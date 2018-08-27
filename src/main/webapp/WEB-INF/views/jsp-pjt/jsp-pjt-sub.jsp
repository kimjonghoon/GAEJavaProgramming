<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>JSP Project</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Model 1</li>
		<li class="sub-menu-item"><a href="/jsp-pjt/Dynamic-Web-Project-Set-Up">Dynamic Web Project</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/database-design">Database Design</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/how-to-use-log4j">How to use Log4j</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-prototype">Prototype</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-javabeans">JavaBeans</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-implementation">Implementaion</a></li>
		<li class="sub-section-title">Model 2</li>	
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-model-2">Model 2</a></li>
		
		<li class="sub-section-title">Blogs in Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>