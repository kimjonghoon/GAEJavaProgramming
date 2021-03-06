<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<nav id="secondaryNav">
	<strong>CSS-Layout</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">3 column fixed width layout</li>
		<li class="sub-menu-item"><a href="/css-layout/div-element-arrangement">주요 엘리먼트 배치</a></li>
		<li class="sub-menu-item"><a href="/css-layout/main-menu-styling">메인 메뉴</a></li>
		<li class="sub-menu-item"><a href="/css-layout/sub-menu-styling">서브 메뉴</a></li>
		<li class="sub-menu-item"><a href="/css-layout/header-footer-content-styling">#header, #footer, #content 스타일</a></li>
		
		<li class="sub-section-title">게시판 디자인</li>
		<li class="sub-menu-item"><a href="/css-layout/bbs-list-styling">목록</a></li>
		<li class="sub-menu-item"><a href="/css-layout/bbs-view-styling">상세보기</a></li>
		<li class="sub-menu-item"><a href="/css-layout/bbs-write_form-styling">글쓰기, 회원가입</a></li>
		
		<li class="sub-section-title">데이터스토어에 저장한 블로그</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>