package com.ssafy.yourpilling.pill.model.service;

import com.ssafy.yourpilling.pill.model.service.vo.request.PillInventoryListVo;
import com.ssafy.yourpilling.pill.model.service.vo.request.PillRegisterVo;
import com.ssafy.yourpilling.pill.model.service.vo.response.ResponsePillInventorListVo;

public interface PillService {

    void register(PillRegisterVo vo);

    ResponsePillInventorListVo inventoryList(PillInventoryListVo pillInventoryListVo);
}
