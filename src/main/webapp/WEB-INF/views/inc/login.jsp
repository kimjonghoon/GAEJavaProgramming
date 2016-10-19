<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%
String url = "";
String english = "";
String korean = "";
String qs = request.getQueryString();
if (qs != null) {
    if (qs.indexOf("&lang=") != -1) {
        qs = qs.substring(0, qs.indexOf("&lang="));
    }
    if (qs.indexOf("lang=") != -1) {
        qs = qs.substring(0, qs.indexOf("lang="));
    }
    if (!qs.equals("")) {
        String decodedQueryString = java.net.URLDecoder.decode(request.getQueryString(), "UTF-8");
        url = "?" + decodedQueryString;
        if (url.indexOf("&lang=") != -1) {
            url = url.substring(0, url.indexOf("&lang="));
        } 
        english = url + "&lang=en";
        korean = url + "&lang=ko";
    } else {
        english = url + "?lang=en";
        korean = url = "?lang=ko";
    }
} else {
    english = url + "?lang=en";
    korean = url = "?lang=ko";
}

pageContext.setAttribute("english", english);
pageContext.setAttribute("korean", korean);
%>

<a href="${english }">English</a> <a href="${korean }">Korean</a>

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