package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.service.UserService;
import org.springframework.ui.Model;
import com.jjinka.jjinkaHoldem.service.GameService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/game")
@RequiredArgsConstructor
public class GameController {
    private final GameService gameService;
    private final UserService userService;
    @GetMapping("/gameList")
    public String gameList(Model model) {
        List<GameDTO> gameDTOList = gameService.findAll();
        model.addAttribute("gameList", gameDTOList);

        return "gameList";
    }
    @GetMapping("/makeGame")
    public String makeGame(){
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
    public String findByGameNo(@RequestParam("gameNo") Long gameNo, Model model){
        GameDTO gameDTO = gameService.findByGameNo(gameNo);
        List<GameJoinerDTO> gameJoinerDTOS = gameService.findJoinerList(gameNo);

        model.addAttribute("gameList", gameDTO);
        model.addAttribute("gameJoiner", gameJoinerDTOS);

        return "gameDetail";
    }
    @PostMapping("/gamerJoin")
    public  @ResponseBody List<GameJoinerDTO> gamerJoin(@ModelAttribute GameJoinerDTO gameJoinerDTO, @RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo){
        UserDTO userDTO =userService.findByUserNo(userNo);

        Map<String,Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userDTO.getUserNo());
        map.put("userName", userDTO.getUserName());

        gameService.gamerJoin(map);

        return gameService.findJoinerList(gameNo);
    }
    @PostMapping("/userGameSet")
    public  @ResponseBody List<GameJoinerDTO> userGameSet(@RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo){
        Map<String,Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userNo);

        gameService.userGameSet(map);

        return gameService.findJoinerList(gameNo);
    }
    @PostMapping("/oneMoreGameCnt")
    public  @ResponseBody List<GameJoinerDTO> oneMoreGameCnt(@RequestParam("userNo") Long userNo, @RequestParam("gameNo") Long gameNo){
        Map<String,Object> map = new HashMap<>();
        map.put("gameNo", gameNo);
        map.put("userNo", userNo);

        gameService.oneMoreGameCnt(map);

        return gameService.findJoinerList(gameNo);
    }
    @PostMapping("/chkJoiner")
    public @ResponseBody String chkJoiner(@RequestParam("userNo") Long userNo,@RequestParam("gameNo") Long gameNo){
        Map<String,Object> map = new HashMap<>();
        map.put("userNo", userNo);
        map.put("gameNo", gameNo);

        return gameService.chkJoiner(map);
    }
    @PostMapping("/chkInGame")
    public @ResponseBody String chkInGame(@RequestParam("tableNo") String tableNo){
        return gameService.chkInGame(tableNo);
    }

    @PostMapping("/gameSet")
    public  String gameSet(@RequestParam("gameNo") Long gameNo){
        boolean saveResult = gameService.gameSet(gameNo);
        System.out.println("saveResult : " + saveResult);
        if (saveResult) {
            return "redirect:/game/gameList";
        } else {
            return "/makeGame";
        }
    }
}
