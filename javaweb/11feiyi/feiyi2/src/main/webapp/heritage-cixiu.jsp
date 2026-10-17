<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fy.entity.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>苏州刺绣 - 精致专题- 非遗项目详情</title>
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
        .detail-header { background-color: var(--main-brown); 
        color: #fff; 
        padding: 40px 0; 
        margin-bottom: 30px; 
        url('images/刺绣1.jpg');
        }
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
        
        .main-img { width: 80%; border-radius: 6px; margin-bottom: 20px; border: 5px solid #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        🏠 <a href="index.jsp">首页</a> &gt; <a href="heritage-project.jsp">非遗项目</a> &gt; 苏州刺绣
    </div>

    <header class="detail-header">
        <div class="header-content">
            <h1>苏州刺绣：经纬间的江南诗意</h1>
            <div class="stats-bar">
                <span class="stat-tag">🏷️ 民间工艺</span>
                <span class="stat-tag">👤 传承人：姚大师</span>
                <span class="stat-tag">👁️ 浏览：2,452</span>
                <span class="stat-tag">❤️ 收藏：315</span>
                <span class="stat-tag">⭐ 评分：4.75</span>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <div class="left-col">
            <div class="content-card">
                <img src="images/刺绣1.jpg" class="main-img" alt="刺绣">
                
                <div class="section-title">📜 项目简介</div>
                <p class="text-content">
                    苏州刺绣是中国四大名绣之首，以“精细雅洁”著称。它以针法细密、色彩淡雅、构图精巧为特点，题材多取自花鸟、山水、人物，兼具实用与艺术价值。
                </p>

                <div class="section-title">📖 详细介绍</div>
                <p class="text-content">
                    苏绣起源于苏州吴地，历史可追溯至2000多年前的春秋时期，明清时期达到鼎盛，成为皇家贡品。它融合了江南文化的温婉气质，针法多达数十种，其中“乱针绣”突破了传统针法限制，让绣品兼具绘画的层次感与刺绣的肌理感。
                </p>
                <p class="text-content">
                    苏绣不仅是技艺的传承，更承载了江南地区的审美情趣：绣品配色遵循“雅而不艳”的原则，题材偏好江南水乡、文人花鸟；如今苏绣既保留传统纹样的精致，也融入现代设计，成为非遗生活化的代表之一。
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
                        <div class="comment-text">刺绣很有韵味，体现了中国传统艺术的精致。</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="right-col">
<div class="side-card">
    <div style="font-size:15px; font-weight:bold; margin-bottom:15px; border-bottom:1px solid #eee; padding-bottom:10px;">❤️ 收藏项目</div>
    <p style="font-size:12px; color:#999; margin-bottom:10px;">点击下方按钮收藏到个人中心</p>
    
    <%-- 假设该项目的ID为1，类型为'刺绣' --%>
    <button id="collectBtn" 
            class="side-btn" 
            data-active="false"
            onclick="handleFavorite('${heritage.id}', '${heritage.title}')"
            style="background:#FDF5E6; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 8px;">
        <span id="collectIcon">⭐</span> 
        <span id="collectText">点击收藏</span>
    </button>
</div>

            <div class="side-card">
                <div class="section-title" style="font-size:15px; justify-content:center;">👤 传承人信息</div>
                <img src="images/李大师.jpg" class="inheritor-avatar">
                <p style="font-weight:bold;">姚大师</p>
                <p style="font-size:12px; color:#888; margin: 10px 0;">民间音乐家，擅长京胡和京剧音乐创作</p>
                <a href="inheritor-cixiu.jsp" class="side-btn">查看详情</a>
            </div>

            <div class="side-card">
                <div class="section-title" style="font-size:15px; justify-content:center;">📢 分享项目</div>
                <p style="font-size:12px; color:#777;">让更多人了解这项非遗文化</p>
                <div style="display:flex; justify-content:center; gap:15px; margin-top:15px;">
                    <span style="cursor:pointer;">📷</span>
                    <span style="cursor:pointer;">🐦</span>
                    <span style="cursor:pointer;">💬</span>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2025 非遗文化传承平台 版权所有 | 传承文化 守护经典</p>
    </footer>
<script>

//页面加载完成后，立刻向服务器同步状态
// 页面加载时，自动从数据库拉取该项目的真实收藏状态
/* ==========================================================
   1. 页面加载自动同步状态 (解决返回/刷新后收藏消失的关键)
   ========================================================== */
// 页面加载时：查（检查状态）
   window.onload = function() {
       const heritageId = "${heritage.id}";
       if (heritageId) {
           fetch('FavoriteServlet?action=check&heritageId=' + heritageId)
               .then(res => res.json())
               .then(data => {
                   updateBtnStatus(data.isFavorited); // 根据数据库结果变色
               });
       }
   };

   // 点击按钮时：增/删（切换状态）
	function handleFavorite(heritageId, itemName) {
	    // 使用统一的 loginUser 变量
	   
	    <% if (loginUser == null) { %>
	        Swal.fire({
	            title: '请先登录',
	            icon: 'warning',
	            confirmButtonText: '去登录'
	        }).then((result) => {
	            if (result.isConfirmed) window.location.href = 'login.jsp';
	        });
	        return;
	    <% } %>

	    if (!heritageId || heritageId === "null" || heritageId === "") {
	        alert("无效项目ID，请检查详情页跳转逻辑");
	        return;
	    }

	    fetch('FavoriteServlet?heritageId=' + heritageId)
	    .then(response => response.json())
	    .then(data => {
	        if (data.status === "added") {
	            updateBtnStatus(true);
	            Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: '收藏成功', showConfirmButton: false, timer: 2000 });
	        } else if (data.status === "removed") {
	            updateBtnStatus(false);
	            Swal.fire({ toast: true, position: 'top-end', icon: 'info', title: '已取消收藏', showConfirmButton: false, timer: 2000 });
	        }
	    })
	    .catch(error => alert("操作失败，请确认后端服务器已重启"));
	}

	function updateBtnStatus(isActive) {
	    const btn = document.getElementById('collectBtn');
	    const text = document.getElementById('collectText');
	    const icon = document.getElementById('collectIcon');
	    if(!btn) return;

	    if (isActive) {
	        btn.style.background = "#8B4513"; btn.style.color = "#fff";
	        text.innerText = "已收藏"; icon.innerText = "🌟";
	    } else {
	        btn.style.background = "#FDF5E6"; btn.style.color = "#8B4513";
	        text.innerText = "点击收藏"; icon.innerText = "⭐";
	    }
	}



</script>
</body>
</html>