package net.java_school.bbs;

import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.java_school.bbs.BoardService;

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
@RequestMapping("bbs")
public class BbsController {
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	private BoardService boardService;

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String list(String boardCd, Integer curPage, String searchWord, Model model) {
		List<Board> boards = boardService.getAllBoard();
		model.addAttribute("boards", boards);

		int numPerPage = 10;
		int pagePerBlock = 10;
		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		PagingHelper pagingHelper = new PagingHelper(totalRecord, curPage, numPerPage, pagePerBlock);
		boardService.setPagingHelper(pagingHelper);
		List<Article> list = boardService.getArticleList(boardCd, searchWord);
		String boardNm = boardService.getBoardNm(boardCd);
		Integer listItemNo = pagingHelper.getListItemNo();
		Integer prevPage = pagingHelper.getPrevPage();
		Integer nextPage = pagingHelper.getNextPage();
		Integer firstPage = pagingHelper.getFirstPage();
		Integer lastPage = pagingHelper.getLastPage();

		model.addAttribute("list", list);
		model.addAttribute("boardNm", boardNm);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);

		return "bbs/list";
	}

	@RequestMapping(value="view", method=RequestMethod.GET)
	public String view(Integer articleNo, 
			String boardCd, 
			Integer curPage,
			String searchWord,
			Model model) {

		List<Board> boards = boardService.getAllBoard();
		model.addAttribute("boards", boards);

		boardService.increaseHit(articleNo);

		Article article = boardService.getArticle(articleNo);//상세보기에서 볼 게시글
		List<AttachFile> attachFileList = boardService.getAttachFileList(articleNo);
		Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
		Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
		List<Comments> commentsList = boardService.getCommentsList(articleNo);
		String boardNm = boardService.getBoardNm(boardCd);

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
		PagingHelper pagingHelper = new PagingHelper(totalRecord, curPage, numPerPage, pagePerBlock);
		boardService.setPagingHelper(pagingHelper);

		List<Article> list = boardService.getArticleList(boardCd, searchWord);

		int listItemNo = pagingHelper.getListItemNo();
		int prevPage = pagingHelper.getPrevPage();
		int nextPage = pagingHelper.getNextPage();
		int firstPage = pagingHelper.getFirstPage();
		int lastPage = pagingHelper.getLastPage();

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("boardNm", boardNm);

		return "bbs/view";
	}
	@RequestMapping(value="write", method=RequestMethod.GET)
	public String write(String boardCd, Model model) {
		//로그인되지 않은 사용자는 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";
		
		List<Board> boards = boardService.getAllBoard();
		String boardNm = boardService.getBoardNm(boardCd);
		model.addAttribute("boards", boards);
		model.addAttribute("boardNm", boardNm);
		return "bbs/write";
	}
	@RequestMapping(value="write", method=RequestMethod.POST)
	public String write(Article article, 
			String curPage, 
			String searchWord, 
			Model model, 
			HttpServletRequest req) {
		
		//로그인되지 않은 사용자는 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";

		article.setEmail(user.getEmail());
		article.setNickname(user.getNickname());
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
				attachFile.setEmail(user.getEmail());
				boardService.addAttachFile(attachFile);
			}
		}
		return "redirect:/bbs/list?boardCd=" + article.getBoardCd() + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;
	}
	@RequestMapping(value="deleteAttachFile", method=RequestMethod.POST)
	public String deleteAttachFile(String filekey, 
			Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {

		//작성자나 관리자가 아니면 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";
		AttachFile currentAttachFile = boardService.getAttachFile(filekey);
		if (!user.getEmail().equals(currentAttachFile.getEmail())) {
			if (!userService.isUserAdmin()) return "redirect:/";
		}

		BlobKey blobKey = new BlobKey(filekey);
		blobstoreService.delete(blobKey);
		boardService.removeAttachFile(filekey);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}
	@RequestMapping(value="deleteComments", method=RequestMethod.POST)
	public String deleteComments(Integer commentNo, 
			Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {

		//작성자나 관리자가 아니면 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";
		Comments currentComments = boardService.getComments(commentNo);
		if (!user.getEmail().equals(currentComments.getEmail())) {
			if (!userService.isUserAdmin()) return "redirect:/";
		}

		boardService.removeComments(commentNo);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}
	@RequestMapping(value="addComments", method=RequestMethod.POST)
	public String addComment(Comments comments,
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {

		//로그인되지 않은 사용자는 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";

		comments.setEmail(user.getEmail());
		comments.setNickname(user.getNickname());
		boardService.addComments(comments);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/view?articleNo=" + comments.getArticleNo() + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;
	}
	@RequestMapping(value="modifyComments", method=RequestMethod.POST)
	public String updateComment(Comments comments, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {

		//작성자나 관리자가 아니면 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";
		Comments currentComments = boardService.getComments(comments.getCommentNo());
		if (!user.getEmail().equals(currentComments.getEmail())) {
			if (!userService.isUserAdmin()) return "redirect:/";
		}
		
		boardService.modifyComments(comments);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/view?articleNo=" + comments.getArticleNo() + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;
	}
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public String modify(Integer articleNo, String boardCd, Model model) {
		//작성자나 관리자가 아니면 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";
		Article currentArticle = boardService.getArticle(articleNo);
		if (!user.getEmail().equals(currentArticle.getEmail())) {
			if (!userService.isUserAdmin()) return "redirect:/";
		}
		
		List<Board> boards = boardService.getAllBoard();
		model.addAttribute("boards", boards);

		String boardNm = boardService.getBoardNm(boardCd);

		//수정페이지에서의 보일 게시글 정보
		model.addAttribute("article", currentArticle);
		model.addAttribute("boardNm", boardNm);

		return "bbs/modify";
	}
	@RequestMapping(value="modify", method=RequestMethod.POST)
	public String modify(Article article,
			Integer curPage, String searchWord, Model model, 
			HttpServletRequest req) throws Exception {
		//작성자나 관리자가 아니면 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";
		Article currentArticle = boardService.getArticle(article.getArticleNo());
		if (!user.getEmail().equals(currentArticle.getEmail())) {
			if (!userService.isUserAdmin()) return "redirect:/";
		}

		boardService.modifyArticle(article);

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
				attachFile.setEmail(article.getEmail());
				boardService.addAttachFile(attachFile);
			}

		}

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/view?articleNo=" + article.getArticleNo() 
				+ "&boardCd=" + article.getBoardCd() 
				+ "&curPage=" + curPage 
				+ "&searchWord=" + searchWord;

	}
	@RequestMapping(value="deleteArticle", method=RequestMethod.POST)
	public String del(Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {
		//작성자나 관리자가 아니면 홈페이지로 리다이렉트
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null) return "redirect:/";
		Article currentArticle = boardService.getArticle(articleNo);
		if (!user.getEmail().equals(currentArticle.getEmail())) {
			if (!userService.isUserAdmin()) return "redirect:/";
		}
		
		boardService.removeArticle(articleNo);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/list?boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;
	}
	
	/* 아래 메서드는 Blobstore 예제로 게시판이 완성되면 삭제하는 것이 좋다. */
	@RequestMapping(value="upload", method=RequestMethod.GET)
	public String uploadForm() {
		return "bbs/upload";
	}
	@RequestMapping(value="upload", method=RequestMethod.POST)
	public String upload(HttpServletRequest req) {
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		List<BlobKey> blobKeys = blobs.get("attachFile");
		if (blobKeys == null || blobKeys.isEmpty()) {
			return "bbs/upload";
		} else {
			return "redirect:/bbs/blob?blob-key=" + blobKeys.get(0).getKeyString();
		}
	}
	@RequestMapping(value="blob", method=RequestMethod.GET)
	public String blob() {
		return "bbs/blob";
	}
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	public String deleteAttachFile(String filekey) throws Exception {
		BlobKey blobKey = new BlobKey(filekey);
		blobstoreService.delete(blobKey);
		boardService.removeAttachFile(filekey);
		return "redirect:/bbs/blob?blob-key=" + blobKey.getKeyString();
	}

}