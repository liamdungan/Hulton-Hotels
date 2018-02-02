<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	session.removeAttribute("username");
	session.removeAttribute("HotelID");
	session.removeAttribute("password");
	session.invalidate();
	System.out.println("logout Sucessful");
	response.sendRedirect("LoginPage.jsp");		
%>
