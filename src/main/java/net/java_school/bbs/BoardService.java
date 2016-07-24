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
}

