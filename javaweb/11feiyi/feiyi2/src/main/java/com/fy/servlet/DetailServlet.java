package com.fy.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DetailServlet
 */
@WebServlet("/DetailServlet")
public class DetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 拿到 ID 和 目标页面
        String id = request.getParameter("id");
        String target = request.getParameter("target");

        // 2. 把 ID 存进 Session (缓存)
        request.getSession().setAttribute("currentProjectID", id);

        // 3. 跳转到对应的页面
        response.sendRedirect(target);
    }
}
