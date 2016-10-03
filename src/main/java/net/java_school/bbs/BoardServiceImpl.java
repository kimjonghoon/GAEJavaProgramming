package net.java_school.bbs;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import net.java_school.mybatis.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	private BoardMapper boardMapper;
	
	public void setBoardMapper(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}
	@Override
	public List<Board> getAllBoardCdBoardNm() {
		return boardMapper.selectAllBoardCdBoardNm();
	}
	@Override
	public List<Board> getAllBoardCdBoardNm_ko() {
		return boardMapper.selectAllBoardCdBoardNm_ko();
	}
	@Override
	public String getBoardNm(String boardCd) {
		return boardMapper.selectOneBoardName(boardCd);
	}
	@Override
	public int addArticle(Article article) {
		return boardMapper.insert(article);
	}
	@Override
	public void addAttachFile(AttachFile attachFile) {
		boardMapper.insertAttachFile(attachFile);
	}
	@Override
	public void removeAttachFile(String filekey) {
	  boardMapper.deleteFile(filekey);
	}
	//목록
	@Override
	public List<Article> getArticleList(String boardCd, String searchWord, Integer offset, Integer rowCount) {
		return boardMapper.selectListOfArticles(boardCd, searchWord, offset, rowCount);
	}
	//총 레코드수
	@Override
	public int getTotalRecord(String boardCd, String searchWord) {
		HashMap<String,String> hashmap = new HashMap<String,String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.selectCountOfArticles(hashmap);
	}
	//조회수 증가
	@Override
	public void increaseHit(int articleNo) {
		boardMapper.updateHitPlusOne(articleNo);
	}

	//상세보기
	@Override
	public Article getArticle(int articleNo) {
		return boardMapper.selectOne(articleNo);
	}

	//다음글
	@Override
	public Article getNextArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.selectNextOne(hashmap);
	}
	
	//이전글
	@Override
	public Article getPrevArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.selectPrevOne(hashmap);
	}

	//첨부파일 리스트
	@Override
	public List<AttachFile> getAttachFileList(int articleNo) {
		return boardMapper.selectListOfAttachFiles(articleNo);
	}
	//댓글 리스트
	@Override
	public List<Comments> getCommentsList(int articleNo) {
		return boardMapper.selectListOfComments(articleNo);
	}
	//첨부파일 찾기
	@Override
	public AttachFile getAttachFile(String filekey) {
		return boardMapper.selectOneAttachFile(filekey);
	}
	//댓글 삭제
	@Override
	public void removeComments(int commentNo) {
		boardMapper.deleteComments(commentNo);
	}
	//댓글 쓰기
	@Override
	public void addComments(Comments comments) {
		boardMapper.insertComments(comments);
	}
	//댓글 수정
	@Override
	public void modifyComments(Comments comments) {
		boardMapper.updateComments(comments);
	}
	//게시글 수정
	@Override
	public void modifyArticle(Article article) {
		boardMapper.updateArticle(article);
	}
	//글삭제
	@Override
	public void removeArticle(int articleNo) {
		boardMapper.deleteArticle(articleNo);
	}
	//댓글 찾기
	@Override
	public Comments getComments(int commentNo) {
		return boardMapper.selectOneComments(commentNo);
	}
	
}