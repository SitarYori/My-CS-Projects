package com.fy.dao;

import com.fy.entity.Heritage;
import com.fy.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HeritageDao {

    /**
     * 私有辅助方法：将 ResultSet 的当前行转换为 Heritage 对象
     * 解决你代码中多处重复手动赋值的问题
     */
    private Heritage mapHeritage(ResultSet rs) throws Exception {
        Heritage h = new Heritage();
        h.setId(rs.getInt("id"));
        h.setTitle(rs.getString("name"));
        h.setType(rs.getString("type"));
        h.setDescription(rs.getString("descr"));
        h.setImage(rs.getString("img"));
        h.setStar(rs.getFloat("star"));
        h.setViews(rs.getInt("view_count"));
        return h;
    }

    // 1. 获取所有非遗项目 (简化：直接调用分页查询)
    public List<Heritage> getAllHeritage() throws Exception {
        return getHeritageByType(null);
    }

    // 2. 按分类筛选非遗项目 (逻辑提取)
    public List<Heritage> getHeritageByType(String type) throws Exception {
        List<Heritage> list = new ArrayList<>();
        String sql = (type == null || type.isEmpty()) ? 
                     "SELECT * FROM heritage" : "SELECT * FROM heritage WHERE type=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (type != null && !type.isEmpty()) {
                ps.setString(1, type);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapHeritage(rs)); // 使用提取的方法
                }
            }
        }
        return list;
    }

    // 3. 分页查询：根据类型和页码获取数据 (完整实现)
    public List<Heritage> getHeritageByPage(String type, int page, int pageSize) throws Exception {
        List<Heritage> list = new ArrayList<>();
        int start = (page - 1) * pageSize;
        
        boolean isAll = (type == null || "全部".equals(type) || type.isEmpty());
        String sql = isAll ? "SELECT * FROM heritage LIMIT ?, ?" 
                           : "SELECT * FROM heritage WHERE type = ? LIMIT ?, ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (isAll) {
                ps.setInt(1, start);
                ps.setInt(2, pageSize);
            } else {
                ps.setString(1, type);
                ps.setInt(2, start);
                ps.setInt(3, pageSize);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapHeritage(rs));
                }
            }
        }
        return list;
    }

    // 4. 获取总记录数
    public int getTotalCount(String type) throws Exception {
        int count = 0;
        boolean isAll = (type == null || "全部".equals(type) || type.isEmpty());
        String sql = isAll ? "SELECT COUNT(*) FROM heritage" 
                           : "SELECT COUNT(*) FROM heritage WHERE type = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (!isAll) ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) count = rs.getInt(1);
            }
        }
        return count;
    }

    // 5. 根据ID获取单个非遗项目 (详情页用)
    public Heritage getHeritageById(Integer id) throws Exception {
        String sql = "SELECT * FROM heritage WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapHeritage(rs);
            }
        }
        return null;
    }

    // 6. 删除操作 (保持原样，逻辑清晰)
    public boolean deleteHeritage(int id) {
        String sql = "DELETE FROM heritage WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

	public List<Heritage> findAll() {
		// TODO Auto-generated method stub
		List<Heritage> heritageList = new ArrayList<>();
        // 实现逻辑：执行SQL查询所有非遗项目，并封装为Heritage对象
        // 示例（结合项目的数据库操作方式，如JDBC）：
        String sql = "SELECT * FROM heritage";
        // 执行SQL，将结果集转换为Heritage对象并添加到heritageList
        // （需补充具体数据库操作代码）
        return heritageList;
	}
}