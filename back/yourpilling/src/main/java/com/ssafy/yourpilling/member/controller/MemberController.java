package com.ssafy.yourpilling.member.controller;

import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterDto;
import com.ssafy.yourpilling.member.controller.dto.request.RequestUpdateDto;
import com.ssafy.yourpilling.member.controller.mapper.MemberControllerMapper;
import com.ssafy.yourpilling.member.model.service.MemberService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.parameters.P;
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

    @GetMapping("/member")
    ResponseEntity<OutMemberVo> info(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        log.info("[요청 : 사용자 정보] member_id : {}", principalDetails.getMember().getMemberId());
        return ResponseEntity.ok(memberService.info(mapper.mapToMemberInfo(principalDetails.getMember().getMemberId())));
    }

    @PutMapping("/member")
    ResponseEntity<Void> update(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                @RequestBody RequestUpdateDto dto){
        log.info("[요청 : 회원 정보 수정] member_id : {}", principalDetails.getMember().getMemberId());
        memberService.update(mapper.mapToMemberUpdateVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/member")
    ResponseEntity<Void> delete(@AuthenticationPrincipal PrincipalDetails principalDetails){
        log.info("[요청 : 회원 탈퇴] member_id : {}", principalDetails.getMember().getMemberId());
        memberService.delete(mapper.mapToMemberDeleteVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok().build();
    }

    @PutMapping("/member/password-reissue")
    ResponseEntity<Void> passwordReIssue(@AuthenticationPrincipal PrincipalDetails principalDetails){
        log.info("[요청 : 비밀번호 초기화] member_id : {}", principalDetails.getMember().getMemberId());
        memberService.passwordReIssue(mapper.mapToMemberPasswordReIssueVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok().build();
    }
}
