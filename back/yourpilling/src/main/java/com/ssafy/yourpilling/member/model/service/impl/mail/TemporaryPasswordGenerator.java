package com.ssafy.yourpilling.member.model.service.impl.mail;

import org.springframework.stereotype.Component;

import java.util.Random;

@Component
public class TemporaryPasswordGenerator {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int PASSWORD_LENGTH = 8;

    public String generatePassword() {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < PASSWORD_LENGTH; i++) {
            int index = random.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }
}