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

    public List<GameDTO> gameList(Map<String, Object> pagingParams) {
        return sqlSessionTemplate.selectList("Game.gameList", pagingParams);
    }
    public int gameCount(Map<String, Object> map) {
        return sqlSessionTemplate.selectOne("Game.gameCount", map);
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

    public void reGameIn(Map<String, Object> map) {
        sqlSessionTemplate.update("Game.reGameIn", map);
    }

    public void oneMoreGameCnt(Map<String, Object> map) {
        sqlSessionTemplate.update("Game.oneMoreGameCnt", map);
    }

    public GameDTO chkInGame(String tableNo) {
        return sqlSessionTemplate.selectOne("Game.chkInGame", tableNo);
    }

    public int gameSet(Map<String, Object> map) {
        return sqlSessionTemplate.update("Game.gameSet", map);
    }

    public void setReward(Map<String, Object> map) {
        sqlSessionTemplate.update("Game.setReward", map);
    }

    public Long getGameReward(Long gameNo) {
        return sqlSessionTemplate.selectOne("Game.getGameReward", gameNo);
    }

    public void setGameWinner(Map<String, Object> map) {
        sqlSessionTemplate.update("Game.setGameWinner", map);
    }

    public void allJoinerGameSet(Long gameNo) {
        sqlSessionTemplate.update("Game.allJoinerGameSet",gameNo);
    }
}
