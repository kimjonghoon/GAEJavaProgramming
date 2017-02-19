<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2014.3.26</div>

<h1>Packages And Access Modifiers</h1>

<h2>Packages</h2>

<p>
Think of the package you use when collecting garbage.<br />
Java provides a package to manage classes with similar features and similar nature.<br />
All of the Java APIs belong to a specific package (usually a package with names beginning with java).<br />
Now let's look at how to make the class we want to create belong to a specific package.<br />
</p>

<em class="filename">BankAccount.java</em>
<pre class="prettyprint">
<strong>package javabank;</strong>

public class BankAccount {
	private String accountNo;
	private long balance;
	
	public void deposit(long amount) {
		balance = balance + amount;
	}
	
	public void withdraw(long amount) {
		balance = balance - amount;
	}
	
	public long getBalance() {
		return balance;
	}
	
	public static void main(String[] args) {
		System.out.println("Package Test!");
	}
}
</pre>

<p>
The first code, package javabank; makes the BankAccount class belong to the javabank package.<br />
When you compile a Java source that declares a package, you must specify a directory after -d followed by a byte code.<br />
If the -d option is omitted, the bytecode is not applied to the package.<br />
Create the BankAccount.java source file in the C:\javaApp\bank\src\javabank directory.<br />

<img src="images/javabank_src_bin.gif" alt="팩키지 예제 디렉토리 구조" style="width: 191px;" /><br />

The bin directory is the directory where the bytecode is located.<br />
The src directory is the directory where the Java source files are located.<br />
If you declare the package, create a subdirectory with the package name in src and place the source there.<br />
Most developers manage the source this way.<br />
</p>

<dl class="note">
<dt>Package names are usually in reverse order of domain name.</dt>
<dd>
Package names are usually in reverse order of domain name.<br />
The package name preferably includes two or more dots.<br />
If you have applied the net.java_school.commons package to the Log class, create the directory and place the source files as shown below.<br />

<pre style="margin-left: 40px;">
src
 └── net
      └── java_school
              └── commons: Log.java
</pre>
</dd>
</dl>

<p>
Let's get back to BankAccount.java.<br />
Go to C:\javaApp\bank\src\javabank and compile as below.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
C:\javaApp\bank\src\javabank&gt;javac -d C:/javaApp/bank/bin BankAccount.java
</pre>

<p>
The path separator following the -d option can also use the / (slash), even on Windows systems.<br />
Of course, you can also use the path separator in the Windows system \ (backslash).<br />
After compiling, go to the C:\java App\bank\bin directory and check whether the bytecode of BankAccount is created.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
C:\javaApp\bank\bin&gt;dir
2008-03-07  12:06  PM    &lt;DIR&gt;          javabank
</pre>

<p>
You will not see the BankAccount.class file in the bin directory, instead you will see the javabank directory.<br />
The BankAccount.class file can be found in this javabank subdirectory.<br />
When you compile BankAccont.java, if you specify the C:\javaApp\bank\bin directory with the -d option.<br /> 
a subdirectory with the same name as the package name is created in the C:\javaApp\bank\bin directory.<br />
BankAccount.class is created in the javabank directory.
</p>

<div class="dtree">
	<script type="text/javascript">
		<!--
		var javabank = new dTree('javabank');
		javabank.add(0,-1,'C:\\javaApp');
		javabank.add(1,0,'bank','javascript:void(0);');
		javabank.add(2,1,'bin','javascript:void(0);');
		javabank.add(3,2,'javabank','javascript:void(0);');
		javabank.add(4,3,'BankAccount.class','src/BankAccount.class');
		javabank.add(5,1,'src','javascript:void(0);');
		javabank.add(6,5,'javabank','javascript:void(0);');
		javabank.add(7,6,'BankAccount.java','src/BankAccount.java');
		document.write(javabank);
		javabank.openAll();
		//-->
	</script>
</div>

<p>
The JVM understands that there is a javabank.BankAccount class in the C:\javaApp\bank\bin directory.<br />
For a class that has a package applied, the fully qualified class name (FQCN) of the BankAccount class is javabank.BankAccount.<br />
To use the BankAccount class in another class, you must write javabank.BankAccount in your code.<br />
The same is true when you run classes.<br />
To run the BankAccount class, you need to run java javabank.BankAccount in the C:\javaApp\javabank\bin directory.<br />
This is because the JVM understands that there is a javabank.BankAccont class in the bin directory.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
C:\javaApp\bank\bin&gt;java javabank.BankAccount
Package Test!
</pre>

<p>
To run a class in a directory that does not have a class, you need to tell the JVM where the class is located.<br />
The way to tell the JVM that the class is located is to use the Java interpreter's classpath<a href="#comments"><sup>1</sup></a> option.<br />
Below is running javabank.BankAccount in the C:\Program Files directory.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
C:\Program Files&gt;java -classpath C:/javaApp/bank/bin javabank.BankAccount
Package Test!
</pre>

<p>
-classpath followed by the path where the class is located.<br />
In the above, classpath is an absolute path.<br />
If the classpath is specified as a relative path, it is as follows.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
C:\Program Files&gt;java -classpath ../javaApp/bank/bin javabank.BankAccount
Package Test!
</pre>

<p>
. Is the current directory.<br />
.. refers to the directory one level above.<br />

The Java compiler javac.exe also has a classpath<a href="#comments"><sup>2</sup></a> option.<br />
The Java compiler uses this option if you have code that uses classes (bytecode) created by other users in the Java source you are trying to compile.<br />
If the class (bytecode) created by another user is in C:\javaApp\commons\bin, you must tell the Java compiler this path.<br />
This is because the Java compiler verifies that the bytecodes used by the source is being used properly.<br />
I will make an example of the above explanation.<br />
For example, we need to create a new class, so we have the following directory structure.<br />
</p>

<div class="dtree">
	<script type="text/javascript">
		<!--
		var classpath = new dTree('classpath');
		classpath.add(0,-1,'C:\\javaApp');
		classpath.add(1,0,'commons','javascript:void(0);');
		classpath.add(2,1,'bin','javascript:void(0);');
		classpath.add(3,2,'net','javascript:void(0);');
		classpath.add(4,3,'java_school','javascript:void(0);');
		classpath.add(5,4,'commons','javascript:void(0);');
		classpath.add(6,5,'Log.class','javascript:void(0)');
		classpath.add(7,1,'src','javascript:void(0);');
		classpath.add(8,7,'net','javascript:void(0);');
		classpath.add(9,8,'java_school','javascript:void(0);');
		classpath.add(10,9,'commons','javascript:void(0);');
		classpath.add(11,10,'Log.java','javascript:void(0)');
		document.write(classpath);
		classpath.openAll();
		//-->
	</script>
</div>

<p>
The following is a new class to create.<br />
</p>

<em class="filename">Log.java</em><a href="#comments"><sup>3</sup></a>
<pre class="prettyprint">
package net.java_school.commons;

public class Log {
	public static void out(String msg) {
		System.out.println(new java.util.Date() + " : " + msg);
	}	
}
</pre>

<p>
Compile Log.java.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">C:\javaApp\commons\src\net\java_school\commons&gt;javac -d ^
C:\javaApp\commons\bin Log.java</pre>

<p>
Next, modify the BankAccont class to use the Log class.<br />
The FQCN of the Log class is net.java_school.commons.Log and should be written to the source as well.<br />
</p>

<pre class="prettyprint">
public void deposit(long amount) {
	balance = balance + amount;
	<strong>net.java_school.commons.Log.out(amount + " dollars have been deposited.");</strong>
	<strong>net.java_school.commons.Log.out("Balance is $ " + this.getBalance());</strong>
}

public void withdraw(long amount) {
	balance = balance - amount;
	<strong>net.java_school.commons.Log.out(amount + " dollars have been withdrawn.");</strong>
	<strong>net.java_school.commons.Log.out("Balance is " + this.getBalance());</strong>
}

public static void main(String[] args) {
	<strong>BankAccount myAccount = new BankAccount();
	myAccount.deposit(10000);
	myAccount.withdraw(500);</strong>
}
</pre>

<p>
Recompile BankAccount.java.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">C:\javaApp\bank\src\javabank&gt;javac -d C:\javaApp\bank\bin ^
-classpath C:\javaApp\commons\bin Account.java</pre>

<p>
Run the javabank.BankAccount.
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">C:\javaApp\bank\bin&gt;java -classpath .;C:\javaApp\commons\bin ^
javabank.Account</pre>

<p>
Our Java programs consist of two classes.<br />
These are the javabank.Account and net.java_school.commons.Log classes.<br />
Because these two classes are located differently, you need to specify the location of the two classes with the classpath option of the Java interpreter.<br />
When the classpath option is used, the JVM looks only for classes where the classpath is set.<br />
So the dot (.), Which means the current directory, is included in the classpath.<br />
</p>

<h3>How to add an external Java library to your Java program</h3>

<p>
Most external Java classes are provided as jar-compressed files.<br />
To deploy the Log class for use by other Java programmers, use jar.exe.<br />
Execute the following command in the directory where Log bytecode is located.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">C:\javaApp\commons\bin&gt;jar cvf java-school-commons.jar .</pre>

<p>
Using the explorer, cut the java-school-commons.jar file created in commons directory and paste it into C:\devLibs.<br />
Run the javabank.Account class.<br />
This time, use the Log class in the java-school-commons.jar file in C:\devLibs.<br />
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">C:\javaApp\bank\bin&gt;java -classpath ^
.;C:\devLibs\java-school-commons.jar javabank.Account</pre> 

<p>
The path to the java-school-commons.jar file must be specified in the classpath.<br />
</p>

<h2>Access Modifiers</h2>

<p>
The access modifiers decide whether it is accessible from the outside.<br />
The access modifiers provides a two-step access control.<br />
Level 1 access control is when the accessor is used in the class declaration.<br />
</p>

<h3>The public access modifier which used in the class declaration part of BankAccount</h3>

<pre class="prettyprint">
package javabank;

<strong>public</strong> class BankAccount {
	//...
} 
</pre>

<h3>The default access modifier which used in the class declaration part of BankAccount</h3>

<pre class="prettyprint">
package javabank;

class Account {
	//...
} 
</pre>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" colspan="2">Level 1 access control: when an access modifier is used in a class declaration</th>
</tr>
<tr>
	<td class="table-in-article-td">public</td>
	<td class="table-in-article-td">It can be referenced in any package classes.</td>
</tr>
<tr>
	<td class="table-in-article-td">default</td>
	<td class="table-in-article-td">It can be referenced in same package classes.</td>
</tr>
</table>

<p>
Below is an example of referring to the javabank.BankAccount class in the example.BankSystem class.<br />
</p>

<pre class="prettyprint">
<strong>package example;</strong>

public class BankSystem {

	//You can declare a parameter of type javabank.BankAccount.
	public void deposit(<strong>javabank.BankAccount</strong> account, long amount) {
		account.deposit(amount);//At this point, the access modifier used in the deposit () method declaration is applied.
	}

}
</pre>

<p>
The following figure shows that all the classes in the javabank package have public access modifiers specified in the class declaration section.<br />
(+ Stands for public)

<img src="images/access_test_public.gif" alt="PUBLIC 접근자 그림" style="width: 590px;" /><br />

Suppose you have created a Bank, Customer with a javabank package like BankAccount.<br />
Any class that belongs to any package can reference Bank, Customer, and BankAccount.<br />
As shown in the figure, the BankSystem in the example package can refer to all classes in the javabank package.<br />
As you can see from the BankSystem source, it means you can declare variables like javabank.BankAccount account.<br />
You can use the import statement to reduce javabank.BankAccount to BankAccount in the class body.<br />
</p>

<pre class="prettyprint">
<strong>package example;</strong>

<strong>import javabank.Account;</strong>

public class BankSystem {

	public void deposit(<strong>BankAccount account</strong>, long amount) {
		account.deposit(amount);
	}

}
</pre>

<p>
Suppose you set a default access modifier in the class declaration of Bank, Customer, and BankAccount.<br />

<img src="images/access_test_default.gif" alt="Default 접근자 그림" style="width: 590px;" /><br />

In this case, the BankSystem class can not refer to Bank, Customer, or Account.<br />
If you try to reference the Bank, Customer, and BankAccount classes in BankSystem, you get a compile error.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" colspan="2">Step 2 Access Control: When an access modifier is used in a field or method declaration</th>
</tr>
<tr>
	<td class="table-in-article-td">public</td>
	<td class="table-in-article-td">The field or method is accessible from all packages.</td>
</tr>
<tr>
	<td class="table-in-article-td">protected</td>
	<td class="table-in-article-td">The field or method is only accessible from the same package.<br />
	In addition, if the packages of the subclass and the superclass are different, the subclasses can access protected fields and methods of the superclass.
	</td>
</tr>
<tr>
	<td class="table-in-article-td">default</td>
	<td class="table-in-article-td">The field or method is only accessible from the same package.</td>
</tr>
<tr>
	<td class="table-in-article-td">private</td>
	<td class="table-in-article-td">It is not accessible from outside the class.</td>
</tr>
</table>

<p>
A field is a data structure declared in a class body.<br />
It's easy to understand if you think everything is not a method in a class body.<br />
A member is a variable that stores the property of an object or a method corresponding to an action of an object.<br />
If public is applied to a field or method, it can be accessed from any package.<br />
If the field or method is private, it can not be accessed from the outside.<br />
The default access modifier is only accessible from the same package.<br />
The protected access modifier is more accessible than the default access modifier.<br />
For the protected access modifier, it's a good idea to review the description below after studying inheritance.<br />
It can be accessed from the same package as the default accessor.<br />
In addition, protected members of the parent class can be accessed from child classes that differ in package from parent.<br />
It should be noted that it is a protected member, not a protected field or method.<br />
In the figure below, # means protected.<br />

<img src="images/access_test_protected.png" alt="Protected 접근자 예 그림" style="width: 590px;" /><br /> 
</p>

<h2>Encapsulation: To access the data of an object, access it only through a method.</h2>

<p>
When designing a class, the following should be kept as it is the basis of object-oriented programming.<br />
This is called encapsulation, which allows you to see only the essential parts of the object when viewed from the outside.<br />
</p>

<ol>
	<li>Declare the member variable as private.</li>
	<li>Declare public setter and getter methods for private member variables</li>
</ol>

<p>
Let's encapsulate the member class of a website.
</p>

<em class="filename">User.java</em>

<pre class="prettyprint">
package net.java_school.user;

public class User {
	private String username;
	private String password;
	private String fullName;
	private String email;
	
	//getters and setters
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFullName() {
		return FullName;
	}
	public void setFullName(String fullName) {
		FullName = fullName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
</pre>

<h2>Eclipse</h2>

<p>
Editors such as Notepad or Edit Plus will no longer be used.<br />
All subsequent chapter examples will use Eclipse.<br />
With Eclipse, you can manage your sources with the directory structure you have practiced above and you do not have to worry about the classpath when compiling.<br />
Download the Eclipse IDE for Java EE Developers from <a href="http://www.eclipse.org/downloads/">http://www.eclipse.org/downloads/</a>.<br />
Unzip and copy the generated eclipse folder and paste it to the desired location.<br />
Assume that you have pasted the eclipse folder into C:\.<br />
</p>

<h3>Run</h3>

<p>
Run C:/eclipse/eclipse.exe to launch Eclipse.<br />
Eclipse asks you where to specify your workspace.<br />
<img src="https://lh6.googleusercontent.com/-KuW40dO62II/TjJ6CM4LOrI/AAAAAAAAAX0/yXp6FWCapbM/workspace_launcher.gif" alt="workspace launcher" /><br />

Workspaces contain and manage one or more projects.<br />
Do not select the workspace as the default directory as shown above.<br />
Also, do not check Use this as default and do not ask again.<br />
It may be convenient to have multiple workspaces to manage projects of different characteristics.<br />
In this example, the workspace is set to C:\javawork.<br />
If you specify it and click the OK button, you can see the following welcome message.<br />

<img src="https://lh5.googleusercontent.com/-Ewvv_Kxiuis/TjJ6B5bj7FI/AAAAAAAAAXs/fulrpOzQ58I/welcome.gif" alt="welcome" /><br />

For reference, this article summarizes the welcome page tutorial.<br />
Closes the welcome page.<br />
the following workbench appears.<br />

<img src="https://lh5.googleusercontent.com/-lHZAcz_vsOU/TjJ6Byjr2BI/AAAAAAAAAXw/6Gk1YbZ1ytk/workbench.gif" alt="workbench" />
</p>

<h3>Eclipse Terminology</h3>

<p>
<strong>Workbench</strong><br />
</p>

<p style="padding-left: 14px;">
It refers to the entire window seen in Eclipse.<br />
A window is divided into four areas, which are called views.<br />
</p>

<strong>Perspective</strong><br />
<p style="padding-left: 14px;">
Including all of the views is called a perspective.<br />
The above screen is a Java perspective.<br />
This perspective consists of the views needed to develop a Java program.<br />
To change the perspective, use the Open Perspective menu bar button in the top right corner.<br />
</p>

<strong>Package Explorer View</strong><br />
<p style="padding-left: 14px;">
The top left view shows the resources (packages, classes, external libraries) belonging to the Java project.
</p>

<strong>Hierarchy View</strong><br />
<p style="padding-left: 14px;">
The upper-left view shows Java's inheritance structure.
</p>

<strong>Outline View</strong><br />
<p style="padding-left: 14px;">
The view at the top right shows the structure of the source file in the editor.
</p>

<strong>Editor View</strong><br />
<p style="padding-left: 14px;">
It is used to edit the source code in the view located in the center of the screen.
</p>

<strong>Problems View</strong><br />
<p style="padding-left: 14px;">
Show compilation errors or warnings at the bottom of the view.
</p>


<strong>Javadoc View</strong><br />
<p style="padding-left: 14px;">
The view at the bottom shows the Java document for the selected part in the Package Explorer or Outline view.
</p>

<strong>Declaraion View</strong><br />
<p style="padding-left: 14px;">
The view at the bottom shows briefly how the selected part of the editor is declared.
</p>	

<p>
You can change the position of the view to the desired position with the mouse.<br />
But it is good to leave it until you get used to it.<br />
</p>

<h3>Practice the Java example using Eclipse</h3>

<p>
Make sure it is a Java perspective.<br />
In Eclipse, the Java source must belong to the project.<br />
To create a Java project, select File - New - Java Project from the menu bar or click the leftmost button on the toolbar as shown below.<br />
<img src="https://lh5.googleusercontent.com/-5W4KIyzc7G8/TjJ6Bg9McGI/AAAAAAAAAXo/p2kJo0YJEv4/toolbar.gif" alt="toolbar" style="width: 73px;" /><br />

Name the project HelloWorld.<br />
Other settings do not have to be specified.<br />
Eclipse is managed by storing the source in the src directory and the compiled binaries in the bin directory.<br />
Click Finish and the HelloWorld project will be created and displayed in the Package Explorer.<br />

<img src="https://lh4.googleusercontent.com/-8Tx99HODIdg/TjJ6A_ribLI/AAAAAAAAAXc/5xSvGBauvwc/s576/project_wizard.gif" alt="project wizard" /><br />

Click second on the toolbar menu below.<br />
<img src="https://lh5.googleusercontent.com/-5W4KIyzc7G8/TjJ6Bg9McGI/AAAAAAAAAXo/p2kJo0YJEv4/toolbar.gif" alt="toolbar" style="width: 73px;" /><br />

Type net.java_school.example in the package name and click Finish.<br />
You should now see the package in the Package Explorer view.<br />

<img src="https://lh4.googleusercontent.com/-B5K99iKod5g/TjJ6AgcfJsI/AAAAAAAAAXY/yJU3KnGQQIU/package_wizard.gif" alt="package wizard" /><br />

With the mouse selected in the Package Explorer in the net.java_school.example package, click the last button on the right of the toolbar menu below.<br />

<img src="https://lh5.googleusercontent.com/-5W4KIyzc7G8/TjJ6Bg9McGI/AAAAAAAAAXo/p2kJo0YJEv4/toolbar.gif" alt="toolbar" style="width: 73px;" /><br />

Enter HelloWorld as the class name.<br />
Check the public static void main (String [] args), because the main method is required.<br />

<img src="https://lh5.googleusercontent.com/-zy_swhmGj48/TjJ6AklwKJI/AAAAAAAAAXQ/-GWHhhwRugA/class_wizard.gif" alt="class wizard" /><br />

Click on Finish and implement the main method in the editor as shown below.<br />
</p>

<em class="filename">HelloWorld.java</em>
<pre class="prettyprint">
package net.java_school.example;

public class HelloWorld {

   public static void main(String[] args) {
      <strong>System.out.println("Hello World !");</strong>
   }

}
</pre>

<p>
If you save, you do not have to compile.<br />
This is because Eclipse continues to compile in the background.<br />
Here's why you can see compilation errors right from the editor.<br />
To run the class, right-click the HelloWorld class in the Package Explorer, open the context menu, and select it as shown below.<br />

<img src="https://lh4.googleusercontent.com/-GQgOXNx6En4/TjJ6BuiXmTI/AAAAAAAAAXk/k3fGHc_rrYs/run.gif" alt="run" /><br />

A console view is displayed and Hello World!

<img src="https://lh5.googleusercontent.com/-xC4-RE1ObLk/TjJ6Atp4agI/AAAAAAAAAXU/9fcwiLYVlH4/console_view.gif" alt="console view" />
</p>

<hr />

<span id="comments">Comments</span>
<ol>
	<li>When you run the Java interpreter (java), the class loader
The classpath finds all the class information that makes up the Java program and loads it into the memory space.<br />
At this time, if it can not find even one class, it prints an error message that the execution fails and the class can not be found.<br />
If you do not specify the classpath option, the class loader looks for the class you created in the current directory.<br />
The path to the Java API, such as the java.lang.String class or the java.lang.System class, is already known by the class loader
It is not specified in the classpath.</li>
	<li>The classpath option of javac or java can be replaced with the cp option.</li>
	<li>The out method of the Log class is a static method, and the description of the static keyword is covered in <a href="Static">static</a>.</li>
</ol>
</article>