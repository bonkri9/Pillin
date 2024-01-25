package com.ssafy.yourpilling.pill.controller;

import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnPillUpdateDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnPillDetailDto;
import com.ssafy.yourpilling.pill.controller.dto.request.RequestOwnRegisterPillDto;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillInventorListVo;
import com.ssafy.yourpilling.pill.controller.mapper.OwnPillControllerMapper;
import com.ssafy.yourpilling.pill.model.service.OwnPillService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class OwnPillController {

    private final OwnPillControllerMapper mapper;
    private final OwnPillService ownPillService;

    @GetMapping("/inventory")
    ResponseEntity<OutOwnPillDetailVo> detail(@RequestBody RequestOwnPillDetailDto dto) {
        OutOwnPillDetailVo vo = ownPillService.detail(mapper.mapToPillDetailVo(dto));
        return ResponseEntity.ok(vo);
    }

    @PostMapping("/inventory")
    ResponseEntity<Void> register(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                  @RequestBody RequestOwnRegisterPillDto dto) {
        ownPillService.register(mapper.mapToPillRegisterVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }


    @PutMapping("/inventory")
    ResponseEntity<Void> update(@RequestBody RequestOwnPillUpdateDto dto){
        ownPillService.update(mapper.mapToOwnPillUpdateVo(dto));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/inventory/list")
    ResponseEntity<OutOwnPillInventorListVo> list(@AuthenticationPrincipal PrincipalDetails principalDetails){
        OutOwnPillInventorListVo data = ownPillService.inventoryList(mapper.mapToPillInventoryListVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok(data);
    }
}
