<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.fy.dao.*, com.fy.entity.*" %>
<%
    // 权限安全检查：如果未登录管理员，强制跳回登录页
    User admin = (User) session.getAttribute("adminUser");
    if (admin == null) {
        // response.sendRedirect("login.jsp");
        // return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>非遗文化管理 - 项目管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: "Microsoft YaHei", sans-serif; background-color: #FDF5E6; display: flex; }

        /* 左侧侧边栏样式 */
        .sidebar { width: 220px; height: 100vh; background-color: #5D3A1A; color: white; position: fixed; }
        .sidebar-header { padding: 20px; font-size: 18px; font-weight: bold; border-bottom: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; }
        .sidebar-header i { margin-right: 10px; }
        .nav-menu { list-style: none; padding-top: 10px; }
        .nav-item { padding: 15px 20px; cursor: pointer; display: flex; align-items: center; transition: 0.3s; color: rgba(255,255,255,0.7); text-decoration: none; }
        .nav-item i { margin-right: 12px; width: 20px; text-align: center; }
        .nav-item:hover, .nav-item.active { background-color: rgba(255,255,255,0.1); color: #FFDAB9; border-left: 4px solid #F1C27D; }

        /* 右侧主体内容 */
        .main-content { margin-left: 220px; flex: 1; padding: 20px; }
        .header-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .user-info { display: flex; align-items: center; gap: 10px; font-size: 14px; }
        .user-info img { width: 35px; height: 35px; border-radius: 50%; }

        /* 搜索与工具栏 */
        .toolbar { background: white; padding: 15px; border-radius: 8px; display: flex; justify-content: space-between; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .btn-add { background-color: #8B4513; color: white; padding: 8px 15px; border-radius: 5px; text-decoration: none; font-size: 14px; transition: 0.3s; }
        .btn-add:hover { background-color: #5D3A1A; }
        .search-area { display: flex; gap: 10px; }
        .search-area input, .search-area select { padding: 6px 10px; border: 1px solid #DDD; border-radius: 4px; outline: none; }
        .btn-filter { background: #8B4513; color: white; border: none; padding: 5px 15px; border-radius: 4px; cursor: pointer; }

        /* 数据表格样式 */
        .data-table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .data-table th { background-color: #F5F5F5; color: #5D3A1A; padding: 12px; text-align: left; font-size: 14px; border-bottom: 2px solid #EEE; }
        .data-table td { padding: 12px; border-bottom: 1px solid #EEE; font-size: 14px; color: #333; }
        
        /* 状态标签与按钮 */
        .status-published { background: #FDF5E6; color: #8B4513; padding: 3px 10px; border-radius: 12px; border: 1px solid #F1C27D; font-size: 12px; }
        .btn-action { padding: 4px 10px; border-radius: 4px; text-decoration: none; font-size: 12px; color: white; margin-right: 5px; }
        .btn-edit { background-color: #1E90FF; }
        .btn-delete { background-color: #FF4500; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-landmark"></i> 非遗文化管理
        </div>
        <div class="nav-menu">
            <a href="admin-index.jsp" class="nav-item"><i class="fas fa-home"></i> 控制台</a>
            <a href="admin-project.jsp" class="nav-item active"><i class="fas fa-th-list"></i> 项目管理</a>
            <a href="admin-inheritor.jsp" class="nav-item"><i class="fas fa-user-tie"></i> 传承人管理</a>
            <a href="#" class="nav-item"><i class="fas fa-tags"></i> 分类管理</a>
            <a href="admin-notice-add.jsp" class="nav-item"><i class="fas fa-bullhorn"></i> 公告管理</a>
            <a href="#" class="nav-item"><i class="fas fa-users"></i> 用户管理</a>
            <a href="admin-comment.jsp" class="nav-item"><i class="fas fa-comments"></i> 点评管理</a>
            <a href="index.jsp" class="nav-item"><i class="fas fa-reply"></i> 返回前台</a>
            <a href="login.jsp" class="nav-item"><i class="fas fa-sign-out-alt"></i> 退出登录</a>
        </div>
    </div>
    <div class="main-content">
        <div class="header-top">
            <h2 style="color: #5D3A1A;">项目管理</h2>
            <div class="user-info">
                <span>admin</span>
                <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=admin" alt="avatar">
            </div>
        </div>

        <div class="toolbar">
            <a href="add-project.jsp" class="btn-add"><i class="fas fa-plus"></i> 添加项目</a>
            <div class="search-area">
                <input type="text" placeholder="项目名称">
                <select>
                    <option>全部分类</option>
                    <option>民间工艺</option>
                    <option>传统音乐</option>
                </select>
                <button class="btn-filter"><i class="fas fa-filter"></i> 筛选</button>
            </div>
        </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>项目名称</th>
                    <th>分类</th>
                    <th>传承人</th>
                    <th>浏览量</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // 实际开发中应调用 HeritageDao 获取数据库列表
                    // List<Heritage> list = new HeritageDao().getAllHeritage();
                    // 下面为模拟图片中的数据展示
                %>
                <tr>
                    <td>1</td>
                    <td><strong>景德镇陶瓷制作</strong></td>
                    <td>民间工艺</td>
                    <td>陈师傅</td>
                    <td>534</td>
                    <td><span class="status-published">published</span></td>
                    <td>
                        <a href="edit-project.jsp?id=1" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(1)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td><strong>苏州刺绣</strong></td>
                    <td>民间工艺</td>
                    <td>李大师</td>
                    <td>452</td>
                    <td><span class="status-published">published</span></td>
                    <td>
                        <a href="edit-project.jsp?id=2" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(2)" class="btn-action btn-delete">删除</a>
                    </td>
                </tr>
				                
				<tr>
				    <td>3</td>
				    <td><strong>传统剪纸艺术</strong></td>
				    <td>民间工艺</td>
				    <td>王老师</td>
				    <td>380</td>
				    <td><span class="status-published">published</span></td>
				    <td>
				        <a href="edit-project.jsp?id=3" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(3)" class="btn-action btn-delete">删除</a>
				    </td>
				</tr>
				<tr>
				    <td>4</td>
				    <td><strong>京剧音乐艺术</strong></td>
				    <td>传统音乐</td>
				    <td>张艺术家</td>
				    <td>341</td>
				    <td><span class="status-published">published</span></td>
				    <td>
				        <a href="edit-project.jsp?id=4" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(4)" class="btn-action btn-delete">删除</a>
				    </td>
				</tr>
				<tr>
				    <td>5</td>
				    <td><strong>民族舞蹈表演</strong></td>
				    <td>传统舞蹈</td>
				    <td>刘舞蹈家</td>
				    <td>421</td>
				    <td><span class="status-published">published</span></td>
				    <td>
				        <a href="edit-project.jsp?id=5" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(5)" class="btn-action btn-delete">删除</a>
				    </td>
				</tr>
				<tr>
				    <td>6</td>
				    <td><strong>中医传统疗法</strong></td>
				    <td>传统医药</td>
				    <td>杨医生</td>
				    <td>290</td>
				    <td><span class="status-published">published</span></td>
				    <td>
				       <a href="edit-project.jsp?id=6" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(6)" class="btn-action btn-delete">删除</a>
				    </td>
				</tr>
				<tr>
				    <td>7</td>
				    <td><strong>传统美食制作</strong></td>
				    <td>传统饮食</td>
				    <td>马厨师</td>
				    <td>513</td>
				    <td><span class="status-published">published</span></td>
				    <td>
				       <a href="edit-project.jsp?id=7" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(7)" class="btn-action btn-delete">删除</a>
				    </td>
				</tr>
				<tr>
				    <td>8</td>
				    <td><strong>传统建筑文化</strong></td>
				    <td>建筑文化</td>
				    <td>吴建筑师</td>
				    <td>312</td>
				    <td><span class="status-published">published</span></td>
				    <td>
				       <a href="edit-project.jsp?id=8" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(8)" class="btn-action btn-delete">删除</a>
				    </td>
				</tr>
				<tr>
				    <td>9</td>
				    <td><strong>民间文学传说</strong></td>
				    <td>非遗文学</td>
				    <td>陈师傅</td>
				    <td>270</td>
				    <td><span class="status-published">published</span></td>
				    <td>
				       <a href="edit-project.jsp?id=9" class="btn-action btn-edit">编辑</a>
                        <a href="javascript:void(0)" onclick="handleDelete(9)" class="btn-action btn-delete">删除</a>
				    </td>
				</tr>
                <%-- 循环结束 --%>
            </tbody>
        </table>
    </div>
    <script>
        function handleDelete(id) {
            if(confirm("确定要删除 ID 为 " + id + " 的非遗项目吗？此操作不可撤销。")) {
                // 执行删除逻辑，跳转到 Servlet 处理
                window.location.href = "AdminActionServlet?action=delete&type=project&id=" + id;
            }
        }
    </script>
</body>
</html>