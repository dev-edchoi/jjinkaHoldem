package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.repository.PointRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class PointService {
    private final PointRepository pointRepository;

    public Long checkPoint(Map<String, Object> map) {
        return pointRepository.checkPoint(map);
    }
}
