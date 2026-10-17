package com.fy.entity;

/**
 * 非遗传承人实体类
 * 对应数据库表：t_inheritor（可根据实际项目调整表名）
 */
public class Inheritor {
    // 核心字段（与数据库表字段对应，可根据需求扩展）
    private Integer id; // 传承人唯一标识（主键，自增）
    private String name; // 传承人姓名
    private String avatar; // 传承人头像图片路径（如：images/inheritor/1.jpg）
    private String tag; // 传承人标签（如：苏绣大师、剪纸非遗传承人）
    private String description; // 传承人简介（简短描述）
    private String specialty; // 专长（扩展字段，可选）
    private Integer level; // 非遗级别（扩展字段，可选）

    // 无参构造器（必须提供，用于JDBC结果集封装）
    public Inheritor() {
    }

    // 全参构造器（方便快速创建对象）
    public Inheritor(Integer id, String name, String avatar, String tag, String description) {
        this.id = id;
        this.name = name;
        this.avatar = avatar;
        this.tag = tag;
        this.description = description;
    }

    // Getter 和 Setter 方法（必须提供，用于读取/设置对象属性）
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}