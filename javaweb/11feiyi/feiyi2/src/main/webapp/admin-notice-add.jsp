<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>后台管理 - 发布新公告</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background: #f4f7f6; margin: 0; display: flex; }
        .main-content { flex: 1; padding: 30px; }
        .form-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        textarea.form-control { height: 200px; resize: vertical; }
        .btn-submit { background: #8B4513; color: white; border: none; padding: 12px 25px; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn-submit:hover { background: #5D2E0A; }
        .status-msg { padding: 10px; margin-bottom: 20px; border-radius: 4px; display: none; }
    </style>
</head>
<body>

    <%-- 1. 引入侧边栏 --%>
<%@ include file="admin-sidebar.jsp" %>

<%-- 2. 右侧主内容容器，增加左边距以避开侧边栏 --%>
<div class="admin-main-wrapper" style="margin-left: 220px; padding: 40px; background-color: #f4f7f6; min-height: 100vh;">
    
    <%-- 3. 表单卡片容器，限制最大宽度并居中显示 --%>
    <div style="max-width: 85%; margin: 0 auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
        
        <h2 style="color: #8B4513; border-left: 5px solid #8B4513; padding-left: 15px; margin-bottom: 35px; font-family: 'KaiTi';">
            <i class="fas fa-plus-circle"></i> 发布新公告
        </h2>

        <form action="admin-notice-save.jsp" method="post">
            <div style="margin-bottom: 25px;">
                <label style="display: block; margin-bottom: 10px; font-weight: bold; color: #555;">公告标题</label>
                <input type="text" name="title" placeholder="请输入公告标题" required
                       style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 15px;">
            </div>

            <div style="display: flex; gap: 40px; margin-bottom: 25px;">
                <div style="flex: 1;">
                    <label style="display: block; margin-bottom: 10px; font-weight: bold; color: #555;">公告类型</label>
                    <select name="type" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; background: white;">
                        <option value="sys">系统通知</option>
                        <option value="news">非遗快讯</option>
                        <option value="master">大师动态</option>
                    </select>
                </div>
                <div style="flex: 1;">
                    <label style="display: block; margin-bottom: 10px; font-weight: bold; color: #555;">是否置顶</label>
                    <div style="padding-top: 10px;">
                        <label style="margin-right: 20px;"><input type="radio" name="isTop" value="1"> 是</label>
                        <label><input type="radio" name="isTop" value="0" checked> 否</label>
                    </div>
                </div>
            </div>

            <div style="margin-bottom: 30px;">
                <label style="display: block; margin-bottom: 10px; font-weight: bold; color: #555;">公告内容</label>
                <textarea name="content" placeholder="支持输入HTML标签内容..." required
                          style="width: 100%; height: 300px; padding: 15px; border: 1px solid #ddd; border-radius: 6px; resize: vertical; line-height: 1.6;"></textarea>
            </div>

            <div style="text-align: center; border-top: 1px solid #eee; padding-top: 30px;">
                <button type="button" onclick="history.back()" 
                        style="padding: 12px 35px; background: #999; color: white; border: none; border-radius: 6px; cursor: pointer; margin-right: 15px; font-weight: bold;">返回</button>
                <button type="submit" 
                        style="padding: 12px 50px; background: #8B4513; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 16px;">立即发布</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>