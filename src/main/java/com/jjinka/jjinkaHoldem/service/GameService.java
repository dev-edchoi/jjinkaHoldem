package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.repository.GameRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class GameService {

    private final GameRepository gameRepository;

    public List<GameDTO> findAll() {
        return gameRepository.findAll();
    }
    public int makeGame(GameDTO gameDTO) {
        return gameRepository.makeGame(gameDTO);
    }

    public GameDTO findByGameNo(Long gameNo) {
        return gameRepository.findByGameNo(gameNo);
    }


    public List<GameJoinerDTO> findJoinerList(Long gameNo) {
        return gameRepository.findJoinerList(gameNo);
    }

    public void gamerJoin(Map<String, Object> map) {
        gameRepository.gamerJoin(map);
    }

    public String chkJoiner(Map<String, Object> map) {
        GameJoinerDTO gameJoinerDTO =  gameRepository.chkJoiner(map);

        if(gameJoinerDTO == null){
            return "ok";
        } else {
            return "no";
        }
    }

    public void userGameSet(Map<String, Object> map) {
        gameRepository.userGameSet(map);
    }

    public void oneMoreGameCnt(Map<String, Object> map) {
        gameRepository.oneMoreGameCnt(map);
    }

    public String chkInGame(String tableNo) {
        GameDTO gameDTO = gameRepository.chkInGame(tableNo);

        if(gameDTO == null){
            return "ok";
        } else {
            return "no";
        }
    }

    public boolean gameSet(Long gameNo) {
        int result = gameRepository.gameSet(gameNo);

        return result > 0;
    }
}
