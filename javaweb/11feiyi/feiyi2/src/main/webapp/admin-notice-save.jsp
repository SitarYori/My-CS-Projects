<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.Notice, com.fy.dao.NoticeDao" %>
<%
    // 设置请求编码防止乱码
    request.setCharacterEncoding("UTF-8");

    // 获取表单数据
    String title = request.getParameter("title");
    String type = request.getParameter("type");
    String content = request.getParameter("content");
    int isTop = Integer.parseInt(request.getParameter("isTop"));

    // 封装对象
    Notice notice = new Notice();
    notice.setTitle(title);
    notice.setType(type);
    notice.setContent(content);
    notice.setIsTop(isTop);

    // 调用Dao保存
    NoticeDao dao = new NoticeDao();
    boolean success = dao.insertNotice(notice);

    if(success) {
        out.println("<script>alert('发布成功！'); window.location.href='notice.jsp';</script>");
    } else {
        out.println("<script>alert('发布失败，请检查数据库连接'); history.back();</script>");
    }
%>