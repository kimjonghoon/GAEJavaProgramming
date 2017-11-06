package net.java_school.controller;

import java.util.List;
import java.util.Locale;
//import java.util.logging.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.googlecode.objectify.Key;

import net.java_school.blog.Article;
import net.java_school.blog.Category;
import net.java_school.blog.Lang;

import static com.googlecode.objectify.ObjectifyService.ofy;

@Controller
public class LectureController {
	//private static final Logger log = Logger.getLogger(LectureController.class.getName());

	@RequestMapping(value="{category}/{article}", method=RequestMethod.GET)
	public String java(@PathVariable("category") String category, @PathVariable("article") String article, Locale locale, Model model) {
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

		return category + "/" + article;
	}

}