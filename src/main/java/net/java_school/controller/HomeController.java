package net.java_school.controller;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;

import net.java_school.blog.Article;
import net.java_school.blog.Category;

@Controller
public class HomeController {
	
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
		//log.info("HomePage");
		return "/";
	}

	@RequestMapping(value="/403")
	public String error403() {
		return "403";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();

		String url = UserServiceFactory.getUserService().createLogoutURL("/");

		response.sendRedirect(url);
	}
	
}