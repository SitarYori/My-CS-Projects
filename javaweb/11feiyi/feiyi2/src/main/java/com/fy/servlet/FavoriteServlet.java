package com.fy.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fy.dao.FavoriteDao;
import com.fy.entity.User;

@WebServlet("/FavoriteServlet")

public class FavoriteServlet extends HttpServlet {

    private FavoriteDao dao = new FavoriteDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // 1. 登录校验
        User user = (User) request.getSession().getAttribute("loginUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();

        // 2. 参数
        String heritageIdStr = request.getParameter("heritageId");
        if (heritageIdStr == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        int heritageId = Integer.parseInt(heritageIdStr);

        // 3. 切换收藏
        if (dao.isFavorited(userId, heritageId)) {
            dao.removeFavorite(userId, heritageId);
        } else {
            dao.addFavorite(userId, heritageId);
        }

        // 4. 回到原页面（关键）
        response.sendRedirect(request.getHeader("Referer"));
    }
}
