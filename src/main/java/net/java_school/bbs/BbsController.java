package net.java_school.bbs;

import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.java_school.commons.NumbersForPaging;
import net.java_school.commons.NumberGeneratorForPaging;
import net.java_school.spring.security.GaeUserAuthentication;
import net.java_school.user.GaeUser;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import javax.validation.Valid;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/bbs")
public class BbsController extends NumberGeneratorForPaging {

    private final BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
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

    @GetMapping("/list")
    public String list(String boardCd, Integer page, String searchWord, Locale locale, Model model) {
        String lang = locale.getLanguage();
        List<Board> boards = boardService.getAllBoards();
        model.addAttribute("boards", boards);

        String boardName = this.getBoardName(boardCd, lang);

        int numPerPage = 20;
        int pagePerBlock = 10;
        int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
        NumbersForPaging ints = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);
        Integer offset = ints.getOffset();
        List<Article> list = boardService.getArticleList(boardCd, searchWord, offset, numPerPage);

        Integer listItemNo = ints.getListItemNo();
        Integer prevPage = ints.getPrevPage();
        Integer nextPage = ints.getNextPage();
        Integer firstPage = ints.getFirstPage();
        Integer lastPage = ints.getLastPage();
        Integer totalPage = ints.getTotalPage();

        model.addAttribute("list", list);
        model.addAttribute("boardName", boardName);
        model.addAttribute("title", boardName);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        model.addAttribute("totalPage", totalPage);

        return "bbs/list";
    }

    @GetMapping("/view")
    public String view(Integer articleNo,
            String boardCd,
            Integer page,
            String searchWord,
            Locale locale,
            Model model) {

        String lang = locale.getLanguage();
        List<Board> boards = boardService.getAllBoards();
        model.addAttribute("boards", boards);

        boardService.increaseHit(articleNo);

        Article article = boardService.getArticle(articleNo);//article in the view.jsp
        List<AttachFile> attachFileList = boardService.getAttachFileList(articleNo);
        Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
        Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
        List<Comments> commentsList = boardService.getCommentsList(articleNo);
        String boardName = this.getBoardName(boardCd, lang);

        //Informations in the view.jsp
        String title = article.getTitle();
        String content = article.getContent();
        int hit = article.getHit();
        String nickname = article.getNickname();
        String owner = article.getOwner();
        Date regdate = article.getRegdate();

        model.addAttribute("title", title);
        model.addAttribute("content", content);
        model.addAttribute("hit", hit);
        model.addAttribute("nickname", nickname);
        model.addAttribute("owner", owner);
        model.addAttribute("regdate", regdate);
        model.addAttribute("attachFileList", attachFileList);
        model.addAttribute("nextArticle", nextArticle);
        model.addAttribute("prevArticle", prevArticle);
        model.addAttribute("commentsList", commentsList);

        //list
        int numPerPage = 20;//record number per page
        int pagePerBlock = 10;//page number per block
        int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
        NumbersForPaging ints = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);
        Integer offset = ints.getOffset();
        List<Article> list = boardService.getArticleList(boardCd, searchWord, offset, numPerPage);

        Integer listItemNo = ints.getListItemNo();
        Integer prevPage = ints.getPrevPage();
        Integer nextPage = ints.getNextPage();
        Integer firstPage = ints.getFirstPage();
        Integer lastPage = ints.getLastPage();
        Integer totalPage = ints.getTotalPage();

        model.addAttribute("list", list);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("boardName", boardName);
        model.addAttribute("totalPage", totalPage);

        return "bbs/view";
    }

    @GetMapping("/write")
    public String write(String boardCd, Locale locale, Model model) {
        String lang = locale.getLanguage();
        List<Board> boards = boardService.getAllBoards();
        String boardName = this.getBoardName(boardCd, lang);
        model.addAttribute("boards", boards);
        model.addAttribute("boardName", boardName);
        model.addAttribute("title", boardName);
        model.addAttribute("article", new Article());

        return "bbs/write";
    }

    @PostMapping("/write")
    public String write(@Valid Article article,
            BindingResult bindingResult,
            String page,
            String searchWord,
            Locale locale,
            Model model,
            GaeUserAuthentication gaeUserAuthentication,
            HttpServletRequest req) {
        
        if (bindingResult.hasErrors()) {
            String lang = locale.getLanguage();
            List<Board> boards = boardService.getAllBoards();
            String boardName = this.getBoardName(article.getBoardCd(), lang);
            model.addAttribute("boards", boards);
            model.addAttribute("boardName", boardName);
            model.addAttribute("title", boardName);
            
            return "bbs/write";
        }

        GaeUser gaeUser = (GaeUser) gaeUserAuthentication.getPrincipal();

        String email = gaeUser.getEmail();
        article.setOwner(email);
        article.setNickname(gaeUser.getNickname());

        boardService.addArticle(article);

        return "redirect:/bbs/list?boardCd=" + article.getBoardCd()
                + "&page=1&searchWord=";
    }

    @PostMapping("/upload")
    public String upload(Integer articleNo, String boardCd, Integer page, String searchWord, HttpServletRequest req) {
        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("attachFile");

        if (blobKeys != null && !blobKeys.isEmpty()) {
            BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
            int size = blobKeys.size();

            for (int i = 0; i < size; i++) {
                BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(blobKeys.get(i));
                AttachFile attachFile = new AttachFile();
                String filekey = blobKeys.get(i).getKeyString();
                attachFile.setFilekey(filekey);
                attachFile.setFilename(blobInfo.getFilename());
                attachFile.setFiletype(blobInfo.getContentType());
                attachFile.setFilesize(blobInfo.getSize());
                attachFile.setCreation(blobInfo.getCreation());
                attachFile.setArticleNo(articleNo);
                Article article = boardService.getArticle(articleNo);
                attachFile.setOwner(article.getOwner());
                boardService.addAttachFile(attachFile);
            }
        }

        return "redirect:/bbs/view?articleNo=" + articleNo
                + "&boardCd=" + boardCd
                + "&page=" + page
                + "&searchWord=" + searchWord;
        
    }
    
    @PostMapping("/deleteAttachFile")
    public String deleteAttachFile(String filekey,
            Integer articleNo,
            String boardCd,
            Integer page,
            String searchWord) throws Exception {

        AttachFile currentAttachFile = boardService.getAttachFile(filekey);
        boardService.removeAttachFile(currentAttachFile);

        BlobKey blobKey = new BlobKey(filekey);
        blobstoreService.delete(blobKey);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");

        return "redirect:/bbs/view?articleNo=" + articleNo
                + "&boardCd=" + boardCd
                + "&page=" + page
                + "&searchWord=" + searchWord;

    }

    @PostMapping("/deleteComments")
    public String deleteComments(Integer commentNo,
            Integer articleNo,
            String boardCd,
            Integer page,
            String searchWord) throws Exception {

        Comments currentComments = boardService.getComments(commentNo);

        boardService.removeComments(currentComments);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");

        return "redirect:/bbs/view?articleNo=" + articleNo
                + "&boardCd=" + boardCd
                + "&page=" + page
                + "&searchWord=" + searchWord;

    }

    @PostMapping("/addComments")
    public String addComment(Comments comments,
            String boardCd,
            Integer page,
            String searchWord,
            GaeUserAuthentication gaeUserAuthentication) throws Exception {

        GaeUser gaeUser = (GaeUser) gaeUserAuthentication.getPrincipal();

        comments.setOwner(gaeUser.getEmail());
        comments.setNickname(gaeUser.getNickname());

        boardService.addComments(comments);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");

        return "redirect:/bbs/view?articleNo=" + comments.getArticleNo()
                + "&boardCd=" + boardCd
                + "&page=" + page
                + "&searchWord=" + searchWord;
    }

    @PostMapping("/modifyComments")
    public String updateComment(Comments comments,
            String boardCd,
            Integer page,
            String searchWord) throws Exception {

        Comments currentComments = boardService.getComments(comments.getCommentNo());
        currentComments.setMemo(comments.getMemo());
        boardService.modifyComments(currentComments);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");

        return "redirect:/bbs/view?articleNo=" + comments.getArticleNo()
                + "&boardCd=" + boardCd
                + "&page=" + page
                + "&searchWord=" + searchWord;
    }

    @GetMapping("/modify")
    public String modify(Integer articleNo, String boardCd, Locale locale, Model model) {
        Article article = boardService.getArticle(articleNo);

        List<Board> boards = boardService.getAllBoards();
        model.addAttribute("boards", boards);

        String boardName = this.getBoardName(boardCd, locale.getLanguage());

        model.addAttribute("article", article);
        model.addAttribute("boardName", boardName);
        model.addAttribute("title", boardName);

        return "bbs/modify";
    }

    @PostMapping("/modify")
    public String modify(@Valid Article article,
            BindingResult bindingResult,
            Integer page, 
            String searchWord,
            Locale locale,
            Model model, 
            HttpServletRequest req) throws Exception {
        
        if (bindingResult.hasErrors()) {
            List<Board> boards = boardService.getAllBoards();
            model.addAttribute("boards", boards);
            String boardName = this.getBoardName(article.getBoardCd(), locale.getLanguage());
            model.addAttribute("article", article);
            model.addAttribute("boardName", boardName);
            model.addAttribute("title", boardName);

            return "bbs/modify";            
        }
        
        Article currentArticle = boardService.getArticle(article.getArticleNo());

        currentArticle.setTitle(article.getTitle());
        currentArticle.setContent(article.getContent());

        boardService.modifyArticle(currentArticle);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");

        return "redirect:/bbs/view?articleNo=" + article.getArticleNo()
                + "&boardCd=" + article.getBoardCd()
                + "&page=" + page
                + "&searchWord=" + searchWord;

    }

    @PostMapping("/deleteArticle")
    public String del(Integer articleNo,
            String boardCd,
            Integer page,
            String searchWord) throws Exception {

        Article currentArticle = boardService.getArticle(articleNo);

        boardService.removeArticle(currentArticle);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");

        return "redirect:/bbs/list?boardCd=" + boardCd
                + "&page=" + page
                + "&searchWord=" + searchWord;
    }

    /*
    @PostMapping("/upload")
    public String upload(HttpServletRequest req) {
        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("attachFile");
        if (blobKeys == null || blobKeys.isEmpty()) {
            return "bbs/upload";
        } else {
            return "redirect:/bbs/blob?blob-key=" + blobKeys.get(0).getKeyString();
        }
    }
    */

}