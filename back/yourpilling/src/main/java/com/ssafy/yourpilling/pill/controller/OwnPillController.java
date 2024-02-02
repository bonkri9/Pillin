package com.ssafy.yourpilling.pill.controller;

import com.ssafy.yourpilling.pill.controller.dto.request.*;
import com.ssafy.yourpilling.pill.model.service.vo.out.*;
import com.ssafy.yourpilling.pill.controller.mapper.OwnPillControllerMapper;
import com.ssafy.yourpilling.pill.model.service.OwnPillService;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;


@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/pill")
public class OwnPillController {

    private final OwnPillControllerMapper mapper;
    private final OwnPillService ownPillService;

    @GetMapping("/inventory")
    ResponseEntity<OutOwnPillDetailVo> detail(@RequestParam(name = "ownPillId") Long ownPillId) {
        log.info("[재고 상세 정보] own_id : {}", ownPillId);
        OutOwnPillDetailVo vo = ownPillService.detail(mapper.mapToPillDetailVo(ownPillId));
        return ResponseEntity.ok(vo);
    }

    @PostMapping("/inventory")
    ResponseEntity<Void> register(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                  @RequestBody RequestOwnRegisterPillDto dto) {
        log.info("[요청 : 재고 등록] member_id : {}, pill_id : {}", principalDetails.getMember().getMemberId(), dto.getPillId());
        ownPillService.register(mapper.mapToPillRegisterVo(principalDetails.getMember().getMemberId(), dto));
        return ResponseEntity.ok().build();
    }

    @PutMapping("/inventory")
    ResponseEntity<Void> update(@RequestBody RequestOwnPillUpdateDto dto){
        log.info("[요청 : 재고 수정] own_id : {}", dto.getOwnPillId());
        ownPillService.update(mapper.mapToOwnPillUpdateVo(dto));
        return ResponseEntity.ok().build();
    }

    @PutMapping("/take")
    ResponseEntity<OutOwnPillTakeVo> take(@RequestBody RequestOwnPillTakeDto dto){
        log.info("[요청 : 영양제 복용] own_id : {}", dto.getOwnPillId());
        OutOwnPillTakeVo vo = ownPillService.take(mapper.mapToOwnPillTakeVo(dto));
        return ResponseEntity.ok(vo);
    }

    @DeleteMapping("/inventory")
    ResponseEntity<Void> remove(@RequestBody RequestOwnPillRemoveDto dto){
        log.info("[요청 : 영양제 재고 삭제] own_id : {}", dto.getOwnPillId());
        ownPillService.remove(mapper.mapToOwnPillRemoveVo(dto));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/inventory/list")
    ResponseEntity<OutOwnPillInventorListVo> list(@AuthenticationPrincipal PrincipalDetails principalDetails){
        log.info("[요청 : 영양제 재고 보유 리스트] member_id : {}", principalDetails.getMember().getMemberId());
        OutOwnPillInventorListVo data = ownPillService.inventoryList(mapper.mapToPillInventoryListVo(principalDetails.getMember().getMemberId()));
        return ResponseEntity.ok(data);
    }

    @GetMapping("/history/weekly")
    ResponseEntity<OutWeeklyTakerHistoryVo> weeklyList(@AuthenticationPrincipal PrincipalDetails principalDetails){
        log.info("[요청 : 주간 복용 기록] member_id : {}", principalDetails.getMember().getMemberId());
        OutWeeklyTakerHistoryVo vo = ownPillService.weeklyTakerHistory(mapper.mapToWeeklyTakerHistoryVo(principalDetails.getMember().getMemberId(), LocalDate.now()));
        return ResponseEntity.ok(vo);
    }

    @GetMapping("/history/monthly")
    ResponseEntity<OutMonthlyTakerHistoryVo> monthlyList(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                                         @RequestParam(name = "year") Integer year, @RequestParam(name="month") Integer month){
        log.info("[요청 : 월간 복용 기록] member_id : {}, year : {}, month : {}", principalDetails.getMember().getMemberId(), year, month);
        LocalDate date = LocalDate.of(year, month, 1);
        OutMonthlyTakerHistoryVo vo = ownPillService.monthlyTakerHistory(mapper.mapToMonthlyTakerHistoryVo(principalDetails.getMember().getMemberId(), date));
        return ResponseEntity.ok(vo);
    }

    @PutMapping("/inventory/take-yn")
    ResponseEntity<Void> take(@RequestBody RequestOwnPillTakeYnDto dto){
        log.info("[요청 : 복용, 미복용 전환] own_id : {}", dto.getOwnPillId());
        ownPillService.updateTakeYn(mapper.mapToOwnPillTakeYnVo(dto));
        // OutOwnPillTakeYnVo vo = ownPillService.updateTakeYn(mapper.mapToOwnPillTakeYnVo(dto));
        return ResponseEntity.ok().build();
    }
}
