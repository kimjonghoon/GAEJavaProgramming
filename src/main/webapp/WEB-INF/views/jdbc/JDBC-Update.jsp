<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>
<div class="last-modified">Last Modified 2017.2.14</div>

<h1>JDBC - Update</h1>

<p>
In this tutorial, you will learn how to use JDBC to execute an UPDATE statement.
Refer to the JDBC programming order to complete the main method of UpdateNamecard.java.
Our goal is to execute the following SQL statement.
</p>

<pre>
UPDATE NAMECARD SET EMAIL ='alison@ggmail.org' WHERE NO = 1
</pre>


<ol>
	<li>Loading a JDBC Driver</li>
	<li>Getting a Connection</li>
	<li>Execute SQL</li>
	<li>[If the SQL statement is a select statement, use a ResultSet to process the data.]</li>
	<li>Returning Resources</li>
</ol>

<em class="filename">NamecardUpdate.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class NamecardUpdate {
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
		Statement stmt = null;
		
		String sql = "UPDATE NAMECARD " +
			"SET EMAIL ='alison@ggmail.org' " +
			"WHERE NO = 1";
		
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(sql);
		} finally {
			try {
				stmt.close();
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