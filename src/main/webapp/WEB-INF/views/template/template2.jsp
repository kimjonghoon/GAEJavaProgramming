<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<tiles:insertAttribute name="title-keywords-description" />
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" media="screen"/>
</head>
<body>
<div id="wrap">
    <header>
        <tiles:insertAttribute name="header"/>
    </header>
    <nav id="mainNav">
        <tiles:insertAttribute name="mainNav"/>
    </nav>
    <div id="login">
        <tiles:insertAttribute name="login"/>
    </div>
    <div id="content-wrap">
        <article>
            <tiles:insertAttribute name="article"/>
        </article>
    </div>
    <div id="sidebar">
        <tiles:insertAttribute name="sidebar"/>
    </div>
    <aside>
        <tiles:insertAttribute name="aside"/>
    </aside>
    <footer>
        <tiles:insertAttribute name="footer"/>
    </footer>
</div>
</body>
</html>