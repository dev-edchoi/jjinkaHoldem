package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    public int userRegister(UserDTO userDTO) {
        return userRepository.save(userDTO);
    }
    public boolean login(UserDTO userDTO) {
        UserDTO loginMember = userRepository.login(userDTO);

        return loginMember != null;
    }
    public List<UserDTO> findAll() {
        return userRepository.findAll();
    }

    public UserDTO findByUserNo(Long userNo) {
        return userRepository.findByUserNo(userNo);
    }

    public void delete(Long userNo) {
        userRepository.delete(userNo);
    }

    public boolean update(UserDTO userDTO) {
        int result = userRepository.update(userDTO);

        return result > 0;
    }

    public String phoneNoCheck(String phoneNumber) {
        UserDTO userDTO =  userRepository.findByMemberPhoneNo(phoneNumber);

        if(userDTO == null){
            return "ok";
        } else {
            return "no";
        }
    }

    public void updatePoint(Map<String, Object> map) {
        userRepository.updatePoint(map);
    }
}
