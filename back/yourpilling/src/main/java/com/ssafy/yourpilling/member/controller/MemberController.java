package com.ssafy.yourpilling.member.controller;

import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterEssentialDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdateNameDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdatePasswordDto;
import com.ssafy.yourpilling.member.controller.mapper.MemberControllerMapper;
import com.ssafy.yourpilling.member.model.service.MemberService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1")
public class MemberController {

    private final MemberService memberService;
    private final MemberControllerMapper mapper;

    @PostMapping("/register")
    ResponseEntity<Void> register(@RequestBody RequestRegisterDto requestRegisterDto) {
        memberService.register(mapper.mapToMemberRegisterVo(requestRegisterDto));

        return ResponseEntity.ok().build();
    }

    @PutMapping("/register/essential")
    ResponseEntity<Void> register(@RequestBody RequestRegisterEssentialDto dto) {
        memberService.registerEssential(mapper.mapToMemberRegisterEssentialVo(dto));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/member")
    ResponseEntity<OutMemberVo> info(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        return ResponseEntity.ok(memberService.info(mapper.mapToMemberInfo(principalDetails.getMember().getMemberId())));
    }

    @PutMapping("/member/name")
    ResponseEntity<Void> update(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                @RequestBody RequestUpdateNameDto dto){
        memberService.updateName(mapper.mapToMemberUpdateNameVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }

    @PutMapping("/member/password")
    ResponseEntity<Void> update(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                @RequestBody RequestUpdatePasswordDto dto){
        memberService.updatePassword(mapper.mapToMemberUpdatePasswordVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }


    @DeleteMapping("/member")
    ResponseEntity<Void> update(@AuthenticationPrincipal PrincipalDetails principalDetails){
        memberService.delete(mapper.mapToMemberDeleteVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok().build();
    }

    @PutMapping("/member/password-reissue")
    ResponseEntity<Void> passwordReIssue(@AuthenticationPrincipal PrincipalDetails principalDetails){
        memberService.passwordReIssue(mapper.mapToMemberPasswordReIssueVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok().build();
    }
}
