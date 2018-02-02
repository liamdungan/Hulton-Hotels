<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
int i = 0;
boolean inSystem = false;
//input
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String user = request.getParameter("username");    
String pass = request.getParameter("password");

try {
    //connect to database
    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
    Statement st = con.createStatement();
    
    
    ResultSet rs = st.executeQuery("select * from Customer where username = '" + user + "'");
	if(rs.next()){
		inSystem = true;	
	}
	
	if(!inSystem){
	    String str = "SELECT MAX(CID) as maxid FROM Customer";
	    ResultSet result = st.executeQuery(str);
	    result.next();
	    int countCust = result.getInt("maxid");
	    countCust += 1;
	
	    PreparedStatement newCust = con.prepareStatement("INSERT INTO Customer values(?, ?, ?, ?, ?, ?, ?)");
	    newCust.setInt(1 , countCust);
	    newCust.setString(2 , email);
	    newCust.setString(3, address);
	    newCust.setString(4, phone);
	    newCust.setString(5 , name);
	    newCust.setString(6, user);
	    newCust.setString(7, pass);
	    
	    i = newCust.executeUpdate();
	    
	    try { st.close(); } catch (Exception e) { /* ignored */ }
	    try { con.close(); } catch (Exception e) { /* ignored */ }
	}
	
} catch (Exception ex) {
	out.print("error");
	//System.out.println("Error");
}finally{
	if(i > 0){
        session.setAttribute("username", user);
		response.sendRedirect("Home.jsp");
	}else{
		response.sendRedirect("RegisterError.jsp");
	}
	
}

%>