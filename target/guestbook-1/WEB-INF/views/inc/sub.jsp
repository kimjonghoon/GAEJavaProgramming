<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong id="main-menu-title">${category }</strong>
	<ul id="sub-menu">
	<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/${i.category }/${i.id }">${i.title }</a></li>
	</c:forEach>
	</ul>
</nav>