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
	public static final String[][] LINK_TITLE =  {
		//JAVA
		{"java/JDK-Install","JDK Install","Java"},
		{"java/Features","Java Features","Java"},
		{"java/Class-Object","Class and Object","Java"},
		{"java/Keyword_Indentifiers_Comment","Indentifiers","Java"},
		{"java/DataType_Casting","Data Type","Java"},
		{"java/Arrays","Arrays","Java"},
		{"java/Operators","Operators","Java"},
		{"java/if_switch_loops","if, switch, loops","Java"},
		{"java/Package_Modifiers","Package, Modifiers","Java"},
		{"java/Inheritance","Inheritance","Java"},
		{"java/Static","Static","Java"},
		{"java/Collection","Collection","Java"},
		{"java/Exception","Exception","Java"},
		{"java/Javabank-Requirements-analysis","Javabank Requirements analysis","Java"},
		{"java/Javabank-Design","Javabank Design","Java"},
		{"java/Javabank-Apply-inheritance","Javabank inheritance","Java"},
		{"java/Javabank-Apply-abstract-class","Javabank Abstract Class","Java"},
		{"java/Javabank-Apply-interface","Javabank Interface","Java"},
		{"java/Thread","Thread","Java"},
		{"java/Stream","Stream","Java"},
		{"java/Logging","Logging","Java"},
		{"java/Socket","Socket","Java"},
		{"java/RMI","RMI","Java"},
		//JDBC
		{"jdbc/JDBC-Intro","JDBC 소개","JDBC"},
		{"jdbc/How-to-install-Oracle","오라클 설치","JDBC"},
		{"jdbc/Login-to-the-scott-account","SQL 연습-SCOTT 계정","JDBC"},
		{"jdbc/SQL-SELECT-Statement","SQL 연습-SELECT","JDBC"},
		{"jdbc/SQL-DML-Statement","SQL 연습-DML","JDBC"},
		{"jdbc/Oracle-JDBC-Test","오라클 JDBC 테스트","JDBC"},
		{"jdbc/Guide-to-using-JDBC","JDBC 프로그래밍 방법","JDBC"},
		{"jdbc/JDBC-Create-Table","테이블 생성","JDBC"},
		{"jdbc/JDBC-Insert","INSERT","JDBC"},
		{"jdbc/JDBC-Select","SELECT","JDBC"},
		{"jdbc/JDBC-Update","UPDATE","JDBC"},
		{"jdbc/PreparedStatement","PreparedStatement","JDBC"},
		{"jdbc/JDBC-Join","테이블 조인(Join)","JDBC"},
		{"jdbc/JDBC-Transaction","트랜잭션","JDBC"},
		{"jdbc/Connection-Pool","Connection Pool","JDBC"},
		{"jdbc/Namecard","명함관리","JDBC"},
		{"jdbc/JavaBank","자바은행","JDBC"},
		//JSP
		{"jsp/How-to-install-Tomcat","Tomcat 설치","JSP"},
		{"jsp/Namecard-Webapp","명함관리 웹 애플리케이션","JSP"},
		{"jsp/Web-Application","웹 애플리케이션","JDBC"},
		{"jsp/Web-Application-Directory-Structure","웹 애플리케이션 작성 실습","JSP"},
		{"jsp/Servlets","서블릿","JDBC","JSP"},
		{"jsp/JSP","JSP","JSP"},
		{"jsp/Accessing-database-from-JSP_Servlets","데이터베이스 연동","JSP"},
		{"jsp/BBS-Study","게시판","JSP"},
		{"jsp/Thread-BBS","계층형 게시판","JSP"},
		{"jsp/BBS-Model1","모델1 게시판","JSP"},
		{"jsp/DataSource","DataSource","JSP"},
		{"jsp/Model2","모델 2","JSP"},
		{"jsp/Paging","페이징 로직 재사용","JSP"},
		//CSS-LAYOUT
		{"css-layout/div-element-arrangement","주요 엘리먼트 배치","CSS Layout"},
		{"css-layout/main-menu-styling","메인 메뉴","CSS Layout"},
		{"css-layout/sub-menu-styling","서브 메뉴","CSS Layout"},
		{"css-layout/header-footer-content-styling","#header, #footer, #content 스타일","CSS Layout"},
		{"css-layout/bbs-list-styling","목록","CSS Layout"},
		{"css-layout/bbs-view-styling","상세보기","CSS Layout"},
		{"css-layout/bbs-write_form-styling","글쓰기, 회원가입","CSS Layout"},
		//JSP-PROJECT
		{"jsp-pjt/Dynamic-Web-Project-Set-Up","개발 준비","JSP Project"},
		{"jsp-pjt/database-design","데이터베이스 설계","JSP Project"},
		{"jsp-pjt/how-to-use-log4j","로깅","JSP Project"},
		{"jsp-pjt/bbs-prototype","프로토타입","JSP Project"},
		{"jsp-pjt/bbs-javabeans","자바빈즈","JSP Project"},
		{"jsp-pjt/bbs-implementation","구현","JSP Project"},
		{"jsp-pjt/bbs-model-2","모델 2","JSP Project"},
		//SPRING
		{"spring/building-java-projects-with-maven","Spring 실습방법","Spring"},
		{"spring/di","Spring DI","Spring"},
		{"spring/aop","Spring AOP","Spring"},
		{"spring/jdbc","Spring JDBC","Spring"},
		{"spring/transaction","Spring 트랜잭션","Spring"},
		{"spring/spring-mvc-with-maven","메이븐으로 Spring MVC 실습","Spring"},
		{"spring/spring-mvc-bbs","Spring MVC 게시판","Spring"},
		{"spring/spring-security-config","웹 요청 보안","Spring"},
		{"spring/method-security","메소드 보안","Spring"},
		{"spring/security-at-view-layer","뷰 레벨 보안","Spring"},
		{"spring/bean-validation-at-signUp","회원가입","Spring"},
		{"spring/bean-validation-at-editAccount","내 정보 수정","Spring"},
		{"spring/bean-validation-at-changePasswd","비밀번호 변경","Spring"},
		{"spring/bean-validation-at-write-article","글쓰기","Spring"},
		{"spring/bean-validation-at-modify-article","게시글 수정","Spring"},
		{"spring/i18n","국제화","Spring"},
		{"spring/downloadController","다운로드 컨트롤러","Spring"},
		{"spring/Setting-development-environment-in-Ubuntu","우분투 개발환경","Spring"},
		{"spring/SpringBbs-with-MySql","MySql용 SpringBbs","Spring"},
		{"spring/migrating-to-spring-security-4","Spring Security 4","Spring"},
		{"spring/spring-security-access-denied-handling","접근 거부 다루기","Spring"},
		{"spring/spring-security-password-encoder","패스워드 암호화","Spring"},
		//JAVASCRIPT
		{"javascript/introduction","자바스크립트 소개","JavaScript"},
		{"javascript/dataType","기본 데이터 타입","JavaScript"},
		{"javascript/handling-select-items","select 엘리먼트 다루기","JavaScript"},
		{"javascript/difference-between-javascript-and-java","자바와 다른점","JavaScript"},
		{"javascript/Number","Number","JavaScript"},
		{"javascript/String","String","JavaScript"},
		{"javascript/RegExp","정규표현식","JavaScript"},
		{"javascript/Date","Date","JavaScript"},
		{"javascript/Array","배열","JavaScript"},
		{"javascript/Math","Math","JavaScript"},
		{"javascript/Function","함수","JavaScript"},
		{"javascript/javascript-form-validation","유효성 검사","JavaScript"},
		{"javascript/Cookie","쿠키 다루기","JavaScript"},
		{"javascript/decoupling-html-and-javascript","HTML에서 자바스크립트 분리","JavaScript"}
	};
	public static final int LEN = LINK_TITLE.length;
	private String[] getPrev(String path) {
		String[] ret = null;
		for (int i = 0; i < LEN; i++) {
			if (LINK_TITLE[i][0].equals(path)) {
				if (i-1 > -1) {
					ret = LINK_TITLE[i-1];
				} 
				break;
			}
		}
		return ret;
	}
	private String[] getNext(String dir_path) {
		String[] ret = null;
		for (int i = 0; i < LEN; i++) {
			if (LINK_TITLE[i][0].equals(dir_path)) {
				if (i+1 < LEN) {
					ret = LINK_TITLE[i+1];
				} 
				break;
			}
		}
		return ret;
	}
	private String[] getMe(String dir_path) {
		String[] ret = null;
		for (int i = 0; i < LEN; i++) {
			if (LINK_TITLE[i][0].equals(dir_path)) {
				ret = LINK_TITLE[i];
				break;
			}
		}
		return ret;
	}
	@RequestMapping(value="{category}/{path}", method=RequestMethod.GET)
	public String java(@PathVariable("category") String category, 
			@PathVariable("path") String path, Model model) {
		String dir_path  = category + "/" + path;
		String[] next = getNext(dir_path);
		String[] prev = getPrev(dir_path);
		if (next != null) {
			model.addAttribute("nextLink", next[0]);
			model.addAttribute("nextTitle", next[1]);
		} else {
			model.addAttribute("nextLink", "");
			model.addAttribute("nextTitle", "");
		}
		if (prev != null) {
			model.addAttribute("prevLink", prev[0]);
			model.addAttribute("prevTitle", prev[1]);
		} else {
			model.addAttribute("prevLink", "");
			model.addAttribute("prevTitle", "");
		}
		String[] me = getMe(dir_path);
		model.addAttribute("category", me[2] + " - " + me[1]);
		return category + "/" + path;
	}	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home() {
		return "/";
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
/*	@RequestMapping(value="{category}/{id}", method=RequestMethod.GET)
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
	}*/
}