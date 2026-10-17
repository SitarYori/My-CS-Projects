<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人 - 马厨师 (传统饮食技艺)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 采用富有食欲的暖橙色与沉稳的炭木棕 */
        body { font-family: "Microsoft YaHei"; background-color: #FFF9F0; margin: 0; color: #333; }
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
        .main-content { flex: 2; background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 15px rgba(210, 105, 30, 0.05); }
        .master-header { display: flex; align-items: flex-end; gap: 20px; border-bottom: 2px solid #D2691E; padding-bottom: 20px; }
        .master-name { font-size: 36px; color: #D2691E; margin: 0; font-family: "KaiTi"; }
        .master-title { font-size: 16px; color: #E67E22; font-weight: bold; }

        /* 烹饪艺术展示图 */
        .image-container { position: relative; margin: 30px 0; border-radius: 10px; overflow: hidden; border: 1px solid #FFE4B5; }
        .master-img { width: 100%; display: block; }
        .info-point { position: absolute; background: rgba(210, 105, 30, 0.9); color: white; padding: 6px 15px; border-radius: 20px; font-size: 13px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .pt-technique { top: 30%; left: 35%; } /* 指向刀工/翻锅 */
        .pt-ingredient { bottom: 25%; right: 20%; } /* 指向特制香料/食材 */

        .bio-text { line-height: 2; color: #444; text-indent: 2em; font-size: 16px; }
        
        /* 烹饪技法展示格 */
        .skill-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 30px; }
        .skill-item { background: #FFFBF5; padding: 20px; text-align: center; border-radius: 8px; border: 1px solid #FFEBCD; }
        .skill-item i { font-size: 26px; color: #D2691E; margin-bottom: 10px; }
        .skill-item h4 { margin: 5px 0; color: #D2691E; }

        /* 右侧边栏 */
        .sidebar { flex: 1; }
        .side-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .side-title { font-size: 18px; color: #D2691E; border-left: 5px solid #D2691E; padding-left: 12px; margin-bottom: 20px; font-weight: bold; }
        
        /* 代表菜品展示 */
        .dish-item { margin-bottom: 20px; border-bottom: 1px dashed #eee; padding-bottom: 15px; }
        .dish-name { font-weight: bold; color: #8B4513; display: block; }
        .dish-desc { font-size: 13px; color: #777; margin-top: 5px; line-height: 1.5; }

        .btn-action { width: 100%; padding: 12px; background: #D2691E; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; transition: 0.3s; }
        .btn-action:hover { background: #A0522D; }
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
                <h1 class="master-name">马厨师</h1>
                <span class="master-title">国家级烹饪大师 · 传统饮食技艺代表性传承人</span>
            </div>

            <div class="image-container">
                <img src="images/i7_detail.jpg" class="master-img" alt="马厨师烹饪照" onerror="this.src='https://via.placeholder.com/700x450?text=马厨师烹饪创作现场'">
                <div class="info-point pt-technique">古法文火煨制</div>
                <div class="info-point pt-ingredient">独门秘制调味方</div>
            </div>

            <div class="bio-text">
                <p>马厨师，深耕传统饮食技艺四十余载。他坚持“寻根求源，守正创新”的烹饪哲学，尤其在复原失传的古法菜肴方面具有极高造诣。他认为，一道好的非遗美食，不仅是味蕾的享受，更是历史与文化的传递。</p>
                <p>马大师曾多次受邀参加国际美食节，向世界展示中华饮食的博大精深。他主张严格遵循“不时不食”的节气饮食原则，坚持使用最地道的天然食材，还原食物最原始、最纯粹的滋味。</p>
            </div>

            <div class="skill-grid">
                <div class="skill-item">
                    <i class="fas fa-utensils"></i>
                    <h4>精湛刀工</h4>
                    <p style="font-size:12px; color:#777;">文思豆腐细如发</p>
                </div>
                <div class="skill-item">
                    <i class="fas fa-fire-alt"></i>
                    <h4>火候掌控</h4>
                    <p style="font-size:12px; color:#777;">掌握镬气，极致火候</p>
                </div>
                <div class="skill-item">
                    <i class="fas fa-mortar-pestle"></i>
                    <h4>古法酿造</h4>
                    <p style="font-size:12px; color:#777;">手工酱料，岁月陈香</p>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <div class="side-title">招牌非遗菜式</div>
                <div class="dish-item">
                    <span class="dish-name">《古法秘制佛跳墙》</span>
                    <p class="dish-desc">选用多种名贵食材，慢火煨制二十小时，汤清味厚。</p>
                </div>
                <div class="dish-item">
                    <span class="dish-name">《孔府麒麟鱼》</span>
                    <p class="dish-desc">展现极高难度的刀法与造型，形神兼备，滋味鲜美。</p>
                </div>
            </div>

            <div class="side-card">
                <div class="side-title">美食研习</div>
                <p style="font-size: 14px; color: #666; line-height: 1.6;">想在家中复刻非遗味道吗？加入马大师的在线烹饪课堂。</p>
                <button class="btn-action" onclick="location.href='course-food.jsp'">
                    <i class="fas fa-play-circle"></i> 观看烹饪教学
                </button>
                <button class="btn-action" style="background:#DAA520; margin-top:15px;" onclick="location.href='ai-assistant.jsp'">
                    <i class="fas fa-robot"></i> 咨询AI美食家
                </button>
            </div>
        </div>
    </div>

</body>
</html>