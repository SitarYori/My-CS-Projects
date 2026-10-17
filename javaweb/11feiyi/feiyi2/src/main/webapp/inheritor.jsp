<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fy.entity.User" %>
<%-- 假设您有一个Inheritor实体类和DAO，如果没有，请根据实际修改包名 --%>
<%@ page import="com.fy.entity.Inheritor" %>
<%@ page import="com.fy.dao.InheritorDao" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>非遗传承人 - 非遗文化传承平台</title>
    <style>
        /* 基础样式复用 */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "微软雅黑", sans-serif; }
        body { background-color: #F8F0E3; color: #333; line-height: 1.6; }

        /* 顶部导航栏 (保持风格统一) */
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

        /* Banner 区域 */
        .header-banner { background-color: #703810; color: #fff; text-align: center; padding: 50px 20px; }
        .header-banner h1 { font-size: 28px; margin-bottom: 10px; letter-spacing: 2px; }
        .header-banner p { font-size: 14px; opacity: 0.8; }

        /* 内容容器 */
        .container { width: 1200px; margin: 40px auto; }

        /* 搜索框美化 */
        .search-section { text-align: center; margin-bottom: 40px; }
        .search-box { display: inline-flex; width: 600px; background: #fff; padding: 5px; border-radius: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #D2B48C; }
        .search-box input { flex: 1; border: none; padding: 10px 20px; border-radius: 30px; outline: none; font-size: 14px; }
        .search-box button { background: #8B4513; color: #fff; border: none; padding: 0 25px; border-radius: 30px; cursor: pointer; transition: 0.3s; }
        .search-box button:hover { background: #A0522D; }

        /* 传承人网格 */
        .inheritor-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 30px; }

        /* 传承人卡片精致化 */
        .inheritor-card { 
            background: #fff; 
            border-radius: 12px; 
            padding: 30px 20px; 
            text-align: center; 
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            border: 1px solid #eee;
            position: relative;
            overflow: hidden;
        }
        .inheritor-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 15px 35px rgba(139, 69, 19, 0.15); 
            border-color: #F1C27D;
        }
        
        /* 圆形头像装饰 */
        .avatar-wrapper {
            width: 110px;
            height: 110px;
            margin: 0 auto 20px;
            position: relative;
            padding: 5px;
            border: 2px solid #F1C27D;
            border-radius: 50%;
        }
        .avatar-wrapper img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            background: #fdfdfd;
        }

        .inheritor-card h3 { font-size: 18px; color: #333; margin-bottom: 8px; }
        
        /* 勋章/标签样式 */
        .skill-tag { 
            display: inline-block; 
            font-size: 12px; 
            color: #8B4513; 
            background: #FDF5E6; 
            padding: 2px 12px; 
            border-radius: 15px; 
            margin-bottom: 15px;
            border: 1px solid #F1C27D;
        }

        .inheritor-desc { 
            font-size: 13px; 
            color: #777; 
            margin-bottom: 20px; 
            height: 40px; 
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* 详情按钮 */
        .detail-btn { 
            display: inline-block; 
            padding: 8px 25px; 
            background-color: transparent; 
            color: #8B4513; 
            border: 1px solid #8B4513; 
            text-decoration: none; 
            border-radius: 5px; 
            font-size: 13px; 
            transition: 0.3s;
        }
        .detail-btn:hover { background-color: #8B4513; color: #fff; }

        /* 页脚 */
        .footer { background: #3d1f08; color: #fff; padding: 40px 0; margin-top: 60px; font-size: 13px; }
        .footer-content { width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; }
        .footer-logo img { width: 120px; filter: brightness(2); }
        
    </style>
</head>
<body>

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
                User loginUser = (User) session.getAttribute("loginUser");
                if (loginUser != null) {
            %>
            <div class="nav-user">
                <div class="user-avatar">
                    <img src="images/user.jpg" alt="头像">
                </div>
                <span style="font-size:13px; color:#F1C27D;"><%= loginUser.getUsername() %></span>
                <a href="personalCenter.jsp">个人中心</a>
                <a href="logout">退出登录</a>
            </div>
            <% } else { %>
            <div class="nav-user"><a href="login.jsp">登录 / 注册</a></div>
            <% } %>
        </div>
    </div>

    <div class="header-banner">
        <h1>✨ 非遗传承人</h1>
        <p>守护传统技艺的匠心大师 · 续写民族文化的时代华章</p>
    </div>

    <div class="container">
        <div class="search-section">
            <form action="inheritor.jsp" method="get">
                <div class="search-box">
                    <input type="text" name="keyword" placeholder="搜索传承人姓名、技艺领域或等级...">
                    <button type="submit">搜索传承人</button>
                </div>
            </form>
        </div>

<div class="inheritor-grid">
    <%
        // 这里是模拟数据，实际应用请通过InheritorDao从数据库获取
        // InheritorDao dao = new InheritorDao();
        // List<Inheritor> list = dao.getAllInheritors();
        
        // 下面为静态模拟展示，方便您直接看效果
        String[][] mockData = {
            {"陈利师傅", "醴陵釉下五彩瓷烧制", "国家级非遗传承人，专注醴陵釉下五彩瓷技艺已有 30 余年", "images/陈师傅.jpg"},
            {"姚大师", "苏州刺绣", "国家级非遗传承人，精通苏州刺绣技艺，作品多次获奖", "images/李大师.jpg"},
            {"王老师", "传统剪纸", "国家级非遗传承人，擅长剪纸艺术创作与教学", "images/王老师.jpg"},
            {"张艺术家", "京剧艺术", "民间音乐家，擅长京胡和京剧音乐", "images/张艺术家.jpg"},
            {"刘舞蹈家", "传统舞蹈", "古典舞蹈艺术家，擅长传统民族舞蹈", "images/刘舞蹈家.jpg"},
            {"杨医生", "中医针灸", "中医针灸传承人，专注于中医传统疗法研究", "images/杨医生.jpg"},
            {"马厨师", "传统饮食", "国家级烹饪大师，精通传统美食制作工艺", "images/马厨师.jpg"},
            {"吴建筑师", "传统建筑", "古建筑专家，研究传统建筑文化与技艺", "images/吴建筑师.jpg"}
        };

       
        for(String[] item : mockData) {
            // --- 新增跳转逻辑开始 ---
            String targetPage;
            
            // 使用 if-else if 结构为每一位师傅分配专门的页面
            if ("陈利师傅".equals(item[0])) {
                // 跳转到陶瓷专题页
                targetPage = "inheritor-taoci.jsp";
            } else if ("姚大师".equals(item[0])) {
                // 跳转到苏绣专题页
                targetPage = "inheritor-cixiu.jsp";
            } else if ("王老师".equals(item[0])) {
                // 跳转到剪纸专题页
                targetPage = "inheritor-jianzhi.jsp";
            } else if ("张艺术家".equals(item[0])) {
                // 跳转到木雕专题页
                targetPage = "inheritor-jingju.jsp";
            } else if ("刘舞蹈家".equals(item[0])) {
                // 跳转到传统舞蹈页
                targetPage = "inheritor-dance.jsp";
            } else if ("杨医生".equals(item[0])) {
                // 跳转到中医针灸页
                targetPage = "inheritor-zhongyi.jsp";
            } else if ("马厨师".equals(item[0])) {
                // 跳转到传统饮食页
                targetPage = "inheritor-food.jsp";
            } else if ("吴建筑师".equals(item[0])) {
                // 跳转到古建筑页
                targetPage = "inheritor-building.jsp";
            } else {
                // 兜底方案：如果没有匹配到专门页面，跳转到带参数的通用模板
                targetPage = "inheritor-detail.jsp?name=" + java.net.URLEncoder.encode(item[0], "UTF-8");
            }
            // --- 新增跳转逻辑结束 ---
    %>
    <div class="inheritor-card">
        <div class="avatar-wrapper">
            <img src="<%= item[3] %>" onerror="this.src='https://api.dicebear.com/7.x/adventurer/svg?seed=<%= item[0] %>'" alt="传承人">
        </div>
        <h3><%= item[0] %></h3>
        <div class="skill-tag">🏷 <%= item[1] %></div>
        <p class="inheritor-desc"><%= item[2] %></p>
        <%-- 这里的 href 已经变为上面动态生成的 targetPage --%>
        <a href="<%= targetPage %>" class="detail-btn">查看详情</a>
    </div>
    <% } %>
</div>

    </div>

    <div class="footer">
        <div class="footer-content">
            <div style="flex: 1;">
                <h4 style="color:#F1C27D; margin-bottom:15px;">关于我们</h4>
                <p style="opacity:0.7;">非遗文化传承平台致力于保护和传承中华优秀传统文化，让更多人了解非物质文化遗产的魅力。</p>
            </div>
            <div style="flex: 1; text-align: center;">
                <h4 style="color:#F1C27D; margin-bottom:15px;">快速链接</h4>
                <p>项目申报 | 传承人申请 | 志愿加入</p>
            </div>
            <div style="flex: 1; text-align: right;">
                <h4 style="color:#F1C27D; margin-bottom:15px;">联系方式</h4>
                <p>📧 contact@heritage.com</p>
                <p>📞 400-888-8888</p>
            </div>
        </div>
        <div style="text-align:center; margin-top:30px; opacity:0.5; border-top:1px solid rgba(255,255,255,0.1); padding-top:20px;">
            © 2025 非遗文化传承平台 版权所有 | 传承文化 · 守护经典
        </div>
    </div>

</body>
</html>