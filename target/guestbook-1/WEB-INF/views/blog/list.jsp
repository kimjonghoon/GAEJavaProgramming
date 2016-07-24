<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="net.java_school.blog.Article"%>
<script>
	function goModify(str) {
		var form = document.getElementById("form");
		form.webSafeString.value = str;
		form.action = "modify";
		form.method = "get";
		form.submit();
	}
	function goDelete(str) {
		var chk = confirm("정말로 삭제하겠습니까?");
		if (chk) {
			var form = document.getElementById("form");
			form.webSafeString.value = str;
			form.action = "delete";
			form.method = "post";
			form.submit();
		}
	}
</script>
<ul>
	<c:forEach var="article" items="${articles }" varStatus="status">
		<li>${article.category }/${article.id } ${article.title }
			<a href="javascript:goModify('${article.keyString }')">[수정]</a> 
			<a href="javascript:goDelete('${article.keyString }')">[삭제]</a>
		</li>
	</c:forEach>
</ul>
<form id="form">
	<input type="hidden" name="webSafeString" />
</form>
<a href="/blog/new">[글쓰기]</a>