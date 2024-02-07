package com.ssafy.yourpilling.member.controller;

import com.ssafy.yourpilling.member.controller.dto.ReIssuePasswordDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterEssentialDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdateNameDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdatePasswordDto;
import com.ssafy.yourpilling.member.controller.mapper.MemberControllerMapper;
import com.ssafy.yourpilling.member.model.service.MemberService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/v1")
public class MemberController {

    private final MemberService memberService;
    private final MemberControllerMapper mapper;

    @PostMapping("/register")
    ResponseEntity<Void> register(@RequestBody RequestRegisterDto dto) {
        log.info("[요청 : 회원가입] email : {}, password : {}", dto.getEmail(), dto.getPassword());
        memberService.register(mapper.mapToMemberRegisterVo(dto));

        return ResponseEntity.ok().build();
    }

    @PutMapping("/register/essential")
    ResponseEntity<Void> register(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                  @RequestBody RequestRegisterEssentialDto dto) {
        log.info("[요청 : 최초 로그인. 회원 생년월일 및 성별 입력] member_id : {}", principalDetails.getMember().getMemberId());
        memberService.registerEssential(mapper.mapToMemberRegisterEssentialVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/member")
    ResponseEntity<OutMemberVo> info(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        log.info("[요청 : 사용자 정보] member_id : {}", principalDetails.getMember().getMemberId());
        return ResponseEntity.ok(memberService.info(mapper.mapToMemberInfo(principalDetails.getMember().getMemberId())));
    }

    @PutMapping("/member/name")
    ResponseEntity<Void> update(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                @RequestBody RequestUpdateNameDto dto){
        log.info("[요청 : 회원 정보 수정] member_id : {}", principalDetails.getMember().getMemberId());
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
    ResponseEntity<Void> delete(@AuthenticationPrincipal PrincipalDetails principalDetails){
        log.info("[요청 : 회원 탈퇴] member_id : {}", principalDetails.getMember().getMemberId());
        memberService.delete(mapper.mapToMemberDeleteVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok().build();
    }

    @PutMapping("/password-reissue")
    ResponseEntity<Void> passwordReIssue(@RequestBody ReIssuePasswordDto dto){
        log.info("[요청 : 비밀번호 초기화] username : {}", dto.getEmail());
        memberService.passwordReIssue(mapper.mapToMemberPasswordReIssueVo(dto.getEmail()));
        return ResponseEntity.ok().build();
    }
}
