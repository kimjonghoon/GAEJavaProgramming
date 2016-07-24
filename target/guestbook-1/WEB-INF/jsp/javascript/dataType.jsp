<script type="text/javascript" src="/resources/js/script-result-display.js"></script>

<div id="last-modified">Last Modified : 2013.11.11</div>

<h1 class="heading1">기본 데이터 타입</h1>

자바스크립트의 기본 데이터 타입은 문자, 숫자, 불린이다.<br />
변수를 선언할 때 변수 명 앞에 variable의 약자인 var를 붙인다.<br />

<pre class="prettyprint">
var city = "서울";//또는 '서울'
var result = 1200 / 1000;
var onGlass = true;
alert('city: ' + city);
alert('result: ' + result);
alert('onGlass: ' + onGlass);
</pre>

<h3 class="heading3">지역변수와 전역변수</h3>
지역변수는 함수 내에서 선언된 변수로 함수 내에서만 사용할 수 있다.<br />
전역변수는 함수 밖에서 선언된 변수로 모든 함수에서 사용할 수 있다.<br />
var를 붙이지 않고 선언한 변수는, 변수의 위치가 함수 안이든 밖이든 상관없이, 전역변수가 된다.<br />
하지만 변수를 선언할 때는 var를 붙이는 것이 좋은 코딩 습관이다.<br />

<h3 class="heading3">상수</h3>
상수를 선언할 때는 상수 앞에 const를 붙인다.<br />
상수 이름은 대문자와 _로 구성하는 것이 관례이다.<br />
상수도 변수와 같이 전역 상수와 지역 상수가 있다.<br />

<pre class="prettyprint">
const PI = 3.14;
alert('PI: ' + PI);
</pre>

<h3 class="heading3">주석</h3>
// 은 한 줄 주석이고,<br />
/* */ 은 여러 줄 주석이다.<br />

<h3 class="heading3">식별자</h3>
식별자로는 문자, 숫자, _, $을 조합한 어떠한 문자열도 가능하다.<br />
대소문자를 구별한다.<br />
예약어는 사용할 수 없다.<br />

<h3 class="heading3">undefined</h3>
undefined는 변수가 선언되고 초기화되지 않은 상태에서 값을 참조했을 때 '값이 할당되지 않았다'는 
의미이다.<br />

<pre class="prettyprint">
var i;
alert('i: ' + i);
</pre>

if 문의 조건절에 0, "", NaN, undefined 가 오면 false이다.<br />

<pre class="prettyprint">
var i;
if (i) {
	alert('i: ' + "true");
} else {
	alert('i: ' + "false");
}
</pre>