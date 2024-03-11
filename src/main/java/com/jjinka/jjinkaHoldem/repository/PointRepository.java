package com.jjinka.jjinkaHoldem.repository;

import com.jjinka.jjinkaHoldem.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
@RequiredArgsConstructor
public class PointRepository {
    private final SqlSessionTemplate sqlSessionTemplate;

    public Long checkPoint(Map<String, Object> map) {
        return sqlSessionTemplate.selectOne("User.checkPoint", map);
    }
}
