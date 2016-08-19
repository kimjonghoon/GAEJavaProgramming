<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<nav id="secondaryNav">
	<strong id="main-menu-title">Java</strong>
	<ul id="sub-menu">
		<li class="sub-section-title">자바 소개</li>
		<li class="sub-menu-item"><a href="/java/Features">자바의 특징</a></li>
		<li class="sub-menu-item"><a href="/java/Class-Object">객체와 클래스</a></li>
		<li class="sub-section-title">자바 기초</li>
		<li class="sub-menu-item"><a href="/java/Keyword_Indentifiers_Comment">키워드, 식별자, 주석</a></li>
		<li class="sub-menu-item"><a href="/java/DataType_Casting">자료형과 형변환</a></li>
		<li class="sub-menu-item"><a href="/java/Arrays">배열</a></li>
		<li class="sub-menu-item"><a href="/java/Operators">연산자</a></li>
		<li class="sub-menu-item"><a href="/java/if_switch_loops">if문, switch문, 반복문</a></li>
		<li class="sub-menu-item"><a href="/java/Package_Modifiers">패키지와 접근자</a></li>
		<li class="sub-menu-item"><a href="/java/Inheritance">상속</a></li>
		<li class="sub-menu-item"><a href="/java/Static">static 키워드</a></li>
		<li class="sub-menu-item"><a href="/java/Collection">컬렉션</a></li>
		<li class="sub-menu-item"><a href="/java/Exception">예외</a></li>
		<li class="sub-section-title">자바은행 예제</li>
		<li class="sub-menu-item"><a href="/java/Javabank-Requirements-analysis">요구사항 분석</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Design">구현</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-inheritance">상속 적용</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-abstract-class">추상 클래스 적용</a></li>
		<li class="sub-menu-item"><a href="/java/Javabank-Apply-interface">인터페이스 적용</a></li>
		<li class="sub-section-title">자바 고급</li>
		<li class="sub-menu-item"><a href="/java/Thread">스레드</a></li>
		<li class="sub-menu-item"><a href="/java/Stream">스트림</a></li>
		<li class="sub-menu-item"><a href="/java/Logging">로깅</a></li>
		<li class="sub-menu-item"><a href="/java/Socket">소켓</a></li>
		<li class="sub-menu-item"><a href="/java/RMI">RMI</a></li>
		<li class="sub-section-title">데이터스토어에 저장한 블로그</li>
<c:forEach var="i" items="${articles }" varStatus="status">
		<li class="sub-menu-item"><a href="/datastore/${i.category }/${i.id }">${i.title }</a></li>
</c:forEach>
	</ul>
</nav>