<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人 - 陈大师 (手工制瓷技艺)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background-color: #FDF5E6; margin: 0; color: #333; }
        .container { width: 1100px; margin: 40px auto; display: flex; gap: 30px; }
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
        .master-header { display: flex; align-items: flex-end; gap: 20px; border-bottom: 2px solid #8B4513; padding-bottom: 20px; }
        .master-name { font-size: 36px; color: #8B4513; margin: 0; font-family: "KaiTi"; }
        .master-title { font-size: 16px; color: #DAA520; font-weight: bold; }

        /* 图片与点位标注 */
        .image-container { position: relative; margin: 30px 0; border-radius: 10px; overflow: hidden; }
        .master-img { width: 100%; display: block; }
        .info-point { position: absolute; background: rgba(139, 69, 19, 0.85); color: white; padding: 6px 15px; border-radius: 20px; font-size: 13px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .pt-art { top: 25%; left: 30%; } /* 指向绘画手势 */
        .pt-material { bottom: 20%; right: 25%; } /* 指向青花料 */

        .bio-text { line-height: 2; color: #444; text-indent: 2em; font-size: 16px; }
        .honor-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 25px; }
        .honor-item { background: #fdfaf2; padding: 15px; border-radius: 5px; font-size: 14px; color: #5D3A1A; border: 1px dashed #DEB887; }

        /* 右侧边栏 */
        .sidebar { flex: 1; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .side-title { font-size: 18px; color: #8B4513; border-left: 5px solid #8B4513; padding-left: 12px; margin-bottom: 20px; font-weight: bold; }
        
        /* 代表作展示 */
        .work-item { display: flex; gap: 12px; margin-bottom: 20px; text-decoration: none; color: inherit; transition: 0.3s; }
        .work-item:hover { opacity: 0.8; }
        .work-thumb { width: 90px; height: 70px; border-radius: 5px; object-fit: cover; }
        .work-info h4 { margin: 0; font-size: 14px; color: #333; }
        .work-info p { margin: 5px 0 0; font-size: 12px; color: #999; }

        .btn-course { width: 100%; padding: 12px; background: #8B4513; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
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
                <h1 class="master-name">陈大师</h1>
                <span class="master-title">国家级非物质文化遗产代表性传承人</span>
            </div>

            <div class="image-container">
                <img src="imges/陈利工作.png" class="master-img" alt="陈大师创作中" onerror="this.src='https://via.placeholder.com/700x450?text=陈大师制瓷工作照'">
                <div class="info-point pt-art">特种青花分水技法</div>
                <div class="info-point pt-material">景德镇高岭土应用</div>
            </div>

            <div class="bio-text">
                <p>陈利大师，1968 年生于湖南醴陵陶瓷世家，从事醴陵釉下五彩瓷烧制技艺三十余载。她精通从制泥、绘彩到施釉、烧制的全套传统工序，尤其在 “薄施淡染” 技法与釉下复合色料研制上具有极高造诣。</p>
                <p>其作品被中国国家博物馆等多家机构收藏。她坚持 “淡染传韵，釉彩承新” 的创作理念，将现代审美意趣融入传统釉下五彩瓷设计中，使古老瓷艺焕发时代生机</p>
            </div>

            <h3 style="color:#8B4513; margin-top:30px;">主要荣誉</h3>
            <div class="honor-grid">
                <div class="honor-item"><i class="fas fa-medal"></i> 2025 年入选国家级非物质文化遗产代表性传承人名单</div>
                <div class="honor-item"><i class="fas fa-medal"></i> 作品《碧玲珑》《万紫千红》被中国国家博物馆收藏</div>
                <div class="honor-item"><i class="fas fa-medal"></i> 多次获全国工艺美术 “百花奖</div>
                <div class="honor-item"><i class="fas fa-medal"></i> 获评全国非遗先进个人</div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">代表作品</div>
                
                <a href="#" class="work-item">
                    <img src="images/碧玲珑.jpg" class="work-thumb" onerror="this.src='https://via.placeholder.com/90/DDD'">
                    <div class="work-info">
                        <h4>《碧玲珑》</h4>
                        <p>以 “薄施淡染” 技法绘就，釉色温润清雅，尽显醴陵釉下五彩瓷的灵秀质感</p>
                    </div>
                </a>

                <a href="#" class="work-item">
                    <img src="images/万紫千红.png" class="work-thumb" onerror="this.src='https://via.placeholder.com/90/DDD'">
                    <div class="work-info">
                        <h4>《万紫千红》</h4>
                        <p>采用 “薄施淡染” 与复色叠加工艺，以多种自研釉下复合色料绘就百花盛放之景，色彩层次丰富却清雅和谐，尽显醴陵釉下五彩瓷 “淡而不寡、艳而不俗” 的特质。</p>
                    </div>
                </a>
            </div>

            <div class="side-card">
                <div class="side-title">关联课程</div>
                <p style="font-size: 14px; color: #666; line-height: 1.6;">跟随陈大师学习正宗醴陵釉手工制瓷技艺，从揉泥开始感悟陶瓷魅力。</p>
                <button class="btn-course" onclick="location.href='course-taici.jsp'">
                    <i class="fas fa-play"></i> 观看大师演示
                </button>
            </div>

            <div class="side-card" style="background: #FDF5E6; border: 1px solid #DEB887;">
                <div class="side-title" style="border-left-color: #DAA520;">技艺咨询</div>
                <p style="font-size: 14px;">如果您对陶瓷工艺有任何疑问，可点击下方按钮咨询 AI 助手。</p>
                <button class="btn-course" style="background: #DAA520;" onclick="location.href='ai-assistant.jsp'">
                    <i class="fas fa-robot"></i> 咨询AI助手
                </button>
            </div>
        </div>
    </div>

</body>
</html>