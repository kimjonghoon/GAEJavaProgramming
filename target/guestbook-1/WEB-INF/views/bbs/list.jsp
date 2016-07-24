<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h1>자유 게시판</h1>
<table class="bbs-table">
<tr>
   <th style="width: 60px;">NO</th>
   <th>TITLE</th>
   <th style="width: 84px;">DATE</th>
   <th style="width: 60px;">READ</th>
</tr>
<!-- 반복 구간 -->
<tr>
   <td style="text-align: center;">11</td>
   <td>
      <a href="#">제목</a>
      <!--첨부 파일 -->
      <strong class="attach">2</strong>
      <!--댓글 -->
      <strong class="reply">[5]</strong>
   </td>
   <td style="text-align: center;">2016.7.8</td>
   <td style="text-align: center;">4567</td>
</tr>
</table>
<div id="paging">
   <strong class="current-page">1</strong>
   <a href="#">[2]</a>
   <a href="#">[3]</a>
   <a href="#">[4]</a>
   <a href="#">[5]</a>
</div>
<div id="list-menu">
   <input type="button" value="새 글쓰기" />
</div>
<div id="search">
   <form action="list.jsp" method="get">
   <p style="margin: 0;padding: 0;">
      <input type="hidden" name="boardCd" value="free" />
      <input type="hidden" name="curPage" value="1" />
      <input type="text" name="searchWord" size="15" maxlength="30" />
      <input type="submit" value="검색" />
   </p>
   </form>
</div>

