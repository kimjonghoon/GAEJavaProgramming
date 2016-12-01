<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
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

UserService userService = UserServiceFactory.getUserService();
%>
<a href="${english }">English</a> <a href="${korean }">Korean</a>

<security:authorize access="hasRole('ROLE_ADMIN')">    
	<a href="/blog/list"><spring:message code="blog.manage" /></a>
</security:authorize>

<security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
    <security:authentication property="principal.userId" var="userIdCheck" />
    <security:authentication property="principal.email" var="emailCheck" />
    <security:authentication property="principal.nickname" var="nicknameCheck" />
</security:authorize>

<c:choose>
    <c:when test="${empty emailCheck}">
		<a href="<%=userService.createLoginURL("/") %>"><spring:message code="sign.in" /></a>
    </c:when>
    <c:otherwise>
        ${userIdCheck } ${emailCheck } ${nicknameCheck } <a href="/logout"><spring:message code="sign.out" /></a>
    </c:otherwise>
</c:choose>