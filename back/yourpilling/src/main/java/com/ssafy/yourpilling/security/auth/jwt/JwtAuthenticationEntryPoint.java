package com.ssafy.yourpilling.security.auth.jwt;

import com.fasterxml.jackson.databind.ObjectMapper;

import com.ssafy.yourpilling.security.auth.error.ErrorResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import java.io.IOException;

// 401
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException {
        Object exception = request.getAttribute("exception");
        setResponse(response, (ErrorResponse) exception);
    }

    private void setResponse(HttpServletResponse response, ErrorResponse errorResponse) throws IOException {
        String responseString = objectMapper.writeValueAsString(errorResponse);
        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(errorResponse.getStateCode());
        response.getWriter().println(responseString);
    }

}
