package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

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

    public List<UserDTO> findByUserName(String userName) {
        return userRepository.findByUserName(userName);
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
    public int updatePoint(Map<String, Object> map) {
        return userRepository.updatePoint(map);
    }
    int pageLimit = 10; // 한 페이지당 보여줄 글 갯수
    int blockLimit = 5; // 하단에 보여줄 페이지 번호 갯수
    public List<UserDTO> userList(int page) {
        int pagingStart = (page - 1) * pageLimit;

        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);

        return userRepository.userList(pagingParams);
    }

    public PageDTO pagingParam(int page) {
        int boardCount = userRepository.userCount();                                              // 전체 글 갯수 조회
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));                           // 전체 페이지 갯수 계산(10/3=3.33333 => 4)
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
    public List<UserDTO> userPopUp(Long gameNo) {
        return userRepository.userPopUp(gameNo);
    }
}
