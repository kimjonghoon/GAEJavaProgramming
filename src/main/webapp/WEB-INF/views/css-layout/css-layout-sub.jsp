<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<nav id="secondaryNav">
	<strong>CSS-Layout</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">3 column fixed width layout</li>
		<li class="sub-menu-item"><a href="/css-layout/div-element-arrangement">Main div elements arrangement</a></li>
		<li class="sub-menu-item"><a href="/css-layout/main-menu-styling">Main Menu Styling</a></li>
		<li class="sub-menu-item"><a href="/css-layout/sub-menu-styling">Sub Menu Styling</a></li>
		<li class="sub-menu-item"><a href="/css-layout/header-footer-content-styling">#header, #footer, #content Styling</a></li>
		
		<li class="sub-section-title">Board Design</li>
		<li class="sub-menu-item"><a href="/css-layout/bbs-list-styling">List</a></li>
		<li class="sub-menu-item"><a href="/css-layout/bbs-view-styling">Detailed View</a></li>
		<li class="sub-menu-item"><a href="/css-layout/bbs-write_form-styling">Write &amp; Sign Up</a></li>
		
		<li class="sub-section-title">Blogs in Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>