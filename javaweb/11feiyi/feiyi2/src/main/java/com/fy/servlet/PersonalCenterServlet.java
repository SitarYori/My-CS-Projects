package com.fy.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fy.dao.FavoriteDao;
import com.fy.entity.Heritage;
import com.fy.entity.User;

/**
 * Servlet implementation class PersonalCenterServlet
 */
@WebServlet("/PersonalCenterServlet")

public class PersonalCenterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        FavoriteDao fDao = new FavoriteDao();
        List<Heritage> myFavs =
                fDao.getFavoriteHeritagesByUserId(loginUser.getId());

        // ⭐ 放进 request
        req.setAttribute("myFavs", myFavs);

        req.getRequestDispatcher("/personnelcentral.jsp")
           .forward(req, resp);
    }
}

