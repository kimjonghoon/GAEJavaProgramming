<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav id="secondaryNav">
	<strong>Spring</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">Spring Basic</li>
		<li class="sub-menu-item"><a href="/spring/building-java-projects-with-maven">Spring 실습방법</a></li>
		<li class="sub-menu-item"><a href="/spring/di">Spring DI</a></li>
		<li class="sub-menu-item"><a href="/spring/aop">Spring AOP</a></li>
		<li class="sub-menu-item"><a href="/spring/jdbc">Spring JDBC</a></li>
		<li class="sub-menu-item"><a href="/spring/transaction">Spring 트랜잭션</a></li>
		
		<li class="sub-section-title">Spring MVC</li>
		<li class="sub-menu-item"><a href="/spring/spring-mvc-with-maven">메이븐으로 Spring MVC 실습</a></li>
		<li class="sub-menu-item"><a href="/spring/spring-mvc-bbs">Spring MVC 게시판</a></li>
		<li class="sub-section-title">Spring Security</li>
		<li class="sub-menu-item"><a href="/spring/spring-security-config">웹 요청 보안</a></li>
		<li class="sub-menu-item"><a href="/spring/method-security">메소드 보안</a></li>
		<li class="sub-menu-item"><a href="/spring/security-at-view-layer">뷰 레벨 보안</a></li>
		
		<li class="sub-section-title">Bean Validataion</li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-signUp">회원가입</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-editAccount">내 정보 수정</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-changePasswd">비밀번호 변경</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-write-article">글쓰기</a></li>
		<li class="sub-menu-item"><a href="/spring/bean-validation-at-modify-article">게시글 수정</a></li>
		
		<li class="sub-section-title">기타</li>
		<li class="sub-menu-item"><a href="/spring/i18n">국제화</a></li>
		<li class="sub-menu-item"><a href="/spring/downloadController">다운로드 컨트롤러</a></li>
		<li class="sub-menu-item"><a href="/spring/Setting-development-environment-in-Ubuntu">우분투 개발환경</a></li>
		<li class="sub-menu-item"><a href="/spring/SpringBbs-with-MySql">MySql용 SpringBbs</a></li>
		<li class="sub-menu-item"><a href="/spring/migrating-to-spring-security-4">Spring Security 4</a></li>
		<li class="sub-menu-item"><a href="/spring/spring-security-access-denied-handling">접근 거부 다루기</a></li>
		<li class="sub-menu-item"><a href="/spring/spring-security-password-encoder">패스워드 암호화</a></li>
		
		<li class="sub-section-title">데이터스토어에 저장한 블로그</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>				
	</ul>
</nav>