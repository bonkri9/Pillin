package com.ssafy.yourpilling.push.model.service.vo.out;

import com.ssafy.yourpilling.push.model.dao.entity.PushMessageInfo;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class OutNotificationsVo {

    List<PushMessageInfo> pushMessageInfos;

}
