package net.java_school.bbs;

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
}