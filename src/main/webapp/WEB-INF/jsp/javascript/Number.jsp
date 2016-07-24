<script type="text/javascript" src="/resources/js/script-result-display.js"></script>

<div id="last-modified">Last Modified : 2013.11.11</div>

<h1 class="heading1">Number</h1>

이클립스에서 작업하면 그림처럼 코드 어시스트를 받을 수 있다.<br />
<br />
<img src="https://lh3.googleusercontent.com/-lsFSrTUjwYA/UotVMybUr4I/AAAAAAAABdQ/gtTrUc0F6YA/s507/javascript-plugin.png" alt="이클립스 자바스크립트  코드 어시스트 기능 활용" /><br />

<pre class="prettyprint">
var num = new Number(2194.123456);
alert("A."+num<strong>.toExponential(3)</strong>); //소수점 이하 3자리를 넘긴 부분은 지수 표현
alert("B."+num<strong>.toPrecision(3)</strong>); //유효숫자를 3자리로 표현
alert("C."+num<strong>.toFixed(8)</strong>); //소수점 이하를 8자로 나머지는 반올림
alert("D."+num<strong>.toLocaleString()</strong>); //로케일에 맞게 숫자를 표현
alert("E."+num<strong>.toString()</strong>); //객체를 문자열로 반환
alert("F."+<strong>Number.MAX_VALUE</strong>); //최대값
alert("G."+<strong>Number.MIN_VALUE</strong>); //최소값
alert("H."+<strong>Number.NEGATIVE_INFINITY</strong>); 
alert("I."+<strong>Number.POSITIVE_INFINITY</strong>); 
alert("J."+<strong>Number.NaN</strong>); //Not a Number 즉, 숫자가 아니라는 의미
alert("K."+(<strong>num.valueOf()</strong> + 1)); //넘버객체의 값을 기본형값으로 반환
//isNaN() 내장함수는 수와 관련되므로 여기서 소개한다.
if (<strong>isNaN</strong>("이천십사년") == true) {
	alert("L.숫자가 아니다.");
}
</pre>

이외에 prototype 프로퍼티가 있다.<br />
prototype 프로퍼티는 객체에 새로운 속성이나 메서드를 추가하는 것을 가능하게 한다.