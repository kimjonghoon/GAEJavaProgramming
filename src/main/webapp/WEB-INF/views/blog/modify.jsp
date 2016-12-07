<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<form action="modify" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <input type="hidden" name="webSafeString" value="${article.keyString }"/>
  <div><spring:message code="blog.title" />:<input type="text" name="title" value="${article.title }"/></div>
  <div><spring:message code="blog.keywords" />:<input type="text" name="keywords" value="${article.keywords }"/></div>
  <div><spring:message code="blog.description" />:<input type="text" name="description" value="${article.description }"/></div>
  <div><textarea name="content" style="width: 99%;height: 300px;">${article.content }</textarea></div>
  <div><input type="submit" value="<spring:message code="blog.modify" />" /></div>
</form>