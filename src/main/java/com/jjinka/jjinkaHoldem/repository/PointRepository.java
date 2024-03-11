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
public class PointRepository {
    private final SqlSessionTemplate sqlSessionTemplate;

    public UserDTO checkPoint(Map<String, Object> map) {
        return sqlSessionTemplate.selectOne("User.checkPoint", map);
    }

    public List<UserPointDTO> checkUserPoint(Map<String, Object> map) {
        return sqlSessionTemplate.selectList("UserPoint.userPointList", map);
    }

    public int logCount(Long userNo) {
        return sqlSessionTemplate.selectOne("UserPoint.pointLogCount", userNo);
    }
}
