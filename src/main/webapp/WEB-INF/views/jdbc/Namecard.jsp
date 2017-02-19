<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2017.2.14</div>

<h1>Namecard</h1>

<p>
In this chapter, we will practice a namecard management program. 
Create Namecard.java and NamecardDao.java classes as shown below.
</p>

<em class="filename">Namecard.java</em>
<pre class="prettyprint">
package net.java_school.namecard;

public class Namecard {
	private int no;
	private String name;
	private String mobile;
	private String email;
	private String company;
	
	public Namecard() {}
	
	public Namecard(String name, String mobile, 
			String email, String company) {
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.company = company;
	}
	
	public Namecard(int no, String name, 
			String mobile, String email, String company) {
		this.no = no;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.company = company;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("[NO: ");
		sb.append(no);
		sb.append("] ");
		sb.append(name);
		sb.append(" ,Mobile: ");
		sb.append(mobile);
		sb.append(" ,Email: ");
		sb.append(email);
		sb.append(" ,Company: ");
		sb.append(company);
		
		return sb.toString();
	}
	
}
</pre>

<em class="filename">NamecardDao.java</em>
<pre class="prettyprint">
package net.java_school.namecard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NamecardDao {
	
	static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASSWORD = "tiger";
	
	public NamecardDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}
	
	private void close(ResultSet rs, PreparedStatement pstmt, Connection con) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
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
	
	public void insert(Namecard card) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO namecard VALUES (seq_namecard_no.nextval, ?, ?, ?, ?)";

		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, card.getName());
			pstmt.setString(2, card.getMobile());
			pstmt.setString(3, card.getEmail());
			pstmt.setString(4, card.getCompany());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(sql);
		} finally {
			close(null, pstmt, con);
		}
	}
	
	//Remove the Namecard	
	public void delete(int no) {
		//TODO
	}
	
	//Find the Namecard by no
	public Namecard selectOne(int no) {
		return null;
	}
	
	//Find the Namecard by keyword
	public ArrayList&lt;Namecard&gt; selectByKeyword(String keyword) {
		ArrayList&lt;Namecard&gt; matched = new ArrayList&lt;Namecard&gt;();
		//TODO		
		return matched;
	}
	
	//Get All Namecards
	public ArrayList&lt;Namecard&gt; selectAll() {
		ArrayList&lt;Namecard&gt; all = new ArrayList&lt;Namecard&gt;();
		//TODO		
		return all;
	}		
	
	//Modify the Namecard
	public void update(Namecard card) {
		//TODO
	}

}
</pre>

<p>
NamecardDao.java is not yet complete.
Complete the //TODO part of NamecardDao.java.
If you have implemented all the methods in NamecardDao.java, create the following class for testing.
</p>

<em class="filename">Test.java</em>
<pre class="prettyprint">
package net.java_school.namecard;

import java.util.ArrayList;

public class Test {

	public static void main(String[] args) {
		NamecardDao dao = new NamecardDao();
		//1.insert(Namecard) test: Adding a namecard
		Namecard alison = new Namecard("Alison","011-1111-1111", "alison@ggmail.org", "Salesman");
		dao.insert(alison); //After execution, check in SQL*PLUS.
		
/* 
		//2.selectAll() test: Get all namecards 
		ArrayList&lt;Namecard&gt; list = dao.selectAll();
		int size = list.size();
		for (int i = 0; i &lt; size; i++) {
			Namecard namecard = list.get(i);
			System.out.println(namecard);
		}
*/


/* 
		//3.selectByKeyword(String) test: Find a namecard by keyword
		ArrayList&lt;Namecard&gt; matched = dao.selectByKeyword("Alison");
		int length = matched.size();
		for (int i = 0; i &lt; length; i++) {
			Namecard namecard = matched.get(i);
			System.out.println(namecard);
		}
*/


/* 
		//4.selectOne(int) test : Find a namecard by no
		Namecard card = dao.selectOne(1);
		System.out.println(card);
*/


/* 
		5.delete(int) test : Remove a namecard
		dao.delete(1);
		ArrayList&lt;Namecard&gt; all = dao.selectAll();
		int cardNum = all.size();
		for (int i = 0; i &lt; cardNum; i++) {
			Namecard namecard = all.get(i);
			System.out.println(namecard);
		}
*/	

/*		//6. update(Namecard) test : Modify a namecard
		Namecard card = dao.selectOne(3);
		System.out.println(card);
		card.setEmail("alison@ggmail.org");
		card.setMobile("222-2222-2222");
		dao.update(card);
*/
	}

}
</pre>

<p>
Test the insert () method of NamecardDao.
Run SQL * PLUS to see if Alison's information is inserted.
When you run the JDBC program, SQL * PLUS must be terminated.
This is because different commit modes of JDBC programs and SQL * PLUS can cause bottlenecks.
When testing the main method of Test, test it one by one.
For example, when testing # 2, comments 1, 3, 4, 5, and 6 are commented out.
When you have finished testing, create a class that will act as the user interface and finish the program.
You need to change your mind when creating user interface classes.
If you use a database, you do not need to store card objects in an array or ArrayList.
</p>

<em class="filename">NamecardUi.java</em>
<pre class="prettyprint">
package net.java_school.namecard;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class NamecardUi {
	
	private NamecardDao dao = new NamecardDao();
	
	public NamecardUi() {}

	private String readCommandLine() throws IOException {
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String input = br.readLine();
		return input;
	}
	
	public void showMenu() {
		String menu = null;
		
		do {
			System.out.println("Please select menu");
			System.out.println("1.Namecard registration");
			System.out.println("2.List of Namecards");
			System.out.println("3.Delete Namecard");
			System.out.println("4.Edit Namecards");
			System.out.println("5.Search Namecard");
			System.out.println("q.Quit");
			
			try {
				menu = readCommandLine();	
			
				if (menu.equals("1")) {
					System.out.print("Please enter a name&gt;&gt;");
					String name = readCommandLine();
					System.out.print("Please enter a mobile&gt;&gt;");
					String mobile = readCommandLine();
					System.out.print("Please enter a email&gt;&gt;");
					String email = readCommandLine();
					System.out.print("Please enter a company&gt;&gt;");
					String company = readCommandLine();
					Namecard card = new Namecard(name, mobile, email, company);
					dao.insert(card);
				} else if (menu.equals("2")) {
					ArrayList&lt;Namecard&gt; all = dao.selectAll();
					for(int i = 0; i &lt; all.size(); i++) {
						System.out.println(all.get(i));
					}
				} else if (menu.equals("3")) {
					System.out.print("Please enter the name to delete&gt;&gt;");
					String name = readCommandLine();
					ArrayList&lt;Namecard&gt; matched = dao.selectByKeyword(name);
					if (matched.size() &gt; 0) {
						for (int i = 0; i &lt; matched.size(); i++) {
							System.out.println(matched.get(i));
						}
						System.out.print("Please enter the NO to delete&gt;&gt;");
						int id = Integer.parseInt(readCommandLine());
						dao.delete(id);
					}
				} else if (menu.equals("4")) {
					System.out.print("Enter the name of the namecard to edit&gt;&gt;");
					String name = readCommandLine();
					ArrayList&lt;Namecard&gt; matched = dao.selectByKeyword(name);
					if (matched.size() &gt; 0) {
						for (int i = 0; i &lt; matched.size(); i++) {
							System.out.println(matched.get(i));
						}
						System.out.print("Please enter the number of namecard to edit&gt;&gt;");
						int id = Integer.parseInt(readCommandLine());
						Namecard card = dao.selectOne(id);
						System.out.print("To edit a name, enter the name to change&gt;&gt;");
						name = readCommandLine();
						if (!name.equals("")) {
							card.setName(name);
						}
						System.out.print("To edit a mobile, enter the mobile to change&gt;&gt;");
						String mobile = readCommandLine();
						if (!mobile.equals("")) {
							card.setMobile(mobile);
						}	
						System.out.print("To edit an email, enter the email to change&gt;&gt;");
						String email = readCommandLine();
						if (!email.equals("")) {
							card.setEmail(email);
						}
						System.out.print("To edit a company, enter the company to change&gt;&gt;");
						String company = readCommandLine();
						if (!company.equals("")) {
							card.setCompany(company);
						}
						dao.update(card);
					}
				} else if (menu.equals("5")) {
					System.out.print("Please enter a name to search&gt;&gt;");
					String name = readCommandLine();
					ArrayList&lt;Namecard&gt; matched = dao.selectByKeyword(name);
					for(int i = 0; i &lt; matched.size(); i++) {
						System.out.println(matched.get(i));
					}
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} while(!menu.equals("q"));
	}
	
	public static void main(String[] args) {
		new NamecardUi().showMenu();
	}

}
</pre>
</article>