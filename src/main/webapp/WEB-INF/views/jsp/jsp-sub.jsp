<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>JSP</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Basic</li>
		<li class="sub-menu-item"><a href="/jsp/How-to-install-Tomcat">How to install Tomcat</a></li>
		<li class="sub-menu-item"><a href="/jsp/Namecard-Webapp">Namecard Webapp</a></li>
		<li class="sub-menu-item"><a href="/jsp/Web-Application">What are web applications?</a></li>
		<li class="sub-menu-item"><a href="/jsp/Web-Application-Directory-Structure">Web application directory structure</a></li>
		<li class="sub-menu-item"><a href="/jsp/Servlet">Servlet</a></li>
		<li class="sub-menu-item"><a href="/jsp/JSP">JSP</a></li>
		<li class="sub-menu-item"><a href="/jsp/Accessing-database-from-JSP_Servlets">Using a database in web applications</a></li>
		<li class="sub-section-title">BBS</li>	
		<li class="sub-menu-item"><a href="/jsp/BBS-Study">Understanding the board program</a></li>
		<li class="sub-menu-item"><a href="/jsp/Thread-BBS">Thread BBS</a></li>
		<li class="sub-menu-item"><a href="/jsp/BBS-Model1">Model 1 BBS</a></li>
		<li class="sub-menu-item"><a href="/jsp/DataSource">DataSource</a></li>
		<li class="sub-menu-item"><a href="/jsp/Model2">Model 2 BBS</a></li>
		<li class="sub-section-title">Blogs in Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>		
	</ul>
</nav>