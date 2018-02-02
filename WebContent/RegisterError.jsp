<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Login Error</title>
	</head>
	<body>
		<script>
			alert("An account already exists for that username. Please log in.");
			window.location.href = "LoginPage.jsp";
		</script>	
	</body>
</html>