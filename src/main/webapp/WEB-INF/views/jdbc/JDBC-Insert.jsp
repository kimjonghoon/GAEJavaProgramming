<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>

<div class="last-modified">Last Modified 2017.2.14</div>

<h1>JDBC - Insert</h1>

<p>
This chapter demonstrates how to insert records into the NAMECARD table using JDBC.
Our goal is to execute the following insert statement.
</p>

<pre class="prettyprint">
INSERT INTO NAMECARD VALUES
(
  SEQ_NAMECARD_NO.NEXTVAL,
  'Alison',
  '011-0000-0000',
  'alison@ggmail.org',
  'Google Inc'
);
</pre>

<p>
Complete the main method of NamecardInsert.java by referring to the following JDBC programming order.
</p>

<ol>
	<li>Loading a JDBC Driver</li>
	<li>Getting a Connection</li>
	<li>Execute SQL</li>
	<li>[If the SQL statement is a select statement, use a ResultSet to process the data.]</li>
	<li>Returning Resources</li>
</ol>

<em class="filename">NamecardInsert.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class NamecardInsert {
	<strong>static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASS = "tiger";</strong>
	
	public static void main(String[] args) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		Connection con = null;
		Statement stmt = null;
		<strong>String sql = "INSERT INTO NAMECARD VALUES " +
			"(SEQ_NAMECARD_NO.NEXTVAL," +
			"'Alison'," +
			"'011-0000-0000'," +
			"'alison@ggmail.org'," +
			"'Google Inc')";</strong>

		try {
			con = DriverManager.getConnection(<strong>URL, USER, PASS</strong>);
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			<strong>System.out.println(sql);</strong>
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

<p>
Once you have run it, check in SQL*PLUS that the data has been inserted.
</p>

</article>