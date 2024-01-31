package com.ssafy.yourpilling.common.exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    E4000("E4000", "잘못된 요청입니다."),
    E4001("E4001", "잘못된 접근입니다."),
    E4011("E4011", "아이디 또는 비밀번호가 틀렸습니다."),
    E4012("E4012", "Access Token 값 오류"),
    E4013("E4013", "Refresh Token 값 오류"),
    E4031("E4031", "권한이 없습니다."),
    E4091("E4091", "중복된 아이디 입니다."),
    E5001("5001", "서버에러");

    private final String errorCode;
    private final String message;

    ErrorCode(String errorCode, String message) {
        this.errorCode = errorCode;
        this.message = message;
    }
}
