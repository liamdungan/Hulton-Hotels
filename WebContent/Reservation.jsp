<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.text.*,java.util.Date" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<% 

try{
	int Cnumber = Integer.parseInt(request.getParameter("Cnumber"));
	String BillingAddr = request.getParameter("BillingAddr");
	String FLName = request.getParameter("FLName");
	int SecCode = Integer.parseInt(request.getParameter("SecCode"));
	String Type = request.getParameter("Type");

	String ExpDateM = request.getParameter("ExpDateM");
	String ExpDateY = request.getParameter("ExpDateY");
	String ExpDate = ExpDateM + "/" + ExpDateY;

	//invoiceNo
	Random random = new Random();
	int InvoiceNum = random.nextInt(900) + 100;
	String InvoiceNo = Integer.toString(InvoiceNum);

	//resDate
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
	String ResDate = dateFormat.format(date); //2016/11/16 12:08:43

	//totalAmt
	int totalAmt = (Integer)session.getAttribute("totalAmt");

	//InDate
	String InDate = (String)session.getAttribute("checkin");
	//OutDate
	String OutDate = (String)session.getAttribute("checkout");

	int hotelID = (Integer)session.getAttribute("HotelID");
	String HotelID = Integer.toString(hotelID);

	int Room_no = (Integer)session.getAttribute("Room_no");

	String bTypes[] = (String[])session.getAttribute("bType");
	String sType[] = (String[])session.getAttribute("sType");

	String username = (String)session.getAttribute("username");


	//Connect to database
	String url = "jdbc:mysql://databaseproject.cazsbjbmf9qu.us-east-1.rds.amazonaws.com:3306/Project2";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "dmathur", "davesh123"); 
	Statement st = con.createStatement();

	//CID
	String str = "SELECT * FROM Customer WHERE username='"+ username +"'";
	ResultSet customer = st.executeQuery(str);
	customer.next();
	int 	CID = customer.getInt("CID");

	//out.print(CID);


	//remove breakfast type duplicates for now
	Set<String> set = new HashSet<String>();
	for (String temp : bTypes) {
			if(temp.equals("None"))
				continue;
	    set.add(temp);
	}
	String[] bType = set.toArray(new String[0]);
	//out.print(Arrays.toString(bType));
	//out.print(Arrays.toString(sType));

	
	
	//Add to reservation in db
    PreparedStatement newReservation = con.prepareStatement("INSERT INTO Reservation VALUES(?, ?, ?)");
    newReservation.setString(1 , InvoiceNo);
    newReservation.setString(2 , ResDate);
    newReservation.setInt(3, totalAmt);
    newReservation.executeUpdate();


	//Add credit card to db
    PreparedStatement newCreditCard = con.prepareStatement("INSERT INTO CreditCard VALUES(?, ?, ?, ?, ?, ?)");
    newCreditCard.setInt(1 , Cnumber);
    newCreditCard.setString(2 , BillingAddr);
    newCreditCard.setString(3, FLName);
    newCreditCard.setInt(4, SecCode);
    newCreditCard.setString(5 , Type);
    newCreditCard.setString(6, ExpDate);
    newCreditCard.executeUpdate();
    
    
    //error
    //Add to Makes in db
    PreparedStatement newMakes = con.prepareStatement("INSERT INTO Makes VALUES(?, ?, ?)");
    newMakes.setString(1 , InvoiceNo);
    newMakes.setInt(2 , Cnumber);
    newMakes.setInt(3, CID);
    newMakes.executeUpdate();
    
    
    
    //error
    //Add to BreakfastReservationIncludes in db
    PreparedStatement newIncludes = con.prepareStatement("INSERT INTO BreakfastReservationIncludes VALUES(?, ?, ?)");
    String thisbType;
    for(int i = 0; i<bType.length; i++){
    		newIncludes = con.prepareStatement("INSERT INTO BreakfastReservationIncludes VALUES(?, ?, ?)");
    		thisbType = bType[i];
        newIncludes.setString(1 , InvoiceNo);
        newIncludes.setString(2 , thisbType);
        newIncludes.setString(3, HotelID);
        newIncludes.executeUpdate();
    }
    
    //Add to ServiceReservationContains
    PreparedStatement newContains = con.prepareStatement("INSERT INTO ServiceReservationContains valuVALUESes(?, ?, ?)");
    String thissType;
    for(int i = 0; i<sType.length; i++){
    		newContains = con.prepareStatement("INSERT INTO ServiceReservationContains VALUES(?, ?, ?)");
    		thissType = sType[i];
    		newContains.setString(1 , InvoiceNo);
    		newContains.setString(2 , thissType);
    		newContains.setString(3, HotelID);
    		newContains.executeUpdate();
    }
    
    //Add to Reserves db
    PreparedStatement newReserves = con.prepareStatement("INSERT INTO Reserves VALUES(?, ?, ?, ?, ?)");
    newReserves.setString(1 , OutDate);
    newReserves.setString(2 , InDate);
    newReserves.setInt(3 , Room_no);
    newReserves.setString(4 , HotelID);
    newReserves.setString(5, InvoiceNo);
    newReserves.executeUpdate();

	//out.println(newCreditCard);
	//out.println(newMakes);
	//out.println(newReservation);
	//out.println(newIncludes);
	//out.println(newContains);
	//out.println(newReserves);
    
	try { st.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
}catch(Exception ex){
	out.print("Error");
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