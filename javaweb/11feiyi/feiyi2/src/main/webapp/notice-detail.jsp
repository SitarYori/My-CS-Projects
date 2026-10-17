<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>公告详情 - 非遗文化传承平台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background-color: #FDF5E6; margin: 0; color: #333; }
        .container { width: 900px; margin: 40px auto; display: flex; flex-direction: column; gap: 25px; }
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
       
        /* 公告正文卡片 */
        .notice-card { background: white; padding: 50px 70px; border-radius: 8px; box-shadow: 0 2px 15px rgba(0,0,0,0.05); position: relative; }
        
        /* 模拟公文红线装饰 */
        .notice-card::before { content: ""; position: absolute; top: 30px; left: 70px; right: 70px; height: 2px; background: #BA1E1E; }

        .notice-title { text-align: center; color: #BA1E1E; font-size: 28px; margin: 40px 0 20px 0; font-family: "KaiTi"; font-weight: bold; }
        
        .notice-meta { text-align: center; color: #999; font-size: 14px; padding-bottom: 30px; border-bottom: 1px dashed #DDD; margin-bottom: 30px; }
        .notice-meta span { margin: 0 15px; }

        .notice-body { line-height: 2; font-size: 16px; color: #444; min-height: 300px; text-indent: 2em; }
        .notice-body p { margin-bottom: 20px; }

        /* 附件区域 */
        .attachment-box { background: #F9F9F9; border: 1px solid #EEE; padding: 15px 20px; border-radius: 4px; margin-top: 40px; }
        .attachment-item { display: flex; align-items: center; text-decoration: none; color: #0288D1; font-size: 14px; }
        .attachment-item i { margin-right: 10px; font-size: 18px; }

        /* 底部落款 */
        .notice-footer { margin-top: 50px; text-align: right; color: #555; line-height: 1.6; }

        /* 返回按钮 */
        .back-bar { display: flex; justify-content: space-between; align-items: center; }
        .btn-back { text-decoration: none; color: #8B4513; font-weight: bold; display: flex; align-items: center; gap: 8px; }
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
        <div class="back-bar">
            <a href="notice.jsp" class="btn-back"><i class="fas fa-chevron-left"></i> 返回公告列表</a>
            <div style="color: #999; font-size: 13px;">当前位置：首页 > 公告详情</div>
        </div>

        <div class="notice-card">
            <%
                // 模拟获取参数
                String id = request.getParameter("id");
                // 实际开发应根据 ID 查询数据库：Notice n = dao.findById(id);
            %>
            
            <h1 class="notice-title">关于开展“非遗进校园”系列直播活动的通知</h1>
            
            <div class="notice-meta">
                <span><i class="far fa-clock"></i> 发布时间：2023-10-25</span>
                <span><i class="far fa-eye"></i> 浏览量：1,284</span>
                <span><i class="far fa-user"></i> 发布者：系统管理员</span>
            </div>

            <div class="notice-body">
                <p>各非遗传承人、广大文化爱好者：</p>
                <p>为进一步弘扬中华优秀传统文化，提升青少年对非物质文化遗产的保护意识，本平台将于下周起正式启动“非遗进校园”系列直播互动活动。</p>
                <p>本次活动将邀请包括<strong>陈师傅（陶瓷技艺）</strong>、<strong>王老师（传统剪纸）</strong>在内的多位国家级及省级非遗传承人，通过实时视频直播的方式，在线展示非遗技艺的独特魅力，并与学生代表进行面对面交流。</p>
                <p>活动期间，平台将同步开放“非遗知识竞赛”赢好礼环节，欢迎各位届时准时参加。</p>
            </div>

            <div class="attachment-box">
                <div style="font-weight: bold; margin-bottom: 10px; font-size: 14px; color: #333;">相关附件：</div>
                <a href="#" class="attachment-item">
                    <i class="far fa-file-pdf"></i> 非遗进校园活动详细流程表.pdf (1.2MB)
                </a>
            </div>

            <div class="notice-footer">
                <p>非遗文化传承平台运营中心</p>
                <p>2023年10月25日</p>
            </div>
        </div>
    </div>

</body>
</html>