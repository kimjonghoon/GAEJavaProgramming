<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%
BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
<form action="<%=blobstoreService.createUploadUrl("/bbs/upload") %>" method="post" enctype="multipart/form-data">
<p>
	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
	Attach File <input type="file" name="attachFile" />
	<input type="submit" value="Submit" />
</p>
</form>