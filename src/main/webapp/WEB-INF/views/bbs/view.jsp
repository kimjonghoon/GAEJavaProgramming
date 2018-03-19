<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    String uploadUrl = blobstoreService.createUploadUrl("/bbs/upload");
    pageContext.setAttribute("uploadUrl", uploadUrl);
%>
<script>
    $(document).ready(function () {

        prettyPrint();
        $('pre.prettyprint').html(function () {
            return this.innerHTML.replace(/\t/g, '&nbsp;&nbsp;&nbsp;&nbsp;');
        });
        $('pre.prettyprint').dblclick(function () {
            selectRange(this);
        });
        $('pre.script-result-display').each(function () {
            var $result = "";
            function println(str) {
                $result += str + "\n";
            }
            var $convert = $(this).text().replace(/alert/g, "println");
            eval($convert);
            $(this).after('<pre class="result">' + $result + '</pre>');
        });

        $('#file-list a.download').click(function (e) {
            e.preventDefault();
            var $filekey = this.title;
            $('#downForm input[name*=filekey]').val($filekey);
            $('#downForm').submit();
        });
        $('#file-list a:not(.download)').click(function (e) {
            e.preventDefault();
            var chk = confirm('<spring:message code="delete.confirm" />');
            if (chk === true) {
                var $filekey = this.title;
                $('#deleteAttachFileForm input[name*=filekey]').val($filekey);
                $('#deleteAttachFileForm').submit();
            }
        });
        //comments
        $('.comments').click(function (e) {
            e.preventDefault();
            if ($(e.target).is('.comments-toggle')) {
                var $form = $(e.target).parent().parent().find('.comments-modify-form');
                var $p = $(e.target).parent().parent().find('.comments-content');
                if ($form.is(':hidden') === true) {
                    $form.show();
                    $p.hide();
                } else {
                    $form.hide();
                    $p.show();
                }
            } else if ($(e.target).is('.comments-delete')) {
                var chk = confirm("<spring:message code="delete.confirm" />");
                if (chk === true) {
                    var $commentNo = $(e.target).attr('title');
                    $('#deleteCommentsForm input[name*=commentNo]').val($commentNo);
                    $('#deleteCommentsForm').submit();
                }
            }
        });
        //modify comments link in form
        $('.comments-modify-form a.comments-modify-submit').click(function (e) {
            e.preventDefault();
            $(e.target).parent().parent().submit();
        });
        //cancel link in form
        $('.comments-modify-form a:contains("<spring:message code="cancel" />")').click(function (e) {
            e.preventDefault();
            var $form = $(e.target).parent().parent();
            var $p = $(e.target).parent().parent().parent().find('.comments-content');
            if ($form.is(':hidden') === true) {
                $form.show();
                $p.hide();
            } else {
                $form.hide();
                $p.show();
            }
        });
        $('.next-prev a').click(function (e) {
            e.preventDeafult();
            var articleNo = this.title;
            $('#viewForm input[name*=articleNo]').val(articleNo);
            $('#viewForm').submit();
        });
        //modify button
        $('.goModify').click(function () {
            $('#modifyForm').submit();
        });
        //del button
        $('.goDelete').click(function () {
            var chk = confirm('<spring:message code="delete.confirm" />');
            if (chk === true) {
                $('#delForm').submit();
            }
        });
        //Next Post button
        $('.next-article').click(function () {
            var articleNo = this.title;
            $('#viewForm input[name*=articleNo]').val(articleNo);
            $('#viewForm').submit();
        });
        //Prev Post button
        $('.prev-article').click(function () {
            var articleNo = this.title;
            $('#viewForm input[name*=articleNo]').val(articleNo);
            $('#viewForm').submit();
        });
        //list button
        $('.goList').click(function () {
            $('#listForm').submit();
        });
        //write button
        $('.goWrite').click(function () {
            $('#writeForm').submit();
        });
        //list title link in view
        $('#list-table a').click(function (e) {
            e.preventDefault();
            var articleNo = this.title;
            $('#viewForm input[name*=articleNo]').val(articleNo);
            $('#viewForm').submit();
        });
        //paging
        $('#paging a').click(function (e) {
            e.preventDefault();
            var page = this.title;
            $('#listForm input[name*=page]').val(page);
            $('#listForm').submit();
        });
        //write button 
        $('#list-menu input').click(function () {
            $('#writeForm').submit();
        });
        //searchForm submit
        $('#searchForm').submit(function () {
            var searchWord = $('#searchForm input[name*=searchWord]').val();
            searchWord = $.trim(searchWord);
            $('#searchForm input[name*=searchWord]').val(searchWord);
        });
        //#board-content > iframe resize
        var originWidth = $('#board-content > iframe').width();
        var originHeight = $('#board-content > iframe').height();

        var width = $('#board-content').width();
        var height = originHeight * width / originWidth;

        $('#board-content > iframe').attr('width', width);
        $('#board-content > iframe').attr('height', height);

        $('#board-content > iframe').attr('allowFullScreen', '');
    });
</script>

<div id="url-navi">${boardName }</div>

<div class="view-menu" style="margin-top: 15px;margin-bottom: 5px;">
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
        <th style="width: 47px;text-align: left;vertical-align: top;font-size: 1em;">TITLE</th>
        <th style="text-align: left;color: #555;font-size: 1em;">${title }</th>
    </tr>
</table>
<div id="date-writer-read">
    <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${regdate }" />
    by ${nickname } hit ${hit }
</div>
<div id="board-content" style="font-size: 0.9em;text-align: justify;">${content }</div>
<div id="file-list" style="text-align: right;">
    <c:forEach var="file" items="${attachFileList }" varStatus="status">
        <div class="attach-file">
            <a href="#" title="${file.filekey }" class="download">${file.filename }</a>
            <security:authorize access="isAuthenticated() and (#owner == principal.email or hasRole('ROLE_ADMIN'))">
                <a href="#" title="${file.filekey }">x</a>
            </security:authorize>
        </div>
    </c:forEach>
</div>
<security:authorize access="isAuthenticated() and (#owner == principal.email or hasRole('ROLE_ADMIN'))">
<form id="uploadForm" action="${uploadUrl}?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
    <input type="hidden" name="articleNo" value="${param.articleNo }" />
    <input type="hidden" name="boardCd" value="${param.boardCd }" />
    <input type="hidden" name="page" value="${param.page }" />
    <input type="hidden" name="searchWord" value="${param.searchWord }" />
    <div>
        <input type="file" name="attachFile" />
        <input type="submit" value="<spring:message code="bbs.submit" />" />
    </div>
</form>
</security:authorize>    
<form id="addCommentForm" action="addComments" method="post" style="margin-bottom: 5px;">
    <input type="hidden" name="articleNo" value="${param.articleNo }" />
    <input type="hidden" name="boardCd" value="${param.boardCd }" />
    <input type="hidden" name="page" value="${param.page }" />
    <input type="hidden" name="searchWord" value="${param.searchWord }" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
<div class="view-menu" style="margin-bottom: 47px;">
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
                        <img src="/resources/images/arrow-current.gif" alt="Current Post" />
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
        <a href="#" title="1">[ <spring:message code="first" /> ]</a>
        <a href="#" title="${prevPage }">[ <spring:message code="prev" /> ]</a>
    </c:if>
    <c:forEach var="i" begin="${firstPage }" end="${lastPage }">
        <c:choose>
            <c:when test="${param.page == i }">
                <span class="current-page"> ${i } </span>
            </c:when>
            <c:otherwise>	
                <a href="#" title="${i }">[ ${i } ]</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${nextPage > 0 }">
        <a href="#" title="${nextPage }">[ <spring:message code="next" /> ]</a>
        <a href="#" title="${totalPage }">[ <spring:message code="last" /> ]</a>
    </c:if>
</div>
<div id="list-menu">
    <input type="button" value="<spring:message code="bbs.write" />" />
</div>
<form id="searchForm" action="list" method="get">
    <input type="hidden" name="boardCd" value="${param.boardCd }" />
    <input type="hidden" name="page" value="${param.page }" />
    <div id="search">
        <input type="text" name="searchWord" size="15" maxlength="${param.searchWord }" />
        <input type="submit" value="<spring:message code="search" />" />
    </div>
</form>

<div id="form-group" style="display: none">
    <form id="listForm" action="list" method="get">
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <form id="viewForm" action="view" method="get">
        <input type="hidden" name="articleNo" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <form id="writeForm" action="write" method="get">
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <form id="modifyForm" action="modify" method="get">
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <form id="delForm" action="deleteArticle" method="post">
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <form id="deleteCommentsForm" action="deleteComments" method="post">
        <input type="hidden" name="commentNo" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <form id="deleteAttachFileForm" action="deleteAttachFile" method="post">
        <input type="hidden" name="filekey" />
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <form id="downForm" action="../serve" method="get">
        <input type="hidden" name="filekey" />
    </form>
</div>
