package com.ssafy.yourpilling.security.config.dto;

import lombok.Data;

@Data
public class RequestLoginDto {
    private String username;
    private String password;
}
