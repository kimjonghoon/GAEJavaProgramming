<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<ul id="main-menu">
	<li class="main-menu-item"><a href="/java/Features">Java</a></li>
	<li class="main-menu-item"><a href="/jdbc/JDBC-Intro">JDBC</a></li>
	<li class="main-menu-item"><a href="/jsp/How-to-install-Tomcat">JSP</a></li>
	<li class="main-menu-item"><a	href="/css-layout/div-element-arrangement">CSS Layout</a></li>
	<li class="main-menu-item"><a	href="/jsp-pjt/Dynamic-Web-Project-Set-Up">JSP Project</a></li>
	<li class="main-menu-item"><a	href="/spring/building-java-projects-with-maven">Spring</a></li>
	<li class="main-menu-item"><a href="/javascript/introduction">JavaScript</a></li>
	<li class="main-menu-item"><a	href="/bbs/list?boardCd=data&curPage=1">BBS</a>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user != null && userService.isUserAdmin()) {
%>
	<li class="main-menu-item"><a	href="/admin">Admin</a>
<%
	}
%>
</ul>