<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>JDBC</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Basic</li>
		<li class="sub-menu-item"><a href="/jdbc/JDBC-Intro">JDBC Introduction</a></li>
		<li class="sub-menu-item"><a href="/jdbc/How-to-install-Oracle">How to install Oracle</a></li>
		<li class="sub-menu-item"><a href="/jdbc/Login-to-the-scott-account">Login to the scott account</a></li>
		<li class="sub-menu-item"><a href="/jdbc/SQL-SELECT-Statement">SQL SELECT Statement</a></li>
		<li class="sub-menu-item"><a href="/jdbc/SQL-DML-Statement">SQL DML Statement</a></li>
		<li class="sub-menu-item"><a href="/jdbc/Oracle-JDBC-Test">Oracle JDBC Test</a></li>
		<li class="sub-menu-item"><a href="/jdbc/Guide-to-using-JDBC">JDBC Guide</a></li>
		<li class="sub-menu-item"><a href="/jdbc/JDBC-Create-Table">JDBC - Create Tables</a></li>
		<li class="sub-menu-item"><a href="/jdbc/JDBC-Insert">JDBC - Insert</a></li>
		<li class="sub-menu-item"><a href="/jdbc/JDBC-Select">JDBC - Select</a></li>
		<li class="sub-menu-item"><a href="/jdbc/JDBC-Update">JDBC - Update</a></li>
		<li class="sub-menu-item"><a href="/jdbc/PreparedStatement">PreparedStatement</a></li>
		<li class="sub-menu-item"><a href="/jdbc/JDBC-Join">JDBC - Join</a></li>
		<li class="sub-menu-item"><a href="/jdbc/JDBC-Transaction">JDBC - Transaction</a></li>
		<li class="sub-menu-item"><a href="/jdbc/Connection-Pool">Connection Pool</a></li>
		<li class="sub-section-title">Labs</li>
		<li class="sub-menu-item"><a href="/jdbc/Namecard">Namecard</a></li>
		<li class="sub-menu-item"><a href="/jdbc/JavaBank">JavaBank</a></li>
		<li class="sub-section-title">Blogs in Datastore</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>
	</ul>
</nav>