package com.jjinka.jjinkaHoldem.repository;

import com.jjinka.jjinkaHoldem.dto.AdminLoginDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class LoginRepository {
    private final SqlSessionTemplate sqlSessionTemplate;

    public AdminLoginDTO validateAdmin(AdminLoginDTO adminLoginDTO) {
        return  sqlSessionTemplate.selectOne("Admin.validateAdmin", adminLoginDTO);
    }
}
