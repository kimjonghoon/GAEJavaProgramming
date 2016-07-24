<div id="last-modified">Last Modified : 2014.5.21</div>

<h1 class="heading1">SELECT</h1>

이번 장에서는 NAMECARD 테이블의 레코드를 SELECT 하는 JDBC 예제를 구현한다.<br />
아래 NamecardSelect.java 파일을 아래 JDBC 프로그래밍 순서를 참조하여 작성한다.<br />
우리의 목표는 다음 문장을 JDBC로 실행하는 것이다.<br />

<br />
SELECT NO,NAME,MOBILE,EMAIL,COMPANY<br /> 
FROM NAMECARD<br />
ORDER BY NO DESC<br />
<br />

<ol>
	<li>JDBC 드라이버 로딩</li>
	<li>Connection 맺기</li>
	<li>SQL 실행</li>
	<li>[SQL문이 select문이었다면 ResultSet을 이용한 실행결과 처리]</li>
	<li>자원 반환</li>
</ol>

<em class="filename">NamecardSelect.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class NamecardSelect {
	static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASS = "tiger";
	
	public static void main(String[] args) {
		// JDBC 드라이버 로딩
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT NO,NAME,MOBILE,EMAIL,COMPANY " +
			"FROM NAMECARD " +
			"ORDER BY NO DESC";

		try {
			// Connection 맺기
			con = DriverManager.getConnection(URL, USER, PASS);
			// SQL 실행
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String mobile = rs.getString("mobile");
				String email = rs.getString("email");
				String company = rs.getString("company");
				System.out.println(no + "|" + name + "|" + mobile + "|" + email + "|" + company);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(sql);
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}
}
</pre>

<dl class="note">
<dt>ResultSet 객체의 next()메소드</dt>
<dd>
반환된 ResultSet이 내장하고 있는 커서는 처음에는 첫번째 레코드의 이전을 가르키고 있다.<br />
이 커서를 한칸 움직이는 메소드가 ResultSet 의 next() 메소드이다.<br /> 
따라서 반복문에서 next() 메소드를 이용하면 테이블에 있는 모든 레코드를 가져올 수 있다.<br />
next() 메소드의 반환값은 이동한 커서의 위치에 레코드가 있으면 true, 없으면 false 를 반환한다. 
</dd>
<dt>ResultSet 객체의 getXXX() 메소드</dt>
<dd>
실제로 getXXX() 라는 이름의 메소드는 아니다.<br />
커서가 가르키고 있는 결과셋에서 첫번째 컬럼의 데이터 형이 NUMBER라면 XXX 부분을 자바의 데이터 형중 하나인 int으로 바꾸어 주고,
getInt(1)와 같이 인자값으로 컬럼의 인덱스를 주면  해당 컬럼의 값을 자바의 int형 값으로 얻을 수 있다.<br />
이때 인자값으로 인덱스가 아닌 컬럼명을 문자열로 주어도 된다.<br />
(우리의 예제는 그렇게 구현했다.)<br />
물론 성능상으론 인덱스를 주는 것이 빠르겠으나 컬럼명을 주는 것이 유지보수에 좋다.<br />
</dd>
</dl>