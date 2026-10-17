<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fy.entity.Heritage" %>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>非遗文化传承平台-首页</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
        body {
            background-color: #F8F0E3;
            color: #333;
        }
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

        /* 头部banner */
		.header-banner { background-color: #703810; color: #fff; text-align: center; padding: 60px 20px; }
        .header-banner h1 { font-size: 28px; margin-bottom: 20px; letter-spacing: 2px; }
        .header-banner p { font-size: 16px;  margin-bottom: 20px; /* 增大描述与按钮的间距 */opacity: 0.8; }

        .header-banner .btn {
            background-color: #F1C27D;
            color: #8B4513;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        /* 内容容器 */
        .container {
            width: 1200px;
            margin: 30px auto;
        }

        /* 热门非遗项目区域（项目添加交互） */
        .section-title {
            text-align: center;
            margin-bottom: 20px;
        }
        .section-title h2 {
            font-size: 20px;
            color: #8B4513;
        }
        .section-title p {
            font-size: 12px;
            color: #666;
        }
        .project-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        .project-item {
            background-color: #fff;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            cursor: pointer; /* 鼠标悬浮提示可点击 */
            transition: transform 0.2s;
        }
        .project-item:hover {
            transform: scale(1.02); /* 悬浮放大效果 */
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .project-item img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .project-item h3 {
            font-size: 16px;
            margin-bottom: 5px;
        }
        .project-item p {
            font-size: 12px;
            color: #666;
            margin-bottom: 10px;
        }
        .project-item .stats {
            font-size: 12px;
            color: #8B4513;
            margin-bottom: 10px;
        }
        .project-item .btn {
            background-color: #8B4513;
            color: #fff;
            border: none;
            padding: 5px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        .more-btn {
            text-align: center;
            margin: 20px 0 40px;
        }
        .more-btn .btn {
            background-color: #8B4513;
            color: #fff;
            border: none;
            padding: 8px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        /* 最新非遗项目+右侧资讯区域 */
        .mixed-section {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
        }
        .latest-projects {
            flex: 2;
        }
        .latest-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }
        .latest-item {
            background-color: #fff;
            padding: 10px;
            border-radius: 6px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .latest-item:hover {
            transform: scale(1.02);
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .latest-item img {
            width: 100%;
            height: 120px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 8px;
        }
        .latest-item h3 {
            font-size: 14px;
            margin-bottom: 5px;
        }
        .latest-item .btn {
            background-color: #8B4513;
            color: #fff;
            border: none;
            padding: 3px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        .news-side {
            flex: 1;
            background-color: #fff;
            padding: 15px;
            border-radius: 6px;
        }
        .news-side h3 {
            font-size: 16px;
            color: #8B4513;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
        }
        .news-list li {
            list-style: none;
            margin-bottom: 10px;
            font-size: 13px;
        }
        .news-list li a {
            color: #333;
            text-decoration: none;
        }
        .news-list li a:hover {
            color: #8B4513;
            text-decoration: underline;
        }

        /* 非遗分类区域 */
        .category-section {
            margin-bottom: 40px;
        }
        .category-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .category-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 6px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .category-item:hover {
            background-color: #F1C27D;
            color: #8B4513;
        }
        .category-item h3 {
            font-size: 16px;
            margin-bottom: 5px;
        }
        .category-item p {
            font-size: 12px;
        }

        /* 底部版权 */
       .footer { background: #3d1f08; color: #fff; padding: 40px 0; margin-top: 60px; font-size: 13px; }
        .footer-content { width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; }
        .footer-logo img { width: 120px; filter: brightness(2); }
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

    <!-- 头部Banner -->
    <div class="header-banner">
        <h1>传承千年文化 守护民族瑰宝</h1>
        <p>探索国家级非物质文化遗产的魅力，感受中华文明的深厚底蕴</p>
        <button class="btn" onclick="window.location.href='heritage-project.jsp'">立即探索</button>
    </div>

    <!-- 内容容器 -->
    <div class="container">
        <!-- 热门非遗项目区域（项目添加跳转） -->
        <div class="hot-projects">
            <div class="section-title">
                <h2>热门非遗项目</h2>
                <p>最受关注的国家级非物质文化遗产项目</p>
            </div>
            <div class="project-grid">
                <!-- 项目1（点击项目/详情跳转到详情页） -->
                <div class="project-item" onclick="window.location.href='heritage-taoci.jsp'">
                    <img src="images/万紫千红.png" alt="醴陵釉陶瓷">
                    <h3>醴陵釉陶瓷</h3>
                    <p>醴陵釉传统制瓷技艺，国家级非遗项目</p>
                    <div class="stats">★★★★☆ 4.5 | 浏览 434</div>
                    <button class="btn" onclick="window.location.href='heritage-taoci.jsp'">详情</button>
                </div>
                <!-- 项目2 -->
                <div class="project-item" onclick="window.location.href='heritageDetail.jsp?id=2'">
                    <img src="images/南京云锦.png" alt="南京云锦">
                    <h3>南京云锦</h3>
                    <p>中国传统丝织工艺，皇家御用织物</p>
                    <div class="stats">★★★★★ 4.8 | 浏览 512</div>
                    <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=2'">详情</button>
                </div>
                <!-- 项目3 -->
                <div class="project-item" onclick="window.location.href='heritage-cixiu.jsp'">
                    <img src="images/刺绣.jpeg" alt="苏绣">
                    <h3>苏绣</h3>
                    <p>苏州传统刺绣技艺，四大名绣之首</p>
                    <div class="stats">★★★★☆ 4.7 | 浏览 452</div>
                    <button class="btn" onclick="window.location.href='heritage-cixiu.jsp'">详情</button>
                </div>
                <!-- 项目4 -->
                <div class="project-item" onclick="window.location.href='heritageDetail.jsp?id=4'">
                    <img src="images/川剧变脸.png" alt="川剧变脸">
                    <h3>川剧变脸</h3>
                    <p>四川传统戏曲表演技艺，特色艺术形式</p>
                    <div class="stats">★★★★☆ 4.7 | 浏览 623</div>
                    <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=4'">详情</button>
                </div>
                <!-- 项目5 -->
                <div class="project-item" onclick="window.location.href='heritage-jianzhi.jsp'">
                    <img src="images/剪纸.jpeg" alt="传统剪纸">
                    <h3>传统剪纸</h3>
                    <p>中国民间传统装饰艺术，历史悠久</p>
                    <div class="stats">★★★★☆ 4.6 | 浏览 380</div>
                    <button class="btn" onclick="window.location.href='heritage-jianzhi.jsp'">详情</button>
                </div>
                <!-- 项目6 -->
                <div class="project-item" onclick="window.location.href='heritage-jianzhu.jsp'">
                    <img src="images/建筑.jpeg" alt="传统建筑">
                    <h3>传统建筑文化</h3>
                    <p>中国古代木结构建筑营造技艺</p>
                    <div class="stats">★★★★☆ 4.6 | 浏览 485</div>
                    <button class="btn" onclick="window.location.href='heritage-jianzhu.jsp">详情</button>
                </div>
            </div>
            <div class="more-btn">
                <button class="btn" onclick="window.location.href='heritage-project.jsp'">查看更多</button>
            </div>
        </div>

        <!-- 最新非遗项目+右侧资讯（项目添加跳转） -->
        <div class="mixed-section">
            <div class="latest-projects">
                <div class="section-title">
                    <h2>最新非遗项目</h2>
                </div>
                <div class="latest-grid">
                    <div class="latest-item" onclick="window.location.href='heritage-taoci.jsp'">
                        <img src="images/拉坯.jpg" alt="项目1">
                        <h3>景德镇陶瓷</h3>
                        <button class="btn" onclick="window.location.href='heritage-taoci.jsp'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritage-cixiu.jsp'">
                        <img src="images/刺绣1.jpg" alt="项目2">
                        <h3>苏绣</h3>
                        <button class="btn" onclick="window.location.href='heritage-cixiu.jsp'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritage-jianzhi.jsp5'">
                        <img src="images/剪纸.jpeg" alt="项目3">
                        <h3>传统剪纸</h3>
                        <button class="btn" onclick="window.location.href='heritage-jianzhi.jsp'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritage-detail.jsp'">
                        <img src="images/jingju1.jpg" alt="项目4">
                        <h3>京剧艺术</h3>
                        <button class="btn" onclick="window.location.href='heritage-detail.jsp'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=8'">
                        <img src="images/敦煌壁画.png" alt="项目5">
                        <h3>敦煌壁画</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=8'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=9'">
                        <img src="images/中华老字号.png" alt="项目6">
                        <h3>中华老字号</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=9'">详情</button>
                    </div>
                </div>
            </div>
            <div class="news-side">
                <h3>行业动态</h3>
                <ul class="news-list">
                    <li><a href="newsDetail.jsp?id=1">⚫ 2025非遗文化博览会将于下月举办</a></li>
                    <li><a href="newsDetail.jsp?id=2">⚫ 新一批国家级非遗传承人名单公布</a></li>
                    <li><a href="newsDetail.jsp?id=3">⚫ 非遗数字化保护项目取得新进展</a></li>
                    <li><a href="newsDetail.jsp?id=4">⚫ 传统技艺进校园活动在多地开展</a></li>
                    <li><a href="newsDetail.jsp?id=5">⚫ 非遗文创产品设计大赛启动征集</a></li>
                </ul>
                <h3 style="margin-top:20px;">最新讨论</h3>
                <ul class="news-list">
                    <li><a href="commentDetail.jsp?id=1">⭐ 用户123：景德镇陶瓷太精美了！</a></li>
                    <li><a href="commentDetail.jsp?id=2">⭐ 用户456：苏绣的细节太震撼了</a></li>
                    <li><a href="commentDetail.jsp?id=2">⭐ 用户456：苏绣的细节太震撼了</a></li>
                </ul>
            </div>
        </div>

        <!-- 非遗分类区域（分类添加跳转） -->
        <div class="category-section">
            <div class="section-title">
                <h2>非遗分类</h2>
                <p>按类别浏览非遗项目</p>
            </div>
            
            
            <div class="category-grid">
			    <div class="category-item" onclick="window.location.href='heritage-project.jsp?type=民间工艺'">
			        <h3>传统工艺</h3>
			        <p>传统手工制作技艺</p>
			    </div>
			
			    <div class="category-item" onclick="window.location.href='heritage-project.jsp?type=传统音乐'">
			        <h3>传统音乐</h3>
			        <p>民族民间音乐艺术</p>
			    </div>
			
			    <div class="category-item" onclick="window.location.href='heritage-project.jsp?type=传统舞蹈'">
			        <h3>传统舞蹈</h3>
			        <p>民间传统舞蹈形式</p>
			    </div>
			    
				<div class="category-item" onclick="window.location.href='heritage-project.jsp?type=传统戏剧'">
                    <h3>传统戏剧</h3>
                    <p>地方戏曲表演艺术</p>
                </div>
			    <div class="category-item" onclick="window.location.href='heritage-project.jsp?type=传统建筑'">
			        <h3>建筑文化</h3>
			        <p>传统建筑营造技艺</p>
			    </div>
			
			    <div class="category-item" onclick="window.location.href='heritage-project.jsp?type=传统美食'">
			        <h3>饮食文化</h3>
			        <p>传统饮食制作技艺</p>
			    </div>
			
			    <div class="category-item" onclick="window.location.href='heritage-project.jsp?type=民间文学'">
			        <h3>传统文学</h3>
			        <p>民间口头文学作品</p>
			    </div>
			    
			    <div class="category-item" onclick="window.location.href='heritage-project.jsp?type=传统医药'">
                    <h3>传统医药</h3>
                    <p>传统医药疗法</p>
                </div>
			</div>
			            

        </div>
    </div>

    <!-- 底部版权 -->
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