package com.jjinka.jjinkaHoldem.repository;

import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class UserPointRepository {
    private final SqlSessionTemplate sqlSessionTemplate;

    public List<UserPointDTO> userPointRecent(Long userNo) {
        return sqlSessionTemplate.selectList("UserPoint.userPointRecent" ,userNo);
    }

    public void insertPointLog(Map<String, Object> map) {
        sqlSessionTemplate.insert("UserPoint.insertPointLog" ,map);
    }

    public int pointLogCount(Long userNo) {
        return sqlSessionTemplate.selectOne("UserPoint.pointLogCount", userNo);
    }

    public List<UserPointDTO> userPointList(Map<String, Object> pagingParams) {
        return sqlSessionTemplate.selectList("UserPoint.userPointList", pagingParams);
    }


}
