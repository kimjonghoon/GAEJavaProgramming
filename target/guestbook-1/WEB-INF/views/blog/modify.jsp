<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="modify" method="post">
  <input type="hidden" name="id" value="${article.id }"/>
  <input type="hidden" name="category" value="${article.category }"/>
  <input type="hidden" name="webSafeString" value="${article.keyString }"/>
  <div>order:<input type="text" name="order" value="${article.order }"/></div>
  <div>title:<input type="text" name="title" value="${article.title }"/></div>
  <div>keywords:<input type="text" name="keywords" value="${article.keywords }"/></div>
  <div>description:<input type="text" name="description" value="${article.description }"/></div>
  <div><textarea name="content" style="width: 99%;height: 300px;">${article.content }</textarea></div>
  <div><input type="submit" value="Modify Article"/></div>
</form>