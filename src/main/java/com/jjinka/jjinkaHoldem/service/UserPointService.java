package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.repository.UserPointRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserPointService {
    private final UserPointRepository  userPointRepository;

    public List<UserPointDTO> userPointAll(Long userNo) {
        return userPointRepository.userPointAll(userNo);
    }
}
