<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="Keywords" content="keywords"/>
<meta name="Description" content="description"/>
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" media="screen"/>
</head>
<body>
<div id="wrap">
    <header>
    	<%@ include file="../inc/header.jsp" %>
	</header>
    <nav id="mainNav">
		<%@ include file="../inc/mainNav.jsp" %>
	</nav>
    <div id="login">
		<%@ include file="../inc/login.jsp" %>
	</div>
    <div id="content-wrap">
        <article>
			<%@ include file="JDK-Install-article.jsp" %>
		</article>
    </div>
    <div id="sidebar">
		<%@ include file="java-sub.jsp" %>
	</div>
    <aside>
		<%@ include file="../inc/aside.jsp" %>
	</aside>
    <footer>
		<%@ include file="../inc/footer.jsp" %>
	</footer>
</div>
</body>
</html>