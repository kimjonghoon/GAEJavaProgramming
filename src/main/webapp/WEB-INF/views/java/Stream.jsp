<div id="last-modified">Last Modified : 2015.5.27</div>

<h1 class="heading1">스트림</h1>

자바에서 입출력은 스트림을 통해서 이루어진다.<br />
자바 프로그램을 기준으로 스트림의 방향이 자바 프로그램 안으로 향하면 입력 스트림,<br />
스트림의 방향이 자바 프로그램 밖으로 향하면 출력 스트림이다.<br />
스트림 객체를 생성할 때 중요한 정보는 입력 스트림의 경우 근원지(Source)이고,
출력 스트림의 경우 목적지(Destination)이다.<br />
스트림 생성자의 인자 값으로 이들 정보를 필요하다.<br />
근원지나 목적지의 형태는 다양하다.<br />
예를 들면 대표적으로 파일이 있겠고, 콘솔 화면, 소켓도 될 수 있다.<br />
스트림 클래스는 상당히 많은데 다음의 분류 기준을 이해하고 있으면 전체를 파악하는데 도움이 된다.<br />

<ul>
	<li>바이트 스트림인가? 문자 스트림인가?</li>
	<li>입력 스트림인가? 출력 스트림인가?</li>
	<li>실제 입출력을 하는가? 입출력의 성능에 도움을 주는가?</li>
</ul>

<h2 class="heading2">바이트 스트림</h2>

바이트 스트림은 1byte 단위로 입출력하는 스트림이다.<br />
일반적으로 동영상이나 이미지 파일과 같은 바이너리 파일에 대한 처리할 때 사용한다.<br />
InputStream과 OutputStream은 추상 클래스로 모든 바이트 스트림 클래스의 최상위 클래스이다.<br />

<table class="table-in-article">
<tr>
	<td class="table-in-article-td" colspan="2"><strong>InputStream 메서드</strong></td>
</tr>
<tr>
	<td class="table-in-article-td" width="180px;">int read()</td>
	<td class="table-in-article-td">추상 메서드, 입력 스트림으로부터 한 바이트씩 읽어서 0~255 사이의 값을 반환한다.
	입력 스트림의 끝에 도달하여 더 이상 읽을 수 없을 때는 -1을 반환한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">int read(byte[] b)</td>
	<td class="table-in-article-td">대부분의 경우 b 크기만큼 읽어서 b에 저장하고 읽은 바이트 수를 반환한다.
	입력 스트림의 끝에 도달하여 더 이상 읽을 수 없을 때는 -1을 반환한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">int read(byte[] b, int off, int len)</td>
	<td class="table-in-article-td">최대 len 만큼 읽어 b의 off 위치에 저장하고 읽은 바이트 수를 반환한다.
	입력 스트림의 끝에 도달하여 더 이상 읽을 수 없을 때는 -1을 반환한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">int available()</td>
	<td class="table-in-article-td">읽을 수 있는 바이트 수를 반환한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">void close()</td>
	<td class="table-in-article-td">입력 스트림을 닫아 스트림과 관련된 시스템 자원을 반환한다.</td>
</tr>
</table>

<table class="table-in-article">
<tr>
	<td class="table-in-article-td" colspan="2"><strong>OutputStream 메서드</strong></td>
</tr>
<tr>
	<td class="table-in-article-td" width="180px">void write(int b)</td>
	<td class="table-in-article-td">b의 하위 8비트를 출력한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">void write(byte[] b)</td>
	<td class="table-in-article-td">b의 내용을 출력한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">void write(byte[] b, int off, int len)</td>
	<td class="table-in-article-td">b의 off 위치부터 len 만큼의 바이트를 출력한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">void flush()</td>
	<td class="table-in-article-td">버퍼에 남은 바이트를 출력한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">void close()</td>
	<td class="table-in-article-td">출력 스트림을 닫아 출력 스트림과 관련된 시스템 자원을 반환한다.</td>
</tr>
</table> 


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

다음 두 개의 파일로 테스트한다.<br />

<em class="filename">test.txt</em>
<pre class="prettyprint">
a b c d e
1 2 3 4 5
</pre>

<em class="filename">테스트.txt</em>
<pre class="prettyprint">
가 나 다 라 마
1 2 3 4 5
</pre>

이번 예제는 콘솔에 파일 내용을 출력하는 것이 아니라 복사본 파일을 만드는 예제이다.<br />

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

FileInputStream/FileOutputStream 은 바이트 단위로 파일에 입출력을 하기 위한 클래스이다.

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" colspan="2">FileInputStream 생성자</th>
</tr>
<tr>
	<td class="table-in-article-td">FileInputStream(File file)</td>
	<td class="table-in-article-td">file로 지정한 파일에 대한 입력 스트림을 생성한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">FileInputStream(String name)</td>
	<td class="table-in-article-td">name으로 지정한 파일에 대한 입력 스트림을 생성한다.</td>
</tr>
</table>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" colspan="2">FileOutputStream 생성자</th>
</tr>
<tr>
	<td class="table-in-article-td" width="270px;">FileOutputStream(File file)</td>
	<td class="table-in-article-td">file로 지정한 파일에 대한 출력 스트림을 생성한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">FileOutputStream(File file, boolean append)</td>
	<td class="table-in-article-td">file로 지정한 파일에 대한 출력 스트림을 생성한다. append가 true 이면 파일 끝에 출력한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">FileOutputStream(String name)</td>
	<td class="table-in-article-td">name으로 지정한 파일에 대한 출력 스트림을 생성한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">FileOutputStream(String name, boolean append)</td>
	<td class="table-in-article-td">name으로 지정한 파일에 대한 출력 스트림을 생성한다. append가 true 이면 파일 끝에 출력한다.</td>
</tr>
</table>

new FileOutputStream("C:/javaApp/test.txt", false);에서 false는 기존 내용의 끝에 추가하지 않는 설정이다.
예제에서 쓰이는 FileInputStream과 FileOutputStream의 메서드는 InputStream과 OutputStream 메서드 
설명 부분을 참고한다.<br />

<h2 class="heading2">문자 스트림</h2>
<!-- 
<img src="https://lh4.googleusercontent.com/-6xNIYh4BAfo/UrREJcHeK7I/AAAAAAAABhs/2U_pBrm-C-Q/w590-h555-no/CharacterStream.jpg" alt="문자 스트림 계층도" /><br />
-->

Reader 와 Writer는 문자 입출력 클래스의 최상위 클래스이다.<br />
모두 추상 클래스인데 메서드에서 입출력 데이터의 단위가 문자이다.<br />

<table class="table-in-article">
<tr>
	<td class="table-in-article-td"><strong>Reader</strong></td>
</tr>
<tr>
	<td class="table-in-article-td">int read()<br />
	단일 문자 하나를 읽고 문자의 유니코드값을 반환한다. 
	</td>
</tr>
<tr>
	<td class="table-in-article-td">int read(char[] b)<br />
	문자를 b 크기만큼을 읽어 b에 저장하고 읽은 문자 수를 반환
	</td>
</tr>
<tr>
	<td class="table-in-article-td">abstract int read(char[] b, int off, int len)<br />
	len 만큼 읽어 b의 off 위치에 저장하고 실제 읽은 문자 수를 반환		
	</td>
</tr>
</table>

<table class="table-in-article">
<tr>
	<td class="table-in-article-td"><strong>Writer</strong></td>
</tr>
<tr>
	<td class="table-in-article-td">void write(String s)<br />
	s를 출력
	</td>
</tr>
<tr>
	<td class="table-in-article-td">void write(char[] b)<br />
	b를 출력
	</td>
</tr>
<tr>
	<td class="table-in-article-td">void write(char[] b, int off, int len)<br />
	b의 off 위치에서 len 만큼의 문자 출력		
	</td>
</tr>
<tr>
	<td class="table-in-article-td">void write(String s, int off, int len)<br />
	s의 off 위치에서 len 만큼의 문자 출력		
	</td>
</tr>
</table>
 
<em class="filename">Test2.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.FileReader;
import java.io.FileWriter;

public class Test2 {

	public static void main(String[] args) throws Exception {
		int n = 0;
		FileReader fr = new FileReader("C:/javaApp/테스트.txt");
		FileWriter fw = new FileWriter("C:/javaApp/테스트카피.txt", false);
		while ((n = fr.read()) != -1) {
			fw.write(n);
		}
		fr.close();
		fw.close();
	}

}
</pre>

<h3 class="heading3">BufferedReader/BufferedWriter</h3>

BufferedReader/BufferedWriter 문자 입력 스트림으로부터 문자를 읽어 들어거나 문자 출력 스트림으로부터 문자를 내보낼 때
버퍼링 기능을 제공하여 효율적으로 처리할 수 있도록 해준다.<br />

<em class="filename">Test2.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;

public class Test {

	public static void main(String[] args) throws Exception {
		FileReader fr = new FileReader("C:/javaApp/테스트.txt");
		BufferedReader br = new BufferedReader(fr);
		String s = null;
		FileWriter fw = new FileWriter("C:/javaApp/테스트카피2.txt", false);
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



<h3 class="heading3">InputStreamReader/OutputStreamWriter</h3>
InputStreamReader는 바이트 스트림에서 문자 스트림으로 변환할 때,
OutputStreamWriter는 문자 스트림에서 바이트 스트림으로 변환할 때 사용하는 클래스이다.<br />
InputStreamReader는 바이트 스트림으로부터 바이트를 읽어서 특정 문자 셋을 이용해서 문자로 바꾼다.<br />
OutputStreamWriter는 이 출력 스트림에 쓰인 문자를 특정 문자 셋을 이용해서 바이트로 바꾼다.<br />

<table class="table-in-article">
<tr>
	<td class="table-in-article-td"><strong>InputStreamReader 생성자</strong></td>
</tr>
<tr>
	<td class="table-in-article-td">InputStreamReader(InputStream in)</td>
</tr>
<tr>
	<td class="table-in-article-td">InputStreamReader(InputStream in, String enc)</td>
</tr>
</table>

<table class="table-in-article">
<tr>
	<td class="table-in-article-td"><strong>OutputStreamWriter 생성자</strong></td>
</tr>
<tr>
	<td class="table-in-article-td">OutputStreamWriter(OutputStream out)</td>
</tr>
<tr>
	<td class="table-in-article-td">OutputStreamWriter(OutputStream out, String enc)</td>
</tr>
</table>

아래 예제는 InputStreamReader를 이용해서 표준 입력 기구인 키보드(System.in)로부터의 바이트 스트림을 문자 스트림으로 변환하는 예제이다.<br />

<em class="filename">InputTest.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.*;

public class InputTest {
	public static void main(String[] args) throws IOException {
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String input = br.readLine();
		System.out.println("입력 : " + input); 
	}
}
</pre>

키보드(표준 입력 기구)를 근원지(source)로 하는 InputStreamReader 을 생성하고 있다.<br />
그다음 입출력의 성능을 위해 버퍼 기능을 가진 BufferedReader 객체의 생성자에 InputStreamReader 의 참조 값을 
생성자 매개변수의 인자 값으로 전달하고 있다.<br />
String input = br.readLine();에서 사용자의 입력을 기다린다.<br />
BufferedReader의 readLine() 메서드는 사용자가 엔터키를 칠 때까지의 문자열을 반환한다.
이때 엔터키는 문자열에 포함되지 않는다.<br />
문자열이 반환되어 input 변수에 할당되고<br />
마지막 줄에서 표준 출력 메서드에 의해 입력값을 확인된다.<br />
BufferedReader를 자바 문서에서 찾아 확인한다.<br />
<br />
다음 예제는 문자 데이터를 파일에 출력하는 것이다.<br />

<em class="filename">OutputTest.java</em>
<pre class="prettyprint">
package net.java_school.stream;

import java.io.*;

public class OutputTest {
	public static void main(String[] args) {
		FileWriter fw = null;
		try {
			fw = new FileWriter("C:/output.txt", true);
			fw.write("테스트");
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

FileWriter 클래스는 문자 데이터를 파일에 출력할 때 사용한다.<br />
FileWriter 클래스의 생성자의 첫 번째 인자는 목적지이고, 두 번째 인자는 파일에 있는 기존 내용을 그대로 둘지 여부를 
결정하는 플래그이다. 여기에서처럼 true 이면 기존 내용을 그대로 둔다.<br />
입력 스트림에서와 달리 출력 스트림일 경우 제대로 출력 스트림을 닫아주는 것이 중요하다.<br />
소스에서 강조된 fw.close() 가 출력 스트림을 닫아주는 코드이다.<br />
이 예제는 <a href="Logging.php">'로깅(Logging)'</a>의 첫 번째 예제에서 쓰인다.<br /> 

<em class="filename">SubtitleToText.java - 자막 파일(확장자 srt)을 일반 문서로 변환</em>
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
			}//finally
			
		}//if
		
	}//main 

}
</pre>

<em class="filename">URLTest.java - URL 클래스:인터넷상의 URL을 참조하는데 이용</em>
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

<h2 class="heading2">객체 스트림</h2>
다음 예제는 객체 스트림에 관한 예제이다.<br />
객체를 파일이나 네트워크를 통해 전달하려면 직렬화 과정이 필요하다.<br />
파일이나 네트워크를 통해 전달된 객체 스트림으로부터 다시 객체를 만들어 내려면 역직렬화 과정이 필요하다.<br />
<br />
예제는 객체 정보를 파일에 저장하고, 객체 정보가 저장된 파일로부터 객체를 생성한다.<br /> 

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

Address 객체가 직렬화되어 스트림을 타고 파일에 저장될 것이라면<br />
Address 클래스는 반드시 Serializable 인터페이스를 구현한다고 선언해야 한다.<br />
<br />
<em>public class Address implements Serializable</em><br />
<br />
그런데 이 Serializable 인터페이스는 구현할 메서드가 없다.<br />
Serializable 인터페이스는 클래스로부터 생성된 객체는 직렬화 대상이라는 것을 버추얼 머신에게 알리는 역할만을 한다.<br />
이와 같은 인터페이스는 선언적 인터페이스라고 한다.<br />
<br />
자바의 기본 자료형 데이터는 직렬화가 필요 없으며,<br />
또 많이 사용하는 String 과 Collection 관련 클래스는 직렬화가 가능하다.<br />
다시 말해, 이와 같은 클래스는 클래스 선언 부에 implements Serializable 문장이 있는 채로 컴파일 되어 있다.<br />
우리가 만드는 클래스가 직렬화가 필요하다면 Serializable 인터페이스를 구현한다고 선언을 해야 한다.<br />

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
			addr.setMobile("010-1234-5678");
			addr.setAddress("서울 서초구");
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

백업(Backup)은 말 그대로 Address 객체를 하나 생성하고 이것을 파일에 저장하는 클래스이다.<br />
객체 스트림을 만들기 위해 ObjectOutputStream 을 사용했고 파일에 저장하기 위해 FileOutputStream 을 사용했다.<br />
다음은 파일에 저장된 객체 정보로부터 객체를 복구하는 예제이다.<br />

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

이 예제는 address.txt 파일에 저장된 객체 정보로부터 똑같은 내용의 객체를 만들어 메모리에 올리는 프로그램이다.<br />
파일로부터의 바이트를 읽어야 하는 입력 스트림이기에 FileInputStream 을 사용했고, 
자바 프로그램으로 들어오는 객체 스트림을 위해서 ObjectInputStream 을 사용했다.<br />
직렬화는 RMI 기본 개념을 이해하기 위해서도 필요하다.<br />

<h2 class="heading2">자바은행 실습</h2>
자바은행 예제에 스트림을 적용하는 실습을 한다.<br /> 
BankUi라는 새로운 클래스를 아래와 같이 만들고 테스트한다.<br />

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
		System.out.println("입력: " + input);
	}

}
</pre>

실행하면 br.readLine();에서 프로그램이 멈춘다.<br />
사용자가 키보드로 입력 후 엔터키를 치면 엔터키를 포함하지 않는 문자열이 input에 할당된다.<br />

<h3 class="heading3">과제</h3>

BankUi를 아래처럼 변경한 후 //TODO 부분을 구현한다.<br />

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
            System.out.println(" ** 메뉴를 선택하세요 ** ");
            System.out.println(" 1 ** 계좌 등록    ");
            System.out.println(" 2 ** 계좌 목록    ");
            System.out.println(" 3 ** 입금    ");
            System.out.println(" 4 ** 출금    ");
            System.out.println(" 5 ** 이체    ");
            System.out.println(" 6 ** 입출금 명세    ");
            System.out.println(" q ** 종료    ");
            System.out.println(" ********************** ");
            System.out.print("&gt;&gt;");
            
            try {
            		
                menu = readCommandLine();

                if (menu.equals("1")) {
                    //TODO 계좌등록
                } else if (menu.equals("2")) {
                    //TODO 계좌목록
                } else if (menu.equals("3")) {
                    //TODO 입금
                } else if (menu.equals("4")) {
                    //TODO 출금
                } else if (menu.equals("5")) {
                    //TODO 이체
                } else if (menu.equals("6")) {
                    //TODO 입출금 명세
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


//TODO 부분을 모두 구현했다면 충분히 테스트한다.<br />
대화형 프로그램으로 진화되었지만 프로그램이 종료되면 계좌와 쌓인 입출금 명세 정보는 사라지는 것은 이전과 같다.<br />
다음 방법으로 계좌와 입출금 명세를 저장할 수 있다.<br /> 

<ol>
	<li>객체 스트림을 이용하여 은행 객체를 파일에 저장</li>
	<li>계좌와 입출금 명세 정보를 읽을 수 있는 텍스트 파일에 저장</li>
	<li>데이터베이스에 저장</li>
</ol>

<h3 class="heading3">1. 객체 스트림을 이용하여 은행 객체를 파일에 저장</h3>
객체를 파일 시스템에 저장하려면 객체가 직렬화 대상이어야 한다.<br />
직렬화 대상이 되게 하려면 Serializable 인터페이스를 구현해야 한다.<br />
Bank, Account, Transaction 클래스를 수정한다.<br />
<em class="path">import java.io.Serializable;</em>문이 필요하다.<br />
 
<pre class="prettyprint">
public interface Bank <strong>extends Serializable</strong> {
</pre>

<pre class="prettyprint">
public abstract class Account <strong>implements Serializable</strong> {
</pre>


<pre class="prettyprint">
public class Transaction <strong>implements Serializable</strong> {
</pre>

시나리오는 이렇다.<br />
프로그램이 시작할 때 bank.ser 파일에 저장된 은행 객체 정보를 역직렬화해서 은행 객체를 힙 메모리에 불러온다.<br />
프로그램을 처음 실행하는 상황이고 그래서 bank.ser 파일이 없다면 FileNotFoundException이 발생할 것이다.
FileNotFoundException이 발생하는 경우에는 은행 클래스의 생성자를 호출하여 은행 객체를 생성하고 
bank 변수에 참조 값을 할당한다.<br />
프로그램을 종료할 때 은행 객체 정보를 bank.ser 파일에 저장한다.<br />
<br /> 
다음 메소드를 BankUi 클래스에 추가한다.<br />

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

<h3 class="heading3">2. 계좌와 입출금 명세 정보를 읽을 수 있는 텍스트 파일에 저장</h3>
텍스트 파일에 저장하기 위한 코드 힌트를 보기 전에 우선 File 클래스에 대해 알아보자.<br />
File 클래스는 짐작과 달리 파일에 대한 입출력 기능은 없다.<br />
File 클래스로 할 수 있는 알은 다음과 같다.<br />

<ul>
	<li>디렉터리 내용을 알아본다.</li>
	<li>파일의 속성을 알아낸다.</li>
	<li>파일을 이름을 변경하거나 파일을 삭제한다.</li>
</ul>

File 객체를 생성하는 코드는 아래와 같다.<br />
File dir = new File(path);<br />
여기서 path에 해당하는 파일이나 디렉터리는 시스템의 전체 경로가 되어야 한다.<br />
다음은 File 클래스의 중요 메서드이다.<br />

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">File</dt>
	<dd class="api-summary-dd">isDirectory() : boolean</dd>
	<dd class="api-summary-dd-method-desc">dir.isDirectory(); //dir이 디렉터리이면 true 반환</dd>
	<dd class="api-summary-dd">isFile() : boolean</dd>
	<dd class="api-summary-dd-method-desc">dir.isFile(); //dir이 파일이면 true 반환</dd>
	<dd class="api-summary-dd">list() : String[]</dd>
	<dd class="api-summary-dd-method-desc">dir.list(); //dir이 디렉터리일 때 디렉터리에 있는 파일명을 String[] 타입 값으로 반환</dd>
	<dd class="api-summary-dd">listFiles() : File[]</dd>
	<dd class="api-summary-dd-method-desc">dir.listFiles(); //디렉터리에 있는 파일의 파일 객체 배열 반환</dd>
	<dd class="api-summary-dd">mkdir() : boolean</dd>
	<dd class="api-summary-dd-method-desc">dir.mkdir(); //File 객체의 이름을 가진 디렉터리 생성</dd>
	<dd class="api-summary-dd">getName() : String</dd>
	<dd class="api-summary-dd-method-desc">파일명 반환</dd>
	<dd class="api-summary-dd">getPath() : String</dd>
	<dd class="api-summary-dd-method-desc">경로 반환</dd>
	<dd class="api-summary-dd">delete() : boolean</dd>
	<dd class="api-summary-dd-method-desc">파일 삭제</dd>
	<dd class="api-summary-dd">exists() : boolean</dd>
	<dd class="api-summary-dd-method-desc">파일이나 경로가 있다면 true, 없다면 false 반환</dd>
</dl>

계좌 정보는 accounts.txt 이름의 파일에 저장할 것이다.<br /> 
저장되는 계좌 정보의 형식은 다음과 같다.<br />

<pre class="prettyprint">
101|홍길동|10000|일반
202|임꺽정|5000|일반
303|장길산|0|일반
404|홍길동|0|마이너스
</pre>

Account.java 파일을 열고 toString() 메서드를 다음처럼 수정하다.<br />

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

입출금 명세는 계좌번호와 같은 이름의 파일에 저장하도록 할 것이다.<br />
저장되는 입출금 명세 정보의 형식은 다음과 같다.<br />

<pre class="prettyprint">
2014/5/1|09:33:30|입금|10000|10000
2014/5/3|09:33:30|출금|6000|4000
</pre>

Transaction.java 파일을 열고 toString() 메서드를 다음처럼 수정한다.<br />

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

먼저 BankUi.java를 열고 아래를 참고하여 코드를 수정한다.<br />

<pre class="prettyprint">
<strong>static final String ACCOUNT_FILE = "accounts.txt";
static final String DATA_DIR = "./data/";</strong>

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

다음 코드 조각을 참조하여 구현한다.<br /> 
프로그램이 시작할 때 계좌 정보를 accounts.txt 파일로부터 읽어서 계좌 객체를 로딩한다.<br />
이클립스에서 작업한다면 프로젝트 루트 디렉터리에 data 폴더를 만들고 폴더 안에 accounts.txt 이름의 빈 파일을 만들어야 한다.<br />

<pre class="prettyprint">
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
</pre>

프로그램을 시작할 때 입출금 명세를 각 입출금 명세 파일로부터 읽어서 입출금 명세 객체를 로딩하고 
계좌 객체와 바인딩 한다.<br />

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

프로그램이 종료될 때 계좌와 입출금 명세를 저장한다.<br />

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

데이터 베이스에 저장하는 방법은 JDBC에서 구현한다.<br />

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
				System.out.println(" ** 메뉴를 선택하세요 ** ");
				System.out.println(" 1 ** 계좌 등록    ");
				System.out.println(" 2 ** 계좌 목록    ");
				System.out.println(" 3 ** 입금    ");
				System.out.println(" 4 ** 출금    ");
				System.out.println(" 5 ** 이체    ");
				System.out.println(" 6 ** 입출금 명세    ");
				System.out.println(" q ** 종료    ");
				System.out.println(" ********************** ");
				System.out.print("&gt;&gt;");
				
				try {
					menu = readCommandLine();
				
					String accountNo = null;
					String name = null;
					String kind = null;
					long amount = 0;
					
					if (menu.equals("1")) {
						//TODO 계좌등록
						System.out.print("계좌 번호를 입력하세요: ");
						accountNo = this.readCommandLine();
						System.out.print("소유자 이름을 입력하세요: ");
						name = this.readCommandLine();
						System.out.print("계좌 종류를 선택하세요. 일반(n), 마이너스(m):  일반(n): : ");
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
						//TODO 계좌목록
						List&lt;Account&gt; accounts = bank.getAccounts();
						for (Account account : accounts) {
							System.out.println(account);
						}
					} else if (menu.equals("3")) {
						//TODO 입금
						System.out.print("계좌 번호를 입력하세요: ");
						accountNo = this.readCommandLine();
						System.out.print("입금 액을 입력하세요: ");
						amount = Integer.parseInt(this.readCommandLine());
						Account account = bank.getAccount(accountNo);
						account.deposit(amount);
					} else if (menu.equals("4")) {
						//TODO 출금
						System.out.print("계좌 번호를 입력하세요: ");
						accountNo = this.readCommandLine();
						System.out.print("출금 액을 입력하세요: ");
						amount = Integer.parseInt(this.readCommandLine());
						Account account = bank.getAccount(accountNo);
						account.withdraw(amount);
					} else if (menu.equals("5")) {
						//TODO 이체
						System.out.print("송금 계좌(From) 번호를 입력하세요: ");
						String from = this.readCommandLine();
						System.out.print("입금 계좌(To) 번호를 입력하세요: ");
						String to = this.readCommandLine();
						System.out.print("이체 금액을 입력하세요: ");
						amount = Integer.parseInt(this.readCommandLine());
						Account fromAccount = bank.getAccount(from);
						Account toAccount = bank.getAccount(to);
						fromAccount.withdraw(amount);
						toAccount.deposit(amount);	
					} else if (menu.equals("6")) {
						//TODO 입출금 명세
						System.out.print("계좌 번호를 입력하세요: ");
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