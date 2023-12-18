package com.project.wsch.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.wsch.service.TestService;

@Controller
public class TestController {
	@Autowired
	TestService service;
	
}
