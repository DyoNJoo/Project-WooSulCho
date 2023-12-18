package com.project.wsch.mapper;

import java.util.List;

import com.project.wsch.vo.ItemVO;

public interface ItemMapper {
    List<ItemVO> getAllItems();
    ItemVO getItemById(int itemId);
	ItemVO[] values();
}
