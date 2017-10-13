<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
<script>
$(document).ready(function() {
	//view button
	$('.goView').click(function() {
		$('#writeForm').attr("action", "view");
		$('#writeForm').attr("method", "get");
		$('#writeForm').submit();
	});
});
</script>

<article>
<h1 class="bbs-heading">${boardName }</h1>
<p style="text-transform: capitalize;"><spring:message code="bbs.modify" /></p>
<form id="writeForm" action="<%=blobstoreService.createUploadUrl("/bbs/modify")%>?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
<p style="margin: 0; padding: 0;">
<input type="hidden" name="articleNo" value="${param.articleNo }" />
<input type="hidden" name="boardCd" value="${param.boardCd }" />
<input type="hidden" name="page" value="${param.page }" />
<input type="hidden" name="searchWord" value="${param.searchWord }" />
</p>

<table style="width: 98%">
<tr>
	<td><spring:message code="bbs.title" /></td>
	<td><input type="text" name="title" style="width: 90%;" value="${article.title }"/></td>
</tr>
<tr>
	<td colspan="2"><textarea name="content" style="width: 98%; height: 200px;">${article.content }</textarea></td>
</tr>
<tr>
	<td><spring:message code="bbs.file" /></td>
	<td><input type="file" name="attachFile" /></td>
</tr>
</table>

<div style="text-align: center; padding-top: 15px;">
	<input type="submit" value="<spring:message code="bbs.submit" />" />
	<input type="button" value="<spring:message code="bbs.view" />" class="goView" />
</div>
</form>
</article>