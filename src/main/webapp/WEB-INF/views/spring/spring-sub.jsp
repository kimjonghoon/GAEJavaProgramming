<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>Spring</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Spring Basic</li>
		<li class="sub-menu-item"><a href="/spring/building-java-projects-with-maven">Building java projects with Maven</a></li>
		<li class="sub-menu-item"><a href="/spring/di">Spring DI</a></li>
		<li class="sub-menu-item"><a href="/spring/aop">Spring AOP</a></li>
		<li class="sub-menu-item"><a href="/spring/jdbc">Spring JDBC</a></li>
		<li class="sub-menu-item"><a href="/spring/transaction">Spring Transaction</a></li>
		
		<li class="sub-section-title">Spring MVC</li>
		<li class="sub-menu-item"><a href="/spring/spring-mvc-with-maven">Building Spring MVC with Maven</a></li>
		<li class="sub-menu-item"><a href="/spring/spring-mvc-bbs">Spring MVC Board</a></li>
		
		<li class="sub-section-title">Spring Security</li>
		<li class="sub-menu-item"><a href="/spring/spring-security-config">Filter Security</a></li>
		<li class="sub-menu-item"><a href="/spring/method-security">Method Security</a></li>
		<li class="sub-menu-item"><a href="/spring/security-at-view-layer">View Layer Security</a></li>
		
		<li class="sub-section-title">Bean Validataion</li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-signUp">Sign Up</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-editAccount">Edit Account</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-changePasswd">Change Password</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-write-article">New Article</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-modify-article">Modify Article</a></li>
		
		<li class="sub-section-title">Blogs in Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>				
	</ul>
</nav>