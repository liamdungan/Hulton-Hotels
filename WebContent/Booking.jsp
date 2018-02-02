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
		<title>Room Reservation</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<!-- drop down style -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
    		<link rel="stylesheet" type="text/css" href="css/BookingStyle.css">
		<link rel="stylesheet" type="text/css" href="css/GeneralStyle.css">
			
	</head>
	<body>
	<%@ include file="SideNav.jsp" %>
	<div id = "main">
		<div id ="container" class="container">
		    <h1>Room Reservation</h1>
		    <div class="row">
		        <div class="col-sm-12">
		            <ul id="nav-tabs-wrapper" class="nav nav-tabs nav-tabs-horizontal">
		              <li class="active"><a id="1" href="#htab1" data-toggle="tab"> <b>Details</b> </a></li>
		              <li><a id="2" href="#htab2" data-toggle="tab"> <b>Rooms Available</b> </a></li>
		              <li><a id="3" href="#htab3" data-toggle="tab"> <b>Breakfast/Services</b> </a></li>
		              <li><a id="4" href="#htab4" data-toggle="tab"> <b>Payment</b> </a></li>
		            </ul>
		            <br>

		            <div class="tab-content" >
		                <div role="tabpanel" class="tab-pane fade in active" id="htab1">
		                 	<form method="post">
		                    <h4>Please select check-in/check-out dates.</h4>
		                    <hr>
		                        	<div class = "form-group">
									<label>Check In</label>
									<input type="date" name="checkin" class="form-control" required>
								</div>
								<div class = "form-group">
									<label>Check Out</label>
									<input type="date" name="checkout" class="form-control" required>
								</div>
								<div class = "form-group">
									<label>Number of People</label>
									<input type="number" name="numPeople" class="form-control" min="1" max="6" required>
								</div>
								<input type="hidden" name="HotelID" value="<%= request.getParameter("HotelID")%>">
								<input type="submit" name="submit" value="Continue" />
							</form>
		                </div>
		                <div role="tabpanel" class="tab-pane fade" id="htab2">
		                    <h4>Select your room.</h4>
							<hr>
							<jsp:include page="SearchRooms.jsp" />
				
		                </div>
		                <div role="tabpanel" class="tab-pane fade in" id="htab3">
		                    <h4>Please select your breakfast and services.</h4>
		                    <hr>
		                    <jsp:include page="SelectBreakfastServices.jsp" />

		                </div>
		                <div role="tabpanel" class="tab-pane fade in" id="htab4">
		                    <h4>Complete your reservation.</h4>
		                    <hr>
		                    <jsp:include page="CompletePayment.jsp" />

		                </div>
		                
		            </div>
		            
		        </div>
		    </div>
		    
		</div>
		</div>
		
		
		<script>
		$('#nav-tabs-wrapper a[data-toggle="tab"]').on('click', function(e) {
		    e.preventDefault();
		    $(e.target).closest('ul').hide().prev('a').removeClass('open').text( $(this).text() );   
		});

		<%
		if (request.getParameter("submit") != null) {
			%>	
			$("#1, #3, #4").removeAttr("data-toggle href"); $( "#2" ).trigger( "click" );
			<%
			
		}else if(request.getParameter("submit2") != null){
    			%>
    			$("#1, #2, #4").removeAttr("data-toggle href"); $( "#3" ).trigger( "click" );
    			<% 
    			
    		}else if(request.getParameter("submit3") != null){
    			%>
    			$("#1, #2, #3").removeAttr("data-toggle href"); $( "#4" ).trigger( "click" );
    			<% 
    		}

		%>
		</script>

	</body>
</html>

<%
    }
%>