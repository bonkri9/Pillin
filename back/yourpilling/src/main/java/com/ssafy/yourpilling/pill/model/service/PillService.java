package com.ssafy.yourpilling.pill.model.service;

import com.ssafy.yourpilling.pill.model.service.vo.in.OwnPillUpdateVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillInventoryListVo;
import com.ssafy.yourpilling.pill.model.service.vo.in.PillRegisterVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutOwnPillDetailVo;
import com.ssafy.yourpilling.pill.model.service.vo.out.OutPillInventorListVo;

public interface PillService {

    void register(PillRegisterVo vo);

    OutPillInventorListVo inventoryList(PillInventoryListVo vo);

    OutOwnPillDetailVo detail(PillDetailVo vo);

    void update(OwnPillUpdateVo vo);
}
