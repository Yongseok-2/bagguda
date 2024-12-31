<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>


<% request.setCharacterEncoding("UTF-8"); %>

<%
    String message = request.getParameter("message");
    String receiver = request.getParameter("receiver");
    String sender = (String) session.getAttribute("username");

    if (message != null && receiver != null && sender != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String query = "INSERT INTO chat_messages (sender, receiver, message, sent_at) VALUES (?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, sender);
            pstmt.setString(2, receiver);
            pstmt.setString(3, message);
            pstmt.executeUpdate();
            response.sendRedirect("chat.jsp?owner=" + receiver);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    } else {
        response.sendRedirect("error.jsp");
    }
%>
