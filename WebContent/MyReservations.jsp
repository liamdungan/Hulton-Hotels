<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	//Check if user is logged in, if they are not, do not allow access
    if ((session.getAttribute("username") == null) || (session.getAttribute("username") == ""))
    {
    		response.sendRedirect("LoginPage.jsp");
    }else{
	    		
%>


<!DOCTYPE html>
<html>
	<head>
		<title>My Reservations</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/GeneralStyle.css">
	</head>
	
	<body>
		<%@ include file="SideNav.jsp" %>
		<div id= "main">
		<div id ="container" class="container">
				<h1>My Reservations</h1>
				<hr>
				<p>Below you can view your current room reservations.</p>
				<%
				
				try{
					//Connect to database
				    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
				    Class.forName("com.mysql.jdbc.Driver");
				    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
				    Statement st = con.createStatement();
				    
				    String username = (String)session.getAttribute("username");
				    
					//get CID
					String str = "SELECT * FROM Customer WHERE username='"+ username +"'";
					ResultSet rs = st.executeQuery(str);
					rs.next();
					int CID = rs.getInt("CID");
					
					//invoice
					str = "SELECT * FROM Makes WHERE CID=" + CID;
					ResultSet makes = st.executeQuery(str);
					String InvoiceNo = "";
					
					String invoice[] = new String[20];
					int i = 0;
					while(makes.next()){
						invoice[i] = makes.getString("InvoiceNo");
						i ++;
					}
					//out.print(Arrays.toString(invoice));
					makes.close();
					//ResultSet reserves;				
					out.print("<table class='table'>");
					out.print("<thead>");
						out.print("<th>Room #</th><th>Hotel ID</th><th>Check In</th><th>Check Out</th>");
					out.print("<thead>");
					if(invoice[0] != null){
						out.print("<tbody>");
						i--;
						ResultSet reserves;
						while(i >= 0){
							str = "SELECT * FROM Reserves WHERE InvoiceNo='"+ invoice[i] +"'";
							reserves = st.executeQuery(str);
							reserves.next();
							out.print("<tr>");
								out.print("<td>");
								out.print(reserves.getInt("Room_no"));
								out.print("</td>");
								out.print("<td>");
								out.print(reserves.getString("HotelID"));
								out.print("</td>");
								out.print("<td>");
								out.print(reserves.getDate("InDate"));
								out.print("</td>");
								out.print("<td>");
								out.print(reserves.getDate("OutDate"));
								out.print("</td>");
							out.print("</tr>");
							i--;
						}
						out.print("</tbody>");
						out.print("</table>");
					}else{
						out.print("</table>");
						out.print("<p>You currently do not have any reservations.</p>");
					}
							
					
			    try { st.close(); } catch (Exception e) { /* ignored */ }
			    try { con.close(); } catch (Exception e) { /* ignored */ }
			    
				}catch(Exception ex){
					out.print("Error");
				}
			    
				%>
				
		</div>
		</div>

	</body>
</html>





<% } %>