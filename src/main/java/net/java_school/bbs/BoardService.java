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
   
}