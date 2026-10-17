<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>民间文学传说 - 非遗项目详情</title>
    <style>
        :root {
            --ink-blue: #2C3E50;       /* 墨蓝色，象征文人墨客 */
            --dark-brown: #5D2E0C;     /* 深炭黑 */
            --accent-gold: #D4AF37;    /* 古铜金 */
            --light-bg: #F9F4E8;       /* 仿古宣纸色 */
            --border-color: #E0D5B7;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: var(--light-bg); color: #333; line-height: 1.6; }

        /* 导航栏复用 */
        .top-nav { background-color: var(--dark-brown); color: #fff; padding: 15px 0; border-bottom: 2px solid var(--accent-gold); }
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
        .breadcrumb a { color: #888; text-decoration: none; transition: 0.3s; }
        .breadcrumb a:hover { color: var(--main-brown); }

        /* Banner */
        .detail-header { background-color: var(--ink-blue); color: #fff; padding: 40px 0; margin-bottom: 30px; }
        .header-content { width: 1100px; margin: 0 auto; }
        .header-content h1 { font-size: 32px; margin-bottom: 15px; letter-spacing: 2px; font-family: "微软雅黑", "黑体"; }
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

        /* 传说赏析网格 */
        .gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin-top: 20px; }
        .gallery-item { text-align: center; }
        .gallery-item img { width: 100%; height: 180px; object-fit: cover; border-radius: 4px; filter: sepia(20%); }
        .gallery-item p { margin-top: 8px; font-size: 14px; color: var(--ink-blue); font-weight: bold; }

        /* 右侧 */
        .side-card { background: #fff; border-radius: 8px; padding: 25px; border: 1px solid var(--border-color); margin-bottom: 20px; text-align: center; }
        .inheritor-avatar { width: 80px; height: 80px; border-radius: 50%; border: 2px solid var(--accent-gold); margin-bottom: 15px; }
        .side-btn { display: block; width: 100%; padding: 10px; margin-top: 15px; border: 1px solid var(--ink-blue); color: var(--ink-blue); text-decoration: none; border-radius: 4px; font-size: 14px; }
        .side-btn:hover { background: var(--ink-blue); color: #fff; }

		/* 评论 */
        .comment-item { border-bottom: 1px solid #eee; padding: 20px 0; display: flex; gap: 15px; }
        .comment-avatar { width: 45px; height: 45px; border-radius: 50%; }
        .comment-info { flex: 1; }
        .comment-user { font-weight: bold; font-size: 14px; color: var(--main-brown); display: flex; justify-content: space-between; }
        .comment-text { margin-top: 8px; font-size: 14px; color: #666; }

        .footer { background: var(--dark-brown); color: #777; padding: 40px 0; text-align: center; font-size: 13px; }
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
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 民间文学传说
    </div>

    <header class="detail-header">
        <div class="header-content">
            <h1>中国民间文学传说</h1>
            <div class="stats-bar">
                <span class="stat-tag">📚 民间文学</span>
                <span class="stat-tag">👤 讲述人：苏先生</span>
                <span class="stat-tag">👁️ 浏览：1,890</span>
                <span class="stat-tag">❤️ 收藏：276</span>
                <span class="stat-tag">⭐ 评分：4.88</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <img src="images/民间文学.png" class="main-img" alt="民间文学">
                
                <div class="section-title">📖 项目起源</div>
                <p class="text-content">
                    民间文学传说起源于人类最早的口头语言艺术，是民族智慧与情感的结晶。从远古的神话创世，到历史长河中的英雄史诗、民间轶事，这些故事在漫长的岁月中经由口耳相传，不断被丰富与重构。它们不仅是文学的源头，更是承载民族历史记忆、道德规范与文化基因的“活态”档案。
                </p>

                <div class="section-title">🖋️ 艺术特色</div>
                <p class="text-content">
                    民间文学的艺术特色在于其“集体创作性”与“变异性”。每一个故事在不同地域的讲述中都会融入当地的方言、习俗与风土人情。它擅长运用浪漫主义的想象与夸张，如《梁祝》的化蝶、《孟姜女》的哭长城，将质朴的生活真理升华为璀璨的艺术意象，具有极强的群众基础和生命力。
                </p>

                <div class="section-title">📜 经典传说赏析</div>
                <div class="gallery-grid">
                    <div class="gallery-item"><img src="images/白蛇传.jpeg"><p>《白蛇传》</p></div>
                    <div class="gallery-item"><img src="images/牛郎织女.png"><p>《牛郎织女》</p></div>
                    <div class="gallery-item"><img src="images/八仙过海.jpeg"><p>《八仙过海》</p></div>
                </div>
            </div>

            <div class="content-card">
                <div class="section-title">💬 读者感悟</div>
                <div class="comment-item">
                    <img src="images/user2.webp" class="comment-avatar">
                    <div class="comment-info">
                        <div class="comment-user">书虫小苏 <span class="comment-date">2025-12-15</span></div>
                        <div style="color:var(--accent-gold); font-size:12px;">★★★★★</div>
                        <div class="comment-text">小时候奶奶讲的故事，现在读来依然震撼。这是我们民族的根。</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="right-col">
            <div class="side-card">
                <div style="font-weight:bold; margin-bottom:10px;">❤️ 典藏故事</div>
                <button class="side-btn">⭐ 收藏此项目</button>
            </div>

            <div class="side-card">
                <div class="section-title" style="font-size:15px; justify-content:center;">👤 讲述人</div>
                <img src="https://api.dicebear.com/7.x/adventurer/svg?seed=Su" class="inheritor-avatar">
                <p style="font-weight:bold;">苏先生</p>
                <p style="font-size:12px; color:#888; margin: 10px 0;">民间文艺家协会会员，口头文学整理者</p>
                <a href="inheritor-detail.jsp" class="side-btn">查看详情</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2025 非遗文化传承平台 版权所有 | 传承文化 守护经典</p>
    </footer>

</body>
</html>