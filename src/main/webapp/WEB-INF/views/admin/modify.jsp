<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
    window.onload = initPage;
    
    function initPage() {
        var form = document.getElementById('blog-form');
        form.onsubmit = function() {
          var title = form.title.value;
          var keywords = form.keywords.value;
          var description = form.description.value;
          var content = form.content.value;
          title = title.trim();
          keywords = keywords.trim();
          description = description.trim();
          content = content.trim();
          if(title.length === 0) {
              alert('<spring:message code="title.empty" />');
              form.title.value = '';
              return false;
          }
          if(keywords.length === 0) {
              alert('<spring:message code="keywords.empty" />');
              form.keywords.value = '';
              return false;
          }
          if(description.length === 0) {
              alert('<spring:message code="description.empty" />');
              form.description.value = '';
              return false;
          }
          if(content.length === 0) {
              alert('<spring:message code="content.empty" />');
              form.content.value = '';
              return false;
          }
          form.title.value = title;
          form.keywords.value = keywords;
          form.description.value = description;
          form.content.value = content;
          
          return true;
        };
    }    
</script>
<h3><spring:message code="blog.modify" /></h3>
<form id="blog-form" action="modify" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <input type="hidden" name="webSafeString" value="${article.keyString }"/>
    <div><spring:message code="blog.title" />:<input type="text" name="title" value="${article.title }"/></div>
    <div><spring:message code="blog.keywords" />:<input type="text" name="keywords" value="${article.keywords }"/></div>
    <div><spring:message code="blog.description" />:<input type="text" name="description" value="${article.description }"/></div>
    <div><textarea name="content" style="width: 99%;height: 300px;">${article.content }</textarea></div>
    <div><input type="submit" value="<spring:message code="blog.modify" />" /></div>
</form>