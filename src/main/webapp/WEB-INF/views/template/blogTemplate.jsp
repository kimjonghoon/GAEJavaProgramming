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
<style type="text/css">
#sidebar {
	display: none;
}
#content {
	margin-left: 0.5em;
}
</style>
<script src="/resources/js/prettify.js"></script>
<script src="/resources/js/jquery-3.2.1.min.js"></script>
<script src="/resources/js/commons.js"></script>
<script>
$(document).ready(function() {
	var url = $('#content').attr('title');
	$('#content').load('/resources/articles/' + url + '.html', function() {
		runAfterLoadArticle();
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
		<div id="content" title="<tiles:insertAttribute name="content" />"></div>
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