package com.ssafy.yourpilling.security.auth.jwt;

import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.ssafy.yourpilling.security.auth.error.AccessTokenExpiredException;
import com.ssafy.yourpilling.security.auth.error.ErrorCode;
import com.ssafy.yourpilling.security.auth.error.ErrorResponse;
import com.ssafy.yourpilling.security.auth.error.ErrorStatues;
import io.jsonwebtoken.MalformedJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Optional;

@RequiredArgsConstructor
public class JwtAuthorizationFilter extends OncePerRequestFilter {

    private final JwtManager jwtManager;


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain chain) throws IOException, ServletException {
        if (request.getRequestURI().equals("/api/v1/login")) {
            chain.doFilter(request, response);
            return;
        }

        try {
            Optional<String> optionalAccessToken = jwtManager.resolveAccessToken(request);
            optionalAccessToken.orElseThrow(() -> new AccessTokenExpiredException("만료된 Access Token 입니다."));
            String accessToken = optionalAccessToken.get();

            boolean accessTokenValid = jwtManager.isTokenValid(accessToken);

            if (accessTokenValid) {
                Authentication authentication = jwtManager.getAuthentication(accessToken);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }

        } catch (AccessTokenExpiredException e) {
            ErrorCode e4012 = ErrorCode.E4012;
            request.setAttribute("exception", new ErrorResponse(ErrorStatues.findByErrorCode(e4012), e4012));
        } catch (MalformedJwtException e) {
            ErrorCode e4000 = ErrorCode.E4000;
            request.setAttribute("exception", new ErrorResponse(ErrorStatues.findByErrorCode(e4000), e4000));
        } catch (JWTDecodeException e) {
            ErrorCode e4000 = ErrorCode.E4000;
            request.setAttribute("exception", new ErrorResponse(ErrorStatues.findByErrorCode(e4000), e4000));
        } catch (IllegalArgumentException e) {
            ErrorCode e4000 = ErrorCode.E4000;
            request.setAttribute("exception", new ErrorResponse(ErrorStatues.findByErrorCode(e4000), e4000));
        } catch (SignatureVerificationException e) {
            ErrorCode e4012 = ErrorCode.E4012;
            request.setAttribute("exception", new ErrorResponse(ErrorStatues.findByErrorCode(e4012), e4012));
        } catch (Exception e) {
            request.setAttribute("exception", HttpStatus.UNAUTHORIZED);
        }

        chain.doFilter(request, response);

    }
}


