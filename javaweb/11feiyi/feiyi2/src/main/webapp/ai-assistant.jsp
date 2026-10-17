<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>AI助手 - 非遗文化传承平台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background-color: #FDF5E6; margin: 0; padding-bottom: 30px; }
        
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
        
        /* 助手容器布局 */
        .ai-container { width: 80%; max-width: 1000px; margin: 40px auto; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        
        /* 顶部标题栏 */
        .ai-header { background: #8B4513; color: white; padding: 25px 40px; display: flex; align-items: center; gap: 20px; }
        .ai-header i { font-size: 40px; }
        .ai-header-text h2 { margin: 0; font-size: 24px; letter-spacing: 2px; }
        .ai-header-text p { margin: 5px 0 0; font-size: 14px; opacity: 0.8; }

        /* 对话区域 */
        .chat-body { padding: 40px; min-height: 400px; background-color: #fafafa; }
        .message-row { display: flex; gap: 20px; margin-bottom: 30px; }
        .ai-avatar { width: 50px; height: 50px; background: #8B4513; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; flex-shrink: 0; }
        
        /* 消息气泡 */
        .chat-bubble { 
            background: #FFF8DC; border: 1px solid #EEDC82; padding: 25px; border-radius: 0 15px 15px 15px; 
            max-width: 70%; line-height: 1.8; color: #5D3A1A; position: relative;
        }
        .chat-bubble h3 { margin-top: 0; font-size: 18px; color: #8B4513; }
        .chat-bubble ul { padding-left: 20px; margin: 15px 0; }
        .chat-bubble li { margin-bottom: 8px; list-style-type: none; }
        .chat-bubble li::before { content: "• "; color: #8B4513; font-weight: bold; }

        /* 输入框区域 */
        .input-area { padding: 20px 40px; background: white; border-top: 1px solid #eee; display: flex; gap: 15px; }
        .chat-input { flex: 1; padding: 15px; border: 1px solid #ddd; border-radius: 5px; outline: none; font-size: 16px; }
        .btn-send { background: #8B4513; color: white; border: none; padding: 0 30px; border-radius: 5px; cursor: pointer; transition: 0.3s; }
        .btn-send:hover { background: #5D3A1A; }
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
                <a href="community.jsp">文化社区</a>
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

    <div class="ai-container">
        <div class="ai-header">
            <div class="ai-avatar" style="background: rgba(255,255,255,0.2);">
                <i class="fas fa-comments"></i>
            </div>
            <div class="ai-header-text">
                <h2>非遗智能助手</h2>
                <p>探索非遗知识 · 传承文化瑰宝</p>
            </div>
        </div>

<div class="chat-body" id="chatContainer">
    <div class="message-row" id="robotMessageRow" style="display: none;">
        <div class="ai-avatar">
            <i class="fas fa-robot"></i>
        </div>
        <div class="chat-bubble" id="aiBubble">
            <div id="loadingStatus"><i class="fas fa-spinner fa-spin"></i> 助手正在思考...</div>
            <div id="realContent" style="display: none;">
                <h3>您好，我是非遗智能助手</h3>
                我可以帮您了解：
                <ul>
                    <li>非遗作品知识（苏绣、蜀绣、皮影戏等）</li>
                    <li>传承人信息和代表作品</li>
                    <li>平台活动和课程推荐</li>
                </ul>
                请问有什么可以帮助您的吗？
            </div>
        </div>
    </div>
</div>

        <div class="input-area">
            <input type="text" id="userInput" class="chat-input" placeholder="请输入您的问题...">
            <button class="btn-send" onclick="sendMessage()"><i class="fas fa-paper-plane"></i> 发送</button>
        </div>
    </div>
    <script>
    // 页面加载完成后触发动态效果
    window.onload = function() {
        const messageRow = document.getElementById("robotMessageRow");
        const loading = document.getElementById("loadingStatus");
        const content = document.getElementById("realContent");

        // 1. 延迟0.5秒显示机器人头像和“正在输入”状态
        setTimeout(() => {
            messageRow.style.display = "flex";
        }, 500);

        // 2. 模拟机器人思考2秒后，隐藏加载状态并显示真实内容
        setTimeout(() => {
            loading.style.display = "none";
            content.style.display = "block";
            // 添加一个淡入动画效果
            content.style.animation = "fadeIn 0.8s";
        }, 2000);
    };

    // 发送按钮的简单逻辑
function sendMessage() {
    var input = document.getElementById("userInput");
    var question = input.value.trim();
    if (question === "") return;

    // 1️⃣ 显示用户消息
    var chat = document.getElementById("chatContainer");
    chat.innerHTML += `
        <div class="message-row" style="justify-content:flex-end;">
            <div class="chat-bubble" style="background:#EEDC82;">
                ${question}
            </div>
        </div>`;

    input.value = "";

    // 2️⃣ 显示 AI 思考中
    chat.innerHTML += `
        <div class="message-row">
            <div class="ai-avatar"><i class="fas fa-robot"></i></div>
            <div class="chat-bubble">正在为您查询非遗资料，请稍候...</div>
        </div>`;

    // 3️⃣ 模拟 AI 回答（课程设计版）
    setTimeout(() => {
        var answer = getAIAnswer(question);
        var bubbles = document.querySelectorAll(".chat-bubble");
        bubbles[bubbles.length - 1].innerHTML = answer;
    }, 1200);
}

// ⭐ 模拟 AI 规则回答
function getAIAnswer(q) {
    if (q.includes("非遗")) {
        return "非物质文化遗产是各族人民世代相传的传统文化表现形式。";
    }
    if (q.includes("苏绣")) {
        return "苏绣是中国四大名绣之一，以针法细腻、构图典雅著称。";
    }
    if (q.includes("传承人")) {
        return "非遗传承人是非遗技艺的重要守护者和传播者。";
    }
    if (q.includes("课程")) {
        return "您可以前往【在线课堂】模块学习非遗相关课程。";
    }
    return "这是一个很有意思的问题，您可以尝试换一种方式描述。";
}

</script>

<style>
    /* 添加简单的淡入动画 */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    #loadingStatus { color: #8B4513; font-style: italic; }
</style>

</body>
</html>