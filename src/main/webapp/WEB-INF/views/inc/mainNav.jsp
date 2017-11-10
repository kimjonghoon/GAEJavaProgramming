<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<ul id="main-menu">
	<li class="main-menu-item"><a href="/java/Features">Java</a></li>
	<li class="main-menu-item"><a href="/jdbc/JDBC-Intro">JDBC</a></li>
	<li class="main-menu-item"><a href="/jsp/How-to-install-Tomcat">JSP</a></li>
	<li class="main-menu-item"><a href="/css-layout/div-element-arrangement">CSS Layout</a></li>
	<li class="main-menu-item"><a href="/jsp-pjt/Dynamic-Web-Project-Set-Up">JSP Project</a></li>
	<li class="main-menu-item"><a href="/spring/building-java-projects-with-maven">Spring</a></li>
	<li class="main-menu-item"><a href="/javascript/introduction">JavaScript</a></li>
	<li class="main-menu-item"><a href="/google-app-engine/building-gae-projects-with-maven">Google App Engine</a>
	<li class="main-menu-item"><a href="/blog">Blog</a></li>
	<li class="main-menu-item"><a href="/bbs/list?boardCd=free&page=1">BBS</a>
<security:authorize access="hasRole('ROLE_ADMIN')">	
	<li class="main-menu-item"><a href="/admin">Admin</a></li>
</security:authorize>	
</ul>