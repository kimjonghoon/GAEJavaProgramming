package net.java_school.bbs;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import net.java_school.mybatis.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	private BoardMapper boardMapper;
	private PagingHelper pagingHelper; //페이징 처리 유틸리티 클래스
	
	public void setBoardMapper(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}
	@Override
	public List<Board> getAllBoard() {
		return boardMapper.selectAllBoard();
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
	public List<Article> getArticleList(String boardCd, String searchWord) {
		Integer offset = pagingHelper.getStartRecord() - 1; //for mysql limit first number
		Integer rowCount = pagingHelper.getNumPerPage();
		
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
	@Override
	public void setPagingHelper(PagingHelper pagingHelper) {
		this.pagingHelper = pagingHelper;
	}
	
}