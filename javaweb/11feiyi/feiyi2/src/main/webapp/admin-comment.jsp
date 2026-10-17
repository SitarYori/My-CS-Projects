<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.fy.dao.*, com.fy.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>点评管理 - 非遗文化后台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body { font-family: "Microsoft YaHei"; background: #FDF5E6; display: flex; margin: 0; }
        .main-content { flex: 1; margin-left: 220px; padding: 20px; }
        
        /* 表格样式 */
        .admin-table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .admin-table th { background: #5D3A1A; color: white; padding: 12px; text-align: left; font-size: 14px; }
        .admin-table td { padding: 12px; border-bottom: 1px solid #EEE; font-size: 13px; color: #444; }
        
        .user-cell { display: flex; align-items: center; gap: 8px; }
        .user-cell img { width: 24px; height: 24px; border-radius: 50%; }
        .star-gold { color: #DAA520; } /* 金色星星样式 */
        
        .btn-del { background: #FF4500; color: white; border: none; padding: 4px 10px; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>

    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="color: #5D3A1A;"><i class="fas fa-star"></i> 点评管理</h2>
            <div class="search-box">
                <input type="text" placeholder="搜索项目名或用户名..." style="padding: 6px; border: 1px solid #ddd; width: 200px;">
                <button style="background:#8B4513; color:white; border:none; padding:6px 15px; border-radius:4px;">搜索</button>
            </div>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>项目名称</th>
                    <th>用户</th>
                    <th>评分</th>
                    <th>评论内容</th>
                    <th>时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // 模拟从数据库获取点评数据
                    // List<Comment> comments = new CommentDao().getAllComments();
                %>
                <tr>
                    <td>1</td>
                    <td>景德镇陶瓷制作</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user1"> user1</td>
                    <td class="star-gold">★★★★★</td>
                    <td>景德镇陶瓷真的很精美，工艺精湛...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(1)">删除</button></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>苏州刺绣</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user2"> user2</td>
                    <td class="star-gold">★★★★★</td>
                    <td>苏州刺绣的针法太细致了，真是精品...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(2)">删除</button></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>苏州刺绣</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user3"> user3</td>
                    <td class="star-gold">★★★★★</td>
                    <td>看了这个项目对苏绣更感兴趣了...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(1)">删除</button></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>传统剪纸艺术</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user4"> user4</td>
                    <td class="star-gold">★★★★★</td>
                    <td>传统剪纸艺术太有特色了，中国文化...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(1)">删除</button></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>景德镇陶瓷制作</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user5"> user5</td>
                    <td class="star-gold">★★★★★</td>
                    <td>了解到了很多陶瓷制作的知识，很有...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(1)">删除</button></td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>京剧音乐艺术</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user6"> user6</td>
                    <td class="star-gold">★★★★★</td>
                    <td>剧音乐很有韵味，体现了中国传统...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(1)">删除</button></td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>民族舞蹈表演</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user7"> user7</td>
                    <td class="star-gold">★★★★★</td>
                    <td>民族舞蹈展现了不同民族的文花特...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(1)">删除</button></td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>中医传统疗法作、</td>
                    <td class="user-cell"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=user8"> user8</td>
                    <td class="star-gold">★★★★★</td>
                    <td>中医传统疗法体现了中国古代的智慧...</td>
                    <td>2025-12-02 17:08</td>
                    <td><button class="btn-del" onclick="delComment(1)">删除</button></td>
                </tr>
                
            </tbody>
        </table>
    </div>

    <script>
        function delComment(id) {
            if(confirm("确定要删除这条用户点评吗？")) {
                // 再次利用 AdminActionServlet 进行统一删除处理
                window.location.href = "AdminActionServlet?action=delete&type=comment&id=" + id;
            }
        }
    </script>
</body>
</html>