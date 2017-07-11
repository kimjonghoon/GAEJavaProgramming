<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>
<div class="last-modified">Last Modified 2017.4.11</div>

<h1>Hierarchical BBS (Thread BBS)</h1>

<p>
A hierarchical bulletin board is a bulletin board in which the posts and their replies are vertically hierarchical.
If the database you choose supports hierarchical queries, you may want to consider hierarchical queries when implementing hierarchical bulletin boards.
However, if the cost of a hierarchical query is large, you may have to give up the hierarchical query.
</p>

<p>
In this section, you will learn about the solution when the database does not support hierarchical queries, 
and then you will study hierarchical queries.
</p>

<p>
In the table below, 25 posts, 26 posts, 27 posts, 29 posts are registered through a New.
These are the top posts in their group.The replies are written through an Reply (not yet implemented).
</p>

<table>
<tr>
	<th>no</th>
	<th>title</th>
	<th>wdate</th>
</tr>
<tr>
	<td>29</td>
	<td><em>29 posts</em></td>
	<td>2007/12/09</td>
</tr>
<tr>
	<td>27</td>
	<td><em>27 posts</em></td>
	<td>2007/11/27</td>
</tr>
<tr>
	<td>32</td>
	<td><span style="padding-left: 14px;">&#8627; First reply in 27 posts</span></td>
	<td>2007/12/22</td>
</tr>
<tr>
	<td>26</td>
	<td><em>26 posts</em></td>
	<td>2007/11/25</td>
</tr>
<tr>
	<td>30</td>
	<td><span style="padding-left: 14px;">&#8627; Second reply in 26 posts</span></td>
	<td>2007/12/20</td>
</tr>
<tr>
	<td>31</td>
	<td><span style="padding-left: 28px;">&#8627; First reply in 30 posts</span></td>
	<td>2007/12/21</td>
</tr>
<tr>
	<td>33</td>
	<td><span style="padding-left: 42px;">&#8627; First reply in 31 posts</span></td>
	<td>2007/12/23</td>
</tr>
<tr>
	<td>28</td>
	<td><span style="padding-left: 14px;">&#8627; First reply in 26 posts</span></td>
	<td>2007/12/01</td>
</tr>
<tr>
	<td>25</td>
	<td><em>posts 1</em></td>
	<td>2007/11/20</td>
</tr>
</table>

<h2>Fields to add for hierarchical bulletin boards</h2>

<p>
To implement a hierarchical bulletin board, each post should have the following information:
</p>

<ol>
	<li>The post should have information about which group it belongs to.</li>
	<li>The post should have information about how far below it is from the top-level article in the group.</li>
	<li>The post should have information about how much its title should be indented in the list page.</li>
</ol>

<p>
Add the family column for 1.
Add a depth column for 2.
Add the indent column for 3.
</p>

<table class="table-in-article">
<tr>
	<th>Column</th>
	<th>Type</th>
	<th>Description</th>
</tr>
<tr>
	<td>family</td>
	<td>number</td>
	<td>Group number</td>
</tr>
<tr>
	<td>depth</td>
	<td>number</td>
	<td>Order from the top of the group</td>
</tr>
<tr>
	<td>indent</td>
	<td>number</td>
	<td>Indentation level</td>
</tr>
</table>

<p>
This seems to be enough.
However, consider the case of deleting a post.
If you delete 30th post on the bulletin board and leave posts 31 and 33, users will think it is a bug.
When you delete 30th post, you can not solve it by family, depth, and indent.
Therefore, if the reply post is a child post, the post need more information about its parent's post. 
Add the parent column to store this information.
</p>

<table class="table-in-article">
<tr>
	<th>no</th>
	<th>parent</th>
	<th>title</th>
	<th>wdate</th>
</tr>
<tr>
	<td>29</td>
	<td>0</td>
	<td>29 posts</td>
	<td>2007/12/09</td>
</tr>
<tr>
	<td>27</td>
	<td>0</td>
	<td>27 posts</td>
	<td>2007/11/27</td>
</tr>
<tr>
	<td>32</td>
	<td>27</td>	
	<td>&nbsp;&nbsp;&#8627; First reply in 27 posts</td>
	<td>2007/12/22</td>
</tr>
<tr>
	<td>26</td>
	<td>0</td>
	<td>26 posts</td>
	<td>2007/11/25</td>
</tr>
<tr style="background: #999;font-weight: bold;">
	<td>30</td>
	<td>26</td>
	<td style="text-decoration: line-through;">&nbsp;&nbsp;&#8627; Second reply in 26 posts</td>
	<td>2007/12/20</td>
</tr>
<tr style="background: #999;font-weight: bold;">
	<td>31</td>
	<td>30</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&#8627; First reply in 30 posts</td>
	<td>2007/12/21</td>
</tr>
<tr style="background: #999;font-weight: bold;">
	<td>33</td>
	<td>31</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8627; First reply in 31 posts</td>
	<td>2007/12/23</td>
</tr>
<tr>
	<td>28</td>
	<td>26</td>
	<td>&nbsp;&nbsp;&#8627; First reply in 26 posts</td>
	<td>2007/12/01</td>
</tr>
<tr>
	<td>25</td>
	<td>0</td>
	<td>25 posts</td>
	<td>2007/11/20</td>
</tr>
</table>

<p>
If you have a parent column, you can delete 31 and 33 together when you delete 30.
In conclusion, the columns needed for a hierarchical bulletin board are:
</p>

<table class="table-in-article">
<tr>
	<th>Column</th>
	<th>Type</th>
	<th>Description</th>
</tr>
<tr>
	<td>family</td>
	<td>number</td>
	<td>Group number</td>
</tr>
<tr style="font-weight: bold;">
	<td>parent</td>
	<td>number</td>
	<td>The no column value of the parent posts</td>
</tr>
<tr>
	<td>depth</td>
	<td>number</td>
	<td>Order from the top of the group</td>
</tr>
<tr>
	<td>indent</td>
	<td>number</td>
	<td>Indentation level</td>
</tr>
</table>

<h2>Hierarchical bulletin board algorithm</h2>

<h3>New posts</h3>

<p>
A created posts through New create a group.
The column values are determined as follows.
</p>

<table class="table-in-article">
<tr>
	<th>Field</th>
	<th>Value</th>
</tr>
<tr>
	<td>family</td>
	<td>Same as no column value.</td>
</tr>
<tr>
	<td>parent</td>
	<td>0</td>
</tr> 
<tr>
	<td>depth</td>
	<td>0</td>
</tr>
<tr>
	<td>indent</td>
	<td>0</td>
</tr>
</table>

<h3>Reply</h3>

<p>
The column values are determined as follows. 
</p>

<table class="table-in-article">
<tr>
	<th>Field</th>
	<th>Value</th>
</tr>
<tr>
	<td>family</td>
	<td>Group number</td>
</tr>
<tr>
	<td>parent</td>
	<td>parent posts's no</td>
</tr>
<tr>
	<td>depth</td>
	<td>(parent's depth) + 1</td>
</tr>
<tr>
	<td>indent</td>
	<td>(parent's indent) + 1</td>
</tr>
</table>

<h3>Changing the board table for a hierarchical bulletin board</h3>

<pre class="prettyprint">
alter table board 
add (family number, parent number, depth number, indent number)
/
update board set family = no, parent = 0, depth = 0, indent = 0
/
</pre>

<h3>Modify an existing bulletin board to a hierarchical bulletin board: list.jsp</h3>

<p>
Open list.jsp and modify the following query to retrieve the records.
</p>

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT no,family,parent,depth,indent,title,wdate " +
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,family,parent,depth,indent,title,wdate FROM board " + 
		"ORDER BY family DESC, depth ASC) A) " +
		"WHERE R BETWEEN ? AND ?";
} else {
	sql = "SELECT no,family,parent,depth,indent,title,wdate " +
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,family,parent,depth,indent,title,wdate FROM board " +
		"WHERE title LIKE '%" + keyword + "%' OR content LIKE '%" + keyword + "%' " + 
	    "ORDER BY family DESC, depth ASC) A) " + 
		"WHERE R BETWEEN ? AND ?";
}
</pre>

<p>
Indent as shown below.
</p>

<pre class="prettyprint">
while (rs.next()) {
	int no = rs.getInt("no");
	String title = rs.getString("title");
	Date wdate = rs.getDate("wdate");
	int indent = rs.getInt("indent");
	for (int i = 0; i &lt; indent; i++) {
		out.println("&amp;nbsp;&amp;nbsp;");
	}
	if(indent != 0) {
		out.println("&#8627;");
	}
	
	//.. Omit ..

</pre>

<p>
If it is an answer (indent! = 0), add &amp;nbsp;&amp;nbsp; as long as the indent column value and add "&#8627;" before the title.
</p>

<h3>Modify an existing bulletin board to a hierarchical bulletin board: New posts</h3>

<p>
Open the BoardWriter.java servlet file and modify the query as shown below.
</p>

<pre class="prettyprint">
String sql = "INSERT INTO board (no,title,content,wdate,family,parent,depth,indent) "
	+ "VALUES (board_no_seq.nextval, ?, ?, sysdate, board_no_seq.nextval, 0, 0, 0)";
</pre>

<h3>Modify an existing bulletin board to a hierarchical bulletin board: view.jsp</h3>

<p>
Open the view.jsp file and insert the following code in the appropriate location:
</p>

<pre class="prettyprint">
&lt;a href="reply_form.jsp?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;Reply&lt;/a&gt;
</pre>

<h3>Modify an existing bulletin board to a hierarchical bulletin board: Reply</h3>

<p>
Create reply_form.jsp as shown below.
</p>

<em class="filename">/board/reply_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;%! static final String LINE_SEPARATOR = System.getProperty("line.separator"); %&gt; 
&lt;%
request.setCharacterEncoding("UTF-8");
Log log = new Log();

int family = 0;
int indent = 0;
int depth = 0;

String title = null;
String content = null;
Date wdate = null;

int no = Integer.parseInt(request.getParameter("no"));
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String sql = "SELECT no, family, depth, indent, title, content, wdate " +
        "FROM board " +
        "WHERE no = ?";

try {
	con = dbmgr.getConnection();
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, no);
	rs = stmt.executeQuery();

	rs.next();
	no = rs.getInt("no");
	family = rs.getInt("family");
	depth = rs.getInt("depth");
	indent = rs.getInt("indent");
	title = rs.getString("title");
	content = rs.getString("content");

	//Add &amp;gt; for each line of the parent text.
	content = content.replaceAll(LINE_SEPARATOR, LINE_SEPARATOR + "&gt;");
	content = LINE_SEPARATOR + LINE_SEPARATOR +"&gt;" + content;
	wdate = rs.getDate("wdate");
} catch (SQLException e) {
	log.debug("Error Source : board/modify_form.jsp : SQLException");
	log.debug("SQLState : " + e.getSQLState());
	log.debug("Message : " + e.getMessage());
	log.debug("Oracle Error Code : " + e.getErrorCode());
	log.debug("sql : " + sql );
} finally {
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {}
	}
	if (stmt != null) {
		try {
			stmt.close();
		} catch (SQLException e) {}
	}
	if (con != null) {
		try {
			con.close();
		} catch (SQLException e) {}
	}
}
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;Reply&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Reply&lt;/h1&gt;
&lt;form action="../servlet/BoardReplier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;
&lt;input type="hidden" name="family" value="&lt;%=family %&gt;" /&gt;
&lt;input type="hidden" name="indent" value="&lt;%=indent %&gt;" /&gt;
&lt;input type="hidden" name="depth" value="&lt;%=depth %&gt;" /&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;" /&gt;
&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;" /&gt;
Title: &lt;input type="text" name="title" size="45" value="&lt;%=title %&gt;" /&gt;&lt;br /&gt;
&lt;textarea name="content" rows="10" cols="60"&gt;&lt;%=content %&gt;&lt;/textarea&gt;&lt;br /&gt;
&lt;input type="submit" value="Submit" /&gt;
&lt;input type="reset" value="Reset" /&gt;&lt;br /&gt;
&lt;/form&gt;
&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;View&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<p>
Create BoardReplier.java.
</p>

<em class="filename">BoardReplier.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardReplier extends HttpServlet {
  
	private static final long serialVersionUID = -4670255864421603178L;
	
	OracleConnectionManager dbmgr = null;
	
	//Query for depth update
	String sql1 = "UPDATE board SET depth = depth + 1 " + 
			"WHERE family = ? AND depth &gt; ? ";
	
	//Queries for reply
	String sql2 = "INSERT INTO board " + 
			"(no, family, parent, depth, indent, title, content, wdate) " + 
			"VALUES (board_no_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate)";
	
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
		
		int parent = Integer.parseInt(req.getParameter("no"));
		int family = Integer.parseInt(req.getParameter("family"));
		int depth = Integer.parseInt(req.getParameter("depth"));
		int indent = Integer.parseInt(req.getParameter("indent"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		String curPage = req.getParameter("curPage");
		String keyword = req.getParameter("keyword");
		
		Connection con = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		
		try {
			con = dbmgr.getConnection();
			con.setAutoCommit(false);
			
			stmt1 = con.prepareStatement(sql1);
			stmt1.setInt(1,family);
			stmt1.setInt(2,depth);
			stmt1.executeUpdate();
			
			stmt2 = con.prepareStatement(sql2);
			stmt2.setInt(1, family);
			stmt2.setInt(2, parent);
			stmt2.setInt(3, depth+1);
			stmt2.setInt(4, indent+1);
			stmt2.setString(5, title);
			stmt2.setString(6, content);
			stmt2.executeUpdate();
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			log.debug("Error Source:BoardReplier.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql2);
		} finally {
			if (stmt1 != null) {
				try {
					stmt1.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt2 != null) {
				try {
					stmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			String path = req.getContextPath();
			keyword = java.net.URLEncoder.encode(keyword,"UTF-8");
			resp.sendRedirect(path + "/board/list.jsp?curPage=" + curPage + "&amp;keyword=" + keyword);
		}

	}
}
</pre>

<p>
Now that you have created a new servlet, BoardReplier, add the servlet definition and mapping settings to the web.xml file as shown below.
</p>

<pre class="prettyprint">
&lt;servlet&gt;
	&lt;servlet-name&gt;BoardReplier&lt;/servlet-name&gt;
	&lt;servlet-class&gt;net.java_school.board.BoardReplier&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
	&lt;servlet-name&gt;BoardReplier&lt;/servlet-name&gt;
	&lt;url-pattern&gt;/servlet/BoardReplier&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

<p>
Now that web.xml has changed, re-run Tomcat.
Visit the detailed view and click Reply to write the reply.
</p>

<h3>Modify an existing bulletin board to a hierarchical bulletin board: Delete</h3>

<h3>Delete (not deleted if there is a reply from the post)</h3>

<pre class="prettyprint">
String sql1 = "SELECT count(*) FROM board WHERE parent = ?";
String sql2 = "DELETE FROM board WHERE no = ?";

boolean check = false;

Connection con = null;
PreparedStatement stmt1 = null;
PreparedStatement stmt2 = null;
ResultSet rs = null;

con = dbmgr.getConnection();
stmt1 = con.prepareStatement(sql1);
stmt1.setInt(1, no);
rs = stmt1.executeQuery();
rs.next();
int num = rs.getInt(1);
if (num == 0) {
	check = true;
}
if (check == true) {
	stmt2 = con.prepareStatement(sql2);
	stmt2.setInt(1, no);
	stmt2.executeUpdate();
}
</pre>

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
	
	private OracleConnectionManager dbmgr;
	
	private static final String SQL1 = "SELECT count(*) FROM board WHERE parent = ?";
	private static final String SQL2 = "DELETE FROM board WHERE no = ?";
	
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager) sc.getAttribute("dbmgr");
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
		String curPage = req.getParameter("curPage");
		String keyword = req.getParameter("keyword");
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		ResultSet rs = null;
		
		boolean check = false;
		
		try {
			stmt1 = con.prepareStatement(SQL1);
			stmt1.setInt(1, no);
			rs = stmt1.executeQuery();
			rs.next();
			int num = rs.getInt(1);
			if (num == 0) {
				check = true;
			}
			if (check == true) {
				stmt2 = con.prepareStatement(SQL2);
				stmt2.setInt(1, no);
				stmt2.executeUpdate();
			}
		} catch (SQLException e) {
			log.debug("Error Source : BoardDeleter.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql1 : " + SQL1);
			log.debug("sql2 : " + SQL2);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt1 != null) {
				try {
					stmt1.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt2 != null) {
				try {
					stmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			String path = req.getContextPath();
			keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
			resp.sendRedirect(path + "/board/list.jsp?curPage=" + curPage + "&amp;keyword=" + keyword);
		}
	}
}
</pre>

<h3>Delete (deletes all descendants)</h3>

<table class="table-in-article">
<tr>
	<th style="width: 100px;">no</th>
	<th style="width: 100px;">parent</th>
	<th style="width: 100px;">family</th>
	<th>title</th>
</tr>
<tr>
	<td>85</td>
	<td>0</td>
	<td>85</td>
	<td>85 posts</td>
</tr>
<tr>
	<td>86</td>
	<td>85</td>
	<td>85</td>
	<td>&nbsp;&nbsp;&#8627; First reply in 85 posts</td>
</tr>
<tr>
	<td>87</td>
	<td>86</td>
	<td>85</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&#8627; First reply in 86 posts</td>
</tr>
<tr>
	<td>88</td>
	<td>87</td>
	<td>85</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8627; First reply in 87 posts</td>
</tr>
</table>

<ol>
	<li>Add the no of the posts to be deleted to the deletion list.</li>
 	<li>Fetch one by one from the delete list and find posts whose parent equals to the fetched value and add them to the delete list.</li>
	<li>Delete all posts stored in the delete list</li>
</ol>

<em class="filename"> RecursiveDeleter.java (perform the delete algorithm)</em>
<pre class="prettyprint">
public class RecursiveDeleter {
	String sql1 = "SELECT no FROM board WHERE parent = ?";
	String sql2 = "DELETE FROM board WHERE no = ?";
	
	Connection con;
	
	Vector&lt;Integer&gt; v = new Vector&lt;Integer&gt;();//delete list
	int idx = 1; //To recursively call the next to the first one added to the list
	
	public RecursiveDeleter(Connection con) {
		this.con = con;
	}
	
	public void addDeleteList(int no) {
		v.addElement(new Integer(no));
	}
	
	public void getDeleteList(int no) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = con.prepareStatement(sql1);
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			while (rs.next()) {
				int target = rs.getInt(1);
				v.addElement(new Integer(target));
			}
			if(idx &lt; v.size()) {
				Integer value = (Integer) v.elementAt(idx++);
				getDeleteList(value.intValue());
			}
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
		}
	}
	 
	public void delete() {
		PreparedStatement stmt = null;
		
		try {
			stmt = con.prepareStatement(sql2);
			for(int i = 0; i &lt; v.size(); i++) {
				Integer value = (Integer) v.elementAt(i);
				stmt.setInt(1, value.intValue());
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
		} finally {
			v.removeAllElements();
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
	}
}
</pre>

<p>
You should call the method in the following order.
</p>

<ol>
	<li>addDeleteList(no);</li>
	<li>getDeleteList(no);</li>
	<li>delete();</li>
</ol>

<p>
If you want to delete 86, add 86 to the delete list using the addDeleteList() method and then call the getDeleteList() method. 
The getDeleteList() method retrieves 86 from the delete list and adds 87, which has 86 as the parent, to the delete list. 
Next, call yourself again, retrieves 87 from the delete list, and add 88 to the delete list, which has 87 as the parent. 
Calling yourself again, retrieves 88 from the delete list and find the posts, which has 88 as the parent. 
However, since there is no post that has 88 as its parent, it completes the delete list. 
Delete all the posts in the delete list by calling the delete() method:
</p>

<p>
A method that calls itself in a method is called a recursive method.
When calling a recursive method, you must retrieve the values in turn from the delete list.
Also, when the delete list is complete, the recursive method should no longer be called.
To do this, we used the idx as index.
You need to know how the idx value changes to fully understand the getDeleteList() method.
</p>

<em class="filename">BoardDeleter.java - (Remove all descendant posts)</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;
import java.util.Vector;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardDeleter extends HttpServlet {
	
	private OracleConnectionManager dbmgr = null;
	
	class RecursiveDeleter {
		String sql1 = "SELECT no FROM board WHERE parent = ?";
		String sql2 = "DELETE FROM board WHERE no = ?";
		
		Connection con;
		
		Vector&lt;Integer&gt; v = new Vector&lt;Integer&gt;();
		int idx = 1; //To recursively call the next to the first one added to the list
		
		public RecursiveDeleter(Connection con) {
			this.con = con;
		}

		public void addDeleteList(int no) {
			v.addElement(new Integer(no));
		}
	
		public void getDeleteList(int no) {
			Log log = new Log();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				stmt = con.prepareStatement(sql1);
				stmt.setInt(1, no);
				rs = stmt.executeQuery();
				while (rs.next()) {
					int target = rs.getInt(1);
					v.addElement(new Integer(target));
				}
				if(idx &lt; v.size()) {
					Integer value = (Integer) v.elementAt(idx++);
					getDeleteList(value.intValue());
				}
			} catch (SQLException e) {
				log.debug("Error Source : BoardDeleter.getDeleteList() : SQLException");
				log.debug("SQLState : " + e.getSQLState());
				log.debug("Message : " + e.getMessage());
				log.debug("Oracle Error Code : " + e.getErrorCode());
				log.debug("sql : " + sql1);
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
				log.close();
			}
		}
		 
		public void delete() {
			Log log = new Log();
			
			PreparedStatement stmt = null;
			
			try {
				stmt = con.prepareStatement(sql2);
				for(int i = 0; i &lt; v.size(); i++) {
					Integer value = (Integer) v.elementAt(i);
					stmt.setInt(1, value.intValue());
					stmt.executeUpdate();
				}
			} catch (SQLException e) {
				log.debug("Error Source : BoardDeleter.delete() : SQLException");
				log.debug("SQLState : " + e.getSQLState());
				log.debug("Message : " + e.getMessage());
				log.debug("Oracle Error Code : " + e.getErrorCode());
				log.debug("sql : " + sql2);
			} finally {
				v.removeAllElements();
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
		}
	}
	
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
		
		int no = Integer.parseInt(req.getParameter("no"));
		String curPage = req.getParameter("curPage");
		String keyword = req.getParameter("keyword");
		
		Connection con = dbmgr.getConnection();
		RecursiveDeleter deleter = new RecursiveDeleter(con);
		deleter.addDeleteList(no);
		deleter.getDeleteList(no);
		deleter.delete();
		
		String path = req.getContextPath();
		keyword = URLEncoder.encode(keyword, "UTF-8");
		resp.sendRedirect(path + "/board/list.jsp?curPage=" + curPage + "&amp;keyword=" + keyword);
	}
}
</pre>

<h2>Hierarchical bulletin board using Oracle Hierarchical Query</h2>

<h3>Oracle Hierarchical Query</h3>

<p>
We will practice Oracle tiered queries with the scott account emp table.
The mgr column of the emp table stores the rank of the supervisor.
</p>

<pre class="prettyprint">
SELECT job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR empno = mgr;
</pre>

<pre class="prettyprint">
JOB	       EMPNO ENAME	       MGR
--------- ---------- ---------- ----------
PRESIDENT	7839 KING
MANAGER 	7566 JONES	      7839
ANALYST 	7902 FORD	      7566
CLERK		7369 SMITH	      7902
MANAGER 	7698 BLAKE	      7839
SALESMAN	7499 ALLEN	      7698
SALESMAN	7521 WARD	      7698
SALESMAN	7654 MARTIN	      7698
SALESMAN	7844 TURNER	      7698
CLERK		7900 JAMES	      7698
MANAGER 	7782 CLARK	      7839
CLERK		7934 MILLER	      7782
</pre>

<p>
The start with clause is followed by a condition to find the highest hierarchy.
The connect by clause connects parent and child nodes.
</p>

<p>
To easily understand hierarchical relationships, let's use a level virtual column that can be used in hierarchical queries.
</p>

<pre class="prettyprint">
SELECT level, job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr;
</pre>

<pre class="prettyprint">
     LEVEL JOB		  EMPNO ENAME		  MGR
---------- --------- ---------- ---------- ----------
	 1 PRESIDENT	   7839 KING
	 2 MANAGER	   7566 JONES		 7839
	 3 ANALYST	   7902 FORD		 7566
	 4 CLERK	   7369 SMITH		 7902
	 2 MANAGER	   7698 BLAKE		 7839
	 3 SALESMAN	   7499 ALLEN		 7698
	 3 SALESMAN	   7521 WARD		 7698
	 3 SALESMAN	   7654 MARTIN		 7698
	 3 SALESMAN	   7844 TURNER		 7698
	 3 CLERK	   7900 JAMES		 7698
	 2 MANAGER	   7782 CLARK		 7839
	 3 CLERK	   7934 MILLER		 7782
</pre>

<p>
Let's indent using level.
</p>

<pre class="prettyprint">
col job format a20;

SELECT LPAD(' ', 2*(LEVEL-1)) || job job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr;
</pre>

<pre class="prettyprint">
JOB			  EMPNO ENAME		  MGR
-------------------- ---------- ---------- ----------
PRESIDENT		   7839 KING
  MANAGER		   7566 JONES		 7839
    ANALYST		   7902 FORD		 7566
      CLERK		   7369 SMITH		 7902
  MANAGER		   7698 BLAKE		 7839
    SALESMAN		   7499 ALLEN		 7698
    SALESMAN		   7521 WARD		 7698
    SALESMAN		   7654 MARTIN		 7698
    SALESMAN		   7844 TURNER		 7698
    CLERK		   7900 JAMES		 7698
  MANAGER		   7782 CLARK		 7839
    CLERK		   7934 MILLER		 7782
</pre>

<p>
If you add ORDER BY empno DESC to sort the above query, the hierarchical relationship is broken.
To sort without breaking the hierarchical relationship, you must use ORDER SIBLINGS BY empno DESC.
</p>

<pre class="prettyprint">
SELECT LPAD(' ', 2*(LEVEL-1)) || job job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr 
ORDER SIBLINGS BY empno DESC;
</pre>

<p>
Notice that the highlighted part of the result is sorted in empno descending order.
</p>

<pre class="prettyprint">
JOB			  EMPNO ENAME		  MGR
-------------------- ---------- ---------- ----------
PRESIDENT		   7839 KING
  MANAGER		   7782 CLARK		 7839
    CLERK		   7934 MILLER		 7782
  MANAGER		   7698 BLAKE		 7839
    CLERK		   <strong>7900</strong> JAMES		 7698
    SALESMAN		   <strong>7844</strong> TURNER		 7698
    SALESMAN		   <strong>7654</strong> MARTIN		 7698
    SALESMAN		   <strong>7521</strong> WARD		 7698
    SALESMAN		   <strong>7499</strong> ALLEN		 7698
  MANAGER		   7566 JONES		 7839
    ANALYST		   7902 FORD		 7566
      CLERK		   7369 SMITH		 7902
</pre>

<p>
The following query extracts only the top 10 records.
</p>

<pre class="prettyprint">
SELECT job, empno, ename,mgr FROM
(SELECT ROWNUM R, A.* 
FROM 
(SELECT LPAD(' ', 2*(LEVEL-1)) || job job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr 
ORDER SIBLINGS BY empno DESC) A) 
WHERE R BETWEEN 1 AND 10;
</pre>

<pre class="prettyprint">
JOB			  EMPNO ENAME		  MGR
-------------------- ---------- ---------- ----------
PRESIDENT		   7839 KING
  MANAGER		   7782 CLARK		 7839
    CLERK		   7934 MILLER		 7782
  MANAGER		   7698 BLAKE		 7839
    CLERK		   7900 JAMES		 7698
    SALESMAN		   7844 TURNER		 7698
    SALESMAN		   7654 MARTIN		 7698
    SALESMAN		   7521 WARD		 7698
    SALESMAN		   7499 ALLEN		 7698
  MANAGER		   7566 JONES		 7839
</pre>

<p>
If you implement a hierarchical bulletin board using Oracle hierarchical queries, you only need to add the parent column to store the unique number of the parent post.
</p>

<em class="filename">Query hints for Oracle hierarchical bulletin boards</em>
<pre class="prettyprint">
SELECT no, indent, parent, title, wdate FROM 
(SELECT ROWNUM R, A.* 
FROM 
(SELECT no, level as indent, parent, title, wdate FROM board 
START WITH parent = 0 
CONNECT BY PRIOR no = parent 
ORDER SIBLINGS BY no DESC) A) 
WHERE R BETWEEN 1 AND 10
</pre>

<h3>list.jsp using Oracle hierarchical bulletin boards</h3>

<p>
Change the query that retrieves list data from list.jsp as follows:
</p>

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT no, indent, parent, title, wdate FROM " +
	"(SELECT ROWNUM R, A.* " +
	"FROM " +
	"(SELECT no, level as indent, parent, title, wdate FROM board " +
	"START WITH parent = 0 " +
	"CONNECT BY PRIOR no = parent " +
	"ORDER SIBLINGS BY no DESC) A) " +
	"WHERE R BETWEEN ? AND ?";

} else {
	sql = "SELECT no, indent, parent, title, wdate FROM " +
	"(SELECT ROWNUM R, A.* " +
	"FROM " +
	"(SELECT no, level as indent, parent, title, wdate FROM board " +
	"WHERE title LIKE '%" + keyword + "%' OR content LIKE '%" + keyword + "%' " +
	"START WITH parent = 0 " +
	"CONNECT BY PRIOR no = parent " +
	"ORDER SIBLINGS BY no DESC) A) " +
	"WHERE R BETWEEN ? AND ?";
}
</pre>

<p>
Then modify the following in list.jsp:
</p>

<pre class="prettyprint">
if(indent != <strong>1</strong>) {
	out.println("&#8627;");
}
</pre>

<p>
If you test, the bulletin board works normally.
However, there is still a part to be removed for performance.
</p>

<h3>Hierarchical bulletin board using hierarchical query: ALTER TABLE board</h3>

<pre class="prettyprint">
ALTER TABLE board DROP COLUMN family
/
ALTER TABLE board DROP COLUMN depth
/
ALTER TABLE board DROP COLUMN indent
/
</pre>

<h3>Hierarchical bulletin board using hierarchical query: New Post</h3>

<p>
If there is no parent, the parent column value is set to 0,
Otherwise, the parent column value is set to the no column value of the parent post.
</p>

<p>
Edit the BoardWriter's new post registration query as shown below.
</p>

<pre class="prettyprint">
String sql = "INSERT INTO board (no, title, content, wdate, parent) "
	+ "VALUES (board_no_seq.nextval, ?, ?, sysdate, 0)";
</pre>

<h3>Hierarchical bulletin board using hierarchical query: Reply</h3>

<em class="filename">/board/reply_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;%! static final String LINE_SEPARATOR = System.getProperty("line.separator"); %&gt; 
&lt;%
request.setCharacterEncoding("UTF-8");
Log log = new Log();

int parent = 0;

String title = null;
String content = null;
Date wdate = null;

int no = Integer.parseInt(request.getParameter("no"));
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String sql = "SELECT no, title, content, wdate " +
        "FROM board " +
        "WHERE no = ?";

try {
	con = dbmgr.getConnection();
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, no);
	rs = stmt.executeQuery();

	rs.next();
	no = rs.getInt("no");
	title = rs.getString("title");
	content = rs.getString("content");

	//add &gt; for each line of the parent post.
	content = content.replaceAll(LINE_SEPARATOR, LINE_SEPARATOR + "&gt;");
	content = LINE_SEPARATOR + LINE_SEPARATOR +"&gt;" + content;
	wdate = rs.getDate("wdate");
} catch (SQLException e) {
	log.debug("Error Source : board/modify_form.jsp : SQLException");
	log.debug("SQLState : " + e.getSQLState());
	log.debug("Message : " + e.getMessage());
	log.debug("Oracle Error Code : " + e.getErrorCode());
	log.debug("sql : " + sql );
} finally {
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {}
	}
	if (stmt != null) {
		try {
			stmt.close();
		} catch (SQLException e) {}
	}
	if (con != null) {
		try {
			con.close();
		} catch (SQLException e) {}
	}
}
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;Reply&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Reply&lt;/h1&gt;
&lt;form action="../servlet/BoardReplier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;" /&gt;
&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;" /&gt;
Title: &lt;input type="text" name="title" size="45" value="&lt;%=title %&gt;" /&gt;&lt;br /&gt;
&lt;textarea name="content" rows="10" cols="60"&gt;&lt;%=content %&gt;&lt;/textarea&gt;&lt;br /&gt;
&lt;input type="submit" value="Submit" /&gt;
&lt;input type="reset" value="Reset" /&gt;&lt;br /&gt;
&lt;/form&gt;
&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;View&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardReplier.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardReplier extends HttpServlet {
  
	OracleConnectionManager dbmgr = null;
	
	//Queries for reply
	String sql = "INSERT INTO board " + 
			"(no, parent, title, content, wdate) " + 
			"VALUES (board_no_seq.nextval, ?, ?, ?, sysdate)";
	
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
		
		int parent = Integer.parseInt(req.getParameter("no"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		String curPage = req.getParameter("curPage");
		String keyword = req.getParameter("keyword");
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = dbmgr.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, parent);
			stmt.setString(2, title);
			stmt.setString(3, content);
			stmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source:BoardReplier.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
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
			keyword = java.net.URLEncoder.encode(keyword,"UTF-8");
			resp.sendRedirect(path + "/board/list.jsp?curPage=" + curPage + "&amp;keyword=" + keyword);
		}
	}
}
</pre>

<h3>Hierarchical bulletin board using hierarchical query: Delete</h3>

<p>
We will not be able to delete postings with reply.
</p>

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
	
	private OracleConnectionManager dbmgr;
	
	private static final String SQL1 = "SELECT count(*) FROM board WHERE parent = ?";
	private static final String SQL2 = "DELETE FROM board WHERE no = ?";
	
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager) sc.getAttribute("dbmgr");
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
		String curPage = req.getParameter("curPage");
		String keyword = req.getParameter("keyword");
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		ResultSet rs = null;
		
		boolean check = false;
		
		try {
			stmt1 = con.prepareStatement(SQL1);
			stmt1.setInt(1, no);
			rs = stmt1.executeQuery();
			rs.next();
			int num = rs.getInt(1);
			if (num == 0) {
				check = true;
			}
			if (check == true) {
				stmt2 = con.prepareStatement(SQL2);
				stmt2.setInt(1, no);
				stmt2.executeUpdate();
			}
		} catch (SQLException e) {
			log.debug("Error Source : BoardDeleter.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql1 : " + SQL1);
			log.debug("sql2 : " + SQL2);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt1 != null) {
				try {
					stmt1.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt2 != null) {
				try {
					stmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			String path = req.getContextPath();
			keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
			resp.sendRedirect(path + "/board/list.jsp?curPage=" + curPage + "&amp;keyword=" + keyword);
		}
	}
}
</pre>
</article>