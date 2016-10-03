package net.java_school.mybatis;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import net.java_school.bbs.Article;
import net.java_school.bbs.AttachFile;
import net.java_school.bbs.Board;
import net.java_school.bbs.Comments;

public interface BoardMapper {
	//모든 게시판
	public List<Board> selectAllBoardCdBoardNm();
	public List<Board> selectAllBoardCdBoardNm_ko();
	
	//게시판 이름
	public String selectOneBoardName(String boardCd);
	public int insert(Article article); 
	public void insertAttachFile(AttachFile attachFile);
	public void deleteFile(String filekey);
	//목록
	public List<Article> selectListOfArticles(
			@Param("boardCd") String boardCd,
			@Param("searchWord") String searchWord,
			@Param("offset") Integer offset,
			@Param("rowCount") Integer rowCount);	
	//총 레코드
	public int selectCountOfArticles(HashMap<String, String> hashmap);
	//조회수 증가
	public void updateHitPlusOne(int articleNo);	
	//상세보기
	public Article selectOne(int articleNo);
	//다음글
	public Article selectNextOne(HashMap<String, String> hashmap); 
	//이전글
	public Article selectPrevOne(HashMap<String, String> hashmap);
	//첨부파일 리스트
	public List<AttachFile> selectListOfAttachFiles(int articleNo);	
	//댓글 리스트
	public List<Comments> selectListOfComments(int articleNo);
	//첨부파일 찾기
	public AttachFile selectOneAttachFile(String filekey);
	//댓글 삭제
	public void deleteComments(int commentNo);
	//댓글 쓰기
	public void insertComments(Comments comments);	
	//댓글 수정
	public void updateComments(Comments comments);
	//게시글 수정
	public void updateArticle(Article article);
	//게시글 삭제
	public void deleteArticle(int articleNo);
	//댓글 찾기
	public Comments selectOneComments(int commentNo);
	
}