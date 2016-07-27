package net.java_school.blog;

import java.util.Date;
import java.util.List;

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

@Controller
public class BlogController {
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home() {
		return "/";
	}

	@RequestMapping(value="java/JDK-Install", method=RequestMethod.GET)
	public String javaInstall() {
		return "java/JDK-Install";
	}

	@RequestMapping(value="blog/new", method=RequestMethod.GET)
	public String postBlog() {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) return "redirect:/"; 
		return "blog/new";
	}

	@RequestMapping(value="blog/new", method=RequestMethod.POST)
	public String postBlog(Article article) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) return "redirect:/"; 
		if (user != null) {
			article.setAuthor_id(user.getUserId());
			article.setAuthor_email(user.getEmail());
		}
		Date today = new Date();
		article.setDate(today);
		article.setLastModified(today);
		ofy().save().entity(article).now();
		return "redirect:/blog/list";
	}

	@RequestMapping(value="{category}/{id}", method=RequestMethod.GET)
	public String blog(@PathVariable("category") String category, 
			@PathVariable("id") String id, Model model) {
		Key<Category> categoryKey = Key.create(Category.class, category);    
		Key<Article> articleKey = Key.create(categoryKey, Article.class, id);
		Article article = ofy().load().key(articleKey).now();
		model.addAttribute("title", article.title);
		model.addAttribute("keywords", article.keywords);
		model.addAttribute("description", article.description);
		model.addAttribute("content", article.content);
		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.ancestor(categoryKey)
				.project("title")
				.order("order")
				.list();
		model.addAttribute("articles", articles);
		return category + "/" + id;
	}
	@RequestMapping(value="blog/list", method=RequestMethod.GET)
	public String blogs(Model model) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) return "redirect:/"; 
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
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) return "redirect:/"; 

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
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) return "redirect:/"; 

		Key<Article> key = Key.create(webSafeString);
		Article storedArticle = ofy()
				.load()
				.key(key)
				.now();
		article.setDate(storedArticle.getDate());
		article.setLastModified(new Date());
	    ofy().save().entity(article).now();
	    return "redirect:/" + article.getCategory() + "/" + article.getId();
	}
	@RequestMapping(value="blog/delete", method=RequestMethod.POST)
	public String delBlog(String webSafeString) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user == null || !userService.isUserAdmin()) return "redirect:/"; 

		Key<Article> key = Key.create(webSafeString);
	    ofy().delete().key(key).now();
	    return "redirect:/blog/list";
	}
	
}
