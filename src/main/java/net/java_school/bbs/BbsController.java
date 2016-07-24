package net.java_school.bbs;

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

@Controller
@RequestMapping("bbs")
public class BbsController {
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	private BoardService boardService;
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String list(Model model) {
		List<Board> boards = boardService.getAllBoard();
		model.addAttribute("boards", boards);
		return "bbs/list";
	}
	@RequestMapping(value="view", method=RequestMethod.GET)
	public String view(Model model) {
		List<Board> boards = boardService.getAllBoard();
		model.addAttribute("boards", boards);
		return "bbs/view";
	}
	@RequestMapping(value="write", method=RequestMethod.GET)
	public String write(String boardCd, Model model) {
		List<Board> boards = boardService.getAllBoard();
		String boardNm = boardService.getBoardNm(boardCd);
		model.addAttribute("boards", boards);
		model.addAttribute("boardNm", boardNm);
		return "bbs/write";
	}
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public String modify(Model model) {
		List<Board> boards = boardService.getAllBoard();
		model.addAttribute("boards", boards);
		return "bbs/modify";
	}
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

	@RequestMapping(value="/deleteFile", method=RequestMethod.POST)
	public String deleteAttachFile(String filekey) throws Exception {
		BlobKey blobKey = new BlobKey(filekey);
		blobstoreService.delete(blobKey);
		boardService.removeAttachFile(filekey);
		return "redirect:/bbs/blob?blob-key=" + blobKey.getKeyString();
	}
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(Article article, Model model, HttpServletRequest req) {
		article.setEmail("tester@tester.org");
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
				attachFile.setEmail("tester@tester.org");
				boardService.addAttachFile(attachFile);
			}
		}
		return "redirect:/bbs/write?boardCd=" + article.getBoardCd();
	}	

}