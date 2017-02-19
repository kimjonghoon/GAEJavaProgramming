<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<article>
<div class="last-modified">Last Modified 2017.2.3</div>

<h1>Stream</h1>

<p>
In Java, input and output are done through streams.
If the stream comes into the Java program, it is an input stream.
If the stream goes out of the Java program, it is an output stream.

The important information when creating a stream object is the source for the input stream and the destination for the output stream.
You need this information as an argument to the stream constructor.

The shape of the source or destination varies.
For example, there may be a file, a console screen, or a socket.
There are a lot of stream classes, and understanding the following classifications can help you understand the whole.
</p>

<ul>
	<li>Is it a byte stream? Is it a character stream?</li>
	<li>Is it an input stream? Is it an output stream?</li>
	<li>Do it actually do I/O? Does it help with I/O performance?</li>
</ul>

<h2>Byte Stream</h2>

<p>
The byte stream is input and output in units of 1 byte.
It is generally used for I/O to binary files such as videos or images.
InputStream and OutputStream are abstract classes and are the top-level classes of all byte stream classes.
</p>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">InputStream</dt>
	<dd class="api-summary-dd">int read()</dd>
	<dd class="api-summary-dd-method-desc">This method is an abstract method.It reads one byte from the input stream and returns a value between 0 and 255.
	It returns -1 if the end of the input stream has been reached and can no longer be read.</dd>
	<dd class="api-summary-dd">int read(byte[] b)</dd>
	<dd class="api-summary-dd-method-desc">In most cases, it reads up to the size of b, stores it in b, and returns the number of bytes read.
	It returns -1 if the end of the input stream has been reached and can no longer be read.</dd>
	<dd class="api-summary-dd">int read(byte[] b, int off, int len)</dd>
	<dd class="api-summary-dd-method-desc">It reads up to the size of len, stores it in the off position of b, and returns the number of bytes read.
	It returns -1 if the end of the input stream has been reached and can no longer be read.</dd>
	<dd class="api-summary-dd">int available()</dd>
	<dd class="api-summary-dd-method-desc">It returns the number of bytes that can be read.</dd>
	<dd class="api-summary-dd">void close()</dd>
	<dd class="api-summary-dd-method-desc">It closes the input stream and returns the system resources associated with the stream.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">OutputStream</dt>
	<dd class="api-summary-dd">void write(int b)</dd>
	<dd class="api-summary-dd-method-desc">It outputs the low 8 bits of b.</dd>
	<dd class="api-summary-dd">void write(byte[] b)</dd>
	<dd class="api-summary-dd-method-desc">It outputs the contents of b.</dd>
	<dd class="api-summary-dd">void write(byte[] b, int off, int len)</dd>
	<dd class="api-summary-dd-method-desc">It outputs len bytes from the off position of b.</dd>
	<dd class="api-summary-dd">void flush()</dd>
	<dd class="api-summary-dd-method-desc">It outputs the remaining bytes in the buffer.</dd>
	<dd class="api-summary-dd">void close()</dd>
	<dd class="api-summary-dd-method-desc">It closes the output stream and returns the system resources associated with the stream.</dd>
</dl>

<em class="filename">Test.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.FileInputStream;

public class Test {

	public static void main(String[] args) throws Exception {
		int n = 0;
		FileInputStream fis = new FileInputStream("C:/javaApp/test.txt");
		while ((n = fis.available()) &gt; 0) {
			byte[] b = new byte[n];
			int result = fis.read(b);
			if (result == -1) {
				break;
			}
			String s = new String(b);
			System.out.println(s);
		}
		fis.close();
	}

}
</pre>

<p>
Test with the following file:
</p>

<em class="filename">test.txt</em>
<pre class="prettyprint">
a b c d e
1 2 3 4 5
</pre>

<p>
The following is an example of creating a copy file.
</p>

<em class="filename">Test.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.FileInputStream;
<strong>import java.io.FileOutputStream;</strong>
import java.io.IOException;

public class Test {

	public static void main(String[] args) throws IOException {
		int n = 0;
		FileInputStream fis = new FileInputStream("C:/javaApp/test.txt");
		<strong>FileOutputStream fos = new FileOutputStream("C:/javaApp/testCopy.txt", false);</strong>
		
		while ((n = fis.available()) &gt; 0) {
			byte[] b = new byte[n];
			int result = fis.read(b);
			if (result == -1) {
				break;
			}
			<strong>fos.write(b);</strong>
		}
		fis.close();
		<strong>fos.close();</strong>
		
	}

}
</pre>

<p>
FileInputStream/FileOutputStream is a class for file I/O in bytes.
</p>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">FileInputStream's Constructors</dt>
	<dd class="api-summary-dd">FileInputStream(File <em>file</em>)</dd>
	<dd class="api-summary-dd-method-desc">Creates an input stream for the file specified by <em>file</em>.</dd>
	<dd class="api-summary-dd">FileInputStream(String <em>name</em>)</dd>
	<dd class="api-summary-dd-method-desc">Creates an input stream for the file specified by <em>name</em>.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">FileOutputStream's Constructors</dt>
	<dd class="api-summary-dd">FileOutputStream(File <em>file</em>)</dd>
	<dd class="api-summary-dd-method-desc">Creates an output stream for the file specified by <em>file</em>.</dd>
	<dd class="api-summary-dd">FileOutputStream(File <em>file</em>, boolean <em>append</em>)</dd>
	<dd class="api-summary-dd-method-desc">Creates an output stream for the file specified by <em>file</em>. If <em>append</em> is true, the output stream append the contents to the end of the file's contents.</dd>
	<dd class="api-summary-dd">FileOutputStream(String <em>name</em>)</dd>
	<dd class="api-summary-dd-method-desc">Creates an output stream for the file specified by <em>name</em>.</dd>
	<dd class="api-summary-dd">FileOutputStream(String <em>name</em>, boolean <em>append</em>)</dd>
	<dd class="api-summary-dd-method-desc">Creates an output stream for the file specified by <em>name</em>. If <em>append</em> is true, the output stream append the contents to the end of the file's contents.</dd>
</dl>

<p>
In the new FileOutputStream ("C:/javaApp/test.txt", <em>false</em>); <em>false</em> overwrites the existing contents.
The methods of the FileInputStream and FileOutputStream used in the examples are described in the InputStream and OutputStream method descriptions.
</p>

<h2>Character Stream</h2>

<p>
<!-- 
<img src="https://lh4.googleusercontent.com/-6xNIYh4BAfo/UrREJcHeK7I/AAAAAAAABhs/2U_pBrm-C-Q/w590-h555-no/CharacterStream.jpg" alt="Character Stream" />
-->
Reader and Writer are the top-level classes of the character input and output classes.
All are abstract classes, and the unit of input and output data in the method is a character.
</p>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">Reader</dt>
	<dd class="api-summary-dd">int read()</dd>
	<dd class="api-summary-dd-method-desc">It reads one single character and returns the Unicode value of the character.</dd>
	<dd class="api-summary-dd">int read(char[] <em>b</em>)</dd>
	<dd class="api-summary-dd-method-desc">It reads a character as many as the size of array <em>b</em>, stores it in b, and returns the number of characters read.</dd>
	<dd class="api-summary-dd">abstract int read(char[] b, int off, int len)</dd>
	<dd class="api-summary-dd-method-desc">It reads a character as many as the size of len and returns the number of characters read.</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">Writer</dt>
	<dd class="api-summary-dd">void write(String <em>s</em>)</dd>
	<dd class="api-summary-dd-method-desc">It outputs <em>s</em>.</dd>
	<dd class="api-summary-dd">void write(char[] <em>b</em>)</dd>
	<dd class="api-summary-dd-method-desc">It outputs <em>b</em>.</dd>
	<dd class="api-summary-dd">void write(char[] <em>b</em>, int <em>off</em>, int <em>len</em>)</dd>
	<dd class="api-summary-dd-method-desc">It outputs characters as many as size of <em>len</em> from the <em>off</em> index of array <em>b</em>.</dd>
	<dd class="api-summary-dd">void write(String <em>s</em>, int <em>off</em>, int <em>len</em>)</dd>
	<dd class="api-summary-dd-method-desc">It outputs characters as many as size of <em>len</em> from the <em>off</em> index of String <em>s</em>.</dd>
</dl>

<em class="filename">Test2.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.FileReader;
import java.io.FileWriter;

public class Test2 {

	public static void main(String[] args) throws Exception {
		int n = 0;
		FileReader fr = new FileReader("C:/javaApp/test.txt");
		FileWriter fw = new FileWriter("C:/javaApp/testCopy.txt", false);
		while ((n = fr.read()) != -1) {
			fw.write(n);
		}
		fr.close();
		fw.close();
	}

}
</pre>

<h3>BufferedReader/BufferedWriter</h3>

<p>
BufferedReader/BufferedWriter provides a buffering function for character I/O.
</p>

<em class="filename">Test2.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;

public class Test {

	public static void main(String[] args) throws Exception {
		FileReader fr = new FileReader("C:/javaApp/test.txt");
		BufferedReader br = new BufferedReader(fr);
		String s = null;
		FileWriter fw = new FileWriter("C:/javaApp/testCopy2.txt", false);
		BufferedWriter bw = new BufferedWriter(fw);
		while ((s = br.readLine()) != null) {
			bw.write(s);
			bw.newLine();
		}
		fr.close();
		br.close();
		bw.close();
		fw.close();
	}

}
</pre>

<h3>InputStreamReader/OutputStreamWriter</h3>

<p>
An InputStreamReader is a bridge from byte streams to character streams: It reads bytes and decodes them into characters using a specified charset.<br />
For more information, please visit <a href="https://docs.oracle.com/javase/8/docs/api/java/io/InputStreamReader.html">this</a>.<br /> 
An OutputStreamWriter is a bridge from character streams to byte streams: Characters written to it are encoded into bytes using a specified charset.<br />
For more information, please visit <a href="https://docs.oracle.com/javase/8/docs/api/java/io/OutputStreamWriter.html">this</a>.
</p>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">InputStreamReader's Constructor</dt>
	<dd class="api-summary-dd">InputStreamReader(InputStream in)</dd>
	<dd class="api-summary-dd">InputStreamReader(InputStream in, String enc)</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">OutputStreamWriter's Constructor</dt>
	<dd class="api-summary-dd">OutputStreamWriter(OutputStream out)</dd>
	<dd class="api-summary-dd">OutputStreamWriter(OutputStream out, String enc)</dd>
</dl>

<p>
The following example uses InputStreamReader to convert bytes input from the keyboard to characters.
</p>

<em class="filename">InputTest.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.*;

public class InputTest {
	public static void main(String[] args) throws IOException {
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String input = br.readLine();
		System.out.println("Input: " + input); 
	}
}
</pre>

<p>
The example creates an InputStreamReader with the keyboard as the source.
In Java, the keyboard is represented by System.in.

Then create a BufferedReader object for the buffer function.
At this time, the reference value of InputStreamReader is passed as the argument to the BufferedReader's constructor.

String input = br.readLine(); waits for user input.

The BufferedReader's readLine () method returns a string until the user hits the Enter.
The Enter is not included in the string.

The string is returned and assigned to the input variable.
and the input value is checked by the standard output method on the last line.
Find and confirm the BufferedReader in the Java documentation.

The last line of code prints the value assigned to input.

For more information about the BufferedReader, please visit <a href="https://docs.oracle.com/javase/8/docs/api/java/io/BufferedReader.html">this</a>.

</p>

<p>
The following example prints character data to a file.
</p>
<em class="filename">OutputTest.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.*;

public class OutputTest {
	public static void main(String[] args) {
		FileWriter fw = null;
		try {
			fw = new FileWriter("C:/output.txt", true);
			fw.write("TEST");
			fw.flush();
		} catch(IOException e) {
			e.printStackTrace();
		} finally {
			try {
				<strong>fw.close();</strong>
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
</pre>

<p>
The FileWriter class is used to output character data to a file.
In the FileWriter class constructor, the first argument is the destination, and the second argument is a flag that determines whether to keep the existing contents in the file. 
If true, leave the existing contents intact.
It is important to close the output stream.
fw.close(); closes the output stream.
</p>

<em class="filename">SubtitleToText.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class SubtitleToText {
	
	public static void main(String[] args) throws IOException {
		FileReader fr = null;
		FileWriter fw = null;
		BufferedReader br = null;
		BufferedWriter bw = null;
		
		if (args.length &gt;= 2) {
			try {
				fr = new FileReader(args[0]);
				br = new BufferedReader(fr);
				fw = new FileWriter(args[1], false);
				bw = new BufferedWriter(fw);
				String s = null;
				while ((s = br.readLine()) != null) {
					try {
						Integer.parseInt(s);
					} catch (NumberFormatException e) {
						if (!s.contains("-&gt;")) {
							bw.write(s);
							bw.newLine();
						}
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (fr != null) {
						fr.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				try {
					if (br != null) {
						br.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				try {
					if (bw != null) {
						bw.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				try {
					if (fw != null) {
						fw.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	} 
}
</pre>

<em class="filename">URLTest.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;

public class URLTest {

	public static void main(String[] args) {
		String url = "http://www.java-school.net";
		String file = "index.html";
		InputStream in = null;
		BufferedReader br = null;
		FileOutputStream fos = null;
		BufferedWriter bw = null;
		try {
			in = (new URL(url)).openStream();
			br = new BufferedReader(new InputStreamReader(in));
			fos = new FileOutputStream(file);
			bw = new BufferedWriter(new OutputStreamWriter(fos));
			String str = null;
			while ((str = br.readLine()) != null) {
				bw.write(str);
				bw.newLine();
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (bw != null) {
				try {
					bw.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
</pre>

<h2>Object Stream</h2>

<p>
The following is an example of an object stream.
A serialization process is required to pass an object through a file or network.
A deserialization process is required to reconstruct an object from a file or an object stream passed over the network.
The example stores object information in a file, and creates an object from the file where object information is stored. 
</p>

<em class="filename">Address.java</em>
<pre class="prettyprint">
package net.java_school.serial;

import java.io.Serializable;

public class Address <strong>implements Serializable</strong> {

	private static final long serialVersionUID = -201008311558L;
	private String mobile;
	private String address;
	
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
</pre>

<p>
If the Address object is to be serialized and stored in a file in a stream, the Address class must declare that it implements the Serializable interface.
<em>public class Address implements Serializable</em>
The Serializable interface does not have a method to implement.
The Serializable interface only tells the virtual machine that objects created from the class are serialized.
Such an interface is called a declarative interface.

Java's primitive data types do not require serialization, and many popular classes such as String and Collection are serializable.
These classes have implements Serializable in the class declaration.
If the class we want to create needs serialization, we need implements Serializable in the class declaration.
</p>

<em class="filename">Backup.java</em>
<pre class="prettyprint">
package net.java_school.serial;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;

public class Backup {
	public static void main(String[] args) {
		ObjectOutputStream out = null;
		try {
			out = new ObjectOutputStream(new FileOutputStream("address.txt"));
			Address addr = new Address();
			addr.setMobile("212-963-4475");
			addr.setAddress("760 United Nations Plaza, Manhattan, New York City");
			out.writeObject(addr);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
</pre>

<p>
The Backup class creates an Address object and stores it in a file.
We used ObjectOutputStream to create the object stream and FileOutputStream to store the Address object in the file.
</p>

<p>
The following example creates an object from the object information stored in a file.
</p>

<em class="filename">Recovery.java</em>
<pre class="prettyprint">
package net.java_school.serial;

import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;

public class Recovery {
	public static void main(String[] args) {
		ObjectInputStream in = null;
		try {
			in = new ObjectInputStream(new FileInputStream("address.txt"));
			while(true) {
				Address addr = (Address) in.readObject();
				System.out.println(addr.getMobile());
				System.out.println(addr.getAddress());
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (EOFException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
</pre>

<p>
This example creates an object of the same content from the object information stored in the address.txt file and puts it in the heap memory.
This example uses a FileInputStream to read bytes from a file.
This example uses an ObjectInputStream for an object stream coming into a Java program.
Serialization is necessary to understand RMI basic concepts.
</p>

<h2>Apply to Stream to Javabank Example</h2>

<p>
Create and test a new class called BankUi as shown below.
</p>

<pre class="prettyprint">
package net.java_school.bank;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class BankUi{
	
	public static void main(String[] args) throws IOException {
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String input = <strong>br.readLine();</strong>
		System.out.println("Input: " + input);
	}

}
</pre>

<h3>TODO</h3>

<p>
Change the BankUi as shown below and implement the TODO part.
</p>

<pre class="prettyprint">
package net.java_school.bank;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class BankUi {

    private Bank bank = new ShinhanBank();

    private String readCommandLine() throws IOException {
        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader(isr);
        String input = br.readLine();
        return input;
    }

    public void startWork() {
        String menu = null;

        do {
            System.out.println(" ** Menu ** ");
            System.out.println(" 1 ** Bank account registration    ");
            System.out.println(" 2 ** List of bank accounts    ");
            System.out.println(" 3 ** Deposit    ");
            System.out.println(" 4 ** Withdrawal    ");
            System.out.println(" 5 ** Transfer    ");
            System.out.println(" 6 ** Transaction history    ");
            System.out.println(" q ** Exit    ");
            System.out.println(" ********************** ");
            System.out.print("&gt;&gt;");
            
            try {
            		
                menu = readCommandLine();

                if (menu.equals("1")) {
                    //TODO Bank account registration
                } else if (menu.equals("2")) {
                    //TODO List of bank accounts
                } else if (menu.equals("3")) {
                    //TODO Deposit
                } else if (menu.equals("4")) {
                    //TODO Withdrawal
                } else if (menu.equals("5")) {
                    //TODO Transfer
                } else if (menu.equals("6")) {
                    //TODO Transaction history
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            System.out.println();
        } while (!menu.equals("q"));

    }

    public static void main(String[] args) {
        BankUi ui = new BankUi();
        ui.startWork();
    }
	
}
</pre>

<p>

Implement all //TODO parts and test them thoroughly.
The Java bank program has evolved into an interactive program, but once the program ends, 
accounts and transaction history disappear as before.
You can save your account and transaction history in the following ways:
</p>

<ol>
	<li>Save the bank object to a file.</li>
	<li>Save the account and transaction history to a text file.</li>
	<li>Save the account and transaction history to Database.</li>
</ol>

<h3>1. How to save a bank object to a file using an object stream.</h3>

<p>
To save an object to the file system, the object must be a serializable object.
Modify the Bank, Account, and Transaction classes as shown below.
</p>

We need <em>import java.io.Serializable;</em> statement.
 
<pre class="prettyprint">
public interface Bank <strong>extends Serializable</strong> {
</pre>

<pre class="prettyprint">
public abstract class Account <strong>implements Serializable</strong> {
</pre>


<pre class="prettyprint">
public class Transaction <strong>implements Serializable</strong> {
</pre>

<p>
The scenario is as follows.
When the program starts, 
it de-serializes the bank object information stored in the bank.ser file and loads the bank object into the heap memory.
If this is the first time you are running the program after the modification and the bank.ser file is not created, a FileNotFoundException will be generated.
When a FileNotFoundException occurs, call the bank class's constructor to create the bank object and assign the bank reference to the bank variable.
At the end of the program, the bank object information is stored in the bank.ser file.
</p>

<p>
Add the following method to the BankUi class.
</p>

<pre class="prettyprint">
public void loadBank() throws Exception {
    try {
        ObjectInputStream in = null;
        in = new ObjectInputStream(new FileInputStream("bank.ser"));
        bank = (Bank) in.readObject();
        in.close();
    } catch (FileNotFoundException e) {
        bank = new ShinhanBank();
    } 
}
</pre>

<pre class="prettyprint">
public void saveBank() throws Exception {
    ObjectOutputStream out = null;
    out = new ObjectOutputStream(new FileOutputStream("bank.ser"));
    out.writeObject(bank);
    out.close();
}
</pre>

<em class="filename">BankUi.java</em>
<pre class="prettyprint">
<strong>
private Bank bank;

public BankUi() throws Exception {
    loadBank();
}
</strong>
public static void main(String[] args) <strong>throws Exception</strong> {
    BankUi ui = new BankUi();
    ui.startWork();
    <strong>ui.saveBank();</strong>
}
</pre>

<h3>2. How to save your account and transaction history to a text file.</h3>

<p>
Before looking at the code hints for saving to a text file, let's first look at the File class.
What you can do with the File class is as follows.
</p>

<ul>
	<li>See the contents of the directory.</li>
	<li>Get the attributes of the file.</li>
	<li>Rename or delete the file.</li>
</ul>

<p>
Note that the File class does not have I/O capabilities for files.
</p>

<p>
File dir = new File(path);<br />
The above code snippet creates a file object.
The file or directory corresponding to path must be the full path of the system.
</p>

<p>
The following are the important methods of the File class.
</p>
<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">File</dt>
	<dd class="api-summary-dd">isDirectory() : boolean</dd>
	<dd class="api-summary-dd-method-desc">dir.isDirectory(); //Returns true if dir is a directory.</dd>
	<dd class="api-summary-dd">isFile() : boolean</dd>
	<dd class="api-summary-dd-method-desc">dir.isFile(); //Returns true if dir is a file.</dd>
	<dd class="api-summary-dd">list() : String[]</dd>
	<dd class="api-summary-dd-method-desc">dir.list(); //If dir is a directory, return the file names in the directory as String[].</dd>
	<dd class="api-summary-dd">listFiles() : File[]</dd>
	<dd class="api-summary-dd-method-desc">dir.listFiles(); //Returns an array of file objects for files in the directory.</dd>
	<dd class="api-summary-dd">mkdir() : boolean</dd>
	<dd class="api-summary-dd-method-desc">dir.mkdir(); //Create a directory with the name of the File object.</dd>
	<dd class="api-summary-dd">getName() : String</dd>
	<dd class="api-summary-dd-method-desc">Return file name.</dd>
	<dd class="api-summary-dd">getPath() : String</dd>
	<dd class="api-summary-dd-method-desc">Return path.</dd>
	<dd class="api-summary-dd">delete() : boolean</dd>
	<dd class="api-summary-dd-method-desc">Delete file.</dd>
	<dd class="api-summary-dd">exists() : boolean</dd>
	<dd class="api-summary-dd-method-desc">Returns true if the file or directory exists, false if not.</dd>
</dl>

<p>
For more information, please visit:<br />
<a href="https://docs.oracle.com/javase/8/docs/api/java/io/File.html">https://docs.oracle.com/javase/8/docs/api/java/io/File.html</a>
</p>

<p>
The account information will be stored in a file named accounts.txt.
The format of the stored account information is as follows.
</p>

<pre class="prettyprint">
101|Alison|10000|Normal
202|Bill|5000|Normal
303|Carol|0|Normal
404|Alison|0|Minus
</pre>

<p>
Open the Account.java file and modify the toString () method as follows:
</p>

<pre class="prettyprint">
@Override
public String toString() {
	StringBuffer sb = new StringBuffer();
	sb.append(accountNo);
	sb.append("|");		
	sb.append(name);
	sb.append("|");
	<strong>sb.append(balance);</strong>
	sb.append("|");
	sb.append(kind);

	return sb.toString();
}
</pre>

<p>
The transaction history will be stored in a file with the same name as the account number.
The format of the transaction history information stored is as follows.
</p>

<pre class="prettyprint">
2014/5/1|09:33:30|D|10000|10000
2014/5/3|09:33:30|W|6000|4000
</pre>

<p>
Open the Transaction.java file and modify the toString() method as follows:
</p>

<pre class="prettyprint">
@Override
public String toString() {
	StringBuilder sb = new StringBuilder();
	sb.append(this.transactionDate);
	sb.append("|");
	sb.append(this.transactionTime);
	sb.append("|");
	sb.append(this.kind);
	sb.append("|");
	<strong>sb.append(this.amount);</strong>
	sb.append("|");
	<strong>sb.append(this.balance);</strong>

	return sb.toString();
}
</pre>

<p>
Open BankUi.java and modify the code referring to the following.
</p>

<pre class="prettyprint">
<strong>
static final String ACCOUNT_FILE = "accounts.txt";
static final String DATA_DIR = "./data/";
</strong>
private Bank bank = <strong>new ShinhanBank();
/*	
public BankUi() throws Exception {
    loadBank();
}
*/</strong>	

public static void main(String[] args) throws Exception {
    BankUi ui = new BankUi();
    ui.startWork();
    <strong>//ui.saveBank();</strong>
}
</pre>

<p>
When the program starts, it reads the account information from the accounts.txt file and loads the account object.
If you work in Eclipse, you need to create a data folder in the project root directory and create an empty file named accounts.txt in the folder.
</p>

<pre class="prettyprint">
FileReader fr = null;
fr = new FileReader(DATA_DIR + BankUi.ACCOUNT_FILE);
BufferedReader br = new BufferedReader(fr);
String str = null;

while ((str = br.readLine()) != null) {
    StringTokenizer st = new StringTokenizer(str, "|");
    String accountNo = st.nextToken();
    String name = st.nextToken();
    long balance = Long.parseLong(st.nextToken());
    String kind = st.nextToken();

    if (kind.equals(Account.NORMAL)) {
        bank.addAccount(accountNo, name, balance, Account.NORMAL);
    } else if (kind.equals(Account.MINUS)) {
        bank.addAccount(accountNo, name, balance, Account.MINUS);
    }
}

br.close();
</pre>

<p>
When you start the program, you load the transaction history object from each transaction history file and bind it with the account object.
</p>

<pre class="prettyprint">
File dir = new File(BankUi.DATA_DIR);
File[] files = dir.listFiles();
FileReader fr = null;
BufferedReader br = null;

for (File file : files) {
    if (file.isFile()) {

        String fileName = file.getName();

        if (!fileName.equals(BankUi.ACCOUNT_FILE)) {
            fr = new FileReader(BankUi.DATA_DIR + fileName);
            br = new BufferedReader(fr);
            List&lt;Transaction&gt; transactions = new ArrayList&lt;Transaction&gt;();
            String str = null;

            while ( (str = br.readLine()) != null) {
                StringTokenizer st = new StringTokenizer(str, "|");
                String day = st.nextToken();
                String time = st.nextToken();
                String kind = st.nextToken();
                long amount = Long.parseLong(st.nextToken());
                long balance = Long.parseLong(st.nextToken());
                transactions.add(new Transaction(day,time,kind,amount,balance));
            }

            Account account = bank.getAccount(fileName);

            if (account != null) {
                account.setTransactions(transactions);
            }
        }
    }
} 		
</pre>

<p>
When the program ends, the account and transaction details are saved.
</p>

<pre class="prettyprint">
StringBuilder sbForAccounts = new StringBuilder();
List&lt;Account&gt; accounts = bank.getAccounts();

for (Account account : accounts) {
    sbForAccounts.append(account);
    sbForAccounts.append(System.getProperty("line.separator"));
    StringBuilder sbForTransactions = new StringBuilder();
    List&lt;Transaction&gt; transactions = account.getTransactions();

    for (Transaction transaction : transactions) {
        sbForTransactions.append(transaction);
        sbForTransactions.append(System.getProperty("line.separator"));
    }

    FileWriter fw = new FileWriter(BankUi.DATA_DIR + account.getAccountNo(), false);
    BufferedWriter bw = new BufferedWriter(fw);
    bw.write(sbForTransactions.toString());
    bw.close();
}

FileWriter fw = null;
BufferedWriter bw = null;
fw = new FileWriter(DATA_DIR + BankUi.ACCOUNT_FILE, false);
bw = new BufferedWriter(fw);
bw.write(sbForAccounts.toString());
bw.close();		
</pre>

<p>
Saving to the database is described in the JDBC chapter.
</p>

<em class="filename">BankUi.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class BankUi {

	static final String ACCOUNT_FILE = "accounts.txt";
	static final String DATA_DIR = "./data/";
	
	private Bank bank = new ShinhanBank();
/*	
	public BankUi() throws Exception {
		loadBank();
	}
*/	
	private String readCommandLine() throws IOException {
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String input = br.readLine();
		return input;
	}
	
	public void startWork() {
			
		String menu = null;
		
			do {
				System.out.println(" ** Menu ** ");
				System.out.println(" 1 ** Bank account registration    ");
				System.out.println(" 2 ** List of bank accounts    ");
				System.out.println(" 3 ** Deposit    ");
				System.out.println(" 4 ** Withdrawal    ");
				System.out.println(" 5 ** Transfer    ");
				System.out.println(" 6 ** Transaction history    ");
				System.out.println(" q ** Exit    ");
				System.out.println(" ********************** ");
				System.out.print("&gt;&gt;");
				
				try {
					menu = readCommandLine();
				
					String accountNo = null;
					String name = null;
					String kind = null;
					long amount = 0;
					
					if (menu.equals("1")) {
						//TODO Bank account registration
						System.out.print("Please enter the number of the account to be created: ");
						accountNo = this.readCommandLine();
						System.out.print("Please enter the owner name of the account to be created: ");
						name = this.readCommandLine();
						System.out.print("Please select the account type to be created. Normal(n), Minus(m):  Normal(n): : ");
						kind = this.readCommandLine();
						if (kind.equals("") || kind.equals("n") || kind.equals("m")) {
							if (kind.equals("")) {
								kind = Account.NORMAL;
							} else if (kind.equals("n")) {
								kind = Account.NORMAL;
							} else {
								kind = Account.MINUS;
							}
							bank.addAccount(accountNo, name, kind);
						}
						
					} else if (menu.equals("2")) {
						//TODO List of bank accounts
						List&lt;Account&gt; accounts = bank.getAccounts();
						for (Account account : accounts) {
							System.out.println(account);
						}
					} else if (menu.equals("3")) {
						//TODO Deposit
						System.out.print("Please enter your account number: ");
						accountNo = this.readCommandLine();
						System.out.print("Please enter deposit amount: ");
						amount = Integer.parseInt(this.readCommandLine());
						Account account = bank.getAccount(accountNo);
						account.deposit(amount);
					} else if (menu.equals("4")) {
						//TODO Withdrawal
						System.out.print("Please enter your account number: ");
						accountNo = this.readCommandLine();
						System.out.print("Please enter deposit amount: ");
						amount = Integer.parseInt(this.readCommandLine());
						Account account = bank.getAccount(accountNo);
						account.withdraw(amount);
					} else if (menu.equals("5")) {
						//TODO Transfer
						System.out.print("Please enter your account number: ");
						String from = this.readCommandLine();
						System.out.print("Please enter the account number you wish to transfer: ");
						String to = this.readCommandLine();
						System.out.print("Enter transfer amount: ");
						amount = Integer.parseInt(this.readCommandLine());
						Account fromAccount = bank.getAccount(from);
						Account toAccount = bank.getAccount(to);
						fromAccount.withdraw(amount);
						toAccount.deposit(amount);	
					} else if (menu.equals("6")) {
						//TODO Transaction history
						System.out.print("Please enter your account number: ");
						accountNo = this.readCommandLine();
						Account account = bank.getAccount(accountNo);
						List&lt;Transaction&gt; transactions = account.getTransactions();
						for (Transaction transaction : transactions) {
							System.out.println(transaction);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				System.out.println();
			} while (!menu.equals("q"));
		
	}
	
	public void loadBank() throws Exception {
		try {
			ObjectInputStream in = null;
			in = new ObjectInputStream(new FileInputStream("bank.ser"));
			bank = (Bank) in.readObject();
			in.close();
		} catch (FileNotFoundException e) {
			bank = new ShinhanBank();
		}
	}
	
	public void saveBank() throws Exception {
		ObjectOutputStream out = null;
		out = new ObjectOutputStream(new FileOutputStream("bank.ser"));
		out.writeObject(bank);
		out.close();
	}
	
	public void readAccounts() throws Exception {
		FileReader fr = null;
		fr = new FileReader(DATA_DIR + BankUi.ACCOUNT_FILE);
		BufferedReader br = new BufferedReader(fr);
		String str = null;
		
		while ( (str = br.readLine()) != null) {
			StringTokenizer st = new StringTokenizer(str, "|");
			String accountNo = st.nextToken();
			String name = st.nextToken();
			long balance = Long.parseLong(st.nextToken());
			String kind = st.nextToken();
			
			if (kind.equals(Account.NORMAL)) {
				bank.addAccount(accountNo, name, balance, Account.NORMAL);
			} else if (kind.equals(Account.MINUS)) {
				bank.addAccount(accountNo, name, balance, Account.MINUS);
			}
		}
		
		br.close();
	}
	
	public void readTransactions() throws Exception {
		File dir = new File(BankUi.DATA_DIR);
		File[] files = dir.listFiles();
		FileReader fr = null;
		BufferedReader br = null;
		
		for (File file : files) {
			if (file.isFile()) {
				
				String fileName = file.getName();
				
				if (!fileName.equals(BankUi.ACCOUNT_FILE)) {
					fr = new FileReader(BankUi.DATA_DIR + fileName);
					br = new BufferedReader(fr);
					List&lt;Transaction&gt; transactions = new ArrayList&lt;Transaction&gt;();
					String str = null;
					
					while ( (str = br.readLine()) != null) {
						StringTokenizer st = new StringTokenizer(str, "|");
						String day = st.nextToken();
						String time = st.nextToken();
						String kind = st.nextToken();
						long amount = Long.parseLong(st.nextToken());
						long balance = Long.parseLong(st.nextToken());
						transactions.add(new Transaction(day,time,kind,amount,balance));
					}
					
					Account account = bank.getAccount(fileName);
					
					if (account != null) {
						account.setTransactions(transactions);
					}
				}
			}
		} 		
	}
	
	public void readAll() throws Exception {
		readAccounts();
		readTransactions();
	}
	
	public void writeAll() throws Exception {
		StringBuilder sbForAccounts = new StringBuilder();
		List&lt;Account&gt; accounts = bank.getAccounts();
		
		for (Account account : accounts) {
			sbForAccounts.append(account);
			sbForAccounts.append(System.getProperty("line.separator"));
			StringBuilder sbForTransactions = new StringBuilder();
			List&lt;Transaction&gt; transactions = account.getTransactions();
			
			for (Transaction transaction : transactions) {
				sbForTransactions.append(transaction);
				sbForTransactions.append(System.getProperty("line.separator"));
			}
			
			FileWriter fw = new FileWriter(BankUi.DATA_DIR + account.getAccountNo(), false);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(sbForTransactions.toString());
			bw.close();
		}
		
		FileWriter fw = null;
		BufferedWriter bw = null;
		fw = new FileWriter(DATA_DIR + BankUi.ACCOUNT_FILE, false);
		bw = new BufferedWriter(fw);
		bw.write(sbForAccounts.toString());
		bw.close();		
	}
	
	public static void main(String[] args) throws Exception {
		BankUi ui = new BankUi();
		ui.readAll();
		ui.startWork();
		ui.writeAll();
		//ui.saveBank();
	}
	
}
</pre>

<p>
How to store account information and transactions in the database will be described in the JDBC chapter.
</p>

</article>