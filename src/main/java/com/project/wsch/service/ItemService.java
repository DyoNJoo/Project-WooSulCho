package com.project.wsch.service;

import java.util.List;

import com.project.wsch.vo.ItemVO;

public interface ItemService {
    List<ItemVO> getAllItems();
    ItemVO getItemById(int itemId);
}
