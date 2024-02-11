package com.ssafy.yourpilling.pill.model.service.mapper;

import com.ssafy.yourpilling.pill.model.dao.entity.BuyRecord;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.service.mapper.value.OwnPillRegisterValue;
import com.ssafy.yourpilling.pill.model.service.vo.in.BuyRecordVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillDetailVo.OutOwnPillPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillInventorListVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillInventorListVo.ResponsePillInventorListData;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillInventorListVo.ResponsePillInventoryItem;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Component
public class OwnPillServiceMapper {

    public OutOwnPillDetailVo mapToOutOwnPillDetailVo(OwnPill ownPill, String warningMessage, List<String> takeWeekdays){
        return OutOwnPillDetailVo
                .builder()
                .ownPillId(ownPill.getOwnPillId())
                .remains(ownPill.getRemains())
                .totalCount(ownPill.getTotalCount())
                .takeWeekdays(takeWeekdays)
                .takeCount(ownPill.getTakeCount())
                .takeOnceAmount(ownPill.getTakeOnceAmount())
                .isAlarm(ownPill.getIsAlarm())
                .takeYn(ownPill.getTakeYN())
                .startAt(ownPill.getStartAt())
                .warningMessage(warningMessage)
                .pill(mapToOutOwnPillPillDetailVo(ownPill.getPill()))
                .build();
    }

    private static OutOwnPillPillDetailVo mapToOutOwnPillPillDetailVo(Pill pill) {
        return OutOwnPillPillDetailVo
                .builder()
                .pillId(pill.getPillId())
                .name(pill.getName())
                .manufacturer(pill.getManufacturer())
                .expirationAt(pill.getExpirationAt())
                .usageInstructions(pill.getUsageInstructions())
                .primaryFunctionality(pill.getPrimaryFunctionality())
                .precautions(pill.getPrecautions())
                .storageInstructions(pill.getStorageInstructions())
                .standardSpecification(pill.getStandardSpecification())
                .productForm(pill.getProductForm().getKorean())
                .imageUrl(pill.getImageUrl())
                .build();
    }

    public OwnPill mapToOwnPill(OwnPillRegisterValue value) {
        return OwnPill
                .builder()
                .remains(value.getAdjustRemain())
                .takeCount(value.getTakeCount())
                .totalCount(value.getTotalCount())
                .takeWeekdays(value.getTakeWeekDaysValue())
                .takeOnceAmount(value.getTakeOnceAmount())
                .isAlarm(value.isAlarm())
                .takeYN(value.isAdjustIsTaken())
                .createdAt(value.getCreateAt())
                .member(value.getMember())
                .pill(value.getPill())
                .build();
    }

    public OutOwnPillInventorListVo mapToResponsePillInventorListVo(ResponsePillInventorListData takeTrue,
                                                                    ResponsePillInventorListData takeFalse) {
        return OutOwnPillInventorListVo
                .builder()
                .takeTrue(takeTrue)
                .takeFalse(takeFalse)
                .build();
    }

    public ResponsePillInventorListData mapToResponsePillInventorListData(
            List<OwnPill> ownPills,
            List<String> imageUrls,
            List<LocalDate> ats) {
        List<ResponsePillInventoryItem> items = new ArrayList<>();
        for (int i = 0; i < ownPills.size(); i++) {
            items.add(mapToResponsePillInventoryItem(ownPills.get(i), imageUrls.get(i), ats.get(i)));
        }
        return ResponsePillInventorListData
                .builder()
                .data(items)
                .build();
    }

    private ResponsePillInventoryItem mapToResponsePillInventoryItem(OwnPill ownPill, String imageUrl, LocalDate at) {
        return ResponsePillInventoryItem
                .builder()
                .ownPillId(ownPill.getOwnPillId())
                .pillName(ownPill.getPill().getName())
                .imageUrl(imageUrl)
                .totalCount(ownPill.getTotalCount())
                .remains(ownPill.getRemains())
                .predicateRunOutAt(at)
                .warningMessage(ownPill.runOutMessage())
                .build();
    }

    public BuyRecord mapToBuyRecord(BuyRecordVo vo) {
        return BuyRecord
                .builder()
                .memberId(vo.getMemberId())
                .pillId(vo.getPillId())
                .build();
    }
}
