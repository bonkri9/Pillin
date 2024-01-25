package com.ssafy.yourpilling.pill.controller;

import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnPillUpdateDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestPillDetailDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestRegisterPillDto;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutPillInventorListVo;
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

    @GetMapping("/inventory")
    ResponseEntity<OutOwnPillDetailVo> detail(@RequestBody RequestPillDetailDto dto) {
        OutOwnPillDetailVo vo = pillService.detail(mapper.mapToPillDetailVo(dto));
        return ResponseEntity.ok(vo);
    }

    @PostMapping("/inventory")
    ResponseEntity<Void> register(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                  @RequestBody RequestRegisterPillDto dto) {
        pillService.register(mapper.mapToPillRegisterVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }


    @PutMapping("/inventory")
    ResponseEntity<Void> update(@RequestBody RequestOwnPillUpdateDto dto){
        pillService.update(mapper.mapToOwnPillUpdateVo(dto));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/inventory/list")
    ResponseEntity<OutPillInventorListVo> list(@AuthenticationPrincipal PrincipalDetails principalDetails){
        OutPillInventorListVo data = pillService.inventoryList(mapper.mapToPillInventoryListVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok(data);
    }
}
