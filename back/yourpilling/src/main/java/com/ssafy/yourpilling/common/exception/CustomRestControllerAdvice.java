package com.ssafy.yourpilling.common.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import static com.ssafy.yourpilling.common.exception.ErrorCode.E5001;
import static com.ssafy.yourpilling.common.exception.ErrorStatues.INTERNAL_SERVER_ERROR;

@RestControllerAdvice
public class CustomRestControllerAdvice {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handlerException(Exception e){
        ErrorResponse errorResponse = new ErrorResponse(INTERNAL_SERVER_ERROR, E5001);
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
