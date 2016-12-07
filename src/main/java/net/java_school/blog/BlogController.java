package net.java_school.blog;

import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;

import static com.googlecode.objectify.ObjectifyService.ofy;

@Controller
public class BlogController {
	private static final Logger log = Logger.getLogger(BlogController.class.getName());

	@RequestMapping(value="{category}/{path}", method=RequestMethod.GET)
	public String java(@PathVariable("category") String category, @PathVariable("path") String path, Locale locale, Model model) {
		String lang = locale.getLanguage();
		Key<Lang> theLang = Key.create(Lang.class, lang);
		Key<Category> theCategory = Key.create(theLang, Category.class, category);
		
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.ancestor(theCategory)
				.project("title")
				.order("date")
				.list();
		
		model.addAttribute("articles", articles);
		
		return category + "/" + path;
	}
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();

		String url = UserServiceFactory.getUserService().createLogoutURL("/");

		response.sendRedirect(url);
	}
	@RequestMapping(value="/403")
	public String error403() {
		return "403";
	}
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home(Model model) {
		//3장 데이터스토어를 이용하는 블로그와 통합
		Key<Category> categoryKey = Key.create(Category.class, "home");    
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.ancestor(categoryKey)
				.project("title")
				.order("order")
				.list();
		model.addAttribute("articles", articles);

		return "/";
	}
	@RequestMapping(value="blog/new", method=RequestMethod.GET)
	public String postBlog() {
		return "blog/new";
	}
	@RequestMapping(value="blog/new", method=RequestMethod.POST)
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

		return "redirect:/blog/list";
	}
	@RequestMapping(value="blog/list", method=RequestMethod.GET)
	public String blogs(Model model) {
		
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.order("date")
				.list();
		
		model.addAttribute("articles", articles);

		return "blog/list";
	}
	@RequestMapping(value="blog/modify", method=RequestMethod.GET)
	public String modifyBlog(String webSafeString, Model model) {
		Key<Article> key = Key.create(webSafeString);
		Article article = ofy()
				.load()
				.key(key)
				.now();
		model.addAttribute("article", article);

		return "blog/modify";
	}
	@RequestMapping(value="blog/modify", method=RequestMethod.POST)
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

		return "redirect:/blog/list";
	}
	@RequestMapping(value="blog/delete", method=RequestMethod.POST)
	public String delBlog(String webSafeString) {
		Key<Article> key = Key.create(webSafeString);
		ofy().delete().key(key).now();

		return "redirect:/blog/list";
	}
	//3장 데이터스토어 이용한 블로그
	@RequestMapping(value="datastore/{category}/{id}", method=RequestMethod.GET)
	public String blog(@PathVariable("category") String category, @PathVariable("id") String id, Locale locale, Model model) {
		String lang = locale.getLanguage();
		log.info("lang: " + lang);
		Key<Lang> theLang = Key.create(Lang.class, lang);
		Key<Category> categoryKey = Key.create(theLang, Category.class, category);    
		Key<Article> articleKey = Key.create(categoryKey, Article.class, id);
		
		Article article = ofy().load().key(articleKey).now();
		
		model.addAttribute("title", article.title);
		model.addAttribute("keywords", article.keywords);
		model.addAttribute("description", article.description);
		model.addAttribute("content", article.content);
		//model.addAttribute("content_ko", article.content_ko);
		
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.ancestor(categoryKey)
				.project("title")
				.order("date")
				.list();
		
		model.addAttribute("articles", articles);

		return "datastore/" + category + "/" + id;
	}
}