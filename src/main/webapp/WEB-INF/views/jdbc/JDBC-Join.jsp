<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2017.2.14</div>

<h1>JDBC - Join</h1>

<p>
Since there is only one table for business card management, we practice the example of joining EMP and DEPT.
Our goal is to execute the following SQL:
</p>

<pre>
SELECT ENAME, JOB, D.DEPTNO, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND D.LOC = 'DALLAS'
</pre>

<p>
Refer to the JDBC programming procedure below and complete the main method of the JoinTable.java file.
</p>

<ol>
	<li>Loading a JDBC Driver</li>
	<li>Getting a Connection</li>
	<li>Execute SQL</li>
	<li>[If the SQL statement is a select statement, use the returned ResultSet to process data.]</li>
	<li>Returning Resources</li>
</ol>

<em class="filename">JoinTable.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JoinTable {
	static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASS = "tiger";
	
	public static void main(String[] args) {
	
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT ENAME,JOB,D.DEPTNO,DNAME " +
				"FROM EMP E, DEPT D " +
				"WHERE E.DEPTNO = D.DEPTNO " +
				"AND D.LOC = 'DALLAS'";
		
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				String ename = rs.getString("ename");
				String job = rs.getString("job");
				String deptno = rs.getString("deptno");
				String dname = rs.getString("dname");
				System.out.println(ename + " " + job + " " + deptno + " " + dname);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(sql);
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
</pre>
</article>