package com.ssafy.yourpilling.pill.controller;

import com.ssafy.yourpilling.pill.controller.dto.request.*;
import com.ssafy.yourpilling.pill.model.service.vo.out.*;
import com.ssafy.yourpilling.pill.controller.mapper.OwnPillControllerMapper;
import com.ssafy.yourpilling.pill.model.service.OwnPillService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;


@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class OwnPillController {

    private final OwnPillControllerMapper mapper;
    private final OwnPillService ownPillService;

    @GetMapping("/inventory")
    ResponseEntity<OutOwnPillDetailVo> detail(@RequestParam(name = "ownPillId") Long ownPillId) {
        OutOwnPillDetailVo vo = ownPillService.detail(mapper.mapToPillDetailVo(ownPillId));
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

    @PutMapping("/take")
    ResponseEntity<OutOwnPillTakeVo> take(@RequestBody RequestOwnPillTakeDto dto){
        OutOwnPillTakeVo vo = ownPillService.take(mapper.mapToOwnPillTakeVo(dto));
        return ResponseEntity.ok(vo);
    }

    @DeleteMapping("/inventory")
    ResponseEntity<Void> remove(@RequestBody RequestOwnPillRemoveDto dto){
        ownPillService.remove(mapper.mapToOwnPillRemoveVo(dto));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/inventory/list")
    ResponseEntity<OutOwnPillInventorListVo> list(@AuthenticationPrincipal PrincipalDetails principalDetails){
        OutOwnPillInventorListVo data = ownPillService.inventoryList(mapper.mapToPillInventoryListVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok(data);
    }

    @GetMapping("/history/weekly")
    ResponseEntity<OutWeeklyTakerHistoryVo> weeklyList(@AuthenticationPrincipal PrincipalDetails principalDetails){
        OutWeeklyTakerHistoryVo vo = ownPillService.weeklyTakerHistory(mapper.mapToWeeklyTakerHistoryVo(principalDetails.getMember().getMemberId(), LocalDate.now()));
        return ResponseEntity.ok(vo);
    }

    @GetMapping("/history/monthly")
    ResponseEntity<OutMonthlyTakerHistoryVo> monthlyList(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                                         @RequestParam(name = "year") Integer year, @RequestParam(name="month") Integer month){
        LocalDate date = LocalDate.of(year, month, 1);
        OutMonthlyTakerHistoryVo vo = ownPillService.monthlyTakerHistory(mapper.mapToMonthlyTakerHistoryVo(principalDetails.getMember().getMemberId(), date));
        return ResponseEntity.ok(vo);
    }

    @PutMapping("/inventory/take-yn")
    ResponseEntity<Void> take(@RequestBody RequestOwnPillTakeYnDto dto){
        ownPillService.updateTakeYn(mapper.mapToOwnPillTakeYnVo(dto));
        // OutOwnPillTakeYnVo vo = ownPillService.updateTakeYn(mapper.mapToOwnPillTakeYnVo(dto));
        return ResponseEntity.ok().build();
    }


}
