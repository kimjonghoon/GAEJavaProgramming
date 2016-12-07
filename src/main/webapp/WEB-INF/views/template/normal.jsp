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
	</footer>
</div>
</body>
</html>