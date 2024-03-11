package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.repository.PointRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PointService {
    private final PointRepository pointRepository;

    public UserDTO checkPoint(Map<String, Object> map) {
        return pointRepository.checkPoint(map);
    }

    int pageLimit = 7; // 한 페이지당 보여줄 글 갯수
    int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수

    public List<UserPointDTO> checkUserPoint(int page, Long userNo) {

        int pagingStart = (page - 1) * pageLimit;

        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        pagingParams.put("userNo", userNo);

        return pointRepository.checkUserPoint(pagingParams);
    }

    public PageDTO pagingParam(int page, Long userNo) {
        int boardCount = pointRepository.logCount(userNo);
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
}
