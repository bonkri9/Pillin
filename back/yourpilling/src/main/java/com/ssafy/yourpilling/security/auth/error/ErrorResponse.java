package com.ssafy.yourpilling.security.auth.error;

import lombok.*;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ErrorResponse {

    private Integer stateCode;
    private String errorCode;
    private String message;

    public ErrorResponse(ErrorStatues errorStatues,ErrorCode errorCode) {
        this.stateCode = errorStatues.getHttpStateCode();
        this.errorCode = errorCode.getErrorCode();
        this.message = errorCode.getMessage();
    }
}
