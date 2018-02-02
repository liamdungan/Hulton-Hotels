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

	String temp = request.getParameter("room");
	String params[]= temp.split(";");
	//out.print(Arrays.toString(params));
	String HotelID = params[1];
	int Room_no = Integer.parseInt(params[0]);
	
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
    
    //add room review to db
    PreparedStatement newRoomReview = con.prepareStatement("INSERT INTO RoomReview VALUES(?, ?, ?)");
    newRoomReview.setString(1 , ReviewID);
    newRoomReview.setInt(2, Room_no);
    newRoomReview.setString(3 , HotelID);
    newRoomReview.executeUpdate();
    newRoomReview.close();
	
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