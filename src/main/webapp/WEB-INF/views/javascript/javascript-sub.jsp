<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>JavaScript</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Basic</li>
		<li class="sub-menu-item"><a href="/javascript/introduction">Introduction</a></li>
		<li class="sub-menu-item"><a href="/javascript/dataType">Data Type</a></li>
		<li class="sub-menu-item"><a href="/javascript/handling-select-items">Handling select items</a></li>
		<li class="sub-menu-item"><a href="/javascript/difference-between-javascript-and-java">Differenct between JavaScript &amp; Java</a></li>
		
		<li class="sub-section-title">JavaScript Objects</li>	
		<li class="sub-menu-item"><a href="/javascript/Number">Number</a></li>
		<li class="sub-menu-item"><a href="/javascript/String">String</a></li>
		<li class="sub-menu-item"><a href="/javascript/RegExp">RegExp</a></li>
		<li class="sub-menu-item"><a href="/javascript/Date">Date</a></li>
		<li class="sub-menu-item"><a href="/javascript/Array">Array</a></li>
		<li class="sub-menu-item"><a href="/javascript/Math">Math</a></li>
		<li class="sub-menu-item"><a href="/javascript/Function">Function</a></li>
		
		<li class="sub-section-title">Lab</li>	
		<li class="sub-menu-item"><a href="/javascript/javascript-form-validation">Form Validation</a></li>
		<li class="sub-menu-item"><a href="/javascript/Cookie">Cookie</a></li>
		<li class="sub-menu-item"><a href="/javascript/decoupling-html-and-javascript">Decoupling HTML and JavaScript</a></li>
		
		<li class="sub-section-title">Blogs in Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>