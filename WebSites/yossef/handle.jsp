package j2se.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBClass {
    
    private static Connection DBInit(){

        Connection conn = null;
        try{
        //STEP 2: Register JDBC driver
        Class.forName(DBCredentials.JDBC_DRIVER);
        <%@ page import="java.sql.*" %>
        
        //STEP 3: Open a connection
                  System.out.println("Connecting to database..."); 
             conn = DriverManager.getConnection(DBCredentials.DB_URL,DBCredentials.USER,DBCredentials.PASS);
            
        } catch (ClassNotFoundException e) {
                e.printStackTrace();
        } catch( SQLException e){
                e.printStackTrace();
        }
        
        return conn;
    }


    public static boolean checkLogin(String userName, String password){
        
        
        Connection conn = DBInit();
        boolean userFound = false;
      
        try {
            String sql = "SELECT COUNT(*) CNT_USERS"
                +" FROM MY_USER"
                +" WHERE USER_NAME=?"
                +" AND USER_PASSWORD=?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, userName);
                    pstmt.setString(2, password);
                    
               ResultSet rs =  pstmt.executeQuery();
            int userCount = 0;
            while(rs.next()){
                 userCount = rs.getInt("CNT_USERS");
            }
                
                if(userCount > 0)            
                        userFound = true;
        
        
        } catch (SQLException e) {
                e.printStackTrace();
        }

        return userFound;
    }
}
