package com.ssafy.yourpilling.pill.model.service.mapper;

import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.service.mapper.value.OwnPillRegisterValue;
import com.ssafy.yourpilling.pill.model.service.vo.response.ResponsePillInventorListVo;
import com.ssafy.yourpilling.pill.model.service.vo.response.ResponsePillInventorListVo.ResponsePillInventorListData;
import com.ssafy.yourpilling.pill.model.service.vo.response.ResponsePillInventorListVo.ResponsePillInventoryItem;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Component
public class PillServiceMapper {

    public OwnPill mapToOwnPill(OwnPillRegisterValue value) {
        return OwnPill
                .builder()
                .remains(value.getVo().getRemains())
                .takeCount(value.getVo().getTakeCount())
                .totalCount(value.getVo().getTotalCount())
                .takeWeekdays(value.getTakeWeekDaysValue())
                .takeOnceAmount(value.getTakeOnceAmount())
                .isAlarm(value.isAlarm())
                .takeYN(value.getVo().getTakeYn())
                .startAt(value.getVo().getStartAt())
                .createdAt(value.getCreateAt())
                .member(value.getMember())
                .pill(value.getPill())
                .build();
    }

    public ResponsePillInventorListVo mapToResponsePillInventorListVo(ResponsePillInventorListData takeTrue,
                                                                      ResponsePillInventorListData takeFalse) {
        return ResponsePillInventorListVo
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
                .imageURl(imageUrl)
                .totalCount(ownPill.getTotalCount())
                .remains(ownPill.getRemains())
                .predicateRunOutAt(at)
                .build();
    }
}
