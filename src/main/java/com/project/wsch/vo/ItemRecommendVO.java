package com.project.wsch.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ItemRecommendVO {
	private int no;
	private String name;
	private int body;
	private int sweet;
	private int sour;
	private String img;
	private int urlnum;
}
