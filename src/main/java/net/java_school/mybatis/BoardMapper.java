package net.java_school.mybatis;

import java.util.List;

import net.java_school.bbs.Article;
import net.java_school.bbs.AttachFile;
import net.java_school.bbs.Board;

public interface BoardMapper {
	//모든 게시판
	public List<Board> selectAllBoard();
	//게시판 이름
	public String selectOneBoardName(String boardCd);
	public int insert(Article article); 
	public void insertAttachFile(AttachFile attachFile);
	public void deleteFile(String filekey); 
}