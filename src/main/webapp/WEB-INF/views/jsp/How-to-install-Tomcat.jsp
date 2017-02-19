<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2017.2.15</div>

<h1>How to install Tomcat</h1>

<p>
On Windows systems, download the 32-bit/64-bit Windows Service Installer from the following address:<br />
<a href="http://tomcat.apache.org/download-80.cgi">http://tomcat.apache.org/download-80.cgi</a><br />
<img src="https://lh3.googleusercontent.com/w73B4xxQhLw1taB9k39Fh-rLkmsQYhopJYCTFIrKjH7P99TJG1Dh2G1d7n4jUZiYzjnaBuVSzh-e1C2g1YTZ34nKEuEyZ7WRlPKc49Zvy0HfM08XMbcaTRbhf8aAtVxZ9CV62G-UySubv_F7yvpSJHUkwFvhLzIg-qG6T85oph3--oqNtgcfXeluJUkZc-Kp8zBymdzo7X4GIfvhGEHXJbVPRiTUZ6MitvWlU3v8z8D5waDmYrhKBaUg5BdKEPn5PJ2iRokMC2rN0gFXTH54gkHoyWQeTH9xJ4y7K5Sngip136Ka2xwS0AtairgWFuWsEgv9xfsQ5JfGfr0XMeK0TO-LDAKwx-tgnLPTLf2gMnNQQzXTF6_DilWOPgygIyvo7wN_m0GL2qhR6OrGG4JWQyiQo2Dc_WJVVSTQ4zSI-7QB5FS2mM26Kvu1t7mp5RMP97lq7jFMqLIKcw4SM1AP-HqizPKKyKb38jqDkPacxTAG21RDtMGwMZd1clZHOel5cctzRxgEHrvlqHHNkKtRCPDTASNEM8AgSFD9Sv2m94hpXssMN2bCjtTrhdVu0aIKZwpl9_vjacNqepfpghmlNFBdVO7h5kdwxujhCsd0XabyeYhdDwXeDYsRUpLJO6mC125ZUDUfzTPui-EQ4ND07xyZDbzAdZzlRSutTKVwCg=w701-h491-no" alt="Tomcat8 download" /><br />
Double-click the downloaded file to start the installation.
</p>

<p>
Determine the Tomcat port during installation.
Tomcat's default port is 8080.
If the 8080 port is being used by another program, you should change it.
If Oracle 11g XE uses the 8080, you need to change the Tomcat port.
The port number can be changed after installation.
You can change it by opening and editing the server.xml file in {TOMCAT_HOME}<sup>1</sup>/conf directory.
</p>

<p>
Set the Tomcat administrator username and password during installation.
This setting can also be changed after installation.
You can change them by opening and editing the tomcat-users.xml in {TOMCAT_HOME}/conf directory.
</p>

<p>
Visit http://localhost:port.(Where port is the port number used by Tomcat)
If you see a cat, installation is a success.
The screen showing the cat is the homepage of Tomcat's ROOT application.
The location of the ROOT application is {TOMCAT_HOME}/webapps/ ROOT.
</p>

<p>
When Tomcat starts the service, the Tomcat Monitor icon appears in the system tray menu.
If you have not seen the cat, try restarting Tomcat using this Tomcat Monitor.<sup>2</sup>
</p>

<span id="comments">Comments</span>
<ol>
	<li>On Windows systems, the full path to {TOMCAT_HOME} is approximately <em>"C:\Program Files\Apache Software Foundation\Tomcat ..."</em>.</li>
	<li>When you set the Tomcat port to 8080 and visit http://localhost:8080,
If you see the message <em>"Authentication Required Server http:/localhost:8080 requires a user name and a password. The server says: XDB"</em>.
It is Oracle XDB, not Tomcat, that works with 8080.
In this case, you need to change port 8080 to a different number in the {TOMCAT_HOME}/conf/server.xml.<br />
<strong class="filename">Previous</strong>
<pre class="prettyprint">
&lt;Connector port="<strong>8080</strong>" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" /&gt;	
</pre>
<strong class="filename">Updated</strong>
<pre class="prettyprint">
&lt;Connector port="<strong>8989</strong>" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" /&gt;	
</pre>
	</li>
</ol>
</article>