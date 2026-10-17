package com.fy.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/aiChat")
public class AIChatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        String question = request.getParameter("question");
        String answer = getAnswer(question);

        response.getWriter().write(answer);
    }

    // ⭐ 规则型“AI回答”
    private String getAnswer(String q) {
        if (q == null || q.trim().isEmpty()) {
            return "请您输入具体的问题内容。";
        }

        q = q.toLowerCase();

        if (q.contains("非遗")) {
            return "非物质文化遗产是指被各族人民世代相传的传统文化表现形式，如传统技艺、表演艺术、民俗活动等。";
        }
        if (q.contains("苏绣")) {
            return "苏绣是中国四大名绣之一，以针法细腻、构图精巧著称，主要流行于江苏地区。";
        }
        if (q.contains("传承人")) {
            return "非遗传承人是掌握并传承非遗技艺的重要人物，他们在文化延续中起着核心作用。";
        }
        if (q.contains("课程")) {
            return "您可以前往【在线课堂】模块，学习与非遗文化相关的课程内容。";
        }
        if (q.contains("平台")) {
            return "本平台致力于通过数字化手段展示非遗文化，提升公众参与度。";
        }

        return "这是一个非常有意思的问题，您可以尝试换一种方式描述，我会尽力为您解答。";
    }
}
