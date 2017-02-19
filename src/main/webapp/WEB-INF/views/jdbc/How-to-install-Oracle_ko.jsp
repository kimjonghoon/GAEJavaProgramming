<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2015.6.6</div>
	
<h1>오라클 설치</h1>

<p>
JDBC를 배우려면 데이터베이스를 설치해야 한다.<br />
현재 현장에서 가장 많이 사용되는 오라클을 설치하도록 한다.<br />
<a href="http://www.oracle.com">http://www.oracle.com</a>를 방문하고 Downloads 메뉴에서 
<a href="http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html">Oracle Database 11g Express Edition<sup>1</sup></a>을 
선택한다.<br />
만일 오라클 웹사이트에 계정이 없다면 회원 가입을 하고 로그인해야 내려받을 수 있다.<br />
오라클 웹사이트의 아이디와 비밀번호는 나중에 대비해 꼭 메모해 놓자.<br />
오라클 사이트의 비밀번호 찾기 기능은 사용자를 지치게 하기 때문이다.<br /><br />
윈도는 오라클이 지원하는 공식 OS이며 쉽게 설치가 된다.<br />
압축을 풀고 setup.exe를 클릭하여 설치 마법사를 실행한 후 다음 버튼을 클릭하는 것으로 설치를 완료한다.<br />
<br />
리눅스 시스템에 오라클을 설치하려면 각오를 단단히 해야 한다.<br />
설치 실패를 거듭하면 오라클이 공식 지원하는 리눅스 배포판<sup>2</sup>를 찾게 될 것이다.<br />
</p>

<h2>우분투 시스템에 Oracle 11g XE 설치</h2>
<p>
<a href="http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html">http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html</a><br />
아래는 위 사이트에서 우분투 시스템에 오라클 설치 방법을 해석한 글이다.<br />
<br />
오라클 공식 사이트에서 리눅스용 오라클 11g XE를 내려받는다.<br /> 
<a href="http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html">http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html</a><br />

Accept License Agreement 라디오 박스에 체크하고<br /> 
Oracle Database Express Edition 11g Release 2 for Linux x64를 선택한다.<br />
로그인 화면으로 이동하는데 로그인하면 내려받기가 시작된다.<br />
오라클 공식 웹사이트 회원이 아니면 회원 가입을 한다.<br />
모두 내려받았다면 파일이 있는 디렉터리로 이동해 다음 명령을 수행한다.<br />
</p>

<pre class="shell-prompt">
unzip oracle-xe-11.2.0-1.0.x86_64.rpm.zip
sudo apt-get install alien libaio1 unixodbc
cd Disk1
sudo alien --scripts -d oracle-xe-11.2.0-1.0.x86_64.rpm
</pre>

<p>
/sbin/chkconfig 파일을 만든다.
</p>

<pre class="shell-prompt">
sudo nano /sbin/chkconfig
</pre>

<p>
다음을 복사하여 파일에 붙여넣는다.
</p>

<pre class="prettyprint">
#!/bin/bash
# Oracle 11gR2 XE installer chkconfig hack for Ubuntu
file=/etc/init.d/oracle-xe
if [[ ! `tail -n1 $file | grep INIT` ]]; then
echo >> $file
echo '### BEGIN INIT INFO' >> $file
echo '# Provides: OracleXE' >> $file
echo '# Required-Start: $remote_fs $syslog' >> $file
echo '# Required-Stop: $remote_fs $syslog' >> $file
echo '# Default-Start: 2 3 4 5' >> $file
echo '# Default-Stop: 0 1 6' >> $file
echo '# Short-Description: Oracle 11g Express Edition' >> $file
echo '### END INIT INFO' >> $file
fi
update-rc.d oracle-xe defaults 80 01
</pre>

<p>
파일을 저장하고 실행 권한을 부여한다.
</p>

<pre class="shell-prompt">
sudo chmod 755 /sbin/chkconfig
</pre>

<p>
커널 파라미터를 설정한다.
</p>

<pre class="shell-prompt">
sudo nano /etc/sysctl.d/60-oracle.conf
</pre>

<p>
다음 내용을 복사하여 파일에 붙인다.
</p>

<pre class="prettyprint">
# Oracle 11g XE kernel parameters  
fs.file-max=6815744  
net.ipv4.ip_local_port_range=9000 65000  
kernel.sem=250 32000 100 128 
kernel.shmmax=2066743296
</pre>

<p>
마지막 줄 kernel.shmmax 값은 시스템에 설치된 램 메모리의 1/2을 할당한다.<br />
계산 방법은 아래와 같다.<br />
</p>

<pre class="shell-prompt">
free -m
</pre>

<p>
결과가 다음과 같으면
</p>

<pre class="shell-prompt">
             total       used       free     shared    buffers     cached
Mem:          3942       3809        133        947         50       1571
-/+ buffers/cache:       2186       1756
Swap:         4083        378       3705
</pre>

<p>
3942 * 1024 * 1024 * 0.5 = 2066743296<br />
<br />
검증한다.<br />
</p>

<pre class="shell-prompt">
sudo cat /etc/sysctl.d/60-oracle.conf
</pre>

<p>
새로운 커널 파라미터를 올린다.
</p>

<pre class="shell-prompt">
sudo service procps start
</pre>

<p>
검증한다.
</p>

<pre class="shell-prompt">
sudo sysctl -q fs.file-max
</pre>

<p>
다음을 실행한다.<br />
</p>

<pre class="shell-prompt">
sudo ln -s /usr/bin/awk /bin/awk
sudo mkdir /var/lock/subsys
sudo touch /var/lock/subsys/listener
</pre>

<p>
오라클 설치 파일이 있는 Disk1 디렉터리에서 다음 명령으로 설치를 시작한다.
</p>
  
<pre class="shell-prompt">
sudo dpkg --install oracle-xe_11.2.0-2_amd64.deb
sudo /etc/init.d/oracle-xe configure
</pre>

<p>
설정에서 Oracle Application Express의 포트는 톰캣과 같은 WAS가 쓰는 8080을 피한다.<br />
(아래에서는 8989로 설정했다.)<br />
리슨너 포트는 디폴트 값인 1521를 그대로 사용한다. (디폴트 선택은 그냥 엔터를 치면 된다.)<br />
관리자 계정인 SYS와 SYSTEM의 비밀번호를 설정한다.<br />
부팅시 오라클 자동시작을 예스로 설정한다.(엔터)<br />
</p>

<pre class="shell-prompt">
Oracle Database 11g Express Edition Configuration
-------------------------------------------------
This will configure on-boot properties of Oracle Database 11g Express 
Edition.  The following questions will determine whether the database 
should be starting upon system boot, the ports it will use, and 
the passwords that will be used for database accounts.  
Press Enter to accept the defaults. 
Ctrl-C will abort.

Specify the HTTP port that will be used 
	for Oracle Application Express [8080]:<strong>8989</strong>

Specify a port that will be used for the database listener [1521]:

Specify a password to be used for database accounts.
Note that the same password will be used for SYS and SYSTEM.
Oracle recommends the use of different passwords 
for each database account.
This can be done after 
initial configuration: <strong>&lt;관리자 비밀번호&gt;</strong>
Confirm the password: <strong>&lt;관리자 비밀번호&gt;</strong>

Do you want Oracle Database 11g Express Edition to be started 
on boot (y/n) [y]:

Starting Oracle Net Listener...Done
Configuring database...Done
Starting Oracle Database 11g Express Edition instance...Done
Installation completed successfully.
</pre>

<p>
환경변수를 추가한다.
</p>

<pre class="shell-prompt">
gedit ~/.bashrc
</pre>

<p>
아래를 복사하여 .bashrc 가장 아래에 붙여넣는다.
</p>

<pre class="prettyprint">
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export ORACLE_BASE=/u01/app/oracle
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
export PATH=$ORACLE_HOME/bin:$PATH
</pre>

<p>
다음 명령으로 환경 변수를 적용한다.<br />
</p>

<pre class="shell-prompt">
source ~/.bashrc
</pre>

<p> 
오라클을 시작한다.<br />
(부팅시 오라클 시작을 예스로 설정했으므로 재부팅 후 이 명령은 필요없다.)
</p>

<pre class="shell-prompt">
sudo service oracle-xe start
</pre>


<h3>SCOTT 계정 만들기</h3>

<p>
관리자 계정으로 오라클에 로그인한다.<br />
</p>

<pre class="shell-prompt">
<strong>sqlplus sys as sysdba</strong>

SQL*Plus: Release 11.2.0.2.0 Production on 월 6월 29 12:04:33 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.

Enter password: <strong>&lt;관리자 비밀번호&gt;</strong>

Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

SQL> <strong>@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/utlsampl.sql</strong>
</pre>

<span id="comments">주석</span>
<ol>
	<li>Express Edition(XE라고 한다)의 애매한 라이선스<br />
	<a href="http://daust.blogspot.kr/2012/08/clarification-on-oracle-xe-licensing.html">http://daust.blogspot.kr/2012/08/clarification-on-oracle-xe-licensing.html</a></li>
	<li>Oracle Enterprise Linux 4 Update 7<br />
	Oracle Enterprise Linux 5 Update 2<br />
	Red Hat Enterprise Linux 4 Update 7<br />
	Red Hat Enterprise Linux 5 Update 2<br />
	SUSE Linux Enterprise Server 10 SP2<br />
	SUSE Linux Enterprise Server 11<br />
	열거된 리눅스는 국내 사용자에게는 익숙하지 않는 것들이라 생각된다.<br />
	오라클 때문에 사용하던 OS를 버리는 것이 과연 옳은 선택일까?<br />
	가정에 하나쯤 있는 윈도 시스템에 오라클을 설치하는 것이 정신 건강에 이롭다.<br />
	</li>
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/cd/E17781_01/install.112/e18802/toc.htm">http://docs.oracle.com/cd/E17781_01/install.112/e18802/toc.htm</a></li>
	<li><a href="http://docs.oracle.com/cd/E17781_01/install.112/e18803/toc.htm">http://docs.oracle.com/cd/E17781_01/install.112/e18803/toc.htm</a></li>
	<li><a href="http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html">http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html</a></li>
	<li><a href="http://crunchbang.org/forums/viewtopic.php?id=23267">http://crunchbang.org/forums/viewtopic.php?id=23267</a></li>
	<li><a href="http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html">http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html</a></li>
</ul>
</article>