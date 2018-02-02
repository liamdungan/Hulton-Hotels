<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<%
if (request.getParameter("submit") != null) {
	
	try{
	int hotelID = Integer.parseInt(request.getParameter("HotelID"));
	String checkin = request.getParameter("checkin");
	String checkout = request.getParameter("checkout");
	int numPeople = Integer.parseInt(request.getParameter("numPeople"));
	
	//print for tesing
	out.print("Hotel ID: " + hotelID);
	out.println("<br> Check In: " + checkin);
	out.println("<br> Check Out: " + checkout);
	out.print("<br> Number of People: " + numPeople);
	
	//save attributes in session
	session.setAttribute("HotelID", hotelID);
	session.setAttribute("checkin", checkin);
	session.setAttribute("checkout", checkout);
	session.setAttribute("numPeople", numPeople);
	
	//Connect to database
    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
    Statement st = con.createStatement();
    
    String str = "SELECT * FROM Room WHERE Capacity >=" + numPeople + " AND HotelID =" + hotelID;
    ResultSet rooms = st.executeQuery(str);
	
	%>
    <table id="table" class="table table-hover table-list-search">
	    <thead>
		    <tr>
		    		<th>Room #</th>
		    		<th>Price</th>
		    		<th>Capacity</th>
		    		<th>Type
		    			<select id='filterText' onchange='filterText()'>
		    				<option value='all'>All</option>
		    				<%
		    				String temp = "";
		    				while(rooms.next()){
		    					if(rooms.getString("Description").equals(temp))
		    						continue;
		    					out.print("<option value='"+ rooms.getString("Description") +"'>"+ rooms.getString("Description") +"</option>");
		    					temp = rooms.getString("Description");
		    				}
		    				%>
		    			</select>
		    		</th>
		    </tr>
	    </thead> 
	    <tbody>
	    <% 
	    rooms = st.executeQuery(str);
			while(rooms.next()){
				int num = rooms.getInt("Room_no");
				out.print("<tr class=\"content\" data-value=\""+ num +"\">");		
					out.print("<td>"); out.print(rooms.getInt("Room_no")); out.print("</td>");

					out.print("<td>"); out.print("$" + rooms.getInt("Price")); out.print("</td>");
				
					out.print("<td>"); out.print(rooms.getInt("Capacity")); out.print("</td>");
				
					out.print("<td>"); out.print(rooms.getString("Description")); out.print("</td>");
				out.print("</tr>");
			}
	    %>
	    </tbody>
    </table>
    
    <form action="Booking.jsp" method = "post" name = "myform">
		<input type="hidden" name="Room_no" value="101"/>
		<input type="submit" name="submit2" value="Continue" />
    </form>

    
    <style>
	    td {border: 1px #DDD solid; padding: 5px; cursor: pointer;}
	
		.selected {
		    background-color: #437aa9;
		    color: #FFF;
		}
    </style>
    
    	<script>
		function filterText(){  
			var rex = new RegExp($('#filterText').val());
			if(rex =="/all/"){clearFilter()}else{
				$('.content').hide();
				$('.content').filter(function() {
				return rex.test($(this).text());
				}).show();
			}
		}
		
		function clearFilter(){
			$('.filterText').val('');
			$('.content').show();
		}
		
		$("#table tbody tr").click(function(){
			   $(this).addClass('selected').siblings().removeClass('selected'); 
			   var value=$(this).data('value');
			   document.myform.Room_no.value = value;
			});

	</script>
    
	<%
    try { st.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
	}catch(Exception ex){
		out.print("Error");
	}finally{

	}
	
	
	
}else{
	out.print("There are no rooms available matching your selections.");
}
%>

