<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1><spring:message code="blog.new" /></h1>

<form action="new" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div>
        <spring:message code="blog.category" /><br />
        <label><input type="radio" name="category" value="java" checked="checked" />Java</label>
        <label><input type="radio" name="category" value="jdbc" />JDBC</label>
        <label><input type="radio" name="category" value="jsp" />JSP</label>
        <label><input type="radio" name="category" value="css-layout" />CSS Layout</label>
        <label><input type="radio" name="category" value="jsp-pjt" />JSP Project</label>
        <label><input type="radio" name="category" value="spring" />Spring</label>
        <label><input type="radio" name="category" value="javascript" />JavaScript</label>
        <label><input type="radio" name="category" value="google-app-engine" />Google Cloud</label>
    </div>
    <div>
        id (<spring:message code="blog.id.desc" />)<br />
        <input type="text" name="id" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.title" /> (<spring:message code="blog.title.desc" />)<br />
        <input type="text" name="title" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.keywords" /> (<spring:message code="blog.keywords.desc" />)<br />
        <input type="text" name="keywords" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.description" /> (<spring:message code="blog.description.desc" />)<br />
        <input type="text" name="description" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.content" />
        <textarea name="content" style="width: 99%; height: 200px;"></textarea>
    </div>
    <div>
        <input type="submit" value="<spring:message code="blog.post" />" />
    </div>
</form>