package com.ssafy.yourpilling.pill.model.service;

import com.ssafy.yourpilling.pill.model.service.vo.in.PillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillInventoryListVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillRegisterVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutPillInventorListVo;

public interface PillService {

    void register(PillRegisterVo vo);

    OutPillInventorListVo inventoryList(PillInventoryListVo pillInventoryListVo);

    OutOwnPillDetailVo detail(PillDetailVo pillDetailVo);
}
