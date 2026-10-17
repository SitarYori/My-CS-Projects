<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>非遗文化传承平台 - 注册</title>
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
        .register-container {
            width: 500px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 40px 50px;
        }
        .register-container .logo {
            text-align: center;
            margin-bottom: 20px;
        }
        .register-container .logo i {
            font-size: 24px;
            color: #8B4513;
        }
        .register-container h3 {
            font-size: 20px;
            text-align: center;
            margin-bottom: 5px;
        }
        .register-container .sub-title {
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
        .form-group .tip {
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
        .register-btn {
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
        .register-btn:hover {
            background: #A0522D;
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
    <div class="register-container">
        <div class="logo">
            <i class="fa fa-university"></i>
        </div>
        <h3>创建新账户</h3>
        <p class="sub-title">注册后即可畅享非遗平台全部功能</p>
        <form action="register1.jsp" method="post">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" name="username" placeholder="请输入3-16位字母/数字组合" required>
                <div class="tip">请勿包含特殊字符</div>
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" name="password" placeholder="请输入6-18位密码" required>
                <div class="tip">建议包含字母和数字，提高安全性</div>
            </div>
            <div class="form-group">
                <label>确认密码</label>
                <input type="password" name="repassword" placeholder="请再次输入密码" required>
            </div>
            <div class="form-group">
                <label>邮箱</label>
                <input type="email" name="email" placeholder="请输入有效邮箱地址" required>
                <div class="tip">用于找回密码和接收平台通知</div>
            </div>
            <button type="submit" class="register-btn">完成注册</button>
            <div class="link-text">
                已有账号？<a href="login.jsp">立即登录</a>
            </div>
            <div class="link-text" style="margin-top: 10px;">
                <a href="forgot.jsp">找回密码</a>
            </div>
        </form>
    </div>
</body>
</html>