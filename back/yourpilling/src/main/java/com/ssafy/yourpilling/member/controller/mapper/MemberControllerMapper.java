package com.ssafy.yourpilling.member.controller.mapper;

import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterDto;
import com.ssafy.yourpilling.member.model.service.vo.MemberRegisterVo;
import org.springframework.stereotype.Component;

@Component
public class MemberControllerMapper {

    public MemberRegisterVo mapToMemberRegisterVo(RequestRegisterDto dto) {
        return MemberRegisterVo
                .builder()
                .email(dto.getEmail())
                .password(dto.getPassword())
                .birthday(dto.getBirthday())
                .nickname(dto.getNickname())
                .name(dto.getName())
                .gender(dto.getGender())
                .build();
    }
}
