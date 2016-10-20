package net.java_school.bbs;

import java.util.List;

public interface BoardService {
   //게시판
   public Board getBoard(String boardCd);
   public int addArticle(Article article);
   public void addAttachFile(AttachFile attachFile);
   public void removeAttachFile(String filekey);
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
	public void removeComments(int commentNo);
	//댓글 쓰기
	public void addComments(Comments comments);
	//댓글 수정
	public void modifyComments(Comments comments);
	//게시글 수정
	public void modifyArticle(Article article);
	//게시글 삭제
	public void removeArticle(int articleNo);
	//댓글 찾기
	public Comments getComments(int commentNo);
	//게시판 목록 
	public List<Board> getBoards();
	//게시판 등록
	public void addBoard(Board board);
	//게시판 수정
	public void editBoard(Board board);
}