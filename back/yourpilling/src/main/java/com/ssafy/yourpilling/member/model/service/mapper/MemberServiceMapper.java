package com.ssafy.yourpilling.member.model.service.mapper;

import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberRegisterVo;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import static java.time.LocalDateTime.now;

@Component
public class MemberServiceMapper {

    public MemberProfile mapToMember(MemberRegisterVo vo, BCryptPasswordEncoder encoder, Role role) {
        return MemberProfile
                .builder()
                .username(vo.getEmail())
                .password(encoder.encode(vo.getPassword()))
                .name(vo.getName())
                .createdAt(now())
                .updatedAt(now())
                .role(role)
                .build();
    }

    public OutMemberVo mapToOutMemberVo(MemberProfile member){
        return OutMemberVo
                .builder()
                .email(member.getUsername())
                .name(member.getName())
                .nickname(member.getName())
                .birthday(member.getBirth())
                .gender(member.getGender())
                .providerId(member.getProviderId())
                .createAt(member.getCreatedAt())
                .updateAt(member.getUpdatedAt())
                .role(member.getRole())
                .build();
    }
}
