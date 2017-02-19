<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<article>
<div class="last-modified">Last Modified 2016.9.19</div>

<h1>Operators, switch, if, loops</h1>

<h2>Operators</h2>

<p>
An Operators is a symbol that the compiler to perform manipulations such as assign a value to a variable or change a value of a variable or compare two values.
</p>

<h3>Arithmetic Operators</h3>

<table class="table-in-article">
<tr>
	<th style="width: 10%;" class="table-in-article-th">Operator</th>
	<th style="width: 10%;" class="table-in-article-th">Example</th>
	<th class="table-in-article-th">Return value</th>
</tr>
<tr>
	<td class="table-in-article-td">+</td>
	<td class="table-in-article-td">5 + 2</td>
	<td class="table-in-article-td">7</td>
</tr>
<tr>
	<td class="table-in-article-td">-</td>
	<td class="table-in-article-td">5 - 2</td>
	<td class="table-in-article-td">3</td>
</tr>
<tr>
	<td class="table-in-article-td">*</td>
	<td class="table-in-article-td">5 * 2</td>
	<td class="table-in-article-td">10</td>
</tr>
<tr>
	<td class="table-in-article-td">/</td>
	<td class="table-in-article-td">5 / 2</td>
	<td class="table-in-article-td">2</td>
</tr>
<tr>
	<td class="table-in-article-td">%</td>
	<td class="table-in-article-td">5 % 2</td>
	<td class="table-in-article-td">1</td>
</tr>
<tr>
	<td rowspan="2" class="table-in-article-td">++</td>
	<td class="table-in-article-td">++5 + 2</td>
	<td class="table-in-article-td">
	8<br />
	(++ returns the value after incrementing.)
	</td>
</tr>
<tr>
	<td class="table-in-article-td">5++ + 2</td>
	<td class="table-in-article-td">
	7<br />
	(++ returns the value before incrementing.)
	</td>
</tr>
<tr>
	<td rowspan="2" class="table-in-article-td">--</td>
	<td class="table-in-article-td">--5 + 2</td>
	<td class="table-in-article-td">
	6<br />
	(-- returns the value after decrementing.)
	</td>
</tr>
<tr>
	<td class="table-in-article-td">5-- + 2</td>
	<td class="table-in-article-td">
	7<br />
	(-- returns the value before decrementing.)
	</td>
</tr>
</table>

<h3>Equality and Relational Operators</h3>

<table class="table-in-article">
<tr>
	<th style="width: 10%;" class="table-in-article-th">Operator</th>
	<th style="width: 10%;" class="table-in-article-th">Example</th>
	<th class="table-in-article-th">Return value</th>
</tr>
<tr>
	<td class="table-in-article-td">&gt;</td>
	<td class="table-in-article-td">5 &gt; 2</td>
	<td class="table-in-article-td">true</td>
</tr>
<tr>
	<td class="table-in-article-td">&gt;=</td>
	<td class="table-in-article-td">5 &gt;= 2</td>
	<td class="table-in-article-td">true</td>
</tr>
<tr>
	<td class="table-in-article-td">&lt;</td>
	<td class="table-in-article-td">5 &lt; 2</td>
	<td class="table-in-article-td">false</td>
</tr>
<tr>
	<td class="table-in-article-td">&lt;=</td>
	<td class="table-in-article-td">5 &lt;= 2</td>
	<td class="table-in-article-td">false</td>
</tr>
<tr>
	<td class="table-in-article-td">==</td>
	<td class="table-in-article-td">5 == 2</td>
	<td class="table-in-article-td">false</td>
</tr>
<tr>
	<td class="table-in-article-td">!=</td>
	<td class="table-in-article-td">5 != 2</td>
	<td class="table-in-article-td">true</td>
</tr>
</table>

<h3>Conditional Operators</h3>

<table class="table-in-article">
<tr>
	<th style="width: 10%;" class="table-in-article-th">Operator</th>
	<th style="width: 60%;" class="table-in-article-th">Example</th>
	<th class="table-in-article-th">Return value</th>
</tr>
<tr>
	<td class="table-in-article-td">&amp;&amp;</td>
	<td class="table-in-article-td">
		int year = 2016;<br />
		year &gt;= 1901 &amp;&amp; year &lt;= 2000;
	</td>
	<td class="table-in-article-td">false</td>
</tr>
<tr>
	<td class="table-in-article-td">||</td>
	<td class="table-in-article-td">
		int age = 6;<br />
		age &lt; 6 || age &gt;= 65;
	</td>
	<td class="table-in-article-td">false</td>
</tr>
<tr>
	<td class="table-in-article-td">?</td>
	<td class="table-in-article-td">
		int a = 5;<br />
		int b = 2;<br />
		return a &gt; b ? a : b;<br />
	</td>
	<td class="table-in-article-td">5</td>
</tr>
</table>


<h3>Assignment Operators</h3>

<table class="table-in-article">
<tr>
	<th style="width: 10%;" class="table-in-article-th">Operator</th>
	<th style="width: 10%;" class="table-in-article-th">Example</th>
	<th class="table-in-article-th">Description</th>
</tr>
<tr>
	<td class="table-in-article-td">=</td>
	<td class="table-in-article-td">a = 9;</td>
	<td class="table-in-article-td">Assign 9 to a</td>
</tr>
<tr>
	<td class="table-in-article-td">+=</td>
	<td class="table-in-article-td">a += b;</td>
	<td class="table-in-article-td">a = a + b;</td>
</tr>
<tr>
	<td class="table-in-article-td">-=</td>
	<td class="table-in-article-td">a -= b;</td>
	<td class="table-in-article-td">a = a - b;</td>
</tr>
<tr>
	<td class="table-in-article-td">*=</td>
	<td class="table-in-article-td">a *= b;</td>
	<td class="table-in-article-td">a = a * b;</td>
</tr>
<tr>
	<td class="table-in-article-td">/=</td>
	<td class="table-in-article-td">a /= b;</td>
	<td class="table-in-article-td">a = a / b;</td>
</tr>
<tr>
	<td class="table-in-article-td">%=</td>
	<td class="table-in-article-td">a %= b;</td>
	<td class="table-in-article-td">a = a % b;</td>
</tr>
</table>


<h3>+ operator when operand is a string</h3>

<p>
when operand is a string, + operator peforms string concatenation.
</p>

<table class="table-in-article">
<tr>
	<th style="width: 190px;" class="table-in-article-th">Example</th>
	<th class="table-in-article-th">Return value</th>
</tr>
<tr>
	<td class="table-in-article-td">1988 + ": Hi";</td>
	<td class="table-in-article-td">"1988: Hi"</td>
</tr>
</table>
</article>