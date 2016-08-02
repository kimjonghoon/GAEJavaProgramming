package net.java_school.bbs;

import java.util.List;

public interface BoardService {
   //모든 게시판
   public List<Board> getAllBoard();
   //게시판 이름
   public String getBoardNm(String boardCd);
   public int addArticle(Article article);
   public void addAttachFile(AttachFile attachFile);
   public void removeAttachFile(String filekey);
	//목록
	public List<Article> getArticleList(String boardCd, String searchWord);
	//총 레코드 수
	public int getTotalRecord(String boardCd, String searchWord);
	public void setPagingHelper(PagingHelper pagingHelper);
	//조회수 증가
	public void increaseHit(int articleNo);
	//상세보기
	public Article getArticle(int articleNo);
	//다음글
	public Article getNextArticle(int articleNo, 
			String boardCd, String searchWord);
	//이전글
	public Article getPrevArticle(int articleNo, 
			String boardCd, String searchWord);
	//첨부파일 리스트
	public List<AttachFile> getAttachFileList(int articleNo);
	//댓글 리스트
	public List<Comments> getCommentsList(int articleNo);
	//첨부파일 찾기
	public AttachFile getAttachFile(int attachFileNo);
   
}