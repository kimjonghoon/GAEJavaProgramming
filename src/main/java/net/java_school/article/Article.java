package net.java_school.article;

import java.util.Date;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
@Cache
public class Article {
	@Parent Key<Category> theCategory;
	@Id public Long id;

	public String author_email;
	public String author_id;
	@Index public String title;
	public String keywords;
	public String description;
	public String content;
	public String content_ko;
	@Index public Date date;
	@Index public String path;
	@Index public int articleOrder;

	public Article() {
		date = new Date();
	}
	public Article(String category, String title, String keywords, String description, String content, String content_ko, String path, int articleOrder) {
		this();
		theCategory = Key.create(Category.class, category);
		this.title = title;
		this.keywords = keywords;
		this.description = description;
		this.content = content;
		this.path = path;
		this.articleOrder = articleOrder;
	}
	public Article(String category, String title, String keywords, String description, String content, String content_ko, String path, int articleOrder, String id, String email) {
		this(category, title, keywords, description, content, content_ko, path, articleOrder);
		author_email = email;
		author_id = id;
	}
	public Key<Article> getKey() {
		return Key.create(theCategory, Article.class, id);
	}
	public String getKeyString() {
		return getKey().toWebSafeString();
	}
	public Key<Category> getTheCategory() {
		return theCategory;
	}
	public void setTheCategory(Key<Category> theCategory) {
		this.theCategory = theCategory;
	}
	public String getAuthor_email() {
		return author_email;
	}
	public void setAuthor_email(String author_email) {
		this.author_email = author_email;
	}
	public String getAuthor_id() {
		return author_id;
	}
	public void setAuthor_id(String author_id) {
		this.author_id = author_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContent_ko() {
		return content_ko;
	}
	public void setContent_ko(String content_ko) {
		this.content_ko = content_ko;
	}
	public Date getDate() {
		return date;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getArticleOrder() {
		return articleOrder;
	}
	public void setArticleOrder(int articleOrder) {
		this.articleOrder = articleOrder;
	}
	
}