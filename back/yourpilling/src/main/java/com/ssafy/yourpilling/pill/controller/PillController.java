package com.ssafy.yourpilling.pill.controller;

import com.ssafy.yourpilling.pill.controller.dto.request.RequestRegisterPillDto;
import com.ssafy.yourpilling.pill.model.service.vo.response.ResponsePillInventorListVo;
import com.ssafy.yourpilling.pill.controller.mapper.PillControllerMapper;
import com.ssafy.yourpilling.pill.model.service.PillService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class PillController {

    private final PillControllerMapper mapper;
    private final PillService pillService;

    @PostMapping("/inventory")
    ResponseEntity<Void> register(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                  @RequestBody RequestRegisterPillDto dto) {
        pillService.register(mapper.mapToPillRegisterVo(principalDetails.getMember().getMemberId(), dto));

        return ResponseEntity.ok().build();
    }


    @GetMapping("/inventory/list")
    ResponseEntity<ResponsePillInventorListVo> list(@AuthenticationPrincipal PrincipalDetails principalDetails){
        pillService.inventoryList(mapper.mapToPillInventoryListVo(principalDetails.getMember().getMemberId()));
        return null;
    }
}
