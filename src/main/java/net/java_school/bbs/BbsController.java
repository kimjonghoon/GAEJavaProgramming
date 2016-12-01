package net.java_school.bbs;

import java.net.URLEncoder;
import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.java_school.bbs.BoardService;
import net.java_school.commons.NumbersForPaging;
import net.java_school.commons.NumberGeneratorForPaging;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@Controller
@RequestMapping("/bbs")
public class BbsController extends NumberGeneratorForPaging {
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	private BoardService boardService;

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	private String getBoardName(String boardCd, String lang) {
		Board board = boardService.getBoard(boardCd);
		
		switch (lang) {
		case "en":
			return board.getBoardNm();
		case "ko":
			return board.getBoardNm_ko();
		default:
			return board.getBoardNm();
		}
	}
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String list(String boardCd, Integer curPage, String searchWord, Locale locale, Model model) {
		String lang = locale.getLanguage();
		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);

		String boardName = this.getBoardName(boardCd, lang);

		int numPerPage = 10;
		int pagePerBlock = 10;
		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		NumbersForPaging ints = this.getNumbersForPaging(totalRecord, curPage, numPerPage, pagePerBlock);
		Integer offset = ints.getOffset();
		List<Article> list = boardService.getArticleList(boardCd, searchWord, offset, numPerPage);
		
		Integer listItemNo = ints.getListItemNo();
		Integer prevPage = ints.getPrevPage();
		Integer nextPage = ints.getNextPage();
		Integer firstPage = ints.getFirstPage();
		Integer lastPage = ints.getLastPage();

		model.addAttribute("list", list);
		model.addAttribute("boardName", boardName);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);

		return "bbs/list";
	}

	@RequestMapping(value="/view", method=RequestMethod.GET)
	public String view(Integer articleNo, 
			String boardCd, 
			Integer curPage,
			String searchWord,
			Locale locale,
			Model model) {
		
		String lang = locale.getLanguage();
		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);

		boardService.increaseHit(articleNo);

		Article article = boardService.getArticle(articleNo);//상세보기에서 볼 게시글
		List<AttachFile> attachFileList = boardService.getAttachFileList(articleNo);
		Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
		Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
		List<Comments> commentsList = boardService.getCommentsList(articleNo);
		String boardName = this.getBoardName(boardCd, lang);

		//상세보기에서 볼 게시글 관련 정보
		String title = article.getTitle();//제목
		String content = article.getContent();//내용
		content = content.replaceAll(System.getProperty("line.separator"), "<br />");
		int hit = article.getHit();//조회수
		String nickname = article.getNickname();//작성자 이름
		String email = article.getEmail();//작성자 ID
		Date regdate = article.getRegdate();//작성일

		model.addAttribute("title", title);
		model.addAttribute("content", content);
		model.addAttribute("hit", hit);
		model.addAttribute("nickname", nickname);
		model.addAttribute("email", email);
		model.addAttribute("regdate", regdate);
		model.addAttribute("attachFileList", attachFileList);
		model.addAttribute("nextArticle", nextArticle);
		model.addAttribute("prevArticle", prevArticle);
		model.addAttribute("commentsList", commentsList);

		//목록관련
		int numPerPage = 10;//페이지당 레코드 수
		int pagePerBlock = 10;//블록당 페이지 링크수
		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		NumbersForPaging ints = this.getNumbersForPaging(totalRecord, curPage, numPerPage, pagePerBlock);
		Integer offset = ints.getOffset();
		List<Article> list = boardService.getArticleList(boardCd, searchWord, offset, numPerPage);

		Integer listItemNo = ints.getListItemNo();
		Integer prevPage = ints.getPrevPage();
		Integer nextPage = ints.getNextPage();
		Integer firstPage = ints.getFirstPage();
		Integer lastPage = ints.getLastPage();

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("boardName", boardName);

		return "bbs/view";
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String write(String boardCd, Locale locale, Model model) {
		String lang = locale.getLanguage();
		List<Board> boards = boardService.getBoards();
		String boardName = this.getBoardName(boardCd, lang);
		model.addAttribute("boards", boards);
		model.addAttribute("boardName", boardName);
		
		return "bbs/write";
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(Article article, 
			String curPage, 
			String searchWord, 
			Model model,
			Principal principal,
			HttpServletRequest req) {
		
		String email = principal.getName();
		article.setEmail(email);
		int endIndex = email.indexOf("@");
		String nickname = email.substring(0, endIndex);
		article.setNickname(nickname);
		
		boardService.addArticle(article);
		
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		List<BlobKey> blobKeys = blobs.get("attachFile");
		
		if (blobKeys != null && !blobKeys.isEmpty()) {
			BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
			BlobInfo blobInfo = null;
			int size = blobKeys.size();
			
			for (int i = 0;i < size;i++) {
				blobInfo = blobInfoFactory.loadBlobInfo(blobKeys.get(i));
				long filesize = blobInfo.getSize();
			
				if (filesize <= 0) {
					blobstoreService.delete(blobKeys.get(i));
					continue;
				}
				
				AttachFile attachFile = new AttachFile();
				String filekey = blobKeys.get(i).getKeyString();
				attachFile.setFilekey(filekey);
				attachFile.setFilename(blobInfo.getFilename());
				attachFile.setFiletype(blobInfo.getContentType());
				attachFile.setFilesize(filesize);
				attachFile.setCreation(blobInfo.getCreation());
				attachFile.setArticleNo(article.getArticleNo());
				attachFile.setEmail(principal.getName());
				boardService.addAttachFile(attachFile);
			}
			
		}
		
		return "redirect:/bbs/list?boardCd=" + article.getBoardCd() + 
				"&curPage=1&searchWord=";
	}
	
	@RequestMapping(value="/deleteAttachFile", method=RequestMethod.POST)
	public String deleteAttachFile(String filekey, 
			Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord,
			Principal principal) throws Exception {

		AttachFile currentAttachFile = boardService.getAttachFile(filekey);
		boardService.removeAttachFile(currentAttachFile);

		BlobKey blobKey = new BlobKey(filekey);
		blobstoreService.delete(blobKey);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}
	
	@RequestMapping(value="/deleteComments", method=RequestMethod.POST)
	public String deleteComments(Integer commentNo, 
			Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {

		Comments currentComments = boardService.getComments(commentNo);

		boardService.removeComments(currentComments);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}
	
	@RequestMapping(value="/addComments", method=RequestMethod.POST)
	public String addComment(Comments comments,
			String boardCd, 
			Integer curPage, 
			String searchWord,
			Principal principal) throws Exception {

		String email = principal.getName();
		comments.setEmail(email);
		
		int endIndex = email.indexOf("@");
		String nickname = email.substring(0, endIndex);
		comments.setNickname(nickname);
		
		boardService.addComments(comments);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/view?articleNo=" + comments.getArticleNo() + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;
	}
	
	@RequestMapping(value="/modifyComments", method=RequestMethod.POST)
	public String updateComment(Comments comments, 
			String boardCd, 
			Integer curPage, 
			String searchWord,
			Principal principal) throws Exception {

		Comments currentComments = boardService.getComments(comments.getCommentNo());
		currentComments.setMemo(comments.getMemo());
		boardService.modifyComments(currentComments); 

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/view?articleNo=" + comments.getArticleNo() + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;
	}
	
	//글 수정
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String modify(Integer articleNo, String boardCd, Locale locale, Model model) {
		Article article = boardService.getArticle(articleNo);

		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);

		String boardName = this.getBoardName(boardCd, locale.getLanguage());

		//수정페이지에서의 보일 게시글 정보
		model.addAttribute("article", article);
		model.addAttribute("boardName", boardName);

		return "bbs/modify";
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(Article article, Integer curPage, String searchWord, Model model, HttpServletRequest req) throws Exception {
		Article currentArticle = boardService.getArticle(article.getArticleNo());
		
		currentArticle.setTitle(article.getTitle());
		currentArticle.setContent(article.getContent());
		
		boardService.modifyArticle(currentArticle);

		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		List<BlobKey> blobKeys = blobs.get("attachFile");

		if (blobKeys != null && !blobKeys.isEmpty()) {
			BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
			BlobInfo blobInfo = null;
			int size = blobKeys.size();

			for (int i = 0;i < size;i++) {
				blobInfo = blobInfoFactory.loadBlobInfo(blobKeys.get(i));
				long filesize = blobInfo.getSize();
				if (filesize <= 0) {
					blobstoreService.delete(blobKeys.get(i));
					continue;
				}
				AttachFile attachFile = new AttachFile();
				String filekey = blobKeys.get(i).getKeyString();
				attachFile.setFilekey(filekey);
				attachFile.setFilename(blobInfo.getFilename());
				attachFile.setFiletype(blobInfo.getContentType());
				attachFile.setFilesize(filesize);
				attachFile.setCreation(blobInfo.getCreation());
				attachFile.setArticleNo(article.getArticleNo());
				attachFile.setEmail(currentArticle.getEmail());
				boardService.addAttachFile(attachFile);
			}

		}

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/view?articleNo=" + article.getArticleNo() 
				+ "&boardCd=" + article.getBoardCd() 
				+ "&curPage=" + curPage 
				+ "&searchWord=" + searchWord;

	}
	
	@RequestMapping(value="/deleteArticle", method=RequestMethod.POST)
	public String del(Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {
		
		Article currentArticle = boardService.getArticle(articleNo);

		boardService.removeArticle(currentArticle);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/list?boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;
	}

	/* 아래 메서드는 Blobstore 예제로 게시판이 완성되면 삭제하는 것이 좋다. */
	@RequestMapping(value="/upload", method=RequestMethod.GET)
	public String uploadForm() {
		return "bbs/upload";
	}
	
	@RequestMapping(value="/upload", method=RequestMethod.POST)
	public String upload(HttpServletRequest req) {
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		List<BlobKey> blobKeys = blobs.get("attachFile");
		if (blobKeys == null || blobKeys.isEmpty()) {
			return "bbs/upload";
		} else {
			return "redirect:/bbs/blob?blob-key=" + blobKeys.get(0).getKeyString();
		}
	}
	
	@RequestMapping(value="/blob", method=RequestMethod.GET)
	public String blob() {
		return "bbs/blob";
	}
	
/*	@RequestMapping(value="/deleteFile", method=RequestMethod.POST)
	public String deleteAttachFile(String filekey) throws Exception {
		BlobKey blobKey = new BlobKey(filekey);
		blobstoreService.delete(blobKey);
		AttachFile currentAttachFile = boardService.getAttachFile(filekey);
		boardService.removeAttachFile(currentAttachFile);
		return "redirect:/bbs/blob?blob-key=" + blobKey.getKeyString();
	}
*/
}