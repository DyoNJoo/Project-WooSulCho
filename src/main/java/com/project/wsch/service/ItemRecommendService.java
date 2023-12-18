package com.project.wsch.service;

import java.util.List;

import com.project.wsch.vo.ItemRecommendVO;
import com.project.wsch.vo.ItemVO;

public interface ItemRecommendService {
    public List<ItemVO> getAllItemsRecommend();
    public ItemVO getItemRecommendById(int itemId);
    public List<ItemVO> getFilteredItems(int body, int sweet, int sour);
}
