<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>Google App Engine</strong>
	<ul id="sub-menu">
		<li class="sub-menu-item"><a href="/google-app-engine/building-gae-projects-with-maven">Building GAE Projects With Maven</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Logging">Logging</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Spring-MVC">Spring MVC</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Spring-Security">Spring Security</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Objectify">Objectify</a></li>
		<li class="sub-menu-item"><a href="/google-app-engine/Spring-optimization">Spring Optimization</a></li>
		
		<li class="sub-section-title">Blogs in Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>				
	</ul>
</nav>