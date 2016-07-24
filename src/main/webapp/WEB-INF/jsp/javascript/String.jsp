<script type="text/javascript" src="/resources/js/script-result-display.js"></script>

<div id="last-modified">Last Modified : 2013.11.11</div>

<h1 class="heading1">String</h1>

<pre class="prettyprint">
<strong>var name = new String("홍길동");//또는 var name = "홍길동";</strong>
var engName = "gildong hong"
alert("1) 성명: " + name);
alert("2) 영어이름: " +engName);
alert("3) 성: " + name<strong>.substring(0,1)</strong>);//자바와 같음
alert("4) 이름: " + name<strong>.substring(1)</strong>);//자바와 같음
alert("5) 이름길이: " + name<strong>.length</strong>);//자바는 length()
alert("6) "+name<strong>.charAt(1)</strong>);//문자의 인덱스 1에 위치한 문자 반환,자바와 같음
alert("7) "+name<strong>.charCodeAt(1)</strong>);//인덱스의 문자코드 반환, 자바의 codePointAt()
alert("8) "+name<strong>.concat(",임꺽정,장길산")</strong>);//자바와 같음
alert("9) "+name<strong>.indexOf("길")</strong>);//길이라는 문자가 있는 인덱스 번지 반환,자바와 같음 
alert("10) "+name<strong>.lastIndexOf("길",0)</strong>);//인덱스 0부터 왼쪽으로 검색,자바와 같음
alert("11) "+name<strong>.match(/길동/)</strong>);//정규표현식에 해당하는 문자열을 반환,자바엔 없음
alert("12) "+name<strong>.replace("홍","고")</strong>);//자바의 replaceAll()과 가장 비슷
alert("13) "+name<strong>.search(/동/g)</strong>);//정규표현식에 해당하는 문자열의 찾아 인덱스 반환
alert("14) "+name<strong>.slice(1,2)</strong>);//자바의 substring(int,int)
alert("15) "+name<strong>.slice(1)</strong>);//자바의 substring(int)
alert("16) "+name<strong>.split("길")</strong>);//자바스크립트의 배열은,로 구분,자바의 split() 같음
alert("17) "+name<strong>.substring(1,2)</strong>);//자바와 같음
alert("18) "+engName<strong>.toUpperCase()</strong>);//자바와 같음
alert("19) "+engName<strong>.toLowerCase()</strong>);//자바와 같음
</pre>