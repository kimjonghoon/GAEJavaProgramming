<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user != null && userService.isUserAdmin()) {
%>    
<a href="/blog/list">Blog Manager</a>
<%
	}
    if (user != null) {
        pageContext.setAttribute("user", user);
%>

${fn:escapeXml(user.nickname)} <a href="<%= userService.createLogoutURL("/")%>">Sign out</a>
<%
    } else {
%>
<a href="<%= userService.createLoginURL("/") %>">Sign in</a>
<%
    }
%>