<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人详情 - 非遗文化传承平台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background-color: #FDF5E6; margin: 0; color: #333; }
        .container { width: 1100px; margin: 40px auto; display: flex; gap: 30px; }
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
        
        /* 左侧传承人核心信息 */
        .main-content { flex: 2; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .header-section { border-bottom: 1px solid #eee; margin-bottom: 30px; padding-bottom: 20px; }
        .inheritor-name { font-size: 32px; color: #8B4513; margin: 0; }
        .meta-info { margin-top: 15px; color: #999; font-size: 14px; display: flex; gap: 20px; }
        
        .intro-box { line-height: 1.8; color: #555; text-indent: 2em; margin-bottom: 30px; }
        .inheritor-photo { width: 100%; border-radius: 10px; margin: 20px 0; border: 1px solid #eee; }

        /* 标签样式 */
        .tag-container { margin-top: 20px; display: flex; gap: 10px; flex-wrap: wrap; }
        .tag { background: #FFF8DC; color: #8B4513; padding: 5px 15px; border-radius: 20px; font-size: 13px; border: 1px solid #EEDC82; }

        /* 右侧侧边栏 */
        .sidebar { flex: 1; display: flex; flex-direction: column; gap: 25px; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .side-title { font-size: 18px; color: #8B4513; border-left: 4px solid #8B4513; padding-left: 10px; margin-bottom: 20px; }
        
        .work-item { display: flex; gap: 15px; margin-bottom: 15px; text-decoration: none; color: inherit; }
        .work-img { width: 80px; height: 60px; border-radius: 5px; object-fit: cover; }
        .work-title { font-size: 14px; font-weight: bold; color: #333; margin-bottom: 5px; }
        .work-desc { font-size: 12px; color: #999; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }

        /* 统计数据 */
        .stats { display: flex; justify-content: space-around; margin-top: 20px; border-top: 1px solid #eee; padding-top: 20px; }
        .stat-item { text-align: center; }
        .stat-num { display: block; font-size: 20px; font-weight: bold; color: #8B4513; }
        .stat-label { font-size: 12px; color: #999; }
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
        <div class="main-content">
            <div class="header-section">
                <h1 class="inheritor-name">姚建萍：苏绣艺术的创新领军人</h1>
                <div class="meta-info">
                    <span><i class="fas fa-user-tie"></i> 国家级非遗传承人</span>
                    <span><i class="fas fa-map-marker-alt"></i> 江苏·苏州</span>
                    <span><i class="far fa-eye"></i> 9851 阅读</span>
                </div>
            </div>

            <div class="intro-box">
                <p>姚建萍是国家级非遗（苏绣）代表性传承人，出生于苏绣世家，从事苏绣艺术四十余年。其作品以“平、光、齐、匀、和、顺、细、密”为特色，独创的“双面乱针绣”技法屡获国际大奖，将现代艺术与传统苏绣融合，被誉为“针尖上的艺术家”。</p>
                <img src="images/姚建萍.png" class="inheritor-photo" alt="姚大师在创作">
                <p>苏绣作为中国四大名绣之首，其针法精细、色彩雅致。姚大师通过针线的交织，展现了江南水乡的独特韵味，被誉为“针尖上的魔术师”。</p>
            </div>

            <div class="tag-container">
                <span class="tag">苏州刺绣</span>
                <span class="tag">传统工艺</span>
                <span class="tag">江南文化</span>
                <span class="tag">手工艺术</span>
            </div>
            
            <div class="stats">
                <div class="stat-item"><span class="stat-num">42</span><span class="stat-label">代表作品</span></div>
                <div class="stat-item"><span class="stat-num">15</span><span class="stat-label">获奖荣誉</span></div>
                <div class="stat-item"><span class="stat-num">120</span><span class="stat-label">授课学时</span></div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">代表作品</div>
                
                <a href="#" class="work-item">
                    <img src="images/荷花掠影.png" class="work-img">
                    <div>
                        <div class="work-title">《荷光掠影》</div>
                        <div class="work-desc">以虚实结合的针法勾勒荷花光影，将水墨意境与苏绣细腻质感融合。</div>
                    </div>
                </a>

                <a href="#" class="work-item">
                    <img src="images/牡丹图.png" class="work-img">
                    <div>
                        <div class="work-title">乱针绣《牡丹图》</div>
                        <div class="work-desc">新乱针绣技法的经典作品，花瓣层次立体，色彩过渡自然，尽显苏绣灵动之美。</div>
                    </div>
                </a>
            </div>

            <div class="side-card">
                <div class="side-title">相关视频课程</div>
                <p style="font-size: 14px; color: #666;">大师亲授，从零基础学习苏绣技法。</p>
                <button style="width: 100%; padding: 10px; background: #8B4513; color: white; border: none; border-radius: 5px; cursor: pointer;">
                    前往在线课堂
                </button>
            </div>
        </div>
    </div>

</body>
</html>