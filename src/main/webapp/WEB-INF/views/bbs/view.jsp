<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	//덧글반복
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
			var chk = confirm("정말로 삭제하시겠습니까?");
			if (chk == true) {
				var $commentNo = $(e.target).attr('title');
				$('#deleteCommentsForm input[name*=commentNo]').val($commentNo);
				$('#deleteCommentsForm').submit();
			}
			return false;
		}
	});
	//form 안의 수정하기 링크
	$('.modify-comment a.comments-modify-submit').click(function(e) {
		$(e.target).parent().parent().submit();
		return false;
	});
	//form 안의 취소 링크
	$('.modify-comment a:contains("취소")').click(function(e) {
		var $form = $(e.target).parent().parent();
		var $p = $(e.target).parent().parent().parent().find('.view-comment');
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
	//수정 버튼
	$('.goModify').click(function() {
		$('#modifyForm').submit();
	});
	//삭제 버튼
	$('.goDelete').click(function() {
		var chk = confirm('정말로 삭제하시겠습니까?');
		if (chk == true) {
			$('#delForm').submit();
		}
	});
	//다음글 버튼
	$('.next-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});
	//이전글 버튼
	$('.prev-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});
	//목록버튼
	$('.goList').click(function() {
		$('#listForm').submit();
	});
	//새글쓰기 버튼
	$('.goWrite').click(function() {
		$('#writeForm').submit();
	});
	//상세보기 안의 목록의 제목링크
	$('#list-table a').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
		return false;
	});
	//페이징 처리
	$('#paging a').click(function() {
		var $curPage = this.title;
		goList($curPage);
		return false;
	});
	//검색 버튼 위의 새글쓰기 버튼
	$('#list-menu input').click(function() {
		$('#writeForm').submit();
	});
});
function goView(articleNo) {
	$('#viewForm input[name*=articleNo]').val(articleNo);
	$('#viewForm').submit();
}
function goList(curPage) {
	$('#listForm input[name*=curPage]').val(curPage);
	$('#listForm').submit();
}
</script>
<h1>${boardNm }</h1>
<div class="view-menu" style="height: 32px;margin-bottom: 5px;">
    <div style="float: left;">
        <input type="button" value="수정" class="goModify" />
        <input type="button" value="삭제" class="goDelete" />
    </div>
    <div style="float: right;">
		<c:if test="${nextArticle != null }">
        <input type="button" value="다음 글" title="${nextArticle.articleNo }" class="next-article" />
		</c:if>
		<c:if test="${prevArticle != null }">
        <input type="button" value="이전 글" title="${prevArticle.articleNo}" class="prev-article" />
		</c:if>
        <input type="button" value="목록" class="goList" />
        <input type="button" value="새 글쓰기" class="goWrite" />
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
	by ${name } hit ${hit }
</div>
<p>${content }</p>
<p id="file-list" style="text-align: right">
<c:forEach var="file" items="${attachFileList }" varStatus="status">
	<a href="#" title="${file.filekey }" class="download">${file.filename }</a>
	<a href="#" title="${file.filekey }">x</a><br />
</c:forEach>
</p>
<form id="addCommentForm" action="addComments" method="post" style="margin-bottom: 5px;">
	<p style="margin: 0;padding: 0">
		<input type="hidden" name="articleNo" value="${param.articleNo }" />
		<input type="hidden" name="boardCd" value="${param.boardCd }" />
		<input type="hidden" name="curPage" value="${param.curPage }" />
		<input type="hidden" name="searchWord" value="${param.searchWord }" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</p>
    <div id="add-comments">
        <textarea name="memo" rows="7" cols="50"></textarea>
    </div>
    <div style="text-align: right;">
        <input type="submit" value="댓글 남기기" />
    </div>
</form>
<!--  댓글 반복 시작 -->
<c:forEach var="comments" items="${commentsList }" varStatus="status">
<div class="comments">
    <span class="comments-writer">${comments.name }</span>
    <span class="comments-date">${comments.regdate }</span>
    <span class="comments-modify-del">
        <a href="#" class="comments-toggle">수정</a>
		| <a href="#" class="comments-delete" title="${comments.commentNo }">삭제</a>
    </span>
    <p class="comments-content">${comments.memo }</p>
    <form class="comments-modify-form" method="post" style="display: none;">
    <p>
        <input type="hidden" name="commentNo" value="${comments.commentNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    <div style="text-align: right;">
		<a href="#" class="comments-modify-submit">수정하기</a>
		 | <a href="#">취소</a>
    </div>
    <div>
        <textarea class="modify-comments-ta" name="memo" rows="7" cols="50">${comments.memo }</textarea>
    </div>
    </form>
</div>
</c:forEach>
<!--  댓글 반복 끝 -->
<div class="next-prev">
    <c:if test="${nextArticle != null }">
    <p>다음 글 : <a href="#" title="${nextArticle.articleNo }">${nextArticle.title }</a></p>
    </c:if>
    <c:if test="${prevArticle != null }">
    <p>이전 글 : <a href="#" title="${prevArticle.articleNo }">${prevArticle.title }</a></p>
    </c:if>
</div>
<div class="view-menu" style="height: 32px;margin-bottom: 5px;">
    <div style="float: left;">
        <input type="button" value="수정" class="goModify" />
        <input type="button" value="삭제" class="goDelete" />
    </div>
    <div style="float: right;">
		<c:if test="${nextArticle != null }">    
        <input type="button" value="다음 글" title="${nextArticle.articleNo }" class="next-article" />
		</c:if>
		<c:if test="${prevArticle != null }">        
        <input type="button" value="이전 글" title="${prevArticle.articleNo}" class="prev-article" />
		</c:if>
        <input type="button" value="목록" class="goList" />
        <input type="button" value="새 글쓰기" class="goWrite" />
    </div>
</div>
<table class="bbs-table">
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
		<img src="/resources/images/arrow-current.gif" alt="현재 글" style="width: 7px;" />
		</c:when>
		<c:otherwise>
		${listItemNo - status.index }
		</c:otherwise>
	</c:choose>
	</td>
	<td>
		<a href="#" title="${article.articleNo }">${article.title }</a>
		<c:if test="${article.attachFileNum > 0 }">
			<strong class="attach">${article.attachFileNum }</strong>
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
		<a href="#" title="${prevPage }">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${firstPage }" end="${lastPage }">
		<c:choose>
			<c:when test="${param.curPage == i }">
				<span class="current-page">${i }</span>
			</c:when>
			<c:otherwise>	
				<a href="#" title="${i }">[${i }]</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${nextPage > 0 }">
		<a href="#" title="${nextPage }">[다음]</a>
	</c:if>
</div>
<div id="list-menu">
	<input type="button" value="새 글쓰기" />
</div>
<div id="search">
	<form action="list" method="get">
	<p style="margin: 0;padding: 0;">
		<input type="hidden" name="boardCd" value="${param.boardCd }" />
		<input type="hidden" name="curPage" value="${param.curPage }" />
		<input type="text" name="searchWord" size="15" maxlength="${param.searchWord }" />
		<input type="submit" value="검색" />
	</p>
	</form>
</div>
<div id="form-group" style="display: none">
    <form id="listForm" action="list" method="get">
    <p>
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="viewForm" action="view" method="get">
    <p>
        <input type="hidden" name="articleNo" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="writeForm" action="write_form" method="get">
    <p>
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="modifyForm" action="modify_form" method="get">
    <p>
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="delForm" action="del" method="post">
    <p>
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="deleteCommentsForm" action="deleteComments" method="post">
    <p>
        <input type="hidden" name="commentNo" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="deleteAttachFileForm" action="deleteAttachFile" method="post">
    <p>
        <input type="hidden" name="filekey" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="downForm" action="../serve" method="get">
    <p><input type="hidden" name="filekey" /></p>
    </form>
</div>