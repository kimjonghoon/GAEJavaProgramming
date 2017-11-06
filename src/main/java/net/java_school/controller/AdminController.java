package net.java_school.controller;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import net.java_school.bbs.Board;
import net.java_school.bbs.BoardService;
import net.java_school.blog.Article;
import net.java_school.blog.Category;
import net.java_school.blog.Lang;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.googlecode.objectify.Key;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private BoardService boardService;
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String index(Model model) {
		List<Board> list = boardService.getAllBoards();
		model.addAttribute("list", list);
		
		return "admin/index";
	}
	
	@RequestMapping(value="/createBoard", method=RequestMethod.POST)
	public String createBoard(Board board) {
		boardService.addBoard(board);
		
		return "redirect:/admin/";
	}

	@RequestMapping(value="/editBoard", method=RequestMethod.POST)
	public String editBoard(Board board) {
		boardService.editBoard(board);
		
		return "redirect:/admin/";
	}
	@RequestMapping(value="/new", method=RequestMethod.GET)
	public String postBlog() {
		return "admin/new";
	}
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public String postBlog(Article article, String category, Locale locale, Principal principal) {
		String lang = locale.getLanguage();
		Key<Lang> theLang = Key.create(Lang.class, lang);
		Key<Category> theCategory = Key.create(theLang, Category.class, category);
		article.setTheCategory(theCategory);
		article.setOwner(principal.getName());
		
		Date today = new Date();
		article.setDate(today);
		article.setLastModified(today);
		
		ofy().save().entity(article).now();

		return "redirect:/admin/list";
	}
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String blogs(Model model) {
		
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.order("date")
				.list();
		
		model.addAttribute("articles", articles);

		return "admin/list";
	}
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String modifyBlog(String webSafeString, Model model) {
		Key<Article> key = Key.create(webSafeString);
		Article article = ofy()
				.load()
				.key(key)
				.now();
		model.addAttribute("article", article);

		return "admin/modify";
	}
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modifyBlog(Article article, String webSafeString) {
		Key<Article> key = Key.create(webSafeString);
		Article storedArticle = ofy()
				.load()
				.key(key)
				.now();
		
		storedArticle.setTitle(article.getTitle());
		storedArticle.setKeywords(article.getKeywords());
		storedArticle.setDescription(article.getDescription());
		storedArticle.setContent(article.getContent());
		storedArticle.setLastModified(new Date());
		
		ofy().save().entity(storedArticle).now();

		return "redirect:/admin/list";
	}
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delBlog(String webSafeString) {
		Key<Article> key = Key.create(webSafeString);
		ofy().delete().key(key).now();

		return "redirect:/admin/list";
	}
	
}