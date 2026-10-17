package com.fy.entity;

public class Heritage {
    // 已有的字段
    private Integer id;
    private String title; // 对应数据库name
    private String description; // 对应数据库descr
    private String image; // 对应数据库img
    private Integer views; // 对应数据库view_count
    
    // ===== 新增，不映射数据库 =====
    private boolean favorited;
    public boolean isFavorited() {
        return favorited;
    }

    public void setFavorited(boolean favorited) {
        this.favorited = favorited;
    }
    // 补充缺失的字段（解决setType、setStar报错的核心）
    private String type; // 对应数据库type（非遗分类）
    private Float star; // 对应数据库star（评分）

    // 无参构造器（必须保留，Dao层反射创建对象需要）
    public Heritage() {}

    // 全参构造器（可选，方便快速创建对象）
    public Heritage(Integer id, String title, String description, String image, Integer views, String type, Float star) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.image = image;
        this.views = views;
        this.type = type; // 初始化补充字段
        this.star = star; // 初始化补充字段
    }

    // 已有的getter/setter（省略，保持原有即可）
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public Integer getViews() { return views; }
    public void setViews(Integer views) { this.views = views; }

    // 补充缺失的setter/getter（解决报错的关键）
    public String getType() { return type; }
    public void setType(String type) { this.type = type; } // 对应Dao层的h.setType()
    public Float getStar() { return star; }
    public void setStar(Float star) { this.star = star; } // 对应Dao层的h.setStar()
}