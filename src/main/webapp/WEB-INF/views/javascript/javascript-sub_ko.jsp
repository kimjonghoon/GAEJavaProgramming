<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>JavaScript</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">기초</li>
		<li class="sub-menu-item"><a href="/javascript/introduction">자바스크립트 소개</a></li>
		<li class="sub-menu-item"><a href="/javascript/dataType">기본 데이터 타입</a></li>
		<li class="sub-menu-item"><a href="/javascript/handling-select-items">select 엘리먼트 다루기</a></li>
		<li class="sub-menu-item"><a href="/javascript/difference-between-javascript-and-java">자바와 다른점</a></li>
		
		<li class="sub-section-title">자바스크립트 객체</li>	
		<li class="sub-menu-item"><a href="/javascript/Number">Number</a></li>
		<li class="sub-menu-item"><a href="/javascript/String">String</a></li>
		<li class="sub-menu-item"><a href="/javascript/RegExp">정규표현식</a></li>
		<li class="sub-menu-item"><a href="/javascript/Date">Date</a></li>
		<li class="sub-menu-item"><a href="/javascript/Array">배열</a></li>
		<li class="sub-menu-item"><a href="/javascript/Math">Math</a></li>
		<li class="sub-menu-item"><a href="/javascript/Function">함수</a></li>
		
		<li class="sub-section-title">Lab</li>	
		<li class="sub-menu-item"><a href="/javascript/javascript-form-validation">유효성 검사</a></li>
		<li class="sub-menu-item"><a href="/javascript/Cookie">쿠키 다루기</a></li>
		<li class="sub-menu-item"><a href="/javascript/decoupling-html-and-javascript">HTML에서 자바스크립트 분리</a></li>
		
		<li class="sub-section-title">데이터스토어에 저장한 블로그</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>