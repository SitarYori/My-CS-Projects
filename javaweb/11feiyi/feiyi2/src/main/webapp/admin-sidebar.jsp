<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .sidebar { 
        width: 220px; 
        height: 100vh; 
        background-color: #5D3A1A; /* 对应图中的深棕色 */
        color: white; 
        position: fixed; 
        left: 0; 
        top: 0;
    }
    .sidebar-header { padding: 20px; font-size: 18px; border-bottom: 1px solid rgba(255,255,255,0.1); }
    .nav-menu { list-style: none; padding: 0; }
    .nav-item { 
        display: block; 
        padding: 15px 20px; 
        color: rgba(255,255,255,0.8); 
        text-decoration: none; 
        transition: 0.3s;
    }
    .nav-item:hover { background: rgba(255,255,255,0.1); color: #F1C27D; }
    /* 当前选中状态的样式 */
    .nav-item.active { background: rgba(255,255,255,0.15); border-left: 4px solid #F1C27D; color: white; }
</style>

<%
    // 获取当前请求的 URI，例如 "/feiyi2/admin-inheritor.jsp"
    String uri = request.getRequestURI();
%>
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-landmark"></i> 非遗文化管理
        </div>
        <div class="nav-menu">
            <a href="admin-index.jsp" class="nav-item"><i class="fas fa-home"></i> 控制台</a>
            <a href="admin-project.jsp" class="nav-item <%= uri.contains("admin-project.jsp") ? "active" : "" %>">
            <i class="fas fa-th-list"></i> 项目管理</a>
            <a href="admin-inheritor.jsp" class="nav-item <%= uri.contains("admin-inheritor.jsp") ? "active" : "" %>">
            <i class="fas fa-user-tie"></i> 传承人管理</a>
            <a href="#" class="nav-item"><i class="fas fa-tags"></i> 分类管理</a>
            <a href="admin-notice-add.jsp" class="nav-item"><i class="fas fa-bullhorn"></i> 公告管理</a>
            <a href="#" class="nav-item"><i class="fas fa-users"></i> 用户管理</a>
            <a href="admin-comment.jsp" class="nav-item <%= uri.contains("admin-comment.jsp") ? "active" : "" %>">
            <i class="fas fa-comments"></i> 点评管理</a>
            <a href="../index.jsp" class="nav-item">
            <i class="fas fa-reply"></i> 返回前台</a>
            <a href="login.jsp" class="nav-item"><i class="fas fa-sign-out-alt"></i> 退出登录</a>
        
        </div>
    </div>
    
    
    
    
    
    
    
    
    
    