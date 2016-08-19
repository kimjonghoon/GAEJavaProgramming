<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<a href="?lang=en">English</a> <a href="?lang=ko">Korean</a>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user != null && userService.isUserAdmin()) {
%>

    
<a href="/blog/list"><spring:message code="blog.manage" /></a>
<%
	}
    if (user != null) {
        pageContext.setAttribute("user", user);
%>

${fn:escapeXml(user.nickname)} <a href="<%= userService.createLogoutURL("/")%>"><spring:message code="sign.out" /></a>
<%
    } else {
%>
<a href="<%= userService.createLoginURL("/") %>"><spring:message code="sign.in" /></a>
<%
    }
%>