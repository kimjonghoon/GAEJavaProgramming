<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>구글 앱 엔진</strong>
	<ul id="sub-menu">
		<li class="sub-menu-item"><a href="/google-app-engine/building-gae-projects-with-maven">구글 앱 엔진 시작하기</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Logging">로깅</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Spring-MVC">스프링 MVC</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Spring-Security">스프링 시큐리티</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Objectify">Objectify</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Spring-optimization">스프링 최적화</a></li>

		<li class="sub-section-title">데이터스토어에 저장한 블로그</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>				
	</ul>
</nav>