<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobInfo" %>
<%@ page import="com.google.appengine.api.blobstore.BlobInfoFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobKey" %>
<%
String filekey = request.getParameter("blob-key");
BlobInfo blobInfo = null;
BlobstoreService blobstoreService = null;
if (filekey != null) {
	blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
	
	BlobKey blobKey = new BlobKey(filekey);
	blobInfo = blobInfoFactory.loadBlobInfo(blobKey);
}
%>
<script src="/resources/js/jquery-1.11.3.min.js"></script>
<script>
$(document).ready(function() {
	  $('#file-list a.download').click(function() {
	    var $filekey = this.title;
	    $('#downForm input[name*=filekey]').val($filekey);
	    $('#downForm').submit();
	    return false;
	  });
	    
	  $('#file-list a:not(.download)').click(function() {
	    var chk = confirm("정말로 삭제하시겠습니까?");
	    
	    if (chk == true) {
	      var $filekey = this.title;
	      $('#deleteAttachFileForm input[name*=filekey]').val($filekey);
	      $('#deleteAttachFileForm').submit();
	    }
	    
	    return false;
	  });
});
</script>

<article>
<h1>Blob Test</h1>
<div id="file-list">
<%
if (blobInfo != null) {
%>
<a href="#" title="<%=blobInfo.getBlobKey().getKeyString() %>" class="download"><%=blobInfo.getFilename() %></a>
<a href="#" title="<%=blobInfo.getBlobKey().getKeyString() %>">x</a>
<%
}
%>
</div>
<div style="display: none;">
<form id="deleteAttachFileForm" action="/bbs/deleteFile" method="post">
<p>
	<input type="hidden" name="filekey" />
</p>
</form>
<form id="downForm" action="../serve" method="get">
<p>
	<input type="hidden" name="filekey" />
</p>
</form>
</div>
</article>