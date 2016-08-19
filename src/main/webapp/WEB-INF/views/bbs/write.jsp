<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
<script>
$(document).ready(function() {
	//list button
	$('.goList').click(function() {
		$('#writeForm').attr("action", "list");
		$('#writeForm').attr("method", "get");
		$('#writeForm').submit();
	});
	//viwe button
	$('.goView').click(function() {
		$('#writeForm').attr("action", "view");
		$('#writeForm').attr("method", "get");
		$('#writeForm').submit();
	});
});
</script>
<h1><spring:message code="${param.boardCd }" /></h1>
<h2 style="text-transform: capitalize;"><spring:message code="bbs.write" /></h2>
<form id="writeForm"	action="<%=blobstoreService.createUploadUrl("/bbs/write")%>" method="post" enctype="multipart/form-data">
<p style="margin: 0; padding: 0;">
<c:if test="${not empty param.articleNo }">
	<input type="hidden" name="articleNo" value="${param.articleNo }" />
</c:if>
<input type="hidden" name="boardCd" value="${param.boardCd }" />
<input type="hidden" name="curPage" value="${param.curPage }" />
<input type="hidden" name="searchWord" value="${param.searchWord }" />
</p>

<table style="width: 98%">
<tr>
	<td><spring:message code="bbs.title" /></td>
	<td><input type="text" name="title" style="width: 90%;" /></td>
</tr>
<tr>
	<td colspan="2"><textarea name="content" style="width: 98%; height: 200px;"></textarea></td>
</tr>
<tr>
	<td><spring:message code="bbs.file" /></td>
	<td><input type="file" name="attachFile" /></td>
</tr>
</table>

<div style="text-align: center; padding-top: 15px;">
<input type="submit" value="<spring:message code="bbs.submit" />" />
<c:choose>
	<c:when test="${empty param.articleNo }">
		<input type="button" value="<spring:message code="bbs.list" />" class="goList" />
	</c:when>
	<c:otherwise>
		<input type="button" value="<spring:message code="bbs.view" />" class="goView" />
	</c:otherwise>
</c:choose>
</div>
</form>