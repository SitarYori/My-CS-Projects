package com.fy.servlet;

import com.fy.dao.HeritageDao;
import com.fy.entity.Heritage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/heritage")
public class HeritageServlet extends HttpServlet {
    private HeritageDao heritageDao = new HeritageDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            // 列表页（默认/分类筛选）
            listHeritage(req, resp);
        } else if ("detail".equals(action)) {
            // 详情页
            detailHeritage(req, resp);
        }
    }

    // 列表页：默认显示所有，或按分类筛选
    private void listHeritage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Heritage> heritageList;
        String type = req.getParameter("type");
        try {
            if (type != null && !type.isEmpty()) {
                // 按分类筛选
                heritageList = heritageDao.getHeritageByType(type);
            } else {
                // 显示所有
                heritageList = heritageDao.getAllHeritage();
            }
            req.setAttribute("heritageList", heritageList);
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    // 详情页：根据ID获取单个项目
 // 在 detailHeritage 方法中
 // 找到 detailHeritage 方法，完整替换如下：
    private void detailHeritage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            Integer id = Integer.parseInt(idStr);
            Heritage heritage = heritageDao.getHeritageById(id);
            
            // 1. 将查询到的对象存入 request
            req.setAttribute("heritage", heritage);
            
            // 2. 关键：转发到你正在使用的那个 JSP 页面
            req.getRequestDispatcher("heritage-cixiu.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}