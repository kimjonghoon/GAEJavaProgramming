<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">    
	<strong id="main-menu-title">Home</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Java Introduction</li>
		<li class="sub-menu-item"><a href="/java/JDK-Install">자바 설치</a></li>
		<li class="sub-section-title">Blogs using Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>