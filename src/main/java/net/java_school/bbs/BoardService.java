package net.java_school.bbs;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;

public interface BoardService {
   //게시판
   public Board getBoard(String boardCd);
   
   @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
   public int addArticle(Article article);
   
   @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
   public void addAttachFile(AttachFile attachFile);
   //첨부 파일 삭제
   @PreAuthorize("#attachFile.owner == principal.email or hasRole('ROLE_ADMIN')")
   public void removeAttachFile(AttachFile attachFile);
	//목록
	public List<Article> getArticleList(String boardCd, String searchWord, Integer offset, Integer rowCount);
	//총 레코드 수
	public int getTotalRecord(String boardCd, String searchWord);
	//조회수 증가
	public void increaseHit(int articleNo);
	//상세보기
	public Article getArticle(int articleNo);
	//다음글
	public Article getNextArticle(int articleNo, String boardCd, String searchWord);
	//이전글
	public Article getPrevArticle(int articleNo, String boardCd, String searchWord);
	//첨부파일 리스트
	public List<AttachFile> getAttachFileList(int articleNo);
	//댓글 리스트
	public List<Comments> getCommentsList(int articleNo);
	//첨부파일 찾기
	public AttachFile getAttachFile(String filekey);
	//댓글 삭제
	@PreAuthorize("#comments.owner == principal.email or hasRole('ROLE_ADMIN')")
	public void removeComments(Comments comments);
	//댓글 쓰기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void addComments(Comments comments);
	//댓글 수정
	@PreAuthorize("#comments.owner == principal.email or hasRole('ROLE_ADMIN')")
	public void modifyComments(Comments comments);
	//게시글 수정
	@PreAuthorize("#article.owner == principal.email or hasRole('ROLE_ADMIN')")
	public void modifyArticle(Article article);
	//게시글 삭제
	@PreAuthorize("#article.owner == principal.email or hasRole('ROLE_ADMIN')")
	public void removeArticle(Article article);
	//댓글 찾기
	public Comments getComments(int commentNo);
	//게시판 목록 
	public List<Board> getAllBoards();
	//게시판 등록
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void addBoard(Board board);
	//게시판 수정
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void editBoard(Board board);
}