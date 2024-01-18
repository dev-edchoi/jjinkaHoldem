package com.jjinka.jjinkaHoldem.repository;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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

    public int gamerJoin(Map<String, Object> map) {
        return sqlSessionTemplate.insert("Game.gamerJoin", map);
    }

    public GameJoinerDTO chkJoiner(Map<String, Object> map) {
        return sqlSessionTemplate.selectOne("Game.chkJoiner", map);
    }

    public void userGameSet(Map<String, Object> map) {
        sqlSessionTemplate.update("Game.userGameSet", map);
    }

    public void oneMoreGameCnt(Map<String, Object> map) {
        sqlSessionTemplate.update("Game.oneMoreGameCnt", map);
    }
}
