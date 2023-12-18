package com.project.wsch.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor 
@AllArgsConstructor 
@Data
public class ItemVO {
    private int id;
    private String name;
    private String type;
    private String abv;
    private String amount;
    private String price;
    private String materials;   

    private String img_prod;
    private String img_taste;
    private String desc;
    
    private int body;
    private int sweet;
    private int sour;
}
