<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %>

<%
    String username = (String) session.getAttribute("username");
    String newDescription = request.getParameter("newDescription");
    
    if (username == null || newDescription == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../html/login.html';</script>");
        return;
    }

    // DB 연결 및 소개글 수정
    Connection conn = DBConnection.getConnection();
    String updateSQL = "UPDATE interface SET description = ? WHERE username = ?";
    PreparedStatement pstmt = conn.prepareStatement(updateSQL);
    pstmt.setString(1, newDescription);
    pstmt.setString(2, username);

    int rowsUpdated = pstmt.executeUpdate();
    
    if (rowsUpdated > 0) {
        out.println("<script>alert('소개글이 수정되었습니다.'); location.href='interface.jsp';</script>");
    } else {
        out.println("<script>alert('수정 실패.'); history.back();</script>");
    }

    pstmt.close();
    conn.close();
%>
