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
    <title>首页</title>
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
        .top-nav {
            background-color: #8B4513;
            color: #fff;
            padding: 15px 0;
            text-align: center;
        }
        .nav-container {
            width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-logo {
            font-size: 22px; /* 增大logo字体 */
            font-weight: bold;
        }
        .nav-menu {
            display: flex;
            gap: 25px;
        }
        .nav-menu a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
        }
        .nav-menu a:hover {
            text-decoration: underline;
        }
        /* 用户信息区域 - 添加框框样式 */
        .nav-user {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 8px 15px;
            border: 2px solid #F1C27D; /* 金色边框（框框） */
            border-radius: 8px; /* 圆角优化 */
            background-color: rgba(241, 194, 125, 0.1); /* 浅金色背景 */
        }
        .user-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #F1C27D;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden; /* 裁剪头像超出部分 */
        }
        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 头像自适应 */
        }
        .nav-user .username {
            color: #F1C27D; /* 用户名金色字体 */
            font-weight: 500;
        }
        .nav-user a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.2s;
        }
        .nav-user a:hover {
            text-decoration: underline;
            background-color: rgba(241, 194, 125, 0.3); /* 悬浮背景高亮 */
        }
        /* 未登录状态的框框样式 */
        .nav-user.unlogin {
            border: 2px solid #E8C8A8;
            background-color: rgba(232, 200, 168, 0.1);
        }
        .nav-user.unlogin a {
            color: #F1C27D;
        }

        /* 头部banner */
        .header-banner {
            background-color: #8B4513;
            color: #fff;
            text-align: center;
            padding: 40px 20px;
        }
        .header-banner h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .header-banner p {
            font-size: 14px;
            margin-bottom: 20px;
        }
        .header-banner .btn {
            background-color: #F1C27D;
            color: #8B4513;
            border: none;
            padding: 8px 20px;
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
        .footer {
            background-color: #8B4513;
            color: #fff;
            text-align: center;
            padding: 20px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <!-- 顶部导航栏（居中+用户信息框框+完善交互） -->
    <div class="top-nav">
        <div class="nav-container">
            <div class="nav-logo">非遗文化传承</div>
            <div class="nav-menu">
                <a href="success-login.jsp">首页</a>
                <a href="heritage-project.jsp">非遗项目</a>
                <a href="inheritor.jsp">传承人</a>
                <a href="community.jsp">文化社区</a>
                <a href="courses.jsp">在线课堂</a>
                <a href="notice.jsp">公告</a>
                <a href="ai-assistant.jsp">AI小助手</a>
            </div>
    
                    <!-- 未登录状态：带框框+登录按钮 -->
                    <div class="nav-user unlogin">
                        <a href="login.jsp" title="前往登录页面">请登录</a>
                    </div>
            
        </div>
    </div>

    <!-- 头部Banner -->
    <div class="header-banner">
        <h1>传承千年文化 守护民族瑰宝</h1>
        <p>探索国家级非物质文化遗产的魅力，感受中华文明的深厚底蕴</p>
        <button class="btn" onclick="window.location.href='heritage_detail.jsp'">立即探索</button>
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
                <button class="btn" onclick="window.location.href='heritageList.jsp'">查看更多</button>
            </div>
        </div>

        <!-- 最新非遗项目+右侧资讯（项目添加跳转） -->
        <div class="mixed-section">
            <div class="latest-projects">
                <div class="section-title">
                    <h2>最新非遗项目</h2>
                </div>
                <div class="latest-grid">
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=1'">
                        <img src="images/最新1.jpg" alt="项目1">
                        <h3>景德镇陶瓷</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=1'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=3'">
                        <img src="images/最新2.jpg" alt="项目2">
                        <h3>苏绣</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=3'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=5'">
                        <img src="images/最新3.jpg" alt="项目3">
                        <h3>传统剪纸</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=5'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=7'">
                        <img src="images/最新4.jpg" alt="项目4">
                        <h3>京剧艺术</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=7'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=8'">
                        <img src="images/最新5.jpg" alt="项目5">
                        <h3>敦煌壁画</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=8'">详情</button>
                    </div>
                    <div class="latest-item" onclick="window.location.href='heritageDetail.jsp?id=9'">
                        <img src="images/最新6.jpg" alt="项目6">
                        <h3>中华老字号</h3>
                        <button class="btn" onclick="window.location.href='heritageDetail.jsp?id=9'">详情</button>
                    </div>
                </div>
            </div>
            <div class="news-side">
                <h3>行业动态</h3>
                <ul class="news-list">
                    <li><a href="newsDetail.jsp?id=1">2025非遗文化博览会将于下月举办</a></li>
                    <li><a href="newsDetail.jsp?id=2">新一批国家级非遗传承人名单公布</a></li>
                    <li><a href="newsDetail.jsp?id=3">非遗数字化保护项目取得新进展</a></li>
                    <li><a href="newsDetail.jsp?id=4">传统技艺进校园活动在多地开展</a></li>
                    <li><a href="newsDetail.jsp?id=5">非遗文创产品设计大赛启动征集</a></li>
                </ul>
                <h3 style="margin-top:20px;">最新评论</h3>
                <ul class="news-list">
                    <li><a href="commentDetail.jsp?id=1">用户123：景德镇陶瓷太精美了！</a></li>
                    <li><a href="commentDetail.jsp?id=2">用户456：苏绣的细节太震撼了</a></li>
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
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=传统工艺'">
                    <h3>传统工艺</h3>
                    <p>传统手工制作技艺</p>
                </div>
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=传统音乐'">
                    <h3>传统音乐</h3>
                    <p>民族民间音乐艺术</p>
                </div>
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=传统舞蹈'">
                    <h3>传统舞蹈</h3>
                    <p>民间传统舞蹈形式</p>
                </div>
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=传统戏剧'">
                    <h3>传统戏剧</h3>
                    <p>地方戏曲表演艺术</p>
                </div>
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=传统文学'">
                    <h3>传统文学</h3>
                    <p>民间口头文学作品</p>
                </div>
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=建筑文化'">
                    <h3>建筑文化</h3>
                    <p>传统建筑营造技艺</p>
                </div>
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=饮食文化'">
                    <h3>饮食文化</h3>
                    <p>传统饮食制作技艺</p>
                </div>
                <div class="category-item" onclick="window.location.href='heritageList.jsp?type=民俗活动'">
                    <h3>民俗活动</h3>
                    <p>民间传统节庆习俗</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 底部版权 -->
    <div class="footer">
        <p>关于我们 | 联系我们 | 隐私政策</p>
        <p>© 2025 非遗文化传承平台 版权所有</p>
    </div>
</body>
</html>