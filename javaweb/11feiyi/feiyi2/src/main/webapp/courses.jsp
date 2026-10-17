<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>在线课程 - 非遗文化传承</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background-color: #FDF5E6; margin: 0; }
                /* 顶部导航栏（居中+样式优化） */
        /* 顶部导航栏 (保持风格统一) */
        .top-nav { background-color: #8B4513; color: #fff; padding: 15px 0; }
        .nav-container { width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .nav-logo { font-size: 22px; font-weight: bold; color: #F1C27D; }
        .nav-menu { display: flex; gap: 25px; }
        .nav-menu a { color: #fff; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .nav-menu a:hover, .nav-menu a.active { color: #F1C27D; text-decoration: underline; }
 
        /* 用户信息区域 - 添加框框样式 */
                .nav-user { display: flex; align-items: center; gap: 12px; padding: 6px 15px; border: 1px solid #F1C27D; border-radius: 20px; background: rgba(255,255,255,0.1); }
        .user-avatar { width: 28px; height: 28px; border-radius: 50%; overflow: hidden; border: 1px solid #F1C27D; }
        .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .nav-user a { font-size: 13px; color: #fff; text-decoration: none; }
        
        /* 页面标题区 */
        .page-header { background: #fff; padding: 60px 0; text-align: center; border-bottom: 1px solid #eee; }
        .page-header h1 { font-size: 36px; color: #5D3A1A; letter-spacing: 10px; margin: 0; }
        .page-header p { color: #888; margin-top: 10px; }

        /* 搜索筛选区 */
        .filter-section { 
            width: 80%; margin: -35px auto 40px; background: white; 
            padding: 25px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            display: flex; gap: 15px; align-items: center;
        }
        .filter-input { flex: 2; padding: 12px; border: 1px solid #ddd; border-radius: 4px; }
        .filter-select { flex: 1; padding: 12px; border: 1px solid #ddd; border-radius: 4px; }
        .btn-search { background: #8B4513; color: white; border: none; padding: 12px 40px; border-radius: 4px; cursor: pointer; }

        /* 课程网格布局 */
        .course-grid { width: 85%; margin: 0 auto; display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; padding-bottom: 50px; }
        .course-card { background: white; border-radius: 10px; overflow: hidden; transition: 0.3s; border: 1px solid #eee; }
        .course-card:hover { transform: translateY(-8px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .course-info { padding: 20px; }
        .course-title { font-size: 18px; font-weight: bold; margin: 0 0 10px; height: 50px; overflow: hidden; }
        .course-meta { display: flex; justify-content: space-between; color: #999; font-size: 13px; margin-bottom: 20px; }
        .tag { padding: 2px 8px; border-radius: 4px; font-size: 12px; }
        .tag-mid { border: 1px solid #DAA520; color: #DAA520; }
        .tag-high { border: 1px solid #FF4500; color: #FF4500; }
        
        .btn-start { width: 100%; background: #F5F5DC; color: #5D3A1A; border: 1px solid #5D3A1A; padding: 10px; border-radius: 5px; cursor: pointer; transition: 0.3s; }
        .btn-start:hover { background: #8B4513; color: white; }
    </style>
</head>
<body>
    <!-- 顶部导航栏（居中+用户信息框框+完善交互） -->
    <div class="top-nav">
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
                // 模拟登录成功的用户信息（实际从Session获取，与LoginServlet联动）
                User loginUser = (User) session.getAttribute("loginUser");
                if (loginUser != null) {
            %>
                    <!-- 已登录状态：带框框+头像+用户名+个人中心/退出登录（完整交互） -->
          <div class="nav-user">
                <div class="user-avatar">
                    <img src="images/user.jpg" alt="头像">
                </div>
                <span style="font-size:13px; color:#F1C27D;"><%= loginUser.getUsername() %></span>
                <a href="personalCenter.jsp">个人中心</a>
                <a href="logout">退出登录</a>
            </div>
            <% 
                } else {
            %>
                    <!-- 未登录状态：带框框+登录按钮 -->
                    <div class="nav-user unlogin">
                        <a href="login.jsp" title="前往登录页面">请登录</a>
                    </div>
            <% 
                }
            %>
        </div>
    </div>


    <div class="page-header">
        <h1>— 在线课程 —</h1>
        <p>学习非遗文化，传承匠心技艺</p>
    </div>

    <div class="filter-section">
        <input type="text" class="filter-input" placeholder="搜索课程标题">
        <select class="filter-select">
            <option>难度等级</option>
            <option>入门</option>
            <option>中级</option>
            <option>高级</option>
        </select>
        <button class="btn-search"><i class="fas fa-search"></i> 搜索</button>
    </div>

    <div class="course-grid">
        <div class="course-card">
            <div class="course-info">
                <div class="course-title">景德镇青花瓷绘画技法精讲 <span class="tag tag-mid">中级</span></div>
                <div class="course-meta">
                    <span><i class="fas fa-book-open"></i> 6 章节</span>
                    <span><i class="fas fa-signal"></i> 中级</span>
                </div>
                <button class="btn-start" onclick="location.href='course-taici.jsp?id=1'">开始学习</button>
            </div>
        </div>

        <div class="course-card">
            <div class="course-info">
                <div class="course-title">西湖绸伞传统制作工艺 <span class="tag tag-mid">中级</span></div>
                <div class="course-meta">
                    <span><i class="fas fa-book-open"></i> 4 章节</span>
                    <span><i class="fas fa-signal"></i> 中级</span>
                </div>
                <button class="btn-start" onclick="location.href='course-chousan.jsp?id=2'">开始学习</button>
            </div>
        </div>

        <div class="course-card">
            <div class="course-info">
                <div class="course-title">蜀绣进阶技法与创作实践 <span class="tag tag-high">高级</span></div>
                <div class="course-meta">
                    <span><i class="fas fa-book-open"></i> 5 章节</span>
                    <span><i class="fas fa-signal"></i> 高级</span>
                </div>
                <button class="btn-start" onclick="location.href='course-shuxiu.jsp?id=3'">开始学习</button>
            </div>
        </div>
        
        </div>

</body>
</html>