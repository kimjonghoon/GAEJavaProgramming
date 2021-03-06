<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>

<div class="last-modified">Last Modified 2015.11.11</div>

<h1>JDK Install</h1>

<h2>Downloading the JDK installer</h2>

<p>
<a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html">http://www.oracle.com/technetwork/java/javase/downloads/index.html</a><br />

<img src="https://lh3.googleusercontent.com/-CttJ26edXQ8/Vjq0aKA0REI/AAAAAAAACqc/s8PKICr8Lyc/s533-Ic42/JavaSEDevelopmentKit.png" alt="64bit windows Java SE" /><br />

If your system is 64-bit Windows, download the Windows x64.<br />
If your system is 32-bit Windows, download the Windows x86.<br />

<a href="http://windows.microsoft.com/en-us/windows/32-bit-and-64-bit-windows#1TC=windows-7">How can I tell if my computer is running a 32-bit or a 64-bit version of Windows?</a><br />
<br />

Installation can be completed simply by clicking the "Next" button.<br />
JDK is locate at "C:\Program Files\Java\jdk1.8.0_&lt;version&gt;"<br />
</p>

<h3>Updating the PATH Environment Variable</h3>

<p>
Click Start, then Control Panel, then System.<br />
Click Advanced, then Environment Variables.<br />
Add the location of the bin folder of the JDK installation for the PATH variable in System Variables.<br />
<br />
If your computer is running Windows XP, do the following:<br />

<img src="https://lh3.googleusercontent.com/-ULLVFDs9LxI/VYDNrKfmzxI/AAAAAAAACMw/8Qb6hgcy1FgaEIbYPnSmyK7YMQY57UivQCCo/s664-Ic42/start-My_Computer-Properties.png" alt="System Properties" /><br /><br />

<img src="https://lh3.googleusercontent.com/-zcZel2n21yk/VYDNqu5CxGI/AAAAAAAACMs/zIwc6Mz6__8optVwJUZnakdVUcAb6ostQCCo/s483-Ic42/System-Properties_Advanced.png" alt="System Properties" /><br /><br />

Creates a new environment variable JAVA_HOME in the "Environment Variables".<br /> 
The value of JAVA_HOME is the installation directory of the JDK.<br />
To obtain the correct value, use the Windows Explorer.<br />

<img src="https://lh3.googleusercontent.com/-_Xljvd7jGXM/VYDNqvGT5iI/AAAAAAAACMo/vDRhGTv4oZcPRBUVRFZV0gurvWhWo45TwCCo/s496-Ic42/add-JAVA_HOME-System-Variable.png" alt="JAVA_HOME create" /><br />

Choose the "Path" from the "System variables" list.<br />
Click on the "Edit" button.<br />
Add the ";%JAVA_HOME%\bin" behind currnet PATH variable.<br />

<img src="https://lh3.googleusercontent.com/-iOuENrZbFAc/VYDNqqHl9zI/AAAAAAAACMg/BhZ60DJrp1EjfSclW23kNc6-y7fCzcAEgCCo/s493-Ic42/add-jdk-bin-path.png" alt="%JAVA_HOME%\bin added in Path" /><br />
</p>
 
<dl class="note">
<dt>
Semicolons (;) are used to separate the PATH environment variable in Windows OS.  
</dt>
<dt>PATH</dt>
<dd>
OS looks for programs in the PATH directories.<br />
if you add the location of the bin folder of the JDK installation for the PATH variable,
you are able to conveniently run the executables (javac.exe, java.exe, jar.exe, and so on) from any directory 
without having to type the full path of the command, such as:<br />
<b>C:\Users\kim&gt;javac Test.java</b><br />
If you do not set the PATH variable, you need to specify the full path to the executable every time you run it, such as:<br />
<b>C:\Program Files\Java\jdk1.8.0_20\bin&gt;javac C:\Users\kim\Test.java</b><br />
Run <b>echo %PATH%</b> in command prompt to confirm the PATH variable.<br />
</dd>
</dl>

<h2>Test</h2>

<p><em class="filename">Test.java</em></p>
<pre class="prettyprint">
public class Test {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
</pre>

<pre class="screen">
C:\Users\kim&gt;javac Test.java

C:\Users\kim&gt;java Test
Hello World!
</pre>

<dl class="note">
<dt>Test failure checklist</dt>
<dd>
javac Test.java<br />
<span class="emphasis">'javac' is not recognized as an internal or external command, operable program or batch file.</span><br />
Update the PATH Environment Variable<br />
<br />
java Test<br />
<span class="emphasis">Exception in thread "main" java.lang.NoClassDefFoundError: Test</span><br />
This is a message that was not found Test.class file.<br />
When you run "java Test" in the directory where Test.class file does not exist, 
you encounter such an error.<br />
To the class file is executed in the directory that does not exist, 
it is necessary to use the -cp option of java.exe, such as:<br />
<em class="path">C:\javawork&gt;java -cp C:\Users\kim Test</em>
</dd>
</dl>

<h2>Editor</h2>

<p>
Until "Package and Modifiers", 
it is better to use a simple editor such as <a href="https://www.editplus.com/">editPlus</a>.<br />
After you finish the Package and Modifiers, We recommend that you install the eclipse.<br />
</p>

<p><span id="refer">References</span></p>
<ul id="references">
	<li><a href="http://windows.microsoft.com/en-us/windows/32-bit-and-64-bit-windows#1TC=windows-7">32-bit and 64-bit Windows: frequently asked questions</a></li>
	<li><a href="http://www.editplus.com">editplus</a></li>
</ul>
</article>