<article>
<script type="text/javascript" src="/resources/js/script-result-display.js"></script>

<div class="last-modified">Last Modified 2013.11.12</div>
			
<h1>Date</h1>

Date 객체를 통해 날짜를 생성하고 년, 월, 일, 초 등의 값에 접근할 수 있다.<br />
인자를 지정하지 않고 생성하면 시스템의 현재 날짜와 시간으로 초기화된다.<br />

<pre class="prettyprint">
var now = new Date();
alert("지금 : " + now.toUTCString());

var milliSecs = new Date(7789110879);
alert("milliSecs: " +milliSecs.toUTCString());

var soccerDay = new Date("Nov 9, 2013 8:00:00");
alert("경기당일: " + soccerDay.toUTCString());

var birthday = new Date(1981,1,25);
alert("생년월일: " + birthday.toLocaleString());

var newYearsEve = new Date(2014,11,31,23,59,59,59);
alert("새해전날: " + newYearsEve.toUTCString());
</pre>

<!-- 
Date 객체를 생성하고 난 후엔, 여러 가지 메소드로 값에 접근할 수 있다.
단순히 값에 접근하는 정적 메소드도 몇 가지 있고, 날짜의 각 비트를 조작할 수 있는 메소드도
몇가지 있다.
Date.now 는 현재 날짜와 시각을 반환하고, Date.parse는 1970년 1월 1일 12시 이후로 현재까지 경과된 시간을 밀리 초 단위로 반환하며, 
Date.UTC 는 1970년 1월 1일 자정 이후로 현재까지 경과된 시간을 밀리 초 단위로 반환한다.

var numMs = Date.UTC(1977,16,24,30,30,30);

Date 객체의 메소드를 사용하면, 특정 요소를 설정하거나 값을 알아낼 수 있다.
다음 메소드는 로컬 날짜값과 시각값을 가져온다.

getFullYear
getHours
getMilliseconds
getMinutes
getMonth
getSeconds
getYear

getUTCFullYear
getUTCHours
getUTCMilliseconds
getUTCMinutes
getUTCMonth
getUTCSeconds

대부분의 get 메소드는 상응하는 set 메소드가 있다.

getDate 메소드는 월을 숫자로 반환하며, getDay 메소드는 요일을 숫자로 반환한다.
요일을 반환할 때는 기준으로 일요일을 0으로 한다.

var dtNow = new Date();
alert(dtNow.getDay());

getTimezoneOffset 는 UTC 와 로컬 시각의 차이를 +/-기호와 함께 분 단위로 표시한다.

toString
로컬 시각을 문자열로 출력한다.

toGMTString
문자열 형식을 GMT 표준으로 지정한다.

toLocaleDateString 과 toLocaleTimeString
로케일을 사용해서 날짜와 시각을 출력한다.

toLocaleString
문자열 형식으로 현재 로케일로 지정한다.

toUTCString
문자열 형식을 UTC 표준으로 정한다.

[예제 4-8] : 다양한 date 메소드의 사용 예

주의
getYear 에 대해서 firefox 와 IE 모두 테스트한다.
-->


<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.w3schools.com/jsref/jsref_obj_date.asp">http://www.w3schools.com/jsref/jsref_obj_date.asp</a></li>
</ul>
</article>