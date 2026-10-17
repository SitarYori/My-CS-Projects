<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>课程详情 - 蜀绣进阶技法与创作实践</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background-color: #FDF5E6; margin: 0; padding-bottom: 50px; }
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
        
        /* 顶部课程横幅 */
        .course-banner { 
            background-color: #A0522D; color: white; padding: 40px 10%; 
            display: flex; flex-direction: column; gap: 15px;
        }
        .course-banner h1 { margin: 0; font-size: 32px; }
        .badge-area { display: flex; gap: 10px; }
        /* 蜀绣为高级课程 */
        .badge { background: rgba(255,255,255,0.2); padding: 4px 12px; border-radius: 4px; font-size: 14px; }
        .badge-high { border: 1px solid #FF4500; color: #FF4500; background: white; }

        /* 内容主体布局 */
        .main-container { width: 85%; margin: 30px auto; display: flex; gap: 30px; }
        .content-left { flex: 2; }
        .content-right { flex: 1; }

        /* 卡片样式 */
        .card { background: white; border-radius: 8px; padding: 25px; margin-bottom: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card-title { font-size: 20px; font-weight: bold; margin-bottom: 20px; color: #5D3A1A; border-left: 5px solid #8B4513; padding-left: 15px; }

        /* 目录项 */
        .chapter-list { display: flex; flex-direction: column; gap: 15px; }
        .chapter-item { 
            display: flex; align-items: center; justify-content: space-between; 
            padding: 20px; background: #f9f9f9; border-radius: 6px; border: 1px solid #eee;
            transition: 0.3s; cursor: pointer;
        }
        .chapter-item:hover { background: #F5F5DC; border-color: #8B4513; }
        .chapter-info { display: flex; align-items: center; gap: 20px; }
        .chapter-num { width: 35px; height: 35px; background: #8B4513; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }
        .chapter-text h4 { margin: 0; font-size: 16px; }
        .chapter-text p { margin: 5px 0 0; font-size: 13px; color: #888; }
        .play-icon { color: #8B4513; font-size: 20px; }

        /* 右侧操作区 */
        .course-img { width: 100%; border-radius: 6px; margin-bottom: 20px; }
        .btn-start { 
            width: 100%; padding: 15px; background: #8B4513; color: white; 
            border: none; border-radius: 6px; font-size: 18px; cursor: pointer; 
            transition: 0.3s; margin-bottom: 25px;
        }
        .btn-start:hover { background: #5D3A1A; }
        .notice-list { padding: 0; list-style: none; color: #666; font-size: 14px; line-height: 2; }
        .notice-list li::before { content: "• "; color: #8B4513; font-weight: bold; }
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
    <div class="course-banner">
        <h1>蜀绣进阶技法与创作实践</h1>
        <div class="badge-area">
            <span class="badge badge-high">高级</span>
            <span class="badge">已发布</span>
            <span class="badge"><i class="far fa-file-alt"></i> 5 章节</span>
        </div>
    </div>

    <div class="main-container">
        <div class="content-left">
            <div class="card">
                <div class="card-title"><i class="fas fa-info-circle"></i> 课程简介</div>
                <p style="color: #666; line-height: 1.6;">
                    蜀绣作为中国四大名绣之一，以针法严谨、色彩明快著称。本进阶课程重点教授“晕针”、“平针”的高级运用，以及如何在现代丝织品上进行艺术创作实践。
                </p>
            </div>

            <div class="card">
                <div class="card-title"><i class="fas fa-list-ul"></i> 课程目录</div>
                <div class="chapter-list">
                    <div class="chapter-item">
                        <div class="chapter-info">
                            <div class="chapter-num">1</div>
                            <div class="chapter-text">
                                <h4>第一章：蜀绣的针法体系概论</h4>
                                <p>深度解析蜀绣12大类、122种针法的配合使用...</p>
                            </div>
                        </div>
                        <i class="fas fa-play-circle play-icon"></i>
                    </div>

                    <div class="chapter-item">
                        <div class="chapter-info">
                            <div class="chapter-num">2</div>
                            <div class="chapter-text">
                                <h4>第二章：晕针技法的高级表现</h4>
                                <p>学习蜀绣核心技法“晕针”，表现色彩的自然过渡...</p>
                            </div>
                        </div>
                        <i class="fas fa-file-alt play-icon"></i>
                    </div>

                    <div class="chapter-item">
                        <div class="chapter-info">
                            <div class="chapter-num">3</div>
                            <div class="chapter-text">
                                <h4>第三章：花鸟禽鱼的细节处理</h4>
                                <p>掌握蜀绣经典题材的丝理走向与光影塑造...</p>
                            </div>
                        </div>
                        <i class="fas fa-file-alt play-icon"></i>
                    </div>

                    <div class="chapter-item">
                        <div class="chapter-info">
                            <div class="chapter-num">4</div>
                            <div class="chapter-text">
                                <h4>第四章：大尺寸作品的构图布局</h4>
                                <p>进阶实操：大幅挂屏或屏风的绣制逻辑与张力控制...</p>
                            </div>
                        </div>
                        <i class="fas fa-file-alt play-icon"></i>
                    </div>

                    <div class="chapter-item">
                        <div class="chapter-info">
                            <div class="chapter-num">5</div>
                            <div class="chapter-text">
                                <h4>第五章：蜀绣现代生活美学应用</h4>
                                <p>如何将传统针法应用于现代服饰与家居设计...</p>
                            </div>
                        </div>
                        <i class="fas fa-file-alt play-icon"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="content-right">
            <div class="card" style="text-align: center;">
                <img src="images/course/shuxiu_main.jpg" alt="蜀绣" class="course-img" onerror="this.src='https://via.placeholder.com/300x200?text=蜀绣精美作品'">
                <button class="btn-start" onclick="location.href='https://www.bilibili.com/video/BV1xm4y1E7Zy/?spm_id_from=333.337.search-card.all.click?cid=1'">开始学习</button>
                
                <div style="text-align: left;">
                    <div class="card-title" style="font-size: 16px;">学习须知</div>
                    <ul class="notice-list">
                        <li>建议有一定刺绣基础的学员学习</li>
                        <li>需自备绣架、真丝底料及专用蚕丝线</li>
                        <li>高级课程作业需提交实物照片审核</li>
                        <li>完成全部5章可申领电子进阶证书</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</body>
</html>