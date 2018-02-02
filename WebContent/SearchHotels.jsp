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
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/GeneralStyle.css">
		
		<title>Search Hotels</title>
	</head>
	<body>
	<%@ include file="SideNav.jsp" %>
	<div id = "main">
		<div id ="container" class="container" >
		<h1>Available Hotels</h1>
		<%
		try{
		    //connect to database
		    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
		    Statement st = con.createStatement();
		    
		    String entity = request.getParameter("country");
		    System.out.println(entity);
		    
		    String str = "SELECT * FROM Hotel WHERE Country = '" + entity + "'";
		    ResultSet result = st.executeQuery(str);
		
		    String button = "<button type=\"button\" onclick=\"window.location.href=\'Booking.jsp\'\" class=\"btn btn-primary\" id=\"1\">Book Here</button>";
		
			out.print("<table id=\"table_format\" class=\"table table-striped table-hover table-list-search\"");
				out.print("<thead>");
				out.print("<tr>");
					out.print("<th>");
						out.print("Street");
					out.print("</th>");
				out.print("<th>");
						out.print("City");
				out.print("</th>");
				out.print("<th>");
						out.print("State");
						out.print("<select id='filterText' onchange='filterText()'>");
							out.print("<option value='all'>All</option>");
						while(result.next()){
							out.print("<option value='"+ result.getString("State") +"'>"+ result.getString("State") +"</option>");
						}
						
				out.print("</th>");
				out.print("<th>");
					out.print("Reservations");
				out.print("</th>");
			out.print("</tr>");
			out.print("</thead>");
			out.print("<tbody id=\"myTable\">");
			int HotelID;
			result = st.executeQuery(str);
			while (result.next()) {
				out.print("<tr class=\"content\">");
					out.print("<td>");
						out.print(result.getString("Street"));
					out.print("</td>");
					out.print("<td>");
						out.print(result.getString("City"));
					out.print("</td>");
					out.print("<td>");
						out.print(result.getString("State"));
					out.print("</td>");
					out.print("<td>");
						HotelID = result.getInt("HotelID");
						System.out.println(HotelID);
						button = "<button type=\"button\" onclick=\"window.location.href=\'Booking.jsp?HotelID="+HotelID+"\'\" class=\"btn btn-primary btn-md\" id=\""+  HotelID  +"\">Book Here</button>";
						out.print(button);
						//System.out.print(button);
					out.print("</td>");
				out.print("</tr>");
				
		
			}
			out.print("</tbody>");
			out.print("</table>");
		
	    try { st.close(); } catch (Exception e) { /* ignored */ }
	    try { con.close(); } catch (Exception e) { /* ignored */ }
		}catch(Exception ex){
			out.print("Error");
		}
		%>
		
		</div>
	</div>
	
	<script>
		function filterText()
		{  
			var rex = new RegExp($('#filterText').val());
			if(rex =="/all/"){clearFilter()}else{
				$('.content').hide();
				$('.content').filter(function() {
				return rex.test($(this).text());
				}).show();
		}
		}
		
		function clearFilter()
			{
				$('.filterText').val('');
				$('.content').show();
			}
	</script>
	</body>
</html>

<%
	}
%>