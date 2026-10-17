package com.fy.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.fy.entity.Notice;

public class NoticeDao {
    
    // 数据库连接配置
    private String url = "jdbc:mysql://localhost:3306/your_db_name?useUnicode=true&characterEncoding=UTF-8";
    private String username = "root";
    private String password = "password";

    // 获取数据库连接
    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, username, password);
    }

    // 1. 获取所有公告列表（按置顶和日期排序）
    public List<Notice> getAllNotices() {
        List<Notice> list = new ArrayList<>();
        String sql = "SELECT * FROM notice ORDER BY is_top DESC, publish_date DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Notice n = new Notice();
                n.setId(rs.getInt("id"));
                n.setType(rs.getString("type"));
                n.setTitle(rs.getString("title"));
                n.setPublishDate(rs.getString("publish_date"));
                n.setIsTop(rs.getInt("is_top"));
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. 根据 ID 获取公告详情
    public Notice getNoticeById(int id) {
        String sql = "SELECT * FROM notice WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Notice n = new Notice();
                    n.setId(rs.getInt("id"));
                    n.setTitle(rs.getString("title"));
                    n.setContent(rs.getString("content"));
                    n.setPublishDate(rs.getString("publish_date"));
                    n.setType(rs.getString("type"));
                    return n;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

 // 3. 插入新公告
    public boolean insertNotice(Notice notice) {
        String sql = "INSERT INTO notice (type, title, content, publish_date, is_top) VALUES (?, ?, ?, CURDATE(), ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, notice.getType());
            ps.setString(2, notice.getTitle());
            ps.setString(3, notice.getContent());
            ps.setInt(4, notice.getIsTop());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
