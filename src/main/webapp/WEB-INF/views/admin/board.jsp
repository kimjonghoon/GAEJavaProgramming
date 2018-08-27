<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
    $(document).ready(function () {
        $('#create-board-form').submit(function () {
            var boardCd = $('#create-board-form input[name*=boardCd]').val();
            var boardNm = $('#create-board-form input[name*=boardNm]').val();
            var boardNm_ko = $('#create-board-form input[name*=boardNm_ko]').val();
            boardCd = $.trim(boardCd);
            boardNm = $.trim(boardNm);
            boardNm_ko = $.trim(boardNm_ko);

            if (boardCd.length === 0) {
                alert('<spring:message code="boardCd.empty" />');
                $('#create-board-form input[name*=boardCd]').val('');
                return false;
            }
            if (boardNm.length === 0) {
                alert('<spring:message code="boardNm.empty" />');
                $('#create-board-form input[name*=boardNm]').val('');
                return false;
            }
            if (boardNm_ko.length === 0) {
                alert('<spring:message code="boardNm_ko.empty" />');
                $('#create-board-form input[name*=boardNm_ko]').val('');
                return false;
            }
        });
        $('#edit-board_form').submit(function () {
            var boardNm = $('#edit-board-form input[name*=boardNm]').val();
            var boardNm_ko = $('#edit-board-form input[name*=boardNm_ko]').val();
            boardNm = $.trim(boardNm);
            boardNm_ko = $.trim(boardNm_ko);

            if (boardNm.length === 0) {
                alert('<spring:message code="boardNm.empty" />');
                $('#edit-board-form input[name*=boardNm]').val('');
                return false;
            }
            if (boardNm_ko.length === 0) {
                alert('<spring:message code="boardNm_ko.empty" />');
                $('#edit-board-form input[name*=boardNm_ko]').val('');
                return false;
            }
        });
        $('#board-list a').click(function (e) {
            e.preventDefault();
            var boardCd = this.text;
            var boardNm = this.className;
            var boardNm_ko = this.title;
            $('#edit-board-form input[name*=boardCd]').val(boardCd);
            $('#edit-board-form input[name*=boardNm]').val(boardNm);
            $('#edit-board-form input[name*=boardNm_ko]').val(boardNm_ko);
        });

    });
</script>

<h3>Board List</h3>

<table class="bbs-table" id="board-list">
    <tr>
        <th style="text-align: left;">Board Code</th>
        <th style="text-align: left;">Board Name</th>
        <th style="text-align: left;">Board Korean Name</th>
    </tr>
    <c:forEach var="board" items="${list }" varStatus="status">
        <tr>
            <td><a href="#" class="${board.boardNm }" title="${board.boardNm_ko }">${board.boardCd }</a></td>
            <td>${board.boardNm }</td>
            <td>${board.boardNm_ko }</td>
        </tr>
    </c:forEach>
</table>

<h2>New Board</h2>

<form id="create-board-form" action="/admin/createBoard" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <table class="bbs-table">
        <tr>
            <td>Board Code</td>
            <td><input type="text" name="boardCd" />
        </tr>
        <tr>
            <td>Board Name</td>
            <td><input type="text" name="boardNm" />
        </tr>
        <tr>
            <td>Board Korean Name</td>
            <td><input type="text" name="boardNm_ko" />
        </tr>
    </table>
    <div>
        <input type="submit" value="Submit" />
    </div>
</form>

<h2>Edit Board</h2>

<form id="edit-board-form" action="/admin/editBoard" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <table class="bbs-table">
        <tr>
            <td>Board Code</td>
            <td><input type="text" name="boardCd" readonly=readonly />
        </tr>
        <tr>
            <td>Board Name</td>
            <td><input type="text" name="boardNm" />
        </tr>
        <tr>
            <td>Board Korean Name</td>
            <td><input type="text" name="boardNm_ko" />
        </tr>
    </table>
    <div>
        <input type="submit" value="Submit" />
    </div>
</form>