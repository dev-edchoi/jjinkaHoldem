package com.jjinka.jjinkaHoldem.repository;

import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class UserPointRepository {
    private final SqlSessionTemplate sqlSessionTemplate;

    public List<UserPointDTO> userPointAll(Long userNo) {
        return sqlSessionTemplate.selectList("UserPoint.userPointAll" ,userNo);
    }
}
