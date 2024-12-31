package termpackage;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/term_jsp/html/AddToWishlistServlet")
public class AddToWishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            JSONObject jsonRequest = new JSONObject(request.getReader().readLine());
            String userId = jsonRequest.getString("user_id");
            String productId = jsonRequest.getString("product_id");

            Connection conn = DBConnection.getConnection();
            if (conn == null) {
                throw new Exception("Database connection failed.");
            }

            // Check if already exists
            String checkQuery = "SELECT is_in_wishlist FROM wishlist WHERE user_id = ? AND product_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, userId);
            checkStmt.setString(2, productId);
            ResultSet rs = checkStmt.executeQuery();
            boolean isInWishlist = false;
            
            if (rs.next()) {
                isInWishlist = rs.getBoolean("is_in_wishlist");
            }

            if (isInWishlist) {
                // If it's already in wishlist, remove it
                String deleteQuery = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
                deleteStmt.setString(1, userId);
                deleteStmt.setString(2, productId);
                deleteStmt.executeUpdate();
                deleteStmt.close();
            } else {
                // If it's not in wishlist, insert it
                String insertQuery = "INSERT INTO wishlist (user_id, product_id, is_in_wishlist) VALUES (?, ?, 1)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, userId);
                insertStmt.setString(2, productId);
                insertStmt.executeUpdate();
                insertStmt.close();
            }

            rs.close();
            checkStmt.close();
            conn.close();
            
            out.print("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Exception occurred\"}");
        }
    }
}
