<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h1>${boardNm }</h1>
<table class="bbs-table">
<tr>
	<th style="width: 60px;">NO</th>
	<th>TITLE</th>
	<th style="width: 84px;">DATE</th>
	<th style="width: 60px;">READ</th>
</tr>

<c:forEach var="article" items="${list }" varStatus="status">
	<tr>
		<td style="text-align: center;">${listItemNo - status.index }</td>
		<td>
			<a href="view?articleNo=${article.articleNo }&boardCd=${param.boardCd }&curPage=${param.curPage }&searchWord=${param.searchWord }">${article.title }</a>
			<c:if test="${article.attachFileNum > 0 }">
				<strong class="attach">[${article.attachFileNum }]</strong>
			</c:if> 
			<c:if test="${article.commentNum > 0 }">
				<strong class="reply">[${article.commentNum }]</strong>
			</c:if>
		</td>
		<td style="text-align: center;"><fmt:formatDate value="${article.regdate }" pattern="yyyy.MM.dd" /></td>
		<td style="text-align: center;">${article.hit }</td>
	</tr>
</c:forEach>
</table>

<c:if test="${prevPage > 0 }">
	<a href="list?boardCd=${param.boardCd }&curPage=${prevPage }&searchWord=${param.searchWord }">[ ${prevPage } ]</a>
</c:if>

<div id="paging">
	<c:forEach var="i" begin="${firstPage }" end="${lastPage }">
		<c:choose>
			<c:when test="${param.curPage == i }">
				<strong class="current-page">${i }</strong>
			</c:when>
			<c:otherwise>
				<a href="list?boardCd=${param.boardCd }&curPage=${i }&searchWord=${param.searchWord }">[${i }]</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</div>

<c:if test="${nextPage > 0 }">
	<a href="list?boardCd=${param.boardCd }&curPage=${nextPage }&searchWord=${param.searchWord }">[ ${nextPage } ]</a>
</c:if>

<div id="list-menu">
	<input type="button" value="새 글쓰기" onclick="location.href='write?boardCd=${param.boardCd}&curPage=${param.curPage }&searchWord=${param.searchWord }'" />
</div>

<div id="search">
	<form method="get">
	<div>
		<input type="hidden" name="boardCd" value="${param.boardCd }" /> 
		<input type="hidden" name="curPage" value="1" /> 
		<input type="text" name="searchWord" size="15" maxlength="30" /> 
		<input type="submit" value="<spring:message code="search" />" />
	</div>
	</form>
</div>