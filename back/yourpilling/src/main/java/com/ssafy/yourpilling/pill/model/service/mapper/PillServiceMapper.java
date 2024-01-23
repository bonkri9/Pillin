package com.ssafy.yourpilling.pill.model.service.mapper;

import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.service.mapper.value.OwnPillRegisterValue;
import org.springframework.stereotype.Component;


@Component
public class PillServiceMapper {

    public OwnPill mapToOwnPill(OwnPillRegisterValue value) {
        return OwnPill
                .builder()
                .remains(value.getVo().getRemains())
                .takeCount(value.getVo().getTakeCount())
                .totalCount(value.getVo().getTotalCount())
                .isAlarm(value.isAlarm())
                .takeYN(value.getVo().getTakeYn())
                .startAt(value.getVo().getStartAt())
                .createdAt(value.getCreateAt())
                .member(value.getMember())
                .pill(value.getPill())
                .build();
    }
}
