package com.fy.entity;

public class Category {
    private int id;       // 分类ID
    private String name;  // 分类名称（如“传统技艺”“民间文学”）

    // 获取分类ID
    public int getId() {
        return id;
    }

    // 设置分类ID
    public void setId(int id) {
        this.id = id;
    }

    // 获取分类名称
    public String getName() {
        return name;
    }

    // 设置分类名称
    public void setName(String name) {
        this.name = name;
    }
}