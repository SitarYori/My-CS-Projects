<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人 - 吴建筑师 (传统建筑营造)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 采用深灰、木棕与象牙白的建筑美学色调 */
        body { font-family: "Microsoft YaHei"; background-color: #F5F5F5; margin: 0; color: #333; }
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
      
        /* 左侧核心信息区 */
        .main-content { flex: 2; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
        .master-header { display: flex; align-items: flex-end; gap: 20px; border-bottom: 2px solid #5D4037; padding-bottom: 20px; }
        .master-name { font-size: 36px; color: #5D4037; margin: 0; font-family: "KaiTi"; }
        .master-title { font-size: 16px; color: #8D6E63; font-weight: bold; }

        /* 建筑营造展示图 */
        .image-container { position: relative; margin: 30px 0; border-radius: 10px; overflow: hidden; border: 1px solid #D7CCC8; }
        .master-img { width: 100%; display: block; }
        .info-point { position: absolute; background: rgba(93, 64, 55, 0.9); color: white; padding: 6px 15px; border-radius: 20px; font-size: 13px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .pt-joint { top: 25%; left: 45%; } /* 指向榫卯结构 */
        .pt-blueprint { bottom: 20%; right: 15%; } /* 指向设计图纸 */

        .bio-text { line-height: 2; color: #444; text-indent: 2em; font-size: 16px; }
        
        /* 营造技艺解析格 */
        .skill-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 30px; }
        .skill-item { background: #EFEBE9; padding: 20px; text-align: center; border-radius: 8px; border: 1px solid #D7CCC8; }
        .skill-item i { font-size: 26px; color: #5D4037; margin-bottom: 10px; }
        .skill-item h4 { margin: 5px 0; color: #5D4037; }

        /* 右侧边栏 */
        .sidebar { flex: 1; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .side-title { font-size: 18px; color: #5D4037; border-left: 5px solid #5D4037; padding-left: 12px; margin-bottom: 20px; font-weight: bold; }
        
        /* 修缮案例展示 */
        .case-item { margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .case-name { font-weight: bold; color: #3E2723; display: block; }
        .case-desc { font-size: 13px; color: #757575; margin-top: 5px; }

        .btn-action { width: 100%; padding: 12px; background: #5D4037; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; transition: 0.3s; }
        .btn-action:hover { background: #3E2723; }
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
            <div class="master-header">
                <h1 class="master-name">吴建筑师</h1>
                <span class="master-title">传统木结构营造技艺传承人 · 古建筑保护专家</span>
            </div>

            <div class="image-container">
                <img src="images/i8_detail.jpg" class="master-img" alt="吴建筑师工作照" onerror="this.src='https://via.placeholder.com/700x450?text=吴建筑师古建筑修缮现场'">
                <div class="info-point pt-joint">千变万化的榫卯智慧</div>
                <div class="info-point pt-blueprint">传统营造法式测绘</div>
            </div>

            <div class="bio-text">
                <p>吴建筑师，深耕中国传统木结构营造技艺三十余载。他主持修复了多处国家级文物保护单位，始终坚持“修旧如旧”的原则，力求还原中国古建筑最真实的历史面貌。他认为，一砖一瓦皆有灵性，一榫一卯尽显智慧。</p>
                <p>作为新一代古建筑保护者，他不仅掌握着传统的“营造法式”，更致力于利用数字化技术为古建筑建立永久的三维档案。他常说：“保护古建筑，就是保护我们民族的根脉。”</p>
            </div>

            

            <div class="skill-grid">
                <div class="skill-item">
                    <i class="fas fa-hammer"></i>
                    <h4>榫卯技艺</h4>
                    <p style="font-size:12px; color:#777;">不用一颗钉的结构奇迹</p>
                </div>
                <div class="skill-item">
                    <i class="fas fa-ruler-combined"></i>
                    <h4>测绘修复</h4>
                    <p style="font-size:12px; color:#777;">精准还原历史尺度</p>
                </div>
                <div class="skill-item">
                    <i class="fas fa-archway"></i>
                    <h4>营造法式</h4>
                    <p style="font-size:12px; color:#777;">传承千年建筑美学</p>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">重点修复工程</div>
                <div class="case-item">
                    <span class="case-name">《江南水乡古戏台》</span>
                    <p class="case-desc">攻克了复杂藻井结构的修复难题，重现百年戏台辉煌。</p>
                </div>
                <div class="case-item">
                    <span class="case-name">《明代书院阁楼》</span>
                    <p class="case-desc">采用传统大木作技法，完整修复了倾斜受损的承重系统。</p>
                </div>
            </div>

            <div class="side-card">
                <div class="side-title">营造课堂</div>
                <p style="font-size: 14px; color: #666; line-height: 1.6;">想了解斗拱的承重原理吗？探索古建筑里的空间魔术。</p>
                <button class="btn-action" onclick="location.href='course-building.jsp'">
                    <i class="fas fa-university"></i> 进入在线课堂
                </button>
                <button class="btn-action" style="background:#8D6E63; margin-top:15px;" onclick="location.href='ai-assistant.jsp'">
                    <i class="fas fa-robot"></i> 咨询AI古建专家
                </button>
            </div>
        </div>
    </div>

</body>
</html>