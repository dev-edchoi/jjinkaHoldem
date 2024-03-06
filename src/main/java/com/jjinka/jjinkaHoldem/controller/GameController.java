package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.service.UserPointService;
import com.jjinka.jjinkaHoldem.service.UserService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;
import com.jjinka.jjinkaHoldem.service.GameService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.sound.midi.SysexMessage;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/game")
@RequiredArgsConstructor
public class GameController {
    private final GameService gameService;
    private final UserService userService;
    private final UserPointService userPointService;

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
                           @RequestParam(value = "dateBefore", required = false) String dateBefore, @RequestParam(value = "dateAfter", required = false) String dateAfter) {
        if(dateBefore == null || dateBefore.isEmpty()) dateBefore = yesterdayDateString;
        if(dateAfter == null || dateAfter.isEmpty()) dateAfter = currentDateString;

        Map<String, Object> map = new HashMap<>();
        map.put("dateBefore", dateBefore);
        map.put("dateAfter", dateAfter);

        List<GameDTO> gameDTOList = gameService.gameList(page, map);
        PageDTO pageDTO = gameService.pagingParam(page, map);

        pageDTO.setDateBefore(dateBefore);
        pageDTO.setDateAfter(dateAfter);

        System.out.println(pageDTO);
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

        return "gameDetail";
    }

    @PostMapping("/setReward")
    public @ResponseBody GameDTO setReward(@RequestParam("gameNo") Long gameNo, @RequestParam("totalGameFee") Long totalGameFee, @RequestParam(value = "gameReward", required = false, defaultValue = "999") Long gameReward, Model model) {
        Map<String, Object> map = new HashMap<>();

        if(gameReward != 999){
            map.put("gameNo", gameNo);
            map.put("totalGameFee", totalGameFee);
            map.put("gameReward", gameReward);
        } else {
            map.put("gameNo", gameNo);
            map.put("totalGameFee", totalGameFee);
        }
        gameService.setReward(map);

        GameDTO gameDTO = gameService.findByGameNo(gameNo);
        model.addAttribute("gameList", gameDTO);
        return gameDTO;
    }

    @PostMapping("/userGameSet")
    public @ResponseBody List<GameJoinerDTO> userGameSet(@RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo,
                                                         @RequestParam("gameJoinNo") Long gameJoinNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userNo);
        map.put("gameJoinNo", gameJoinNo);

        gameService.userGameSet(map);

        return gameService.findJoinerList(gameNo);
    }

    public void gamerPointDeduction(Long userNo, Long gameFee){
        Map<String, Object> pointDeductionMap = new HashMap<>();
        pointDeductionMap.put("userNo", userNo);
        pointDeductionMap.put("gameFee", gameFee);
        pointDeductionMap.put("reasonForChange", 4);

        int isSuccess2 = gameService.pointDeduction(pointDeductionMap);
        if(isSuccess2 > 0) {
            pointDeductionMap.put("gameFee", gameFee * -1);
            userPointService.insertPointLog(pointDeductionMap);
        }
    }

    @PostMapping("/gamerJoin")
    public @ResponseBody List<GameJoinerDTO> gamerJoin(@ModelAttribute GameJoinerDTO gameJoinerDTO, @RequestParam("userNo") Long userNo,
                                                       @RequestParam("gameNo") Long gameNo, @RequestParam("gameFee") Long gameFee) {
        UserDTO userDTO = userService.findByUserNo(userNo);

        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userDTO.getUserNo());
        map.put("userName", userDTO.getUserName());

        int isSuccess = gameService.gamerJoin(map);
        if(isSuccess > 0){
            gamerPointDeduction(userDTO.getUserNo(), gameFee);
        }

        return gameService.findJoinerList(gameNo);
    }
    @PostMapping("/reGameIn")
    public @ResponseBody List<GameJoinerDTO> reGameIn(@ModelAttribute GameJoinerDTO gameJoinerDTO, @RequestParam("userNo") Long userNo,
                                                      @RequestParam("gameNo") Long gameNo, @RequestParam("gameFee") Long gameFee, @RequestParam("gameJoinNo") Long gameJoinNo) {
        UserDTO userDTO = userService.findByUserNo(userNo);

        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userDTO.getUserNo());
        map.put("userName", userDTO.getUserName());
        map.put("gameJoinNo", gameJoinNo);

        int isSuccess = gameService.reGameIn(map);
        if(isSuccess > 0){
            gamerPointDeduction(userNo, gameFee);
        }

        return gameService.findJoinerList(gameNo);
    }

    @PostMapping("/oneMoreGameCnt")
    public @ResponseBody List<GameJoinerDTO> oneMoreGameCnt(@RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo,
                                                            @RequestParam("gameFee") Long gameFee, @RequestParam("gameJoinNo") Long gameJoinNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userNo);
        map.put("gameJoinNo", gameJoinNo);

        int isSuccess = gameService.oneMoreGameCnt(map);
        if(isSuccess > 0){
            gamerPointDeduction(userNo, gameFee);
        }

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

//    @PostMapping("/gameSet")
//    public void gameSet(@RequestParam("gameNo") Long gameNo, @RequestParam("gameReward") Long gameReward, @RequestParam("userNo") Long userNo) {
//        Map<String, Object> gameSetMap = new HashMap<>();
//        gameSetMap.put("gameNo", gameNo);
//        gameSetMap.put("userNo", userNo);
//
//        Map<String, Object> setGameWinnerMap = new HashMap<>();
//        setGameWinnerMap.put("gameReward", gameReward);
//        setGameWinnerMap.put("userNo", userNo);
//
//        Map<String, Object> userPointMap = new HashMap<>();
//        userPointMap.put("userNo", userNo);
//        userPointMap.put("userPoint", gameReward);
//        userPointMap.put("isGameReward", "1");
//
//        gameService.gameSet(gameSetMap);
//        gameService.allJoinerGameSet(gameNo);
//        gameService.setGameWinner(setGameWinnerMap);
//        userPointService.insertPointLog(userPointMap);
//    }

    @PostMapping("/gameSet")
    public @ResponseBody String gameSet(@RequestParam("values") String values, @RequestParam("gameNo") Long gameNo) throws ParseException {
        JSONParser jsonParser = new JSONParser();
        JSONArray insertParam = (JSONArray) jsonParser.parse(values);

        for(int i=0; i < insertParam.size(); i++){
            JSONObject insertData = (JSONObject) insertParam.get(i);
            Long userNo = Long.parseLong(String.valueOf(insertData.get("userNo")));
            Long gameReward = Long.parseLong(String.valueOf(insertData.get("gameReward")));

            Map<String, Object> setGameWinnerMap = new HashMap<>();
            setGameWinnerMap.put("gameReward", gameReward);
            setGameWinnerMap.put("userNo", userNo);

            gameService.setGameWinner(setGameWinnerMap);

            Map<String, Object> userPointMap = new HashMap<>();
            userPointMap.put("userNo", userNo);
            userPointMap.put("userPoint", gameReward);
            userPointMap.put("reasonForChange", "1");

            userPointService.insertPointLog(userPointMap);
        }
        gameService.allJoinerGameSet(gameNo);

        return gameService.gameSet(gameNo);
    }

    @PostMapping("/chkGaming")
    public @ResponseBody String gameSet(@RequestParam("gameNo") Long gameNo){
        return gameService.chkGaming(gameNo);
    }

    @GetMapping("/gameUpdate")
    public String gameUpdate(@RequestParam("gameNo") Long gameNo, Model model){
        GameDTO gameDTO = gameService.findByGameNo(gameNo);
        model.addAttribute("game", gameDTO);
        return "gameUpdate";
    }

    @PostMapping("/gameUpdate")
    public String gameUpdate(@ModelAttribute GameDTO gameDTO){
        if(gameDTO.getRewardRate() == null){
            gameDTO.setRewardRate(0L);
        }
        boolean result = gameService.gameUpdate(gameDTO);

        if(result){
            return "redirect:/game?gameNo=" + gameDTO.getGameNo();
        } else {
            return "gameList";
        }
    }
}

