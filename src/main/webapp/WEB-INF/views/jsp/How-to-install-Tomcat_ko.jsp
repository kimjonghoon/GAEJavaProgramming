<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>
<div class="last-modified">Last Modified 2017.2.15</div>

<h1>Tomcat 설치</h1>

<p>
다음 주소에서 32-bit/64-bit Windows Service Installer를 내려 받는다.<br />
<a href="http://tomcat.apache.org/download-80.cgi">http://tomcat.apache.org/download-80.cgi</a><br />
<img src="https://lh3.googleusercontent.com/w73B4xxQhLw1taB9k39Fh-rLkmsQYhopJYCTFIrKjH7P99TJG1Dh2G1d7n4jUZiYzjnaBuVSzh-e1C2g1YTZ34nKEuEyZ7WRlPKc49Zvy0HfM08XMbcaTRbhf8aAtVxZ9CV62G-UySubv_F7yvpSJHUkwFvhLzIg-qG6T85oph3--oqNtgcfXeluJUkZc-Kp8zBymdzo7X4GIfvhGEHXJbVPRiTUZ6MitvWlU3v8z8D5waDmYrhKBaUg5BdKEPn5PJ2iRokMC2rN0gFXTH54gkHoyWQeTH9xJ4y7K5Sngip136Ka2xwS0AtairgWFuWsEgv9xfsQ5JfGfr0XMeK0TO-LDAKwx-tgnLPTLf2gMnNQQzXTF6_DilWOPgygIyvo7wN_m0GL2qhR6OrGG4JWQyiQo2Dc_WJVVSTQ4zSI-7QB5FS2mM26Kvu1t7mp5RMP97lq7jFMqLIKcw4SM1AP-HqizPKKyKb38jqDkPacxTAG21RDtMGwMZd1clZHOel5cctzRxgEHrvlqHHNkKtRCPDTASNEM8AgSFD9Sv2m94hpXssMN2bCjtTrhdVu0aIKZwpl9_vjacNqepfpghmlNFBdVO7h5kdwxujhCsd0XabyeYhdDwXeDYsRUpLJO6mC125ZUDUfzTPui-EQ4ND07xyZDbzAdZzlRSutTKVwCg=w701-h491-no" alt="Tomcat8 download" /><br />
다운로드한 파일을 실행해 설치를 시작한다.
</p>

<p>
설치 도중 톰캣이 사용하는 포트 번호를 결정한다.
톰캣의 디폴트 포트는 8080이다.
8080 포트를 다른 프로그램이 사용하고 있다면, 8080을 사용할 수 없다.
만약 오라클 11g XE가 8080을 사용한다면, 톰캣의 포트를 변경한다.
포트 번호는 설치 후에도 변경할 수 있다.
{톰캣홈}<sup>1</sup>/conf 디렉토리에서 server.xml 파일을 편집하면 변경된다.
</p>

<p>
설치 도중 톰캣 관리자의 사용자명과 비밀번호를 부여한다.
이 설정 역시 설치 후에 변경할 수 있다.
{톰캣홈}/conf 디렉토리에서 tomcat-users.xml 파일을 열고 편집하면 변경된다.
</p>

<p>
설치가 제대로 완료되었는지 확인하기 위해서 http://localhost:port를 방문한다. 
(여기서 port는 톰캣이 사용하도록 정한 포트이다.)
고양이를 볼 수 있다면 설치가 성공한 것이다.
고양이를 보여주는 화면은 톰캣의 ROOT 애플리케이션의 홈페이지이다.
ROOT 애플리케이션의 위치는 {톰캣홈}/webapps/ROOT이다.
</p>

<p>
윈도 시스템에서 톰캣이 서비스를 시작하면 시스템 트레이 메뉴에 Tomcat Monitor 아이콘이 나타난다.
만약 고양이 화면을 보지 못했다면 이 Tomcat Monitor를 이용해서 톰캣을 실행을 시도해 본다.<sup>2</sup>
</p>

<span id="comments">Comments</span>
<ol>
	<li>윈우 시스템에서 {톰캣홈}의 전체 경로는 대략 "C:\Program Files\Apache Software Foundation\Tomcat ..."이다.</li>
	<li>포트를 8080을 사용하도록 설치한 후, http://localhost:8080을 방문했을 때 
	"인증 필요 서버 http://localhost:8080에 사용자 이름과 비밀번호를 입력해야 합니다.서버메시지:XDB ..."
	라는 메시지가 보인다면 이건 톰캣이 아니라 오라클의 XDB가 반응한 것이다.
	이런 경우 {톰캣홈}/conf/server.xml 파일에서 8080 포트를 다른 번호로 바꿔야 한다.
	</li>
</ol>
</article>