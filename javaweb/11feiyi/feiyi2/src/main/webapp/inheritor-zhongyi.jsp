<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人 - 杨医生 (中医针灸)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 采用本草绿与古朴的木色调 */
        body { font-family: "Microsoft YaHei"; background-color: #F4F7F0; margin: 0; color: #333; }
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
        .main-content { flex: 2; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(60, 100, 60, 0.05); }
        .master-header { display: flex; align-items: flex-end; gap: 20px; border-bottom: 2px solid #556B2F; padding-bottom: 20px; }
        .master-name { font-size: 36px; color: #556B2F; margin: 0; font-family: "KaiTi"; }
        .master-title { font-size: 16px; color: #8FBC8F; font-weight: bold; }

        /* 中医诊疗展示图 */
        .image-container { position: relative; margin: 30px 0; border-radius: 10px; overflow: hidden; border: 1px solid #E0EADD; }
        .master-img { width: 100%; display: block; }
        .info-point { position: absolute; background: rgba(85, 107, 47, 0.9); color: white; padding: 6px 15px; border-radius: 20px; font-size: 13px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .pt-meridian { top: 25%; left: 40%; } /* 指向人体穴位模型 */
        .pt-herb { bottom: 20%; right: 25%; } /* 指向药材/针灸包 */

        .bio-text { line-height: 2; color: #444; text-indent: 2em; font-size: 16px; }
        
        /* 中医诊疗特色展示 */
        .skill-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 30px; }
        .skill-item { background: #F9FAF7; padding: 20px; text-align: center; border-radius: 8px; border: 1px dashed #A2B59F; }
        .skill-item i { font-size: 26px; color: #556B2F; margin-bottom: 10px; }
        .skill-item h4 { margin: 5px 0; color: #556B2F; }

        /* 右侧边栏 */
        .sidebar { flex: 1; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .side-title { font-size: 18px; color: #556B2F; border-left: 5px solid #556B2F; padding-left: 12px; margin-bottom: 20px; font-weight: bold; }
        
        /* 中医养生建议 */
        .health-tip { background: #FFF9F0; border-left: 3px solid #DAA520; padding: 15px; margin-bottom: 15px; font-size: 14px; }
        .health-tip strong { color: #8B4513; display: block; margin-bottom: 5px; }

        .btn-action { width: 100%; padding: 12px; background: #556B2F; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; transition: 0.3s; }
        .btn-action:hover { background: #3B4D21; }
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
                <h1 class="master-name">杨道华</h1>
                <span class="master-title">国家级非遗（中医针灸）传承人·主任中医师</span>
            </div>

            <div class="image-container">
                <img src="images/i6_detail.jpg" class="master-img" alt="杨医生诊疗照" onerror="this.src='https://via.placeholder.com/700x450?text=杨医生中医诊疗场景'">
                <div class="info-point pt-meridian">传统针刺补泻手法</div>
                <div class="info-point pt-herb">地道道地药材辨识</div>
            </div>

            <div class="bio-text">
               <p>杨道华，出身中医针灸世家，自幼随父辈研习《黄帝内经》《针灸大成》，深耕针灸领域四十余年，是国家级非遗“杨氏针灸”的代表性传承人。</p>
<p>他主张“针药并用，形神同调”，在“飞针技法”基础上创新“透穴针法”，擅长以针灸辅助慢性病调理，尤其在颈肩腰腿痛、脾胃失调等领域疗效显著。多年来他深入基层义诊，同时收徒授艺，致力于非遗针灸技艺的活态传承。</p>
            </div>

            <div class="skill-grid">
                <div class="skill-item">
                    <i class="fas fa-hand-holding-medical"></i>
                    <h4>透穴飞针</h4>
                    <p style="font-size:12px; color:#777;">融合飞针与透穴技法，进针快、痛感轻，针感传导强</p>
                </div>
                <div class="skill-item">
                    <i class="fas fa-fire"></i>
                    <h4>古法艾灸</h4>
                    <p style="font-size:12px; color:#777;">保留艾炷悬灸古法，温通经络调虚寒</p>
                </div>
                <div class="skill-item">
                    <i class="fas fa-mortar-pestle"></i>
                    <h4>针药协同</h4>
                    <p style="font-size:12px; color:#777;">针灸配中药方剂，一人一方辨证调治</p>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">养生锦囊</div>
                <div class="health-tip">
                    <strong>🌞 针灸调脾胃</strong>
                    脾胃虚弱者可常按足三里穴，搭配麦粒灸中脘，助运化、补脾气
                </div>
                <div class="health-tip">
                    <strong>🍵 日常护颈</strong>
                    久坐后可轻按风池、肩井穴，配合“飞针点按法”缓解颈肩僵硬。
                </div>
            </div>

            <div class="side-card">
                <div class="side-title">互动交流</div>
                <p style="font-size: 14px; color: #666; line-height: 1.6;">想了解更多中医经络知识？观看杨医生的科普课堂视频。</p>
                <button class="btn-action" onclick="location.href='course-zhongyi.jsp'">
                    <i class="fas fa-video"></i> 观看科普课堂
                </button>
                <button class="btn-action" style="background:#DAA520; margin-top:15px;" onclick="location.href='ai-assistant.jsp'">
                    <i class="fas fa-robot"></i> 咨询AI药师
                </button>
            </div>
        </div>
    </div>

</body>
</html>