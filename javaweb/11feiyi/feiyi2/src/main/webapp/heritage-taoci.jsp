<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>景德镇陶瓷制作 - 非遗文化传承</title>
    <style>
        /* 全局样式复用与主题定制 */
        :root {
            --clay-brown: #5D2E0C;      /* 泥土棕 */
            --porcelain-blue: #003399;   /* 青花蓝 */
            --paper-white: #FDF5E6;     /* 宣纸白 */
            --accent-gold: #F1C27D;      /* 装饰金 */
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: var(--paper-white); color: #333; }

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

  		/* 面包屑导航 */
        .breadcrumb { width: 1100px; margin: 20px auto; font-size: 13px; color: #888; }
        .breadcrumb a { color: #888; text-decoration: none; transition: 0.3s; }
        .breadcrumb a:hover { color: var(--main-brown); }


        /* 顶部通栏 - 使用陶瓷主题背景 */
        .detail-header { 
            background: linear-gradient(rgba(93, 46, 12, 0.85), rgba(93, 46, 12, 0.85)), 
                        url('images/taoci-bg.jpg'); /* 建议放一张陶瓷纹理背景图 */
            background-size: cover;
            color: #fff; 
            padding: 60px 0; 
            border-bottom: 4px solid var(--accent-gold); 
        }
        .header-content { width: 1100px; margin: 0 auto; }
        .header-content h1 { font-size: 32px; margin-bottom: 15px; letter-spacing: 2px; }
        .stats-bar { display: flex; gap: 20px; font-size: 14px; opacity: 0.9; }
        .stat-tag { background: rgba(255,255,255,0.15); padding: 4px 12px; border-radius: 4px; border: 1px solid rgba(255,255,255,0.2);  transition: all 0.2s ease; /* 新增：过渡动画 */}
        .stat-tag:hover { /* 新增：悬浮高亮 */background: rgba(255,255,255,0.25); border-color: rgba(255,255,255,0.4); }
        
        /* 布局 */
        .main-layout { width: 1100px; margin: 30px auto; display: grid; grid-template-columns: 1fr 320px; gap: 30px; }
        .content-card { background: #fff; border-radius: 12px; padding: 40px; box-shadow: 0 8px 25px rgba(0,0,0,0.05); }
        .main-img { width: 80%; border-radius: 8px; margin-bottom: 30px; border: 1px solid #eee; }
        
        .section-title { 
            font-size: 22px; 
            color: var(--clay-brown); 
            border-left: 6px solid var(--clay-brown); 
            padding-left: 15px; 
            margin: 35px 0 20px; 
            font-weight: bold; 
        }
        .text-body { font-size: 16px; line-height: 2; text-indent: 2em; color: #444; }

        /* 陶瓷工序展示 - 特色模块 */
        .process-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-top: 20px; }
        .process-item { text-align: center; font-size: 14px; color: var(--clay-brown); }
        .process-item img { width: 100%; border-radius: 5px; margin-bottom: 8px; filter: grayscale(20%); transition: 0.3s; }
        .process-item img:hover { filter: grayscale(0); transform: translateY(-5px); }

        /* 右侧侧边栏 */
        .side-box { background: #fff; border-radius: 12px; padding: 25px; margin-bottom: 25px; border-top: 4px solid var(--clay-brown); }
        .avatar { width: 90px; height: 90px; border-radius: 50%; border: 3px solid var(--accent-gold); margin: 0 auto 15px; display: block; }
        .btn-action { display: block; width: 100%; padding: 12px; background: var(--clay-brown); color: #fff; text-decoration: none; border-radius: 6px; text-align: center; transition: 0.3s; }
        .btn-action:hover { background: #3d1e08; }
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
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 醴陵釉陶瓷制作
    </div>
    <header class="detail-header">
        <div class="header-content">
            <h1 style="font-size: 36px; letter-spacing: 2px;">醴陵釉下五彩瓷</h1>
            <div class="stats-bar">
                <span class="stat-tag">🏺 民间工艺</span>
                <span class="stat-tag" "images/i1.jpg">👤 传承人：陈师傅</span>
                <span class="stat-tag">👁️ 浏览量：534</span>
                <span class="stat-tag">⭐ 评分：4.5</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <img src="images/万紫千红.png" class="main-img" alt="醴陵釉陶瓷">
                
                <div class="section-title">项目介绍</div>
                <p class="text-body">
                    醴陵釉下五彩瓷以“薄施淡染”为核核心，色彩淡雅清新，釉面光洁洁莹润，陈利大师将现代审美融入传统技艺。
                </p>

                <div class="section-title">制作工序</div>
                <p class="text-body" style="margin-bottom: 20px;">
                    手工制瓷工序极其复杂，传统上有“七十二道工序”之说，主要包括拉坯、利坯、画坯、施釉和烧窑。
                </p>
                <div class="process-grid">
                    <div class="process-item"><img src="images/拉坯.jpg"><span>拉坯成型</span></div>
                    <div class="process-item"><img src="images/绘画.jpg"><span>手工绘画</span></div>
                    <div class="process-item"><img src="images/吹釉.jpg"><span>吹釉工法</span></div>
                    <div class="process-item"><img src="images/柴烧.jpg"><span>柴窑烧制</span></div>
                </div>

                <div class="section-title">历史价值</div>
                <p class="text-body">
                    醴陵种下五彩瓷是中国陶瓷文化瑰宝，陈利大师作品被中国国家博物馆收藏，推动非遗创新传承。
                </p>
            </div>
        </div>

        <div class="right-col">
            <div class="side-box">
                <h3 style="color:var(--clay-brown); margin-bottom:15px; text-align:center;">传承人信息</h3>
                <img src="images/陈师傅.jpg" class="avatar">
                <p style="text-align:center; font-weight:bold; font-size:18px;">陈师傅</p>
                <p style="font-size:14px; color:#666; line-height:1.6; margin:10px 0;">
                    国家级非遗传承人，1968年生于湖南醒陵陶瓷世家，从事醒陵釉下五彩瓷烧制技艺三十余载，精通“薄施淡染”技法与釉下复合色料研制
                </p>
                <a href="inheritor-taoci.jsp?id=chen" class="btn-action">查看传承人详情</a>
            </div>

            <div class="side-box">
                <h3 style="margin-bottom:15px; text-align:center;">互动参与</h3>
                <p style="font-size:13px; color:#888; margin-bottom:10px;">对此项目感兴趣？</p>
                <a href="#" class="btn-action" style="background:#fff; color:var(--clay-brown); border:1px solid var(--clay-brown);">❤️ 收藏该项目</a>
                <a href="#" class="btn-action" style="margin-top:10px;">✍️ 发表评论</a>
            </div>
        </div>
    </div>

</body>
</html>