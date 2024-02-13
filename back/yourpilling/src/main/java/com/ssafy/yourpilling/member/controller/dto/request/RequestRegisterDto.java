package com.ssafy.yourpilling.member.controller.dto.request;

import com.ssafy.yourpilling.common.Gender;
import lombok.Data;

import java.time.LocalDate;

@Data
public class RequestRegisterDto {

    private String email;
    private String password;
    private String name;
}
