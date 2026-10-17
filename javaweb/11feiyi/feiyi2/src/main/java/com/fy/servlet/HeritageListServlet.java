package com.fy.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fy.utils.DBUtil;
import com.fy.dao.FavoriteDao;
import com.fy.dao.HeritageDao;
import com.fy.entity.Heritage;
import com.fy.entity.User;

/**
 * Servlet implementation class HeritageListServlet
 */
@WebServlet("/heritage/list")
public class HeritageListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

    	HeritageDao heritageDao = new HeritageDao();
    	List<Heritage> list = heritageDao.findAll();

        // ===== 关键：算收藏状态 =====
        User user = (User) req.getSession().getAttribute("loginUser");
        if (user != null) {
            FavoriteDao favoriteDao = new FavoriteDao();
            int userId = user.getId();

            for (Heritage h : list) {
                boolean fav = favoriteDao.isFavorited(userId, h.getId());
                h.setFavorited(fav);
            }
        }

        req.setAttribute("list", list);
        req.getRequestDispatcher("/heritage-project.jsp")
           .forward(req, resp);
    }
}
