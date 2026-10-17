<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人 - 张艺术家 (京剧表演艺术)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 采用京剧经典的红、黑、金配色 */
        body { font-family: "Microsoft YaHei"; background-color: #FFF8F8; margin: 0; color: #333; }
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
        .main-content { flex: 2; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(186, 30, 30, 0.08); }
        .master-header { display: flex; align-items: flex-end; gap: 20px; border-bottom: 3px solid #BA1E1E; padding-bottom: 20px; }
        .master-name { font-size: 36px; color: #BA1E1E; margin: 0; font-family: "KaiTi"; }
        .master-title { font-size: 16px; color: #D4AF37; font-weight: bold; }

        /* 京剧舞台形象展示图 */
        .image-container { position: relative; margin: 30px 0; border-radius: 10px; overflow: hidden; border: 2px solid #BA1E1E; }
        .master-img { width: 100%; display: block; }
        .info-point { position: absolute; background: rgba(186, 30, 30, 0.9); color: white; padding: 6px 15px; border-radius: 20px; font-size: 13px; box-shadow: 0 2px 5px rgba(0,0,0,0.3); }
        .pt-makeup { top: 20%; left: 48%; } /* 指向脸谱/妆面 */
        .pt-costume { bottom: 20%; right: 25%; } /* 指向蟒袍/靠旗 */

        .bio-text { line-height: 2; color: #444; text-indent: 2em; font-size: 16px; }
        
        /* 四功五法解析格 */
        .skill-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin-top: 30px; }
        .skill-item { background: #FFF0F0; padding: 15px; text-align: center; border-radius: 8px; border: 1px solid #FFDADA; }
        .skill-item h4 { margin: 5px 0; color: #BA1E1E; font-size: 18px; }
        .skill-item p { font-size: 12px; color: #666; margin: 0; }

        /* 右侧边栏 */
        .sidebar { flex: 1; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .side-title { font-size: 18px; color: #BA1E1E; border-left: 5px solid #BA1E1E; padding-left: 12px; margin-bottom: 20px; font-weight: bold; }
        
        /* 经典剧目列表 */
        .play-item { display: flex; align-items: center; gap: 10px; margin-bottom: 15px; padding: 10px; background: #FAFAFA; border-radius: 5px; }
        .play-icon { color: #D4AF37; font-size: 20px; }
        .play-name { font-weight: bold; font-size: 14px; }

        .btn-action { width: 100%; padding: 12px; background: #BA1E1E; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; transition: 0.3s; }
        .btn-action:hover { background: #8B0000; }
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
                <h1 class="master-name">张艺术家</h1>
                <span class="master-title">著名京剧表演艺术家 · 净行（花脸）传人</span>
            </div>

            <div class="image-container">
                <img src="images/张艺术家.jpg" class="master-img" alt="张老师剧照" onerror="this.src='https://via.placeholder.com/700x450?text=张老师京剧舞台造型'">
                <div class="info-point pt-makeup">揉、勾、抹脸谱工艺</div>
                <div class="info-point pt-costume">传统苏绣戏服（靠）</div>
            </div>

            <div class="bio-text">
                <p>张艺术家，当代著名京剧表演艺术家，工净行。他自幼入梨园，拜名师，深得传统京剧艺术精髓。他嗓音宽厚嘹亮，表演粗犷豪迈中不失细腻，将花脸行当的“气、势、神”发挥得淋漓尽致。</p>
                <p>除了舞台表演，张老师还致力于京剧脸谱的研究与数字化保存。他认为，京剧不仅是舞台上的唱念做打，更是流动的中华历史博物馆。他坚守舞台数十载，旨在将这方寸戏台上的民族脊梁代代传下去。</p>
            </div>

            

            <div class="skill-grid">
                <div class="skill-item"><h4>唱</h4><p>歌唱</p></div>
                <div class="skill-item"><h4>念</h4><p>念白</p></div>
                <div class="skill-item"><h4>做</h4><p>表演</p></div>
                <div class="skill-item"><h4>打</h4><p>武打</p></div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">经典唱段</div>
                <div class="play-item">
                    <i class="fas fa-play-circle play-icon"></i>
                    <span class="play-name">《长坂坡》</span>
                </div>
                <div class="play-item">
                    <i class="fas fa-play-circle play-icon"></i>
                    <span class="play-name">《铡美案》</span>
                </div>
                <div class="play-item">
                    <i class="fas fa-play-circle play-icon"></i>
                    <span class="play-name">《定军山》</span>
                </div>
            </div>

            <div class="side-card">
                <div class="side-title">梨园研学</div>
                <p style="font-size: 14px; color: #666; line-height: 1.6;">想了解京剧脸谱背后的含义吗？加入张老师的在线艺术讲堂。</p>
                <button class="btn-action" onclick="location.href='course-jingju.jsp'">
                    <i class="fas fa-theater-masks"></i> 观看名家教学
                </button>
                <button class="btn-action" style="background:#D4AF37; margin-top:15px;" onclick="location.href='ai-assistant.jsp'">
                    <i class="fas fa-robot"></i> 咨询AI票友
                </button>
            </div>
        </div>
    </div>

</body>
</html>