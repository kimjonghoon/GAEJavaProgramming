<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav id="secondaryNav">
   <strong>BBS</strong>
   <ul id="sub-menu">
   <c:forEach var="i" items="${boards }" varStatus="status">
      <li class="sub-menu-item"><a href="/bbs/list?boardCd=${i.boardCd }&page=1">${i.boardNm_ko }</a></li>
   </c:forEach>
   </ul>
</nav>