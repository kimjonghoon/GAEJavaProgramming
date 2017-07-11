<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>
<div class="last-modified">Last Modified 2017.2.28</div>

<h1>JSP</h1>

<ol>
	<li><a href="#JSP">What is JSP?</a></li>
	<li><a href="#Directives">Directives</a>
		<ol>
			<li><a href="#page_Directives">page directive</a></li>
			<li><a href="#include_Directives">include directive</a></li>
			<li><a href="#taglib_Directives">taglib directive</a></li>
		</ol>
	</li>
	<li><a href="#Scripting">Scripting</a>
		<ol>
			<li><a href="#Declarations">Declarations</a></li>
			<li><a href="#Expressions">Expressions</a></li>
			<li><a href="#Scriptlets">Scriptlets</a></li>
		</ol>
	</li>
	<li><a href="#Actions">Actions</a>
		<ol>
			<li><a href="#useBean">jsp:useBean</a></li>
			<li><a href="#setProperty">jsp:setProperty</a></li>
			<li><a href="#getProperty">jsp:getProperty</a></li>
			<li><a href="#param">jsp:param</a></li>
			<li><a href="#include">jsp:include</a></li>
			<li><a href="#forward">jsp:forward</a></li>
			<!-- <li><a href="#plugin">jsp:plugin</a></li>-->
		</ol>
	</li>
	<li><a href="#Implicit_Objects">Implicit Objects</a>
		<ol>
			<li><a href="#out">out</a></li>
			<li><a href="#request">request</a></li>
			<li><a href="#response">response</a></li>
			<li><a href="#pageContext">pageContext</a></li>
			<li><a href="#session">session</a></li>
			<li><a href="#application">application</a></li>
			<li><a href="#config">config</a></li>
			<li><a href="#page">page</a></li>
			<li><a href="#exception">exception</a></li>
		</ol>
	</li>
	<li><a href="#JSP_Confirm">Things to check in JSP syntax</a>
		<ol>
			<li><a href="#include_vs_include">Differences between include directive and include action</a></li>
			<li><a href="#ServletContext_Web-App">The relationship between a ServletContext and a web application</a></li>
			<li><a href="#pageDirectives_session-attr">The meaning of the session attribute of the page directive</a></li>
			<li><a href="#useBean_scope">The meaning of the scope attribute of the jsp:useBean action</a></li>
		</ol>
	</li>
	<li><a href="#examples">JSP Examples</a>
		<ol>
			<li><a href="#error-handling-1">JSP error handling in the early Servlet/JSP spec</a></li>
			<li><a href="#error-handling-2">JSP error handling in the current Servlet/JSP spec</a></li>
			<li><a href="#cookie-example">Cookie</a></li>
			<li><a href="#include-directive-example">Using the include directive to separate pages</a></li>
			<li><a href="#login-process">Login using JavaBeans (using session)</a></li>
			<li><a href="#login-process-2">Modify the 'Login using JavaBeans (using session)' to be an example using Action.</a></li>
			<li><a href="#fileList-example">JSP that shows uploaded files</a></li>
			<li><a href="#download-example">JSP which downloads files</a></li>
			<li><a href="#jsp-file-upload">JSP that uploads files</a></li>
		</ol>
	</li>
</ol>

<h2 id="JSP">1. What is JSP?</h2>

<p>
In the <a href="Creating-a-new-web-application">Creating a new web application</a> chapter, we changed the myapp application to the ROOT application.
(The DocuementBase for the myapp application is C:/www/myapp.)
All the examples below, such as the servlet chapter, should be practiced in the ROOT application.
Write the JSP file in C:/www/myapp or its subdirectories with a regular editor, not Eclipse.
</p>

<p>
JSP has emerged as a Java-side countermeasure for ASP as Microsoft's ASP becomes popular.

JSP is a servlet-based technology.
Strictly speaking, JSP does not respond to client requests.
The JSP is translated into a servlet<sup>1</sup> by a servlet container, such as tomcat, and this servlet responds to the client's request.

Servlets are a technique for dynamically creating HTML pages.
However, it has been difficult to write Java code and HTML code together.
The servlet must create the HTML design as a Java string and pass it as an argument to a method in the output stream.
This means that the HTML code is inserted into the Java code in Servlet.

In JSP, this is the opposite.
Java code is inserted into the HTML design.
This means that JSPs can be written more easily than servlets in writing design and code together.<sup>2</sup>
JSP is a useful technique when you need to show your users the dynamically generated HTML with a complex design.
</p>

<p>
Create a hello.jsp file in the top-level directory of your ROOT application (C:/www/myapp) and visit http://localhost:port/hello.jsp. 
</p>

<em class="filename">/hello.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;body&gt;
Hello, World!
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
When Tomcat first receives a /hello.jsp request, Tomcat creates a servlet from hello.jsp as follows:
</p>

<pre class="prettyprint">
// .. omit ..

try {
  response.setContentType("text/html");
  pageContext = _jspxFactory.getPageContext(this, request, response,
  			null, true, 8192, true);
  _jspx_page_context = pageContext;
  application = pageContext.getServletContext();
  config = pageContext.getServletConfig();
  session = pageContext.getSession();
  out = pageContext.getOut();
  _jspx_out = out;

  out.write("&lt;html&gt;\n");
  out.write("&lt;body&gt;\n");
  out.write("Hello, World!\n");
  out.write("&lt;/body&gt;\n");
  out.write("&lt;/html&gt;\n");
} catch (java.lang.Throwable t) {
  if (!(t instanceof javax.servlet.jsp.SkipPageException)){
    out = _jspx_out;
    if (out != null &amp;&amp; out.getBufferSize() != 0)
      try {
        if (response.isCommitted()) {
          out.flush();
        } else {
          out.clearBuffer();
        }
      } catch (java.io.IOException e) {}
    if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
    else throw new ServletException(t);
  }
} finally {
  _jspxFactory.releasePageContext(_jspx_page_context);
}

// .. omit ..
</pre>

<p>
Because hello.jsp is created in the top-level directory of the ROOT application, 
the full path to the generated servlet is {TOMCAT_HOME}\work\Catalina\localhost\_\org\apache\jsp\hello_jsp.java.
Tomcat compiles this servlet, creates a servlet object from the servlet bytecode, and invokes the service method of the servlet object.
When hello.jsp request arrives again, Tomcat checks whether the hello.jsp file has been changed.
If hello.jsp has not changed, Tomcat checks whether the servlet object is loaded.
If the servlet object is in memory, Tomcat call the service method of the servlet object.
If the servlet object is not in memory, Tomcat create a servlet object.
If hello.jsp is changed, Tomcat make a servlet Java source from hello.jsp.
</p>


<h2 id="Directives">2. Directives</h2>

<p>
Directives provide general information about a JSP to a Servlet Container.
There are three directives: page, include, and taglib.
</p>


<h3 id="page_Directives">2.1 page directive</h3>

<pre class="prettyprint no-border">
&lt;%@ page {attribute="value"} %&gt;
</pre>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 190px;">attribute="value"</th>
	<th class="table-in-article-th">Description</th>
</tr>
<tr>
	<td class="table-in-article-td">language="scriptLanguage"</td>
	<td class="table-in-article-td">the server-side language to compile the page (mostly java)</td>
</tr>
<tr>
	<td class="table-in-article-td">import="importList"</td>
	<td class="table-in-article-td">The Java package or Java package list that the page imports. Lists are separated by commas (,).</td>
</tr>
<tr>
	<td class="table-in-article-td">session="true | false"</td>
	<td class="table-in-article-td">Sets whether the page uses session data (default is true).</td>
</tr>
<tr>
	<td class="table-in-article-td">errorPage="error_uri"</td>
	<td class="table-in-article-td">relative path of the error page that handles the JSP exception.</td>
</tr>
<tr>
	<td class="table-in-article-td">isErrorPage="true | false"</td>
	<td class="table-in-article-td">whether the page is a error page (default is false).</td>
</tr>
<tr>
	<td class="table-in-article-td">contentType="ctinfo"</td>
	<td class="table-in-article-td">Set the MIME type and charset of the response.</td>
</tr>
<tr>
	<td class="table-in-article-td">pageEncoding="charset"</td>
	<td class="table-in-article-td">the charset of the JSP file. Specifies the same as the charset specified by contentType.</td>
</tr>
</table>

<p>
If omitted, there are many attributes to which the default value applies.
Therefore, you do not need to set all attributes.
The contentType attribute can only be set once and is set in most of the first page directives.
You can set multiple import attributes.
</p>

<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.HashMap,java.util.ArrayList" %&gt;
</pre>

<p>
There are two page directives in this example.
The first directive above sets the response of content type to text/html (HTML Documents) and the character set of response content to UTF-8.
UTF-8 is currently the most popular character set on the Internet.

The second page directive has only the import attribute set.
The Java codes in JSP will use java.util.HashMap and java.util.ArrayList.
You can also set the import attribute on the first page directive, but doing so is not recommended.
You can change the above as follows.
</p>
 
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.HashMap" %&gt;
&lt;%@ page import="java.util.ArrayList" %&gt;
</pre>

<p>
It is recommended to code this way because it is easy to see.
</p>


<h3 id="include_Directives">2.2 include directive</h3>

<p>
The include directive is used to insert a document into a servlet which is made from a JSP. 
The document to be inserted must exist within the web application.
</p>

<pre class="prettyprint no-border">
&lt;%@ include file="header.jsp" %&gt;
</pre>

<h3 id="taglib_Directives">2.3 taglib directive</h3>

<p>
The taglib directive specifies the tag library used by the JSP page.
A tag library is a technique for creating a tag that changes to Java code when converted to a servlet.
If you can use tags instead of Java code in JSP, you can manage your design efficiently.
However, with the advent of a large number of tag libraries, programmers have become increasingly reluctant to use tag libraries.
</p>

<p>
The tag library uses prefix and uri to uniquely distinguish its tag set.
</p>

<pre class="prettyprint no-border">
&lt;%@ taglib <strong>uri</strong>="tagLibraryURI" <strong>prefix</strong>="tagPrefix" %&gt;
</pre>

<p>
The uri is a URI Information that uniquely names the tag library.
The prefix is used to distinguish the tag libraries within a JSP page.
</p>

<p>
I will not discuss how to create a tag library.
The JSP Standard Tag Library (JSTL) included in the JSP specification is covered in the <a href="/jsp-pjt">JSP Project</a>.
</p>

<h2 id="Scripting">3. Scripting</h2>

<p>
Scripting is used to insert Java code into JSP pages. 
There are three scripting: Declarations, Expressions, Scriptlets,
</p>

<h3 id="Declarations">3.1 Declarations</h3>

<p>
Declarations are used to declare servlet instance variables and methods within a JSP page.
The following declaration is converted to an instance variable of the servlet class.
</p>

<pre class="prettyprint no-border">
&lt;%! String name = new String("Alison"); %&gt;
</pre>

<p>
The following declaration is converted to instance method of the servlet class.
</p>

<pre class="prettyprint no-border">
&lt;%! 
public String getName() {
	return name;
} 
%&gt;
</pre>


<h3 id="Expressions">3.2 Expressions</h3>

<p>
The expression is converted to a string by the servlet container.
If the expression is not converted to a string, a ClassCastException is thrown.
The following expression prints Hello, Alison to the web browser.
</p>

<pre class="prettyprint no-border">
Hello, &lt;%=getName()%&gt;
</pre>

<h3 id="Scriptlets">3.3 Scriptlets</h3>

<p>
You can insert Java statements freely within scriptlets.
A Java statements in &lt;% ...%&gt; are included in the servlet's _jspSevice() method when a servlet is made from a JSP.
</p>

<h2 id="Actions">4. Actions</h2>

<p>
Actions are used to create or modify objects.
</p>

<h3 id="useBean">4.1 &lt;jsp:useBean&gt;</h3>

<p>
This action creates a bean or finds the bean that was created.
First, it looks for objects that use the same scope and id.
If the object is not found, it creates the object according to the given scope and id attributes.
</p>

<pre class="prettyprint no-border">
&lt;jsp:useBean id="name" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
</pre>

<strong>&lt;jsp:useBean&gt;'s attributes</strong>
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">attribute</th>
	<th class="table-in-article-th">Description</th>
</tr>
<tr>
	<td class="table-in-article-td">id</td>
	<td class="table-in-article-td">The key to identify the object instance in the same scope.</td>
</tr>
<tr>
	<td class="table-in-article-td">scope</td>
	<td class="table-in-article-td">The range in which the generated bean's reference is valid, page(default), request, session, application</td>
</tr>
<tr>
	<td class="table-in-article-td">class</td>
	<td class="table-in-article-td">FQCN(Fully Qualified Class Name) 패키지를 포함한 클래스 이름</td>
</tr>
<tr>
	<td class="table-in-article-td">type</td>
	<td class="table-in-article-td">The superclass or interface of the class defined in the class attribute.</td>
</tr>
</table>

<p>
&lt;jsp:useBean id="cart" scope="request" class="example.Cart" /&gt; is like the following scriptlet:
</p>

<pre class="prettyprint">
&lt;%
    example.Cart cart;
    cart = (example.Cart) request.getAttribute("cart");
    if (cart == null) {
        cart = new example.Cart();
        request.setAttribute("cart", cart);
    }
%&gt;
</pre>

<h3 id="setProperty">4.2 &lt;jsp:setProperty&gt;</h3>

<p>
This action is used to set the property value of the bean.
</p>

<pre class="prettyprint">
&lt;jsp:useBean id="login" scope="page" class="example.User" /&gt;
&lt;jsp:setProperty name="login" property="passwd" /&gt;
</pre>

<p>
The above code is like the scriptlet below.
</p>

<pre class="prettyprint">
&lt;%
    example.User user;
    user = (example.User) pageContext.getAttribute("user");
    if (user == null) {
        user = new example.User();
        pageContext.setAttribute("user", user);
    }
    String _jspParam;
    _jspParam = request.getParameter("passwd");
    if (_jspParam != null &amp;&amp; !_jspParam.equals(""))
        user.setPasswd(_jspParam);
%&gt;
</pre>

<strong>&lt;jsp:setProperty&gt;'s attributes</strong>
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">Attribute</th>
	<th class="table-in-article-th">Description</th>
</tr>
<tr>
	<td class="table-in-article-td">name</td>
	<td class="table-in-article-td">The name of the bean instance defined in &lt;jsp:useBean&gt;.</td>
</tr>
<tr>
	<td class="table-in-article-td">property</td>
	<td class="table-in-article-td">
Beans property to change the value.
If property="*", all properties of the bean are modified by calling any setter method that matches all parameter names in the HTTP request.
But if the value of the parameter is "", the property of the corresponding bean is not modified.
	</td>
</tr>
<tr>
	<td class="table-in-article-td">param</td>
	<td class="table-in-article-td">
The value of the param attribute is one of the parameter names of the HTTP request.
The value of the beans property set in the property attribute is set to the param attribute value. 
	</td>
</tr>
<tr>
	<td class="table-in-article-td">value</td>
	<td class="table-in-article-td">Change the property of the bean to the string defined in the value attribute.</td>
</tr>
</table>

<p>
Suppose you have the following form page.
</p>

<pre class="prettyprint">
&lt;form action="register.jsp" method="post"&gt;
    &lt;input type="text" name="id" /&gt;
    &lt;input type="password" name="passwd" /&gt;
&lt;/form&gt;
</pre>

<p>
Suppose there is the following action in register.jsp that receives the value entered in the form by a user:
</p>

<pre class="prettyprint no-border">
&lt;jsp:setProperty name="user" property="*" /&gt;
</pre>

<p>
The above action is like the scriptlet below.
</p>

<pre class="prettyprint">
&lt;%
    String _jspParam;
    _jspParam = request.getParameter("passwd");
    if ( _jspParam != null &amp;&amp; !_jspParam.equals("") )
        user.setPasswd(_jspParam);
    _jspParam = request.getParameter("id");
    if ( _jspParam != null &amp;&amp; !_jspParam.equals("") )
        user.setId(_jspParam);
%&gt;
</pre>

<p>
Suppose you have the following form page:
</p>

<pre class="prettyprint">
&lt;form action="signUp.jsp" method="post"&gt;
    &lt;input type="text" name="member_id" /&gt;
&lt;/form&gt;
</pre>

<p>
Suppose you have the following action in signUp.jsp that receives a form input value:
</p>

<pre class="prettyprint no-border">
&lt;jsp:setProperty name="user" property="id" param="member_id" /&gt;
</pre>

<p>
The above action is like the scriptlet below.
</p>

<pre class="prettyprint">
&lt;%
    String _jspParam;
    _jspParam = request.getParameter("member_id");
    if (_jspParam != null &amp;&amp; !_jspParam.equals(""))
        user.setId(_jspParam);
%&gt;
</pre>

<p>
As you can see in the example above, 
if the name of the bean's member variable and the name of the form's parameter are not equal, you need to use the param attribute.
</p>

<p>
The following is an example of the setProperty action.
</p>

<pre class="prettyprint no-border">
&lt;jsp:setProperty name="user" property="id" value="admin" /&gt;
</pre>

<p>
The above setProperty action is like the following scriptlet.
</p>

<pre class="prettyprint">
&lt;%
    user.setId("admin");
%&gt;
</pre>

<p>
As in the example above, the setProperty action is used to set the property value of the bean.
</p>

<h3 id="getProperty">4.3 &lt;jsp:getProperty&gt;</h3>

<p>
The getProperty action takes the property value of the bean and puts it into the output stream.
</p>

<pre class="prettyprint">
&lt;jsp:getProperty name="name" property="propertyName" /&gt;
</pre>

<strong>&lt;jsp:getProperty&gt;'s attributes</strong>
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">Attribute</th>
	<th class="table-in-article-th">Description</th>
</tr>
<tr>
	<td class="table-in-article-td">name</td>
	<td class="table-in-article-td">The name of the bean instance</td>
</tr>
<tr>
	<td class="table-in-article-td">property</td>
	<td class="table-in-article-td">a property of bean instance</td>
</tr>
</table>

<h3 id="param">4.4 &lt;jsp:param&gt;</h3>

<p>
This action is used to define the parameters to pass to &lt;jsp:include&gt; and &lt;jsp:forward&gt;.
</p>

<pre class="prettyprint">
&lt;jsp:param name="name" value="value" /&gt;
</pre>

<h3 id="include">4.5 &lt;jsp:include&gt;</h3>

<p>
This action is used to add static (HTML) or dynamic web components (JSP, Servlets) to a JSP page.
</p>

<pre class="prettyprint">
&lt;jsp:include page="urlSpec" flush="true"&gt;
	&lt;jsp:param ... /&gt;
&lt;/jsp:include&gt;
</pre>

<strong>&lt;jsp:include&gt;'s attributes</strong>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">Attribute</th>
	<th class="table-in-article-th">Description</th>
</tr>
<tr>
	<td class="table-in-article-td">page</td>
	<td class="table-in-article-td">Relative path of the resources to be included</td>
</tr>
<tr>
	<td class="table-in-article-td">flush</td>
	<td class="table-in-article-td">Whether the buffer is flushed</td>
</tr>
</table>

<h3 id="forward">4.6 &lt;jsp:forward&gt;</h3>

<p>
This action is used for forwarding.
Forwarding means that the resource that is requested by the client passes control to another resource.
&lt;jsp:forward&gt; can have &lt;jsp:param&gt; as its child element, in order to pass parameters to the target resource to which control is passed.
The page attribute is the relative address of the target resource to which control is passed.
</p>

<pre class="prettyprint">
&lt;jsp:forward page="relativeURL"&gt;
	&lt;jsp:param .../&gt;
&lt;/jsp:forward&gt;
</pre>

<h2 id="Implicit_Objects">5. Implicit Objects</h2>

<p>
An implicit object is an object used in a JSP and can be used immediately without any effort to obtain a reference value.
</p>

<h3 id="out">5.1 out</h3>

<p>
It is a reference to the instance of javax.servlet.jsp.JspWriter abstract class type.
It used to write data to the response stream.
Create helloworld.jsp in the root directory of your ROOT application as shown below and visit http://localhost:port/helloWorld.jsp.
</p>

<em class="filename">/helloWorld.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;body&gt;
&lt;%
out.println("Hello, World!");
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Compare the servlet made from hello.jsp with the servlet made from helloworld.jsp. 
The full path of each servlet is:
</p>

<ul>
	<li>{TOMCAT_HOME}\work\Catalina\localhost\_\org\apache\jsp\hello_jsp.java</li>
	<li>{TOMCAT_HOME}\work\Catalina\localhost\_\org\apache\jsp\helloworld_jsp.java</li>
</ul>

<h3 id="request">5.2 request</h3>

<p>
This is a reference to the instance of javax.servlet.http.HttpServletRequest interface type.
This reference allows you to access request parameters, information sent by the user in the header, and information about the user.
Create request.jsp in the root directory of your ROOT application as shown below and visit http://localhost:port/request.jsp?user=alison
</p>

<em class="filename">/request.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;body&gt;
&lt;%
out.println("Hello, " + request.getParameter("user"));
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3 id="response">5.3 response</h3>

<p>
It is a reference to the instance of javax.servlet.http.HttpServletResponse interface type.
</p>

<h3 id="pageContext">5.4 pageContext</h3>

<p>
This is a reference to the instance of javax.servlet.jsp.PageContext abstract class type.
It provides access to all available resources within the JSP.
For example, it provides access to resources such as ServletRequest, ServletResponse, ServletContext, HttpSession, and ServletConfig.
</p>

<h3 id="session">5.5 session</h3>

<p>
This is a reference to the instance of javax.servlet.http.HttpSession type.
It is used to read and store session data.
Create session.jsp in the root directory of your ROOT application as shown below and visit http://localhost:port/session.jsp several times.
</p>

<em class="filename">/session.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;head&gt;
  &lt;title&gt;session&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
Integer count = (Integer)session.getAttribute("count");
  
if (count == null) {
	count = new Integer(1);
	session.setAttribute("count", count);
} else {
	count = new Integer(count.intValue() + 1);
	session.setAttribute("count", count);
}
out.println("COUNT: " + count); 
%&gt; 
&lt;/body&gt;
&lt;/html&gt;
</pre>


<h3 id="application">5.6 application</h3>

<p>
It is a reference to the instance of javax.servlet.ServletContext interface type.
</p>

<h3 id="config">5.7 config</h3>

<p>
It is a reference to the javax.servlet.ServletConfig inferface type instance.
The ServletConfig type instance contains servlet initialization parameter information.
</p>

<h3 id="page">5.8 page</h3>

<p>
It is a reference of type Object that refers to the servlet instance. 
This is why you cannot declare a variable named page in JSP scripting. 
This is not much use.
</p>

<h3 id="exception">5.9 exception</h3>

<p>
The exception implicit object provides access to the uncaught exception that occurred in a JSP.
The exception variable can only be used within pages whose page directive's isErrorPage attribute is set to true.
</p>

<h2 id="JSP_Confirm">6. Things to check in JSP syntax</h2>

<h3 id="include_vs_include">6.1 Differences between include directive and include action</h3>

<p>
If you use the include directive, one servlet made from one JSP into which all JSPs combined will responds to the client's request.
If you use the include action, the JSP in the include action becomes an independent servlet and participates in creating a single response.
In other words, a directive is interpreted once when converted to a servlet, but in the case of an action it is interpreted each time it is requested.
Therefore, theoretically, it is better to use the include directive when the content of the included page does not change on demand, and the include action if the content of the included page changes on demand.
</p>

<h3 id="ServletContext_Web-App">6.2 The relationship between a ServletContext and a web application</h3>

<p>
According to the servlet specification, only one ServletContext object is created per web application.
ServletContext has methods that communicate with the server-side components of the web application and the servlet container.
So ServletContext serves as a common repository for server-side components such as JSPs and servlets.
The resources stored in ServletContext exist for the lifetime of the web application.
</p>

<h3 id="pageDirectives_session-attr">6.3 page directive's session attribute</h3>

<p>
If the session attribute of the page directive is set to false, such as &lt;%@ page session="false" ..&gt;, the page can not create a session object nor can it obtain a reference to an existing session object.
If you try to access the session object while session is set to false, an error occurs.
</p>

<h3 id="useBean_scope">6.4 jsp:useBean action's scope</h3>

<p>
The scope attribute of &lt;jsp:useBean&gt; determines how far to use the JavaBean.
Depending on how the scope attribute is specified, the bean object is referenced without being destroyed on multiple pages.
For example, if the scope attribute is set to session, this bean object will not be destroyed until the end of the session.
The default value of scope is page.
You can specify four values for the scope attribute, which are summarized as follows.
</p>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">Scope</th>
	<th class="table-in-article-th">Description</th>
</tr>
<tr>
	<td class="table-in-article-td">page</td>
	<td class="table-in-article-td">
The default value of scope is page.
If scope is not specified, page is set.
A bean whose scope attribute is page is valid only on the page.
A bean whose scope attribute is page is created each time a page is requested and destroyed when the page finishes execution.
A bean whose scope attribute is page can not be referenced in the target page of a jsp:include or jsp:forward action.
If there is a jsp:useBean action with the same id and scope bean on the target page, this action creates a new bean. (It does not refer to the bean created on the page that handed over control.)
Also, a bean created on the target page of the jsp:include action can not be referenced on a page that handed over control.
The page scope beans are appropriate when the state of the beans does not need to be maintained.
	</td>
</tr>
<tr>
	<td class="table-in-article-td">request</td>
	<td class="table-in-article-td">
The bean whose scope attribute is request is stored in the HttpServletRequest object.
Therefore, A bean whose scope attribute is request can also be referenced from the target page of the jsp:forward and jsp:include actions.
	</td>
</tr>
<tr>
	<td class="table-in-article-td">session</td>
	<td class="table-in-article-td">
The bean whose scope attribute value is session is stored in the session object (HttpSession type object).
Therefore, the bean whose scope attribute value is session will not be destroyed on all pages that are called during session maintenance.
On the other hand, a bean whose scope attribute value is page or request is destroyed after it responds to the browser.
The session object created for each user maintains a value that can be referenced by all server-side components until the session ends.
Note that JSP whose session attribute of the page directive is set to false can not use the beans stored in the session object.
	</td>
</tr>
<tr>
	<td class="table-in-article-td">application</td>
	<td class="table-in-article-td">
The bean whose scope attribute value is application is stored in the ServletContext object.
Therefore, the bean whose scope attribute value is application is not destroyed until the web application is unloaded.
All JSPs and servlets in the same web application that can access the ServletContext can access this bean.
Beans in the ServletContext are common resources for a web application. (we have learned that the ServletContext serves as the common repository) 
For that reason, you should decide carefully about setting scope to application.
	</td>
</tr>
</table>


<h2 id="examples">7. JSP Examples</h2>

<h3 id="error-handling-1">7.1 JSP error handling in the early Servlet/JSP spec</h3>

<p>
JSP spec provides a way to deal with errors by providing a JSP page that can handle only errors.
If there is an unhandled exception in the JSP, the servlet container passes the request to the JSP error page.
The exception object that occurred at this time is also passed.
Creating a JSP error page is simple.
To make jsp error page, set the value of the page directive's isErrorPage attribute to true.
Create the following errorPage.jsp in the ROOT application's documentbase.
</p>

<em class="filename">/errorPage.jsp</em>
<pre class="prettyprint">
&lt;%@ page <strong>isErrorPage="true"</strong> contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%&gt;
&lt;html&gt;
&lt;body&gt;
&lt;p&gt;
The following error has occurred.&lt;br /&gt;
&lt;%=exception.getMessage() %&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
IsErrorPage="true" tells the container that this page deals with the error professionally.
</p>

<p>
&lt;%=exception.getMessage() %&gt; prints the error message of the exception sent to the error page.
Here exception is an implicit object.
The exception implicit object can only be referenced from a JSP page with the value of the page directive's isErrorPage attribute set to true.
To see how the error page works, write the following JSP page into the ROOT application's documentbase.
</p>

<em class="filename">/errorMaker.jsp</em>
<pre class="prettyprint">
&lt;%@ page <strong>errorPage="errorPage.jsp"</strong> contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%&gt;
&lt;%
if (true) {
	throw new Exception("Intentionally occurred Exception.");
}
%&gt;
</pre>

<p>
Handling errors using error pages was in the initial specification of Servlet/JSP.
</p>

<h3 id="error-handling-2">7.2 JSP error handling in the current Servlet/JSP spec</h3>

<p>
You can specify an error page in the web.xml file, by HTTP status code<sup>3</sup> and the type of exception that occurs.
This spec was added in Servlet 2.3.
</p>

<em class="filename">WEB-INF/web.xml</em>
<pre class="prettyprint">
&lt;error-page&gt;
	&lt;error-code&gt;404&lt;/error-code&gt;
	&lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
	&lt;error-code&gt;403&lt;/error-code&gt;
	&lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
	&lt;error-code&gt;500&lt;/error-code&gt;
	&lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
</pre>

<p>
With this approach, you can not use implicit object exception in error.jsp.
Instead, you can get the exception object with the newly added property value as follows:
<sup>4</sup>
</p>

<pre class="prettyprint no-border">
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
</pre>

<p>
Here is a list of the attributes of the request related to the error.
All of them can be accessed in the same way as above.
</p>

<table>
<tr>
	<th>javax.servlet.error.status_code</th>
</tr>
<tr>
	<td>Error status code. java.lang.Integer type</td>
</tr>
<tr>
	<th>javax.servlet.error.exception_type</th>
</tr>
<tr>
	<td>Exception type. java.lang.Class type</td>
</tr>
<tr>
	<th>javax.servlet.error.message</th>
</tr>
<tr>
	<td>Error message. String type</td>
</tr>
<tr>
	<th>javax.servlet.error.exception</th>
</tr>
<tr>
	<td>Exceptions occurred. java.lang.Throwable type</td>
</tr>
<tr>
	<th>javax.servlet.error.request_uri</th>
</tr>
<tr>
	<td>The URI of the resource that caused the problem. String type</td>
</tr>
<tr>
	<th>javax.servlet.error.servlet_name</th>
</tr>
<tr>
	<td>The name of the servlet that caused the problem. String type</td>
</tr>
</table>

<em class="filename">/error.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Error&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
//Analyze the servlet exception
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");

if (servletName == null) {
    servletName = "Unknown";
}

String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

if (requestUri == null) {
    requestUri = "Unknown";
}
 
if(statusCode != 500){
    out.write("&lt;h3&gt;Error Details&lt;/h3&gt;");
    out.write("&lt;strong&gt;Status Code&lt;/strong&gt;:" + statusCode + "&lt;br&gt;");
    out.write("&lt;strong&gt;Requested URI&lt;/strong&gt;:"+requestUri);
}else{
    out.write("&lt;h3&gt;Exception Details&lt;/h3&gt;");
    out.write("&lt;ul&gt;&lt;li&gt;Servlet Name:" + servletName + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Name:" + throwable.getClass().getName() + "&lt;/li&gt;");
    out.write("&lt;li&gt;Requested URI:" + requestUri + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Message:" + throwable.getMessage() + "&lt;/li&gt;");
    out.write("&lt;/ul&gt;");
}
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Visit http://localhost:port/alison.jsp.
Because you did not create the alison.jsp file in the ROOT application's document base, a 404 error will occur and the error.jsp file will respond.
In IE, if the content of the error page is less than a certain byte, the error page does not work.<sup>3</sup>
</p>

<p>
It is better not to set the error page at the development stage.
</p>

<h3 id="cookie-example">7.3 Cookie</h3>

<p>
Cookies are simple data stored in a web browser and sent together when sending a request.
If the cookie's lifetime is specified using the setMaxAge() method, the web browser stores the cookie as a file in its own cookie store.
Cookies without setMaxAge() will disappear when the web browser exits.
</p>

<strong>Cookie operation process</strong>
<ol>
	<li>The web browser requests a server resource with code to burn cookies.</li>
	<li>The server resource adds the cookie value to the HTTP response header.</li>
	<li>The web browser stores the cookie data in the response header.</li>
	<li>The web browser also sends cookie data whenever it requests a resource on the website that provided the cookie.</li>
</ol>

<p>
In step 2, the cookie value included in the response header is the following string.
</p>

<pre class="prettyprint no-border">
<strong>Set-Cookie: name=<em>VALUE</em></strong>; expires=<em>DATE</em>; path=<em>PATH</em>; domain=<em>DOMAIN_NAME</em>; secure
</pre>

<p>
The string highlighted above is required data,
<em>Italics</em> are the parts that need to be changed to actual values.
</p>

<p>
In the fourth step, the cookie information included in the request header is the following string.
</p>

<pre class="prettyprint no-border">
Cookie: <em>name1=VALUE1</em>; <em>name2=VALUE2</em>;...
</pre>

<strong>One cookie consists of the following information:</strong>
<ul>
	<li>name</li>
	<li>value</li>
	<li>expires</li>
	<li>domain</li>
	<li>path</li>
	<li>secure(https)</li>
</ul>

<p>
The following is a cookie class.
</p>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">javax.servlet.http.Cookie</dt>
	<dd class="api-summary-dd">Cookie(String name, String value)</dd>
	<dd class="api-summary-dd">getName()</dd>
	<dd class="api-summary-dd">setValue(String)</dd>
	<dd class="api-summary-dd">getValue()</dd>
	<dd class="api-summary-dd">setDomain(String)</dd>
	<dd class="api-summary-dd">getDomain()</dd>
	<dd class="api-summary-dd">setPath(String)</dd>
	<dd class="api-summary-dd">getPath()</dd>
	<dd class="api-summary-dd">setMaxAge(int)</dd>
	<dd class="api-summary-dd">getMaxAge()</dd>
	<dd class="api-summary-dd">setSecure(boolean)</dd>
	<dd class="api-summary-dd">getSecure()</dd>
</dl>	

<p>
The following code snippet shows how to use the Cookie class.
</p>
  
<pre class="prettyprint">
/*
* Creates a cookie.
*/
Cookie cookie = new Cookie("user", "alison");

/*
*  If it starts with a dot, the cookie is sent to the relevant domain.
* www.java-school.net, user.java-school.net, blog.java-school.net, etc.
*/
cookie.setDomain(".java-school.net");

/*
* To create a cookie that applies to the full path of your website, set the path to '/'. 
* If you set a specific path, such as '/ user', cookies are sent only to requests containing '/user'.
*/
cookie.setPath("/");

/*
* Set cookie expire time in seconds.
* If a negative value is set here, the cookie is deleted when the web browser exits. 
*/
cookie.setMaxAge(60*60*24*30); //Cookies valid for 30 days
</pre>

<p>
Let's create a simple example of cookies.
Create a cookie subdirectory under the document base and create the following files in it.
</p>

<em class="filename">/cookie/index.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Cookie Test&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Cookie Test&lt;/h1&gt;
&lt;ul&gt;
	&lt;li&gt;&lt;a href="setCookie.jsp"&gt;Burn Cookies&lt;/a&gt;&lt;/li&gt;
	&lt;li&gt;&lt;a href="viewCookie.jsp"&gt;Confirm Cookies&lt;/a&gt;&lt;/li&gt;
	&lt;li&gt;&lt;a href="editCookie.jsp"&gt;Modify Cookies&lt;/a&gt;&lt;/li&gt;
	&lt;li&gt;&lt;a href="delCookie.jsp"&gt;Delete Cookies&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/setCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.net.*"  %&gt;
&lt;%
Cookie cookie = new Cookie("name", URLEncoder.encode("Alison", "UTF-8"));

/*
* If setPath() is not used, the path is set to the directory where setCookie.jsp is located. (path=/cookie)
*/ 
response.addCookie(cookie);
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Burn Cookies&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
Set-Cookie: &lt;%=cookie.getName() %&gt;=&lt;%=cookie.getValue() %&gt;&lt;br /&gt;
&lt;a href="viewCookie.jsp"&gt;Confirm Cookies&lt;/a&gt; 
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/viewCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.net.*" %&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Confirm Cookies&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
Cookie[] cookies = request.getCookies();
if (cookies != null &amp;&amp; cookies.length &gt; 1) {
	int length = cookies.length;
	for (int i = 0; i &lt; length; i++) {
%&gt;
	&lt;%=cookies[i].getName() %&gt;=&lt;%=URLDecoder.decode(cookies[i].getValue(), "UTF-8") %&gt;&lt;br /&gt;
&lt;%			
	}
}
%&gt;
&lt;a href="./"&gt;index.html&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/editCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.net.*" %&gt;
&lt;%
Cookie[] cookies = request.getCookies();
if (cookies != null &amp;&amp; cookies.length &gt; 1) {
	int length = cookies.length;
	for (int i = 0; i &lt; length; i++) {
		if (cookies[i].getName().equals("name")) {
			Cookie cookie = new Cookie("name", URLEncoder.encode("Bill" ,"UTF-8"));
			response.addCookie(cookie);
		}
	}
}
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Modify Cookies&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
Cookie value changed.&lt;br /&gt;
&lt;a href="viewCookie.jsp"&gt;Confirm Cookies&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/delCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
Cookie[] cookies = request.getCookies();
if (cookies != null &amp;&amp; cookies.length &gt; 1) {
	int length = cookies.length;
	for (int i = 0; i &lt; length; i++) {
		if (cookies[i].getName().equals("name")) {
			Cookie cookie = new Cookie("name", "");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
			break;
		}
	}
}
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Delete Cookies&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
name cookie deleted.&lt;br /&gt;
&lt;a href="viewCookie.jsp"&gt;Confirm Cookies&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3 id="include-directive-example">7.4 Separate pages using include directive</h3>

<p>
Download <a href="src/example.zip">example.zip</a> and unzip it to the root directory of your ROOT application.
Visit http://localhost:port/example/ex1/index.jsp.
Open the index.jsp file and confirm the following:
</p>

<pre class="prettyprint no-border">
&lt;%@ include file="../inc/subMenu.jsp" %&gt;
</pre>

<p>
Index.jsp includes subMenu.jsp.
By separating the parts of the page into separate files and integrating them using the include directive, maintenance becomes easier.
In the subMenu.jsp code, the path for files, images, style sheets, and so on should be relative to index.jsp.
This is because JSP files are combined based on index.jsp.
However, the paths in style sheet code, should be relative to the style sheet file not index.jsp.
</p>

<h3 id="login-process">7.5 Login using JavaBeans (using session)</h3>

<p>
The location of this example is /example/ex2/.
Visit http://localhost:port/example/ex2/index.jsp.
There is work to do to test the login.
The login_proc.jsp page is the page that processes the login.
The login_proc.jsp uses net.java_school.user.User.java JavaBeans.
To run the example, write net.java_school.user.User.java as below and compile to generate bytecode in WEB-INF/classes.
</p>

<em class="filename">User.java</em>
<pre class="prettyprint">
package net.java_school.user;

public class User {

  private String id;
  private String passwd;
	
  public String getId() {
      return id;
  }
	
  public void setId(String id) {
      this.id = id;
  }
	
  public String getPasswd() {
      return passwd;
  }	
	
  public void setPasswd(String passwd) {
      this.passwd = passwd;
  }

}
</pre>

<p>
If you have finished creating and compiling User.java,
Go back to http://localhost:port/example/ex2/index.jsp and test your login.
Open the file /example/ex2/index.jsp and confirm the followings.
</p>

<pre class="prettyprint no-border">
&lt;input type="text" name="<strong>id</strong>" /&gt;
</pre>

<p>
The id parameter is sent to login_proc.jsp.
Open the file /example/ex2/login_proc.jsp and check the code below.
</p>

<pre class="prettyprint no-border">
String id = request.getParameter("<strong>id</strong>");
</pre>

<p>
The value of the id parameter in login_proc.jsp can be obtained using the getParameter() method of the request implicit object.
Login_proc.jsp creates a User object and sets the member variables of the User object using the passed id and passwd parameters.
The login process is completed by putting this User object in the session.
In order to simplify the example, I omitted the code related to the database query.
Therefore, login is successful for any ID and password.
</p>

<em class="filename">login_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;

&lt;%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

/* 
* Here you need the logic to query the database for members with id and passwd.
*/
User user = new User();
user.setId(id);

// After creating the session, save the User object as "user" in the session.
session.setAttribute("user", user);
%&gt;

&lt;jsp:forward page="index.jsp" /&gt;
</pre>

<h3 id="login-process-2">7.6 Modify the 'Login using JavaBeans (using session)' to be an example using Action</h3>

<p>
The location of the example is /example/ex3/.
This example has the same functionality as the previous example.
I just changed login_proc.jsp to use the action.
If you open the login_proc.jsp file, you can see that the code has been simplified as shown below.
</p>

<em class="filename">/login_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;jsp:useBean id="user" scope="session" class="net.java_school.user.User" /&gt;
&lt;jsp:setProperty name="user" property="*"/&gt;
&lt;jsp:forward page="index.jsp" /&gt;
</pre>

<p>
The jsp:useBean action finds an object whose key value is "user" in the session.
If there is no such object, this action creates a User object from the net.java_school.user.User class and store it in the session with the id attribute value of the jsp:useBean action as the key value.

The jsp:setProperty action passes the values of the parameters in the HTTP request as arguments to the setter method of the JSP bean.
The jsp:setProperty action sets the member variables by calling the setter methods of the JSP bean with the values of the parameters in the HTTP request.
</p>

<pre class="prettyprint no-border">
&lt;jsp:setProperty name="user" property="*"/&gt;
</pre>

<p>
The above action calls the setId() and setPasswd() methods of the User bean.
The value of the HTTP request parameter matching the setter method name is passed as the parameter value of the setter method.
</p>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">JSP or JSP bean</th>
	<th class="table-in-article-th">Code</th>
</tr>
<tr>
	<td class="table-in-article-td">index.jsp</td>
	<td class="table-in-article-td"><pre class="prettyprint no-border">&lt;input type="text" name="<strong>id</strong>" /&gt;</pre></td>
</tr>
<tr>	
	<td class="table-in-article-td">login_proc.jsp</td>
	<td class="table-in-article-td"><pre class="prettyprint no-border">&lt;jsp:setProperty name="login" property="<strong>id</strong>" /&gt;</pre></td>
</tr>
<tr>
	<td class="table-in-article-td">User.java</td>
	<td class="table-in-article-td"><pre class="prettyprint no-border">set<strong>Id</strong>(String id)</pre></td>
</tr>
</table>

<p>
In the "setId()" method name, the "I" in Id is an uppercase letter.
(We already studied Java naming convention in Java chapter)
When using the jsp:setProperty action, it will not work unless the JSP bean follows the Java naming convention.
That is, when using actions, the Java naming convention is not a recommendation, but a grammar.
</p>

<h3 id="fileList-example">7.7 JSP that shows uploaded files</h3>

<p>
We already covered the file upload example in the servlet chapter.
The following JSP shows a list of uploaded files in the upload folder.
</p>

<em class="filename">/fileList.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.io.*" %&gt;
&lt;%@ page import="java.net.*" %&gt;
&lt;%
String upload = application.getRealPath("/upload");

File dir = new File(upload);
File[] files = dir.listFiles();
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;List of saved files&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goDownload(filename) {
	var form = document.getElementById("downForm");
	form.filename.value = filename;
	form.submit();
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
int len = files.length;
for (int i = 0; i &lt; len; i++) {
	File file = files[i];
	String filename = file.getName();
%&gt;
	&lt;a href="javascript:goDownload('&lt;%=filename %&gt;')"&gt;&lt;%=file.getName() %&gt;&lt;/a&gt;&lt;br /&gt;
&lt;%
}
%&gt;
&lt;form id="downForm" action="download.jsp" method="post"&gt;
	&lt;input type="hidden" name="filename" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3 id="download-example">7.8 JSP which downloads files</h3>

<p>
The following is the JSP that works when you click the file name on the file list page above.
</p>

<em class="filename">/download.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;
&lt;%@ page import="java.io.File" %&gt;
&lt;%@ page import="java.net.URLEncoder" %&gt;
&lt;%@ page import="java.io.OutputStream" %&gt;
&lt;%@ page import="java.io.FileInputStream" %&gt;
&lt;%@ page import="java.io.IOException" %&gt;
&lt;%@ page import="org.apache.commons.io.FileUtils" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
String filename = request.getParameter("filename");

String path = application.getRealPath("/upload");
File file = new File(path + "/" + filename);

response.setContentLength((int) file.length());

String filetype = filename.substring(filename.indexOf(".") + 1, filename.length());
if (filetype.trim().equalsIgnoreCase("txt")) {
	response.setContentType("text/plain");
} else {
	response.setContentType("application/octet-stream");
}

String userAgent = request.getHeader("user-agent");
boolean ie = userAgent.indexOf("MSIE") != -1;
if (ie) {
	filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
} else {
	filename = new String(filename.getBytes("UTF-8"), "8859_1");
}

response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
/* response.setHeader("Content-Transfer-Encoding", "binary"); */

OutputStream outputStream = response.getOutputStream();

try {
	FileUtils.copyFile(file, outputStream);
} finally {
	outputStream.flush();
}
%&gt;
</pre>

<h3 id="jsp-file-upload">7.9 JSP that uploads files</h3>

<p>
The following is a JSP replacement of the file upload servlet we covered in the Servlet chapter.
</p>

<em class="filename">fileupload_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="
java.util.Iterator,
java.io.File,java.util.List,
javax.servlet.http.HttpServletRequest,
org.apache.commons.fileupload.FileItem,
org.apache.commons.fileupload.FileItemFactory,
org.apache.commons.fileupload.FileUploadException,
org.apache.commons.fileupload.disk.DiskFileItemFactory,
org.apache.commons.fileupload.servlet.ServletFileUpload" %&gt;
&lt;%
//Check that we have a file upload request
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//Create a factory for disk-based file items
DiskFileItemFactory factory = new DiskFileItemFactory();

//Configure a repository (to ensure a secure temp location is used)
File repository = (File) application.getAttribute("javax.servlet.context.tempdir");
factory.setRepository(repository);

//Create a new file upload handler
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");
//Parse the request
List&lt;FileItem&gt; items = upload.parseRequest(request);
//Process a file upload
Iterator&lt;FileItem&gt; iter = items.iterator();
while (iter.hasNext()) {
	FileItem item = iter.next();
	String fileName = null;
	if (!item.isFormField()) {
		String fieldName = item.getFieldName();
		out.println("fieldName : " + fieldName);out.println(",");
		fileName = item.getName();
		out.println("fileName : " + fileName);out.println(",");
		String contentType = item.getContentType();
		out.println("contentType : " + contentType);out.println(",");
		boolean isInMemory = item.isInMemory();
		out.println("isInMemory : " + isInMemory);out.println(",");
		long sizeInBytes = item.getSize();
		out.println("sizeInBytes : " + sizeInBytes);
	}
	// Process a file upload
	String dir = application.getRealPath("/upload");
	File uploadedFile = new File(dir + "/" + fileName);
    item.write(uploadedFile);
}
response.sendRedirect("upload.html");
%&gt;
</pre>

<span id="comments">Comments</span>
<ol>
	<li>Servlets made from JSPs are similar to servlets we learned in previous chapters, but they are not the same.</li>
	<li>Using JSTL to write JSP can further reduce the difficulty of writing HTML and Java code together.</li>
	<li>HTTP status code 404 means not found, 403 means prohibited, and 500 means an internal server error.</li>
	<li>With JSTL you can access:<pre class="prettyprint no-border">&lt;c:out value="${requestScope['javax.servlet.error.message']}" /&gt;</pre></li>
</ol>
</article>