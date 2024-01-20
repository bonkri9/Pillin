package com.ssafy.yourpilling.security.auth.error;

import org.springframework.http.HttpStatus;

import java.util.Arrays;
import java.util.List;

public enum ErrorStatues {
    BAD_REQUEST(HttpStatus.BAD_REQUEST, List.of(ErrorCode.E4001)),
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED, Arrays.asList(ErrorCode.E4011, ErrorCode.E4012, ErrorCode.E4013)),
    FORBIDDEN(HttpStatus.FORBIDDEN, List.of(ErrorCode.E4031)),
    CONFLICT(HttpStatus.CONFLICT, List.of(ErrorCode.E4091)),
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, List.of(ErrorCode.E5001));

    private final HttpStatus httpStatus;
    private final List<ErrorCode> errorCodeList;

    ErrorStatues(HttpStatus httpStatus, List<ErrorCode> errorCodeList) {
        this.httpStatus = httpStatus;
        this.errorCodeList = errorCodeList;
    }

    public static ErrorStatues findByErrorCode(ErrorCode errorCode) {
        ErrorStatues statues = Arrays.stream(ErrorStatues.values())
                .filter(errorStatues -> errorStatues.hasErrorCode(errorCode))
                .findAny().orElse(INTERNAL_SERVER_ERROR);
        return statues;
    }

    private boolean hasErrorCode(ErrorCode errorCode) {
        return errorCodeList.stream().anyMatch(code -> code == errorCode);
    }

    public int getHttpStateCode() {
        return this.httpStatus.value();
    }
}

