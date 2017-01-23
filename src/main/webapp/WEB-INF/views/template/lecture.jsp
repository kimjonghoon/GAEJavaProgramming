<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html> 
<html>
<head>
<script async="async" src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
(adsbygoogle = window.adsbygoogle || []).push({
	google_ad_client: "ca-pub-1447532017929181",
	enable_page_level_ads: true
});
</script>
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
<script>
$(document).ready(function() {
	prettyPrint();
	$('pre.prettyprint').html(function() {
		return this.innerHTML.replace(/\t/g,'&nbsp;&nbsp;&nbsp;&nbsp;');
	});
	$('pre.prettyprint').dblclick(function() {
		selectRange(this);
	});
});
</script>
</head>
<body>
<div id="wrap">
	<header>
		<tiles:insertAttribute name="header" />
	</header>
	<nav id="mainNav">
		<tiles:insertAttribute name="mainNav" />
	</nav>
	<div id="login">
		<tiles:insertAttribute name="login"/>
	</div>
	<div id="content-wrap">
		<article>
			<tiles:insertAttribute name="article" />
			<div id="prev-next">
			<ul>
				<li><spring:message code="next" /> : <a href="<tiles:insertAttribute name="next-link" />"><tiles:insertAttribute name="next-title" /></a></li>
				<li><spring:message code="prev" /> : <a href="<tiles:insertAttribute name="prev-link" />"><tiles:insertAttribute name="prev-title" /></a></li>
			</ul>
			</div>
		</article>
	</div>
	<div id="sidebar">
		<tiles:insertAttribute name="sidebar" />
	</div>
	<aside>
		<tiles:insertAttribute name="aside" />
	</aside>
	<footer>
		<tiles:insertAttribute name="footer" />
		<div id="footer-ad">
			<tiles:insertAttribute name="footer-ad" />
		</div>
	</footer>
</div>
</body>
</html>