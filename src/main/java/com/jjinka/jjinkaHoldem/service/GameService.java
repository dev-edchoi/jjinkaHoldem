package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.GameJoinerDTO;
import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.repository.GameRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class GameService {

    private final GameRepository gameRepository;

    /*
    public List<GameDTO> findAll() {
        return gameRepository.findAll();
    }
    */
    int pageLimit = 10; // 한 페이지당 보여줄 글 갯수
    int blockLimit = 5; // 하단에 보여줄 페이지 번호 갯수

    public List<GameDTO> gameList(int page, Map<String, Object> map) {
        int pagingStart = (page - 1) * pageLimit;

        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        pagingParams.put("dateBefore", map.get("dateBefore"));
        pagingParams.put("dateAfter", map.get("dateAfter"));

        return gameRepository.gameList(pagingParams);
    }

    public PageDTO pagingParam(int page, Map<String, Object> map) {
        int boardCount = gameRepository.gameCount(map);
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        int endPage = startPage + blockLimit - 1;

        if (endPage > maxPage) {
            endPage = maxPage;
        }

        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);

        return pageDTO;
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

    public int gamerJoin(Map<String, Object> map) {
        return gameRepository.gamerJoin(map);
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

    public int reGameIn(Map<String, Object> map) {
        return gameRepository.reGameIn(map);
    }

    public int oneMoreGameCnt(Map<String, Object> map) {
        return gameRepository.oneMoreGameCnt(map);
    }

    public String chkInGame(String tableNo) {
        GameDTO gameDTO = gameRepository.chkInGame(tableNo);

        if(gameDTO == null){
            return "ok";
        } else {
            return "no";
        }
    }

    public String gameSet(Long gameNo) {
        int result = gameRepository.gameSet(gameNo);
        String sResult = "";

        if(result > 0) {
            sResult = "success";
        } else {
            sResult = "false";
        }

        return sResult;
    }

    public void setReward(Map<String, Object> map) {
        gameRepository.setReward(map);
    }

    public Long getGameReward(Long gameNo) {
        return gameRepository.getGameReward(gameNo);
    }

    public void setGameWinner(Map<String, Object> map) {
        gameRepository.setGameWinner(map);
    }

    public void allJoinerGameSet(Long gameNo) {
        gameRepository.allJoinerGameSet(gameNo);
    }

    public String chkGaming(Long gameNo) {
        return gameRepository.chkGaming(gameNo);
    }

    public boolean gameUpdate(GameDTO gameDTO) {
        int result = gameRepository.gameUpdate(gameDTO);

        return result > 0;
    }

    public int pointDeduction(Map<String, Object> pointDeductionMap) {
        return gameRepository.pointDeduction(pointDeductionMap);
    }

    public void setPrizeMoney(Map<String, Object> prizeMoneyMap) {
        gameRepository.setPrizeMoney(prizeMoneyMap);
    }

    public Long CntTodayGame() {
        return gameRepository.CntTodayGame();
    }
}
