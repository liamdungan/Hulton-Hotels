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
		<!-- drop down style -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/GeneralStyle.css">
		
		
		<title>Home Page</title>
	</head>
	<body> 
	<%@ include file="SideNav.jsp" %>
	<div id = "main">
		<div id ="container" class="container" >
			<br/><br/>
			<div style="text-align:center">
				<h4>
				<%
				String name = session.getAttribute("username").toString();
				out.println("Hello,  " + name + ".");
				%>
				</h4>
				<br>
				<p>To begin please select the Country where you plan to stay.</p>
			
			</div>
			<br><br/>
			
			<div style="text-align:center">
			<form action="SearchHotels.jsp">
				<label class="col-form-label" >Select Country</label>
				<div class="form-group">
				<select name="country"  class="selectpicker" data-live-search="true" style="max-width:40%;margin: 0 auto;" required >
					<option value="" disabled selected>Country</option>
					<option data-tokens="US United States" value="US">United States</option>
					<option data-tokens="UK United Kingdom" value="UK">United Kingdom</option>
					<option data-tokens="IR Ireland" value="IR">Ireland</option>
				</select> 
				<br><br>
				<input type="submit" class="btn btn-primary btn-xs" value="Continue" >
				</div>
			</form>
			
			</div>
			<br>
			

		</div>
	</div>
	</body>
</html>


<%
    }
%>