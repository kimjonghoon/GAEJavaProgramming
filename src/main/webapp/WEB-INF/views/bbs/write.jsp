<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script>
    $(document).ready(function () {
        $('#writeForm').submit(function () {
            var title = $('#writeForm input[name*=title]').val();
            var content = $('#writeForm-ta').val();
            title = $.trim(title);
            content = $.trim(content);
            if (title.length === 0) {
                alert('<spring:message code="title.empty" />');
                $('#writeForm input[name*=title]').val('');
                return false;
            }
            if (content.length === 0) {
                alert('<spring:message code="content.empty" />');
                $('#writeForm-ta').val('');
                return false;
            }
            $('#writeForm input[name*=title]').val(title);
            $('#writeForm-ta').val(content);
        });
        $('#goList').click(function () {
            $('#listForm').submit();
        });
        $('#goView').click(function () {
            $('#viewForm').submit();
        });
    });
</script>
<div id="content-categories">${boardName }</div>
<h3 style="text-transform: capitalize;"><spring:message code="bbs.write" /></h3>
<form:form id="writeForm" action="/bbs/write" modelAttribute="article" method="post">
    <c:if test="${not empty param.articleNo }">
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
    </c:if>
    <input type="hidden" name="boardCd" value="${param.boardCd }" />
    <input type="hidden" name="page" value="${param.page }" />
    <input type="hidden" name="searchWord" value="${param.searchWord }" />
    <form:errors path="*" cssClass="error" />
    <table style="width: 98%">
        <tr>
            <td><spring:message code="bbs.title" /></td>
            <td>
                <form:input path="title" style="width: 90%;" /><br />
                <form:errors path="title" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea name="content" style="width: 98%; height: 200px;" id="writeForm-ta"></textarea><br />
                <form:errors path="content" cssClass="error" />
            </td>
        </tr>
    </table>
    <div style="text-align: center; padding-top: 15px;">
        <input type="submit" value="<spring:message code="bbs.submit" />" />
        <input type="button" value="<spring:message code="bbs.list" />" id="goList" />
        <c:if test="${not empty param.articleNo }">
            <input type="button" value="<spring:message code="bbs.view" />" id="goView" />
        </c:if>
    </div>
</form:form>
<div style="display: none;">
    <form id="listForm" action="list" method="get">
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <form id="viewForm" action="view" method="get">
        <input type="hidden" name="articleNo" value="${param.articleNo }" />
        <input type="hidden" name="boardCd" value="${param.boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
</div>        