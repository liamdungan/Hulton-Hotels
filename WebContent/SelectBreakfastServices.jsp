<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
if (request.getParameter("submit2") != null) {

	try{
		
		int room_no = Integer.parseInt(request.getParameter("Room_no"));
		session.setAttribute("Room_no", room_no);
		
		int hotelID = (Integer)session.getAttribute("HotelID");
		int numPeople = (Integer)session.getAttribute("numPeople");
		int Room_no = (Integer)session.getAttribute("Room_no");
		
		//print for testing 
		out.print("Hotel ID: " + hotelID + "<br>");
		out.print("Room #: " + Room_no + "<br>");
		out.print("Number of People: " + numPeople + "<br>");
		
		//Connect to database
		String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
		Statement st = con.createStatement();
		
	    String str = "SELECT * FROM Room WHERE Room_no =" + Room_no + " AND HotelID =" + hotelID;
	    ResultSet room = st.executeQuery(str);
	    room.next();
		int capacity = room.getInt("Capacity");
		session.setAttribute("Capacity", capacity);
		out.print("Room Capacity: " + capacity);
		out.print("<br><br>");
		
		
	    String str2 = "SELECT * FROM Breakfast WHERE HotelID =" + hotelID;
	    ResultSet breakfast = st.executeQuery(str2);
	    
		%>
		<form action= "Booking.jsp" method = "post">
		<div class = "form-group" >
			<label>Breakfast</label>
			<%
			int i = 1;
			while(i <= capacity){
				out.print("<select name='Breakfast'  class='selectpicker' required>");
					out.print("<option value='' disabled selected> Guest "+ i +"</option>");
					out.print("<option value='None'>None</option>");
					breakfast = st.executeQuery(str2);
					while(breakfast.next()){
						out.print("<option value='"+ breakfast.getString("bType") +"'>"+ breakfast.getString("bType") + " $" + breakfast.getInt("bPrice") +"</option>");
					}
				out.print("</select>");
				i++;
			}
			%>
		</div>
		
		<% 
		String str3 = "SELECT * FROM Service WHERE HotelID =" + hotelID;
		ResultSet service = st.executeQuery(str3);
		%>
		<div class = "form-group">
			<label>Services</label>
			<%
			while(service.next()){
				out.print("<div>");
					out.print("<p><input type='checkbox' name='services' value='"+ service.getString("sType") +"'>");
					out.print(service.getString("sType") + " $" + service.getInt("sCost") + "</p>");
				out.print("</div>");
			}
			%>
		</div>
		<input type="submit" name="submit3" value="Continue" />
		</form>
	
	
			
	<%
    try { st.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
	}catch(Exception ex){
		out.print("Error");
	}finally{
		
	}
		



	}else{
		out.print("There are no Breakfast or Services available matching your selections.");
	}
%>