<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>传统建筑文化 - 非遗项目详情</title>
    <style>
        :root {
            --main-gray: #4A5568;      /* 黛瓦青，建筑主色 */
            --dark-brown: #3E2723;     /* 深木色 */
            --accent-gold: #F1C27D;
            --light-bg: #F5F5F5;       /* 灰白色背景，模拟石材感 */
            --border-color: #D7CCC8;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: var(--light-bg); color: #333; line-height: 1.6; }
        
        /* 导航栏复用 */
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

        /* 面包屑 */
        .breadcrumb { width: 1100px; margin: 20px auto; font-size: 13px; color: #888; }
        .breadcrumb a { color: #888; text-decoration: none; transition: 0.3s; }
        .breadcrumb a:hover { color: var(--main-brown); }
        
        /* Banner */
        .detail-header { background-color: var(--main-gray); color: #fff; padding: 40px 0; margin-bottom: 30px; border-bottom: 4px solid var(--dark-brown); }
        .header-content { width: 1100px; margin: 0 auto; }
        .header-content h1 { font-size: 32px; margin-bottom: 15px; letter-spacing: 2px; }
        .stats-bar { display: flex; gap: 20px; font-size: 14px; opacity: 0.9; }
        .stat-tag { background: rgba(255,255,255,0.15); padding: 4px 12px; border-radius: 4px; border: 1px solid rgba(255,255,255,0.2);  transition: all 0.2s ease; /* 新增：过渡动画 */}
        .stat-tag:hover { /* 新增：悬浮高亮 */background: rgba(255,255,255,0.25); border-color: rgba(255,255,255,0.4); }
        
        /* 主体布局 */
        .main-layout { width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 1fr 300px; gap: 30px; padding-bottom: 60px; }

        /* 左侧 */
        .content-card { background: #fff; border-radius: 8px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 25px; border: 1px solid #f0f0f0; }
        .section-title { font-size: 18px; font-weight: bold; color: var(--dark-brown); margin-bottom: 20px; display: flex; align-items: center; gap: 10px; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .main-img { width: 100%; border-radius: 6px; margin-bottom: 25px; border: 5px solid #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .text-content { font-size: 15px; color: #555; text-indent: 2em; margin-bottom: 20px; text-align: justify; }

        /* 建筑赏析网格 */
        .gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin-top: 20px; }
        .gallery-item { text-align: center; }
        .gallery-item img { width: 100%; height: 150px; object-fit: cover; border-radius: 4px; border: 1px solid #eee; }
        .gallery-item p { margin-top: 8px; font-size: 14px; color: var(--main-brown); font-weight: bold; }

        /* 右侧 */
        .side-card { background: #fff; border-radius: 8px; padding: 25px; border: 1px solid var(--border-color); margin-bottom: 20px; text-align: center; }
        .inheritor-avatar { width: 80px; height: 80px; border-radius: 50%; border: 2px solid var(--accent-gold); margin-bottom: 15px; }
        .side-btn { display: block; width: 100%; padding: 10px; margin-top: 15px; border: 1px solid var(--main-brown); color: var(--main-brown); text-decoration: none; border-radius: 4px; font-size: 14px; }
        .side-btn:hover { background: var(--main-brown); color: #fff; }


        /* 评论 */
        .comment-item { border-bottom: 1px solid #eee; padding: 20px 0; display: flex; gap: 15px; }
        .comment-avatar { width: 45px; height: 45px; border-radius: 50%; }
        .comment-info { flex: 1; }
        .comment-user { font-weight: bold; font-size: 14px; color: var(--main-brown); display: flex; justify-content: space-between; }
        .comment-text { margin-top: 8px; font-size: 14px; color: #666; }

        .footer { background: var(--dark-brown); color: #999; padding: 40px 0; text-align: center; font-size: 13px; }
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
                <div class="user-avatar"><img src="images/user.jpg"></div>
                <span><%= loginUser.getUsername() %></span>
                <a href="personalCenter.jsp">个人中心</a>
                <a href="logout">退出</a>
            </div>
            <% } else { %>
            <div class="nav-user"><a href="login.jsp">登录 / 注册</a></div>
            <% } %>
        </div>
    </nav>

    <div class="breadcrumb">
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 传统建筑文化
    </div>

    <header class="detail-header">
        <div class="header-content">
            <h1>中国传统建筑文化</h1>
            <div class="stats-bar">
                <span class="stat-tag">🏮 传统技艺</span>
                <span class="stat-tag">👤 传承人：吴建筑师</span>
                <span class="stat-tag">👁️ 浏览：3,240</span>
                <span class="stat-tag">❤️ 收藏：512</span>
                <span class="stat-tag">⭐ 评分：4.95</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <img src="images/建筑.jpeg" class="main-img" alt="中国建筑">
                
                <div class="section-title">🏯 项目起源</div>
                <p class="text-content">
                    中国传统建筑文化起源于原始社会的穴居与巢居，经过数千年的演变，形成了以木构架为核心的独特体系。从宫殿、寺庙到民间民居，传统建筑不仅是遮风避雨的场所，更是天人合一、等级制度与家族观念的物质体现，是“凝固的诗，立体的画”。
                </p>

                <div class="section-title">🧱 艺术特色</div>
                <p class="text-content">
                    传统建筑最大的特色在于“榫卯结构”，这种不用一颗铁钉的连接方式，展现了极高的力学智慧。此外，“中轴对称”的布局展现了庄严与秩序，而飞檐翘角、斗拱装饰则赋予了建筑轻盈灵动的动态感。无论是“红墙金瓦”的皇家气派，还是“白墙黛瓦”的江南韵味，都体现了独特的东方美学。
                </p>

                <div class="section-title">📐 建筑赏析</div>
                <div class="gallery-grid">
                    <div class="gallery-item"><img src="images/斗拱.jpeg"><p>斗拱结构</p></div>
                    <div class="gallery-item"><img src="images/飞檐.jpeg"><p>飞檐艺术</p></div>
                    <div class="gallery-item"><img src="images/园林.jpeg"><p>园林布局</p></div>
                </div>
            </div>

            <div class="content-card">
                <div class="section-title">💬 专家解读</div>
                <div class="comment-item">
                    <img src="images/user1.webp" class="comment-avatar">
                    <div class="comment-info">
                        <div class="comment-user">建筑师小梁 <span class="comment-date">2025-12-10</span></div>
                        <div style="color:#F1C40F; font-size:12px;">★★★★★</div>
                        <div class="comment-text">传统建筑的精髓在于它对自然的敬畏，这种结构之美是现代建筑难以替代的。</div>
                    </div>
                </div>
            </div>
            
        </div>

        <div class="right-col">
            <div class="side-card">
                <div style="font-weight:bold; margin-bottom:10px;">❤️ 关注建筑</div>
                <p style="font-size:12px; color:#999; margin-bottom:10px;">点击下方按钮收藏到个人中心</p>
                <button class="side-btn">⭐ 收藏此项目</button>
            </div>

            <div class="side-card">
                <div class="section-title" style="font-size:15px; justify-content:center;">👤 传承人</div>
                <img src="images/吴建筑师.jpg" class="inheritor-avatar">
                <p style="font-weight:bold;">吴建筑师</p>
                <p style="font-size:12px; color:#888; margin: 10px 0;">古建筑修复专家，营造法式研究员</p>
                <a href="inheritor-building.jsp" class="side-btn">查看详情</a>
            </div>
        </div>
        
        
        
    </div>

    <footer class="footer">
        <p>© 2025 非遗文化传承平台 版权所有 | 传承文化 守护经典</p>
    </footer>

</body>
</html>