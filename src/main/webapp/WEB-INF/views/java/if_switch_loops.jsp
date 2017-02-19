<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<article>
<h2>if, switch, loops</h2>

<h3>if</h3>

<pre class="prettyprint">
int year = 2001;
if (year &gt;= 2001 &amp;&amp; age &lt;= 2100) {
  System.out.println("21st century");
}
</pre>

<pre class="screen">
21st century
</pre>	

<pre class="prettyprint">
int age = 65;
if (age &lt; 6 &amp;&amp; age &gt;= 65) {
  System.out.println("Free");
} else {
  System.out.println("Not Free");
}
</pre>

<pre class="screen">
Free
</pre>

<pre class="prettyprint">
int age = 65;
if (age &gt;= 65) {
  System.out.println("Free");
} else if (age &lt; 6) {
  System.out.println("Free");
} else {
  System.out.println("NOT Free");
}
</pre>
	
<pre class="screen">
Free
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
Breaks out of the inner loop
</dd>
<dt>continue;</dt>
<dd>
Skips rest of loop's body and makes program flow goto the boolean expression that controls the loop. 
</dd>
<dt>return;</dt>
<dd>
Terminates the method and makes program flow goto the line which call the method.
A <strong>return;</strong> is only available at void method.<br />
</dd>
<dt>
for (<strong>int i = 0</strong>; i &lt; 10; i++) { }
</dt>
<dd>
In Java, you can declare the variable in the initial expression as the above.<br />
Variable i is valid in {} of for statement.<br />
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
		++e and e++ are extremely differ in the operator precedence. 
		*/
		 
		System.out.println("e++ = " + e++); //e++ = 5
		System.out.println("++e = " + ++e); //++e = 7

		System.out.println("e-- = " + e--); //e-- = 7
		System.out.println("--e = " + --e); //--e = 5
		
		e++; //e++ equals ++e when it show alone.
		System.out.println("e = " + e); //e = 6
		++e;
		System.out.println("e = " + e); //e = 7
	}
}
</pre>

Add the below to the source.

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

Add the below to the source.

<pre class="prettyprint">
int yr = 2000;
String msg = null;

msg = yr &gt;= 2001 &amp;&amp; yr &lt;= 2100 &amp;&amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
System.out.println(msg);

msg = null;
msg = yr &gt;= 2001 &amp; yr &lt;= 2100 &amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
System.out.println(msg);
</pre>

<pre class="screen">
2000 is not 21C
Exception in thread "main" java.lang.NullPointerException
	at Test.main(Test.java:46)
</pre>

<em>&amp; msg.length() &gt; 0</em> occurs an exception.<br />
Unlike &amp;&amp;, &amp; checks a following boolean expression, 
even if the previous boolean expression is false.<br /> 
Comments lines that occur exception.

<pre class="prettyprint">
//msg = yr &gt;= 2001 &amp; yr &lt;= 2100 &amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
//System.out.println(msg);
</pre>

Add the below to the source.

<pre class="prettyprint">
class User {
	boolean signIn = true;
	String id = "Batman";
	String authority = "ADMIN";
}

User user = new User();

//Check whether login user's id is the "Superman" or authority is an "ADMIN".
if ((user.signIn &amp;&amp; user.id.equals("Superman")) || (user.signIn &amp;&amp; user.authority.equals("ADMIN"))) {
	System.out.println("1st TEST: Superman OR ADMIN");
}

user.authority = "USER";
if ((user.signIn &amp;&amp; user.id.equals("Superman")) || (user.signIn &amp;&amp; user.authority.equals("ADMIN"))) {
	System.out.println("2nd TEST: Superman OR ADMIN");
}
</pre>

<pre class="screen">
1st TEST: Superman OR ADMIN
</pre>

<span id="refer">References</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javase/tutorial/java/nutsandbolts/switch.html">Using Strings in switch Statements - http://docs.oracle.com/javase/tutorial/java/nutsandbolts/switch.html</a></li>
</ul>
</article>