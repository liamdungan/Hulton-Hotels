<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<% 
//is customer in the system already?
boolean inSystem = false;

//get user and pass that was entered
String username = request.getParameter("username");
String password = request.getParameter("password");

try{
	
	//Connect to database
    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
    Statement st = con.createStatement();
    
	//print user and pass for testing
	//System.out.println("email: " + username + " password: "+ password);
	
	//Find set from database with username and password matching the entered values
    ResultSet rs;
    rs = st.executeQuery("select * from Customer where username = '" + username + "' and pass='" + password + "'");
    
    //if username and passwod correct, inSystem = true
	if(rs.next()){
		inSystem = true;		
	}

    try { st.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
    
} catch (Exception ex) {
	System.out.println(ex);
}finally{
    
	if(inSystem){
		session.setAttribute("username", username);
		response.sendRedirect("Home.jsp");
	}else{	
		response.sendRedirect("LoginError.jsp");
	}
}
%>	
