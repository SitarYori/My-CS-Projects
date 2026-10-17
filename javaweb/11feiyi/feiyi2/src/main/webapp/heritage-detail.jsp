<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>京剧音乐艺术 - 非遗项目详情</title>
    <style>
        :root {
            --main-brown: #8B4513;
            --dark-brown: #5D2E0C;
            --accent-gold: #F1C27D;
            --light-bg: #FDF5E6;
            --border-color: #EBD9B4;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", sans-serif; }
        body { background-color: var(--light-bg); color: #333; line-height: 1.6; }

        /* 导航栏复用 */
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

        /* 面包屑导航 */
        .breadcrumb { width: 1100px; margin: 20px auto; font-size: 13px; color: #888; }
        .breadcrumb a { color: #888; text-decoration: none; transition: 0.3s; }
        .breadcrumb a:hover { color: var(--main-brown); }

        /* 详情头部 Banner */
        .detail-header { background-color: var(--main-brown); color: #fff; padding: 40px 0; margin-bottom: 30px; }
        .header-content { width: 1100px; margin: 0 auto; }
        .header-content h1 { font-size: 32px; margin-bottom: 15px; letter-spacing: 2px; }
        .stats-bar { display: flex; gap: 20px; font-size: 14px; opacity: 0.9; }
        .stat-tag { background: rgba(255,255,255,0.15); padding: 4px 12px; border-radius: 4px; border: 1px solid rgba(255,255,255,0.2);  transition: all 0.2s ease; /* 新增：过渡动画 */}
        .stat-tag:hover { /* 新增：悬浮高亮 */background: rgba(255,255,255,0.25); border-color: rgba(255,255,255,0.4); }
        
        /* 主体布局 */
        .main-layout { width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 1fr 300px; gap: 30px; padding-bottom: 60px; }

        /* 左侧内容区 */
        .content-card { background: #fff; border-radius: 8px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 25px; border: 1px solid #f0f0f0; }
        .section-title { font-size: 18px; font-weight: bold; color: var(--dark-brown); margin-bottom: 20px; display: flex; align-items: center; gap: 10px; border-bottom: 2px solid var(--light-bg); padding-bottom: 10px; }
        
        .main-img { width: 100%; border-radius: 6px; margin-bottom: 20px; border: 5px solid #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .text-content { font-size: 15px; color: #555; text-indent: 2em; margin-bottom: 20px; }

        /* 右侧侧边栏 */
        .side-card { background: #fff; border-radius: 8px; padding: 25px; border: 1px solid var(--border-color); margin-bottom: 20px; text-align: center; }
        .inheritor-avatar { width: 80px; height: 80px; border-radius: 50%; border: 2px solid var(--accent-gold); margin-bottom: 15px; }
        .side-btn { display: block; width: 100%; padding: 10px; margin-top: 15px; border: 1px solid var(--main-brown); color: var(--main-brown); text-decoration: none; border-radius: 4px; font-size: 14px; transition: 0.3s; }
        .side-btn:hover { background: var(--main-brown); color: #fff; }

        /* 评论区样式 */
        .comment-item { border-bottom: 1px solid #eee; padding: 20px 0; display: flex; gap: 15px; }
        .comment-avatar { width: 45px; height: 45px; border-radius: 50%; background: #eee; }
        .comment-info { flex: 1; }
        .comment-user { font-weight: bold; font-size: 14px; color: var(--main-brown); display: flex; justify-content: space-between; }
        .comment-date { font-weight: normal; font-size: 12px; color: #999; }
        .comment-text { margin-top: 8px; font-size: 14px; color: #666; }
        .stars { color: #F1C40F; font-size: 12px; margin-top: 5px; }

        /* 提交表单 */
        .comment-form textarea { width: 100%; height: 100px; padding: 15px; border: 1px solid #ddd; border-radius: 6px; margin: 15px 0; outline: none; resize: none; }
        .submit-btn { background: var(--main-brown); color: #fff; border: none; padding: 10px 30px; border-radius: 4px; cursor: pointer; float: right; }

        /* 页脚复用 */
        .footer { background: var(--dark-brown); color: #999; padding: 40px 0; text-align: center; font-size: 13px; }
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

    <div class="breadcrumb">
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 京剧音乐艺术
    </div>

    <header class="detail-header">
        <div class="header-content">
            <h1>京剧音乐艺术</h1>
            <div class="stats-bar">
                <span class="stat-tag">🏷️ 传统音乐</span>
                <span class="stat-tag">👤 传承人：张艺术家</span>
                <span class="stat-tag">👁️ 浏览：1,341</span>
                <span class="stat-tag">❤️ 收藏：128</span>
                <span class="stat-tag">⭐ 评分：4.65</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <img src="images/jingju1.jpg" class="main-img" alt="京剧艺术">
                
                <div class="section-title">📜 项目简介</div>
                <p class="text-content">
                    京剧音乐是中国传统音乐的精华。它以西皮、二黄为主要腔调，伴奏乐器分为文场（以京胡为主）和武场（以打击乐为主）。其旋律优美动听，节奏感强，具有极高的艺术感染力。
                </p>

                <div class="section-title">📖 详细介绍</div>
                <p class="text-content">
                    京剧音乐具有独特的表现力，融合了中国古代音乐理论和民间音乐传统，形成了独具特色的音乐体系。它不仅是戏曲表演的灵魂，更是研究中华民族音乐文化演进的重要“活化石”。
                </p>
                <p class="text-content">
                    在其长期的发展过程中，京剧音乐吸收了昆曲、秦腔等多种地方戏曲的元素，通过一代代艺人的加工提炼，变得愈发严谨且富有变化。
                </p>
            </div>

            <div class="content-card">
                <div class="section-title">💬 用户点评 (1)</div>
                
                <div class="comment-form">
                    <p style="font-size:14px; color:#666;">发表点评：</p>
                    <div style="margin-top:10px;">
                        评分：
                        <select style="padding:4px;">
                            <option>★★★★★ 非常好</option>
                            <option>★★★★ 比较好</option>
                            <option>★★★ 一般</option>
                        </select>
                    </div>
                    <textarea placeholder="分享您对这个非遗项目的看法..."></textarea>
                    <button class="submit-btn">提交点评</button>
                    <div style="clear:both;"></div>
                </div>

                <div class="comment-item">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user1" class="comment-avatar">
                    <div class="comment-info">
                        <div class="comment-user">
                            user1
                            <span class="comment-date">2025-12-02 17:08</span>
                        </div>
                        <div class="stars">★★★★★</div>
                        <div class="comment-text">京剧音乐很有韵味，体现了中国传统音乐的精髓。</div>
                    </div>
                </div>
            </div>
        </div>

<%
    // 核心：获取地址栏 ?id=xx 的值
    String currentId = request.getParameter("id"); 
    
    boolean isAlreadyFav = false;
    com.fy.entity.User userObj = (com.fy.entity.User) session.getAttribute("loginUser");
    
    // 只有当 currentId 有值时才去查数据库
    if (userObj != null && currentId != null && !currentId.trim().isEmpty()) {
        try {
            int hid = Integer.parseInt(currentId);
            isAlreadyFav = new com.fy.dao.FavoriteDao().isFavorited(userObj.getId(), hid);
        } catch (Exception e) {
            e.printStackTrace(); 
        }
    }
%>

<div class="right-col">
    <div class="side-card">
        <div style="font-size:15px; font-weight:bold; margin-bottom:15px; border-bottom:1px solid #eee; padding-bottom:10px;">❤️ 收藏项目</div>
        <p style="font-size:12px; color:#999; margin-bottom:10px;">点击下方按钮收藏到个人中心</p>
        
        <%-- 这里一定要确保 onclick 里的参数被 JSP 正确输出了 --%>
        <button id="collectBtn" class="side-btn" 
                style="background: <%= isAlreadyFav ? "#F1C27D" : "#FDF5E6" %>;" 
                onclick="handleFavorite('<%= (currentId == null) ? "" : currentId %>')">
            ⭐ <span id="favText"><%= isAlreadyFav ? "已收藏" : "点击收藏" %></span>
        </button>
    </div>

    <%-- 传承人卡片 (略) --%>
    <div class="side-card">
        <div class="section-title" style="font-size:15px; justify-content:center;">👤 传承人信息</div>
        <img src="images/张艺术家.jpg" class="inheritor-avatar">
        <p style="font-weight:bold;">张艺术家</p>
        <a href="inheritor-jingju.jsp?id=1" class="side-btn">查看详情</a>
    </div>
</div>

<script>
function handleFavorite(hid) {
    // 这里的判断对应了 image_b40006.png 的报错逻辑
    if(!hid || hid === "" || hid === "null") {
        alert("错误：详情页未检测到项目ID！请返回列表重新进入。");
        return;
    }
    
    fetch('FavoriteServlet?action=toggle&heritageId=' + hid)
        .then(response => response.text())
        .then(result => {
            const btn = document.getElementById('collectBtn');
            const text = document.getElementById('favText');
            
            if (result.trim() === "added") {
                alert("收藏成功！");
                text.innerText = "已收藏";
                btn.style.background = "#F1C27D"; 
            } else if (result.trim() === "removed") {
                alert("已取消收藏");
                text.innerText = "点击收藏";
                btn.style.background = "#FDF5E6";
            } else if (result.trim() === "not_logged_in") {
                alert("请先登录！");
                window.location.href = "login.jsp";
            } else {
                alert("操作失败：" + result);
            }
        })
        .catch(err => {
            console.error("Fetch Error:", err);
            alert("请求发送失败，请检查网络");
        });
}
</script>
    </div>

    <footer class="footer">
        <p>© 2025 非遗文化传承平台 版权所有 | 传承文化 守护经典</p>
    </footer>

</body>
</html>