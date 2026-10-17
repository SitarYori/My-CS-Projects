package com.fy.dao;

import com.fy.entity.Inheritor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 非遗传承人数据访问类
 * 负责与数据库t_inheritor表交互
 */
public class InheritorDao {
    // 数据库连接信息（可抽取到DBUtil工具类中，此处为方便演示直接写入）
    private static final String DB_URL = "jdbc:mysql://localhost:3306/feiyi_db?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf8mb4";
    private static final String DB_USER = "root"; // 你的数据库用户名
    private static final String DB_PASSWORD = "123456"; // 你的数据库密码

    /**
     * 查询所有非遗传承人信息
     * @return List<Inheritor> 传承人列表，无数据时返回空列表
     */
    public List<Inheritor> getAllInheritors() {
        // 定义返回结果列表
        List<Inheritor> inheritorList = new ArrayList<>();
        // 声明JDBC相关对象（提前声明，方便finally中关闭）
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 1. 加载JDBC驱动（MySQL 8.0+ 可省略，自动加载）
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. 获取数据库连接
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // 3. 编写SQL语句，查询所有传承人（按id降序，最新添加的排在前面）
            String sql = "SELECT id, name, avatar, tag, description FROM t_inheritor ORDER BY id DESC";

            // 4. 创建PreparedStatement对象（防止SQL注入）
            pstmt = conn.prepareStatement(sql);

            // 5. 执行SQL语句，获取结果集
            rs = pstmt.executeQuery();

            // 6. 遍历结果集，封装为Inheritor对象并添加到列表
            while (rs.next()) {
                Inheritor inheritor = new Inheritor();
                inheritor.setId(rs.getInt("id"));
                inheritor.setName(rs.getString("name"));
                inheritor.setAvatar(rs.getString("avatar"));
                inheritor.setTag(rs.getString("tag"));
                inheritor.setDescription(rs.getString("description"));

                // 将封装好的传承人对象添加到列表
                inheritorList.add(inheritor);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("JDBC驱动加载失败，请检查驱动依赖！");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("数据库操作失败，SQL执行异常！");
        } finally {
            // 7. 关闭JDBC资源（逆序关闭，避免资源泄露）
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 8. 返回传承人列表
        return inheritorList;
    }

    // 扩展：可添加根据id查询单个传承人、新增传承人等方法（按需补充）
    public Inheritor getInheritorById(Integer id) {
        // 实现逻辑与getAllInheritors类似，SQL改为 WHERE id = ?
        return null;
    }
}