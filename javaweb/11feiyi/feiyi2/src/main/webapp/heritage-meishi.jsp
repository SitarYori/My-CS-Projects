<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>传统美食制作 - 非遗项目详情</title>
    <style>
        :root {
            --main-brown: #A0522D;     /* 赭石色，更有烟火气 */
            --dark-brown: #5D2E0C;
            --accent-gold: #F1C27D;
            --food-orange: #E67E22;    /* 美食主题橙 */
            --light-bg: #FDF5E6;
            --border-color: #EBD9B4;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: var(--light-bg); color: #333; line-height: 1.6; }

        /* 导航栏 */
        .top-nav { background-color: var(--dark-brown); color: #fff; padding: 15px 0; }
        .nav-container { width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .nav-logo { font-size: 22px; font-weight: bold; color: var(--accent-gold); }
        .nav-menu { display: flex; gap: 25px; }
        .nav-menu a { color: #fff; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .nav-menu a:hover, .nav-menu a.active { color: var(--accent-gold); text-decoration: underline; }
        
        .nav-user { display: flex; align-items: center; gap: 12px; padding: 6px 15px; border: 1px solid var(--accent-gold); border-radius: 20px; background: rgba(255,255,255,0.1); }
        .user-avatar { width: 28px; height: 28px; border-radius: 50%; overflow: hidden; border: 1px solid var(--accent-gold); }
        .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .nav-user a { font-size: 13px; color: #fff; text-decoration: none; margin-left: 5px; }

        /* 面包屑 */
        .breadcrumb { width: 1100px; margin: 20px auto; font-size: 13px; color: #888; }
        .breadcrumb a { color: #888; text-decoration: none; }

        /* Banner */
        .detail-header { background-color: var(--main-brown); color: #fff; padding: 40px 0; margin-bottom: 30px; }
        .header-content { width: 1100px; margin: 0 auto; }
        .header-content h1 { font-size: 32px; margin-bottom: 15px; letter-spacing: 2px; }
        .stats-bar { display: flex; gap: 20px; font-size: 14px; opacity: 0.9; }
        .stat-tag { background: rgba(255,255,255,0.15); padding: 4px 12px; border-radius: 4px; border: 1px solid rgba(255,255,255,0.2); }

        /* 主体布局 */
        .main-layout { width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 1fr 300px; gap: 30px; padding-bottom: 60px; }

        /* 左侧 */
        .content-card { background: #fff; border-radius: 8px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 25px; border: 1px solid #f0f0f0; }
        .section-title { font-size: 18px; font-weight: bold; color: var(--main-brown); margin-bottom: 20px; display: flex; align-items: center; gap: 10px; border-bottom: 2px solid var(--light-bg); padding-bottom: 10px; }
        .main-img { width: 100%; border-radius: 6px; margin-bottom: 25px; border: 5px solid #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .text-content { font-size: 15px; color: #555; text-indent: 2em; margin-bottom: 20px; text-align: justify; }

        /* 图片赏析网格 */
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
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 传统美食制作
    </div>

    <header class="detail-header">
        <div class="header-content">
            <h1>传统美食制作技艺</h1>
            <div class="stats-bar">
                <span class="stat-tag">🥘 传统技艺</span>
                <span class="stat-tag">👤 传承人：马大厨</span>
                <span class="stat-tag">👁️ 浏览：2,105</span>
                <span class="stat-tag">❤️ 收藏：342</span>
                <span class="stat-tag">⭐ 评分：4.90</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <img src="images/美食技艺.png" class="main-img" alt="美食技艺">
                
                <div class="section-title">🍳 项目起源</div>
                <p class="text-content">
                    中国传统美食制作技艺是劳动人民在数千年的生产生活中创造的饮食文化。从火的利用到复杂的烹饪技法，美食不仅是维持生存的能量来源，更是礼仪、节庆和情感寄托的重要载体。各地的气候与食材造就了八大菜系及数不胜数的民间小吃。
                </p>

                <div class="section-title">🍱 艺术特色</div>
                <p class="text-content">
                    传统美食制作讲究“色、香、味、形、器”五位一体。技艺特色在于对火候的精准掌控、精妙的刀工处理以及秘制的调味配方。它强调“药食同源”的健康理念，通过炸、熘、爆、炒、烩、炖等数十种技法，展现出中华饮食文化的博大精深。
                </p>

                <div class="section-title">🖼️ 美食赏析</div>
                <div class="gallery-grid">
                    <div class="gallery-item"><img src="images/刀工展示.png"><p>刀工展示</p></div>
                    <div class="gallery-item"><img src="images/烹饪火候.png"><p>烹饪火候</p></div>
                    <div class="gallery-item"><img src="images/成品摆盘.png"><p>成品摆盘</p></div>
                </div>
            </div>

            <div class="content-card">
                <div class="section-title">💬 用户点评</div>
                <div class="comment-item">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Foodie" class="comment-avatar">
                    <div class="comment-info">
                        <div class="comment-user">食神小王 <span class="comment-date">2025-11-20</span></div>
                        <div style="color:#F1C40F; font-size:12px;">★★★★★</div>
                        <div class="comment-text">这不仅是食物，更是艺术！希望能把这些传统味道传承下去。</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="right-col">
            <div class="side-card">
                <div style="font-weight:bold; margin-bottom:10px;">❤️ 收藏味道</div>
                <button class="side-btn">⭐ 收藏此项目</button>
            </div>

            <div class="side-card">
                <div class="section-title" style="font-size:15px; justify-content:center;">👤 传承人</div>
                <img src="images/马厨师.jpg" class="inheritor-avatar">
                <p style="font-weight:bold;">马大厨</p>
                <p style="font-size:12px; color:#888; margin: 10px 0;">特级厨师，非遗鲁菜技艺传承人</p>
                <a href="inheritor-food.jsp" class="side-btn">查看详情</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2025 非遗文化传承平台 版权所有 | 传承文化 守护经典</p>
    </footer>

</body>
</html>