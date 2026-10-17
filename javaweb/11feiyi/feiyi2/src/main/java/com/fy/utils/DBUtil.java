package com.fy.utils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mysql.jdbc.Statement;


public class DBUtil {
	private static String url = "jdbc:mysql://localhost:3306/feiyi?useSSL=false&useUnicode=true&characterEncoding=utf8";
	private static String user = "root";
	private static String password = "123456";


	public static Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection(url, user, password);
		}
	
	// 核心新增：统一关闭资源的工具方法
	// 在 DBUtil.java 中修改此方法
	// 在 DBUtil.java 中添加这两个方法，报错就会消失
	public static void closeAll(Connection conn, PreparedStatement ps, ResultSet rs) {
	    closeAll(conn, (java.sql.Statement)ps, rs);
	}

	public static void closeAll(Connection conn, java.sql.Statement stmt, ResultSet rs) {
	    try {
	        if (rs != null) rs.close();
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
    
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            System.out.println("数据库连接成功：" + conn);
            closeAll(conn, null, null); // 测试完也记得关闭
        } catch (Exception e) {
            System.out.println("数据库连接失败：" + e.getMessage());
            e.printStackTrace();
        }
	}
}
