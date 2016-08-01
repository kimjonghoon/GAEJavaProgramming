<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<nav id="secondaryNav">
	<strong id="main-menu-title">Java</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Java Introduction</li>
		<li class="sub-menu-item"><a href="/java/Features">자바의 특징</a></li>
		<li class="sub-menu-item"><a href="/java/Object-and-Class">객체와 클래스</a></li>
		<li class="sub-section-title">Java Basic</li>
		<li class="sub-menu-item"><a href="/java/Class-Object">Class and Object</a></li>
		<li class="sub-menu-item"><a href="/java/Keyword_Indentifiers_Comment">Indentifiers</a></li>
		<li class="sub-menu-item"><a href="/java/DataType_Casting">Data Type</a></li>
		<li class="sub-menu-item"><a href="/java/Arrays">Arrays</a></li>
		<li class="sub-menu-item"><a href="/java/Operators">Operators</a></li>
		<li class="sub-menu-item"><a href="/java/if_switch_loops">if, switch, loops</a></li>
		<li class="sub-menu-item"><a href="/java/Package_Modifiers">Package, Modifiers</a></li>
		<li class="sub-menu-item"><a href="/java/Inheritance">Inheritance</a></li>
		<li class="sub-menu-item"><a href="/java/Static">Static</a></li>
		<li class="sub-menu-item"><a href="/java/Collection">Collection</a></li>
		<li class="sub-menu-item"><a href="/java/Exception">Exception</a></li>
		<li class="sub-section-title">Bank example</li>
		<li class="sub-menu-item"><a href="/java/Javabank-Requirements-analysis">Javabank<br />Requirements analysis</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Design">Javabank<br />Design</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-inheritance">Javabank<br />inheritance</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-abstract-class">Javabank<br />Abstract Class</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-interface">Javabank<br />Interface</a></li>
		<li class="sub-menu-item"><a href="/java/Thread">Thread</a></li>
		<li class="sub-menu-item"><a href="/java/Stream">Stream</a></li>
		<li class="sub-menu-item"><a href="/java/Logging">Logging</a></li>
		<li class="sub-section-title">Java Network</li>
		<li class="sub-menu-item"><a href="/java/Socket">Socket</a></li>
		<li class="sub-menu-item"><a href="/java/RMI">RMI</a></li>
		<li class="sub-section-title">Blogs using Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>