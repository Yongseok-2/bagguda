package termpackage;

import java.sql.*;

public class WishlistHelper {

    public static boolean isInWishlist(String username, String productId) {
        boolean isInWishlist = false;
        
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM wishlist WHERE user_id = ? AND product_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, productId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                isInWishlist = rs.getInt(1) > 0;
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return isInWishlist;
    }
}
