package net.java_school.controller;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.googlecode.objectify.Key;

import net.java_school.blog.Article;
import net.java_school.blog.Category;
import net.java_school.blog.Lang;

@Controller
public class DatastoreBlogController {

	@RequestMapping(value="datastore/{category}/{id}", method=RequestMethod.GET)
	public String blog(@PathVariable("category") String category, @PathVariable("id") String id, Locale locale, Model model) {
		String lang = locale.getLanguage();
		Key<Lang> theLang = Key.create(Lang.class, lang);
		Key<Category> categoryKey = Key.create(theLang, Category.class, category);    
		Key<Article> articleKey = Key.create(categoryKey, Article.class, id);

		Article article = ofy().load().key(articleKey).now();

		if (article == null) return "redirect:/";

		model.addAttribute("title", article.title);
		model.addAttribute("keywords", article.keywords);
		model.addAttribute("description", article.description);
		model.addAttribute("content", article.content);

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