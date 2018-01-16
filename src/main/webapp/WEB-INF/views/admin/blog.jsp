<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script>
	function goModify(str) {
		var form = document.getElementById("form");
		form.webSafeString.value = str;
		form.action = "/admin/modify";
		form.method = "get";
		form.submit();
	}
	function goDelete(str) {
		var chk = confirm('<spring:message code="delete.confirm" />');
		if (chk) {
			var form = document.getElementById("form");
			form.webSafeString.value = str;
			form.action = "/admin/delete";
			form.method = "post";
			form.submit();
		}
	}
</script>

<h1><spring:message code="blog.list" /></h1>
<ul>
	<c:forEach var="article" items="${articles }" varStatus="status">
		<li>${article.category }/${article.id } ${article.title }
			<a href="javascript:goModify('${article.keyString }')">[<spring:message code="bbs.modify" />]</a> 
			<a href="javascript:goDelete('${article.keyString }')">[<spring:message code="bbs.delete" />]</a>
		</li>
	</c:forEach>
</ul>
<form id="form">
	<input type="hidden" name="webSafeString" />
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<a href="/admin/new" style="text-transform: capitalize;"><spring:message code="blog.new" /></a>