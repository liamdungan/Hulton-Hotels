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
		<title>Reviews</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/ReviewsStyle.css">
		<link rel="stylesheet" type="text/css" href="css/GeneralStyle.css">
	</head>
	
	<body>
		<%@ include file="SideNav.jsp" %>
		<div id = "main">
		<div id ="container" class= "container">
			<h1>Reviews</h1>
			<hr>
			<div class="row">
		        <div class="col-sm-12">
		            <ul id="nav-tabs-wrapper" class="nav nav-tabs nav-tabs-horizontal">
		              <li class="active"><a id="1" href="#htab1" data-toggle="tab"> <b>Room Review</b> </a></li>
		              <li><a id="2" href="#htab2" data-toggle="tab"> <b>Breakfast Review</b> </a></li>
		              <li><a id="3" href="#htab3" data-toggle="tab"> <b>Service Review</b> </a></li>
		            </ul>
		            <br>

		            <div class="tab-content" >
		                <div role="tabpanel" class="tab-pane fade in active" id="htab1">
						<%
						try{
							//Connect to database
						    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
						    Class.forName("com.mysql.jdbc.Driver");
						    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
						    Statement st = con.createStatement();
						    
						    //get CID
						    String username = (String)session.getAttribute("username");
							String str = "SELECT * FROM Customer WHERE username='"+ username +"'";
							ResultSet rs = st.executeQuery(str);
							rs.next();
							int 	CID = rs.getInt("CID");
							
							//review id
							Random random = new Random();
							int reviewID = random.nextInt(900) + 100;
							String ReviewID = Integer.toString(reviewID);
							
							out.print("<form action='RoomReview.jsp' method='post'>");
							
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
							if(invoice[0] != null){
								out.print("Select a room and leave a review.<br><br>");
								
								//i--;
								ResultSet reserves;
								while(i >= 0){
									str = "SELECT * FROM Reserves WHERE InvoiceNo='"+ invoice[i] +"'";
									reserves = st.executeQuery(str);
									while(reserves.next()){
										out.print("<input type='radio' value='"+ reserves.getInt("Room_no")+";" + reserves.getString("HotelID") +"' name='room' required/>"+" Room #: "+reserves.getInt("Room_no") + " - Hotel ID: " +reserves.getString("HotelID") + "<br>");
									}
								i--;
								}
							%>
			<br>
			<br>
			<fieldset>
			<input type = "hidden" name = "CID" value= <%=CID%>>
			<input type = "hidden" name = "ReviewID" value= <%=reviewID%>>
			<div class = "form-group">
				<label class="col-sm-3 control-label" for="Rating">Rating</label>
				<div class="col-sm-9">
					<input type="number" name="Rating" class="form-control" placeholder="1-10" min="1" max="10" required>
				</div>
			</div>
			<br><br>
			<div class="form-group">
		        <label class="col-sm-3 control-label" for="TextComment">Additional Comments</label>
		        <div class="col-sm-9">
		          <input type="text" class="form-control" name="TextComment" id="TextComment" maxlength="28" placeholder="comments" required>
		        </div>
		      </div>
			<br><br>
		      <div class="form-group">
		        <div class="col-sm-offset-3 col-sm-9">
		          <input type="submit" class="btn btn-success" value="Submit">
		        </div>
		      </div>
		    </fieldset>
							<%
								
								
							out.print("</form>");
							}else{
								out.print("You currently do not have any rooms to review.");
							}
							
						    %>
							
						    <%
						    try { st.close(); } catch (Exception e) { /* ignored */ }
						    try { con.close(); } catch (Exception e) { /* ignored */ }
						}catch(Exception ex){
							out.print("error loading Room Reviews");
						}
		                 %>

		                </div>
		                <div role="tabpanel" class="tab-pane fade" id="htab2">
		                <%
						try{
							//Connect to database
						    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
						    Class.forName("com.mysql.jdbc.Driver");
						    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
						    Statement st = con.createStatement();
						    
							//review id
							Random random = new Random();
							int reviewID = random.nextInt(900) + 100;
							String ReviewID = Integer.toString(reviewID);
						    
						    //get CID
						    String username = (String)session.getAttribute("username");
							String str = "SELECT * FROM Customer WHERE username='"+ username +"'";
							ResultSet rs = st.executeQuery(str);
							rs.next();
							int 	CID = rs.getInt("CID");
							
							out.print("<form action='BreakfastReview.jsp' method='post'>");
							
							//invoice
							str = "SELECT * FROM Makes WHERE CID=" + CID;
							ResultSet makes = st.executeQuery(str);
							String InvoiceNo = "";
							
							String invoice[] = new String[20];
							int i = 0;
							while(makes.next()){
								invoice[i] = makes.getString("InvoiceNo");
								i ++;
								//out.print(i + "-");
							}
							//out.print(Arrays.toString(invoice));
							makes.close();
							if(invoice[0] != null){
								out.print("Select a breakfast order and leave a review.<br><br>");
								
								//i--;
								ResultSet includes;
								while(i >= 0){
									str = "SELECT * FROM BreakfastReservationIncludes WHERE InvoiceNo='"+ invoice[i] +"'";
									includes = st.executeQuery(str);
									while(includes.next()){
										out.print("<input type='radio' value='"+ includes.getString("bType")+";" + includes.getString("HotelID") +"' name='service' required/>"+" Type: "+includes.getString("bType") + " - Hotel ID: " +includes.getString("HotelID") + " for reservation number: " + includes.getString("InvoiceNo") + "<br>");
									}
								i--;
								}
						    
				%>
			<br>
			<br>
			<fieldset>
			<input type = "hidden" name = "CID" value= <%=CID%>>
			<input type = "hidden" name = "ReviewID" value= <%=reviewID%>>
			<div class = "form-group">
				<label class="col-sm-3 control-label" for="Rating">Rating</label>
				<div class="col-sm-9">
					<input type="number" name="Rating" class="form-control" placeholder="1-10" min="1" max="10" required>
				</div>
			</div>
			<br><br>
			<div class="form-group">
		        <label class="col-sm-3 control-label" for="TextComment">Additional Comments</label>
		        <div class="col-sm-9">
		          <input type="text" class="form-control" name="TextComment" id="TextComment" maxlength="28" placeholder="comments" required>
		        </div>
		      </div>
			<br><br>
		      <div class="form-group">
		        <div class="col-sm-offset-3 col-sm-9">
		          <input type="submit" class="btn btn-success" value="Submit">
		        </div>
		      </div>
		    </fieldset>
				<%
							}else{
								out.print("You currently have no Breakfast orders to review.");
							}
							out.print("</form>");
		        		
						    try { st.close(); } catch (Exception e) { /* ignored */ }
						    try { con.close(); } catch (Exception e) { /* ignored */ }
						}catch(Exception ex){
							out.print("error loading Breakfast Reviews");
						}
						%>
				
		                </div>
		                <div role="tabpanel" class="tab-pane fade in" id="htab3">
		                <%
						try{
							//Connect to database
						    String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
						    Class.forName("com.mysql.jdbc.Driver");
						    Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
						    Statement st = con.createStatement();
						    
							//review id
							Random random = new Random();
							int reviewID = random.nextInt(900) + 100;
							String ReviewID = Integer.toString(reviewID);
						    
						    //get CID
						    String username = (String)session.getAttribute("username");
							String str = "SELECT * FROM Customer WHERE username='"+ username +"'";
							ResultSet rs = st.executeQuery(str);
							rs.next();
							int 	CID = rs.getInt("CID");
							out.print("<form action='ServiceReview.jsp' method='post'>");
							
							//invoice
							str = "SELECT * FROM Makes WHERE CID=" + CID;
							ResultSet makes = st.executeQuery(str);
							String InvoiceNo = "";
							
							String invoice[] = new String[20];
							int i = 0;
							while(makes.next()){
								invoice[i] = makes.getString("InvoiceNo");
								i ++;
								//out.print(i + "-");
							}
							//out.print(Arrays.toString(invoice));
							makes.close();
							if(invoice[0] != null){
								out.print("Select a service and leave a review.<br><br>");
								
								//i--;
								ResultSet includes;
								while(i >= 0){
									str = "SELECT * FROM ServiceReservationContains WHERE InvoiceNo='"+ invoice[i] +"'";
									includes = st.executeQuery(str);
									while(includes.next()){
										out.print("<input type='radio' value='"+ includes.getString("sType")+";" + includes.getString("HotelID") +"' name='service' required/>"+" Type: "+includes.getString("sType") + " - Hotel ID: " +includes.getString("HotelID") + " for reservation number: " + includes.getString("InvoiceNo") + "<br>");
									}
								i--;
								}
						    
			%>
			<br>
			<br>
			<fieldset>
			<input type = "hidden" name = "CID" value= <%=CID%>>
			<input type = "hidden" name = "ReviewID" value= <%=reviewID%>>
			<div class = "form-group">
				<label class="col-sm-3 control-label" for="Rating">Rating</label>
				<div class="col-sm-9">
					<input type="number" name="Rating" class="form-control" placeholder="1-10" min="1" max="10" required>
				</div>
			</div>
			<br><br>
			<div class="form-group">
		        <label class="col-sm-3 control-label" for="TextComment">Additional Comments</label>
		        <div class="col-sm-9">
		          <input type="text" class="form-control" name="TextComment" id="TextComment" maxlength="28" placeholder="comments" required>
		        </div>
		      </div>
			<br><br>
		      <div class="form-group">
		        <div class="col-sm-offset-3 col-sm-9">
		          <input type="submit" class="btn btn-success" value="Submit">
		        </div>
		      </div>
		    </fieldset>

			<%    
						}else{
							out.print("You currently have no services to review.");
						}
							out.print("</form>");	
		        		
						    try { st.close(); } catch (Exception e) { /* ignored */ }
						    try { con.close(); } catch (Exception e) { /* ignored */ }
						}catch(Exception ex){
							out.print("error loading Service Reviews");
						}
						%>
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
		</script>
			
	</body>
</html>





<% } %>