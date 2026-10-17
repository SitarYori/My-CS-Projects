<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>非遗文化传承平台 - 找回密码</title>
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
        .forgot-container {
            width: 500px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 40px 50px;
        }
        .forgot-container .logo {
            text-align: center;
            margin-bottom: 20px;
        }
        .forgot-container .logo i {
            font-size: 24px;
            color: #8B4513;
        }
        .forgot-container h3 {
            font-size: 20px;
            text-align: center;
            margin-bottom: 5px;
        }
        .forgot-container .sub-title {
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
        .form-group .verify-code {
            display: flex;
            gap: 10px;
        }
        .form-group .verify-code input {
            flex: 2;
        }
        .form-group .verify-code button {
            flex: 1;
            padding: 12px 15px;
            background: #eee;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
        .form-group .verify-code button:hover {
            background: #e0e0e0;
        }
        .submit-btn {
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
        .submit-btn:hover {
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
    <div class="forgot-container">
        <div class="logo">
            <i class="fa fa-university"></i>
        </div>
        <h3>找回您的密码</h3>
        <p class="sub-title">通过注册时填写的邮箱验证身份，重置密码</p>
        <form action="forgot" method="post">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" name="username" placeholder="请输入您的注册用户名" required>
            </div>
            <div class="form-group">
                <label>注册邮箱</label>
                <input type="email" name="email" placeholder="请输入您的注册邮箱" required>
            </div>
            <div class="form-group">
                <label>邮箱验证码</label>
                <div class="verify-code">
                    <input type="text" name="code" placeholder="请输入6位验证码" required>
                    <button type="button" id="sendCodeBtn">获取验证码</button>
                </div>
            </div>
            <div class="form-group">
                <label>新密码</label>
                <input type="password" name="newPassword" placeholder="请输入6-18位新密码" required>
            </div>
            <button type="submit" class="submit-btn">重置密码</button>
            <div class="link-text">
                想起密码了？<a href="login.jsp">立即登录</a>
            </div>
            <div class="link-text" style="margin-top: 10px;">
                还没有账号？<a href="register.jsp">立即注册</a>
            </div>
        </form>
    </div>

    <!-- 简单的验证码倒计时脚本（可选） -->
    <script>
        const sendCodeBtn = document.getElementById('sendCodeBtn');
        let countdown = 60;
        let timer = null;

        sendCodeBtn.onclick = function() {
            if (timer) return;

            // 模拟发送验证码（实际项目需后端接口支持）
            this.innerText = `${countdown}s后重新获取`;
            this.disabled = true;

            timer = setInterval(() => {
                countdown--;
                if (countdown <= 0) {
                    clearInterval(timer);
                    timer = null;
                    countdown = 60;
                    this.innerText = '获取验证码';
                    this.disabled = false;
                } else {
                    this.innerText = `${countdown}s后重新获取`;
                }
            }, 1000);
        }
    </script>
</body>
</html>