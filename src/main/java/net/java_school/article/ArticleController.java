package net.java_school.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.HashMap;
import java.util.List;

@Controller
public class ArticleController {
	public static final HashMap<String,String> map = new HashMap<String,String>();
	static {
		map.put("java", "Java");
		map.put("jdbc", "JDBC");
		map.put("jsp", "JSP");
		map.put("css-layout", "CSS Layout");
		map.put("jsp-pjt", "JSP Project");
		map.put("spring", "Spring");
		map.put("javascript", "JavaScript");
	}
	
	@RequestMapping(value="article/list", method=RequestMethod.GET)
	public String list(String category, Model model) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) {
			return "redirect:/";
		}
		if (category == null) category = "java";
		Key<Category> theCategory = Key.create(Category.class, category);
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.ancestor(theCategory)
				.project("title")
				.project("path")
				.order("articleOrder")
				.list();
		
		model.addAttribute("articles", articles);
		model.addAttribute("category", category);
		return "article/list";
	}	
	@RequestMapping(value="article/new", method=RequestMethod.POST)
	public String writeArticle(HttpServletRequest req, 
			HttpServletResponse resp) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) {
			return "redirect:/";
		}
		Article article = null;
		String category = req.getParameter("category");
		String title = req.getParameter("title");
		String keywords = req.getParameter("keywords");
		String description = req.getParameter("description");
		String content = req.getParameter("content");
		String content_ko = req.getParameter("content_ko");
		String path = req.getParameter("path");
		int articleOrder = Integer.parseInt(req.getParameter("articleOrder"));
		article = new Article(category, title, keywords, description, content, content_ko, 
				path, articleOrder, user.getUserId(), user.getEmail());
		ofy().save().entity(article).now();
		return "redirect:/article/list?category=" + category;
	}
	@RequestMapping(value="article/modify", method=RequestMethod.GET)
	public String modifyForm(String webSafeString, Model model) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) {
			return "redirect:/";
		}
		Key<Article> key = Key.create(webSafeString);
		Article article = ofy()
				.load()
				.key(key)
				.now();
		model.addAttribute("title", article.title);
		model.addAttribute("keywords", article.keywords);
		model.addAttribute("description", article.description);
		model.addAttribute("content", article.content);
		model.addAttribute("path", article.path);
		model.addAttribute("category", article.theCategory.getName());
		model.addAttribute("articleOrder", article.articleOrder);
		model.addAttribute("webSafeString", webSafeString);
		return "article/modify";
	}
	@RequestMapping(value="article/modify", method=RequestMethod.POST)
	public String modify(String title, String keywords, 
			String description, String content, String content_ko, String path, 
			String category, String webSafeString, int articleOrder, Model model) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) {
			return "redirect:/";
		}
		Key<Article> key = Key.create(webSafeString);
		Article article = new Article(category, title, keywords, 
				description, content, content_ko, path, articleOrder);
		article.id = key.getId();
		ofy().save().entity(article).now();
		return "redirect:/" + category + "/" + path;
	}
	@RequestMapping(value="article/delete", method=RequestMethod.POST)
	public String del(String webSafeString, Model model) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) {
			return "redirect:/";
		}
		Key<Article> key = Key.create(webSafeString);
		ofy().delete().key(key).now();
		return "redirect:/article/list";
	}	
	@RequestMapping(value="{category}/{path}", method=RequestMethod.GET)
	public String article(@PathVariable("category") String category, 
			@PathVariable("path") String path, Model model) {
		Article article = ofy()
				.load()
				.type(Article.class)
				.filter("path", path)
				.first()
				.now();
		model.addAttribute("title", article.title);
		model.addAttribute("keywords", article.keywords);
		model.addAttribute("description", article.description);
		model.addAttribute("content", article.content);
		model.addAttribute("date", article.date);
		
		//추가
		Key<Category> theCategory = Key.create(Category.class, category);
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.ancestor(theCategory)
				.project("title")
				.project("path")
				.order("articleOrder")
				.list();
		model.addAttribute("articles", articles);
		model.addAttribute("category", category);
		String chapterTitle = map.get(category);
		model.addAttribute("chapterTitle", chapterTitle);
		
		//추가
		int prevNo = article.articleOrder - 1;
		int nextNo = article.articleOrder + 1;
		Article prev = ofy()
				.load()
				.type(Article.class)
				.ancestor(theCategory)
				.filter("articleOrder", prevNo)
				.project("title")
				.project("path")
				.first()
				.now();
		Article next = ofy()
				.load()
				.type(Article.class)
				.ancestor(theCategory)
				.filter("articleOrder", nextNo)
				.project("title")
				.project("path")
				.first()
				.now();
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		
		return category + "/" + path;
	}
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home(Model model) {
		Article article = ofy()
				.load()
				.type(Article.class)
				.order("-date")
				.first()
				.now();
		if (article != null) {
			model.addAttribute("title", article.title);
			model.addAttribute("keywords", article.keywords);
			model.addAttribute("description", article.description);
			model.addAttribute("content", article.content);
			model.addAttribute("date", article.date);
		}
		return "/";
	}
}