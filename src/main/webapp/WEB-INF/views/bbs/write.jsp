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
    window.onload = initPage;
    
    function initPage() {
        var writeForm = document.getElementById('writeForm');
        writeForm.onsubmit = function() {
            var title = writeForm.title.value;
            var content = writeForm.content.value;
            title = title.trim();
            content = content.trim();
            if (title.length === 0) {
                alert('<spring:message code="title.empty" />');
                writeForm.title.value = '';
                return false;
            }
            if (content.length === 0) {
                alert('<spring:message code="content.empty" />');
                writeForm.content.value = '';
                return false;
            }
            writeForm.title.value = title;
            writeForm.content.value = content;
            return true;
        };
        var listBtn = document.getElementById('goList');
        listBtn.onclick = function() {
            writeForm.action = "list";
            writeForm.method = "get";
            writeForm.submit();
        };
        var viewBtn = document.getElementById('goView');
        viewBtn.onclick = function() {
            writeForm.action = "view";
            writeForm.method = "get";
            writeForm.submit();
        };
    }
</script>
<div id="url-navi">${boardName }</div>
<p style="text-transform: capitalize;"><spring:message code="bbs.write" /></p>
<form id="writeForm" action="<%=blobstoreService.createUploadUrl("/bbs/write")%>?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
    <c:if test="${not empty param.articleNo }">
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
    </c:if>
    <input type="hidden" name="boardCd" value="${param.boardCd }" />
    <input type="hidden" name="page" value="${param.page }" />
    <input type="hidden" name="searchWord" value="${param.searchWord }" />
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
        <input type="button" value="<spring:message code="bbs.list" />" id="goList" />
        <c:if test="${not empty param.articleNo }">
            <input type="button" value="<spring:message code="bbs.view" />" id="goView" />
        </c:if>
    </div>
</form>