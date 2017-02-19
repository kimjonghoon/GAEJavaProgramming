<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<article>
<div class="last-modified">Last Modified 2016.4.7</div>

<h2>if문, switch문, 반복문</h2>

<h3>if문</h3>

<pre class="prettyprint">
int year = 2001;
if (year &gt;= 2001 &amp;&amp; age &lt;= 2100) {
  System.out.println("21세기");
}
</pre>

<pre class="screen">
21세기
</pre>	

<pre class="prettyprint">
int age = 65;
if (age &lt; 6 &amp;&amp; age &gt;= 65) {
  System.out.println("무료");
} else {
  System.out.println("유료");
}
</pre>

<pre class="screen">
무료
</pre>

<pre class="prettyprint">
int age = 65;
if (age &gt;= 65) {
  System.out.println("무료");
} else if (age &lt; 6) {
  System.out.println("무료");
} else {
  System.out.println("유료");
}
</pre>
	
<pre class="screen">
무료
</pre>


<h3>switch</h3>

<pre class="prettyprint">
int channel = 7;
swicth (channel) {
	case 5:
	System.out.println("SBS");
	break;
	case 7: case 9:
	System.out.println("KBS");
	break;
	case 11:
	System.out.println("MBC");
	break;  	
	default:
	System.out.println("Cabel TV");
}
</pre>

<pre class="screen">
KBS
</pre>

<h3>for</h3>

<pre class="prettyprint">
int sum = 0;
for (int i = 1; i &lt;= 10; i++) {
  sum += i;
}
System.out.println(sum);
</pre>

<pre class="screen">
55
</pre>

<h3>while</h3>
<pre class="prettyprint">
int sum = 0;
int i = 1;
while (i &lt;= 10) {
  sum += i;
  i++;
}
System.out.println(sum);
</pre>

<pre class="screen">
55
</pre>

<h3>do ~ while</h3>

<pre class="prettyprint">
int sum = 0;
int i = 1;
do {
  sum += i;
  i++;
} while (i &lt;= 10);
System.out.println(sum);
</pre>

<pre class="screen">
55
</pre>


<dl class="note">
<dt>break;</dt>
<dd>
자신을 감싸고 있는 반복문을 빠져나온다.<br />
</dd>
<dt>continue;</dt>
<dd>
자신을 감싸고 있는 반복문의 조건식으로 분기한다.<br /> 
</dd>
<dt>return;</dt>
<dd>
메소드를 종료하고 프로그램의 흐름을 메소드를 호출한 곳으로 되돌린다.<br />
<strong>return;</strong> 문은 void 메소드에서만 사용할 수 있다.<br />
</dd>
<dt>for (int i = 0; i &lt; 10; i++) </dt>
<dd>
자바에서는 for 문의 초기식에 변수를 선언할 수 있다.<br />
초기식에서 선언된 변수는 for문의 {} 안에서만 유효하다.<br />
</dd>
</dl>

<em class="filename">OperatorsTest.java</em>
<pre class="prettyprint">
public class OperatorsTest {
	public static void main(String[] args) {
		int a = 1;
		int b = 2;
		int c = 3;
		int d = 4;
		int e = 5;

		System.out.println("a = " + a); //a = 1
		System.out.println("b = " + b); //b = 2
		System.out.println("c = " + c); //c = 3
		System.out.println("d = " + d); //d = 4
		System.out.println("e = " + e); //e = 5

		System.out.println("a + b = " + (a + b)); //a + b = 3
		System.out.println("b - c = " + (b - c)); //b - c = -1
		System.out.println("c * d = " + (c * d)); //c * d = 12
		System.out.println("e / b = " + (e / b)); //e / b = 2
		System.out.println("e % b = " + (e % b)); //e % b = 1
		
		/*
		++ 또는 --가 피연산자가 앞에 붙을때와 뒤에 붙을 때 
		연산자 우선순의는 극과 극으로 차이가 난다. 
		*/
		 
		System.out.println("e++ = " + e++); //e++ = 5
		System.out.println("++e = " + ++e); //++e = 7

		System.out.println("e-- = " + e--); //e-- = 7
		System.out.println("--e = " + --e); //--e = 5
		
		e++; //단독으로 사용하면 ++e와 같다.
		System.out.println("e = " + e); //e = 6
		++e;
		System.out.println("e = " + e); //e = 7
	}
}
</pre>


예제에 다음 부분을 추가하고 테스트한다.

<pre class="prettyprint">
System.out.println("a &gt; b " + (a &gt; b));
System.out.println("b &gt;= a " + (b &gt;= a));
System.out.println("c &lt; d " + (c &lt; d));
System.out.println("d &lt;= a " + (d &lt;= a));
System.out.println("a == b " + (a == b));
System.out.println("a != b " + (a != b));
</pre>

<pre class="screen">
a &gt; b false
b &gt;= a true
c &lt; d true
d &lt;= a false
a == b false
a != b true
</pre>

예제에 다음 코드를 추가하고 테스트한다.

<pre class="prettyprint">
int yr = 2000;
String msg = null;

msg = yr &gt;= 2001 &amp;&amp; yr &lt;= 2100 &amp;&amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
System.out.println(msg);

msg = null;
msg = yr &gt;= 2001 &amp; yr &lt;= 2100 &amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";//익셉션 발생!
System.out.println(msg);
</pre>

<pre class="screen">
2000 is not 21C
Exception in thread "main" java.lang.NullPointerException
	at Test.main(Test.java:46)
</pre>

<em>&amp; msg.length() &gt; 0</em>는 예외를 발생시킨다.<br />
&amp;는 &amp;&amp;와 달리 먼저 검사한 부울 식이 false라도 이어지는 부울 식을 검사한다.<br />
아래와 같이 주석처리한다.

<pre class="prettyprint">
//msg = yr &gt;= 2001 &amp; yr &lt;= 2100 &amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
//System.out.println(msg);
</pre>

예제에 다음을 추가하고 테스트한다.

<pre class="prettyprint">
class User {
	boolean signIn = true;
	String id = "Batman";
	String authority = "ADMIN";
}

User user = new User();

//로그인한 유저의 아이디가 Superman 이거나 권한이 ADMIN인지 검사
if ((user.signIn &amp;&amp; user.id.equals("Superman")) || (user.signIn &amp;&amp; user.authority.equals("ADMIN"))) {
	System.out.println("첫번째 테스트: Superman OR ADMIN");
}

user.authority = "USER";
if ((user.signIn &amp;&amp; user.id.equals("Superman")) || (user.signIn &amp;&amp; user.authority.equals("ADMIN"))) {
	System.out.println("두번째 테스트: Superman OR ADMIN");
}
</pre>

<pre class="screen">
첫번째 테스트: Superman OR ADMIN
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javase/tutorial/java/nutsandbolts/switch.html">Using Strings in switch Statements - http://docs.oracle.com/javase/tutorial/java/nutsandbolts/switch.html</a></li>
</ul>
</article>