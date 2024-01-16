package com.jjinka.jjinkaHoldem.repository;

import com.jjinka.jjinkaHoldem.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class UserRepository {

    private final SqlSessionTemplate sqlSessionTemplate;
    public int save(UserDTO userDTO) {
        return sqlSessionTemplate.insert("User.save", userDTO);
    }
    public UserDTO login(UserDTO userDTO) {
        return  sqlSessionTemplate.selectOne("User.login", userDTO);
    }
    public List<UserDTO> findAll() {
        return sqlSessionTemplate.selectList("User.findAll");
    }
    public UserDTO findByUserNo(Long userNo) {
        return sqlSessionTemplate.selectOne("User.findByUserNo", userNo);
    }

    public List<UserDTO> findByUserName(String userName) {
        return sqlSessionTemplate.selectList("User.findByUserName", userName);
    }

    public void delete(Long userNo) {
        sqlSessionTemplate.delete("User.delete",userNo);
    }

    public int update(UserDTO userDTO) {
        return sqlSessionTemplate.update("User.update", userDTO);
    }

    public UserDTO findByMemberPhoneNo(String phoneNumber) {
        return sqlSessionTemplate.selectOne("User.findByMemberPhoneNo", phoneNumber);
    }

    public void updatePoint(Map<String, Object> map) {
        sqlSessionTemplate.update("User.updatePoint", map);
    }


}