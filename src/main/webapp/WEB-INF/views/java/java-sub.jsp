<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<nav id="secondaryNav">
	<strong id="main-menu-title">Java</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Java Introduction</li>
		<li class="sub-menu-item"><a href="/java/Features">Java Features</a></li>
		<li class="sub-menu-item"><a href="/java/Class-Object">Class and Object</a></li>
		<li class="sub-section-title">Java Basic</li>
		<li class="sub-menu-item"><a href="/java/Keyword_Indentifiers_Comment">Indentifiers</a></li>
		<li class="sub-menu-item"><a href="/java/DataType_Casting">Data Type</a></li>
		<li class="sub-menu-item"><a href="/java/Arrays">Arrays</a></li>
		<li class="sub-menu-item"><a href="/java/Operators">Operators</a></li>
		<li class="sub-menu-item"><a href="/java/if_switch_loops">if, switch, loops</a></li>
		<li class="sub-menu-item"><a href="/java/Package_Modifiers">Package, Modifiers</a></li>
		<li class="sub-menu-item"><a href="/java/Inheritance">Inheritance</a></li>
		<li class="sub-menu-item"><a href="/java/Static">static keyword</a></li>
		<li class="sub-menu-item"><a href="/java/Collection">Collection</a></li>
		<li class="sub-menu-item"><a href="/java/Exception">Exception</a></li>
		<li class="sub-section-title">Javabank example</li>
		<li class="sub-menu-item"><a href="/java/Javabank-Requirements-analysis">Requirements Analysis</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Design">Application Design</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-inheritance">Inheritance</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-abstract-class">Abstract Class</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-interface">Interface</a></li>
		<li class="sub-section-title">Java Advanced</li>
		<li class="sub-menu-item"><a href="/java/Thread">Thread</a></li>
		<li class="sub-menu-item"><a href="/java/Stream">Stream</a></li>
		<li class="sub-menu-item"><a href="/java/Logging">Logging</a></li>
		<li class="sub-menu-item"><a href="/java/Socket">Socket</a></li>
		<li class="sub-menu-item"><a href="/java/RMI">RMI</a></li>
		<li class="sub-section-title">Blogs using Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>