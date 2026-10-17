<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人 - 王老师 (传统剪纸技艺)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 页面背景采用剪纸常用的朱红色与米白色调 */
        body { font-family: "Microsoft YaHei"; background-color: #FFF5F5; margin: 0; color: #333; }
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
        .main-content { flex: 2; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(255,0,0,0.05); }
        .master-header { display: flex; align-items: flex-end; gap: 20px; border-bottom: 2px solid #C04848; padding-bottom: 20px; }
        .master-name { font-size: 36px; color: #C04848; margin: 0; font-family: "KaiTi"; }
        .master-title { font-size: 16px; color: #D44E4E; font-weight: bold; }

        /* 图片与点位标注 */
        .image-container { position: relative; margin: 30px 0; border-radius: 10px; overflow: hidden; border: 1px solid #FFDada; }
        .master-img { width: 100%; display: block; }
        .info-point { position: absolute; background: rgba(192, 72, 72, 0.9); color: white; padding: 6px 15px; border-radius: 20px; font-size: 13px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .pt-tool { top: 35%; left: 45%; } /* 指向剪刀/刻刀 */
        .pt-paper { bottom: 25%; right: 20%; } /* 指向宣纸/红纸 */

        .bio-text { line-height: 2; color: #444; text-indent: 2em; font-size: 16px; }
        
        /* 技法展示格 */
        .skill-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 25px; }
        .skill-card { background: #FFF9F9; padding: 20px; text-align: center; border-radius: 8px; border: 1px solid #FFEDED; }
        .skill-card i { font-size: 24px; color: #C04848; margin-bottom: 10px; }
        .skill-card h4 { margin: 5px 0; color: #C04848; }

        /* 右侧边栏 */
        .sidebar { flex: 1; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .side-title { font-size: 18px; color: #C04848; border-left: 5px solid #C04848; padding-left: 12px; margin-bottom: 20px; font-weight: bold; }
        
        .work-item { display: flex; gap: 12px; margin-bottom: 20px; text-decoration: none; color: inherit; }
        .work-thumb { width: 90px; height: 90px; border-radius: 5px; object-fit: cover; border: 1px solid #eee; }
        .work-info h4 { margin: 0; font-size: 14px; color: #333; }
        
        .btn-action { width: 100%; padding: 12px; background: #C04848; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; transition: 0.3s; }
        .btn-action:hover { background: #A03838; }
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
                <h1 class="master-name">王银凤</h1>
                <span class="master-title">国家级非物质文化遗产(剪纸)代表性传承人</span>
            </div>

            <div class="image-container">
                <img src="images/i3_detail.jpg" class="master-img" alt="王老师剪纸中" onerror="this.src='https://via.placeholder.com/700x450?text=王老师剪纸创作照'">
                <div class="info-point pt-tool">脱稿盲剪技法</div>
                <div class="info-point pt-paper">万年红宣纸选材</div>
            </div>

            <div class="bio-text">
                <p>王银凤，生于剪纸艺术之乡，自幼随家族研习剪纸技艺，深耕行业四十余年。她将传统剪纸“圆如秋月、尖如麦芒”的十六字诀与现代审美结合，独创“写意剪纸”风格，作品兼具北方剪纸的粗犷与南方剪纸的细腻。</p>
                <p>她坚持“无稿剪刻”的创作方式，“心中有图、手随神动”，作品多次斩获国家级非遗奖项，更作为文化礼品走出国门。</p>
            </div>

            <div class="skill-grid">
                <div class="skill-card">
                    <i class="fas fa-cut"></i>
                    <h4>阴刻技法</h4>
                    <p style="font-size:12px; color:#666;">以线刻为主，保留块面</p>
                </div>
                <div class="skill-card">
                    <i class="fas fa-pencil-alt"></i>
                    <h4>阳刻技法</h4>
                    <p style="font-size:12px; color:#666;">剔除块面，保留线条</p>
                </div>
                <div class="skill-card">
                    <i class="fas fa-layer-group"></i>
                    <h4>套色剪纸</h4>
                    <p style="font-size:12px; color:#666;">多层叠加，色彩丰富</p>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">代表作品</div>
                <div class="work-item">
                    <img src="images/王银凤作品.webp" class="work-thumb" onerror="this.src='https://via.placeholder.com/90/fee'">
                    <div class="work-info">
                        <h4>《百福图》</h4>
                        <p style="font-size: 12px; color: #999;">以100种形态各异的“福”字为核心，融合传统吉祥纹样，寓意福气满盈，是王银凤的经典贺岁作品。</p>
                    </div>
                </div>
                <div class="work-item">
                    <img src="images/四季平安.webp" class="work-thumb" onerror="this.src='https://via.placeholder.com/90/fee'">
                    <div class="work-info">
                        <h4>《四季平安》</h4>
                        <p style="font-size: 12px; color: #999;">以四季花卉为主题，用镂空剪刻技法展现“梅兰竹菊”的灵动感，线条纤细如丝，细节精妙入微。</p>
                    </div>
                </div>
            </div>

            <div class="side-card">
                <div class="side-title">传承课堂</div>
                <p style="font-size: 14px; color: #666;">想体验“一剪成蝶”的惊喜吗？加入王老师的在线课堂。</p>
                <button class="btn-action" onclick="location.href='course-jianzhi.jsp'">
                    <i class="fas fa-video"></i> 进入课堂
                </button>
                <button class="btn-action" style="background:#DAA520; margin-top:15px;" onclick="location.href='ai-assistant.jsp'">
                    <i class="fas fa-robot"></i> 咨询AI助手
                </button>
            </div>
        </div>
    </div>

</body>
</html>