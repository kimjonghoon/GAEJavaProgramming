<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
    window.onload = initPage;
    
    function initPage() {
        document.getElementById("create-board-form").onsubmit = createBoardCheck;
        document.getElementById("edit-board-form").onsubmit = editBoardCheck;
        
        var board_list = document.getElementById("board-list");
        var boardLinks = board_list.getElementsByTagName("a");
        for (var i = 0; i < boardLinks.length; i++) {
            var boardLink = boardLinks[i];
            boardLink.onclick = function() {
                var boardNm_ko = this.title;
                var boardNm = this.className;
                var boardCd = this.text;
                var form = document.getElementById("edit-board-form");
                form.boardCd.value = boardCd;
                form.boardNm.value = boardNm;
                form.boardNm_ko.value = boardNm_ko;
                return false;
            };
        }
    }
    function createBoardCheck() {
        var form = document.getElementById("create-board-form");
        var boardCd = form.boardCd.value;
        var boardNm = form.boardNm.value;
        var boardNm_ko = form.boardNm_ko.value;
        boardCd = boardCd.trim();
        boardNm = boardNm.trim();
        boardNm_ko = boardNm_ko.trim();
        if (boardCd.length === 0) {
            alert('<spring:message code="boardCd.empty" />');
            form.boardCd.value = '';
            return false;
        }
        if (boardNm.length === 0) {
            alert('<spring:message code="boardNm.empty" />');
            form.boardNm.value = '';
            return false;
        }
        if (boardNm_ko.length === 0) {
            alert('<spring:message code="boardNm_ko.empty" />');
            form.boardNm_ko.value = '';
            return false;
        }
        return true;
        
    }
    function editBoardCheck() {
        var form = document.getElementById("edit-board-form");
        var boardNm = form.boardNm.value;
        var boardNm_ko = form.boardNm_ko.value;
        boardNm = boardNm.trim();
        boardNm_ko = boardNm_ko.trim();
        if (boardNm.length === 0) {
            alert('<spring:message code="boardNm.empty" />');
            form.boardNm.value = '';
            return false;
        }
        if (boardNm_ko.length === 0) {
            alert('<spring:message code="boardNm_ko.empty" />');
            form.boardNm_ko.value = '';
            return false;
        }
        return true;
    }
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