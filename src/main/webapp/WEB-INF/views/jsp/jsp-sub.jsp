<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>JSP</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">JSP Tutorial</li>
		<li class="sub-menu-item"><a href="How-to-install-Tomcat">Tomcat 설치</a></li>
		<li class="sub-menu-item"><a href="Namecard-Webapp">명함관리 웹 애플리케이션</a></li>
		<li class="sub-menu-item"><a href="Web-Application">웹 애플리케이션</a></li>
		<li class="sub-menu-item"><a href="Web-Application-Directory-Structure">웹 애플리케이션 작성 실습</a></li>
		<li class="sub-menu-item"><a href="Servlets">서블릿</a></li>
		<li class="sub-menu-item"><a href="JSP">JSP</a></li>
		<li class="sub-menu-item"><a href="Accessing-database-from-JSP_Servlets">데이터베이스 연동</a></li>
		<li class="sub-section-title">게시판</li>	
		<li class="sub-menu-item"><a href="BBS-Study">게시판</a></li>
		<li class="sub-menu-item"><a href="Thread-BBS">계층형 게시판</a></li>
		<li class="sub-menu-item"><a href="BBS-Model1">모델1 게시판</a></li>
		<li class="sub-menu-item"><a href="DataSource">DataSource</a></li>
		<li class="sub-menu-item"><a href="Model2">모델 2</a></li>
		<li class="sub-menu-item"><a href="Paging">페이징 로직 재사용</a></li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>