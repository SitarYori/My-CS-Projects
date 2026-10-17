package com.fy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fy.entity.Heritage;
import com.fy.utils.DBUtil;

public class FavoriteDao {

    /**
     * 1️⃣ 添加收藏
     */
	public boolean addFavorite(int userId, int heritageId) {
        String sql = "INSERT INTO favorites (user_id, heritage_id, add_time) VALUES (?, ?, NOW())";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, heritageId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 2️⃣ 取消收藏
     */
	 public boolean removeFavorite(int userId, int heritageId) {
	        String sql = "DELETE FROM favorites WHERE user_id=? AND heritage_id=?";
	        try (Connection conn = DBUtil.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.setInt(2, heritageId);
	            return ps.executeUpdate() > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

    /**
     * 3️⃣ 判断是否已收藏（⭐/🌟）
     */
	 public boolean isFavorited(int userId, int heritageId) {
	        String sql = "SELECT 1 FROM favorites WHERE user_id=? AND heritage_id=?";
	        try (Connection conn = DBUtil.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, userId);
	            ps.setInt(2, heritageId);
	            ResultSet rs = ps.executeQuery();
	            return rs.next();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	
	 /**
	  * 4️⃣ 我的收藏（个人中心）
	  */
	 public List<Heritage> getFavoriteHeritagesByUserId(int userId) {
	     List<Heritage> list = new ArrayList<>();

	     String sql =
	         "SELECT h.id, h.title, h.image " +
	         "FROM heritage h " +
	         "INNER JOIN favorites f ON h.id = f.heritage_id " +
	         "WHERE f.user_id = ? " +
	         "ORDER BY f.add_time DESC";

	     try (Connection conn = DBUtil.getConnection();
	          PreparedStatement ps = conn.prepareStatement(sql)) {

	         ps.setInt(1, userId);
	         ResultSet rs = ps.executeQuery();

	         while (rs.next()) {
	             Heritage h = new Heritage();
	             h.setId(rs.getInt("id"));
	             h.setTitle(rs.getString("title"));
	             h.setImage(rs.getString("image"));
	             h.setType(rs.getString("type"));
	             h.setTitle(rs.getString("name"));
	             list.add(h);
	         }
	     } catch (Exception e) {
	         e.printStackTrace();
	     }

	     return list;
	 }



}
