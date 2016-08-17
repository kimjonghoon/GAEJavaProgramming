<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
<script>
$(document).ready(function() {
	//상세보기 버튼
	$('.goView').click(function() {
		$('#writeForm').attr("action", "view");
		$('#writeForm').attr("method", "get");
		$('#writeForm').submit();
	});
});
</script>
<h1>${boardNm }</h1>
<h2>수정</h2>
<form id="writeForm"	action="<%=blobstoreService.createUploadUrl("/bbs/modify")%>" method="post" enctype="multipart/form-data">
<p style="margin: 0; padding: 0;">
<input type="hidden" name="articleNo" value="${param.articleNo }" />
<input type="hidden" name="boardCd" value="${param.boardCd }" />
<input type="hidden" name="curPage" value="${param.curPage }" />
<input type="hidden" name="searchWord" value="${param.searchWord }" />
</p>

<table style="width: 98%">
<tr>
	<td>제목</td>
	<td><input type="text" name="title" style="width: 90%;" value="${article.title }"/></td>
</tr>
<tr>
	<td colspan="2"><textarea name="content" style="width: 98%; height: 200px;">${article.content }</textarea></td>
</tr>
<tr>
	<td>첨부 파일</td>
	<td><input type="file" name="attachFile" /></td>
</tr>
</table>

<div style="text-align: center; padding-top: 15px;">
	<input type="submit" value="전송" />
	<input type="button" value="상세보기" class="goView" />
</div>
</form>