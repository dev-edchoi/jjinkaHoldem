package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import com.jjinka.jjinkaHoldem.repository.GameRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
