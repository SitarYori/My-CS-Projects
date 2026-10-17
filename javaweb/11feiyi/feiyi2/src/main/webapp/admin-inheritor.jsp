<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.fy.dao.*, com.fy.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>传承人管理 - 非遗文化后台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 沿用项目管理的深棕色风格 */
        body { font-family: "Microsoft YaHei"; background: #FDF5E6; display: flex; margin: 0; }
        .main-content { flex: 1; margin-left: 220px; padding: 20px; }
        
        /* 导航与表格样式 */
        .admin-table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; }
        .admin-table th { background: #5D3A1A; color: white; padding: 12px; text-align: left; }
        .admin-table td { padding: 12px; border-bottom: 1px solid #EEE; font-size: 14px; }
        
        .btn-action { padding: 5px 12px; border-radius: 4px; color: white; text-decoration: none; font-size: 12px; margin-right: 5px; }
        .btn-edit { background: #1E90FF; }
        .btn-delete { background: #FF4500; }
        .header-box { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    </style>
</head>
<body>

    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="header-box">
            <h2 style="color: #5D3A1A;">传承人管理</h2>
            <div class="search-area">
                <input type="text" placeholder="传承人姓名" id="searchName" style="padding:6px; border:1px solid #ddd;">
                <button onclick="alert('筛选功能开发中')" style="background:#8B4513; color:white; border:none; padding:6px 15px; border-radius:4px; cursor:pointer;">筛选</button>
            </div>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>姓名</th>
                    <th>专长</th>
                    <th>联系方式</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // 获取传承人列表数据
                    // List<Inheritor> list = new InheritorDao().getAllInheritors(); 
                    // 模拟截图中的数据
                %>
                <tr>
                    <td>1</td>
                    <td>陈师傅</td>
                    <td>景德镇陶瓷制作</td>
                    <td>0798-6688888</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=1" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(1)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>李大师</td>
                    <td>苏州刺绣</td>
                    <td>0512-6688888</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=2" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(2)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>王老师</td>
                    <td>传统剪纸</td>
                    <td>010-8888888</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=3" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(3)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                 <tr>
                    <td>4</td>
                    <td>张艺术家</td>
                    <td>京剧音乐</td>
                    <td>010-9999999</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=4" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(4)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                 <tr>
                    <td>5</td>
                    <td>刘舞蹈家</td>
                    <td>民族舞蹈</td>
                    <td>020-7777777</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=5" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(5)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                 <tr>
                    <td>6</td>
                    <td>杨医生</td>
                    <td>中医医药</td>
                    <td>0571-6666666</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=6" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(6)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                 <tr>
                    <td>7</td>
                    <td>马厨师</td>
                    <td>传统饮食</td>
                    <td>0755-5555555</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=7" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(7)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>吴建筑师</td>
                    <td>传统建筑</td>
                    <td>0311-4444444</td>
                    <td>
                        <a href="edit-inheritor.jsp?id=8" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="confirmDel(8)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
        function confirmDel(id) {
            // 使用交互弹窗确认删除操作
            if(confirm("确定要删除这位传承人吗？相关项目可能也会受到影响。")) {
                // 跳转到之前写好的统一 Action Servlet，type 传 inheritor
                window.location.href = "AdminActionServlet?action=delete&type=inheritor&id=" + id;
            }
        }
    </script>
</body>
</html>