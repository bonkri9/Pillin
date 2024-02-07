package com.ssafy.yourpilling.member.controller.mapper;

import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterEssentialDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdateNameDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdatePasswordDto;
import com.ssafy.yourpilling.member.model.service.vo.in.*;
import org.springframework.stereotype.Component;

@Component
public class MemberControllerMapper {

    public MemberRegisterVo mapToMemberRegisterVo(RequestRegisterDto dto) {
        return MemberRegisterVo
                .builder()
                .email(dto.getEmail())
                .password(dto.getPassword())
                .name(dto.getName())
                .build();
    }


    public MemberInfoVo mapToMemberInfo(Long memberId) {
        return MemberInfoVo
                .builder()
                .memberId(memberId)
                .build();
    }

    public MemberUpdateNameVo mapToMemberUpdateNameVo(Long memberId, RequestUpdateNameDto dto){
        return MemberUpdateNameVo
                .builder()
                .memberId(memberId)
                .name(dto.getName())
                .build();
    }

    public MemberUpdatePasswordVo mapToMemberUpdatePasswordVo(Long memberId, RequestUpdatePasswordDto dto){
        return MemberUpdatePasswordVo
                .builder()
                .memberId(memberId)
                .password(dto.getPassword())
                .build();
    }

    public MemberDeleteVo mapToMemberDeleteVo(Long memberId) {
        return MemberDeleteVo
                .builder()
                .memberId(memberId)
                .build();
    }

    public MemberPasswordReIssueVo mapToMemberPasswordReIssueVo(Long memberId) {
        return MemberPasswordReIssueVo
                .builder()
                .memberId(memberId)
                .build();
    }

    public RegisterEssentialVo mapToMemberRegisterEssentialVo(RequestRegisterEssentialDto dto) {
        return RegisterEssentialVo
                .builder()
                .birthday(dto.getBirthday())
                .gender(dto.getGender())
                .build();
    }
}
