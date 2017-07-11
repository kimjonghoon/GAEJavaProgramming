<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2017.3.24</div>

<h1>Understanding the bulletin board program</h1>

<p>
After accessing the scott account with SQL*PLUS, use the following script to create the table and sequence for the bulletin board.
</p>

<em class="filename"><a href="board-schema.sql">board-schema.sql</a></em>
<pre class="prettyprint">
create table board(
 no number primary key,
 title varchar2(200) not null,
 content varchar2(4000),
 wdate date
)
/
create sequence board_no_seq
start with 1
increment by 1
/
</pre>

<p>
To use the board-schema.sql file, access SQL*PLUS with the scott account, 
type @ followed by the full path to the board-schema.sql file.
If there is a board-schema.sql file in C:\, execute it as follows.
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
SQL&gt;@C:\board-schema.sql
</pre>

<p>
Run the following insert statement while logged in to SQL * PLUS with the scott account. 
(A total of 100 insert statements are executed)
</p>

<em class="filename"><a href="board-data.sql">board-data.sql</a></em>
<pre class="prettyprint">
insert into board values (board_no_seq.nextval, '000001','',sysdate);
insert into board values (board_no_seq.nextval, '000002','',sysdate);
insert into board values (board_no_seq.nextval, '000003','',sysdate);
insert into board values (board_no_seq.nextval, '000004','',sysdate);
insert into board values (board_no_seq.nextval, '000005','',sysdate);
insert into board values (board_no_seq.nextval, '000006','',sysdate);
insert into board values (board_no_seq.nextval, '000007','',sysdate);
insert into board values (board_no_seq.nextval, '000008','',sysdate);
insert into board values (board_no_seq.nextval, '000009','',sysdate);
insert into board values (board_no_seq.nextval, '000010','',sysdate);
insert into board values (board_no_seq.nextval, '000011','',sysdate);
insert into board values (board_no_seq.nextval, '000012','',sysdate);
insert into board values (board_no_seq.nextval, '000013','',sysdate);
insert into board values (board_no_seq.nextval, '000014','',sysdate);
insert into board values (board_no_seq.nextval, '000015','',sysdate);
insert into board values (board_no_seq.nextval, '000016','',sysdate);
insert into board values (board_no_seq.nextval, '000017','',sysdate);
insert into board values (board_no_seq.nextval, '000018','',sysdate);
insert into board values (board_no_seq.nextval, '000019','',sysdate);
insert into board values (board_no_seq.nextval, '000020','',sysdate);
insert into board values (board_no_seq.nextval, '000021','',sysdate);
insert into board values (board_no_seq.nextval, '000022','',sysdate);
insert into board values (board_no_seq.nextval, '000023','',sysdate);
insert into board values (board_no_seq.nextval, '000024','',sysdate);
insert into board values (board_no_seq.nextval, '000025','',sysdate);
insert into board values (board_no_seq.nextval, '000026','',sysdate);
insert into board values (board_no_seq.nextval, '000027','',sysdate);
insert into board values (board_no_seq.nextval, '000028','',sysdate);
insert into board values (board_no_seq.nextval, '000029','',sysdate);
insert into board values (board_no_seq.nextval, '000030','',sysdate);
insert into board values (board_no_seq.nextval, '000031','',sysdate);
insert into board values (board_no_seq.nextval, '000032','',sysdate);
insert into board values (board_no_seq.nextval, '000033','',sysdate);
insert into board values (board_no_seq.nextval, '000034','',sysdate);
insert into board values (board_no_seq.nextval, '000035','',sysdate);
insert into board values (board_no_seq.nextval, '000036','',sysdate);
insert into board values (board_no_seq.nextval, '000037','',sysdate);
insert into board values (board_no_seq.nextval, '000038','',sysdate);
insert into board values (board_no_seq.nextval, '000039','',sysdate);
insert into board values (board_no_seq.nextval, '000040','',sysdate);
insert into board values (board_no_seq.nextval, '000041','',sysdate);
insert into board values (board_no_seq.nextval, '000042','',sysdate);
insert into board values (board_no_seq.nextval, '000043','',sysdate);
insert into board values (board_no_seq.nextval, '000044','',sysdate);
insert into board values (board_no_seq.nextval, '000045','',sysdate);
insert into board values (board_no_seq.nextval, '000046','',sysdate);
insert into board values (board_no_seq.nextval, '000047','',sysdate);
insert into board values (board_no_seq.nextval, '000048','',sysdate);
insert into board values (board_no_seq.nextval, '000049','',sysdate);
insert into board values (board_no_seq.nextval, '000050','',sysdate);
insert into board values (board_no_seq.nextval, '000051','',sysdate);
insert into board values (board_no_seq.nextval, '000052','',sysdate);
insert into board values (board_no_seq.nextval, '000053','',sysdate);
insert into board values (board_no_seq.nextval, '000054','',sysdate);
insert into board values (board_no_seq.nextval, '000055','',sysdate);
insert into board values (board_no_seq.nextval, '000056','',sysdate);
insert into board values (board_no_seq.nextval, '000057','',sysdate);
insert into board values (board_no_seq.nextval, '000058','',sysdate);
insert into board values (board_no_seq.nextval, '000059','',sysdate);
insert into board values (board_no_seq.nextval, '000060','',sysdate);
insert into board values (board_no_seq.nextval, '000061','',sysdate);
insert into board values (board_no_seq.nextval, '000062','',sysdate);
insert into board values (board_no_seq.nextval, '000063','',sysdate);
insert into board values (board_no_seq.nextval, '000064','',sysdate);
insert into board values (board_no_seq.nextval, '000065','',sysdate);
insert into board values (board_no_seq.nextval, '000066','',sysdate);
insert into board values (board_no_seq.nextval, '000067','',sysdate);
insert into board values (board_no_seq.nextval, '000068','',sysdate);
insert into board values (board_no_seq.nextval, '000069','',sysdate);
insert into board values (board_no_seq.nextval, '000070','',sysdate);
insert into board values (board_no_seq.nextval, '000071','',sysdate);
insert into board values (board_no_seq.nextval, '000072','',sysdate);
insert into board values (board_no_seq.nextval, '000073','',sysdate);
insert into board values (board_no_seq.nextval, '000074','',sysdate);
insert into board values (board_no_seq.nextval, '000075','',sysdate);
insert into board values (board_no_seq.nextval, '000076','',sysdate);
insert into board values (board_no_seq.nextval, '000077','',sysdate);
insert into board values (board_no_seq.nextval, '000078','',sysdate);
insert into board values (board_no_seq.nextval, '000079','',sysdate);
insert into board values (board_no_seq.nextval, '000080','',sysdate);
insert into board values (board_no_seq.nextval, '000081','',sysdate);
insert into board values (board_no_seq.nextval, '000082','',sysdate);
insert into board values (board_no_seq.nextval, '000083','',sysdate);
insert into board values (board_no_seq.nextval, '000084','',sysdate);
insert into board values (board_no_seq.nextval, '000085','',sysdate);
insert into board values (board_no_seq.nextval, '000086','',sysdate);
insert into board values (board_no_seq.nextval, '000087','',sysdate);
insert into board values (board_no_seq.nextval, '000088','',sysdate);
insert into board values (board_no_seq.nextval, '000089','',sysdate);
insert into board values (board_no_seq.nextval, '000090','',sysdate);
insert into board values (board_no_seq.nextval, '000091','',sysdate);
insert into board values (board_no_seq.nextval, '000092','',sysdate);
insert into board values (board_no_seq.nextval, '000093','',sysdate);
insert into board values (board_no_seq.nextval, '000094','',sysdate);
insert into board values (board_no_seq.nextval, '000095','',sysdate);
insert into board values (board_no_seq.nextval, '000096','',sysdate);
insert into board values (board_no_seq.nextval, '000097','',sysdate);
insert into board values (board_no_seq.nextval, '000098','',sysdate);
insert into board values (board_no_seq.nextval, '000099','',sysdate);
insert into board values (board_no_seq.nextval, '000100','',sysdate);
commit;
</pre>

<p>
Or, execute the next PL/SQL statement.
</p>

<pre class="prettyprint">
DECLARE
  counter INTEGER;
BEGIN
  counter := 1;
  FOR counter IN 1..100 LOOP
    insert into board values (board_no_seq.nextval, LPAD(board_no_seq.currval, 6, 0),'',sysdate); 
  END LOOP;
END;
/
</pre>

<p>
The table below shows the list of files to be created to implement the bulletin board.
</p>

<table class="table-in-article">
<caption class="table-in-article-caption">List of files to create</caption>
<tr>
	<td class="table-in-article-td">list.jsp</td>
	<td class="table-in-article-td">
Shows list of posts
(Step-by-step page break, search function will added)
	</td>
</tr>
<tr>
	<td class="table-in-article-td">write_form.jsp</td>
	<td class="table-in-article-td">Post Writing Form</td>
</tr>
<tr>
	<td class="table-in-article-td">BoardWriter.java</td>
	<td class="table-in-article-td">Servlet to insert a post into the database table</td>
</tr>
<tr>
	<td class="table-in-article-td">view.jsp</td>
	<td class="table-in-article-td">Show the details of the post</td>
</tr>
<tr>
	<td class="table-in-article-td">modify_form.jsp</td>
	<td class="table-in-article-td">Modify Form</td>
</tr>
<tr>
	<td class="table-in-article-td">BoardModifier.java</td>
	<td class="table-in-article-td">Servlet modifying the post</td>
</tr>
<tr>
	<td class="table-in-article-td">BoardDeleter.java</td>
	<td class="table-in-article-td">Servlet to delete the post</td>
</tr>
</table>

<p>
To review JSPs and servlets, JSP is used to show the screen, and Servlet that does not need a screen is adopted.
The flow of the bulletin board program is as follows.
</p>

<pre style="line-height: 200%;">
list.jsp &rarr; write_form.jsp &rarr; BoardWriter.java (Run insert) &rarr; list.jsp
  └── view.jsp
        └── modify_form.jsp &rarr; BoardModifier.java (Rnu update) &rarr; view.jsp
        └── BoardDeleter.java (Run delete) &rarr; list.jsp
</pre>

<p>
I will create a JSP file in the board subdirectory under the root directory of the ROOT application.
If you've been practicing <a href="Accessing-database-from-JSP_Servlets">Using the databases in JSP</a>, 
then custom connection pooling bytecode is created in WEB-INF/classes.
(If you do not have custom connection pooling bytecode, you can not test the board below)
</p>

<dl class="note">
<dt>MyServletContextListener.java</dt>
<dd>
We have already practiced a listener example that stores the OracleConnectionManager object in the ServletContext in the <a href="Servlet">Servlet</a> section when the web application is started. (MyServletContextListener.java)
This listener is running in your ROOT application.
</dd>
</dl>

<h2>List and Writing</h2>

<p>
The first step of the list page (list.jsp) shows all the records.
</p>

<em class="filename">/board/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;List&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;List&lt;/h1&gt;
&lt;%
Log log = new Log();

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String sql = "SELECT no, title, wdate FROM board ORDER BY no DESC";

try {
	con = dbmgr.getConnection();

	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();

	while (rs.next()) {
		int no = rs.getInt("no");
		String title = rs.getString("title");
		Date wdate = rs.getDate("wdate");
%&gt;
&lt;%=no %&gt; &lt;a href="view.jsp?no=&lt;%=no %&gt;"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
  }
} catch(SQLException e) {
	log.debug("Error Source: board/list.jsp : SQLException");
	log.debug("SQLState: " + e.getSQLState());
	log.debug("Message: " + e.getMessage());
	log.debug("Oracle Error Code: " + e.getErrorCode());
	log.debug("sql: " + sql);
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
		dbmgr.freeConnection(con);
	}
	log.close();
}
%&gt;
&lt;p&gt;
&lt;a href="write_form.jsp"&gt;Add New Post&lt;/a&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/board/write_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;Add New Post&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Add New Post&lt;/h1&gt;
&lt;form action="../servlet/BoardWriter" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;Title&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50"&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="20" cols="100"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="Submit"&gt;
		&lt;input type="reset" value="Reset"&gt;
		&lt;a href="list.jsp"&gt;List&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;  
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardWriter.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardWriter extends HttpServlet {
	private static final long serialVersionUID = 5698354994510824246L;
	
	OracleConnectionManager dbmgr = null;

	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager)sc.getAttribute("dbmgr");
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		Log log = new Log();
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt = null;
		String sql = "INSERT INTO board VALUES (board_no_seq.nextval, ?, ?, sysdate)";
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, content);
			stmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source: BoardWriter.java: SQLException");
			log.debug("SQLState: " + e.getSQLState());
			log.debug("Message: " + e.getMessage());
			log.debug("Oracle Error Code: " + e.getErrorCode());
			log.debug("sql: " + sql);
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			String path = req.getContextPath();
			resp.sendRedirect(path + "/board/list.jsp");
		}
	}
}
</pre>

<p>
Register this servlet in web.xml and set the URI mapping to <strong>/servlet/BoardWriter</strong>.
</p>

<p>
Test in the following order.
</p>

<ol>
	<li>Since web.xml has changed, rerun Tomcat.</li>
	<li>Visit http://localhost:port/board/list.jsp</li>
	<li>Click the New link to go to the add new post page.</li>
	<li>Check if new articles are registered.</li>
</ol>

<h2>View Post</h2>

<em class="filename">/board/view.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;View Post&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no) {
	location.href="modify_form.jsp?no=" + no;
}

function goDelete(no) {
	var check = confirm('Are you sure you want to delete it?');
	if (check) {
		location.href="../servlet/BoardDeleter?no=" + no;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;View Post&lt;/h1&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
Log log = new Log();
Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String sql = "SELECT no, title, content, wdate FROM board WHERE no = ?";
try {
	con = dbmgr.getConnection();
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, no);
	rs = stmt.executeQuery();
	
	while (rs.next()) {
		String title = rs.getString("title");
		String content = rs.getString("content");
		Date wdate = rs.getDate("wdate");
		if (content == null) content = "";
%&gt;
&lt;h2&gt;Title: &lt;%=title %&gt;, Date Created: &lt;%=wdate.toString() %&gt;&lt;/h2&gt;
&lt;p&gt;
&lt;%=content = content.replaceAll(System.getProperty("line.separator"), "&lt;br /&gt;") %&gt;
&lt;/p&gt;
&lt;%
	}
} catch (SQLException e) {
	log.debug("Error Source : board/view.jsp: SQLException");
	log.debug("SQLState: " + e.getSQLState());
	log.debug("Message: " + e.getMessage());
	log.debug("Oracle Error Code: " + e.getErrorCode());
	log.debug("sql: " + sql);
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
		dbmgr.freeConnection(con);
	}
	log.close();
}
%&gt;
&lt;a href="list.jsp"&gt;List&lt;/a&gt;
&lt;input type="button" value="Edit Post" onclick="javascript:goModify('&lt;%=no %&gt;')"&gt;
&lt;input type="button" value="Delete" onclick="javascript:goDelete('&lt;%=no %&gt;')"&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Test in the following order.
</p>

<ol>
	<li>Since web.xml has not changed, you do not need to rerun Tomcat.</li>
	<li>Click title in the list to visit the View Post page.</li>
</ol>


<h2>Edit Post</h2>

<em class="filename">/board/modify_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));

Log log = new Log();

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String title = null;
String content = null;
String sql = "SELECT title, content FROM board WHERE no = ?";

try {
	con = dbmgr.getConnection();
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, no);
	rs = stmt.executeQuery();
	
	if (rs.next()) {
	    title = rs.getString("title");
	    content = rs.getString("content");
	    if (content == null) content = "";
	}
} catch (SQLException e) {
	log.debug("Error Source: board/modify_form.jsp: SQLException");
	log.debug("SQLState: " + e.getSQLState());
	log.debug("Message: " + e.getMessage());
	log.debug("Oracle Error Code: " + e.getErrorCode());
	log.debug("sql: " + sql);
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
		dbmgr.freeConnection(con);
	}
	log.close();
}
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;Edit Post&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Edit Post&lt;/h1&gt;
&lt;form action="../servlet/BoardModifier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;Title&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=title %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=content %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="Submit"&gt;
		&lt;input type="reset" value="Reset"&gt;
		&lt;a href="view.jsp?no=&lt;%=no %&gt;"&gt;View Post&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardModifier.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardModifier extends HttpServlet {
  
	private static final long serialVersionUID = -971206071575571573L;

	OracleConnectionManager dbmgr = null;
	
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager)sc.getAttribute("dbmgr");
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		Log log = new Log();
		
		int no = Integer.parseInt(req.getParameter("no"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "UPDATE board SET title = ?, content = ? WHERE no = ?";
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, content);
			stmt.setInt(3, no);
			stmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source: BoardModifier.java: SQLException");
			log.debug("SQLState: " + e.getSQLState());
			log.debug("Message: " + e.getMessage());
			log.debug("Oracle Error Code: " + e.getErrorCode());
			log.debug("sql: " + sql);
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			
			String path = req.getContextPath();
			resp.sendRedirect( path + "/board/view.jsp?no=" + no);
		}
	}
}
</pre>

<p>
Register this servlet in web.xml and set the URI mapping to <strong>/servlet/BoardModifier</strong>.
</p>

<p>
Test in the following order.
</p>

<ol>
	<li>Rerun Tomcat.</li>
	<li>Visit http://localhost:port/board/list.jsp</li>
	<li>Click title in the list to visit the View Post page.</li>
	<li>On the View Post page, click Edit Post to go to the edit post page.</li>
	<li>On the edit Post page, change the title and content, and then click the Submit button.</li>
	<li>On the View Post page that came back, check if the title and content have changed.</li> 
</ol>

<h2>Delete Post</h2>

<em class="filename">BoardDeleter.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardDeleter extends HttpServlet {

	private static final long serialVersionUID = 664510406708983868L;
	
	OracleConnectionManager dbmgr = null;
	
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager)sc.getAttribute("dbmgr");
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		Log log = new Log();
		
		int no = Integer.parseInt(req.getParameter("no"));
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt = null;
		String sql = "delete board where no = ?";
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, no);
			stmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source: BoardDeleter.java: SQLException");
			log.debug("SQLState: " + e.getSQLState());
			log.debug("Message: " + e.getMessage());
			log.debug("Oracle Error Code: " + e.getErrorCode());
			log.debug("sql: " + sql);
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			String path = req.getContextPath();
			resp.sendRedirect(path + "/board/list.jsp");
		}
	}
}
</pre>

<p>
Register this servlet in web.xml and set the URI mapping to <strong>/servlet/BoardDeleter</strong>.
</p>

<p>
Test in the following order.
</p>

<ol>
	<li>Rerun Tomcat.</li>
	<li>Visit http://localhost:port/board/list.jsp</li>
	<li>Click title in the list to visit the View Post page.</li>
	<li>On the View Post page, click the Delete button.</li>
	<li>When you return to the list page, make sure that the post has been removed.</li>
</ol>


<h2>Splitting a list page</h2>

<p>
If you have a lot of data, you need to show the records in groups without showing all the records in the list.
</p>

<h3>Queries for grouping records</h3>

<p>
If you are grouping records by 10, the Oracle query statement that fetches the records for each group is as follows:
</p>

<em class="filename">Records belonging to group 1</em>
<pre class="prettyprint">
SELECT no,title,wdate FROM (
	SELECT ROWNUM R, A.* FROM (select no, title, wdate
		FROM board ORDER BY no DESC) A)
WHERE R BETWEEN 1 and 10;
</pre>

<em class="filename">Records belonging to group 2</em>
<pre class="prettyprint">
SELECT no,title,wdate FROM (
	SELECT ROWNUM R, A.* FROM (select no, title, wdate
		FROM board ORDER BY no DESC) A)
WHERE R BETWEEN 11 and 20;
</pre>

<em class="filename">Records belonging to group 3</em>
<pre class="prettyprint">
SELECT no,title,wdate FROM (
	SELECT ROWNUM R, A.* FROM (select no, title, wdate
		FROM board ORDER BY no DESC) A)
WHERE R BETWEEN 21 and 30;
</pre>

<p>
The ROWNUM is a Pseudocolumn.
In the query result, the ROWNUM returns a number indicating the order in which Oracle selects the row from a table.
If you use ROWNUM in the condition of the WHERE clause, you can extract records corresponding to the group.
When requesting list.jsp, if you pass the record group number as a parameter, you can get the starting record number and the last record number of ROWNUM corresponding to the group.
Set the parameter corresponding to the record group number to be passed to list.jsp to curPage and modify list.jsp with reference to the following code.
</p>
 
<em class="filename">/board/list.jsp</em>
<pre class="prettyprint">
&lt;%

// .. Omit ..

<strong>int curPage = (request.getParameter("curPage") == null) ? 1 : Integer.parseInt(request.getParameter("curPage"));</strong>
// Start ROWNUM  
<strong>int start = (curPage - 1) * 10 + 1;</strong>
// End ROWNUM
<strong>int end = start + 10 - 1;</strong>

// .. Omit ..

<strong>String sql = "SELECT no,title,wdate FROM (" + 
          	"SELECT ROWNUM R, A.* FROM (SELECT no, title, wdate " +
          	"FROM board ORDER BY no DESC) A) " + 
      	"WHERE R BETWEEN ? AND ?";</strong>
      
stmt = con.prepareStatement(sql);
<strong>stmt.setInt(1, start);</strong>
<strong>stmt.setInt(2, end);</strong>
rs = pstmt.executeQuery();

// .. Omit ..

%&gt;
</pre>

<p>
If you request http://localhost:port/board/list.jsp?curPage=1, you can see the records of group 1,
If you request http://localhost:port/board/list.jsp?curPage=2, you can see the records of group 2.
However, it is inconvenient to change the curPage parameter in the address bar of a web browser and move the page.
A typical bulletin board we know of provides a link to move the page as shown below.
</p>
<pre class="prettyprint no-border">
&lt;a href=&quot;list.jsp?curPage=1&quot;&gt;[1]&lt;/a&gt;
</pre>

<p>
If you know the last page number, you can make the link like this from 1 to the last page number using the for statement.
How do I know the last page?
Since the page number starts at 1, the "last page number" is equal to the "total number of pages".
The total number of pages is calculated by dividing the total number of records by 10, which is the number of records per page.
Add the following code to the appropriate location in list.jsp.
</p>

<pre class="prettyprint">
int totalRecord = 0;
String sql = "SELECT count(*) FROM board";
stmt = con.prepareStatement(sql);
rs = pstmt.executeQuery();
rs.next();
totalRecord = rs.getInt(1);
</pre>

<p>
Add the following to the appropriate location under the code to get the total number of records in list.jsp.
</p>

<pre class="prettyprint">
int totalPage = 0;

if (totalRecord != 0) {
	if (totalRecord % 10 == 0) {
		totalPage = totalRecord / 10;
	} else {
		totalPage = totalRecord / 10 + 1;
	}
}
</pre>

<p>
Now we get the total number of pages, the last page number.
At this point, I will refine the code to get the ROWNUM start and end records more elegantly.
Declare the variable numPerPage to store the number of records per page, and modify the code in list.jsp referring to the code below.
</p>

<pre class="prettyprint">
int numPerPage = 10; //the number of records per page
int start = (curPage - 1) * numPerPage + 1; //the ROWNUM start record
int end = start + numPerPage - 1; //the ROWNUM end record
</pre>

<p>
You also need to change the code to get the total number of pages.
</p>

<pre class="prettyprint">
int totalPage = 0;
if (totalRecord != 0) {
	if (totalRecord % <strong>numPerPage</strong> == 0) {
		totalPage = totalRecord / <strong>numPerPage</strong>;
	} else {
		totalPage = totalRecord / <strong>numPerPage</strong> + 1;
	}	
}
</pre>

<p>
Add the following code that creates the page move link to the bottom of list.jsp.
</p>

<pre class="prettyprint">
&lt;%
for (int i = 1; i &lt;= totalPage; i++) {
%&gt;
	&lt;a href="list.jsp?curPage=&lt;%=i%&gt;"&gt;[&lt;%=i%&gt;]&lt;/a&gt;
&lt;%
}
%&gt;
</pre>

<p>
The page partitioning algorithm is summarized as follows.
</p>

<ol>
	<li>Get the total number of records.</li>
	<li>Set the number of records per page and obtain the total number of pages.</li>
	<li>Find the first ROWNUM number and the last ROWNUM number of the group.</li>
	<li>Create page links.</li>
</ol>

<p>
The following is a list.jsp with page partitioning function.
</p>

<em class="filename">/board/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;List &lt;%=curPage %&gt; page&lt;/title&gt;
&lt;/head&gt;
&lt;body style="font-size: 11px;"&gt;
&lt;h1&gt;List &lt;%=curPage %&gt; page&lt;/h1&gt;
&lt;%
Log log = new Log();

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String sql = null;

//1. Get the total number of records.
int totalRecord = 0;
try {
	con = dbmgr.getConnection();
	sql = "SELECT count(*) FROM board";
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();
	rs.next();
	totalRecord = rs.getInt(1);
} catch (SQLException e) {
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
		dbmgr.freeConnection(con);
	}	
}

//2. Set the number of records per page and obtain the total number of pages.
int numPerPage = 10; //Set the number of records per page
int totalPage = 0;
if (totalRecord != 0) {
	if (totalRecord % numPerPage == 0) {
		totalPage = totalRecord / numPerPage;
	} else {
		totalPage = totalRecord / numPerPage + 1;
	}
}

//3. Find the first ROWNUM number and the last ROWNUM number of the group.
int curPage = request.getParameter("curPage") == null ? 1 : Integer.parseInt(request.getParameter("curPage"));

//first ROWNUM 
int start = (curPage - 1) * numPerPage + 1;
//last ROWNUM
int end = start + numPerPage - 1;

try {
	con = dbmgr.getConnection();
	sql="SELECT no,title,wdate FROM (" +
	         "SELECT ROWNUM R, A.* FROM (" + 
	          "SELECT no, title, wdate FROM board ORDER BY no DESC) A) " +
	         "WHERE R BETWEEN ? AND ?";
	
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, start);
	stmt.setInt(2, end);
	rs = stmt.executeQuery();

	while (rs.next()) {
		int no = rs.getInt("no");
		String title = rs.getString("title");
		Date wdate = rs.getDate("wdate");
%&gt;
&lt;%=no %&gt; &lt;a href="view.jsp?no=&lt;%=no %&gt;"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
  }
} catch(SQLException e) {
	log.debug("Error Source: board/list.jsp's SQLException");
	log.debug("SQLState: " + e.getSQLState());
	log.debug("Message: " + e.getMessage());
	log.debug("Oracle Error Code: " + e.getErrorCode());
	log.debug("sql: " + sql);
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
		dbmgr.freeConnection(con);
	}
	log.close();
}

//4. Create page links.
for (int i = 1; i &lt;= totalPage; i++) {
%&gt;
	&lt;a href="list.jsp?curPage=&lt;%=i %&gt;"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
&lt;%
}
%&gt;
&lt;p&gt;
&lt;a href="write_form.jsp?curPage=&lt;%=curPage %&gt;"&gt;Add New Post&lt;/a&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Visit the list page and click the page link to test it.
</p>

<dl class="note">
<dt>Why can not we use page variables in JSP scripting?</dt>
<dd>
When the JSP is converted to a servlet, the following code is generated and added to the servlet code.
<pre class="prettyprint no-border"><strong>Object page = this;</strong></pre>
In conclusion, you can not use a variable named page in JSP scripting.
</dd>
</dl>

<h3>Oracle 11g's rank() function</h3>

<p>
You can use the rank () function from Oracle 11g.
The following is a query statement that sorts the employee data in salary order in the emp table of the scott account.
</p>

<pre class="prettyprint">
SELECT empno,ename,sal,rank() over (order by sal desc) as rank FROM emp;
</pre>

<p>
With this function, you can change the query statement corresponding to the bulletin board list as follows.
</p>

<pre class="prettyprint">
SELECT no,title,wdate 
FROM (
	SELECT rank() over (order by no desc) R,no,title,wdate FROM board
) 
WHERE R BETWEEN 1 and 10;
</pre>

<h2>Limiting the number of pages link.</h2>

<p>
There is also a problem with the page partitioning function.
If there are 10000 records and numPerPage is 10, 1000 page links are generated as [1] [2] [3] ...... [999] [1000].
A 1000 page link will ruin the web design.
The solution is to divide the page links into groups as well.
I'll call this feature <strong>"Limit the number of page links"</strong>.
</p>

<h3>Divide page links into groups</h3>

<p>
Pages must be grouped to limit the number of links.
If you restrict the number of links to 5 pages to be visible, then links [1] [2] [3] [4] [5] will belong to group 1, and links [6] [7] [8] [9] [10]  will belong to group 2.

<img src="https://lh3.googleusercontent.com/Cbp7bPD4AJmZw_mBKbRTqRIm5QxjwNkeus_Z5Y_40WERLtbMdK_C-vnUT31IMepPG2zj_geFXXxm0apwtK2KpqTjiCi_qptnLX_EkE8AWV56pfVbisRp2iMr6iPydQncSkOh4jd_m1qSDUYwq9cDDbKsKohkClP1q_dMw5_q8YPBez6SIIWnj-NScDhlmtKSD07dM4Gg7BQRS32YYW8sd-dbMC0hi9168t-dTcRDnQCs_wiGcrUjbD1sboIkZRM7okFDN_j6Bg9btSFFcwdbLrWmm5saK94pO3ZET37U86FXW9ejaDXrNHgEZ-JzHefdlrvZ_0hvQk5e6sdDg6wxYpFmfjGuRIeNfJaQWtCabuu8Cp7FS7CGPhR1zMTTyp-SrQsbQSiN_jl0KfVeJ24GITyH-xR8wtophQlc_GnxCc9TX_8q_Xui_M0ol54G8M8pxShhCBsjlmcyf_OUo16LDphoUY7GZ2GPGrFK8aMxlVBqZ0lbzOIjAXTYz6GASk6_cvep8rwE5iEvdmDJ36dCOZLsbWbKVLw0aQhG6redjNG0cCELle9sJXJhrIcSm_fQcmrxN9UHPWXH9ZB1GKy-rYcipiY1YXP92IgbsyOZtneWxqp1nqaSYFJi=w366-h357-no" alt="Divide page links into groups" style="display: block;" />

If the page group unit is called pagePerBlock and the number of the page group to which curPage belongs is stored in a variable called block, the block can be obtained by the following code.
</p>

<em class="filename">Obtaining the block to which curPage belongs.</em>
<pre class="prettyprint">
//Declaring and initializing variables to store the number of the group to which curPage belongs.
int block = 1;

//Declaring and initializing variables to store the number of page links per page link group.
int pagePerBlock = 5;

if (curPage % pagePerBlock == 0) {
	block = curPage / pagePerBlock;
} else {
	block = curPage / pagePerBlock + 1;
}
</pre>

<p>
The first page and last page number belonging to block can be obtained by the following code.
</p>

<pre class="prettyprint">
//The first page belonging to block 
int firstPage = (block - 1) * pagePerBlock + 1;

//The last page belonging to block
int lastPage =  block * pagePerBlock;
</pre>

<p>
Use the loop statement to create a link from the first page to the last page.
</p>

<pre class="prettyprint">
&lt;%
for (int i = firstPage; i &lt;= lastPage; i++) {
%&gt;
	&lt;a href="list.jsp?curPage=&lt;%=i%&gt;"&gt;[&lt;%=i%&gt;]&lt;/a&gt;
&lt;%
}
%&gt;
</pre>

<p>
If you modify list.jsp as described above, you get the following results.

<img src="https://lh3.googleusercontent.com/zk88YMFPxv1fewDNDdm8aCXi5kCG3U9A_ltOAnL-HAc_zX5cO8r9RdfCb2B2_PHGxTxV09e8g7-6Z9dYi3W7aJcggr84XU_jOVz8JQmwkEvvbO-CorNMZCnxBFmzJ4PVanwDAaduRKyMIpaSbLuHCWVLyKOK58GKZMddWQpQFwu-ONRUSj-BtLBO_YlrLAsOXRrQI8uhwr07mAqRa7wOe9PQpp9uyppnoxz35DxbRC1TbH8uGJ__jQQciqWa42cH4IW1cOhJuBYGaNqGDiiCNO7e11fb-nfyw0SZNAlvDUl7NJ5fd9YwezBrKQN2gtgTolM4ez7q5qU2WpQtdjL8_MlIUI-0g675of9FbW0e3rlroBR2seAaEX2xrBqlEjHqn5FDJucQTJRrueZJ2NBgb23AlQg9TzSdMRuotG2-0Jbsg6ydBfBvdKTlTeED7wYQsEtTKoDnrH1ucPGN6nlzEVWTGM_IndnqeUlllG8lULoBa6mvHogFBBKBTRBQXldz3kMBryThmfpPa8sL5WuglVBQAnQOGNBmtqrLIsMZ5pQq1Z6HofvQHQHTvSfzuOyBQ5X-TZ9qVV8W97gbJdYl8KnxlxWDKFEtMswO5iPuBzTEtYDJbJy8e-r8=w363-h340-no" alt="Group page links" style="display: block;" />

Obtaining the page group to which the current page belongs and showing only pages belonging to that page group succeeded.
But there is no way to move to another page group.
The most common solution is to create a link so that you can move to an adjacent page group.
If the block is greater than 1, Creates a [&lt;] link and link "list.jsp?curPage=&lt;%=firstPage-1 %&gt;" to that. 
If the block is smaller than the total number of blocks (the total number of blocks is equal to the last block number), Create a [&gt;] link and link "list.jsp?curPage=&lt;%=lastPage+1 %&gt;"to that.
This allows you to navigate to adjacent page groups using the [&lt;] [&gt;] link.
To create a [&gt;] link, you need additional code to get the total number of blocks, or the last block number.
</p>

<pre class="prettyprint">
int totalBlock = 0;

if (totalPage &gt; 0) { 
	if (totalPage % pagePerBlock == 0) {
		totalBlock = totalPage / pagePerBlock;
	} else {
		totalBlock = totalPage / pagePerBlock + 1;
	}
}
</pre>

<p>
You can generate the [&lt;] and [&gt;] links with the following code.
</p>

<pre class="prettyprint">
&lt;%
int prevPage = 0;
if(block &gt; 1) {
	prevPage = firstPage - 1;
%&gt;
	&lt;a href="list.jsp?curPage=&lt;%=prevPage %&gt;"&gt;[&lt;]&lt;/a&gt;
&lt;%
}
%&gt;
</pre>

<pre class="prettyprint">
&lt;%
if(block &lt; totalBlock) {
	int nextPage = lastPage + 1;
%&gt;
	&lt;a href="list.jsp?curPage=&lt;%=nextPage %&gt;"&gt;[&gt;]&lt;/a&gt;
&lt;%
}
%&gt;
</pre>

<p>
Modify the list.jsp as described above.
</p>

<p>
The following is a list after modification.
You can see the links [&lt;] and [&gt;] to move to adjacent page groups.
<img src="https://lh3.googleusercontent.com/M2JdgNTMDvNzvdYnHNRUuOceaxUI85ukmUiDjEboGVRgzR8g-vNdtLLzVXeOR6Zl_krJdOv1VZfqQNBIIbfNvhU393Z768pLJkQvozE3-SlQSpXrDuY0dwkZe9hcOww1cb2TpDFOgmaVwsQiybMIt2Sk2fovc8ZP_qA6BojPtNlNQpca_f3ujhhrC8krW-GdiGCfER48_xscK0no64nEfiOF725JvnBPDUZWcEfIBI1ozkUt3iY_U4nykVqPIZyBwzMvxEnEUgbXTkbk-im12niR1XqDcbOJbofVoEP3owXtdgPdVwyJguQ9wX0HUzvnHuXhxvC55ytYMcwfv1eES-YcUsjCZzsnoNNNIJeVxhxaI7-KXO8evOB4j9-In_EpqNjDsWBzYpP_W_3DU9p2TXgUbKAi0Z5vTOg88vnObTFL4_T20ZhtBRzBM0XgNyoZDUZjYpft9smxFnttbM0GP6SvTERLTg3-hAC3h-W0BIuotWCQDocavx4sMn_HrEWvPhXBwmO0CdZzuGxGRU4KMLvKrw4HnXyDXMnxBtLasgQFb5cLvZ-D7r8_-3i6FJs8wZbuAZMdBXXJUjb_VvlndI77bCWfM4HU5p6A8MDSkBjoQI5AUc_jAEKq=w212-h296-no" alt="Group pages" style="display: block;" />
<img src="https://lh3.googleusercontent.com/OaInFDlgr7ttlx3F6cOYUq58S5DF4jyYvhHGB50HF1sKSLJC2ve0946BJ-jT6u4hC3Qf080c98ajrpDxMyhs2an5qv75iTxR7rv_S47LGuFlcMjIBWqRkKNEKo4WDNzpiBFzeQazJtMuG5ScaRt1BUYx315Gi0YLjrcrzfphvceKKrhA6LwZwbO7W4sCTWYsOVNYAJf_NL5NUM2DKshKCs8---AJ44ia_88Q7BwritlpUwNSax6Fy0VQhSBkm9idmvP2P8pQvc2iNvpMX4zB1nUGs-qwa130SnWQIQnVjaPgEPdK9IXjca-rk9ah-J015hLwcqhgyhoKUJsEl-Ab5aMMZPDvIV1569Mw7YKrfBQGfe1VFBCNbx9EirEXt39RceUwS9XVNnz-lHOMVIl_Y91AAJ19nafRoxZ3zgNqbCsR3EpN4jWheshnF4zOeaAO5-t_Owzqm74O1rB9G3cNDNe7itgDpFxnSsT8gm4c8vbu5a_CF30c47LI7JZCmbWNBDO9s5TjAe9IhY2XRyerC_GwZGxqj2cvLGJOwHDujONcj1vs0SIxt0vypka5J2JJUcLzMt6bukarQcLLGGgHFrAXyAV_HRB_HBEpsLn8jiPu4VUS_MFNZWKi=w212-h287-no" alt="Group pages" style="display: block;" />
</p>

<p>
There seems to be no problem, but there are still bugs.
After adding the records so that the total number of records is 101, move to the last block using the [&gt;] link.
<img src="https://lh3.googleusercontent.com/7t5Cv7nxxsjbNmRAvyMphWR74Jo3bFiDLQsqr6Qb7I-VKgFCfmL-p9_mpng0gru-i9IsaYn4PxsS4I1WCS03rUXih9nA23kBTWd9sS_pKCNxB9W1Po2R5xakx3cFs_KAb33LYMD4f_FW1uG3HHxaiO0jE0tjHvvnsWj8_7S0IwfK_gzU2RKP4IUpBaPb-g6OJz4xGgNXLtCWlyEXSWdA0izg8qfu5OmUYSMH44jqMIJYCV0j0gsRbvhCqphH6vkSzMe-Q3lFYTROpq12KyPqrOYsmd-4rXqsM-jq-6onQodyBFdt_IZBUv3lw8AI39_XE6MvqlGrrBPWRmzux7jSoUulKoU6y3Z2NUzvTyl4ifdmlJT8DNG-NU4RnJ0TCEpGfZCadOA8Be6MFYheVZGl_X021Ld7KRogsE-rOrzq9wJ5Ow8hMKD-3sc0JwqFs0W22JcpRudcq9VwOkD-DRQoyaM3KTisx_gTUVBheloFdkpZFUn85U6TErIRYnSy3PYjws2CyH5CaDO4S9fuJPUERY8HQR3kanRwkT3QQOYqjqDyfB-S2r0QGmACtblUCULJDCU6c2llKlyh4HW4NW-MHLh9TYttHYkIOo_EVnq6Gj8225arir_ai91v=w452-h68-no" alt="Group pages" style="display: block;" />

It can be confirmed that unnecessary page links ([12] [13] [14] [15]) are generated in the last block.
If numPerPage is 10 when the record is 101, totalPage is 11.
And if pagePerBlock is 5, then totalBlock is 3.
The last page number in the block 3 is calculated as 15, so that unnecessary links [12] [13] [14] [15] are created.
To prevent unnecessary page links from being created, the last page number in the last block should be set to the total number of pages (this is the same as the last page number).
Add the following code before the for statement that prints the pagination link:
</p>

<pre class="prettyprint">
if (block &gt;= totalBlock) {
	lastPage = totalPage;
}
</pre>

<h3>Final page segmentation algorithm</h3>
<ol>
	<li>Sets the number of page links per block.</li>
	<li>Calculate the total number of blocks.</li>
	<li>Calculate the block to which the current page belongs.</li>
	<li>Calculate the first and last page to link in the block.</li>
	<li>Remove unnecessary pages from the block.</li>
	<li>If block &gt; 1, create a [&lt;] link to go to firstPage - 1.</li>
	<li>Use the loop statement to create a link from the first page of the block to the last page of the block.</li>
	<li>If block &gt; totalBlcok, creates a [&gt;] link go to lastPage + 1.</li>
</ol>

<h3>Modify the board component other than list.jsp</h3>

<p>
After visiting view.jsp from list.jsp?curPage=5 and clicking the "List" link in view.jsp, you will be visiting list.jsp.
In other words, I saw the View Post on page 5 and came back to page 1.
It is common sense to see the View Post on page 5 and go back to page 5 when you click the "List" link.
To do so, you must pass the curPage parameter to all the components associated with the bulletin board, except for the "servlet that handles new writing", and the component that passed the curPage must add this parameter to the query string of the link to move to the other component.
Open the /board/list.jsp file and modify the query string of the link as shown below.
</p>

<em class="filename">Pass curPage parameter when moving from list.jsp to view.jsp</em>
<pre class="prettyprint">
&lt;a href="view.jsp?no=&lt;%=no %&gt;<strong>&amp;curPage=&lt;%=curPage %&gt;</strong>"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;
</pre>

<em class="filename">Pass curPage parameter when moving from list.jsp to write_form.jsp</em>
<pre class="prettyprint">
&lt;a href="write_form.jsp?<strong>curPage=&lt;%=curPage %&gt;</strong>"&gt;Add New Post&lt;/a&gt;
</pre>

<p>
Open the /board/view.jsp file and modify the query string for the move link to other components.
</p>

<em class="filename">/board/view.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
<strong>String curPage = request.getParameter("curPage");</strong>
%&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;View Post&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no,<strong>curPage</strong>) {
	location.href="modify_form.jsp?no=" + no + <strong>"&amp;curPage=" + curPage</strong>;
}

function goDelete(no,curPage) {
	var check = confirm('Are you sure you want to delete it?');
	if (check) {
		location.href="../servlet/BoardDeleter?no=" + no + <strong>"&amp;curPage=" + curPage</strong>;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;View Post&lt;/h1&gt;

.. Omit ..

&lt;a href="list.jsp<strong>?curPage=&lt;%=curPage %&gt;</strong>"&gt;List&lt;/a&gt;
&lt;input type="button" value="Edit Post" onclick="javascript:goModify('&lt;%=no %&gt;',<strong>'&lt;%=curPage %&gt;'</strong>)"&gt;
&lt;input type="button" value="Delete Post" onclick="javascript:goDelete('&lt;%=no %&gt;',<strong>'&lt;%=curPage %&gt;'</strong>)"&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Open the /board/write_form.jsp file and modify the code to return to the list.
However, you should not change the form action property to ../servlet/BoardWriter?curPage=&lt;%=curPage%>.
Why? New articles are always visible on the first page of the list.
I registered a new article on page 5, but if I go back to page 5, I can not see the new article I wrote.
Therefore, if you register a new article, it is correct to go to the first page of the list.
</p>

<em class="filename">/board/write_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
<strong>String curPage = request.getParameter("curPage");</strong>
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;Add New Post&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Add New Post&lt;/h1&gt;
&lt;form action="../servlet/BoardWriter" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;Title&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50"&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="20" cols="100"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="Submit"&gt;
		&lt;input type="reset" value="Reset"&gt;
		&lt;a href="list.jsp<strong>?curPage=&lt;%=curPage %&gt;</strong>"&gt;List&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;  
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/board/modify_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
<strong>String curPage = request.getParameter("curPage");</strong>

Log log = new Log();


//.. Omit ..

%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;Edit Post&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Edit Post&lt;/h1&gt;
&lt;form action="../servlet/BoardModifier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
<strong>&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;"&gt;</strong>
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;Title&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=title %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=content %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="Submit"&gt;
		&lt;input type="reset" value="Reset"&gt;
		&lt;a href="view.jsp?no=&lt;%=no %&gt;<strong>&amp;curPage=&lt;%=curPage %&gt;</strong>"&gt;View Post&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardModifier</em>
<pre class="prettyprint">
@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {

	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	<strong>String curPage = req.getParameter("curPage");</strong>
	
	//.. Omit ..
				
	String path = req.getContextPath();
	resp.sendRedirect(path + "/board/view.jsp?no=" + no + <strong>"&amp;curPage=" + curPage</strong>);
	
}
</pre>

<em class="filename">BoardDeleter</em>
<pre class="prettyprint">
@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	
	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	<strong>String curPage = req.getParameter("curPage");</strong>
		
	//.. Omit ..
	
	String path = req.getContextPath();
	resp.sendRedirect(path + "/board/list.jsp<strong>?curPage=" + curPage</strong>);
	
}
</pre>

<p>
Web programmers should be familiar with paging.
You should have a thorough understanding of paging through implementation and sufficient testing.
</p>

<h2>Search</h2>

<p>
If you have a lot of posts, you need a search function.
Add the following code at the bottom of list.jsp.
</p>

<pre class="prettyprint">
&lt;form action="list.jsp" method="post"&gt;
	&lt;input type="text" size="10" maxlength="30" name="keyword" /&gt;
	&lt;input type="submit" value="Search" /&gt;
&lt;/form&gt;
</pre>

<p>
Now you need to pass list.jsp with a keyword parameter in addition to curPage.
If the received keyword parameter is null, it is recommended to replace it with the character "".
Add the following code to the appropriate location in list.jsp.
</p>

<pre class="prettyprint">
String keyword = request.getParameter("keyword");
if (keyword == null) keyword = "";
</pre>

<p>
When a search is added, the total number of records changes according to the search condition.
Therefore, modify the part of the list.jsp to obtain the total number of records as follows.
</p>

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT count(*) FROM board";
} else {
	sql = "SELECT count(*) FROM board " +
		"WHERE title LIKE '%" + keyword + "%' " + 
		"OR content LIKE '%" + keyword + "%'";
}
</pre>

<p>
Modify the query to retrieve the records for that page.
</p>

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT no,title,wdate " + 
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,title,wdate FROM board ORDER BY no DESC) A) " +
		"WHERE R BETWEEN ? AND ?";
} else {
	sql = "SELECT no,title,wdate " +
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,title,wdate FROM board " +
		"WHERE title LIKE '%" + keyword + "%' OR content LIKE '%" + keyword + "%' " +
		"ORDER BY no DESC) A) " +
		"WHERE R BETWEEN ? AND ?";
}
</pre>

<p>
When you click the 5th page link at the bottom of the list page of search results, you should not go to the 5th page of the unscanned list.
Open the list.jsp file and modify it to pass the keyword parameter to the link to list.jsp.
</p>

<pre class="prettyprint">
&lt;a href="list.jsp?curPage=&lt;%=prevPage %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;[&lt;]&lt;/a&gt;
</pre>

<pre class="prettyprint">
&lt;a href="list.jsp?curPage=&lt;%=i %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
</pre>

<pre class="prettyprint">
&lt;a href="list.jsp?curPage=&lt;%=nextPage %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;[&gt;]&lt;/a&gt;
</pre>

<p>
If you move to the View Post from the list of search results and then use the [List] link to return to the list, you will not be able to return to the list that was searched.
When you request view.jsp, you need to pass a parameter called keyword in addition to curPage to get back to the search list.
Open the list.jsp file and see below to modify the link to View Post and Add New Post.
</p>

<pre class="prettyprint">
&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;
</pre>

<pre class="prettyprint">
&lt;a href="write_form.jsp?curPage=&lt;%=curPage %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;Add New Post&lt;/a&gt;
</pre>

<p>
Modify the code so that view.jsp receives the curPage and keyword parameters, and then uses the curPage and keyword parameters when returning to list.jsp.
Other components of the bulletin board, except for the writing process servlet, also receive the keyword parameter and modify it so that the keyword parameter is added to the link from the code to the other component.
</p>

<em class="filename">/board/view.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;%
<strong>request.setCharacterEncoding("UTF-8");</strong>
int no = Integer.parseInt(request.getParameter("no"));
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");
%&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;View Post&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no,curPage,keyword) {
	location.href="modify_form.jsp?no=" + no + "&amp;curPage=" + curPage + <strong>"&amp;keyword=" + keyword</strong>;
}

function goDelete(no,curPage,keyword) {
	var check = confirm('Are you sure you want to delete it?');
	if (check) {
		location.href="../servlet/BoardDeleter?no=" + no + "&amp;curPage=" + curPage + <strong>"&amp;keyword=" + keyword</strong>;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;View Post&lt;/h1&gt;

.. Omit ..

&lt;a href="list.jsp?curPage=&lt;%=curPage %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;List&lt;/a&gt;
&lt;input type="button" value="Edit Post" onclick="javascript:goModify('&lt;%=no %&gt;','&lt;%=curPage %&gt;',<strong>'&lt;%=keyword %&gt;'</strong>)"&gt;
&lt;input type="button" value="Delete Post" onclick="javascript:goDelete('&lt;%=no %&gt;','&lt;%=curPage %&gt;',<strong>'&lt;%=keyword %&gt;'</strong>)"&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Modify the following components for the same reason as above.
However, BoardWriter.java does not need to be modified.
</p>

<em class="filename">/board/write_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
<strong>request.setCharacterEncoding("UTF-8");</strong>
String curPage = request.getParameter("curPage");
<strong>String keyword = request.getParameter("keyword");</strong>
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Add New Post&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Add New Post&lt;/h1&gt;
&lt;form action="../servlet/BoardWriter" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;Title&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50"&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="20" cols="100"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="Submit"&gt;
		&lt;input type="reset" value="Reset"&gt;
		&lt;a href="list.jsp?curPage=&lt;%=curPage %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;List&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;  
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/board/modify_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;%
<strong>request.setCharacterEncoding("UTF-8");</strong>
String no = request.getParameter("no");
String curPage = request.getParameter("curPage");
<strong>String keyword = request.getParameter("keyword");</strong>
Log log = new Log();

//.. Omit ..

%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Edit Post&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Edit Post&lt;/h1&gt;
&lt;form action="../servlet/BoardModifier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;"&gt;
<strong>&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;"&gt;</strong>
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;Title&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=title %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=content %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="Submit"&gt;
		&lt;input type="reset" value="Reset"&gt;
		&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;View Post&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardModifier</em>
<pre class="prettyprint">@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {

	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	String curPage = req.getParameter("curPage");
	<strong>String keyword = req.getParameter("keyword");</strong>
	
	//.. Omit ..
				
	String path = req.getContextPath();
	<strong>keyword = java.net.URLEncoder.encode(keyword,"UTF-8");</strong>
	resp.sendRedirect(path + "/board/view.jsp?no=" + no + "&amp;curPage=" + curPage + <strong>"&amp;keyword=" + keyword</strong>);
	
}
</pre>


<em class="filename">BoardDeleter</em>
<pre class="prettyprint">@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	
	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	String curPage = req.getParameter("curPage");
	<strong>String keyword = req.getParameter("keyword");</strong>
		
	//.. Omit ..
	
	String path = req.getContextPath();
	<strong>keyword = java.net.URLEncoder.encode(keyword,"UTF-8");</strong>
	resp.sendRedirect(path + "/board/list.jsp?curPage=" + curPage + <strong>"&amp;keyword=" + keyword</strong>);

}
</pre>

<h3>keyword = java.net.URLEncoder.encode(keyword,"UTF-8");</h3>

<p> 
The reason for the keyword = java.net.URLEncoder.encode (keyword, "UTF-8") code is that the encoding of the Java string and the URL address character, which are arguments to the sendRedirect () method of HttpServletResponse, are different.
The URLEncoder encode () method allows you to get the byte value for non-English characters.
This code needs to modify the server settings to work the way we want.
Open the {TOMCAT_HOME}/conf/server.xml file and make sure that the Connector element has the URIEncoding attribute set to UTF-8, as shown below, with the Connector element having the port attribute value of 8080 (we had to change it to 8989).
If there is no URIEncoding attribute, add it as follows.
</p>

<pre class="prettyprint">
&lt;Connector port="8080" protocol="HTTP/1.1" 
	connectionTimeout="20000" 
	<strong>URIEncoding="UTF-8"</strong>
	redirectPort="8443" /&gt;
</pre>

<p>
Tomcat uses ISO-8859-1 as the default character encoding for URLs that contain query strings.
In other words, the encoding of GET parameters is ISO-8859-1.
URIEncoding="UTF-8" setting changes the character encoding for the URL to UTF-8.
With this setting, it is possible to transmit a parameter whose value are in non-english characters by the GET method.
To apply this setting, rerun Tomcat.
For English-only sites, the above settings may not be necessary.
</p>


<span id="refer">References</span>
<ul id="references">
	<li><a href="https://docs.oracle.com/cd/B28359_01/server.111/b28286/pseudocolumns009.htm#SQLRF00255">https://docs.oracle.com/cd/B28359_01/server.111/b28286/pseudocolumns009.htm#SQLRF00255</a></li>
	<li><a href="http://wiki.apache.org/tomcat/FAQ/CharacterEncoding">http://wiki.apache.org/tomcat/FAQ/CharacterEncoding</a></li>
	<li><a href="https://en.wikipedia.org/wiki/Create,_read,_update_and_delete">https://en.wikipedia.org/wiki/Create,_read,_update_and_delete</a>
</ul>
</article>