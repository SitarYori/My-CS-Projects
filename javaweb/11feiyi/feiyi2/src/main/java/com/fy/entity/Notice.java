package com.fy.entity;

public class Notice {
    
    // 1. 私有属性
    private int id;             // 公告ID
    private String type;        // 类型：sys(系统), news(资讯), master(动态)
    private String title;       // 标题
    private String content;     // 正文内容
    private String publishDate; // 发布日期（也可以使用 java.util.Date，但在简单的JSP中用String更方便处理）
    private int isTop;          // 是否置顶：1-是，0-否

    // 2. 无参构造方法（必须，用于一些框架反射）
    public Notice() {
    }

    // 3. 全参构造方法（可选，方便在代码中快速创建对象）
    public Notice(int id, String type, String title, String content, String publishDate, int isTop) {
        this.id = id;
        this.type = type;
        this.title = title;
        this.content = content;
        this.publishDate = publishDate;
        this.isTop = isTop;
    }

    // 4. Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public int getIsTop() {
        return isTop;
    }

    public void setIsTop(int isTop) {
        this.isTop = isTop;
    }

    // 5. toString 方法，方便在控制台打印调试输出
    @Override
    public String toString() {
        return "Notice{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", publishDate='" + publishDate + '\'' +
                ", isTop=" + isTop +
                '}';
    }
}
