package com.ssafy.yourpilling.member.controller.mapper;

import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdateDto;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberDeleteVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberInfoVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberRegisterVo;
import com.ssafy.yourpilling.member.model.service.vo.in.MemberUpdateVo;
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


    public MemberInfoVo mapToMemberInfo(Long memberId) {
        return MemberInfoVo
                .builder()
                .memberId(memberId)
                .build();
    }

    public MemberUpdateVo mapToMemberUpdateVo(Long memberId, RequestUpdateDto dto){
        return MemberUpdateVo
                .builder()
                .memberId(memberId)
                .nickname(dto.getNickname())
                .build();
    }

    public MemberDeleteVo mapToMemberDeleteVo(Long memberId) {
        return MemberDeleteVo
                .builder()
                .memberId(memberId)
                .build();
    }
}
