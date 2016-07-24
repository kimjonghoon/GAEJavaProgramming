<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8" />
<title><tiles:insertAttribute name="title" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="Keywords" content="<tiles:insertAttribute name="keywords" />" />
<meta name="Description" content="<tiles:insertAttribute name="description" />" />
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/resources/css/print.css" type="text/css" media="print" />
<link rel="stylesheet" href="/resources/css/prettify.css" type="text/css" />
<script src="/resources/js/prettify.js"></script>
<script src="/resources/js/jquery-1.10.2.min.js"></script>
<script src="/resources/js/commons.js"></script>
<tiles:insertAttribute name="only-page-script" />
</head>
<body>
<div id="wrap">

	<header>
		<tiles:insertAttribute name="header" />
	</header>

	<nav id="mainNav">
		<tiles:insertAttribute name="main-menu" />
	</nav>
	
	<div id="login">

	</div>

	<div id="content-wrap">
		<article>
			<div id="navigator"><tiles:insertAttribute name="category" /></div>
			<tiles:insertAttribute name="content" />
			<div id="prev-next">
			<ul>
				<li>Next : <a href="<tiles:insertAttribute name="next-link" />"><tiles:insertAttribute name="next-title" /></a></li>
				<li>Prev : <a href="<tiles:insertAttribute name="prev-link" />"><tiles:insertAttribute name="prev-title" /></a></li>
			</ul>
			</div>
		</article>
	</div>
		
	<div id="sidebar">
		<nav id="secondaryNav">
			<tiles:insertAttribute name="sub-menu" />
		</nav>
	</div>
	
	<aside>
		<tiles:insertAttribute name="showAd" />
	</aside>
	
	<footer class="floatstop">
		<tiles:insertAttribute name="footer" />
	</footer>

</div>

</body>
</html>