<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<%@ page import="com.fy.entity.Heritage" %>
<%@ page import="com.fy.dao.FavoriteDao" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>个人中心 - 非遗文化传承</title>
    <style>
        /* --- 基础样式 --- */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "微软雅黑", sans-serif; }
        body { background-color: #F8F0E3; color: #333; }

        /* --- 顶部导航栏 --- */
        .top-nav { background-color: #8B4513; color: #fff; padding: 15px 0; }
        .nav-container { width: 1100px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .nav-logo { font-size: 22px; font-weight: bold; color: #F1C27D; }
        .nav-menu { display: flex; gap: 25px; }
        .nav-menu a { color: #fff; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .nav-menu a:hover { color: #F1C27D; }
        .nav-user { display: flex; align-items: center; gap: 10px; }
        .user-btn { background: rgba(255,255,255,0.1); border: 1px solid #F1C27D; padding: 5px 15px; border-radius: 20px; color: #fff; text-decoration: none; font-size: 13px; }

        /* --- 个人中心主体布局 --- */
        .center-header { background: #703810; height: 160px; display: flex; align-items: center; justify-content: center; color: #fff; margin-bottom: -60px; }
        .center-header h1 { font-size: 24px; letter-spacing: 2px; }

        .main-container { width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 280px 1fr; gap: 30px; padding-bottom: 50px; }

        /* --- 左侧个人信息卡片 --- */
        .sidebar { background: #fff; border-radius: 12px; padding: 30px 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; height: fit-content; }
        .avatar-box { width: 100px; height: 100px; margin: 0 auto 15px; border-radius: 50%; border: 3px solid #F1C27D; overflow: hidden; }
        .avatar-box img { width: 100%; height: 100%; object-fit: cover; }
        .username { font-size: 20px; font-weight: bold; color: #3d1f08; margin-bottom: 25px; }
        
        .menu-list { text-align: left; list-style: none; border-top: 1px solid #eee; padding-top: 20px; }
        .menu-item { display: flex; align-items: center; padding: 12px 15px; margin-bottom: 8px; border-radius: 8px; cursor: pointer; color: #666; transition: 0.3s; text-decoration: none; }
        .menu-item i { margin-right: 12px; font-size: 18px; }
        .menu-item:hover, .menu-item.active { background: #F8F0E3; color: #8B4513; font-weight: bold; }

        /* --- 右侧内容区域 --- */
        .content-box { background: #fff; border-radius: 12px; padding: 40px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); display: flex; flex-direction: column; gap: 40px; min-height: 500px; }
        .section-title { font-size: 18px; color: #8B4513; margin-bottom: 25px; display: flex; align-items: center; border-left: 4px solid #8B4513; padding-left: 15px; }
        
        .form-row { display: grid; grid-template-columns: 100px 1fr; align-items: center; margin-bottom: 20px; }
        .form-row label { font-size: 14px; color: #777; }
        .form-row input, .form-row textarea { padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 14px; background: #fafafa; }
        .form-row input:focus { border-color: #8B4513; outline: none; background: #fff; }
        
        .btn-save { background: #8B4513; color: #fff; border: none; padding: 12px 40px; border-radius: 6px; cursor: pointer; font-size: 15px; transition: 0.3s; width: fit-content; margin-left: 100px; }
        .btn-save:hover { background: #703810; box-shadow: 0 4px 8px rgba(0,0,0,0.2); }

        /* 收藏卡片排版 */
        .fav-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; }
        .fav-card { border: 1px solid #eee; border-radius: 8px; overflow: hidden; display: flex; transition: 0.3s; }
        .fav-card:hover { border-color: #F1C27D; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .fav-card img { width: 120px; height: 100px; object-fit: cover; }
        .fav-info { padding: 12px; flex: 1; display: flex; flex-direction: column; justify-content: space-between; }
        .fav-info h4 { font-size: 15px; color: #3d1f08; }
        .fav-info a { color: #8B4513; font-size: 12px; text-decoration: none; font-weight: bold; }

        .divider { height: 1px; background: #eee; margin: 10px 0; }
        .footer { background: #3d1f08; color: #fff; text-align: center; padding: 30px 0; margin-top: 50px; font-size: 13px; opacity: 0.8; }
    </style>
</head>
<body>

<%
    // 获取当前登录用户
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // 获取当前菜单状态
    String menu = request.getParameter("menu");
    if (menu == null) menu = "info"; 
%>

<nav class="top-nav">
    <div class="nav-container">
        <div class="nav-logo">🏛 非遗文化传承</div>
        <div class="nav-menu">
                <a href="success-login.jsp">首页</a>
                <a href="heritage-project.jsp">非遗项目</a>
                <a href="inheritor.jsp">传承人</a>

                <a href="courses.jsp">在线课堂</a>
                <a href="notice.jsp">公告</a>
                <a href="ai-assistant.jsp">AI小助手</a>
            </div>
        <div class="nav-user">
            <span style="color:#F1C27D; font-size:13px; margin-right:10px;"><%= loginUser.getUsername() %></span>
            <a href="logout" class="user-btn" style="border-color:#ccc; color:#ccc;">退出登录</a>
        </div>
    </div>
</nav>

<div class="center-header">
    <h1><i style="margin-right:10px;">👤</i> 个人中心</h1>
</div>

<div class="main-container">
    <aside class="sidebar">
        <div class="avatar-box">
            <img src="images/user.jpg" alt="用户头像">
        </div>
        <div class="username"><%= loginUser.getUsername() %></div>
        
        <div class="menu-list">
            <a href="personalCenter.jsp?menu=info" 
               class="menu-item <%= "info".equals(menu) ? "active" : "" %>"><i>📁</i> 我的基本信息</a>
            
            <a href="personalCenter.jsp?menu=fav" 
               class="menu-item <%= "fav".equals(menu) ? "active" : "" %>"><i>❤</i> 我的收藏项目</a>
            
            <a href="#" class="menu-item"><i>💬</i> 我的互动点评</a>
            <a href="#" class="menu-item"><i>📝</i> 我的文化帖子</a>
            
            <a href="logout" class="menu-item" style="color:#cc0000; margin-top:20px;">
                <i>🚪</i> 退出当前账号
            </a>
        </div>
    </aside>

    <main class="content-box">
        <% if ("fav".equals(menu)) { %>
<section>
    <h2 class="section-title">❤ 我收藏的非遗项目</h2>
    <div class="fav-grid">
        <%
            // 实例化 Dao 并查询数据
            FavoriteDao fDao = new FavoriteDao();
            List<Heritage> myFavs = fDao.getFavoriteHeritagesByUserId(loginUser.getId());

            if (myFavs == null || myFavs.isEmpty()) {
        %>
            <div style="grid-column: 1 / -1; text-align: center; padding: 50px; color: #999;">
                <p>您还没有收藏任何项目</p>
                <a href="heritage-project.jsp" style="color: #8B4513; text-decoration: underline;">去探索非遗项目</a>
            </div>
        <%
            } else {
                for (Heritage h : myFavs) {
        %>
            <div class="fav-card">
                <img src="<%= h.getImage() %>" 
                     alt="<%= h.getTitle() %>" 
                     onerror="this.src='images/default.jpg'">
                <div class="fav-info">
                    <h4><%= h.getTitle() %></h4>
                    <p style="font-size: 12px; color: #888; margin-bottom: 8px;">分类：<%= h.getType() %></p>
                    <a href="HeritageServlet?action=detail&id=<%= h.getId() %>">
                        查看详情 →
                    </a>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>
</section>



        <% } else { %>
            <section>
                <h2 class="section-title">📝 修改个人信息</h2>
                <form action="updateProfile" method="post">
                    <div class="form-row">
                        <label>真实姓名</label>
                        <input type="text" name="realName" placeholder="请输入您的姓名" value="<%= loginUser.getUsername() %>">
                    </div>
                    <div class="form-row">
                        <label>联系电话</label>
                        <input type="text" name="phone" placeholder="请输入您的手机号" value="188XXXX8899">
                    </div>
                    <div class="form-row">
                        <label>个人简介</label>
                        <textarea name="intro" rows="3" placeholder="写点什么介绍下自己吧..."></textarea>
                    </div>
                    <button type="submit" class="btn-save">保存修改</button>
                </form>
            </section>

            <div class="divider"></div>

            <section>
                <h2 class="section-title">🔑 修改安全密码</h2>
                <form action="updatePassword" method="post">
                    <div class="form-row">
                        <label>原密码</label>
                        <input type="password" name="oldPwd" placeholder="请输入当前密码">
                    </div>
                    <div class="form-row">
                        <label>新密码</label>
                        <input type="password" name="newPwd" placeholder="请输入新密码">
                    </div>
                    <div class="form-row">
                        <label>确认密码</label>
                        <input type="password" name="confirmPwd" placeholder="请再次输入新密码">
                    </div>
                    <button type="submit" class="btn-save">修改密码</button>
                </form>
            </section>
        <% } %>
        
    </main>
</div>

<footer class="footer">
    © 2025 非遗文化传承平台 版权所有 | 传承中华文明 · 守护民族根脉
</footer>

</body>
</html>