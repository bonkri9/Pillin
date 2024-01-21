package com.ssafy.yourpilling.member.controller;

import com.ssafy.yourpilling.member.controller.dto.request.RequestRegisterDto;
import com.ssafy.yourpilling.member.controller.mapper.MemberControllerMapper;
import com.ssafy.yourpilling.member.model.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
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
}
