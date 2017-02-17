<article>
<div class="last-modified">Last Modified 2014.5.21</div>

<h1>PreparedStatement</h1>

PreparedStatement는  지금까지 사용한 Statement인터페이스보다 편리하고 효과적이다.<br />
PreparedStatement인터페이스는 Statement인터페이스를 상속한다.<br />
때문에 지금까지 예제에서 나왔던 메소드 몇몇은 이번 예제에서도 그대로 쓰인다.<br />
<br />
Statement가 DBMS에 전달하는 SQL문은 단순한 문자열이다.<br />
DBMS는 이 문자열을 DBMS가 이해할 수 있도록 컴파일하고 실행한다.<br />
반면 PreparedStatement는 컴파일된 SQL문을 DBMS에 전달하여 성능을 향상시킨다.<br />
성능을 향상시키는 것 뿐 아니라 편리한 점도 있다.<br />
SQL문에  <span class="emphasis">?</span>을 넣을 수 있고, <span class="emphasis">?</span>부분의 값을 설정할 수 있다.<br />
그러므로써 동일한 SQL문을 <span class="emphasis">?</span>에 값만 바꾸어 실행할 수 있다.<br />
<br />
UsingPrepareStatement.java 의 메인 메소드에 아래 JDBC 프로그래밍 방법을 참조하여 작성한다.<br />
우리의 목표는<br />
<em>UPDATE NAMECARD SET COMPANY=? WHERE NO=?</em><br />
을 실행하는 것이다.<br />
  
<ol>
	<li>JDBC 드라이버 로딩</li>
	<li>Connection 맺기</li>
	<li>SQL 실행</li>
	<li>[SQL문이 select문이었다면 ResultSet을 이용한 처리]</li>
	<li>자원 반환</li>
</ol>

<em class="filename">UsingPrepareStatement.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
<strong>import java.sql.PreparedStatement;</strong>
import java.sql.SQLException;

public class UsingPreparedStatement {
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
		PreparedStatement pstmt = null;
		String sql = "UPDATE NAMECARD SET COMPANY=<strong>?</strong> WHERE NO=<strong>?</strong>";
		try {
			// 커넥션 맺기
			con = DriverManager.getConnection(URL, USER, PASS);
			// SQL 실행
			<strong>pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "율도국");
			pstmt.setInt(2, 1);
			pstmt.executeUpdate();</strong>
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(sql);
		} finally {
			try {
				pstmt.close();
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

Statement을 사용할 때와 다른 부분은 아래와 같다.<br />
<em>pstmt = con.prepareStatement(sql);</em><br />
Statement을 사용할 때와 달리 PreparedStatement을 얻기 위해 사용하는 
prepareStatement 메소드의 인자값으로 SQL문을 전달한다.<br />
<em>pstmt.executeUpdate();</em><br />
Statement와 달리 executeUpdate() 메소드에 SQL문을 인자로 전달하지 않는다.<br />
<br />
SQL문에 ? 이 있다면 PrepareStatement의 setXXX 메소드를 이용해서 설정해야 한다.<br />
(PreparedStatement을 쓴다고 SQL문에 반드시 ?가 있어야 되는 것은 아니다.)<br />
XXX 부분은 해당 컬럼의 데이터 형에 매핑되는 자바 데이터 형으로 결정한다.<br />
setXXX 메소드의 첫번째 파라미터는 ? 가 위치하고 있는 순서다.<br />
setXXX 메소드의 두번째 파라미터는 ? 를 대체할 값이다.<br />
<br />
필자가 생각하기에 PreparedStatement대신에 Statement을 꼭 써야 하는 경우는 거의 없다고 생각한다.<br />
때문에 이제부터는 PreparedStatement만을 사용하는 것이 좋겠다.<br />
지금까지 Statement사용한 예제를 모두 PreparedStatement로 수정해 보자.<br />
</article>