package com.jjinka.jjinkaHoldem.repository;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class GameRepository {
    private final SqlSessionTemplate sqlSessionTemplate;

    public List<GameDTO> findAll() {
        return sqlSessionTemplate.selectList("Game.findAll");
    }
    public int makeGame(GameDTO gameDTO) {
        return sqlSessionTemplate.insert("Game.makeGame", gameDTO);
    }

    public GameDTO findByGameNo(Long gameNo) {
        return sqlSessionTemplate.selectOne("Game.findByGameNo", gameNo);
    }

    public List<GameJoinerDTO> findJoinerList(Long gameNo) {
        return sqlSessionTemplate.selectList("Game.findJoinerList", gameNo);
    }
}
