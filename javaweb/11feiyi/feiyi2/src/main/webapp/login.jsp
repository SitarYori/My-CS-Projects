<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>非遗文化传承平台 - 登录</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
        body {
            background: #f5f5f5 url("images/jingju.jpeg") no-repeat left top;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .login-container {
            width: 800px;
            height: 500px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            display: flex;
            overflow: hidden;
        }
        .left-panel {
            width: 40%;
            background: #8B4513; /* 棕色调 */
            color: #fff;
            padding: 40px 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .left-panel h2 {
            font-size: 22px;
            margin-bottom: 10px;
        }
        /* 白色字体改为背景色小字 */
        .left-panel .desc-text {
            font-size: 12px; /* 缩小字号 */
            line-height: 1.6;
            margin-bottom: 30px;
            color: #E8C8A8; /* 背景对应的浅棕色 */
        }
        .feature-item {
            background: rgba(255,255,255,0.2);
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .feature-item i {
            font-size: 20px;
            margin-right: 10px;
        }
        /* 功能项描述改为背景色小字 */
        .feature-item .feature-desc {
            font-size: 12px;
            color: #E8C8A8; /* 背景对应的浅棕色 */
        }
        .feature-item h4 {
            font-size: 14px;
            margin-bottom: 3px;
        }
        /* 管理员入口样式（添加跳转交互） */
        .admin-entry {
            font-size: 12px;
            color: #E8C8A8; /* 背景对应的浅棕色 */
            text-decoration: underline;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        /* 鼠标悬浮效果，提升交互体验 */
        .admin-entry:hover {
            color: #fff;
            text-decoration: none;
        }
        .right-panel {
            width: 60%;
            padding: 40px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .right-panel .logo {
            text-align: center;
            margin-bottom: 20px;
        }
        .right-panel .logo i {
            font-size: 24px;
            color: #8B4513;
        }
        .right-panel h3 {
            font-size: 20px;
            text-align: center;
            margin-bottom: 5px;
        }
        .right-panel .sub-title {
            font-size: 12px;
            color: #666;
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
        }
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-group input::placeholder {
            color: #999;
        }
        .login-btn {
            width: 100%;
            padding: 12px;
            background: #8B4513;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 15px;
        }
        .login-btn:hover {
            background: #A0522D;
        }
        .divider {
            text-align: center;
            font-size: 12px;
            color: #999;
            margin: 15px 0;
        }
        .link-text {
            text-align: center;
            font-size: 12px;
        }
        .link-text a {
            color: #8B4513;
            text-decoration: none;
        }
        .link-text a:hover {
            text-decoration: underline;
        }
    </style>
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div class="login-container">
        <!-- 左侧面板 -->
        <div class="left-panel">
            <div>
                <h2>非遗文化传承平台</h2>
                <!-- 白色字体改为背景色小字 -->
                <p class="desc-text">登录您的账户，探索中华非物质文化遗产的无穷魅力，与志同道合的朋友一起传承和保护民族瑰宝。</p>
                <div class="feature-item">
                    <i class="fa fa-list-alt"></i>
                    <div>
                        <h4>丰富的非遗项目</h4>
                        <!-- 功能项描述改为背景色小字 -->
                        <p class="feature-desc">收录数百种非物质文化遗产项目</p>
                    </div>
                </div>
                <div class="feature-item">
                    <i class="fa fa-user"></i>
                    <div>
                        <h4>传承人风采</h4>
                        <p class="feature-desc">了解非遗传承人的故事与技艺</p>
                    </div>
                </div>
                <div class="feature-item">
                    <i class="fa fa-comments"></i>
                    <div>
                        <h4>文化交流社区</h4>
                        <p class="feature-desc">与非遗爱好者互动交流</p>
                    </div>
                </div>
            </div>
            <!-- 管理员入口：添加<a>标签实现跳转至admin.jsp -->
            <a href="admin.jsp" class="admin-entry" style="text-decoration: none;">
                <i class="fa fa-lock"></i> 管理员登录入口 →
            </a>
        </div>
        <!-- 右侧登录面板 -->
        <div class="right-panel">
            <div class="logo">
                <i class="fa fa-university"></i>
            </div>
            <h3>欢迎回来</h3>
            <p class="sub-title">请登录您的账户继续探索</p>
            <form action="login" method="post">
                <div class="form-group">
                    <label>用户名/邮箱</label>
                    <input type="text" name="username" placeholder="请输入用户名或邮箱" required>
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" name="password" placeholder="请输入密码" required>
                </div>
				        <% 
						    String error = request.getParameter("error");
						    if ("1".equals(error)) {
						        // 红色大字+匹配页面的居中/间距样式
						        out.print("<div style='text-align: center; color: red; font-size: 16px; font-weight: bold; margin-bottom: 15px;'>用户名或密码不正确</div>");
						    }
						%>
                <button type="submit" class="login-btn">立即登录</button>
                <div class="divider">或</div>
                <div class="link-text">
                    还没有账号？<a href="register.jsp">立即注册</a>
                </div>
                <div class="link-text" style="margin-top: 10px;">
                    <a href="forgot.jsp">找回密码</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>