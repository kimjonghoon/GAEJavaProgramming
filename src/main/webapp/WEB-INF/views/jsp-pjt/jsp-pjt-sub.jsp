<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong id="main-menu-title">JSP Project</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Model 1</li>
		<li class="sub-menu-item"><a href="/jsp-pjt/Dynamic-Web-Project-Set-Up">개발 준비</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/database-design">데이터베이스 설계</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/how-to-use-log4j">로깅</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-prototype">프로토타입</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-javabeans">자바빈즈</a></li>
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-implementation">구현</a></li>
		<li class="sub-section-title">Model 2</li>	
		<li class="sub-menu-item"><a href="/jsp-pjt/bbs-model-2">모델 2</a></li>
		
		<li class="sub-section-title">데이터스토어에 저장한 블로그</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>