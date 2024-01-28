package com.jjinka.jjinkaHoldem.service;

import com.jjinka.jjinkaHoldem.dto.AdminLoginDTO;
import com.jjinka.jjinkaHoldem.repository.LoginRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LoginService {
    private final LoginRepository loginRepository;

    public boolean validateAdmin(AdminLoginDTO adminLoginDTO) {
        AdminLoginDTO isAdmin = loginRepository.validateAdmin(adminLoginDTO);

        return isAdmin != null;
    }
}
