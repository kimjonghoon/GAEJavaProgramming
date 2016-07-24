<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h1>자유 게시판</h1>
<div class="view-menu" style="height: 32px;">
    <div style="float: left;">
        <input type="button" value="수정" />
        <input type="button" value="삭제" />
    </div>
    <div style="float: right;">
        <input type="button" value="다음 글" />
        <input type="button" value="이전 글" />
        <input type="button" value="목록" />
        <input type="button" value="새 글쓰기" />
    </div>
</div>
<table class="bbs-table">
<tr>
    <th style="width: 37px;text-align: left;">TITLE</th>
    <th style="text-align: left;color: #555;">무궁화꽃이피었습니다</th>
</tr>
</table>
<div id="date-writer-read">2014 10-09 17:50:30 by 홍길동 read 1330</div>
<p id="content">
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다<br />
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다<br />
</p>
<!--  댓글 반복 시작 -->
<div class="comments">
    <span class="comments-writer">임꺽정</span>
    <span class="comments-date">2011.12.11 12:14:32</span>
    <span class="comments-modify-del">
        <a href="javascript:modifyCommentToggle('5')">수정</a>
         | <a href="javascript:deleteComment('5')">삭제</a>
    </span>
    <p id="comment5">무궁화꽃이피었습니다</p>
    <form id="modifyCommentForm5" class="modify-comments" method="post" style="display: none;">
    <p>
        <input type="hidden" name="commentNo" value="5" />
        <input type="hidden" name="boardCd" value="free" />
        <input type="hidden" name="articleNo" value="12" />
        <input type="hidden" name="curPage" value="1" />
        <input type="hidden" name="searchWord" value="무궁화꽃" />
    </p>
    <div>
            <a href="javascript:document.forms.modifyCommentForm5.submit()">수정하기</a>
            | <a href="javascript:modifyCommentToggle('5')">취소</a>
    </div>
    <div>
        <textarea class="modify-comments-ta" name="memo" rows="7" cols="50">무궁화꽃이 피었습니다.</textarea>
    </div>
    </form>
</div>
<!--  댓글 반복 끝 -->
<form id="addCommentForm" action="addComment_proc.jsp" method="post">
    <p style="margin: 0; padding: 0;">
        <input type="hidden" name="articleNo" value="5"/>
        <input type="hidden" name="boardCd" value="free" />
        <input type="hidden" name="curPage" value="1" />
        <input type="hidden" name="searchWord" value="무궁화꽃" />
    </p>
    <div id="add-comments">
        <textarea name="memo" rows="7" cols="50"></textarea>
    </div>
    <div style="text-align: right;">
        <input type="submit" value="댓글 남기기" />
    </div>
</form>
<div id="next-prev">
    <p>다음 글 : <a href="#">무궁화꽃이 피었습니다.</a></p>
    <p>이전 글 : <a href="#">무궁화꽃이 피었습니다.</a></p>
</div>
<div class="view-menu" style="height: 32px;">
    <div style="float: left;">
        <input type="button" value="수정" />
        <input type="button" value="삭제" />
    </div>
    <div style="float: right;">
        <input type="button" value="다음 글" />
        <input type="button" value="이전 글" />
        <input type="button" value="목록" />
        <input type="button" value="새 글쓰기" />
    </div>
</div>
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