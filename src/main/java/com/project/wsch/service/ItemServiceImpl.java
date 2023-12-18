package com.project.wsch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.wsch.mapper.ItemMapper;
import com.project.wsch.vo.ItemVO;

@Service
public class ItemServiceImpl implements ItemService {

    private final ItemMapper itemMapper;


	    @Autowired
	    public ItemServiceImpl(ItemMapper itemMapper) {
	        this.itemMapper = itemMapper;
	    }

	    @Override
	    public List<ItemVO> getAllItems() {
	        return itemMapper.getAllItems();
	    }

	    @Override
	    public ItemVO getItemById(int itemId) {
	        return itemMapper.getItemById(itemId);
	    }

}