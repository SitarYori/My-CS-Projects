<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>中医传统疗法 - 非遗详情</title>
    <style>
        /* 1. 中医主题品牌色系 */
        :root {
            --main-brown: #8B4513;     /* 顶部导航深褐 */
            --dark-brown: #5D2E0C;     /* 标题色 */
            --accent-gold: #F1C27D;    /* 装饰金 */
            --herbal-green: #2E7D32;   /* 草本绿 */
            --light-bg: #FDF5E6;       /* 全局背景色 */
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: var(--light-bg); color: #333; line-height: 1.6; }

        /* 2. 顶部导航栏 */
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

        /* 3. 面包屑导航 */
       .breadcrumb { width: 1100px; margin: 20px auto; font-size: 13px; color: #888; }
        .breadcrumb a { color: #888; text-decoration: none; transition: 0.3s; }
        .breadcrumb a:hover { color: var(--main-brown); }

        /* 4. 详情页头部 Banner */
        .detail-header { background-color: var(--main-brown); color: #fff; padding: 40px 0; margin-bottom: 30px; }
        .header-content { width: 1100px; margin: 0 auto; }
        .header-content h1 { font-size: 32px; margin-bottom: 15px; letter-spacing: 2px; }
        .stats-bar { display: flex; gap: 20px; font-size: 14px; opacity: 0.9; }
        .stat-tag { background: rgba(255,255,255,0.15); padding: 4px 12px; border-radius: 4px; border: 1px solid rgba(255,255,255,0.2);  transition: all 0.2s ease; /* 新增：过渡动画 */}
        .stat-tag:hover { /* 新增：悬浮高亮 */background: rgba(255,255,255,0.25); border-color: rgba(255,255,255,0.4); }
        
        /* 5. 主体布局 */
        .main-layout { width: 1100px; margin: 30px auto; display: grid; grid-template-columns: 1fr 320px; gap: 30px; padding-bottom: 60px; }
        
        .content-card { background: #fff; border-radius: 8px; padding: 40px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border: 1px solid #eee; }
        .main-img-wrapper { text-align: center; margin-bottom: 30px; border: 1px solid #E0E0E0; padding: 10px; border-radius: 4px; }
        .main-img { width: 100%; border-radius: 4px; }

        .section-title { 
            font-size: 22px; 
            color: var(--herbal-green); 
            border-bottom: 2px solid var(--herbal-green); 
            padding-bottom: 8px; 
            margin: 35px 0 20px; 
            font-weight: bold;
        }
        .text-body { font-size: 16px; color: #444; text-indent: 2em; margin-bottom: 20px; line-height: 1.8; }

        /* 6. 作品/疗法赏析网格 */
        .gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin-top: 20px; }
        .gallery-item { border: 1px solid #f0f0f0; padding: 10px; background: #fff; text-align: center; border-radius: 5px; }
        .gallery-item img { width: 100%; height: 160px; object-fit: cover; border-radius: 3px; }
        .gallery-item p { margin-top: 10px; font-size: 15px; color: var(--herbal-green); font-weight: bold; }

        /* 7. 右侧侧边栏 */
        .side-card { background: #fff; border-radius: 8px; padding: 25px; border: 1px solid #EBD9B4; margin-bottom: 20px; text-align: center; }
        .avatar { width: 90px; height: 90px; border-radius: 50%; border: 2px solid var(--herbal-green); margin-bottom: 12px; }
        .btn-side { display: block; width: 100%; padding: 10px; background: var(--herbal-green); color: #fff; text-decoration: none; border-radius: 4px; margin-top: 10px; font-family: "Microsoft YaHei"; }
		.side-btn { display: block; width: 100%; padding: 10px; margin-top: 15px; border: 1px solid var(--main-brown); color: var(--main-brown); text-decoration: none; border-radius: 4px; font-size: 14px; transition: 0.3s; }
        .side-btn:hover { background: var(--main-brown); color: #fff; }


        /* 8. 页脚 */
        .footer { background: var(--dark-brown); color: #999; padding: 30px 0; text-align: center; font-size: 13px; font-family: "Microsoft YaHei"; }
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

    <div class="breadcrumb">
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 中医传统疗法
    </div>

    <header class="detail-header">
        <div class="header-content">
            <h1>中医传统疗法</h1>
            <div class="stats-bar">
                <span class="stat-tag">🌿 传统医药</span>
                <span class="stat-tag">👤 传承人：张老医师</span>
                <span class="stat-tag">👁️ 浏览：945</span>
                <span class="stat-tag">❤️ 收藏：298</span>
                <span class="stat-tag">⭐ 评分：4.8</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <div class="main-img-wrapper">
                    <img src="images/中医.jpg" class="main-img" alt="中医艺术">
                </div>
                
                <div class="section-title">🌿 项目起源</div>
                <p class="text-body">
                    中医传统疗法植根于博大精深的中华文明，已有数千年的历史。从《黄帝内经》到《本草纲目》，中医形成了完整的理论体系。传统疗法不仅仅是治病的技术，更是“天人合一”哲学思想的实践，强调通过调理阴阳平衡来实现身体的康复与养生。
                </p>

                <div class="section-title">📜 艺术特色</div>
                <p class="text-body">
                    中医传统疗法的特色在于“辨证论治”与“内外兼修”。它包含了针灸、拔罐、推拿、艾灸等多种非药物手段。艺人们（医师）通过经络理论，通过指法、针法或药石，调动人体自身的修复能力。其精髓在于其自然性、整体性以及对生命本质的深刻领悟。
                </p>

                <div class="section-title">🏥 疗法赏析</div>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="images/针灸.jpg" alt="针灸">
                        <p>针灸疗法</p>
                    </div>
                    <div class="gallery-item">
                        <img src="images/拔罐.png" alt="拔罐">
                        <p>传统拔罐</p>
                    </div>
                    <div class="gallery-item">
                        <img src="images/艾灸.jpg" alt="艾灸">
                        <p>温和艾灸</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="right-col">
        
        <div class="side-card">
                <div style="font-size:15px; font-weight:bold; margin-bottom:15px; border-bottom:1px solid #eee; padding-bottom:10px;">❤️ 收藏项目</div>
                <p style="font-size:12px; color:#999; margin-bottom:10px;">点击下方按钮收藏到个人中心</p>
                <button class="side-btn" style="background:#FDF5E6">⭐ 点击收藏</button>
            </div>
            
            <div class="side-card">
                <h4 style="color:var(--herbal-green); border-bottom:1px solid #eee; padding-bottom:10px;">👤 传承人信息</h4>
                <div style="margin-top:15px;">
                    <img src="images/杨医生.jpg" class="avatar">
                    <p style="font-weight:bold; font-size:18px;">杨老医师</p>
                    <p style="font-size:13px; color:#777; margin: 10px 0;">国家级中医非遗传承人</p>
                    <a href="inheritor-zhongyi.jsp" class="btn-side">了解传承人</a>
                </div>
            </div>

            <div class="side-card">
                <h4 style="margin-bottom:15px;">📖 养生建议</h4>
                <p style="font-size:13px; color:#888; margin-bottom:15px;">春生夏长，秋收冬藏。中医讲究顺应节气，欢迎咨询更多传统养生知识。</p>

            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2025 非遗文化传承平台 版权所有 | 传承文化 守护经典</p>
    </footer>

</body>
</html>