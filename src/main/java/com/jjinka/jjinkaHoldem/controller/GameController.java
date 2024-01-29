package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.service.UserService;
import org.springframework.ui.Model;
import com.jjinka.jjinkaHoldem.service.GameService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/game")
@RequiredArgsConstructor
public class GameController {
    private final GameService gameService;
    private final UserService userService;

    /*
    @GetMapping("/gameList")
    public String gameList(Model model) {
        List<GameDTO> gameDTOList = gameService.findAll();
        model.addAttribute("gameList", gameDTOList);

        return "gameList";
    }

    */
    // 현재 날짜 구하기
    LocalDate currentDate = LocalDate.now();
    // 하루 전날 날짜 구하기
    LocalDate yesterdayDate = currentDate.minusDays(1);
    // 날짜 포맷 지정
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    // 현재 날짜와 하루 전날 날짜를 지정된 형식으로 출력
    String currentDateString = currentDate.format(formatter);
    String yesterdayDateString = yesterdayDate.format(formatter);

    @GetMapping("/gameList")
    public String gameList(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           @RequestParam(value = "dateBefore" ,required = false) String dateBefore, @RequestParam(value = "dateAfter", required = false) String dateAfter) {
        System.out.println(dateBefore + " : " + dateAfter);
        System.out.println(currentDateString + " : " + yesterdayDateString);

        if(dateBefore == null) dateBefore = yesterdayDateString;
        if(dateAfter == null) dateAfter = currentDateString;

        Map<String, Object> map = new HashMap<>();
        map.put("dateBefore", dateBefore);
        map.put("dateAfter", dateAfter);

        List<GameDTO> gameDTOList = gameService.gameList(page, map);
        PageDTO pageDTO = gameService.pagingParam(page);

        model.addAttribute("gameList", gameDTOList);
        model.addAttribute("paging", pageDTO);

        return "gameList";
    }

    @GetMapping("/makeGame")
    public String makeGame() {
        return "makeGame";
    }

    @PostMapping("/makeGame")
    public String makeGame(@ModelAttribute GameDTO gameDTO) {
        int saveResult = gameService.makeGame(gameDTO);

        if (saveResult > 0) {
            return "redirect:/game/gameList";
        } else {
            return "/makeGame";
        }
    }

    @GetMapping
    public String findByGameNo(@RequestParam("gameNo") Long gameNo, @RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model) {
        GameDTO gameDTO = gameService.findByGameNo(gameNo);
        List<GameJoinerDTO> gameJoinerDTOS = gameService.findJoinerList(gameNo);

        model.addAttribute("gameList", gameDTO);
        model.addAttribute("gameJoiner", gameJoinerDTOS);
        model.addAttribute("page", page);

        System.out.println(gameJoinerDTOS);
        return "gameDetail";
    }

    @PostMapping("/setReward")
    public @ResponseBody GameDTO setReward(@RequestParam("gameNo") Long gameNo, @RequestParam("totalGameFee") Long totalGameFee, @RequestParam("gameReward") Long gameReward, Model model) {
        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("totalGameFee", totalGameFee);
        map.put("gameReward", gameReward);

        gameService.setReward(map);

        GameDTO gameDTO = gameService.findByGameNo(gameNo);
        model.addAttribute("gameList", gameDTO);
        return gameDTO;
    }

    @PostMapping("/gamerJoin")
    public @ResponseBody List<GameJoinerDTO> gamerJoin(@ModelAttribute GameJoinerDTO gameJoinerDTO, @RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo) {
        UserDTO userDTO = userService.findByUserNo(userNo);

        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userDTO.getUserNo());
        map.put("userName", userDTO.getUserName());

        gameService.gamerJoin(map);

        return gameService.findJoinerList(gameNo);
    }

    @PostMapping("/userGameSet")
    public @ResponseBody List<GameJoinerDTO> userGameSet(@RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userNo);

        gameService.userGameSet(map);

        return gameService.findJoinerList(gameNo);
    }

    @PostMapping("/reGameIn")
    public @ResponseBody List<GameJoinerDTO> reGameIn(@ModelAttribute GameJoinerDTO gameJoinerDTO, @RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo) {
        UserDTO userDTO = userService.findByUserNo(userNo);

        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userDTO.getUserNo());
        map.put("userName", userDTO.getUserName());

        gameService.reGameIn(map);

        return gameService.findJoinerList(gameNo);
    }

    @PostMapping("/oneMoreGameCnt")
    public @ResponseBody List<GameJoinerDTO> oneMoreGameCnt(@RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userNo);

        gameService.oneMoreGameCnt(map);

        return gameService.findJoinerList(gameNo);
    }

    @PostMapping("/chkJoiner")
    public @ResponseBody String chkJoiner(@RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("userNo", userNo);
        map.put("gameNo", gameNo);

        return gameService.chkJoiner(map);
    }

    @PostMapping("/chkInGame")
    public @ResponseBody String chkInGame(@RequestParam("tableNo") String tableNo) {
        return gameService.chkInGame(tableNo);
    }

    @PostMapping("/gameSet")
    public String gameSet(@RequestParam("gameNo") Long gameNo) {
        boolean saveResult = gameService.gameSet(gameNo);

        if (saveResult) {
            return "redirect:/game/gameList";
        } else {
            return "/makeGame";
        }
    }
}
