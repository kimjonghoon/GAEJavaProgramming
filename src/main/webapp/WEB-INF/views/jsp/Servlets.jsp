<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<article>
<div class="last-modified">Last Modified 2017.3.7</div>

<h1>Servlet</h1>

<h2>What is Servlet?</h2>

<p>
Servlet is a Java-based technologies for creating programs such as bulletin boards.
Just as the java.sql package is called JDBC, the javax.servlet and javax.servlet.http packages are called Servlet.
Servlet is designed to be independent of the network protocol, but it is mostly used to create dynamic content in the HTTP protocol environment.
JSPs can easily make the application element corresponding to the screen than Servlet.
When you learn Servlet, it is a good start to first learn the basic structure of Servlet.
</p>

<h2>The basic structure of Servlet</h2>

<p>
The basic structure of Servlet consists of:
</p>

<ul>
	<li>The javax.servlet.Servlet interface that all servlets must implement.</li>
	<li>Javax.servlet.GenericServlet abstract class which most servlets inherit.</li>
	<li>The javax.servlet.http.HttpServlet class that the servlets that use the HTTP protocol inherit.</li>
</ul>

<P>
As shown in the figure<sup><a href="#comments">1</a></sup> below, GenericServlet implements the javax.servlet.ServletConfig interface for programmers' convenience.<br />
<img src="https://lh3.googleusercontent.com/9IeGxc54vtjXg7SZtRqTESFpYFI6hbHBfx3-qaC9_yYdi7nNWGFLTeU8-bsaMmxAMNxmFjYft3QoJ_kAIkAH_vJej5nvX3IFQImNYjkBWmo8UEgo8VXNEKHN2qSJJ8udkzP8DeH1oYG4-Cc9r1UE8XcavlPJOmB4eQcrTipIZNFqeSYwyWCI6oGhum_NW2sR2TvzQYVzS8NEQi8I8J42esbVLBQnOCjegriVNy3AJqmwlvIkXqG9IXRA1zsAcQnUDpjs7x6ThOPvr00-mSp11qHNZ5aQLGhBf4nbaM6I9fALeMf984mcpHSMVwhx6aS5DZiwLooxcyRxmYPvTEG1FzBepUuBm8O5XNNBe_p_50ZdwUcSFW0qBdfTCvNdAnhfSf5DA0VIehZsv-0uHt-QqeDk1wNvGI8g-NB66O4iz5Ywm1M1BZ7qaGNUonHZBVaaeMWfHVQB94wj6NxOhJCGmXuBfn99WEe82GBF4zn9bjOaedAAR2-Pz2lw3J0BZbEzix6VIKyHzzD1Egq1I_6uW1mkb40Aiqa-xX4cudg6rfXTeW007lcK7TD1TqKaxDrQMfjxzV-0f4Fscsb7aznqLYP21cFlk0IEbQklRwfjMVnS_S1q8llGoA1h=w495-h921-no" alt="Servlets Framework" /><br />
</p>

<h3>Servlet Interface</h3>

<p>
The javax.servlet.Servlet interface is the heart of the servlet architecture.
All servlets must implement this Servlet interface.
Servlet lifecycle methods are declared in the body of the servlet interface.
</p>

<ul>
	<li>init(): initializes a servlet.</li>
	<li>service(): services to client requests.</li>
	<li>destroy(): stops service, returns resources.</li>
</ul>

<h4>init()</h4>

<p>
The servlet container calls the init() method once after the servlet object is created.
The servlet can be serviced only when the init() method completes without errors.
The request before the init() method completes is blocked.
When the init() method is called, it receives the object of the ServletConfig interface type as argument,
If you set the Servlet initialization parameters in web.xml, this ServletConfig will have the Servlet initialization parameters information set in web.xml.
If there are the Servlet initialization parameters, then the init() method should have code to do the initialization of the servlet.
</p>
 
<pre class="prettyprint no-border">
void init(ServletConfig config) throws ServletException;
</pre>

<h4>service()</h4>

<p>
Each time a client sends a request to a servlet, the servlet container calls the service() method of the servlet.
The service() method reads the request information using an object of the ServletRequest type, which is the first argument, and responds to the client using an object of the ServletResponse type, which is the second argument.
Note that the servlet container executes the service() method on the new thread whenever the client requests it.

The service () method runs simultaneously on a separate thread, so it can respond to a large number of client requests without delay.
However, critical section problems can arise with the resources that the servlet uses (eg, files, network connections, static variables, instance variables, etc.).

Therefore, it is best not to create static or instance variables that can cause problems with your servlets.
Synchronizing the resources used by the servlet is not good code in most cases.
</p>

<pre class="prettyprint no-border">
void service(ServletRequest req, ServletResponse res) throws ServletException, IOException;
</pre>


<h4>destroy()</h4>

<p>
It is called by the servlet container when the servlet should no longer be serviced.
This method is not what the programmer calls in code.
To call destroy(), you must use the "Tomcat manager" to unload the application or shut down Tomcat.
Tomcat manager is a web application that can be accessed at http://localhost:port/manager. 
It is the web application that manages web applications.
To view the Tomcat Manager screen, you must log in using the administrator and administrator password you set when installing Tomcat.
If you do not remember your administrator and Administrator password, open {TOMCAT_HOME}/conf/tomcat-users.xml and you'll see it.  
</p>

<pre class="prettyprint no-border">
void destroy();
</pre>


<h3>GenericServlet abstract class</h3>

<p>
Most servlets inherit the GenericServlet class.
The GenericServlet class implements the ServletConfig interface.
GenericServlet implements the Servlet interface incompletely.
Because GenericServlet does not implement the service() method of the Servlet interface, 
GenericServlet's service() method is an abstract method, so GenericServlet is an abstract class.
Subclasses that inherit GenericServlet must implement the service() method.
</p>

<pre class="prettyprint no-border">
public abstract void service(ServletRequest req, ServletResponse res) throws ServletException, IOException;
</pre>

<p>
The init(ServletConfig config) method is implemented in GenericServlet as follows:
</p>

<pre class="prettyprint no-border">
public void init(ServletConfig config) throws ServletException {
	this.config = config;
	<strong>this.init();</strong>
}
</pre>

<p>
The init(ServletConfig config) method calls the init() method with no parameters on the last line.
The parameterless init() method was added to the GenericServlet for convenience,
This method has nothing in the method body as shown below.
</p>

<pre class="prettyprint no-border">
public void init() throws ServletException {

}
</pre>

<p>
It is convenient to override this method rather than overriding the init(ServletConfig config) method in the sub class.
This is because you do not have to worry about storing the ServletConfig object.
When overriding the init(ServletConfig config) method in a sub class, you need to add super(config); code on the first line.
Without this code, the servlet will not store ServletConfig objects.
</p>

<p>
The init(ServletConfig config) method saves the ServletConfig object received as an argument in the instance variable config.
The getServletConfig () method of GenericServlet returns this config.
</p>

<pre class="prettyprint no-border">
public ServletConfig getServletConfig() {
	return config;
}
</pre>

<p>
The getServletContext() is method of ServletConfig interface.
GenericServlet implements ServletConfig interface.
The getServletContxt() method of GenericServlet returns an object of type ServletContext as shown below.
</p>

<pre class="prettyprint no-border">
public ServletContext getServletContext() {
	return getServletConfig().getServletContext();
}
</pre>

<p>
The getInitParameter() and getInitParameterNames() methods of the ServletConfig interface are implemented as follows in the GenericServlet.
</p>

<pre class="prettyprint no-border">
public String getInitParameter(String name) {
	return getServletConfig().getInitParameter(name);
}
</pre>

<pre class="prettyprint no-border">
public Enumeration getInitParameterNames() {
	return getServletConfig().getInitParameterNames();
}   
</pre>

<p>
It is for the convenience of the programmer that GenericServlet implements ServletConfig.
Let's look at examples.
It is convenient to use this.getServletContext(); rather than this.getServletConfig().GetServletContext(); to get a reference to a ServletContext object in a servlet.
It is convenient to use String driver = this.getInitParameter("driver"); rather than String driver = this.getServletConfig().GetInitParameter("driver"); to get servlet initialization parameter information.
</p>


<h3>HttpServlet class</h3>

<p>
A servlet servicing an HTTP request must inherit HttpServlet.
The HttpServlet class inherits the GenericServlet abstract class and is a servlet specific to the HTTP protocol.

The HttpServlet class provides methods for handling HTTP requests.
The client's request is passed to the servlet as the HttpServletRequest object type, and the servlet responds using the HttpServletResponse object type.

The HttpServlet class implements the GenericServlet's service () abstract method by simply calling the protected void service (HttpServletRequest req, HttpServletResponse resp) method.
</p>

<pre class="prettyprint">
public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
	
	HttpServletRequest  request;
	HttpServletResponse response;
	
	try {
		request = (HttpServletRequest) req;
		response = (HttpServletResponse) res;
	} catch (ClassCastException e) {
		throw new ServletException(&quot;non-HTTP request or response&quot;);
	}
	
	<strong>service(request, response);</strong>
}
</pre>

<p>
Eventually, the following method handles the HTTP request.
</p>

<pre class="prettyprint">
protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	String method = req.getMethod();

	if (method.equals(METHOD_GET)) {
		long lastModified = getLastModified(req);
		if (lastModified == -1) {
			// servlet doesn't support if-modified-since, no reason
			// to go through further expensive logic
			<strong>doGet(req, resp);</strong>
		} else {
			long ifModifiedSince = req.getDateHeader(HEADER_IFMODSINCE);
			if (ifModifiedSince &lt; (lastModified / 1000 * 1000)) {
				// If the servlet mod time is later, call doGet()
				// Round down to the nearest second for a proper compare
				// A ifModifiedSince of -1 will always be less
				maybeSetLastModified(resp, lastModified);
				<strong>doGet(req, resp);</strong>
			} else {
				resp.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
			}
		}
	} else if (method.equals(METHOD_HEAD)) {
		long lastModified = getLastModified(req);
		maybeSetLastModified(resp, lastModified);
		doHead(req, resp);
	} else if (method.equals(METHOD_POST)) {
		<strong>doPost(req, resp);</strong>
	} else if (method.equals(METHOD_PUT)) {
		doPut(req, resp);
	} else if (method.equals(METHOD_DELETE)) {
		doDelete(req, resp);
	} else if (method.equals(METHOD_OPTIONS)) {
		doOptions(req,resp);
	} else if (method.equals(METHOD_TRACE)) {
		doTrace(req,resp);
	} else {
		//
		// Note that this means NO servlet supports whatever
		// method was requested, anywhere on this server.
		//
		String errMsg = lStrings.getString("http.method_not_implemented");
		Object[] errArgs = new Object[1];
		errArgs[0] = method;
		errMsg = MessageFormat.format(errMsg, errArgs);

		resp.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED, errMsg);
	}
}	
</pre>

<p>
The only thing the HttpServlet's +service() method does is call the #service() method.
(Where + denotes the public access modifier and # the protected access modifier)
When the #service() method of the HttpServlet class is called, this method reads the HTTP METHOD (eg, POST, GET etc.) in the request object (an object of type HttpServletRequest) and calls the matching method according to this value.
For example, if the HTTP method is "GET", it calls doGet() and if it is "POST" it calls the doPost() method.
Methods like doGet() and doPost() are the methods we need to override.

The HttpServletRequest interface inherits the ServletRequest interface.
The HttpServletResponse interface inherits the ServletResponse interface.
When a client's request comes in, the servlet container creates an object of type HttpServletRequest and an object of type HttpServletResponse and passes them as the argument values to the servlet's +service(ServletRequest req, ServletResponse res) method.
Making classes that implement the HttpServletRequest and HttpServletResponse interfaces is the responsibility of the vendor making the servlet container.
</p>

<h2>Summary of Servlet API</h2>
<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">Servlet Interface</dt>
	<dd class="api-summary-dd">init(ServletConfig config)</dd>
	<dd class="api-summary-dd">service(ServletRequest req, ServletResponse res)</dd>
	<dd class="api-summary-dd">destroy()</dd>
	<dd class="api-summary-dd">getServletConfig():ServletConfig</dd>
	<dd class="api-summary-dd-method-desc">Returns a ServletConfig object that contains variables related to servlet initialization</dd>
	<dd class="api-summary-dd">getServletInfo():String</dd>
	<dd class="api-summary-dd-method-desc">Return simple information about the servlet</dd>
</dl>	

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">ServletConfig Interface</dt>
	<dd class="api-summary-dd">getInitParameter(String name):String</dd>
	<dd class="api-summary-dd-method-desc">Returns the initialization parameter value corresponding to name</dd>
	<dd class="api-summary-dd">getInitParameterNames():Enumeration</dd>
	<dd class="api-summary-dd-method-desc">Return all servlet initialization parameter names as Enumeration type</dd>
	<dd class="api-summary-dd">getServletContext():ServletContext</dd>
	<dd class="api-summary-dd-method-desc">Return ServletContext</dd>
	<dd class="api-summary-dd">getServletName():String</dd>
	<dd class="api-summary-dd-method-desc">Return the name of the servlet instance</dd>
</dl>


<dl class="api-summary">
	<dt class="api-summary-dt">+GenericServlet Abstract class</dt>
	<dd class="api-summary-dd-class-desc bottom-line">This class provides basic services that are protocol independent. This class implements the Servlet, ServletConfig interface.</dd>
	<dd class="api-summary-dd">+init()</dd>
	<dd class="api-summary-dd-method-desc">Servlet initialization method, which is called by GenericServlet's init(ServletConfig config) method</dd>
	<dd class="api-summary-dd">&lt;&lt;abstract&gt;&gt; +service(ServletRequest req, ServletResponse res)</dd>
	<dd class="api-summary-dd-method-desc">The GenericServlet abstract class still does not implement the service() method of the Servlet interface.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpServlet Abstract class</dt>
	<dd class="api-summary-dd-class-desc bottom-line">Inherits GenericServlet.</dd>
	<dd class="api-summary-dd">#doGet(HttpServletRequest req, HttpServletResponse resp)</dd>
	<dd class="api-summary-dd-method-desc">Method to handle HTTP GET requests</dd>
	<dd class="api-summary-dd">#doPost(HttpServletRequest req, HttpServletResponse resp)</dd>
	<dd class="api-summary-dd-method-desc">Method to handle HTTP POST</dd>
	<dd class="api-summary-dd">+service(ServletRequest req, ServletResponse res)</dd>
	<dd class="api-summary-dd-method-desc">This method overrides GenericServlet's abstract method service(). This method does nothing other than call the #service() method.</dd>
	<dd class="api-summary-dd">#service(HttpServletRequest req, HttpServletResponse resp)</dd>
	<dd class="api-summary-dd-method-desc">Call one of doGet(req, resp), doHead(req, resp), doPost(req, resp), doGet(req, resp), doDelete(req, resp), doOptions(req, resp), doTrace(req, resp) according to the HTTP METHOD.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">ServletContext Interface</dt>
	<dd class="api-summary-dd-class-desc bottom-line">
This interface provides methods that the servlet uses to communicate with the servlet container.
It also provides functions to get the MIME type of the file, the full path of the file, the RequestDispatcher reference, or log the log file.
There is one ServletContext object for each Web application, which serves as a common repository for the dynamic components that make up the Web application.
In other words, the data stored in the ServletContext is freely accessible from servlets or JSPs within the same web application.	</dd>
	<dd class="api-summary-dd">setAttribute(Strng name, Object value)</dd>
	<dd class="api-summary-dd-method-desc">Stores the data as a name-value pair.</dd>
	<dd class="api-summary-dd">getAttribute(String name):Object</dd>
	<dd class="api-summary-dd-method-desc">Returns the data with the given name.</dd>
	<dd class="api-summary-dd">removeAttribute(String name)</dd>
	<dd class="api-summary-dd-method-desc">Removes the data with the given name.</dd>
	<dd class="api-summary-dd">getInitParameter(String name):String</dd>
	<dd class="api-summary-dd-method-desc">Returns the value of the web application initialization parameter with the given name.</dd>
	<dd class="api-summary-dd">getRequestDispatcher(String path):RequestDispatcher</dd>
	<dd class="api-summary-dd-method-desc">Returns a RequestDispatcher object for the resource located at the given path.</dd>
	<dd class="api-summary-dd">getRealPath(String path):String</dd>
	<dd class="api-summary-dd-method-desc">Returns the real path for a given virtual path.</dd>
	<dd class="api-summary-dd">getResource(String path):URL</dd>
	<dd class="api-summary-dd-method-desc">Returns a URL to the resource that is mapped to a specified path.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">RequestDispatcher Interface</dt>
	<dd class="api-summary-dd-class-desc bottom-line">It is used to pass a client's request to another resource (servlet, JSP) or to include the contents of another resource in a response.</dd>
	<dd class="api-summary-dd">forward(ServletRequest req, ServletResponse res)</dd>
	<dd class="api-summary-dd-method-desc">Forward the client's request to another resource.</dd>
	<dd class="api-summary-dd">include(ServletRequest req, ServletResponse res)</dd>
	<dd class="api-summary-dd-method-desc">Include the contents of other resources in the response.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">ServletRequest Interface</dt>
	<dd class="api-summary-dd-class-desc bottom-line">Contains client request information.</dd>
	<dd class="api-summary-dd">setAttribute(String name, Object o)</dd>
	<dd class="api-summary-dd-method-desc">Stores the data as a name-value pair.</dd>
	<dd class="api-summary-dd">getAttribute(String name):Object</dd>
	<dd class="api-summary-dd-method-desc">Returns the stored data with the given name.</dd>
	<dd class="api-summary-dd">removeAttribute(String name)</dd>
	<dd class="api-summary-dd-method-desc">Removes the stored data with the given name.</dd>
	<dd class="api-summary-dd">getInputStream():ServletInputStream</dd>
	<dd class="api-summary-dd-method-desc">Returns an input stream to read the binary data in the body of the request</dd>
	<dd class="api-summary-dd">getParameter(String name):String</dd>
	<dd class="api-summary-dd-method-desc">Returns the value of the HTTP parameter with the given name</dd>
	<dd class="api-summary-dd">getParameterNames():Enumeration</dd>
	<dd class="api-summary-dd-method-desc">Return all HTTP parameter names as an Enumeration type</dd>
	<dd class="api-summary-dd">getParameterValues(String name):String[]</dd>
	<dd class="api-summary-dd-method-desc">Returns all the values of the HTTP parameter with the given name as a String array. Used when there are multiple values in a single HTTP parameter, such as a checkbox or a multiple-selection list.</dd>
	<dd class="api-summary-dd">getServletPath():String</dd>
	<dd class="api-summary-dd-method-desc">Returns the path starting with "/". The returned path does not include the query string.</dd>
	<dd class="api-summary-dd">getRemoteAddr():String</dd>
	<dd class="api-summary-dd-method-desc">Returns the client's IP address.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpServletRequest Interface</dt>
	<dd class="api-summary-dd-class-desc bottom-line">Inherits ServletReqeust.</dd>
	<dd class="api-summary-dd">getCookies():Cookie[]</dd>
	<dd class="api-summary-dd-method-desc">Returns an array of cookies passed by the browser</dd>
	<dd class="api-summary-dd">getSession():HttpSession</dd>
	<dd class="api-summary-dd-method-desc">Returns current session (HttpSession).</dd>
	<dd class="api-summary-dd">getSession(boolean created):HttpSession</dd>
	<dd class="api-summary-dd-method-desc">Returns current session. If the session is not created, if the created is true, the session is created and returned. If the created is false, the null is returned.</dd>
	<dd class="api-summary-dd">getContextPath():String</dd>
	<dd class="api-summary-dd-method-desc">Returns the part of the request URI that points to the context. If you request http://localhost:port/contextPath/board/list.jsp?page=1, it will return "/contextPath".</dd>
	<dd class="api-summary-dd">getRequestURI():String</dd>
	<dd class="api-summary-dd-method-desc">If you request http://localhost:port/ContextPath/board/list.jsp?page=1, it will return "/ContextPath/board/list.jsp".</dd>
	<dd class="api-summary-dd">getQueryString():String</dd>
	<dd class="api-summary-dd-method-desc">If you request http://localhost:port/ContextPath/board/list.jsp?page=1, it will return "page=1".</dd>
</dl>


<dl class="api-summary">
	<dt class="api-summary-dt">ServletResponse Interface</dt>
	<dd class="api-summary-dd-class-desc bottom-line">Used to send responses to clients.</dd>
	<dd class="api-summary-dd">getOutputStream():ServletOutputStream</dd>
	<dd class="api-summary-dd-method-desc">Returns an output stream to send binary data in response.</dd>
	<dd class="api-summary-dd">getWriter():PrintWriter</dd>
	<dd class="api-summary-dd-method-desc">Returns an output stream to send character data in response.</dd>
	<dd class="api-summary-dd">setContentType(String type)</dd>
	<dd class="api-summary-dd-method-desc">
Used to set the MIME type of response data.
(For example, 
if the response data is HTML, set MIME to text/html, 
if plain text, set MIME to text/plain, 
if binary data, set MIME to application/octet-stream.
Should be called before the getWriter() method)
	</dd>
	<dd class="api-summary-dd">getContentType():String</dd>
	<dd class="api-summary-dd-method-desc">
Return the MIME type specified by the setContentType() method
Returns null if not specified
	</dd>
	<dd class="api-summary-dd">setCharacterEncoding(String charset)</dd>
	<dd class="api-summary-dd-method-desc">
Set the character set of response data.
To set it to UTF-8, code as setCharacterEncoding ("UTF-8");.
SetCharacterEncoding("UTF-8"); is equivalent to <em>charset=UTF-8</em> in setContentType("text/html; <em>charset=UTF-8</em>"); in JSP code.
Should be called before the getWrite() method is executed.
	</dd>
	<dd class="api-summary-dd">getCharacterEncoding():String</dd>
	<dd class="api-summary-dd-method-desc">
Returns the character set of the response data.
Returns "ISO-8859-1" if no character set is specified.
	</dd>
	<dd class="api-summary-dd">setContentLength(int length)</dd>
	<dd class="api-summary-dd-method-desc">
Sets the size of the response data to an int value.
Can be used to indicate to what extent the client is downloading the response data from the server.	
	</dd>				
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpServletResponse Interface</dt>
	<dd class="api-summary-dd-class-desc bottom-line">
Inherits the ServletResponse interface. 
Used to send an HTTP response to the client.
	</dd>
	<dd class="api-summary-dd">addCookie(Cookie cookie)</dd>
	<dd class="api-summary-dd-method-desc">Adds a cookie to the response.</dd>
	<dd class="api-summary-dd">sendRedirect(String location)</dd>
	<dd class="api-summary-dd-method-desc">Redirects to the given URL.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpSession Interface</dt>
	<dd class="api-summary-dd-class-desc bottom-line">Used to store user information needed for session maintenance on the server side.</dd>
	<dd class="api-summary-dd">getAttribute(String name):Object</dd>
	<dd class="api-summary-dd">setAttribute(String name, Object value)</dd>
	<dd class="api-summary-dd">removeAttribute(String name)</dd>
	<dd class="api-summary-dd">invalidate()</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">Cookie</dt>
	<dd class="api-summary-dd-class-desc bottom-line">
Cookies are the information stored on the client side for session maintenance.
To maintain the session, the web browser adds this cookie information to the request whenever it sends a request to the server that sent the cookie.

Cookies can store multiple name-value pairs.
In addition, cookies can have optional values for path, domain, expiration date, and security.

To create a cookie on a server element, you need code that adds a string of the promised format to the response header.
A web browser that receives a response containing cookie information will also send cookie information every time it sends the request to the server.
The cookie information passed to the server element can be obtained as an array type using the getCookie() method of HttpServletRequest.
Cookie or session are the technology that overcomes the limitations of the HTTP protocol to disconnect after a response.
	</dd>
	<dd class="api-summary-dd">Cookie(String name, String value)</dd>
	<dd class="api-summary-dd">getName():String</dd>
	<dd class="api-summary-dd">getValue():String</dd>
	<dd class="api-summary-dd">setValue(String newValue)</dd>
	<dd class="api-summary-dd">getPath():String</dd>
	<dd class="api-summary-dd">setPath(String uri)</dd>
	<dd class="api-summary-dd">getDomain():String</dd>
	<dd class="api-summary-dd">setDomain(String pattern)</dd>
	<dd class="api-summary-dd">getMaxAge():int</dd>
	<dd class="api-summary-dd">setMaxAge(int expiry)</dd>
	<dd class="api-summary-dd">getSecure():boolean</dd>
	<dd class="api-summary-dd">setSecure(boolean flag)</dd>
</dl>


<h2>Servlet Examples</h2>

<p>
Write all the examples below in the ROOT application.
In the <a href="Creating-a-new-web-application">Creating a new web application</a>, 
we changed the application with the document base C:/www/myapp to the ROOT application.
Create JSPs in C:/www/myapp and java sources in C:/www/myapp/WEB-INF/src.
Instead of using Eclipse, use a regular editor such as EditPlus.
</p>

<em class="filename">SimpleServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SimpleServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
    	
		out.println("&lt;html&gt;");
		out.println("&lt;body&gt;");
    	
		//Output the IP of client
		out.println("Your IP Address is " + req.getRemoteAddr() + ".\n");
		out.println("&lt;/body&gt;&lt;/html&gt;");
		out.close();
	}
  
}
</pre>

<p>
SimpleServlet does not implement servlet lifecycle methods init() and destroy().
These methods are already implemented in the GenericServlet and are not visible in the above sources because there is no reason to override them.
Open the /WEB-INF/web.xml file and add the servlet element to the sub element of the web-app element as shown below.
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
	&lt;servlet-name&gt;SimpleServlet&lt;/servlet-name&gt;
	&lt;servlet-class&gt;example.SimpleServlet&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
	&lt;servlet-name&gt;SimpleServlet&lt;/servlet-name&gt;
	&lt;url-pattern&gt;/simple&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
At the command prompt, navigate to the folder where SimpleServlet.java is located and compile as shown below.
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 8.0/lib/servlet-api.jar" ^
SimpleServlet.java
</pre>

<dl class="note">
<dt>package javax.servlet.http does not exist</dt>
<dd>
The above compilation error means that the Java compiler can not find the javax.servlet.http package.
This is because you did not add the full path to the servlet-api.jar file as the javac's cp option value.
If the path you are adding as a cp option value contains a space, you must enclose it with "".
</dd>
</dl>

<p>
Restart Tomcat and visit http://localhost:port<em>/simple</em>.
</p>

<h3>SimpleServlet.java source description</h3>

<pre class="prettyprint">
public class SimpleServlet extends HttpServlet
</pre>

<p>
Servlets that inherit the HttpServlet class must be declared public.
</p>

<pre class="prettyprint">
@Override
public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	doPost(req, resp);
}

@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	//.. omit ..
}
</pre>

<p>
The doGet() and doPost() methods are methods that override the doGet() and doPost() methods of HttpServlet.
A servlet that receives a GET request overrides the doGet() method.
It is a request of the GET method to request the resource of the web server by inputting the address in the web browser.
In the above example, the doGet() method calls the doPost() method.
Therefore, the same code is executed whether it is a GET or a POST request.
The doGet() and doPost() methods have HttpServletRequest and HttpServletResponse as parameters.
</p>

<pre class="prettyprint">
resp.setContentType("text/html; charset=UTF-8");
PrintWriter out = resp.getWriter();
</pre>

<p>
resp.setContentType("text/html; charset=UTF-8") sets the content type of the response (HttpServletResponse).
That is, this code sets the MIME <sup><a href="#comments">2</a></sup> type of the document to be output in response to the web browser.
This code can be used only once in a servlet and must be executed before getting a PrintWriter object.
Removing the <em>; charset=UTF-8</em> part breaks non-English characters.
PrintWriter object can be obtained by calling getWriter() of the HttpServletResponse as follows:
</p>

<pre class="prettyprint no-border">
PrintWriter out = resp.getWriter();

out.println("&lt;html&gt;");
out.println("&lt;body&gt;");

//Output the IP of client
out.println("Your IP Address is " + req.getRemoteAddr() + ".\n");
</pre>

<p>
PrintWriter's println() method prints the string passed as argument value to the client's web browser.
As you can see, SimpleServlet uses PrintWriter's println() method to send HTML to the client.

HttpServletRequest's getRemoteAddr() is a method that returns the IP address of the client.
HttpServeltRequest object contains the information sent by the client and information about the client.

Let's take a look at the process until the SimpleServlet servlet sends a response.
The client uses the web browser to request the server's SimpleSerlvet.
Tomcat calls the + service(ServletRequest req, ServletResponse res) method of SimpleServlet 
and passes the object (HttpSerlvetRequest interface implementation) encapsulating the client 's request 
and the response object (HttpSerlvetResponse interface implementation) as method arguments.
The +service(ServletRequest req, ServletResponse res) method simply calls the #service(HttpServletRequest req, HttpServletResponse resp) method.
The #service(HttpServletRequest req, HttpServletResponse resp) method invokes methods such as doGet() or doPost() depending on the HTTP method type (GET, POST, etc.).
The above example is a GET request because you requested a servlet resource from the web browser address bar.
So the doGet() method is called.
</p>

<h2>How user sends string data to server-side resources and how server-side resources receive data</h2>

<p>
In the Web environment, dynamic elements are elements that respond differently depending on the string data sent by the client.
Web programmers who need to create dynamic elements on the Web need to know how to let a client send string data to a server-side resource using a web browser, and how to obtain string data sent by a client on a server-side resource.
All web programmers mainly use form and its sub-elements to allow clients to send string data to server-side resources.<sup><a href="#comments">3</a></sup>
The data that the client sends is passed to the server-side resource specified by the form element's action attribute.
</p>

<h3>How to transfer parameters and how to get the values of the parameters sent</h3>

<p>
In the table below, the "HTML Form" item shows the HTML tag for receiving the value from the user, 
and the "Servlet" item shows how servlet to get the parameter values sent from the client.
</p>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">HTML Form</th>
	<th class="table-in-article-th">Servlet</th>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;input type="text" name="<strong>addr</strong>" /&gt;
</pre>	
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParameter("<strong>addr</strong>");
</pre>
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;input type="radio" name="<strong>os</strong>" value="Windows" /&gt;
&lt;input type="radio" name="<strong>os</strong>" value="Linux" /&gt;
</pre>				
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParameter("<strong>os</strong>");
</pre>
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;input type="hidden" name="<strong>curPage</strong>" value="1" /&gt;
</pre>	
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParameter("<strong>curPage</strong>");
</pre>
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;input type="password" name="<strong>passwd</strong>" /&gt;
</pre>
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParamter("<strong>passwd</strong>");
</pre>
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;textarea name="<strong>content</strong>" cols="60" rows="12"&gt;blah blah&lt;/textarea&gt;
</pre>	
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParamter("<strong>content</strong>");
</pre>
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;select name="<strong>grade</strong>"&gt;
	&lt;option value="A"&gt;A&lt;/option&gt;
	&lt;option value="B"&gt;B&lt;/option&gt;
	&lt;option value="C"&gt;C&lt;/option&gt;
	&lt;option value="D"&gt;D&lt;/option&gt;
	&lt;option value="F"&gt;F&lt;/option&gt;
&lt;/select&gt;
</pre>	
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParameter("<strong>grade</strong>");
</pre>
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;input type="checkbox" name="<strong>hw</strong>" value="Intel" /&gt;
&lt;input type="checkbox" name="<strong>hw</strong>" value="AMD" /&gt;
</pre>	
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParameterValues("<strong>hw</strong>");
</pre>
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
&lt;select name="<strong>sports</strong>" <strong>multiple="multiple"</strong>&gt;
	&lt;option value="soccer"&gt;Soccer&lt;/option&gt;
	&lt;option value="baseball"&gt;Baseball&lt;/option&gt;
	&lt;option value="basketball"&gt;Basketball&lt;/option&gt;
&lt;/select&gt;
</pre>	
	</td>
	<td class="table-in-article-td">
<pre class="prettyprint no-border">
req.getParameterValues("<strong>sports</strong>");
</pre>
	</td>
</tr>
</table>

<h4>getParameter(String name)</h4>

<p>
The getParameter(String name) method of ServletRequest is the most common method used to get data sent by the user.
The type of character data that the client sends to the server is a parameter name-value pair.
Here, the name of the parameter is the value of the name attribute of the form's subelements (input, textarea, select, etc.), and value is the user input.
 
In the server-side resource code, 
if the name of the parameter passed by the client is given as the argument of the getParameter(String name) method, 
this method returns the value that the user has entered or selected.

An input element whose type attribute value is radio is called a radio button.
Radio buttons with the same name attribute value can form a group and select only one item within a group.
</p>

<h4>getParameterValues(String name)</h4>

<p>
When a client sends multiple values with one parameter, the getParamterValues(String name) method of the HttpServletRequest is needed to get these values from the server-side resource.
This method returns an array of strings consisting of the values chosen by the user.

If you want the client to send multiple values with one parameter, add the checkbox or select element whose multiple attribute value is "multiple" to your HTML.
(the checkbox indicates that the value of the type attribute of the input element is "checkbox")
If the value of the name attribute is the same, these checkboxes belongs to the same group.
A checkbox differs from a radio button in that multiple checkboxes within a group can be selected.

With the select element, the user can generally select only one item.
However, if the select element's multiple attribute value is set to "multiple", the user can select multiple items using the Ctrl or Shift buttons.
</p>

<h4>getParamterNames()</h4>

<p>
To find out what parameter the user is sending, the server side code needs the getParamterNames() method of HttpServletRequest.
The getParameterNames() method returns an Enumeration<sup><a href="#comments">4</a></sup> type object containing the parameter names.
</p>

<dl class="note">
<dt>input type="file"</dt>
<dd>
&lt;input type="file" ../&gt; is used to transfer binary data such as images to the server. 
The parent element, form should be &lt;form method="post" enctype="multipart/form-data"...&gt;

If you need to send other additional information (For example, string data such as name, title, content, etc.) as well as the file you are uploading, 
add other elements, which are sending strings in the form element including &lt;input type="file" /&gt;.

If you press the submit button, the data will be transmitted with a different protocol than when sending only the string.
Therefore, you can not access data sent using the getParameter(String name) method.
Although you can directly implement methods to access data sent with binary data and binary data using the Servlet API, most programmers use external libraries in this case.
</dd>
</dl>

<h3>String transfer example</h3>

<p>
Let's practice how to receive data from the user in the servlet through the below example.
Create SignUp.html in the documentbase/example diretory.
</p>

<em class="filename">/example/SignUp.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Sign Up&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h3&gt;Sign Up&lt;/h3&gt;

&lt;form id="joinForm" action="../RegisterServlet" method="post"&gt;
&lt;div&gt;ID &lt;input type="text" name="id" /&gt;&lt;/div&gt;
&lt;div&gt;Nickname &lt;input type="text" name="nickname" /&gt;&lt;/div&gt;
&lt;div&gt;Password &lt;input type="password" name="passwd" /&gt;&lt;/div&gt;
&lt;div&gt;Name &lt;input type="text" name="name" /&gt;&lt;/div&gt;
&lt;div&gt;Gender Male &lt;input type="radio" name="gender" value="M" /&gt; Female &lt;input type="radio" name="gender" value="F" /&gt;&lt;/div&gt;
&lt;div&gt;Birthday &lt;input type="text" name="birthday" /&gt;&lt;/div&gt;
&lt;div&gt;Mobile &lt;input type="text" name="mobile" /&gt;&lt;/div&gt;
&lt;div&gt;Telephone &lt;input type="text" name="tel" /&gt;&lt;/div&gt;
&lt;div&gt;Address &lt;input type="text" name="address" /&gt;&lt;/div&gt;
&lt;div&gt;Email &lt;input type="text" name="email" /&gt;&lt;/div&gt;
&lt;div&gt;
Sports
&lt;input type="checkbox" name="sports" value="soccer" /&gt;soccer
&lt;input type="checkbox" name="sports" value="baseball" /&gt;baseball
&lt;input type="checkbox" name="sports" value="basketball" /&gt;Basketball
&lt;input type="checkbox" name="sports" value="tennis" /&gt;Tennis
&lt;input type="checkbox" name="sports" value="tabletennis" /&gt;Tabletennis
&lt;/div&gt;
&lt;div&gt;
Lectures
&lt;select name="main-menu" multiple="multiple"&gt;
	&lt;option value=""&gt;-- Multiple Select --&lt;/option&gt;
	&lt;option value="java"&gt;JAVA&lt;/option&gt;
	&lt;option value="jdbc"&gt;JDBC&lt;/option&gt;
	&lt;option value="jsp"&gt;JSP&lt;/option&gt;
	&lt;option value="css-layout"&gt;CSS Layout&lt;/option&gt;
	&lt;option value="jsp-prj"&gt;JSP Project&lt;/option&gt;
	&lt;option value="spring"&gt;Spring&lt;/option&gt;
	&lt;option value="javascript"&gt;JavaScript&lt;/option&gt;
&lt;/select&gt;
&lt;/div&gt;
&lt;div&gt;
About Me
&lt;textarea name="aboutMe" cols="40" rows="7"&gt;&lt;/textarea&gt;
&lt;/div&gt;
&lt;div&gt;&lt;input type="submit" value="Submit" /&gt;&lt;/div&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Create RegisterServlet.java in /WEB-INF/src/example directory as shown below.
</p>

<em class="filename">RegisterServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegisterServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException,ServletException {
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("id");
		
		out.println("&lt;html&gt;&lt;body&gt;");
		out.println("id : " + id);
		
		String[] sports = req.getParameterValues("sports");
		int len = sports.length;
		
		out.println("&lt;ol&gt;");
		for (int i = 0; i &lt; len; i++) {
			out.println("&lt;li&gt;" + sports[i] + "&lt;/li&gt;");
		}
		
		out.println("&lt;/ol&gt;");
		
		String path = req.getContextPath();
		out.println("&lt;a href=" + path + "/example/SignUp.html&gt;Join&lt;/a&gt;");
		out.println("&lt;/body&gt;&lt;/html&gt;");
	}
}
</pre>

<p>
Open a command prompt and go to /WEB-INF/src/example and compile as below.
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 8.0/lib/servlet-api.jar" ^
RegisterServlet.java
</pre>

<p>
Add the following to web.xml:
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;			
    &lt;servlet-name&gt;RegisterServlet&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.RegisterServlet&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;RegisterServlet&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/RegisterServlet&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
After restarting Tomcat, go to http://localhost:port/example/SignUp.html.
TODO: Add a code to the servlet to check for values other than ID and sports.
</p>

<h2>RequestDispatcher Interface</h2>

<p>
RequestDispathcer has two methods, include() and forward().
The include() method is used to pass control to another resource and to take control again when another resource is completed.
It is used to add messages produced by other resources to the response.

The forward () method passes control to another resource. 
As a result, the resource that receives the control responds to the client.

Let's practice the forward () method example.
Create the ControllerServlet.java file in the /WEB-INF/src/example directory as follows:
</p>

<em class="filename">ControllerServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = null;
		String view = null;
		boolean isRedirect = false;
		
		command = uri.substring(contextPath.length());
		
		if (command.equals("/example/SignUp.action")) {
			view = "/example/SignUp.html";
		}
		
		if (isRedirect == false) {
			ServletContext sc = this.getServletContext();
			RequestDispatcher rd = sc.getRequestDispatcher(view);
			<strong>rd.forward(req, resp);</strong>
		} else {
			resp.sendRedirect(view);
		}
	}
}
</pre>

<p>
Open a command prompt and go to /WEB-INF/src/example and compile as follows:
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 8.0/lib/servlet-api.jar" ^
ControllerServlet.java
</pre>

<p>
Add the following to web.xml:
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;Controller&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.ControllerServlet&lt;/servlet-class&gt;
    &lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;Controller&lt;/servlet-name&gt;
    &lt;url-pattern&gt;*.action&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
After restarting Tomcat, go to http://localhost:port<span class="emphasis">/example/SignUp.action</span> and verify that /example/SignUp.html responds.
TODO: In ControllerServlet.java, change isRedirect to true and recompile and test.
</p>

<p>
We have added ControllerServlet servlet declarations and mappings in web.xml so that ControllerServlet would handle all requests ending in .action.
When a request string which ends in .action comes, Tomcat interprets the mapping information in web.xml and invokes the +servlet(servletRequest req, ServletResponse resp) method of the ControllerServlet servlet.
The +service(ServletRequest req, ServletResponse resp) method simply calls the #service(HttpServletRequest req, HttpServletResponse resp) method.
The #service (HttpServletRequest req, HttpServletResponse resp) method checks the HTTP METHOD of the request and calls the appropriate method.
This is the GET method because you requested http://localhost:port/example/SignUp.action in the address bar of your web browser.
So, doGet() method is called.
The controllerServlet's doGet() method simply calls doPost().
The following table summarizes the HttpServletRequest methods used in the implementation of doPost().
</p>

<table>
<tr>
	<th>getRequestURI()</th>
</tr>
<tr>	
	<td>
When requesting http://localhost:port/example/SignUp.action in a web browser, it returns "/example/SignUp.action".	
	</td>
</tr>
<tr>
	<th>getContextPath()</th>
</tr>
<tr>	
	<td>
Returns the value of the path property of the context file (this value is called ContextPath).
As we work in the ROOT application, the value we can get through this method is "".
	</td>
</tr>
<tr>
	<th>req.getRequestURI().substring(req.getContextPath().length())</th>
</tr>
<tr>	
	<td>
The above code returns "/example/SignUp.action".
	</td>
</tr>
</table>  

<p>
The user requesting /example/SignUp.action receives a response of /example/SignUp.html.
</p>

<h2>Servlet using database</h2>

<p>
Let's convert the GetEmp.java file, which we practiced in the JDBC chapter, into a servlet.
This is an example of turning a pure Java application into a servlet.
Create the GetEmpServlet.java file in the /WEB-INF/src/example directory of the ROOT application.
</p>

<em class="filename" id="GetEmpServlet">GetEmpServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetEmpServlet extends HttpServlet {
	
	private String DB_URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	private String DB_USER = "scott";
	private String DB_PASSWORD = "tiger";
	
	/*
	 * GenericServlet's init() method
	 * init(ServletConfig config) invoke this method.
	 * Therefore, you do not need to override the init(ServletConfig config) method.
	 */
	@Override
	public void init() throws ServletException {
		try {
			Class.forName( "oracle.jdbc.driver.OracleDriver" );
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "select * from emp";
		
		try {
			con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				String empno = rs.getString(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				String mgr = rs.getString(4);
				String hiredate = rs.getString(5);
				String sal = rs.getString(6);
				String comm = rs.getString(7);
				String depno = rs.getString(8);
				
				out.println( empno + " : " + ename + " : " + job + " : " + mgr + 
				" : " + hiredate + " : " + sal + " : " + comm+" : " + depno + "&lt;br /&gt;" );
			}

		} catch (SQLException e) {
			e.printStackTrace(out);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
</pre>

<p>
Use the command prompt to navigate to the /WEB-INF/src/example directory of the ROOT application and compile it as follows:
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
javac -d C:/www/myapp/WEB-INF/classes ^ 
-cp "C:/Program Files/Apache Software Foundation/Tomcat 8.0/lib/servlet-api.jar" ^
GetEmpServlet.java
</pre>

<p>
Add the following to web.xml:
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;GetEmpServlet&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.GetEmpServlet&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;GetEmpServlet&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/empList&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
Copy the JDBC driver file to {TOMCAT_HOME}/lib.
After restarting Tomcat, visit http://localhost:port<span class="emphasis">/empList</span>.
</p>

<pre class="browser">
7369 : SMITH : CLERK : 7902 : 1980-12-17 00:00:00.0 : 800 : null : 20
7499 : ALLEN : SALESMAN : 7698 : 1981-02-20 00:00:00.0 : 1600 : 300 : 30
7521 : WARD : SALESMAN : 7698 : 1981-02-22 00:00:00.0 : 1250 : 500 : 30
7566 : JONES : MANAGER : 7839 : 1981-04-02 00:00:00.0 : 2975 : null : 20
7654 : MARTIN : SALESMAN : 7698 : 1981-09-28 00:00:00.0 : 1250 : 1400 : 30
7698 : BLAKE : MANAGER : 7839 : 1981-05-01 00:00:00.0 : 2850 : null : 30
7782 : CLARK : MANAGER : 7839 : 1981-06-09 00:00:00.0 : 2450 : null : 10
7788 : SCOTT : ANALYST : 7566 : 1987-04-19 00:00:00.0 : 3000 : null : 20
7839 : KING : PRESIDENT : null : 1981-11-17 00:00:00.0 : 5000 : null : 10
7844 : TURNER : SALESMAN : 7698 : 1981-09-08 00:00:00.0 : 1500 : 0 : 30
7876 : ADAMS : CLERK : 7788 : 1987-05-23 00:00:00.0 : 1100 : null : 20
7900 : JAMES : CLERK : 7698 : 1981-12-03 00:00:00.0 : 950 : null : 30
7902 : FORD : ANALYST : 7566 : 1981-12-03 00:00:00.0 : 3000 : null : 20
7934 : MILLER : CLERK : 7782 : 1982-01-23 00:00:00.0 : 1300 : null : 10
</pre>

<p>
If you do not see the results you want, check the list below.
</p>

<ul>
	<li>Is the servlet declaration and servlet mapping added correctly to the web.xml file?</li>
	<li>Is there a GetEmpServlet bytecode in the /WEB-INF/classes/example directory.</li>
	<li>Is there an Oracle JDBC driver file (ojdbc6.jar) in the {TOMCAT_HOME}/lib directory.</li>
	<li>Did the ROOT web application load successfully?</li>
</ul>

<h2>Using ServletConfig initialization parameter</h2>

<p>
Let's modify the GetEmpServlet example to use the ServletConfig initialization parameter.
Create the following servlet in the /WEB-INF/src/example directory.
</p>

<em class="filename">InitParamServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InitParamServlet extends HttpServlet {
	
	private String url;
	private String user;
	private String passwd;
	private String driver;
	
	@Override
	public void init() throws ServletException {
		url = this.getInitParameter("url");
		user = this.getInitParameter("user");
		passwd = this.getInitParameter("passwd");
		driver = this.getInitParameter("driver");
		
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM emp";
		
		try {
			con = DriverManager.getConnection(url, user, passwd);
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				String empno = rs.getString(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				String mgr = rs.getString(4);
				String hiredate = rs.getString(5);
				String sal = rs.getString(6);
				String comm = rs.getString(7);
				String depno = rs.getString(8);
				
				out.println(empno + " : " + ename + " : " + job + " : " + mgr + 
				  " : " + hiredate + " : " + sal + " : " + comm+" : " + depno + "&lt;br /&gt;");
			}
		} catch (SQLException e) {
			e.printStackTrace(out);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
</pre>

<p>
Add the following to web.xml:
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
	&lt;servlet-name&gt;InitParamServlet&lt;/servlet-name&gt;
	&lt;servlet-class&gt;example.InitParamServlet&lt;/servlet-class&gt;
	&lt;init-param&gt;
		&lt;param-name&gt;driver&lt;/param-name&gt;
		&lt;param-value&gt;oracle.jdbc.driver.OracleDriver&lt;/param-value&gt;
	&lt;/init-param&gt;
	&lt;init-param&gt;
		&lt;param-name&gt;url&lt;/param-name&gt;
		&lt;param-value&gt;jdbc:oracle:thin:@127.0.0.1:1521:XE&lt;/param-value&gt;
	&lt;/init-param&gt;
	&lt;init-param&gt;
		&lt;param-name&gt;user&lt;/param-name&gt;
		&lt;param-value&gt;scott&lt;/param-value&gt;
	&lt;/init-param&gt;
	&lt;init-param&gt;
		&lt;param-name&gt;passwd&lt;/param-name&gt;
		&lt;param-value&gt;tiger&lt;/param-value&gt;
	&lt;/init-param&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
	&lt;servlet-name&gt;InitParamServlet&lt;/servlet-name&gt;
	&lt;url-pattern&gt;/initParam&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
The value of the initialization parameter of ServletConfig set above is obtained by using getInitParameter(String name) method of ServletConfig.
After restarting Tomcat, visit http://localhost:port<span class="emphasis">/initParam</span>.
</p>

<h2>Using ServletContext Initialization Parameters</h2>

<p>
The ServletConfig initialization parameters can only be referenced in the corresponding servlet.
The ServletContext initialization parameters can be referenced in any servlet and JSP in the web application.
The ServletContext initialization parameter is set in web.xml using the context-param element.

For the schema and dtd there is a specified order. 
The following excerpts from <a href="http://java.sun.com/dtd/web-app_2_3.dtd">http://java.sun.com/dtd/web-app_2_3.dtd</a>.
</p>

<div id="web-app" class="codebox">
&lt;!ELEMENT web-app (icon?, display-name?, description?, distributable?,
<strong>context-param*</strong>, filter*, filter-mapping*, <strong>listener*</strong>, <strong>servlet*</strong>,
servlet-mapping*, session-config?, mime-mapping*, welcome-file-list?,
error-page*, taglib*, resource-env-ref*, resource-ref*, security-constraint*,
login-config?, security-role*, env-entry*, ejb-ref*,  ejb-local-ref*)&gt;
</div>

<p>
You can see that the context-param must be declared ahead of the servlet.
Open web.xml and add the following:
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;context-param&gt;
    &lt;param-name&gt;url&lt;/param-name&gt;
    &lt;param-value&gt;jdbc:oracle:thin:@127.0.0.1:1521:XE&lt;/param-value&gt;
&lt;/context-param&gt;
</pre>

<p>
A reference to a ServletContext object can be obtained using the servlet's getServletContext() method.
The value of url, which is the ServletContext initialization parameter declared above, is obtained by using getInitParameter(String name) method of ServletContext.
Add the following code to the existing SimpleSerlvet.java in the appropriate location and recompile.
</p>

<h5>Edit SimpleServlet.java</h5>

<pre class="prettyprint">
ServletContext sc = getServletContext();
String url = sc.getInitParameter("url");
out.println(url);
</pre>

<p>
After restarting Tomcat, visit http://localhost:port/simple.
TODO: Modify InitParamServlet.java so that the url is set with the ServletContext initialization parameter.
</p>

<h2>Listener</h2>

<p>
The listener runs on the web application event.
Web application events have been added to the Servlet 2.3 specification.
Web application events are divided into:
</p>

<ul>
	<li>Application startup and shutdown</li>
	<li>Session creation and session invalidation</li>
</ul>

<p>
An application startup event occurs when a web application is first loaded and started by a servlet container, such as Tomcat.
Application shutdown events occur when the web application is shut down.
Session creation events occur when a new session is created.
Session invalidation events occur each time a session is invalidated.
To use events, you need to write a class called Listener.
The Listener class is a pure Java class that implements the following interfaces:
</p>

<ul>
	<li>javax.servlet.ServletContextListener</li>
	<li>javax.servlet.http.HttpSessionListener</li>
</ul>

<p>
If you want listeners for application startup or shutdown events, implement the ServletContextListener interface.
If you want listeners for session creation and session invalidation events, implement the HttpSessionListener interface.
The ServletContextListener interface consists of two methods:
</p>

<ul>
	<li>public void contextInitialized(ServletContextEvent sce);</li>
	<li>public void contextDestroyed(ServletContextEvent sce);</li>
</ul>

<p>
The HttpSessionListener interface consists of two methods:
</p>

<ul>
	<li>public void sessionCreated(HttpSessionEvent se);</li>
	<li>public void sessionDestroyed(HttpSessionEvent se);</li>
</ul>

<p>
Write the following Listener class, which it,  right after the web application startup, creates an OracleConnectionManager object and stores it in the ServletContext. 
</p>

<em class="filename">MyServletContextListener.java</em>
<pre class="prettyprint">
package net.java_school.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.java_school.db.dbpool.OracleConnectionManager;

public class MyServletContextListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();
		OracleConnectionManager dbMgr = new OracleConnectionManager();
		sc.setAttribute("dbMgr", dbMgr);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();
		sc.removeAttribute("dbMgr");
	}

}
</pre>

<p>
Add the following to web.xml, below the context-param, above the servlet declaration.
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;listener&gt;
	&lt;listener-class&gt;net.java_school.listener.MyServletContextListener&lt;/listener-class&gt;
&lt;/listener&gt;
</pre>

<h3 id="Custom-ConnectionPool">Using a custom connection pool</h3>
<p>
Add all the java source files from the lession entitled "<a href="../jdbc/Connection-Pool">ConnectionPool</a>" in the JDBC chapter to the ROOT application's WEB-INF/src directory.
Open Log.java and modify it as follows:
</p>

<pre class="prettyprint">
public String logFile = "C:/www/myapp/WEB-INF/myapp.log";
</pre>

<p>
Copy the orcale.properties file in the "<a href="../jdbc/Connection-Pool">ConnectionPool</a>" to the ROOT application's WEB-INF directory.
Open ConnectionManager.java and modify it as follows:
</p>

<pre class="prettyprint">
configFile = "C:/www/myapp/WEB-INF/" + poolName + ".properties";
</pre>

<p>
Now when the ROOT web application is started, an OracleConnectionManager object will be created and its reference will be stored in the ServletContext.
To test it, modify the GetEmpServlet.java file as shown below.
</p>

<em class="filename">GetEmpServlet.java</em>
<pre class="prettyprint">
package example;

import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import net.java_school.db.dbpool.*;

public class GetEmpServlet extends HttpServlet {

	<strong>private OracleConnectionManager dbMgr;</strong>
	
	@Override
	public void init() throws ServletException {
		<strong>ServletContext sc = getServletContext();</strong>
		<strong>dbMgr = (OracleConnectionManager) sc.getAttribute("dbMgr");</strong>
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM emp";
		
		try {
			con = <strong>dbMgr.getConnection();</strong>
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				String empno = rs.getString(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				String mgr = rs.getString(4);
				String hiredate = rs.getString(5);
				String sal = rs.getString(6);
				String comm = rs.getString(7);
				String depno = rs.getString(8);
				
				out.println( empno + " : " + ename + " : " + job + " : " + mgr +
					" : " + hiredate + " : " + sal + " : " + comm+" : " + depno + "&lt;br&gt;" );
			}
		} catch (SQLException e) {
			e.printStackTrace(out);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
</pre>

<p>
Compile the custom connection pool source and GetEmpServlet.java.
Restart Tomcat and visit http://localhost:port/empList.
(The declarations and mappings for the GetEmpServlet servlet have already been set up in previous exercises)
</p>

<p>
The HttpSessionListener interface consists of two methods. One for session creation events and the other for session invalidation events.
</p>

<ul>
	<li>public void sessionCreated(HttpSessionEvent se);</li>
	<li>public void sessionDestroyed(HttpSessionEvent se);</li>
</ul>

<p>
The following is an example of an HttpSessionListener.
</p>

<em class="filename">SessionCounterListener.java</em>
<pre class="prettyprint">
package net.java_school.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionCounterListener implements HttpSessionListener {

	public static int totalCount;
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		totalCount++;
		System.out.println("Session Increase. Total Sessions:" + totalCount);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		totalCount--;.
		System.out.println("Session Reduction. Total Sessions:" + totalCount);
	}
}
</pre>

<p>
Add the following to web.xml:
</p>

<pre class="prettyprint">
&lt;listener&gt;
    &lt;listener-class&gt;net.java_school.listener.SessionCounterListener&lt;/listener-class&gt;
&lt;/listener&gt;
</pre>

<p>
Restart Tomcat and visit http://localhost:port/simple.
Visit http://localhost:port/simple with another web browser.
Check the log messages in the Tomcat log file.
</p>

<h2>Filter</h2>

<p>
A filter is used when there is code that must be executed before a user's request is delivered to a server resource.
For the filter to work, you need to add filter declarations and filter mappings to web.xml.
If filter 1 followed by filter 2 in web.xml is mapped in order, then filter 1 - filter 2 - server resource - filter 2 - filter 1 - web browser will be executed in order.
The filter class must implement the javax.servlet.Filter interface.
</p>

<p>
The following is a pure Java application created to understand the filter mechanism.
</p>

<em class="filename">ChainFilter.java</em>
<pre class="prettyprint">
package net.java_school.filter;

import java.util.ArrayList;
import java.util.Iterator;

public class ChainFilter {
	private ArrayList&lt;Filter&gt; filters;
	private Iterator&lt;Filter&gt; iterator;

	public void doFilter() {
		if (iterator.hasNext()) {
			iterator.next().doFilter(this);
		} else {
			System.out.println("Run Server resource");
		}
	}

	public ArrayList&lt;Filter&gt; getFilters() {
		return filters;
	}

	public void setFilters(ArrayList&lt;Filter&gt; filters) {
		this.filters = filters;
		this.iterator = filters.iterator();
	}
	
}
</pre>

<em class="filename">Filter.java</em>
<pre class="prettyprint">
package net.java_school.filter;

public interface Filter {
	
	public void doFilter(ChainFilter chain);

}
</pre>

<em class="filename">Filter1.java</em>
<pre class="prettyprint">
package net.java_school.filter;

public class Filter1 implements Filter {

	@Override
	public void doFilter(ChainFilter chain) {
		System.out.println("Run Filter 1 before the server resource runs");
		chain.doFilter();
		System.out.println("Run Filter 1 after the server resource runs");
	}

}
</pre>

<em class="filename">Filter2.java</em>
<pre class="prettyprint">
package net.java_school.filter;

public class Filter2 implements Filter {

	@Override
	public void doFilter(ChainFilter chain) {
		System.out.println("Run Filter 2 before the server resource runs");
		chain.doFilter();
		System.out.println("Run Filter 2 after the server resource runs");
	}

}
</pre>

<em class="filename">Tomcat.java</em>
<pre class="prettyprint">
package net.java_school.filter;

import java.util.ArrayList;

public class Tomcat {

	public static void main(String[] args) {
		ChainFilter chain = new ChainFilter();
		ArrayList&lt;Filter&gt; filters = new ArrayList&lt;Filter&gt;();
		Filter f1 = new Filter1();
		Filter f2 = new Filter2();
		filters.add(f1);
		filters.add(f2);
		chain.setFilters(filters);
		chain.doFilter();
	}

}
</pre>

<pre class="console">
<strong class="console-result">Run Filter 1 before the server resource runs
Run Filter 2 before the server resource runs
Run Server resource.
Run Filter 2 after the server resource runs
Run Filter 1 after the server resource runs
</strong></pre>

<h3>Filter Interface</h3>
<ul>
	<li>init(FilterConfig filterConfig) throws ServletException;
	When this method is called by the servlet container, the filter is in service state.
	</li>
	<li>doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException;
	Called by the servlet container to perform the filtering operation.
	</li>
	<li>destroy()
	When called by a servlet container, the filter is no longer able to service. Mainly used for returning resources.
	</li>
</ul>

<p>
The arguments of the doFilter() method show that the filter can access the ServletRequest, ServletResponse, and javax.servlet.FilterChain objects when it intercepts the request or response.
The FilterChain object has a list of filters that should be called in order.

In the doFilter() method of the filter class, the code before FilterChain's doFilter() method call is the filtering code that is executed before the request reaches the server resource 
and the code after FilterChain's doFilter() method call is the filtering code that is executed before the response.
</p>


<h3>Filter Example</h3>

<p>
The following is an example that runs req.setCharacterEncoding("UTF-8"); code before all server resources are executed.
Create a CharsetFilter.java file as follows:
</p>

<em class="filename">/WEB-INF/src/net/java_school/filter/CharsetFilter.java</em>
<pre class="prettyprint">
package net.java_school.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharsetFilter implements Filter {

	private String charset = null;
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		this.charset = config.getInitParameter("charset");
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) 
		throws IOException, ServletException {
		
		if (req.getCharacterEncoding() == null) {
			req.setCharacterEncoding(charset);
			chain.doFilter(req,resp);
		}
	}

	@Override
	public void destroy() {
		//Implement it if you have resources to return.
	}

}
</pre>

<p>
At the command prompt, go to the /WEB-INF/src/net/java_school/filter/directory and compile as follows.
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 8.0/lib/servlet-api.jar" ^
CharsetFilter.java
</pre>

<p>
Open the following web.xml file and add the following:
Note the order with existing elements.
The following code should be placed between the context-param element and the listener element. 
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;filter&gt;
   &lt;filter-name&gt;CharsetFilter&lt;/filter-name&gt;
   &lt;filter-class&gt;net.java_school.filter.CharsetFilter&lt;/filter-class&gt;
   &lt;init-param&gt;
      &lt;param-name&gt;charset&lt;/param-name&gt;
      &lt;param-value&gt;UTF-8&lt;/param-value&gt;
   &lt;/init-param&gt;
&lt;/filter&gt;

&lt;filter-mapping&gt;
   &lt;filter-name&gt;CharsetFilter&lt;/filter-name&gt;
   &lt;url-pattern&gt;/*&lt;/url-pattern&gt;
&lt;/filter-mapping&gt;
</pre>

<p>
Open the RegisterServlet.java source and comment out the req.setCharacterEncoding("UTF-8"); and recompile RegisterServlet.java.
Go to http://localhost:port/example/SignUp.html and input the non-English characters into the ID and click submit button.
If req.setCharacterEncoding("UTF-8"); is executed, the ID will be output correctly. 
</p>

<p>
The filter initialization parameters are set using the filters sub-element, init-param.
The getInitParameter() and getInitParameters() methods of FilterConfig are used to read filter initialization parameters.

The filter-mapping element in web.xml specifies the resource to be filtered.

Filters are added to the FilterChain in the order in which they are listed in web.xml, but the filter mapped to the servlet name is added after the filter that matches the URL pattern.
The doFilter() method of FilterChain calls the next filter of FilterChain.
</p>

<h2>Uploading files</h2>

<p>
Most programmers are using external libraries to upload files.
</p>

<h3>MultipartRequest</h3>

<p>
The MultipartRequest package is a package that is widely used for file upload.
Download cos.26Dec2008.zip from the following address.
<a href="http://www.servlets.com/cos/index.html">http://www.servlets.com/cos/index.html</a>
After decompressing, copy the cos.jar file to the ROOT application's /WEB-INF/lib directory.
There are eight constructors for the MultipartRequest class. For a more detailed explanation, please refer to the following address.
<a href= "http://www.servlets.com/cos/javadoc/com/oreilly/servlet/MultipartRequest.html">http://www.servlets.com/cos/javadoc/com/oreilly/servlet/MultipartRequest.html</a>
The following constructor resolves the encoding problem for non-English characters and automatically rename the file name when the file name is duplicate.
</p>

<pre class="prettyprint">
public MultipartRequest(
	HttpServletRequest request,
	String saveDirectory,
	int maxPostSize,
	String encoding,
	FileRenamePolicy policy) throws IOException
</pre>

<h4>Methods of MultipartRequest</h4>

<p>
If the MultipartRequest constructor was successfully executed, the upload was successful.
The following table shows the member methods of MultipartRequest that are available after uploading files to the server's file system.
Suppose you upload the logo.gif image file using the &lt;input type="file" name="photo" /&gt;.
</p>

<table class="table-in-article">
<tr>
	<th class="table-in-article-td">getContentType("photo");</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return the MIME type of the uploaded file. For example, if the extension of the file is gif, "image/gif" is returned.</td>
</tr>
<tr>
	<th class="table-in-article-td">getFile("photo");</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return the File object of the file uploaded and stored in the server.</td>
</tr>
<tr>
	<th class="table-in-article-td">getFileNames();</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return parameter names whose type attribute is "file" as Enumeration type.</td>
</tr>
<tr>
	<th class="table-in-article-td">getFilesystemName("photo");</th>
</tr>
<tr>	
	<td class="table-in-article-td">Returns the actual file name that is uploaded and exists in the server file system.</td>
</tr>
<tr>
	<th class="table-in-article-td">getOriginalFileName("photo");</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return original file name</td>
</tr>
</table>

<table>
<caption>Methods to provide the same interface as HttpServletRequest</caption>
<tr>
	<th class="table-in-article-td">getParameter(String name);</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return value of parameter corresponding to name as String</td>
</tr>
<tr>
	<th class="table-in-article-td">getParameterNames();</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return all parameter names as Enumeration type.</td>
</tr>
<tr>
	<th class="table-in-article-td">getParameterValues(String name);</th>
</tr>
<tr>	
	<td class="table-in-article-td">Returns values of the parameter corresponding to name as String[].</td>
</tr>
</table>

<h4>MultipartRequest Example</h4>

<p>
Create the following HTML file in the example subdirectory of the ROOT application's top-level directory:
</p>

<em class="filename">/example/MultipartRequest.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
	&lt;title&gt;MultipartRequest Servlet Example&lt;/title&gt;
	&lt;meta charset="UTF-8" /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;h1&gt;File Upload Test with MultipartRequest&lt;/h1&gt;

&lt;form action="../servlet/UploadTest" method="post" enctype="multipart/form-data"&gt;
&lt;div&gt;Name: &lt;input type="text" name="name" /&gt;&lt;/div&gt;
&lt;div&gt;File 1: &lt;input type="file" name="file1" /&gt;&lt;/div&gt;
&lt;div&gt;File 2: &lt;input type="file" name="file2" /&gt;&lt;/div&gt;
&lt;div&gt;&lt;input type="submit" value="Submit" /&gt;&lt;/div&gt;
&lt;/form&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Create and compile the following servlet.
When compiling, you need to tell the Java compiler the path to the cos.jar file.
</p>

<em class="filename">UploadTest.java</em>
<pre class="prettyprint">
package example;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UploadTest extends HttpServlet {
	
	@Override	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		ServletContext cxt = getServletContext();
		String dir = cxt.getRealPath("/upload");
		
		try {
			MultipartRequest multi = new MultipartRequest(req, dir, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
					
			out.println("&lt;html&gt;");
			out.println("&lt;body&gt;");
			out.println("&lt;h1&gt;Parameters passed by the user&lt;/h1&gt;");
			out.println("&lt;ol&gt;");
			Enumeration&lt;?&gt; params = multi.getParameterNames();
			
			while (params.hasMoreElements()) {
				String name = (String) params.nextElement();
				String value = multi.getParameter(name);
				out.println("&lt;li&gt;" + name + "=" + value + "&lt;/li&gt;");
			}
			
			out.println("&lt;/ol&gt;");
			out.println("&lt;h1&gt;Uploaded files&lt;/h1&gt;");
			
			Enumeration&lt;?&gt; files = multi.getFileNames();
			
			while (files.hasMoreElements()) {
				out.println("&lt;ul&gt;");
				String name = (String) files.nextElement();
				String filename = multi.getFilesystemName(name);
				String originalName =multi.getOriginalFileName(name);
				String type = multi.getContentType(name);
				File f = multi.getFile(name);
				out.println("&lt;li&gt;Parameter name: "  + name + "&lt;/li&gt;");
				out.println("&lt;li&gt;File name: " + filename + "&lt;/li&gt;");
				out.println("&lt;li&gt;File original name: " + originalName + "&lt;/li&gt;");
				out.println("&lt;li&gt;File type: " + type + "&lt;/li&gt;");
				
				if (f != null) {
					out.println("&lt;li&gt;File size: " + f.length() + "&lt;/li&gt;");
				}
				out.println("&lt;/ul&gt;");
			}
		} catch(Exception e) {
			out.println("&lt;ul&gt;");
			e.printStackTrace(out);
			out.println("&lt;/ul&gt;");
		}
		out.println("&lt;/body&gt;&lt;/html&gt;");
	}
}
</pre>

<p>
Add the following to web.xml:
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;UploadTest&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.UploadTest&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;UploadTest&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/servlet/UploadTest&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
Before running the example, create an upload subdirectory in the top-level directory of your ROOT web application.
Restart Tomcat and visit http://localhost:port/example/upload.html.
After uploading duplicate files, check the file name in upload folder.
If you upload a duplicate file, you can see that the file name except the extension is appended with a number at the end.
If the test fails, check the list below.
</p>

<ol>
	<li>Check that the bytecode of the UploadTest servlet is generated.</li>
	<li>Make sure that there is an upload subdirectory in the root directory of the ROOT application.</li>
	<li>Make sure the cos.jar file is in /WEB-INF/lib in the ROOT application.</li>
	<li>Make sure the UploadTest servlet is correctly registered and mapped in the web.xml.</li>
	<li>Make sure the ROOT web application is loaded.</li>
</ol>

<h3>commons-fileupload</h3>

<p>
Commons-fileupload is a file upload library provided by Apache, which is famous for its open source.
Download the latest binary file from the following address.
<a href="http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi">http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi</a>
<a href="http://commons.apache.org/proper/commons-io/download_io.cgi">http://commons.apache.org/proper/commons-io/download_io.cgi</a>
Uncompress and copy the commons-fileupload-x.x.jar and commons-io-x.x.jar files to the ROOT application's /WEB-INF/lib.
</p>

<em class="filename">/example/commons-fileupload.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;commons-fileupload Test&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;h1&gt;Uploading files using commons-fileupload&lt;/h1&gt;

&lt;form action="../CommonsUpload" method="post" enctype="multipart/form-data"&gt;
&lt;div&gt;File : &lt;input type="file" name="upload" /&gt;&lt;/div&gt;
&lt;div&gt;&lt;input type="submit" value="Submit" /&gt;&lt;/div&gt;
&lt;/form&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">CommonsUpload.java</em>
<pre class="prettyprint">
package example;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Iterator;
import java.io.File;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class CommonsUpload extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws IOException, ServletException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		//Check that we have a file upload request
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		//Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		//Configure a repository (to ensure a secure temp location is used)
		ServletContext servletContext = this.getServletConfig().getServletContext();
		File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
		factory.setRepository(repository);
		
		//Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		try {
			//Parse the request
			List&lt;FileItem&gt; items = upload.parseRequest(req);
			//Process a file upload
			Iterator&lt;FileItem&gt; iter = items.iterator();
			while (iter.hasNext()) {
				FileItem item = iter.next();
				String fileName = null;
				if (!item.isFormField()) {
					String fieldName = item.getFieldName();
					out.println(fieldName);
					fileName = item.getName();
					out.println(fileName);
					String contentType = item.getContentType();
					out.println(contentType);
					boolean isInMemory = item.isInMemory();
					out.println(isInMemory);
					long sizeInBytes = item.getSize();
					out.println(sizeInBytes);
				}
				// Process a file upload
				ServletContext cxt = getServletContext();
				String dir = cxt.getRealPath("/upload");
				File uploadedFile = new File(dir + "/" + fileName);
				item.write(uploadedFile);
			}
		} catch (Exception e) {
			out.println("&lt;ul&gt;");
			e.printStackTrace(out);
			out.println("&lt;/ul&gt;");
		}
		out.println("&lt;a href="/example/commons-fileupload.html"&gt;commons-fileupload.html&lt;/a&gt;");
	}
}
</pre>

<p>
Add the following to web.xml:
</p>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;commonsUpload&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.CommonsUpload&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
	&lt;servlet-name&gt;commonsUpload&lt;/servlet-name&gt;
	&lt;url-pattern&gt;/CommonsUpload&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
Restart Tomcat and visit http://localhost:port/example/commons-fileupload.html.
After uploading duplicate files, check the file name in upload folder.
If you upload a duplicate file, you will notice that unlike cos.jar, it overwrites the existing file.
An example of showing uploaded files is covered in the JSP chapter.
</p>

<h2>Cookie</h2>

<p>
The HTTP protocol is a protocol that can not maintain state.
A cookie is one of technologies for overcoming that a web browser cannot maintain a session in communication with a server due to the characteristics of the HTTP protocol.
When the server sends a cookie, the web browser passes the cookie to the server for each request so that the user information can be maintained.
</p>

<h3>Server sends cookie to web browser</h3>

<p>
For the cookie to work, the server must make and send the cookie to a web browser.
The cookie looks like as follows: 
</p>

<pre class="prettyprint">
Set-Cookie : name = value ; expires = date ; path = path ; domain = domain ; secure
</pre>

<p>
Cookies are stored in files managed by the web browser.
</p>

<h3>Web browser sends cookie to server</h3>

<p>
Once the cookie is set in the web browser, the web browser sends the cookie whenever it requests the server resource.
The cookie looks like as follows: 
</p>
 
<pre class="prettyprint">
Cookie ; name = value1 ; name2 = value2 ;
</pre>

<p>
The cookie name and value can not contain characters such as [] () = "/? @ :;
</p>

<h3>Cookie's constructor</h3>

<p>
Creates a cookie using the Cookie (String name, String value) constructor.
</p>

<h3>Methods of Cookie class</h3>

<table class="table-in-article">
<tr>
	<th class="table-in-article-td">setValue(String value)</th>
</tr>
<tr>	
	<td class="table-in-article-td">It is used to reset the value of created cookie.</td>
</tr>
<tr>
	<th class="table-in-article-td">setDomain(String pattern)</th>
</tr>
<tr>	
	<td class="table-in-article-td">
By default, cookies are only returned to the server that sent them.
To send a cookie to a server using the same domain, use the setDomain() method.
Domains not related to the server can not be set with setDomain().
	</td>
</tr>
<tr>
	<th class="table-in-article-td">setMaxAge(int expiry)</th>
</tr>
<tr>	
	<td class="table-in-article-td">
Set the validity period of the cookie in seconds.
If you set a negative number, the cookie is deleted when you close the browser.
	</td>
</tr>
<tr>
	<th class="table-in-article-td">setPath(String uri)</th>
</tr>
<tr>	
	<td class="table-in-article-td">
Sets the path to which cookies will be applied.
If the path is set, the web browser will send the cookie to the web server only if it visit the set path.
	</td>
</tr>
<tr>
	<th class="table-in-article-td">setSecure(boolean flag)</th>
</tr>
<tr>	
	<td class="table-in-article-td">If flag is true, cookies are sent only for servers using secure channels. (https)</td>
</tr>
</table>

<p>
If you create a cookie with the cookie constructor and call the cookie method to set the cookie appropriately, you must send the cookie to the web browser.
The following is the code that sends the cookie to the web browser.
</p>

<pre class="prettyprint no-border">
resp.addCookie(cookie);
</pre>

<h3>Access cookie sent by web browser from server resource</h3>

<pre class="prettyprint no-border">
Cookie[] cookie = <strong>req.getCookies();</strong>
</pre>

<p>
Use the getCookies() method of HttpServletRequest to get the cookie array.
(If there is no cookie, the getCookies() method returns null)
You can get information about cookies by using the following method.
Among them, getName() and getValue() are mainly used.
</p>

<table class="table-in-article">
<tr>
	<th class="table-in-article-td">getName()</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return cookie name</td>
</tr>
<tr>
	<th class="table-in-article-td">getValue()</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return cookie value</td>
</tr>
<tr>
	<th class="table-in-article-td">getDomain()</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return cookie domain</td>
</tr>
<tr>
	<th class="table-in-article-td">getMaxAge()</th>
</tr>
<tr>	
	<td class="table-in-article-td">Return cookie expiration</td>
</tr>
</table>

<p>
Here is a snippet of code that gets the cookie value from the server resource.
</p>

<pre class="prettyprint">
String id = null;
Cookie[] cookies = request.getCookies();

if (cookies != null) {

	for (int i = 0; i &lt; cookies.length; i++) {
		String name = cookies[i].getName();
		
		if (name.equals("id")) {
			id = cookies[i].getValue();
			break;
		}
	}
}
</pre>

<p>
Below is an example of deleting cookies.
It creates a cookie with the same name as the cookie you want to delete, calls setMaxAge(0), and sends the cookie to a web browser.
</p>

<pre class="prettyprint">
Cookie cookie = new Cookie("id","");
cookie.setMaxAge(0);
resp.addCookie(cookie);
</pre>

<p>
Cookie exercises are covered in <a href="JSP">JSP</a> chapter.
</p>

<h2>Session</h2>

<p>
A session is a cookie-based technology, which were made to overcome weaknesses in cookie security.
Unlike cookies, the web browser stores only the session ID that the server has set as the cookie value.
A session ID cookie stored in a web browser and a session object (HttpSession Type) mapped to a session ID cookie in the server cooperate to maintain the state of the user.
The code for creating the session is as follows.
</p>

<pre class="prettyprint">
HttpSession session = req.getSession(true); //If there is no session, create it.
HttpSession session = req.getSession(false); //If there is no session, it returns null.
</pre>

<p>
Once the session object has been created, you can store the information in the session.
</p>

<pre class="prettyprint">
User user = new User("Alison", "11111111");
session.setAttribue("user", user);
</pre>

<p>
Session exercises are covered in the <a href="JSP">JSP</a> chapter.
</p>

<span id="comments">Comments</span>
<ol>
	<li>
The figure does not show all the properties and methods of GenericServlet and HttpServlet.
To easily understand servlets, you need to be able to draw inheritance relationships between Servlets, ServletConfig, GenericServlet, and HttpServlet.
	</li>
	<li>
MIME(Multipurpose Internet Mail Extensions).
MIME of .html or .htm is text/html, .txt is text/plain .gif is image/gif.
	</li>
	<li>
The string following the ? after the URL is called a query string.
The query string is passed to the server-side resource corresponding to the URL.
If there is more than one information in the query string, use &amp; from the second. (eg, http://localhost:port/list.jsp?board=free&amp;page=1)
	</li>
	<li>
The Enumeration interface has two methods to access the data in order: hasMoreElements() and nextElement().
	</li>
</ol>

<span id="refer">References</span>
<ul id="references">
	<li><a href="https://java.net/downloads/servlet-spec/Final/servlet-3_1-final.pdf">https://java.net/downloads/servlet-spec/Final/servlet-3_1-final.pdf</a></li>
	<li><a href="https://tomcat.apache.org/tomcat-8.0-doc/servletapi/">https://tomcat.apache.org/tomcat-8.0-doc/servletapi/</a></li>
	<li><a href="https://jcp.org/en/jsr/detail?id=315">https://jcp.org/en/jsr/detail?id=315</a></li>
	<li><a href="http://docs.oracle.com/javaee/7/api/index.html?overview-summary.html">http://docs.oracle.com/javaee/7/api/index.html?overview-summary.html</a></li>
	<li><a href="http://www.mkyong.com/servlet/a-simple-httpsessionlistener-example-active-sessions-counter/">http://www.mkyong.com/servlet/a-simple-httpsessionlistener-example-active-sessions-counter/</a></li>
	<li><a href="http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi">http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi</a></li>
	<li><a href="http://commons.apache.org/proper/commons-io/download_io.cgi">http://commons.apache.org/proper/commons-io/download_io.cgi</a></li>
	<li><a href="http://commons.apache.org/proper/commons-fileupload/using.html">http://commons.apache.org/proper/commons-fileupload/using.html</a></li>
	<li><a href="http://www.albumbang.com/board/board_view.jsp?board_name=free&no=292">http://www.albumbang.com/board/board_view.jsp?board_name=free&amp;no=292</a></li>
	<li><a href="http://www.docjar.com/docs/api/javax/servlet/GenericServlet.html">http://www.docjar.com/docs/api/javax/servlet/GenericServlet.html</a></li>
</ul>
</article>