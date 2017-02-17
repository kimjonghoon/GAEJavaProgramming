<article>
<div class="last-modified">Last Modified 2014.8.4</div>

<h1>개발 준비</h1>

<h2>이클립스에서 Dynamic Web Project 선택해서 새로운 프로젝트 생성</h2>
개발 시스템에 톰캣과 이클립스가  설치되어 있어야 하고, 이클립스에는 WTP플러그인이 설치되어 있어야 한다.
이클립스 버전에 따라 WTP 설치가 쉽지 않을 수 있다. 
이런 경우, WTP가 포함되어 있는 Eclipse IDE for Java EE Developers를 새로 설치하자.
이클립스를 시작한다.(여기서는 워크스페이스를 C:/www 로 선택했다)
퍼스펙티브가 Java EE인 상태에서, Dynamic Web Project를 선택하여 프로젝트를 생성한다.
서블릿, JSP 장에서는 퍼스펙티브가 Java인 상태에서 Java Project를 선택하여 프로젝트를 생성했다.
 
 
<h3>Dynamic Web Project 프로젝트 생성</h3>
<img src="https://lh5.googleusercontent.com/-42TkBNkWZyw/Tuv7qhWj1eI/AAAAAAAAA4Y/4N0ZYhVmrx4/s590/new_dynamic_webProject.png" alt="1. New - Dynamic Web Project 를 선택한다." /><br />
<img src="https://lh3.googleusercontent.com/-hbGGtu9EfEI/TutjP9fITlI/AAAAAAAAA4E/fbwQJmVZPv0/s523/dynamic_webproject.png" alt="2. Dynamic Web Proejct 를 이용해서 새로운 프로젝트를 생성한다. " /><br />

프로젝트 이름을 JSPProject 라고 하겠다.<br />
여기에서는 이클립스와 톰캣을 연동하지 않을 것이므로, 프로젝트 이름 외의 설정은 디폴트로 그대로 두고 "Next"을 계속 클릭하여 마무리한다.<br />

<img src="https://lh3.googleusercontent.com/-HVViyq64maY/Tuti18TkZ-I/AAAAAAAAA3U/KQ337OflcXs/s640/JSPProject.PNG" alt="3. 이클립스에서 Dynamic WebProject 를 선택해서 새로운 프로젝트를 생성하는데 프로젝트명은 JSPProject로 한다." /><br />

<img src="https://lh3.googleusercontent.com/-17rYJE8t9no/Tuti3epuNmI/AAAAAAAAA3s/6AMamqkjZP8/s520/WebContent.PNG" alt="4. Dynamic WebProject 로 프로젝트를 생성할 때 웹컨텐츠를 두는 기본 폴더는 WebContent 이다." /><br />

프로젝트가 생성이 완료된 다음에 개발을 편하게 하기 위해서 Build Path를 변경하다.<br />
Package Explorer 뷰에서 프로젝트를 마우스로 선택하고 
마우스 오른쪽 키를 클릭하여 아래 그림처럼 메뉴가 나타나도록 한다.<br />
메뉴에서 <strong>Build Path, Configure Build Path...</strong> 를 차례로 선택한다.<br />

<img src="https://lh6.googleusercontent.com/-Fs1hxINvL_8/Tuti0tC0wKI/AAAAAAAAA3A/aL_2Z1ixVhI/s590/build_path.png" alt="5. 개발을 편하게 하기 위해서 Dynamic WebProject의 기본 output 폴더인 build 를 WEB-INF/classes 로 바꾸기 위해 Build Path  를 선택한다." /><br />

이어지는 화면에서 Source 탭을 선택한다.<br />

<img src="https://lh5.googleusercontent.com/-XbccQsDk2Gs/TuwAO6p5hrI/AAAAAAAAA48/g0SMlArOHMI/s741/source_tab_select.PNG" alt="source tab를 선택한다." width="590px" /><br />

소스 화면 하단 Default output folder: 의 오른쪽의 Browse... 버튼을 클릭하면 
Folder Selection 화면이 나타난다.<br /> 
Folder Selection 화면의 Create New Folder... 버튼을 클릭하여 WEB-INF/classes 폴더를 그림처럼 생성한다.<br />
WEB-INF/classes 폴더가 Default output 폴더가 되도록 설정한다.<br />

<img src="https://lh3.googleusercontent.com/-Axdwie02Mps/Tuti1e4eG-I/AAAAAAAAA3Q/VkIWy9KCG9s/s552/classes.png" alt="Build Path를 선택해서 나오는 설정화면에서 source 탭을 클릭한다. 아래 Default output Folder 옆의 Browser 를 클릭한 다음 Create New Folder 를 클릭하여 WEB-INF아래 classes 폴더를 만들고 이 폴더를 선택한다." /><br />

Default output 폴더가 <strong>JSPProject/WebContent/WEB-INF/classes</strong> 인지 확인한다.<br />

<img src="https://lh3.googleusercontent.com/-F2nBQYXkPL4/Tuti0jkBddI/AAAAAAAAA28/iestW7xEr2Q/s733/build_path_result.PNG" width="590px;" alt="변경하려는 Build Path, JSPProject/WebContent/WEB-INF/classes 를 확인하는 설정 화면이다." /><br />

참고로 Dynamic Web Project 로 생성했을 경우 JSPProject/build 란 폴더가 Default output 폴더로서 만들어진다.<br />
다음은 탐색기에서 본 JSPProject 프로젝트의 디렉토리이다.<br />

<img src="https://lh3.googleusercontent.com/-QYsQsax98ok/VYT2B2wxsvI/AAAAAAAAChY/-vFh-YbAOgA/s258/JSPProject-directory.png" alt="4. 이클립스에서 워크스페이스를 C:/www 로, 프로젝트명을 JSPProject 로 해서 프로젝트를 생성했을 때 디렉토리 구조를 보이는 화면" /><br />

<h2>JSPProject 웹 애플리케이션을 톰캣에 등록</h2>
톰캣이 우리가 만든 JSPProject 웹 애플리케이션을 등록하고 서비스하도록 해야 한다.<br />
아래와 같은 내용으로 파일명을 JSPProject.xml 으로 파일을 만들고, 
{톰캣홈}/conf/Catalina/localhost 에 저장한 다음 톰캣을 재실행한다.<br />

<em class="filename">JSPProject.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
	<strong>docBase="C:/www/JSPProject/WebContent"</strong>
	reloadable="true"&gt;
&lt;/Context&gt;
</pre>

웹 애플리케이션과 JSPProjext.xml 파일에 이상이 없다면 톰캣은 JSPProject 애플리케이션을 등록하고 서비스할 것이다.<br />
여기서 {톰캣홈} 은 톰캣이 설치된 최상위 디렉토리를 말한다.<br />
윈도우 시스템이고 톰캣 7을 설치했을 경우 {톰캣홈} 은 <br />
<em class="path">C:\Program Files\Apache Software Foundation\Tomcat 7.0</em> 이고
JSPProject.xml 파일은
<em class="path">C:\Program Files\Apache Software Foundation\Tomcat 7.0\conf\Catalina\localhost</em> 
에 저장되어야 한다.<br />
JSPProject.xml 내용중에 docBase 의 값이 C:/www/JSPProject 가 아니라는 점에 조심해야 한다.<br />
WEB-INF 바로 위 디렉토리가 도큐먼트베이스이다.<br />

<h3>WEB-INF/web.xml</h3>
web.xml 은 웹 애플리케이션에 대한 설정파일이다.<br />
이클립스에서 Dynamic Web Project 로 프로젝트를 생성했다면 web.xml 이 자동으로 만들어질 수 있다.<br />
만일 만들어지지 않았다면 {톰캣홈}/webapps 에 있는 ROOT 애플리케이션의 web.xml 파일을 복사해서 JSPProject 의 WEB-INF 디렉토리에 붙여넣는다.<br />
그다음, 붙여넣기한 web.xml 파일을 열고 web-app 엘리먼트의 내용을 모두 지운다.<br /> 
편집한 web.xml 은 아래와 같을 것이다.<br />

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="ISO-8859-1"?&gt;
&lt;!--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--&gt;

&lt;web-app xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                      http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0"
  metadata-complete="true"&gt;  

&lt;/web-app&gt;
</pre>

<h3>테스트</h3>
톰캣이 JSPProject 를 서비스하고 있는지 확인하자.<br />
도큐먼트 베이스에 test.html 파일을 만든다.<br />
아래 그림처럼 WebContent 를 선택한 상태에서 마우스 오른쪽 버튼을 클릭한 후
New -- HTML File 를 차례로 선택한다.<br />
 
<img src="https://lh5.googleusercontent.com/-5QI9P39l5IQ/Tuti2gJ7hcI/AAAAAAAAA3o/Ic0IBV-nWUw/s590/test_html.png" alt="웹 애플리케이션이 톰캣에 등록한 후에 테스트하기 위해서 웹 애플리케이션의 루트 디렉토리에 test.html 이라는 파일을 만드는 화면이다." /><br />

http://localhost:port/JSPProject/test.html를 방문해서 톰캣이 웹 애플리케이션을 서비스하는지 확인한다.<br />
여기서 port는 톰캣이 사용하는 포트 번호이다.<br />
{톰캣홈}/conf/server.xml 파일에서 포트번호를 확인할 수 있다.<br />

<pre class="prettyprint">
&lt;Connector port=<strong title="톰캣 디폴트 포트는 8080">"8989"</strong> protocol="HTTP/1.1" 
	connectionTimeout="20000" 
	<strong title="GET방식으로 한글 데이터를 전달하기 위해서">URIEncoding="UTF-8"</strong>
	redirectPort="8443" /&gt;
</pre>

<h2>JSP 페이지</h2>
구현하려는 프로젝트는 모델1 게시판이다.<br />
모델1은 클라이언트가 직접 JSP를 요청한다.<br />
그러므로 모델1에서는 주인공이 JSP 라고 할 수 있다.<br />
다음은 웹 프로그래밍 구성요소 중 JSP 만 따로 정리한 것으로, 다음 글부터 순서대로 구현할 것이다.<br />

<ul>
  <li>/index.jsp : 홈페이지</li>

  <li>/error.jsp : 에러 페이지</li>
</ul>

<ul>
  <li>
    <strong>/inc 공통 인클루드</strong>

    <ol>
      <li>header.jsp : 로고와 회원메뉴 버튼(로그인, 회원 가입 또는 로그아웃, 내 정보 수정)</li>

      <li>main-menu.jsp : 메인 메뉴</li>

      <li>extra.jsp : 화면 오른쪽에 위치하며 이미지로 외부 링크</li>

      <li>footer.jsp : 카피라이트, 주소, 연락처 표시</li>

      <li>loginCheck.jsp : 로그인이 필요한 페이지에서 인클루드<br />
      로그인되어 있지 않은 사용자는 로그인 페이지로 이동시킨다.<br />
      이때 로그인 후 다시 돌아오기 위한 정보를 로그인 페이지에 전달한다.</li>
    </ol>
  </li>
</ul>

<ul>
  <li>
    <strong>/users</strong>

    <ol>
      <li>notLoginUsers-menu.jsp : 로그인하지 않은 사용자를 위한 회원 관련 메뉴</li>

      <li>login.jsp : 로그인 폼</li>

      <li>login_proc.jsp : 로그인 처리</li>

      <li>logout_proc.jsp : 로그아웃 처리</li>

      <li>loginUsers-menu.jsp : 로그인한 사용자를 위한 회원 관련 메뉴</li>

      <li>signUp.jsp : 회원 가입 폼</li>

      <li>signUp_proc.jsp : 회원 가입 처리</li>

      <li>welcome.jsp : 회원 가입 환영</li>

      <li>editAccount.jsp : 내 정보 수정 폼</li>

      <li>editAccount_proc.jsp : 내 정보 수정 처리</li>

      <li>changePasswd.jsp : 비밀번호 변경 폼</li>

      <li>changePasswd_proc.jsp : 비밀번호 변경 처리</li>

      <li>changePasswd_confirm.jsp : 비밀번호 변경 확인</li>

      <li>bye.jsp : 탈퇴 폼</li>

      <li>bye_proc.jsp : 탈퇴 처리</li>

      <li>bye_confirm.jsp : 탈퇴 확인</li>
    </ol>
  </li>
</ul>

<ul>
  <li>
    <strong>/bbs</strong>

    <ol>
      <li>bbs-menu.jsp : 게시판 메뉴</li>

      <li>list.jsp : 게시판 목록</li>

      <li>write_form.jsp : 글쓰기 폼</li>

      <li>write_proc.jsp : 글쓰기 처리</li>

      <li>view.jsp : 상세보기</li>

      <li>addComment_proc.jsp : 댓글 쓰기 처리</li>

      <li>updateComment_proc.jsp : 댓글 수정 처리</li>

      <li>deleteComment_proc.jsp : 댓글 삭제 처리</li>

      <li>deleteAttachFile_proc.jsp : 첨부 파일 삭제 처리</li>

      <li>del_proc.jsp : 게시글 삭제 처리</li>

      <li>modify_form.jsp : 게시글 수정 폼</li>

      <li>modify_proc.jsp : 게시글 수정 처리</li>
    </ol>
  </li>
</ul>

<ul>
  <li>
    <strong>/java</strong>

    <ol>
      <li>index.jsp : 서브페이지 예제</li>
    </ol>
  </li>
</ul>
</article>
