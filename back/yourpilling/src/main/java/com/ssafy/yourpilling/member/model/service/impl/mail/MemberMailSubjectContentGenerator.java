package com.ssafy.yourpilling.member.model.service.impl.mail;

import org.springframework.stereotype.Component;

@Component
public class MemberMailSubjectContentGenerator {

    private static final String SUBJECT = "pillin";

    private final String MAIL_FORMAT = "임시 비밀번호 : %s <br/>";

    public String generateSubject(){
        return this.SUBJECT;
    }

    public String generateContent(String rawPassword){
        return String.format(MAIL_FORMAT, rawPassword);
    }
}