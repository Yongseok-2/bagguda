<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>

<%
    String loggedInUser = request.getParameter("owner");

    if (loggedInUser != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT * FROM chat_messages WHERE (sender = ? AND receiver = ?) OR (sender = ? AND receiver = ?) ORDER BY sent_at ASC";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, loggedInUser);
            pstmt.setString(2, loggedInUser);
            pstmt.setString(3, loggedInUser);
            pstmt.setString(4, loggedInUser);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                String sender = rs.getString("sender");
                String message = rs.getString("message");
                String sentAt = rs.getString("sent_at");

                if (sender.equals(loggedInUser)) {
                    out.println("<div style='text-align:right; background-color:lightblue; padding:5px; margin:5px;'>" +
                        message + "<br><small>" + sentAt + "</small></div>");
                } else {
                    out.println("<div style='text-align:left; background-color:lightgray; padding:5px; margin:5px;'>" +
                        message + "<br><small>" + sentAt + "</small></div>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>
