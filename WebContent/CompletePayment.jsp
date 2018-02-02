<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<%
if (request.getParameter("submit3") != null) {
	%><label>Review:</label><%
	
	try{
		
		int n = (Integer)session.getAttribute("Capacity");
		int hotelID = (Integer)session.getAttribute("HotelID");
		int Room_no = (Integer)session.getAttribute("Room_no");
		
		String breakfastOrders[] = request.getParameterValues("Breakfast");
		String services[] = request.getParameterValues("services");
		
		session.setAttribute("bType", breakfastOrders);
		session.setAttribute("sType", services);
		
		out.print("Hotel ID: " + hotelID);
		out.print("<br>");
		out.print("Room #: "+ Room_no);
		out.print("<br>");
		out.print( "Breakfast Orders: " + Arrays.toString(breakfastOrders) );
		out.print("<br>");
		out.print( "Services: " + Arrays.toString(services) );
		
		//Connect to database
	    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
	    Statement st = con.createStatement();
	    
	    
	    String str = "";
	    ResultSet temp;
		
		
		int totalPrice = 0;
		String thisBreakfast;
		for(int i = 0; i<breakfastOrders.length; i++){
			thisBreakfast = breakfastOrders[i];
			if(thisBreakfast.equals("None"))
				continue;
			str = "SELECT * FROM Breakfast WHERE HotelID="+ hotelID + " AND bType='"+ thisBreakfast+"'";
			temp = st.executeQuery(str);
			temp.next();
			totalPrice += temp.getInt("bPrice");
		}
		//out.print("<br>"+totalPrice);
		
		
		String thisService;
		for(int i = 0; i<services.length; i++){
			thisService = services[i];
			str = "SELECT * FROM Service WHERE HotelID="+ hotelID + " AND sType='"+ thisService+"'";
			temp = st.executeQuery(str);
			temp.next();
			totalPrice += temp.getInt("sCost");
		}
		//out.print("<br>"+totalPrice);
		
		
		str = "SELECT * FROM Room WHERE HotelID="+ hotelID + " AND Room_no=" + Room_no;
		temp = st.executeQuery(str);
		temp.next();
		totalPrice += temp.getInt("Price");
		
		session.setAttribute("totalAmt", totalPrice);
		%>
		<br>
		<br>
		<label>Total Price: </label>$<%=totalPrice%>
		<br>
		
		<form action="Reservation.jsp" class="form-horizontal" role="form" method="post">
		    <fieldset>
		      <div class="form-group">
		        <label class="col-sm-3 control-label" for="FLName">Name on Card</label>
		        <div class="col-sm-9">
		          <input type="text" class="form-control" name="FLName" id="FLName" placeholder="Card Holder's Name" required>
		        </div>
		      </div>
		      <div class="form-group">
		        <label class="col-sm-3 control-label" for="Cnumber">Card Number</label>
		        <div class="col-sm-9">
		          <input type="number" class="form-control" name="Cnumber" id="Cnumber" placeholder="Credit Card Number" required>
		        </div>
		      </div>
		      <div class="form-group">
		        <label class="col-sm-3 control-label" for="BillingAddr">Billing Address</label>
		        <div class="col-sm-9">
		          <input type="text" class="form-control" name="BillingAddr" id="BillingAddr" placeholder="Address" required>
		        </div>
		      </div>
		      		      <div class="form-group">
		        <label class="col-sm-3 control-label" for="Type">Card Type</label>
		        <div class="col-sm-9">
		          <div class="row">
		            <div class="col-xs-3">
		              <select class="form-control col-sm-2" name="Type" id="Type" required>
		                <option>Type</option>
		                <option value="VISA">VISA</option>
		                <option value="MASTER">MASTER</option>
		                <option value="DISCOVER">DISCOVER</option>
		                <option value="AMEX">AMEX</option>
		              </select>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="form-group">
		        <label class="col-sm-3 control-label" for="ExpDate">Expiration Date</label>
		        <div class="col-sm-9">
		          <div class="row">
		            <div class="col-xs-3">
		              <select class="form-control col-sm-2" name="ExpDateM" id="ExpDate" required>
		                <option>Month</option>
		                <option value="01">Jan (01)</option>
		                <option value="02">Feb (02)</option>
		                <option value="03">Mar (03)</option>
		                <option value="04">Apr (04)</option>
		                <option value="05">May (05)</option>
		                <option value="06">June (06)</option>
		                <option value="07">July (07)</option>
		                <option value="08">Aug (08)</option>
		                <option value="09">Sep (09)</option>
		                <option value="10">Oct (10)</option>
		                <option value="11">Nov (11)</option>
		                <option value="12">Dec (12)</option>
		              </select>
		            </div>
		            <div class="col-xs-3">
		              <select class="form-control col-sm-2" name="ExpDateY" required>
		                <option value="17">2017</option>
		                <option value="18">2018</option>
		                <option value="19">2019</option>
		                <option value="20">2020</option>
		                <option value="21">2021</option>
		                <option value="22">2022</option>
		                <option value="23">2023</option>
		              </select>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="form-group">
		        <label class="col-sm-3 control-label" for="SecCode">Card CVV</label>
		        <div class="col-sm-3">
		          <input type="number" class="form-control" name="SecCode" id="SecCode" placeholder="Security Code" required>
		        </div>
		      </div>
		      <div class="form-group">
		        <div class="col-sm-offset-3 col-sm-9">
		          <input type="submit" class="btn btn-success" value="Reserve">
		        </div>
		      </div>
		    </fieldset>
		  </form>
		<%
		

	    try { st.close(); } catch (Exception e) { /* ignored */ }
	    try { con.close(); } catch (Exception e) { /* ignored */ }	
	}catch(Exception ex){
		out.print("error");
	}finally{
		
	}
%>
	


	
	
	
	
<% 
	}else{
		out.print("You must first select a room before payment.");
	}%>