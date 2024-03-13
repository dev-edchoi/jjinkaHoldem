package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.repository.UserPointRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class UserPointService {
    private final UserPointRepository  userPointRepository;

    public List<UserPointDTO> userPointRecent(Long userNo) {
        return userPointRepository.userPointRecent(userNo);
    }

    public void insertPointLog(Map<String, Object> map) {
        userPointRepository.insertPointLog(map);
    }

    int pageLimit = 10; // 한 페이지당 보여줄 글 갯수
    int blockLimit = 5; // 하단에 보여줄 페이지 번호 갯수

    public List<UserPointDTO> userPointLog(int page, Long userNo) {
        int pagingStart = (page - 1) * pageLimit;

        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        pagingParams.put("userNo", userNo);

        return userPointRepository.userPointList(pagingParams);
    }

    public PageDTO pointPagingParam(int page, Long userNo) {
        int pointLogCount = userPointRepository.pointLogCount(userNo);                                              // 전체 글 갯수 조회
        int maxPage = (int) (Math.ceil((double) pointLogCount / pageLimit));                           // 전체 페이지 갯수 계산(10/3=3.33333 => 4)
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;      // 시작 페이지 값 계산(1, 4, 7, 10, ~~~~)
        int endPage = startPage + blockLimit - 1;                                                   // 끝 페이지 값 계산(3, 6, 9, 12, ~~~~)

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
