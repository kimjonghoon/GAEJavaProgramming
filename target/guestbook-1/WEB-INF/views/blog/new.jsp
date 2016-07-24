<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1>New</h1>
<form action="new" method="post">
   <div>
      category:
      <input type="text" name="category" style="width: 99%;" />
   </div>
   <div>
      id:
      <input type="text" name="id" style="width: 99%;" />
   </div>
   <div>
      order:
      <input type="text" name="order" style="width: 99%;" />
   </div>
   <div>
      title:
      <input type="text" name="title" style="width: 99%;" />
   </div>
   <div>
      keywords:
      <input type="text" name="keywords" style="width: 99%;" />
   </div>
   <div>
      description:
      <input type="text" name="description" style="width: 99%;" />
   </div>
   <div>
      content:
      <textarea name="content" style="width: 99%; height: 200px;"></textarea>
   </div>
   <div>
      <input type="submit" value="Post Article" />
   </div>
</form>