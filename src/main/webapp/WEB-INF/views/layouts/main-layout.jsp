<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:importAttribute name="styles"/>
<tiles:importAttribute name="javascripts"/>

<!DOCTYPE html> 
<html>
    <head lang="<tiles:insertAttribute name="lang" defaultValue="en" defaultValueType="string" />">
        <meta charset="UTF-8" />
        <title><tiles:insertAttribute name="title" /></title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="Keywords" content="<tiles:insertAttribute name="keywords" />" />
        <meta name="Description" content="<tiles:insertAttribute name="description" />" />
        <link rel="stylesheet" href="/resources/css/screen.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/resources/css/print.css" type="text/css" media="print" />
        <c:forEach var="style" items="${styles}">
            <link rel="stylesheet" href="<c:url value="${style}"/>" type="text/css" />
        </c:forEach>
        <script async="async" src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        <script>
        (adsbygoogle = window.adsbygoogle || []).push({
                google_ad_client: "ca-pub-1447532017929181",
                enable_page_level_ads: true
        });
        </script>
        <c:forEach var="script" items="${javascripts}">
            <script src="<c:url value="${script}"/>"></script>
        </c:forEach>
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
                <div id="content">
                    <tiles:insertAttribute name="content" />
                </div>
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