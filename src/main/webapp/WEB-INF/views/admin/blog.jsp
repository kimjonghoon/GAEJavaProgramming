<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script>
    window.onload = initPage;
    
    function initPage() {
        var blog_list = document.getElementById("blog-list");
        var blogLinks = blog_list.getElementsByTagName("a");
        for (var i = 0; i < blogLinks.length; i++) {
            var blogLink = blogLinks[i];
            if (blogLink.className === "blog-modify-link") {
                blogLink.onclick = function() {
                    var webSafeString = this.title;
                    var form = document.getElementById("form");
                    form.webSafeString.value = webSafeString;
                    form.action = "/admin/modify";
                    form.method = "get";
                    form.submit();
                    return false;
                };
            } else if (blogLink.className === 'blog-delete-link') {
                blogLink.onclick = function() {
                    var chk = confirm('<spring:message code="delete.confirm" />');
                    if (chk) {
                        var webSafeString = this.title;
                        var form = document.getElementById("form");
                        form.webSafeString.value = webSafeString;
                        form.action = "/admin/delete";
                        form.method = "post";
                        form.submit();
                        return false;
                    }
                };
            }
        }        
    }
</script>

<h3><spring:message code="blog.list" /></h3>
<ul id="blog-list">
    <c:forEach var="article" items="${articles }" varStatus="status">
        <li>${article.category }/${article.id } ${article.title }
            <a href="#" title="${article.keyString }" class="blog-modify-link">[<spring:message code="bbs.modify" />]</a> 
            <a href="#" title="${article.keyString }" class="blog-delete-link">[<spring:message code="bbs.delete" />]</a>
        </li>
    </c:forEach>
</ul>
<form id="form">
    <input type="hidden" name="webSafeString" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<a href="/admin/new" style="text-transform: capitalize;"><spring:message code="blog.new" /></a>