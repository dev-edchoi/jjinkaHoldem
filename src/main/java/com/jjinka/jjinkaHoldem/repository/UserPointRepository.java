package com.jjinka.jjinkaHoldem.repository;

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

    public List<UserPointDTO> userPointAll(Long userNo) {
        return sqlSessionTemplate.selectList("UserPoint.userPointAll" ,userNo);
    }

    public void insertPointLog(Map<String, Object> map) {
        sqlSessionTemplate.insert("UserPoint.insertPointLog" ,map);
    }
}
