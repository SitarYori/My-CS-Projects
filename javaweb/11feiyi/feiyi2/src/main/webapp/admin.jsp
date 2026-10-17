<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>非遗文化传承平台 - 管理员登录</title>
    <style>
        /* 与主登录页统一风格的样式 */
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
        .admin-login-container {
            width: 400px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 40px;
        }
        .admin-login-container h3 {
            font-size: 20px;
            text-align: center;
            margin-bottom: 20px;
            color: #8B4513;
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
        .admin-login-btn {
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
        .admin-login-btn:hover {
            background: #A0522D;
        }
        .back-link {
            text-align: center;
            font-size: 12px;
        }
        .back-link a {
            color: #8B4513;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="admin-login-container">
        <h3>管理员专属登录</h3>
        <form action="admin-project.jsp" method="post">
            <div class="form-group">
                <label>管理员账号</label>
                <input type="text" name="adminName" placeholder="请输入管理员账号" required>
            </div>
            <div class="form-group">
                <label>管理员密码</label>
                <input type="password" name="adminPwd" placeholder="请输入管理员密码" required>
            </div>
            <button type="submit" class="admin-login-btn">登录后台</button>
            <div class="back-link">
                <a href="login.jsp">返回普通用户登录</a>
            </div>
        </form>
    </div>
</body>
</html>