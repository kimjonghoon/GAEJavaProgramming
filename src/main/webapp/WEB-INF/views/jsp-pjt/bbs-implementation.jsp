<div id="last-modified">Last Modified : 2015.6.20</div>
 
<h1>구현</h1>

<h3>회원 가입</h3>
회원 가입을 처리하는 signUp_proc.jsp 파일을 아래와 같이 완성한다.<br />

<em class="filename">/bbs/signUp_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.user.*" %&gt;</strong>    
&lt;%
/*
회원 가입을 처리하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
자동으로 로그인하지 않는다.
회원 가입이 완료되면 환영페이지로 이동한다.
*/
<strong>
request.setCharacterEncoding("UTF-8");

String email = request.getParameter("email");
String passwd = request.getParameter("passwd");
String name = request.getParameter("name");
String mobile = request.getParameter("mobile");

//email,passwd,name,mobile 순으로
User user = new User(email, passwd, name, mobile);

UserService service = new UserService();
service.addUser(user);
</strong>
response.sendRedirect("welcome.jsp");
%&gt;
</pre>

http://localhost:port/JSPProject/users/signUp.jsp를 방문하여 테스트한다.<br />
환영 페이지를 보았다면 SQL*PLUS로 접속하여 member 테이블에 데이터가 삽입되었는지 확인한다.<br />
환영 페이지를 보지 못했다면 WEB-INF/debug.log 파일에서 로그 메시지를 확인한다.<br />
리눅스 시스템인 경우 <em class="path">chmod o+w debug.log</em>와 같은 권한 설정이 필요하다.<br />
로그 메시지는 TOMCAT_HOME/logs 디렉터리에 있는 파일에도 쌓이니 참고한다.<br />
테스트가 성공했다면 signUp.jsp 의 텍스트 필드에서 value 속성을 제거한다.<br />
참고로, 프로젝트를 간단하게 하도록 회원을 관리하는 관리자 페이지는 만들지 않는다.<br />

<h3>로그인 처리</h3>
로그인 처리 페이지인 login_proc.jsp를 완성한다.<br />

<em class="filename">/users/login_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
<strong>&lt;%@ page import="net.java_school.user.UserService" %&gt;</strong>
&lt;%
<strong>request.setCharacterEncoding("UTF-8");</strong>

String url = request.getParameter("url");
String email = request.getParameter("email");
String passwd = request.getParameter("passwd");
<strong>
UserService service = new UserService();
User user = service.login(email, passwd);

if (user == null) {
    //로그인이 실패하면 다시 로그인 화면으로 되돌아간다.
    response.sendRedirect("login.jsp?url=" + url + "&amp;msg=Login-Failed");
} else {
    session.setAttribute("user", user);</strong>
    if (url != null &amp;&amp; !url.equals("")) {
        response.sendRedirect(url);
    } else {
        response.sendRedirect("../bbs/list.jsp?boardCd=free&amp;page=1");
    }
}
%&gt;
</pre>

로그인 페이지 login.jsp는 이제 msg라는 파라미터가 전달되는지 확인해야 한다.<br />
다음 코드 조각을 로그인 페이지에 추가한다.<br />

<em class="filename">login.jsp</em>
<pre class="prettyprint">&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;로그인&lt;/h1&gt;
<strong>&lt;%
String msg = request.getParameter("msg");

if (msg != null) {
%&gt;
    &lt;p style="color: red;"&gt;로그인에 실패했습니다.&lt;/p&gt;
&lt;%
}
%&gt;</strong>
</pre>

프로젝트에서 사용하는 문자열을 전담하는 클래스를 만든다.<br />

<em class="filename">WebContants.java</em>
<pre class="prettyprint">package net.java_school.commons;

public class WebContants {
    //Session key
    public final static String USER_KEY = "user";
}
</pre>

"user"는 세션에 담을 User 객체의 킷값이다.<br />
login_proc.jsp를 열고 <strong>"user"</strong>를 <strong>WebContants.USER_KEY</strong>로 수정한다.<br />

<h3>내 정보 수정 처리</h3>
먼저 로그인하지 않음을 나타내는 다음 문자열을 WebContants.java에 추가한다.<br />
<pre>public final static String NOT_LOGIN = "Not Login";</pre>

<em class="filename">/users/editAccount_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.user.UserService" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;</strong>
&lt;%
/*
회원정보를 수정하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
로그인되어 있지 않으면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
회원정보를 수정한 후 다시 로그인하고 비밀번호 변경화면으로 이동한다.
비밀번호 변경 화면에서는 비밀번호 외에 회원정보를 모두 볼 수 있기 때문이다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.NOT_LOGIN);
    return;
}

request.setCharacterEncoding("UTF-8");
//전달되는 파라미터 name, mobile, passwd
String name = request.getParameter("name");
String mobile = request.getParameter("mobile");
String passwd = request.getParameter("passwd");

String email = user.getEmail();

UserService service = new UserService();

user = service.login(email, passwd);

if (user == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    session.removeAttribute(WebContants.USER_KEY);//비밀번호가 틀리면 세션을 끊는다.
    return;
}

user = new User(email, passwd, name, mobile);

service.editAccount(user);
session.setAttribute(WebContants.USER_KEY, user);
</strong>
response.sendRedirect("changePasswd.jsp");
%&gt;
</pre>


<h3>비밀번호 변경 처리</h3>

<em class="filename">/users/changePasswd_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.user.UserService" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;</strong>
&lt;%
/*
비밀번호를 수정하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
로그인이 되어 있지 않으면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
비밀번호 변경 후 비밀번호 변경 확인 페이지로 이동한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.NOT_LOGIN);
    return; 
}

//전달되는 파라미터 currentPasswd(현재 비밀번호),newPasswd(변경할 비밀번호)
String currentPasswd = request.getParameter("currentPasswd");
String newPasswd = request.getParameter("newPasswd");
String email = user.getEmail();

UserService service = new UserService();
int check = service.changePasswd(currentPasswd, newPasswd, email);
if (check &lt; 1) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    return; 
}
</strong>
response.sendRedirect("changePasswd_confirm.jsp");
%&gt;
</pre>


<h3>탈퇴 처리</h3>
WebContants.java에 다음 문자열 클래스 상수를 추가한다.<br />
<pre>public final static String AUTHENTICATION_FAILED = "Authentication Failed";</pre>

<em class="filename">/users/bye_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.user.UserService" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;</strong>
&lt;%
/*
회원 탈퇴를 처리하는 페이지로 모델 2에서는 삭제해야 한다.
-구현-
로그인 사용자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
회원 테이블에서 회원정보를 지운다.
세션을 지운다.
탈퇴 확인 페이지로 이동한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.NOT_LOGIN); 
    return;
}

//전달되는 파라미터 email,passwd
String email = request.getParameter("email");
String passwd = request.getParameter("passwd");

//email과 passwd가 맞으면 회원 테이블에서 회원 정보 삭제하고 세션 제거
UserService service = new UserService();
User check = service.login(email, passwd);
if (check == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED); 
    return;
}

//회원 테이블에서 회원 정보 삭제
service.bye(user.getEmail(), passwd);
//세션 제거
session.removeAttribute(WebContants.USER_KEY);
//탈퇴 확인 페이지로 이동</strong>
response.sendRedirect("bye_confirm.jsp");
%&gt;
</pre>

<h3>목록</h3>
목록 /bbs/list.jsp를 구현한다.<br />
내용이 많으니 나누어 진행한다.<br />
전달된 파라미터를 받아서 목록에서 보일 데이터를 만든다.<br />

<em class="filename">/bbs/list.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="net.java_school.commons.PagingHelper" %&gt;
&lt;%@ page import="java.util.ArrayList" %&gt;</strong>
&lt;%@ include file="../inc/loginCheck.jsp" %&gt;
<strong>&lt;%
request.setCharacterEncoding("UTF-8");

String boardCd = request.getParameter("boardCd");
int page = Integer.parseInt(request.getParameter("page"));
String searchWord = request.getParameter("searchWord");
if (searchWord == null) searchWord = "";
BoardService service = new BoardService();

//PaginHelper 생성
//1. 총 레코드 계산
int totalRecord = service.getTotalRecord(boardCd, searchWord);
//2. numPerPage, pagePerBlock 설정
int numPerPage = 10;
int pagePerBlock = 10;
PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);

//BoardService에 PagingHelper 주입
service.setPagingHelper(pagingHelper);

List&lt;Article&gt; articleList = service.getArticleList(boardCd, searchWord);
String boardNm = service.getBoardNm(boardCd);
%&gt;</strong>
</pre>

게시판 이름을 출력하는 코드를 삽입한다.

<pre class="prettyprint">&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;<strong>&lt;%=boardNm %&gt;</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
</pre>

검색 폼에서 다음 강조된 부분을 수정한다.<br />

<pre class="prettyprint">&lt;form action="list.jsp" method="get"&gt;
    &lt;p style="margin: 0;padding: 0;"&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="text" name="searchWord" size="15" maxlength="30" /&gt;
        &lt;input type="submit" value="검색" /&gt;
    &lt;/p&gt;
&lt;/form&gt;
</pre>

하단의 #form-group에서 input 엘리먼트 속성값을 아래와 같이 수정한다.<br />

<pre class="prettyprint">&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="listForm" action="list.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="writeForm" action="write_form.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;
</pre>

페이징 처리 로직을 구현한다.<br />

<pre class="prettyprint">    &lt;!--  반복 구간 시작 --&gt;
<strong>&lt;%
int listItemNo = service.getListItemNo();
int size = articleList.size();
for (int i = 0; i &lt; size; i++) {
    Article article = articleList.get(i);
    int articleNo = article.getArticleNo();
    String title = article.getTitle();
    java.util.Date regdate = article.getRegdate();
    int attachFileNum = article.getAttachFileNum();
    int commentNum = article.getCommentNum();
    int hit = article.getHit();
%&gt;</strong>           
    &lt;tr&gt;
        &lt;td style="text-align: center;"&gt;<strong>&lt;%=listItemNo %&gt;</strong>&lt;/td&gt;
        &lt;td&gt;
            &lt;a href="javascript:goView('<strong>&lt;%=articleNo %&gt;</strong>')"&gt;<strong>&lt;%=title %&gt;</strong>&lt;/a&gt;
            <strong>&lt;% if (attachFileNum &gt; 0) { %&gt;</strong>&lt;img src="images/attach.png" alt="첨부 파일" /&gt;<strong>&lt;% } %&gt;</strong>
            <strong>&lt;% if (commentNum &gt; 0) { %&gt;</strong>&lt;span class="bbs-strong"&gt;[&lt;%=commentNum %&gt;]&lt;/span&gt;<strong>&lt;% } %&gt;</strong>
        &lt;/td&gt;
        &lt;td style="text-align: center;"&gt;<strong>&lt;%=regdate %&gt;</strong>&lt;/td&gt;
        &lt;td style="text-align: center;"&gt;<strong>&lt;%=hit %&gt;</strong>&lt;/td&gt;
    &lt;/tr&gt;
<strong>&lt;%
    listItemNo--;
} // for 문의 끝
%&gt;</strong>           
    &lt;!--  반복 구간 끝 --&gt;
    &lt;/table&gt;

    &lt;div id="paging"&gt;
<strong>&lt;%
if (service.getPrevPage() != 0) {
%&gt;</strong>
        &lt;a href="javascript:goList('&lt;%=service.getPrevPage() %&gt;')"&gt;[이전]&lt;/a&gt;
<strong>&lt;%
} // if 문 끝

int firstPage = service.getFirstPage();
int lastPage = service.getLastPage();
for (int i = firstPage; i &lt;= lastPage; i++) {
    if (page == i) {
%&gt;</strong>
        &lt;span class="bbs-strong"&gt;&lt;%=i %&gt;&lt;/span&gt;       
<strong>&lt;%
    } else {
%&gt;</strong>   
        &lt;a href="javascript:goList('&lt;%=i %&gt;')"&gt;&lt;%=i %&gt;&lt;/a&gt;      
<strong>&lt;%
    }
}// for문 끝

// [다음]링크 구현
if (service.getNextPage() != 0) {
%&gt;</strong>
    &lt;a href="javascript:goList('&lt;%=service.getNextPage() %&gt;')"&gt;[다음]&lt;/a&gt;
<strong>&lt;%
}// if문 끝
%&gt;</strong>
    &lt;/div&gt;
</pre>

list.jsp에 방문하여 게시판을 테스트한다.<br />
아직 게시물이 없으므로 제대로 동작하는지는 알 수 없으나 에러 없이 화면이 보여야 한다.<br />

<h3>글쓰기 폼</h3>
/bbs/write_form.jsp를 구현한다.<br />

<em class="filename">/bbs/write_form.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;<strong>
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;</strong>
&lt;%@ include file="../inc/loginCheck.jsp" %&gt;<strong>
&lt;%
request.setCharacterEncoding("UTF-8");

String articleNo = request.getParameter("articleNo");
String boardCd = request.getParameter("boardCd");
String page = request.getParameter("page");
String searchWord = request.getParameter("searchWord");

BoardService service = new BoardService();
String boardNm = service.getBoardNm(boardCd);
%&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="글쓰기 화면" /&gt;
&lt;meta name="Description" content="글쓰기 화면" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("writeForm");
    //유효성 검사 로직 추가
    return true;
}

function goList() {
    var form = document.getElementById("listForm");
    form.submit();
}

function goView() {
    var form = document.getElementById("viewForm");
    form.submit();
}

//]]&gt;
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;
        
&lt;!-- 본문 시작 --&gt;        
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;<strong>&lt;%=boardNm %&gt;</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;h2&gt;글쓰기&lt;/h2&gt;
&lt;form id="writeForm" action="write_proc.jsp" method="post" enctype="multipart/form-data" onsubmit="return check();"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
&lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="title" style="width: 90%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;&lt;/textarea&gt;
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;첨부 파일&lt;/td&gt;
    &lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="전송" /&gt;
    &lt;input type="button" value="목록" onclick="goList()" /&gt;
<strong>&lt;% 
if (articleNo != null) {
%&gt;   
    &lt;input type="button" value="상세보기" onclick="goView()" /&gt;
&lt;%
} //if문 끝
%&gt;</strong>  
&lt;/div&gt;
&lt;/form&gt;
&lt;/div&gt;
&lt;!--  본문 끝 --&gt;
        &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="bbs-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="listForm" action="list.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>글쓰기 처리</h3>
글쓰기 처리 페이지 write_proc.jsp를 구현한다.<br />
파일 업로드를 위한 라이브러리가 필요하다.<br />
<a href="http://www.servlets.com/cos/cos-26Dec2008.zip">http://www.servlets.com/cos/cos-26Dec2008.zip</a>를 
내려받고 압축을 푼다.<br />
cos.jar를 WEB-INF/lib에 복사한다.<br />
도큐먼트 베이스 아래 upload라는 폴더를 만든다.<br />
유닉스 계열 시스템이면 upload 폴더에 권한 설정이 필요하다.<br />

<em class="filename">/bbs/write_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
<strong>&lt;%@ page import="java.io.*" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.user.UserService" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="com.oreilly.servlet.MultipartRequest" %&gt;
&lt;%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %&gt;</strong>
&lt;%
/*
새 게시글을 등록하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
로그인 사용자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
로그인 체크를 통과하면
boardCd, title, content, attachFile 파라미터를 가지고 새로운 게시글을 인서트 한다.
form이 enctype="multipart/form-data"인 경우 request.getParameter()로 파라미터의 값을 얻을 수 없다.
프로그래밍을 손쉽게 하도록 외부 라이브러리를 이용한다. (아파치 commons.fileupload 또는 cos)
새 글을 등록한 후 목록의 첫 번째 페이지로 돌아간다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.NOT_LOGIN);
    return;
}

String dir = application.getRealPath("/upload");

MultipartRequest multi = new MultipartRequest(
        request,
        dir,
        5*1024*1024,
        "UTF-8",
        new DefaultFileRenamePolicy());

String title = multi.getParameter("title");
String content = multi.getParameter("content");
String filename = multi.getFilesystemName("attachFile");
String filetype = multi.getContentType("attachFile");

File f = multi.getFile("attachFile");
long filesize = 0L;
AttachFile attachFile = null;

if (f != null) {
    filesize = f.length();
    attachFile = new AttachFile();
    attachFile.setFilename(filename);
    attachFile.setFiletype(filetype);
    attachFile.setFilesize(filesize);
    attachFile.setEmail(user.getEmail());
}

String boardCd = multi.getParameter("boardCd");

Article article = new Article();
article.setEmail(user.getEmail());
article.setTitle(title);
article.setContent(content);
article.setBoardCd(boardCd);

BoardService service = new BoardService();
service.addArticle(article, attachFile);

response.sendRedirect("list.jsp?boardCd=" + boardCd + "&amp;page=1");</strong>
%&gt;
</pre>

<h3>상세보기</h3>
/bbs/view.jsp 파일을 아래를 참조하여 수정한다.<br />

<em class="filename">/bbs/view.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;<strong>
&lt;%@ page import="java.util.*" %&gt;
&lt;%@ page import="net.java_school.user.*" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="net.java_school.commons.*" %&gt;</strong>
&lt;%@ include file="../inc/loginCheck.jsp" %&gt;<strong>
&lt;%
request.setCharacterEncoding("UTF-8");

int articleNo = Integer.parseInt(request.getParameter("articleNo"));
String boardCd = request.getParameter("boardCd");
int page = Integer.parseInt(request.getParameter("page"));
String searchWord = request.getParameter("searchWord");
if (searchWord == null) searchWord = "";

BoardService service = new BoardService();

//PagingHelper 생성
int totalRecord = service.getTotalRecord(boardCd, searchWord);//총 레코드
int numPerPage = 10;
int pagePerBlock = 10;
PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);

//BoardService에 PagingHelper 주입
service.setPagingHelper(pagingHelper);

service.increaseHit(articleNo);//목록을 구하기 전에 조회 수를 1 증가시킨다.

Article detailedArticle = service.getArticle(articleNo);//상세보기에서 볼 게시글
List&lt;AttachFile&gt; attachFileList = service.getAttachFileList(articleNo);//첨부 파일 목록
Article nextArticle = service.getNextArticle(articleNo, boardCd, searchWord);//다음 글
Article prevArticle = service.getPrevArticle(articleNo, boardCd, searchWord);//이전 클
List&lt;Article&gt; articleList = service.getArticleList(boardCd, searchWord);//게시글 목록 
List&lt;Comment&gt; commentList = service.getCommentList(articleNo);//댓글 목록

String boardNm = service.getBoardNm(boardCd);//게시판 이름

String articleOwnerName = detailedArticle.getName();//게시글 작성자 이름
%&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 상세보기" /&gt;
&lt;meta name="Description" content="게시판 상세보기" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[ 

function modifyCommentToggle(articleNo) {
    var p_id = "comment" + articleNo;
    var form_id = "modifyCommentForm" + no;
    var p = document.getElementById(p_id);
    var form = document.getElementById(form_id);
    
    var p_display;
    var form_display;
    
    if (p.style.display) {
            p_display = '';
            form_display = 'none';
    } else {
            p_display = 'none';
            form_display = '';
    }
    
    p.style.display = p_display;
    form.style.display = form_display;
}

function goList(page) {
    var form = document.getElementById("listForm");
    form.page.value = page;
    form.submit();
}

function goView(articleNo) {
    var form = document.getElementById("viewForm");
    form.articleNo.value = articleNo;
    form.submit();
}

function goWrite() {
    var form = document.getElementById("writeForm");
    form.submit();
}


function goModify() {
    var form = document.getElementById("modifyForm");
    form.submit();
}

function goDelete() {
    var check = confirm("정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("delForm");
        form.submit();
    }
}

function deleteAttachFile(attachFileNo) {
    var check = confirm("첨부 파일을 정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("deleteAttachFileForm");
        form.attachFileNo.value = attachFileNo;
        form.submit();
    }
}

function deleteComment(commentNo) {
    var check = confirm("댓글을 정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("deleteCommentForm");
        form.commentNo.value = commentNo;
        form.submit();
    }
}

//]]&gt;                    
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;
        
&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;<strong>&lt;%=boardNm %&gt;</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;!--  목록에서 추가되는 부분 begin --&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;th style="width: 37px;text-align: left;vertical-align: top;"&gt;TITLE&lt;/th&gt;
    &lt;th style="text-align: left;color: #555;"&gt;<strong>&lt;%=detailedArticle.getTitle() %&gt;</strong>&lt;/th&gt;
&lt;/tr&gt; 
&lt;/table&gt;

&lt;div id="gul-content"&gt;
    &lt;span id="date-writer-hit"&gt;edited <strong>&lt;%=detailedArticle.getRegdate() %&gt;</strong> by <strong>&lt;%=articleOwnerName %&gt;</strong> hit <strong>&lt;%=detailedArticle.getHit() %&gt;</strong>&lt;/span&gt;<strong>
&lt;%
String content = detailedArticle.getContent();
content = content.replaceAll(System.getProperty("line.separator"), "&lt;br /&gt;");
%&gt;</strong>
    &lt;p&gt;<strong>&lt;%=content %&gt;</strong>&lt;/p&gt;<strong>
&lt;%       
int size = attachFileList.size();
if (size &gt; 0) {
%&gt;</strong>
    &lt;p id="file-list" style="text-align: right"&gt;
<strong>&lt;%

    String path = request.getContextPath();
    String uploadPath = path + "/upload/";
    
    for (int i = 0; i &lt; size; i++) {
        AttachFile attachFile = attachFileList.get(i);
        String filename = attachFile.getFilename();
        int attachFileNo = attachFile.getAttachFileNo();
        String fileFullPath = uploadPath + filename;
        
%&gt;</strong>
        &lt;a href="<strong>&lt;%=fileFullPath %&gt;"&gt;&lt;%=filename %&gt;</strong>&lt;/a&gt;
<strong>&lt;% 
        if (user.getEmail().equals(detailedArticle.getEmail())) { 
%&gt;</strong>
        &lt;a href="javascript:deleteAttachFile('<strong>&lt;%=attachFileNo %&gt;</strong>')"&gt;x&lt;/a&gt;
<strong>&lt;%
        }//if문 끝
%&gt;</strong>
        <strong>&lt;br /&gt;</strong>
<strong>&lt;%       
    }//for문 끝
%&gt;</strong>       
    &lt;/p&gt;
<strong>&lt;%
}//if문 끝
%&gt;</strong>      
&lt;/div&gt;
&lt;!--  댓글 반복 시작 --&gt;
<strong>&lt;%
size = commentList.size();
for (int i = 0; i &lt; size; i++ ) {
    Comment comment = commentList.get(i);
    int commentNo = comment.getCommentNo();
    String email = comment.getEmail();
    String memo = comment.getMemo();
    String commentOwnerName = comment.getName();
    Date regdate = comment.getRegdate();
%&gt;</strong>
&lt;div class="comments"&gt;
    &lt;span class="writer"&gt;<strong>&lt;%=commentOwnerName %&gt;</strong>&lt;/span&gt;
    &lt;span class="date"&gt;<strong>&lt;%=regdate %&gt;</strong>&lt;/span&gt;
<strong>&lt;%
    if (user.getEmail().equals(email)) {
%&gt;</strong>   
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:modifyCommentToggle(<strong>'&lt;%=commentNo %&gt;'</strong>)"&gt;수정&lt;/a&gt;
         | &lt;a href="javascript:deleteComment(<strong>'&lt;%=commentNo %&gt;'</strong>)"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
<strong>&lt;%
    }//if문 끝
%&gt;</strong>   
    &lt;p id="comment<strong>&lt;%=commentNo %&gt;</strong>"&gt;<strong>&lt;%=memo %&gt;</strong>&lt;/p&gt;
    &lt;form id="modifyCommentForm<strong>&lt;%=commentNo %&gt;</strong>" class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none;"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" value="<strong>&lt;%=commentNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;div class="fr"&gt;
            &lt;a href="javascript:document.forms.modifyCommentForm<strong>&lt;%=commentNo %&gt;</strong>.submit()"&gt;수정하기&lt;/a&gt;
            | &lt;a href="javascript:goCommentModify(<strong>'&lt;%=commentNo %&gt;'</strong>)"&gt;취소&lt;/a&gt;

    &lt;/div&gt;
    &lt;div&gt;
        &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;<strong>&lt;%=memo %&gt;</strong>&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/div&gt;
<strong>&lt;%
}//for문 끝
%&gt;</strong>
&lt;!--  댓글 반복 끝 --&gt;
    
&lt;form id="addCommentForm" action="addComment_proc.jsp" method="post"&gt;
    &lt;p style="margin: 0;padding: 0;"&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;div id="addComment"&gt;
        &lt;textarea name="memo" rows="7" cols="50"&gt;&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;div style="text-align: right;"&gt;
        &lt;input type="submit" value="댓글 남기기" /&gt;
    &lt;/div&gt;
&lt;/form&gt;
    
&lt;div id="next-prev"&gt;
<strong>&lt;%
if (nextArticle != null) {
%&gt;</strong>
    &lt;p&gt;다음 글 : &lt;a href="javascript:goView(<strong>'&lt;%=nextArticle.getArticleNo() %&gt;'</strong>)"&gt;<strong>&lt;%=nextArticle.getTitle() %&gt;</strong>&lt;/a&gt;&lt;/p&gt;
<strong>&lt;%
} 
if (prevArticle != null) {
%&gt;</strong>       
    &lt;p&gt;이전 글 : &lt;a href="javascript:goView(<strong>'&lt;%=prevArticle.getArticleNo() %&gt;'</strong>)"&gt;<strong>&lt;%=prevArticle.getTitle() %&gt;</strong>&lt;/a&gt;&lt;/p&gt;
<strong>&lt;%
}
%&gt;</strong>       
&lt;/div&gt;
    
&lt;div id="view-menu"&gt;
    &lt;div class="fl"&gt;
<strong>&lt;%
if (user.getEmail().equals(detailedArticle.getEmail())) {
%&gt;</strong>      
        &lt;input type="button" value="수정" onclick="goModify();" /&gt;
        &lt;input type="button" value="삭제" onclick="goDelete()" /&gt;
<strong>&lt;%
}
%&gt;</strong>
    &lt;/div&gt;
        
    &lt;div class="fr"&gt;
<strong>&lt;%
if (nextArticle != null) {
%&gt;</strong>       
        &lt;input type="button" value="다음 글" onclick="goView(<strong>'&lt;%=nextArticle.getArticleNo() %&gt;'</strong>)" /&gt;
<strong>&lt;%
}
if (prevArticle != null) {
%&gt;</strong>           
        &lt;input type="button" value="이전 글" onclick="goView(<strong>'&lt;%=prevArticle.getArticleNo() %&gt;'</strong>)" /&gt;
<strong>&lt;%
}
%&gt;</strong>           
        &lt;input type="button" value="목록" onclick="goList(<strong>'&lt;%=page %&gt;'</strong>)" /&gt;
        &lt;input type="button" value="새 글쓰기" onclick="goWrite()" /&gt;
    &lt;/div&gt;
&lt;/div&gt;
    
&lt;!-- 목록 --&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;th style="width: 60px"&gt;NO&lt;/th&gt;
    &lt;th&gt;TITLE&lt;/th&gt;
    &lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
    &lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
&lt;/tr&gt;
<strong>&lt;%
int listItemNo = service.getListItemNo();
size = articleList.size();
for (int i = 0; i &lt; size; i++) {
    Article article = articleList.get(i);
    int aNo = article.getArticleNo();
    String title = article.getTitle();
    Date regdate = article.getRegdate();
    int hit = article.getHit();
    int attachFileNum = article.getAttachFileNum();
    int commentNum = article.getCommentNum();
%&gt;</strong>  
&lt;tr&gt;
    &lt;td style="text-align: center;"&gt;
<strong>&lt;%
if (articleNo == aNo) {
%&gt;</strong>
    &lt;img src="../images/arrow.gif" alt="현재 글" /&gt;
<strong>&lt;%
} else {
%&gt;
    &lt;%=listItemNo %&gt;
&lt;%
}
%&gt;</strong>
    &lt;/td&gt;
    &lt;td&gt;
        &lt;a href="javascript:goView(<strong>'&lt;%=aNo %&gt;'</strong>)"&gt;&lt;%=title %&gt;&lt;/a&gt;
<strong>&lt;%
if (attachFileNum &gt; 0) { 
%&gt;</strong>
        &lt;img src="../images/attach.png" alt="첨부 파일" /&gt;
<strong>&lt;%
}
if (commentNum &gt; 0 ) {
%&gt;</strong>           
        &lt;span class="bbs-strong"&gt;[<strong>&lt;%=commentNum %&gt;</strong>]&lt;/span&gt;
<strong>&lt;%
}
%&gt;</strong>          
    &lt;/td&gt;
    &lt;td style="text-align: center;"&gt;<strong>&lt;%=regdate %&gt;</strong>&lt;/td&gt;
    &lt;td style="text-align: center;"&gt;<strong>&lt;%=hit %&gt;</strong>&lt;/td&gt;
&lt;/tr&gt;
&lt;%
    <strong>listItemNo--;
}//for문 끝
%&gt;</strong>

&lt;/table&gt;

&lt;div id="paging"&gt;<strong>
&lt;%
if (service.getPrevPage() != 0 ) {
%&gt;</strong>
    &lt;a href="javascript:goList(<strong>'&lt;%=service.getPrevPage() %&gt;'</strong>)"&gt;[이전]&lt;/a&gt;
<strong>&lt;%
}
int firstPage = service.getFirstPage();
int lastPage = service.getLastPage();

for (int i = firstPage; i &lt;= lastPage; i++) {
    if (page == i) {
%&gt;</strong>
    &lt;span class="bbs-strong"&gt;<strong>&lt;%=i %&gt;</strong>&lt;/span&gt;
<strong>&lt;%
    } else {
%&gt;</strong>   
    &lt;a href="javascript:goList(<strong>'&lt;%=i %&gt;'</strong>)"&gt;<strong>&lt;%=i %&gt;</strong>&lt;/a&gt;        
<strong>&lt;%
    }
}//for 문 끝
// [다음] 링크 구현
if (service.getNextPage() != 0) {
%&gt;</strong>
    &lt;a href="javascript:goList(<strong>'&lt;%=service.getNextPage() %&gt;'</strong>)"&gt;[다음]&lt;/a&gt;
<strong>&lt;%
}
%&gt;</strong>
&lt;/div&gt;

&lt;div id="list-menu"&gt;
    &lt;input type="button" value="새 글쓰기" onclick="goWrite()" /&gt;
&lt;/div&gt;

&lt;div id="search"&gt;
    &lt;form action="list.jsp" method="get"&gt;
    &lt;p style="margin: 0;padding: 0;"&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="text" name="searchWord" size="15" maxlength="30" /&gt;
        &lt;input type="submit" value="검색" /&gt;
    &lt;/p&gt;  
    &lt;/form&gt;
&lt;/div&gt;
    
&lt;/div&gt;&lt;!--  bbs 끝 --&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="bbs-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="listForm" action="list.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="writeForm" action="write_form.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="modifyForm" action="modify_form.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="delForm" action="del_proc.jsp" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="deleteCommentForm" action="deleteComment_proc.jsp" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" /&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;   
    &lt;form id="deleteAttachFileForm" action="deleteAttachFile.jsp" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="attachFileNo" /&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;   
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>댓글 쓰기 처리</h3>

<em class="filename">/bbs/addComment_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;</strong>
&lt;%
/*
새로운 댓글을 인서트 하는 페이지로 모델 2에서는 삭제한다.
-구현-
로그인 사용자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
로그인 체크를 통과하면 
먼저 요청의 캐릭터 셋을 UTF-8으로 설정한다.
boardCd, articleNo, page, searchWord, memo 파라미터를 받아서 댓글을 인서트 한다.
댓글을 인서트 한 후 상세보기로 돌아가기 위해 검색어 searchWord를 URLEncoder의 encode() 메서드로 UTF-8으로 인코딩한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.NOT_LOGIN);
    return;
}
request.setCharacterEncoding("UTF-8");

String boardCd = request.getParameter("boardCd");
int articleNo = Integer.parseInt(request.getParameter("articleNo"));
int page = Integer.parseInt(request.getParameter("page"));
String searchWord = request.getParameter("searchWord");
String memo = request.getParameter("memo");

Comment comment = new Comment();
comment.setArticleNo(articleNo);
comment.setEmail(user.getEmail());
comment.setMemo(memo);

BoardService service = new BoardService();
service.addComment(comment);

searchWord = java.net.URLEncoder.encode(searchWord, "UTF-8");
response.sendRedirect("view.jsp?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);</strong>
%&gt;
</pre>

<h3>댓글 수정 처리</h3>
<em class="filename">/bbs/updateComment_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;</strong>
&lt;%
/*
댓글 업데이트를 실행하는 페이지로 모델 2에서는 삭제한다.
-구현-
작성자인지 검사하고 작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Authentication Failed"); return;
작성자 체크를 통과하면
요청의 캐릭터 셋을 UTF-8으로 설정한다.
commentNo, boardCd, articleNo, page, searchWord, memo 파라미터를 받아서
댓글을 업데이트한다.
댓글을 업데이트한 후 상세보기로 돌아가기 위해 검색어 searchWord를 URLEncoder의 encode() 메서드로 UTF-8으로 인코딩한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);

request.setCharacterEncoding("UTF-8");
int commentNo = Integer.parseInt(request.getParameter("commentNo"));

//로그인 사용자가 댓글의 소유자인지 검사
BoardService service = new BoardService();
Comment comment = service.getComment(commentNo);
if (user == null || !user.getEmail().equals(comment.getEmail())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    return; 
}

String boardCd = request.getParameter("boardCd");
int articleNo = Integer.parseInt(request.getParameter("articleNo"));
int page = Integer.parseInt(request.getParameter("page"));
String searchWord = request.getParameter("searchWord");

String memo = request.getParameter("memo");

//생성된 Comment 객체를 재사용한다.
comment.setCommentNo(commentNo);
comment.setArticleNo(articleNo);
comment.setEmail(user.getEmail());
comment.setMemo(memo);

service.modifyComment(comment);

searchWord = java.net.URLEncoder.encode(searchWord,"UTF-8");
response.sendRedirect("view.jsp?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);</strong>
%&gt;
</pre>

<h3>댓글 삭제 처리</h3>

<em class="filename">/bbs/deleteComment_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;</strong>
&lt;%
/*
댓글 삭제를 실행하는 페이지로 모델 2에서는 삭제한다.

-구현-
작성자인지를 검사하고 작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "작성자가 아닙니다."); return;
요청의 캐릭터 셋을 UTF-8으로 설정해야 한다.
요청에서 참조해야 하는 파라미터는
commentNo, boardCd, articleNo, page, searchWord 이다.
댓글을 삭제 후 상세보기를 돌아가기 위해선 searchWord를 URLEncoder의 encode() 메서드로 UTF-8으로 인코딩한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);

request.setCharacterEncoding("UTF-8");
int commentNo = Integer.parseInt(request.getParameter("commentNo"));

//로그인 사용자가 댓글의 소유자인지를 검사
BoardService service = new BoardService();
Comment comment = service.getComment(commentNo);
if (user == null || !user.getEmail().equals(comment.getEmail())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    return; 
}

String boardCd = request.getParameter("boardCd");
int articleNo = Integer.parseInt(request.getParameter("articleNo"));
int page = Integer.parseInt(request.getParameter("page"));
String searchWord = request.getParameter("searchWord");

service.removeComment(commentNo);

searchWord = java.net.URLEncoder.encode(searchWord, "UTF-8");
response.sendRedirect("view.jsp?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);</strong>
%&gt;
</pre>

<h3>첨부 파일 삭제 처리</h3>

<em class="filename">/bbs/deleteAttachFile_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;</strong>
&lt;%
/*
첨부 파일 삭제를 실행하는 페이지로 모델 2에서는 삭제한다.

-구현-
작성자인지를 검사하고 작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "작성자가 아닙니다."); return;
요청의 캐릭터 셋을 UTF-8으로 설정해야 한다.
요청에서 참조해야 하는 파라미터는
attachFileNo, articleNo, boardCd, page, searchWord이다.
첨부 파일을 삭제 후 상세보기를 돌아가기 위해 searchWord를 URLEncoder의 encode() 메서드로 UTF-8으로 인코딩한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);

request.setCharacterEncoding("UTF-8");
int attachFileNo = Integer.parseInt(request.getParameter("attachFileNo"));

//로그인 사용자가 첨부 파일 소유자인지를 검사
BoardService service = new BoardService();
AttachFile attachFile = service.getAttachFile(attachFileNo);
if (user == null || !user.getEmail().equals(attachFile.getEmail())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    return; 
}

String boardCd = request.getParameter("boardCd");
int articleNo = Integer.parseInt(request.getParameter("articleNo"));
int page = Integer.parseInt(request.getParameter("page"));
String searchWord = request.getParameter("searchWord");

service.removeAttachFile(attachFileNo);

searchWord = java.net.URLEncoder.encode(searchWord, "UTF-8");
response.sendRedirect("view.jsp?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);</strong>
%&gt;
</pre>

<h3>글 수정 폼</h3>

<em class="filename">/bbs/modify_form.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
<strong>&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;</strong>
&lt;%<strong>
request.setCharacterEncoding("UTF-8");

int articleNo = Integer.parseInt(request.getParameter("articleNo"));
String boardCd = request.getParameter("boardCd");
int page = Integer.parseInt(request.getParameter("page"));
String searchWord = request.getParameter("searchWord");

//articleNo로 게시글 객체를 얻어서 현재 로그인된 사용자가 소유자인지 검사
User user = (User) session.getAttribute("user");
BoardService service = new BoardService();
Article article = service.getArticle(articleNo);

//글 소유자와 로그인 사용자가 다르면 에러 페이지로 보낸다. 
if (user == null || !user.getEmail().equals(article.getEmail())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    return;
}

//수정 폼의 초깃값
String title = article.getTitle();
String content = article.getContent();
if (content == null) content = "";

//게시판 이름
String boardNm = service.getBoardNm(boardCd);</strong>
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 수정하기 폼" /&gt;
&lt;meta name="Description" content="게시판 수정하기 폼" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("modifyForm");
    //유효성 검사 로직 추가
    return true;
}

function goView() {
    var form = document.getElementById("viewForm");
    form.submit();
}

//]]&gt;
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;
        
&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;<strong>&lt;%=boardNm %&gt;</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;h2&gt;수정&lt;/h2&gt;
&lt;form id="modifyForm" action="modify_proc.jsp" method="post" enctype="multipart/form-data" onsubmit="return checking();"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
&lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
&lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
&lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
&lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="title" style="width: 90%;" value="<strong>&lt;%=title %&gt;</strong>" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;<strong>&lt;%=content %&gt;</strong>&lt;/textarea&gt;
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;첨부 파일&lt;/td&gt;
    &lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="전송" /&gt;
    &lt;input type="button" value="상세보기" onclick="goView()" /&gt;
&lt;/div&gt;
&lt;/form&gt;
    
&lt;/div&gt;&lt;!-- bbs 끝 --&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="bbs-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;div id="form-group" style="display: none;"&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>&lt;%=articleNo %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>&lt;%=boardCd %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>&lt;%=page %&gt;</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>&lt;%=searchWord %&gt;</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>글 수정 처리</h3>

<em class="filename">/bbs/modify_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="java.io.*" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.user.UserService" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="com.oreilly.servlet.MultipartRequest" %&gt;
&lt;%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %&gt;</strong>
&lt;%
/*
게시글을 수정하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
작성자인지 검사하고 작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Authentication Failed"); return;
articleNo, boardCd, page, searchWord, title, content, attachFile 파라미터를 받고
게시글을 수정한다.
form이 enctype="multipart/form-data"인 경우 request.getParameter()로 파라미터의 값을 얻을 수 없다.
쉽게 프로그래밍하기 위해 외부 라이브러리를 이용한다. (아파치 commons.fileupload 또는 cos)
게시글을 수정한 후 상세보기를 돌아가기 위해 검색어 searchWord를 URLEncoder의 encode() 메서드로 UTF-8으로 인코딩한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);

String dir = application.getRealPath("/upload");

MultipartRequest multi = new MultipartRequest(
        request,
        dir,
        5*1024*1024,
        "UTF-8",
        new DefaultFileRenamePolicy());

BoardService service = new BoardService();
int articleNo = Integer.parseInt(multi.getParameter("articleNo"));
//글 소유자인지 검사
if (!service.getArticle(articleNo).getEmail().equals(user.getEmail())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    return;
}

String boardCd = multi.getParameter("boardCd");
int page = Integer.parseInt(multi.getParameter("page"));
String searchWord = multi.getParameter("searchWord");
searchWord = java.net.URLEncoder.encode(searchWord, "UTF-8");

String title = multi.getParameter("title");
String content = multi.getParameter("content");
String filename = multi.getFilesystemName("attachFile");
String filetype = multi.getContentType("attachFile");

File f = multi.getFile("attachFile");
long filesize = 0L;
AttachFile attachFile = null;

if (f != null) {
    filesize = f.length();
    attachFile = new AttachFile();
    attachFile.setFilename(filename);
    attachFile.setFiletype(filetype);
    attachFile.setFilesize(filesize);
    attachFile.setEmail(user.getEmail());
    attachFile.setArticleNo(articleNo);
}

Article article = new Article();
article.setArticleNo(articleNo);
article.setBoardCd(boardCd);
article.setTitle(title);
article.setContent(content);
article.setEmail(user.getEmail());

service.modifyArticle(article, attachFile);

response.sendRedirect("view.jsp?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);</strong>
%&gt;
</pre>

<h3>게시글 삭제 처리</h3>

<em class="filename">/bbs/del_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;</strong>
&lt;%
/*
게시글을 삭제하는 페이지로 모델 2에서는 삭제한다.
-구현-
작성자인지 검사하고 작성자가 아니면 
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Authentication Failed"); return;
작성자 체크를 통과하면
요청의 캐릭터 셋을 UTF-8으로 설정한다.
articleNo, boardCd, page, searchWord 파라미터를 받고
articleNo로 게시글을 삭제한다.
게시글 삭제 후 목록을 돌아가기 위해 검색어 searchWord를 URLEncoder의 encode() 메서드로 UTF-8으로 인코딩한다.
*/
<strong>
User user = (User) session.getAttribute(WebContants.USER_KEY);

request.setCharacterEncoding("UTF-8");
//전달된 파라미터 articleNo,boardCd,page,searchWord
int articleNo = Integer.parseInt(request.getParameter("articleNo"));
//글 소유자 검사
BoardService service = new BoardService();
Article article = service.getArticle(articleNo);
if (user == null || !user.getEmail().equals(article.getEmail())) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, WebContants.AUTHENTICATION_FAILED);
    return;
}

service.removeArticle(articleNo);

String boardCd = request.getParameter("boardCd");
String page = request.getParameter("page");
String searchWord = request.getParameter("searchWord");

searchWord = java.net.URLEncoder.encode(searchWord, "UTF-8");
response.sendRedirect("list.jsp?boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);</strong>
%&gt;
</pre>
