<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<script>
$(document).ready(function() {
	$('#file-list a.download').click(function() {
		var $filekey = this.title;
		$('#downForm input[name*=filekey]').val($filekey);
		$('#downForm').submit();
		return false;
	});
	$('#file-list a:not(.download)').click(function() {
		var chk = confirm('<spring:message code="delete.confirm" />');
		if (chk == true) {
			var $filekey = this.title;
			$('#deleteAttachFileForm input[name*=filekey]').val($filekey);
			$('#deleteAttachFileForm').submit();
		}
		return false;
	});
	//comments
	$('.comments').click(function(e) {
		if ($(e.target).is('.comments-toggle')) {
			var $form = $(e.target).parent().parent().find('.comments-modify-form');
			var $p = $(e.target).parent().parent().find('.comments-content');
			if ($form.is(':hidden') == true) {
				$form.show();
				$p.hide();
			} else {
				$form.hide();
				$p.show();
			}
			return false;
		} else if ($(e.target).is('.comments-delete')) {
			var chk = confirm("<spring:message code="delete.confirm" />");
			if (chk == true) {
				var $commentNo = $(e.target).attr('title');
				$('#deleteCommentsForm input[name*=commentNo]').val($commentNo);
				$('#deleteCommentsForm').submit();
			}
			return false;
		}
	});
	//modify comments link in form
	$('.comments-modify-form a.comments-modify-submit').click(function(e) {
		$(e.target).parent().parent().submit();
		return false;
	});
	//cancel link in form
	$('.comments-modify-form a:contains("<spring:message code="cancel" />")').click(function(e) {
		var $form = $(e.target).parent().parent();
		var $p = $(e.target).parent().parent().parent().find('.comments-content');
		if ($form.is(':hidden') == true) {
			$form.show();
			$p.hide();
		} else {
			$form.hide();
			$p.show();
		}
		return false;
	});
	$('.next-prev a').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
		return false;
	});
	//modify button
	$('.goModify').click(function() {
		$('#modifyForm').submit();
	});
	//del button
	$('.goDelete').click(function() {
		var chk = confirm('<spring:message code="delete.confirm" />');
		if (chk == true) {
			$('#delForm').submit();
		}
	});
	//Next Post button
	$('.next-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});
	//Prev Post button
	$('.prev-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});
	//list button
	$('.goList').click(function() {
		$('#listForm').submit();
	});
	//write button
	$('.goWrite').click(function() {
		$('#writeForm').submit();
	});
	//list title link in view
	$('#list-table a').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
		return false;
	});
	//paging
	$('#paging a').click(function() {
		var $page = this.title;
		goList($page);
		return false;
	});
	//write button 
	$('#list-menu input').click(function() {
		$('#writeForm').submit();
	});
});
function goView(articleNo) {
	$('#viewForm input[name*=articleNo]').val(articleNo);
	$('#viewForm').submit();
}
function goList(page) {
	$('#listForm input[name*=page]').val(page);
	$('#listForm').submit();
}
</script>

<article>
<h1>${boardName }</h1>

<div class="view-menu" style="height: 32px;margin-bottom: 5px;">
	<security:authorize access="isAuthenticated() and (#owner == principal.email or hasRole('ROLE_ADMIN'))">
    <div style="float: left;">
        <input type="button" value="<spring:message code="bbs.modify" />" class="goModify" />
        <input type="button" value="<spring:message code="bbs.delete" />" class="goDelete" />
    </div>
    </security:authorize>
    <div style="float: right;">
		<c:if test="${nextArticle != null }">
        <input type="button" value="<spring:message code="bbs.next" />" title="${nextArticle.articleNo }" class="next-article" />
		</c:if>
		<c:if test="${prevArticle != null }">
        <input type="button" value="<spring:message code="bbs.prev" />" title="${prevArticle.articleNo}" class="prev-article" />
		</c:if>
        <input type="button" value="<spring:message code="bbs.list" />" class="goList" />
        <input type="button" value="<spring:message code="bbs.write" />" class="goWrite" />
    </div>
</div>
<table class="bbs-table">
<tr>
    <th style="width: 37px;text-align: left;">TITLE</th>
    <th style="text-align: left;color: #555;">${title }</th>
</tr>
</table>
<div id="date-writer-read">
	<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${regdate }" />
	by ${nickname } hit ${hit }
</div>
<p>${content }</p>
<p id="file-list" style="text-align: right">
<c:forEach var="file" items="${attachFileList }" varStatus="status">
	<a href="#" title="${file.filekey }" class="download">${file.filename }</a>
	<security:authorize access="isAuthenticated() and (#owner == principal.email or hasRole('ROLE_ADMIN'))">
	<a href="#" title="${file.filekey }">x</a><br />
	</security:authorize>
</c:forEach>
</p>
<form id="addCommentForm" action="addComments" method="post" style="margin-bottom: 5px;">
	<p style="margin: 0;padding: 0">
		<input type="hidden" name="articleNo" value="${param.articleNo }" />
		<input type="hidden" name="boardCd" value="${param.boardCd }" />
		<input type="hidden" name="page" value="${param.page }" />
		<input type="hidden" name="searchWord" value="${param.searchWord }" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</p>
    <div id="add-comments">
        <textarea name="memo" rows="7" cols="50"></textarea>
    </div>
    <div style="text-align: right;">
        <input type="submit" value="<spring:message code="bbs.add.comments" />" />
    </div>
</form>
<!--  comments start -->
<c:forEach var="comments" items="${commentsList }" varStatus="status">
<div class="comments">
    <span class="comments-writer">${comments.nickname }</span>
    <span class="comments-date">${comments.regdate }</span>
    <security:authorize access="isAuthenticated() and (#comments.owner == principal.email or hasRole('ROLE_ADMIN'))">
    <span class="comments-modify-del">
        <a href="#" class="comments-toggle"><spring:message code="bbs.modify" /></a>
		| <a href="#" class="comments-delete" title="${comments.commentNo }"><spring:message code="bbs.delete" /></a>
    </span>
    </security:authorize>
    <p class="comments-content">${comments.memo }</p>
    <form class="comments-modify-form" action="modifyComments" method="post" style="display: none;">
    <p>
        <input type="hidden" name="commentNo" value="${comments.commentNo }" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    <div style="text-align: right;">
		<a href="#" class="comments-modify-submit"><spring:message code="bbs.modify.comments" /></a>
		 | <a href="#"><spring:message code="cancel" /></a>
    </div>
    <div>
        <textarea class="modify-comments-ta" name="memo" rows="7" cols="50">${comments.memo }</textarea>
    </div>
    </form>
</div>
</c:forEach>
<!--  comments end -->
<div class="next-prev">
    <c:if test="${nextArticle != null }">
    <p><spring:message code="bbs.next" /> : <a href="#" title="${nextArticle.articleNo }">${nextArticle.title }</a></p>
    </c:if>
    <c:if test="${prevArticle != null }">
    <p><spring:message code="bbs.prev" /> : <a href="#" title="${prevArticle.articleNo }">${prevArticle.title }</a></p>
    </c:if>
</div>
<div class="view-menu" style="height: 32px;margin-bottom: 5px;">
	<security:authorize access="isAuthenticated() and (#owner == principal.email or hasRole('ROLE_ADMIN'))">
    <div style="float: left;">
        <input type="button" value="<spring:message code="bbs.modify" />" class="goModify" />
        <input type="button" value="<spring:message code="bbs.delete" />" class="goDelete" />
    </div>
    </security:authorize>
    <div style="float: right;">
		<c:if test="${nextArticle != null }">    
        <input type="button" value="<spring:message code="bbs.next" />" title="${nextArticle.articleNo }" class="next-article" />
		</c:if>
		<c:if test="${prevArticle != null }">        
        <input type="button" value="<spring:message code="bbs.prev" />" title="${prevArticle.articleNo}" class="prev-article" />
		</c:if>
        <input type="button" value="<spring:message code="bbs.list" />" class="goList" />
        <input type="button" value="<spring:message code="bbs.write" />" class="goWrite" />
    </div>
</div>
<table id="list-table" class="bbs-table">
<tr>
	<th style="width: 60px;">NO</th>
	<th>TITLE</th>
	<th style="width: 84px;">DATE</th>
	<th style="width: 60px;">HIT</th>
</tr>
<c:forEach var="article" items="${list }" varStatus="status">
<tr>
	<td style="text-align: center;">
	<c:choose>
		<c:when test="${param.articleNo == article.articleNo }">	
		<img src="/resources/images/arrow-current.gif" alt="Current Post" style="width: 7px;" />
		</c:when>
		<c:otherwise>
		${listItemNo - status.index }
		</c:otherwise>
	</c:choose>
	</td>
	<td>
		<a href="#" title="${article.articleNo }">${article.title }</a>
		<c:if test="${article.attachFileNum > 0 }">
			<img alt="attach file" src="/resources/images/attach.png"/>
		</c:if>
		<c:if test="${article.commentNum > 0 }">
		<span class="reply">[${article.commentNum }]</span>
		</c:if>
	</td>
	<td style="text-align: center;"><fmt:formatDate pattern="yyyy.MM.dd" value="${article.regdate }" /></td>
	<td style="text-align: center;">${article.hit }</td>
</tr>
</c:forEach>
</table>
<div id="paging">
	<c:if test="${prevPage > 0 }">
		<a href="#" title="${prevPage }">[<spring:message code="prev" />]</a>
	</c:if>
	<c:forEach var="i" begin="${firstPage }" end="${lastPage }">
		<c:choose>
			<c:when test="${param.page == i }">
				<span class="current-page">${i }</span>
			</c:when>
			<c:otherwise>	
				<a href="#" title="${i }">[${i }]</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${nextPage > 0 }">
		<a href="#" title="${nextPage }">[<spring:message code="bbs.next" />]</a>
	</c:if>
</div>
<div id="list-menu">
	<input type="button" value="<spring:message code="bbs.write" />" />
</div>
<div id="search">
	<form action="list" method="get">
	<p style="margin: 0;padding: 0;">
		<input type="hidden" name="boardCd" value="${param.boardCd }" />
		<input type="hidden" name="page" value="${param.page }" />
		<input type="text" name="searchWord" size="15" maxlength="${param.searchWord }" />
		<input type="submit" value="<spring:message code="search" />" />
	</p>
	</form>
</div>
<div id="form-group" style="display: none">
    <form id="listForm" action="list" method="get">
    <p>
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="viewForm" action="view" method="get">
    <p>
        <input type="hidden" name="articleNo" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="writeForm" action="write" method="get">
    <p>
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="modifyForm" action="modify" method="get">
    <p>
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="delForm" action="deleteArticle" method="post">
    <p>
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    </form>
    <form id="deleteCommentsForm" action="deleteComments" method="post">
    <p>
        <input type="hidden" name="commentNo" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    </form>
    <form id="deleteAttachFileForm" action="deleteAttachFile" method="post">
    <p>
        <input type="hidden" name="filekey" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    </form>
    <form id="downForm" action="../serve" method="get">
    <p><input type="hidden" name="filekey" /></p>
    </form>
</div>
</article>