<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fy.entity.Heritage" %>
<%@ page import="com.fy.entity.User" %>
<%@ page import="com.fy.dao.HeritageDao" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>非遗项目 </title>
    <style>
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
         body { background-color: #F8F0E3; color: #333; line-height: 1.6; }

        /* 顶部导航栏 (保持风格统一) */
        .top-nav { background-color: #8B4513; color: #fff; padding: 15px 0; }
        .nav-container { width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .nav-logo { font-size: 22px; font-weight: bold; color: #F1C27D; }
        .nav-menu { display: flex; gap: 25px; }
        .nav-menu a { color: #fff; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .nav-menu a:hover, .nav-menu a.active { color: #F1C27D; text-decoration: underline; }
        
        .nav-menu a.active {
    		text-decoration: none; /* 强制无下划线 */
   		 color: #F1C27D; /* 可选：选中状态变金色，突出显示 */
		}
        .nav-user { display: flex; align-items: center; gap: 12px; padding: 6px 15px; border: 1px solid #F1C27D; border-radius: 20px; background: rgba(255,255,255,0.1); }
        .user-avatar { width: 28px; height: 28px; border-radius: 50%; overflow: hidden; border: 1px solid #F1C27D; }
        .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .nav-user a { font-size: 13px; color: #fff; text-decoration: none; }


        /* --- Banner样式 --- */
        /* Banner 区域 */
        .header-banner { background-color: #703810; color: #fff; text-align: center; padding: 50px 20px; }
        .header-banner h1 { font-size: 28px; margin-bottom: 22px; letter-spacing: 2px; }
        .header-banner p { font-size: 14px; opacity: 0.8; }

        /* --- 内容容器样式  --- */
        .container {
            width: 1200px;
            margin: 20px auto;
        }
        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }
        .search-bar input {
            width: 400px;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px 0 0 4px;
        }
        .search-bar select {
            padding: 8px;
            border: 1px solid #ccc;
        }
        .search-bar button {
            padding: 8px 15px;
            background-color: #8B4513;
            color: #fff;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
        }
        .category-tabs {
            margin-bottom: 20px;
            text-align: center;
        }
        .category-tabs a {
            display: inline-block;
            padding: 5px 12px;
            background-color: #D2B48C;
            color: #333;
            text-decoration: none;
            margin: 0 5px;
            border-radius: 3px;
            font-size: 14px;
        }
        .category-tabs a.active, .category-tabs a:hover {
            background-color: #8B4513;
            color: #fff;
        }
        .project-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .project-item {
            background-color: #fff;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            transition: transform 0.2s;
        }
        .project-item:hover {
            transform: scale(1.02);
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .project-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .project-item h3 {
            font-size: 16px;
            margin-bottom: 5px;
        }
        .project-item p {
            font-size: 12px;
            color: #666;
            margin-bottom: 10px;
            line-height: 1.5;
            height: 36px;
            overflow: hidden;
        }
        .project-item .stats {
            font-size: 12px;
            color: #8B4513;
            margin-bottom: 10px;
        }
        .project-item .btn {
            display: inline-block;
            padding: 5px 15px;
            background-color: #8B4513;
            color: #fff;
            text-decoration: none;
            border-radius: 3px;
            font-size: 12px;
        }
        .pagination {
            text-align: center;
            margin: 30px 0;
        }
        .pagination a {
            display: inline-block;
            padding: 5px 10px;
            background-color: #fff;
            border: 1px solid #ccc;
            text-decoration: none;
            color: #333;
            margin: 0 2px;
            border-radius: 3px;
        }
        .pagination a.active, .pagination a:hover {
            background-color: #8B4513;
            color: #fff;
            border-color: #8B4513;
        }
         /* 底部版权 */
        
        .footer { background: #3d1f08; color: #fff; padding: 40px 0; margin-top: 60px; font-size: 13px; }
        .footer-content { width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; }
        .footer-logo img { width: 120px; filter: brightness(2); }
    
    </style>
</head>
<body>
    <div class="top-nav">
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
                <a href="logout">退出登录</a>
            </div>
            <% } else { %>
            <div class="nav-user"><a href="login.jsp">登录 / 注册</a></div>
            <% } %>
        </div>
    </div>

    <div class="header-banner">
        <h1>🏛 非遗项目</h1>
        <p>探索中华民族的丰厚非物质文化遗产</p>
    </div>

    <div class="container">
        <div class="search-bar">
            <form action="heritage-project.jsp" method="get" style="display:inline;">
                <input type="text" name="keyword" placeholder="搜索非遗项目...">
                <select name="sort">
                    <option value="latest">最新发布</option>
                    <option value="views">最多浏览</option>
                    <option value="stars">最高评分</option>
                </select>
                <button type="submit">搜索</button>
            </form>
        </div>

        <div class="category-tabs">
            <%
                String type = request.getParameter("type");
                if (type == null) type = "全部";
            %>
            <a href="heritage-project.jsp?type=全部" class="<%= "全部".equals(type) ? "active" : "" %>">全部</a>
            <a href="heritage-project.jsp?type=民间工艺" class="<%= "民间工艺".equals(type) ? "active" : "" %>">民间工艺</a>
            <a href="heritage-project.jsp?type=传统音乐" class="<%= "传统音乐".equals(type) ? "active" : "" %>">传统音乐</a>
            <a href="heritage-project.jsp?type=传统舞蹈" class="<%= "传统舞蹈".equals(type) ? "active" : "" %>">传统舞蹈</a>
            <a href="heritage-project.jsp?type=传统医药" class="<%= "传统医药".equals(type) ? "active" : "" %>">传统医药</a>
            <a href="heritage-project.jsp?type=传统美食" class="<%= "传统美食".equals(type) ? "active" : "" %>">传统美食</a>
            <a href="heritage-project.jsp?type=传统建筑" class="<%= "传统建筑".equals(type) ? "active" : "" %>">传统建筑</a>
            <a href="heritage-project.jsp?type=民间文学" class="<%= "民间文学".equals(type) ? "active" : "" %>">民间文学</a>
        </div>



<div class="project-grid">
    <%
        HeritageDao dao = new HeritageDao();
        List<Heritage> projectList;
        if ("全部".equals(type)) {
            projectList = dao.getAllHeritage();
        } else {
            projectList = dao.getHeritageByType(type);
        }

        for (Heritage h : projectList) {
            // --- 新增逻辑：根据标题匹配跳转页面 ---
            String targetPage = "heritage-detail.jsp"; // 默认页面
            String title = h.getTitle();
            String imgPath = h.getImage(); // 默认获取数据库路径
            
            if ("民间文学传说".equals(title)) {
                targetPage = "heritage-wenxue.jsp";
                imgPath = "images/民间文学.png";
            } else if ("苏州刺绣".equals(title)) {
                targetPage = "heritage-cixiu.jsp";
                imgPath = "images/刺绣.jpeg";
            } else if ("传统剪纸艺术".equals(title)) {
                targetPage = "heritage-jianzhi.jsp";
                imgPath = "images/剪纸.jpeg";
            } else if ("京剧音乐艺术".equals(title)) {
                targetPage = "heritage-detail.jsp"; 
                imgPath = "images/jingju.jpeg";
            } else if ("民族舞蹈表演".equals(title)) {
                targetPage = "heritage-wudao.jsp";
                imgPath = "images/民族舞.jpeg";
            } else if ("中医传统疗法".equals(title)) {
                targetPage = "heritage-zhongyi.jsp";
                imgPath = "images/中医.jpg";
            } else if ("传统美食制作".equals(title)) {
                targetPage = "heritage-meishi.jsp";
                imgPath = "images/美食技艺.png";
            } else if ("传统建筑文化".equals(title)) {
                targetPage = "heritage-jianzhu.jsp";
                imgPath = "images/建筑.jpeg";
            } else if ("醴陵釉陶瓷制作".equals(title)) {
                targetPage = "heritage-taoci.jsp";
                imgPath = "images/万紫千红.png";
            }
    %>
            <div class="project-item">
                <img src="<%= imgPath %>" alt="<%= title %>">
                <h3><%= title %></h3>
                <p><%= h.getDescription() %></p>
                <div class="stats">
                    <% for (int i=0; i<Math.floor(h.getStar()); i++) { %>★<% } %>
                    <% if (h.getStar() % 1 > 0) { %>☆<% } %>
                    <%= h.getStar() %> | 浏览 <%= h.getViews() %>
                </div>
                <a href="<%= targetPage %>" class="btn">查看详情</a>
            </div>
            
            
    <%
        }
    %>
</div>

        <div class="pagination">
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">下一页</a>
        </div>
    </div>

        <div class="footer">
        <div class="footer-content">
            <div style="flex: 1;">
                <h4 style="color:#F1C27D; margin-bottom:15px;">关于我们</h4>
                <p style="opacity:0.7;">非遗文化传承平台致力于保护和传承中华优秀传统文化，让更多人了解非物质文化遗产的魅力。</p>
            </div>
            <div style="flex: 1; text-align: center;">
                <h4 style="color:#F1C27D; margin-bottom:15px;">快速链接</h4>
                <p>项目申报 | 传承人申请 | 志愿加入</p>
            </div>
            <div style="flex: 1; text-align: right;">
                <h4 style="color:#F1C27D; margin-bottom:15px;">联系方式</h4>
                <p>📧 contact@heritage.com</p>
                <p>📞 400-888-8888</p>
            </div>
        </div>
        <div style="text-align:center; margin-top:30px; opacity:0.5; border-top:1px solid rgba(255,255,255,0.1); padding-top:20px;">
            © 2025 非遗文化传承平台 版权所有 | 传承文化 · 守护经典
        </div>
    </div>
</body>
</html>