<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Login Error</title>
	</head>
	<body>
		<script>
			alert("The username or password you entered is incorrect. Please try again.");
			window.location.href = "LoginPage.jsp";
		</script>	
	</body>
</html>