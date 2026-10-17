<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人 - 刘舞蹈家 (传统舞蹈)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 采用富有流动感的青绿色调 */
        body { font-family: "Microsoft YaHei"; background-color: #F0F7F4; margin: 0; color: #333; }
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
        .main-content { flex: 2; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(46, 139, 87, 0.05); }
        .master-header { display: flex; align-items: flex-end; gap: 20px; border-bottom: 2px solid #2E8B57; padding-bottom: 20px; }
        .master-name { font-size: 36px; color: #2E8B57; margin: 0; font-family: "KaiTi"; }
        .master-title { font-size: 16px; color: #66BB6A; font-weight: bold; }

        /* 舞蹈动态展示图 */
        .image-container { position: relative; margin: 30px 0; border-radius: 10px; overflow: hidden; }
        .master-img { width: 100%; display: block; filter: brightness(0.95); }
        .info-point { position: absolute; background: rgba(46, 139, 87, 0.9); color: white; padding: 6px 15px; border-radius: 20px; font-size: 13px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .pt-pose { top: 20%; left: 55%; } /* 指向舞蹈身段 */
        .pt-costume { bottom: 15%; right: 30%; } /* 指向传统服饰细节 */

        .bio-text { line-height: 2; color: #444; text-indent: 2em; font-size: 16px; }
        
        /* 舞蹈流派展示 */
        .dance-features { display: flex; justify-content: space-around; margin-top: 30px; background: #F9FCFB; padding: 25px; border-radius: 10px; }
        .feature-item { text-align: center; }
        .feature-item i { font-size: 28px; color: #2E8B57; margin-bottom: 10px; }
        .feature-item h4 { margin: 5px 0; color: #2E8B57; }

        /* 右侧边栏 */
        .sidebar { flex: 1; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .side-title { font-size: 18px; color: #2E8B57; border-left: 5px solid #2E8B57; padding-left: 12px; margin-bottom: 20px; font-weight: bold; }
        
        /* 经典剧照列表 */
        .stage-photo { width: 100%; height: 120px; border-radius: 5px; object-fit: cover; margin-bottom: 10px; border: 1px solid #eee; }
        .photo-desc { font-size: 13px; color: #666; margin-bottom: 15px; text-align: center; }

        .btn-action { width: 100%; padding: 12px; background: #2E8B57; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; transition: 0.3s; }
        .btn-action:hover { background: #1E5B37; }
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
                <h1 class="master-name">刘岩</h1>
                <span class="master-title">国家一级演员·中国古典舞艺术家</span>
            </div>

            <div class="image-container">
                <img src="images/i5_detail.jpg" class="master-img" alt="舞蹈表演照" onerror="this.src='https://via.placeholder.com/700x450?text=刘舞蹈家演出剧照'">
                <div class="info-point pt-pose">敦煌壁画复原舞姿</div>
                <div class="info-point pt-costume">手工刺绣汉唐舞衣</div>
            </div>

            <div class="bio-text">
               <p>刘岩，中国古典舞领域代表性艺术家，以“身韵灵动、情感深刻”的表演风格著称。她曾是北京奥运会开幕式独舞《丝路》的原定表演者，虽因意外受伤致残，仍以“轮椅上的舞者”身份深耕舞蹈教育与理论研究。</p>
               <p>她长期致力于传统舞蹈的“身韵传承”，抢救整理古典舞技法体系，并通过《岩语》《红线》等作品，以现代视角诠释古典舞的精神内核，被誉为“用灵魂起舞的艺术家”。</p>
            </div>

            <div class="dance-features">
                <div class="feature-item">
                    <i class="fas fa-wind"></i>
                    <h4>身韵流派</h4>
                    <p style="font-size:12px; color:#999;">形神兼备，气贯始终</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-history"></i>
                    <h4>复古复原</h4>
                    <p style="font-size:12px; color:#999;">还原历代宫廷舞蹈</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-users"></i>
                    <h4>民族采风</h4>
                    <p style="font-size:12px; color:#999;">融合民间艺术精粹</p>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">舞台掠影</div>
                <img src="images/胭脂扣.png" class="stage-photo" onerror="this.src='https://via.placeholder.com/200x120?text=剧照1'">
                <div class="photo-desc">《胭脂扣》</div>
                
                <img src="images/我再次呼吸.png" class="stage-photo" onerror="this.src='https://via.placeholder.com/200x120?text=剧照2'">
                <div class="photo-desc">《我再次呼吸》</div>
            </div>

            <div class="side-card">
                <div class="side-title">研学与咨询</div>
                <p style="font-size: 14px; color: #666; line-height: 1.6;">想要领略汉唐舞的神韵吗？点击下方了解大师亲授课程。</p>
                <button class="btn-action" onclick="location.href='course-dance.jsp'">
                    <i class="fas fa-video"></i> 观看教学视频
                </button>
                <button class="btn-action" style="background:#8B4513; margin-top:15px;" onclick="location.href='ai-assistant.jsp'">
                    <i class="fas fa-robot"></i> AI 助手咨询
                </button>
            </div>
        </div>
    </div>

</body>
</html>