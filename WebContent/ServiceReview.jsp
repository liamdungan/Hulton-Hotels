<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%

try{
	//Connect to database
	String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
	Statement st = con.createStatement();
	
	String temp = request.getParameter("service");
	String params[]= temp.split(";");
	//out.print(Arrays.toString(params));
	String HotelID = params[1];
	String sType = params[0];

	String ReviewID = request.getParameter("ReviewID");
	int CID = Integer.parseInt(request.getParameter("CID"));
	String TextComment = request.getParameter("TextComment");
	String Rating = request.getParameter("Rating");
		
	//add review to db
    PreparedStatement newReview = con.prepareStatement("INSERT INTO Review VALUES(?, ?, ?, ?)");
    newReview.setString(1 , ReviewID);
    newReview.setString(2 , Rating);
    newReview.setString(3, TextComment);
    newReview.setInt(4, CID);
    newReview.executeUpdate();
    newReview.close();
    
    //add breakfast review to db
    PreparedStatement newServiceReview = con.prepareStatement("INSERT INTO ServiceReview VALUES(?, ?, ?)");
    newServiceReview.setString(1 , ReviewID);
    newServiceReview.setString(2, sType);
    newServiceReview.setString(3 , HotelID);
    newServiceReview.executeUpdate();
    newServiceReview.close();
	
    try { st.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
}catch(Exception ex){
	System.out.print("error");
}finally{
	%>
	<html>
		<body>
			<script>
				alert("Success!");
				window.location.href = "Home.jsp";
			</script>	
		</body>
	</html>
	<%
}

%>