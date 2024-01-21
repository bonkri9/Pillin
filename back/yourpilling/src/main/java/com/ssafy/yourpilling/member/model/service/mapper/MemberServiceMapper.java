package com.ssafy.yourpilling.member.model.service.mapper;

import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.service.vo.MemberRegisterVo;
import org.springframework.stereotype.Component;

import static java.time.LocalDateTime.now;

@Component
public class MemberServiceMapper {

    public MemberProfile mapToMember(MemberRegisterVo vo) {
        return MemberProfile
                .builder()
                .username(vo.getEmail())
                .password(vo.getPassword())
                .birth(vo.getBirthday())
                .nickname(vo.getNickname())
                .name(vo.getName())
                .gender(vo.getGender())
                .createdAt(now())
                .updatedAt(now())
                .build();
    }
}
