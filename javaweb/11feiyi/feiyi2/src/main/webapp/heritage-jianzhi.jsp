<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>传统剪纸艺术 - 非遗详情</title>
    <style>
        /* 全局品牌色系 */
        :root {
            --main-brown: #8B4513;     /* 顶部导航深褐 */
            --dark-brown: #5D2E0C;     /* 内容标题褐 */
            --accent-gold: #F1C27D;    /* 装饰金 */
            --paper-red: #D32F2F;      /* 剪纸主题红 */
            --light-bg: #FDF5E6;       /* 全局宣纸色背景 */
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: var(--light-bg); color: #333; line-height: 1.6; }

        /* 顶部导航栏 */
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

        /* 面包屑导航 */
        .breadcrumb { width: 1100px; margin: 20px auto; font-size: 13px; color: #888; font-family: "Microsoft YaHei"; }
        .breadcrumb a { color: #888; text-decoration: none; }

        /* 详情页头部 Banner */
        .detail-header { background-color: var(--main-brown); color: #fff; padding: 40px 0; margin-bottom: 30px; }
        .header-content { width: 1100px; margin: 0 auto; }
        .header-content h1 { font-size: 32px; margin-bottom: 15px; letter-spacing: 2px; }
        .stats-bar { display: flex; gap: 20px; font-size: 14px; opacity: 0.9; }
        .stat-tag { background: rgba(255,255,255,0.15); padding: 4px 12px; border-radius: 4px; border: 1px solid rgba(255,255,255,0.2);  transition: all 0.2s ease; /* 新增：过渡动画 */}
        .stat-tag:hover { /* 新增：悬浮高亮 */background: rgba(255,255,255,0.25); border-color: rgba(255,255,255,0.4); }
        
        /* 主体布局 */
        .main-layout { width: 1100px; margin: 30px auto; display: grid; grid-template-columns: 1fr 320px; gap: 30px; padding-bottom: 60px; }
        
        /* 左侧内容区 */
        .content-card { background: #fff; border-radius: 8px; padding: 40px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border: 1px solid #eee; }
        .main-img-wrapper { text-align: center; margin-bottom: 30px; padding: 10px; border: 1px dashed var(--paper-red); }
        .main-img { width: 100%; border-radius: 4px; }

        .section-title { 
            font-size: 22px; 
            color: var(--paper-red); 
            border-bottom: 2px solid var(--paper-red); 
            padding-bottom: 8px; 
            margin: 35px 0 20px; 
            font-weight: bold;
        }
        .text-body { font-size: 16px; color: #444; text-indent: 2em; margin-bottom: 20px; line-height: 1.8; }

        /* 作品赏析网格 */
        .gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin-top: 20px; }
        .gallery-item { border: 1px solid #f0f0f0; padding: 8px; background: #fff; text-align: center; }
        .gallery-item img { width: 100%; height: 160px; object-fit: cover; border-radius: 2px; }
        .gallery-item p { margin-top: 8px; font-size: 14px; color: var(--paper-red); font-weight: bold; }

        /* 右侧侧边栏 */
        .side-card { background: #fff; border-radius: 8px; padding: 25px; border: 1px solid #EBD9B4; margin-bottom: 20px; text-align: center; }
        .avatar { width: 90px; height: 90px; border-radius: 50%; border: 2px solid var(--paper-red); margin-bottom: 12px; }
        .btn-side { display: block; width: 100%; padding: 10px; background: var(--paper-red); color: #fff; text-decoration: none; border-radius: 4px; margin-top: 10px; font-family: "Microsoft YaHei"; }

        /* 页脚 */
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
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 传统剪纸艺术
    </div>

    <header class="detail-header">
        <div class="header-content">
            <h1>中国传统剪纸艺术</h1>
            <div class="stats-bar">
                <span class="stat-tag">✂️ 民间工艺</span>
                <span class="stat-tag">👤 传承人：王老师</span>
                <span class="stat-tag">👁️ 浏览：380</span>
                <span class="stat-tag">⭐ 评分：4.7</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <div class="main-img-wrapper">
                    <img src="images/剪纸.jpeg" class="main-img" alt="剪纸主图">
                </div>
                
                <div class="section-title">✂️ 项目起源</div>
                <p class="text-body">
                    中国剪纸是一种用剪刀或刻刀在纸上剪刻花纹，用于装点生活或配合其他民俗活动的民间艺术。其历史可追溯至汉、唐时代，这种“镂空艺术”在视觉上给人以透空的感觉和艺术享受，是中国农村群众中最为流行的民间艺术形式之一。
                </p>

                <div class="section-title">🎨 艺术特色</div>
                <p class="text-body">
                    剪纸艺术讲究“线条连贯，图案对称”。艺人们凭借一把剪刀，便能在方寸纸张间展现大千世界。其艺术特色在于通过“虚实结合”的镂空技术，将花鸟鱼虫、民间传说等题材具象化。线条圆如秋月、尖如麦芒、缺如锯齿、细如胡须，具有极强的装饰性和节奏感。
                </p>

                <div class="section-title">🖼️ 作品赏析</div>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="images/龙凤呈祥.jpeg" alt="作品1">
                        <p>《龙凤呈祥》</p>
                    </div>
                    <div class="gallery-item">
                        <img src="images/喜鹊登梅.jpeg" alt="作品2">
                        <p>《喜鹊登梅》</p>
                    </div>
                    <div class="gallery-item">
                        <img src="images/年年有余.jpeg" alt="作品3">
                        <p>《年年有余》</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="right-col">
            <div class="side-card">
                <h4 style="color:var(--paper-red); border-bottom:1px solid #eee; padding-bottom:10px;">👤 传承人信息</h4>
                <div style="margin-top:15px;">
                    <img src="images/王老师.jpg" class="avatar">
                    <p style="font-weight:bold; font-size:18px;">王老师</p>
                    <p style="font-size:13px; color:#777; margin: 10px 0;">市级非遗代表性传承人</p>
                    <a href="inheritor-jianzhi.jsp" class="btn-side">了解传承人</a>
                </div>
            </div>

            <div class="side-card">
                <h4 style="margin-bottom:15px;">❤️ 互动参与</h4>
                <a href="favorite?action=toggle&heritageId=${h.id}" 
                class="btn-side" style="background:none; border:1px solid var(--paper-red); color:var(--paper-red);">⭐ 收藏本项目</a>
                <a href="#" class="btn-side" style="margin-top:10px;">💬 查看用户评价</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2025 非遗文化传承平台 版权所有 | 传承文化 守护经典</p>
    </footer>

</body>
</html>