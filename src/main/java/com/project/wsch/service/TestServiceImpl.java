package com.project.wsch.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.project.wsch.mapper.TestMapper;

@Service
public class TestServiceImpl implements TestService{
	@Inject
	TestMapper mapper;

	
}
