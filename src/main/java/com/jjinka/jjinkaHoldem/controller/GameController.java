package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import org.springframework.ui.Model;
import com.jjinka.jjinkaHoldem.service.GameService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/game")
@RequiredArgsConstructor
public class GameController {
    private final GameService gameService;
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
            return "gameList";
        } else {
            return "userRegister";
        }
    }

    @GetMapping
    public String findByGameNo(@RequestParam("gameNo") Long gameNo, Model model){
        GameDTO gameDTO = gameService.findByGameNo(gameNo);
        model.addAttribute("gameList", gameDTO);

        return "gameDetail";
    }
}
