<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2017.2.15</div>

<h1>Namecard Web Application</h1>

<p>
Before studying a Web application, let's make the JDBC Namecard example as a Web application.
In this Chapter, You will be able to understand the difference between pure Java applications and web applications.
</p>

<h2>Preparations for changing the JDBC Namecard example to a web application</h2>

<h3>1. Copy the Oracle JDBC driver to {TOMCAT_HOME}/lib.</h3>

<p>
The JDBC driver must be in {TOMCAT_HOME}/lib instead of WEB-INF/lib for your web application for special reasons.<sup><a href="#comments">1</a></sup>
There should be no JDBC driver in WEB-INF/lib for your web application.
Copy the ojdbc6.jar file to {TOMCAT_HOME}/lib.
</p>

<h3>2. Create a directory structure for Namecard web applications.</h3>

<p>
If you set C:/www/namecard to be the top level directory of your namecard management web application, 
you should create the following subdirectory under C:/www/ namecard.
</p>

<ul>
	<li>WEB-INF</li>
	<li>WEB-INF/classes</li>
	<li>WEB-INF/lib</li>
</ul>

<h3>3. Create the web.xml file in the WEB-INF directory.</h3>

<p>
Copy {TOMCAT_HOME}/webapps/ROOT/WEB-INF/web.xml and paste it into C:/www/namecard/WEB-INF/.
After copying, open the file C:/www/namecard/WEB-INF/web.xml and delete everything inside the web-app element.
</p>

<pre class="prettyprint">
&lt;?xml version="1.0" encoding="ISO-8859-1"?&gt;
&lt;!--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--&gt;

&lt;web-app xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                      http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0"
  metadata-complete="true"&gt;

&lt;/web-app&gt;
</pre>

<h3>4. Create a context file named namecard.xml.</h3>

<p>
Create a namecard.xml file as shown below and move it to {TOMCAT_HOME}/conf/Catalina/localhost.
</p>

<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="C:/www/namecard"
    reloadable="true"&gt;
&lt;/Context&gt;
</pre>

<h3>Test 1</h3>

<p>
Copy the namecard and NamecardDao bytecode that you have practiced in <a href="/jdbc/Namecard">Namecard</a> into WEB-INF/classes.
</p>

<pre>
C:/www/namecard/WEB-INF/classes
                           └── net
                               └── java_school
                                       └── namecard - Namecard.class
                                                    - NamecardDao.class
						
</pre>

<p>
Create all the JSP files in the DocumentBase C: / www / namecard.
Make list.jsp as follows. (This practice is best done with a regular editor, not with Eclipse.)
</p>

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.namecard.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;    
&lt;!DOCTYPE html&gt;
&lt;%
NamecardDao dao = new NamecardDao();
ArrayList&lt;Namecard&gt; list = dao.selectAll();
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;List All Namecard&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;table border="1"&gt;
&lt;tr&gt;
	&lt;td&gt;NO&lt;/td&gt;
	&lt;td&gt;NAME&lt;/td&gt;
	&lt;td&gt;MOBILE&lt;/td&gt;
	&lt;td&gt;EMAIL&lt;/td&gt;
	&lt;td&gt;COMPANY&lt;/td&gt;
&lt;/tr&gt;
&lt;%
int size = list.size();
for(int i = 0;i &lt; size;i++) {
	Namecard card = list.get(i);
%&gt;	
&lt;tr&gt;
	&lt;td&gt;&lt;%=card.getNo() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getName() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getMobile() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getEmail() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getCompany() %&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;%
}
%&gt;	
&lt;/table&gt;
&lt;p&gt;
&lt;input type="button" value="추가" onclick="location.href='write.jsp'" /&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
After restarting Tomcat, Visit http://localhost:port/namecard/list.jsp.
</p>

<h3>Test 2</h3>

<p>
In Test 1, you can place the Java source in a location that is completely independent of where the web application is located.
However, if you manage the source in this way, you can forget the location of the source, or you can erase the source by mistake.
Test 2 is a test that moves the source into the area of the web application and compiles the source.
First, you need to decide where to put the Java source,
If you place the source under WEB-INF, you will not be able to access the source directly from your web browser, so we will set the source directory to WEB-INF/src.
Copy the business card management src directory from JDBC and paste it into /WEB-INF.
At the command prompt, go to C:/www/namecad/WEB-INF/src/net/java_school/namecard and compile by doing the following:<sup><a href="#comments">2</a></sup>
</p>

<pre>
javac -d C:/www/namecard/WEB-INF/classes *.java
</pre>

<p>
Go to http://localhost:port/namecard/list.jsp and test.
</p>

<h3 id="3rd-Test">Test 3</h3>

<p>
Test 3 shows you how to manage your sources in Eclipse.
Run Eclipse.
Select your workspace as C:/www.<br />

<img src="images/workspace-c_www.png" alt="Select workspace as C:/www." /><br />

In the Java perspective, select File - New - Java Project.
Create a Java project with the name namecard.<sup><a href="#comments">3</a></sup>

<img src="images/Java-Perspective_File-New-Java-Project.png" alt="Create a Java Project with the Java perspective selected." /><br />

We are writing a web application, not a pure Java application, so do not use the directories src and bin that Eclipse sets by default.
With the mouse selected for the project, right-click.
Select Build Path, Configure Build Path ..
In the Source tab, select WEB-INF/src as the Source folder.
Select WEB-INF/classes as the Output folder.<br />

<img src="images/Namecard-WebApp_src_bin.png" alt="the Source Folder and Output Folder for Namecard Web Application" /><br />

Now if you modify the source in Eclipse, you will have bytecode in WEB-INF/classes without having to compile it separately.
Go to http://localhost:port/namecard/list.jsp and test.
If the test succeeds, create a JSP file in C:/www/namecard to register the namecard.
First, change the Eclipse JSP template charset to UTF-8.
In Eclipse, select Windows - Preferences - Web - JSP Files, select UTF-8 in the Encoding box, and click Apply.<br />

<img src="images/eclipse-jsp_files_encoding.png" alt="JSP charset to  UTF-8 " /><br />

The highlighted part of the write.jsp source below is what you need to type directly.
</p>
 
<em class="filename">/write.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>Add Namecard</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>&lt;h1&gt;Add Namecard&lt;/h1&gt;
&lt;form action="write_proc.jsp" method="post"&gt;
NAME : &lt;input type="text" name="name" /&gt;&lt;br /&gt;
MOBILE : &lt;input type="text" name="mobile" /&gt;&lt;br /&gt;
EMAIL : &lt;input type="text" name="email" /&gt;&lt;br /&gt;
COMPANY : &lt;input type="text" name="company" /&gt;&lt;br /&gt;
&lt;input type="submit" value="Confirm" /&gt;
&lt;input type="button" value="Cancel" onclick="location.href='list.jsp'" /&gt;
&lt;/form&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Next, create a write_proc.jsp file.
This page adds a business card using information received from write.jsp.
You will have to type in the highlighted part of the source below.
</p>

<em class="filename">/write_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
String company = request.getParameter("company");
Namecard namecard = new Namecard(name,mobile,email,company);
NamecardDao dao = new NamecardDao();
dao.insert(namecard);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>Add Namecard</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>New namecard added.&lt;a href="list.jsp"&gt;All Namecards&lt;/a&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Visit http://localhost:port/namecard/list.jsp and test the business card registration.
Let's implement the business card deletion function.
First, edit the list.jsp as follows.
</p>

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
.. omit ..

    &lt;td&gt;NO&lt;/td&gt;
    &lt;td&gt;NAMe&lt;/td&gt;
    &lt;td&gt;MOBILE&lt;/td&gt;
    &lt;td&gt;EMAIL&lt;/td&gt;
    &lt;td&gt;COMPANY&lt;/td&gt;
    <span class="emphasis">&lt;td&gt;Manage&lt;/td&gt;</span>

.. omit ..

    &lt;td&gt;&lt;%=card.getNo() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getName() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getMobile() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getEmail() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getCompany() %&gt;&lt;/td&gt;
    <span class="emphasis">&lt;td&gt;&lt;a href="delete.jsp?no=&lt;%=card.getNo() %&gt;"&gt;Del&lt;/a&gt;&lt;/td&gt;</span>

.. omit ..	
</pre>

<p>
Next, create delete.jsp.
delete.jsp receives the value corresponding to the primary key of the namecard in list.jsp and performs deletion.
You will have to type in the highlighted part of the source below.
</p>

<em class="filename">/delete.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
int no = Integer.parseInt(request.getParameter("no"));
NamecardDao dao = new NamecardDao();
dao.delete(no);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>Delete Namecard</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>The namecard has been deleted.&lt;a href="list.jsp"&gt;All Namecards&lt;/a&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Visit http://localhost:port/namecard/list.jsp to test the deletion of namecards.
Next, let's implement namecard modification.
Below is a method to modify a namecard in NamecardDao.java.
</p>

<em class="filename">NamecardDao.java</em>
<pre class="prettyprint">
public void update(Namecard card) {
	String sql = "UPDATE namecard " +
			"SET name = ? " +
			",mobile = ? " +
			",email = ? " +
			",company = ? " +
			"WHERE no = ?";
			
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, card.getName());
		pstmt.setString(2, card.getMobile());
		pstmt.setString(3, card.getEmail());
		pstmt.setString(4, card.getCompany());
		pstmt.setInt(5, card.getNo());
		pstmt.executeUpdate();
		
//.. omit ..
</pre>

<p>
Modify the list.jsp file as shown below.
</p>

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;td&gt;
	&lt;a href="delete.jsp?no=&lt;%=card.getNo() %&gt;"&gt;Del&lt;/a&gt;
	<strong>&lt;a href="modify.jsp?no=&lt;%=card.getNo() %&gt;"&gt;Modify&lt;/a&gt;</strong>
&lt;/td&gt;
</pre>

<p>
Next, create a modify.jsp file.
</p>

<em class="filename">/modify.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
int no = Integer.parseInt(request.getParameter("no"));
NamecardDao dao = new NamecardDao();
Namecard card = dao.selectOne(no);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>Modify a Namecard</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>&lt;h1&gt;Modify a Namecard&lt;/h1&gt;
&lt;form action="modify_proc.jsp" method="post"&gt;
<span class="emphasis">&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;</span>
NAME : &lt;input type="text" name="name" value="&lt;%=card.getName() %&gt;" /&gt;&lt;br /&gt;
MOBILE : &lt;input type="text" name="mobile" value="&lt;%=card.getMobile() %&gt;" /&gt;&lt;br /&gt;
EMAIL : &lt;input type="text" name="email" value="&lt;%=card.getEmail() %&gt;" /&gt;&lt;br /&gt;
COMPANY : &lt;input type="text" name="company" value="&lt;%=card.getCompany() %&gt;" /&gt;&lt;br /&gt;
&lt;input type="submit" value="Confirm" /&gt;
&lt;input type="button" value="Cancel" onclick="location.href='list.jsp'" /&gt;
&lt;/form&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;<br />
The above code must be in the form tag.
Create the modify_proc.jsp file.
This JSP modifies the namecard using information sent from modify.jsp.
</p>

<em class="filename">modify_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
request.setCharacterEncoding("UTF-8");
int no = Integer.parseInt(request.getParameter("no"));
String name = request.getParameter("name");
String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
String company = request.getParameter("company");
Namecard card = new Namecard();
card.setNo(no);
card.setName(name);
card.setMobile(mobile);
card.setEmail(email);
card.setCompany(company);
NamecardDao dao = new NamecardDao();
dao.update(card);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>Modify a Namecard</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>The namecard has been modified. &lt;a href="list.jsp"&gt;All Namecards&lt;/a&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Visit http://localhost:port/namecard/list.jsp, and edit the namecard.
Let's add a search function to list.jsp.
Open list.jsp and add the following before &lt;/body&gt;.
</p>

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;form action="list.jsp" method="post"&gt;
	&lt;input type="text" name="keyword" /&gt;
	&lt;input type="submit" value="Search" /&gt;
&lt;/form&gt;
</pre>

<p>
Add the selectByKeyword (String keyword) method to NamecardDao.java.
</p>

<em class="filename">NamecardDao.java</em>
<pre class="prettyprint">
public ArrayList&lt;Namecard&gt; selectByKeyword(String keyword) {
	keyword = "%" + keyword + "%";
	ArrayList&lt;Namecard&gt; matched = new ArrayList&lt;Namecard&gt;();
		
	String sql ="SELECT no,name,mobile,email,company " + 
				"FROM namecard " +
			"WHERE name LIKE ? " +
				"OR mobile LIKE ? " +
				"OR email LIKE ? " + 
				"OR company LIKE ? " +
			"ORDER BY no DESC";
			
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, keyword);
		pstmt.setString(2, keyword);
		pstmt.setString(3, keyword);
		pstmt.setString(4, keyword);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			int no = rs.getInt("no");
			String sname = rs.getString("name");
			String mobile = rs.getString("mobile");
			String email = rs.getString("email");
			String company = rs.getString("company");
			Namecard namecard = new Namecard(no, name, mobile, email, company);
			matched.add(namecard);
		}
	} catch (SQLException e) {
		e.printStackTrace();
		System.out.println(sql);
	} finally {
		close(rs,pstmt,con);
	}
	
	return matched;
}
</pre>

<p>
If you visit list.jsp to test your search, there is a bug that searches for null.
The first time you visit list.jsp from the web browser's address bar, the keyword is null.
And if you did not put any value in the search field in list.jsp and clicked the search button, the keyword is "" (whitespace).
Open list.jsp and modify it as shown below.
</p>

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;%
//Commented out the following code.
//NamecardDao dao = new NamecardDao();
//ArrayList&lt;Namecard&gt; list = dao.selectAll();

request.setCharacterEncoding("UTF-8");
String keyword = request.getParameter("keyword");

NamecardDao dao = new NamecardDao();
ArrayList&lt;Namecard&gt; list = null;

if (keyword == null) {
	keyword = "";
}
if (keyword.equals("")) {
	list = dao.selectAll();
} else {
	list = dao.selectByKeyword(keyword);
}
%&gt;
</pre>

<p>
If you have done so, go to http://localhost:port/namecard/list.jsp and test.
</p>

<span id="comments">Comments</span>
<ol>
	<li>Copying the JDBC driver files to WEB-INF/lib for each web application can cause memory leaks.</li>
	<li>If the NamecardDao class uses a connection pool, you must first compile the connection pool-related classes.</li>
	<li>In contrast, most books and sites illustrate how to create a Dynamic Web Project in the Java EE perspective.
To focus on servlets/JSPs rather than Eclipse, the settings presented here are better.</li>
</ol>

<span id="refer">References</span>
<ul id="references">
	<li><a href="http://stackoverflow.com/questions/6981564/why-jdbc-driver-must-been-put-in-tomcat-home-lib-folder">http://stackoverflow.com/questions/6981564/why-jdbc-driver-must-been-put-in-tomcat-home-lib-folder</a></li>
</ul>
</article>