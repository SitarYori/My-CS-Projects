<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>公告中心 - 非遗文化传承平台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background-color: #FDF5E6; margin: 0; color: #333; }
        .container { width: 1000px; margin: 40px auto; }
        .top-nav { background-color: #8B4513; color: #fff; padding: 15px 0; }
        .nav-container { width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .nav-logo { font-size: 22px; font-weight: bold; color: #F1C27D; }
        .nav-menu { display: flex; gap: 25px; }
        .nav-menu a { color: #fff; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .nav-menu a:hover, .nav-menu a.active { color: #F1C27D; text-decoration: underline; }
        
        .nav-user { display: flex; align-items: center; gap: 12px; padding: 6px 15px; border: 1px solid #F1C27D; border-radius: 20px; background: rgba(255,255,255,0.1); }
        .user-avatar { width: 28px; height: 28px; border-radius: 50%; overflow: hidden; border: 1px solid #F1C27D; }
        .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .nav-user a { font-size: 13px; color: #fff; text-decoration: none; }
        
        /* 头部装饰 */
        .notice-header { text-align: center; margin-bottom: 40px; }
        .notice-header h1 { color: #8B4513; font-family: "KaiTi"; font-size: 32px; border-bottom: 2px solid #DAA520; display: inline-block; padding-bottom: 10px; }
        
        /* 分类标签 */
        .filter-tabs { display: flex; gap: 15px; margin-bottom: 25px; }
        .tab { padding: 8px 20px; background: white; border-radius: 20px; font-size: 14px; cursor: pointer; border: 1px solid #DEB887; color: #8B4513; transition: 0.3s; }
        .tab.active { background: #8B4513; color: white; border-color: #8B4513; }
        .tab:hover { background: #F5DEB3; }

        /* 公告列表卡片 */
        .notice-list { background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .notice-item { display: flex; align-items: center; padding: 20px; border-bottom: 1px solid #F5F5F5; transition: 0.2s; text-decoration: none; color: inherit; }
        .notice-item:last-child { border-bottom: none; }
        .notice-item:hover { background-color: #FFFBF0; }

        /* 类型标签颜色 */
        .type-tag { padding: 4px 10px; border-radius: 4px; font-size: 12px; margin-right: 15px; width: 60px; text-align: center; }
        .type-sys { background: #E1F5FE; color: #0288D1; } /* 系统通知 */
        .type-news { background: #FFF3E0; color: #E65100; } /* 非遗快讯 */
        .type-master { background: #F1F8E9; color: #388E3C; } /* 大师动态 */

        .notice-title { flex-grow: 1; font-size: 16px; font-weight: bold; color: #444; }
        .notice-date { color: #999; font-size: 13px; font-family: "Georgia"; }
        
        /* 置顶标志 */
        .top-badge { background: #FF5252; color: white; font-size: 11px; padding: 2px 6px; border-radius: 3px; margin-left: 10px; }

        /* 分页器 */
        .pagination { display: flex; justify-content: center; margin-top: 30px; gap: 10px; }
        .page-btn { padding: 5px 12px; background: white; border: 1px solid #DEB887; color: #8B4513; cursor: pointer; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>

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
            <% 
                User loginUser = (User) session.getAttribute("loginUser");
                if (loginUser != null) {
            %>
            <div class="nav-user">
                <div class="user-avatar">
                    <img src="images/user.jpg" alt="头像">
                </div>
                <span style="font-size:13px; color:#F1C27D;"><%= loginUser.getUsername() %></span>
                <a href="personalCenter.jsp">个人中心</a>
                <a href="logout">退出</a>
            </div>
            <% } else { %>
            <div class="nav-user"><a href="login.jsp">登录 / 注册</a></div>
            <% } %>
        </div>
    </nav>

    <div class="container">
        <div class="notice-header">
            <h1><i class="fas fa-bullhorn"></i> 梨园公告栏</h1>
            <p style="color: #666;">获取最新的非遗资讯、系统升级及传承人活动信息</p>
        </div>

        <div class="filter-tabs">
            <div class="tab active">全部</div>
            <div class="tab">系统通知</div>
            <div class="tab">非遗快讯</div>
            <div class="tab">大师动态</div>
        </div>

        <div class="notice-list">
            <%
                // 模拟公告数据，实际开发中应从数据库查询 NoticeDao.listAll()
                String[][] notices = {
                    {"sys", "平台升级公告：非遗全息展示功能上线", "2023-10-25", "top"},
                    {"news", "景德镇国际陶瓷博览会将于下月开幕", "2023-10-24", ""},
                    {"master", "陈大师手工制瓷技艺线上直播课预告", "2023-10-22", ""},
                    {"sys", "关于进一步加强非遗数字化档案保护的通知", "2023-10-20", ""},
                    {"news", "苏州刺绣获评最受年轻人关注的传统技艺", "2023-10-18", ""},
                    {"master", "杨医生中医针灸公益讲座（北京站）报名开启", "2023-10-15", ""}
                };

                for(String[] n : notices) {
                    String typeClass = "";
                    String typeName = "";
                    if(n[0].equals("sys")) { typeClass="type-sys"; typeName="系统"; }
                    else if(n[0].equals("news")) { typeClass="type-news"; typeName="资讯"; }
                    else { typeClass="type-master"; typeName="动态"; }
            %>
            <a href="notice-detail.jsp?id=<%= Math.random() %>" class="notice-item">
                <span class="type-tag <%= typeClass %>"><%= typeName %></span>
                <span class="notice-title">
                    <%= n[1] %>
                    <% if(n[3].equals("top")) { %><span class="top-badge">置顶</span><% } %>
                </span>
                <span class="notice-date"><%= n[2] %></span>
            </a>
            <% } %>
        </div>

        <div class="pagination">
            <a href="#" class="page-btn">上一页</a>
            <a href="#" class="page-btn" style="background:#8B4513; color:white;">1</a>
            <a href="#" class="page-btn">2</a>
            <a href="#" class="page-btn">下一页</a>
        </div>
    </div>

</body>
</html>