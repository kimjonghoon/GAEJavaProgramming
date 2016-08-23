<div id="last-modified">Last Modified : 2015.5.21</div>

<h1>메소드 보안</h1>

스프링 시큐리티는 메소드 보안을 서비스 레이어에 하는 것을 권고한다.<br />
BoardService.java와 UserService.java에 메소드 보안을 적용한다.<br />
<em class="path">import org.springframework.security.access.prepost.PreAuthorize;</em><br />
문이 필요하다.<br />

<em class="filename">UserService.java</em>
<pre class="prettyprint">
//회원가입
public int addUser(User user);

//회원권한 추가
public void addAuthority(String email, String authority);

//로그인
public User login(String email, String passwd);

//내 정보 수정
@PreAuthorize("#user.email == principal.username or hasRole('ROLE_ADMIN')")
public int editAccount(User user);

//비밀번호 변경
@PreAuthorize("#email == principal.username or hasRole('ROLE_ADMIN')")
public int changePasswd(String currentPasswd, String newPasswd, String email);

//탈퇴
@PreAuthorize("#user.email == principal.username or hasRole('ROLE_ADMIN')")
public void bye(User user);

//회원찾기
@PreAuthorize("#email == principal.username or hasRole('ROLE_ADMIN')")
public User getUser(String email);
</pre>

<em class="filename">BoardService.java</em>
<pre class="prettyprint">
//목록
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public List&lt;Article&gt; getArticleList(String boardCd, String searchWord);

//총 레코드 수
public int getTotalRecord(String boardCd, String searchWord);

//글쓰기
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public int addArticle(Article article);

//첨부파일 추가
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public void addAttachFile(AttachFile attachFile);

//글수정
@PreAuthorize("#article.email == principal.username or hasRole('ROLE_ADMIN')")
public void modifyArticle(Article article);

//글삭제
@PreAuthorize("#article.email == principal.username or hasRole('ROLE_ADMIN')")
public void removeArticle(Article article);

//조회수 증가
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public void increaseHit(int articleNo);

//상세보기
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public Article getArticle(int articleNo);

//다음글
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public Article getNextArticle(int articleNo, 
		String boardCd, String searchWord);

//이전글
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public Article getPrevArticle(int articleNo, 
		String boardCd, String searchWord);

//첨부파일 리스트
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public List&lt;AttachFile&gt; getAttachFileList(int articleNo);

//첨부파일 삭제
@PreAuthorize("#attachFile.email == principal.username or hasRole('ROLE_ADMIN')")
public void removeAttachFile(AttachFile attachFile);

//게시판 이름
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public String getBoardNm(String boardCd);

//댓글 쓰기
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public void addComment(Comment comment);

//댓글 수정
@PreAuthorize("#comment.email == principal.username or hasRole('ROLE_ADMIN')")
public void modifyComment(Comment comment);

//댓글 삭제
@PreAuthorize("#comment.email == principal.username or hasRole('ROLE_ADMIN')")
public void removeComment(Comment comment);

//댓글 리스트
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public List&lt;Comment&gt; getCommentList(int articleNo);

//첨부파일 찾기
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public AttachFile getAttachFile(int attachFileNo);

//댓글 찾기
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
public Comment getComment(int commentNo);

public int getListItemNo();

public int getPrevPage();

public int getFirstPage();

public int getLastPage();

public int getNextPage();

public void setPagingHelper(PagingHelper pagingHelper);
</pre>

<h3>테스트</h3>
빌드하고 http://localhost:port/spring-bbs/users/login을 방문하여
im@gmail.org/1111로 로그인한다.<br />
게시판 목록에서 hong@gmail.org 메일을 쓰는 홍길동이 작성한 게시글을 클릭한다.<br /> 
수정 버튼을 클릭하여 글수정 화면으로 이동한다.<br />
글수정 화면에서 수정 후 전송을 클릭한다.<br />
메소드 보안이 작동하고 있다면 noAuthority.jsp로 이동하게 된다.<br />
