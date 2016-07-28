<div id="last-modified">Last Modified : 2015.5.26</div>
	
<h1 class="heading1">스레드</h1>

프로그램은 위에서 아래로 왼쪽에서 오른쪽으로 순차적으로 실행된다.<br />
처리되는 코드를 연필로 따라 줄 그어 나간다면 실타래처럼 보일 것이다.<br />
그래서 프로그램의 실행 흐름을 스레드라 한다.<br />
지금까지 우리는 실이 한 가닥인 단일 스레드 프로그램만을 보아 왔다.<br />
이번 과정은 실타래가 2가닥 이상인(멀티 스레드) 프로그램을 만드는 방법을 소개한다.<br />

<h3 class="heading3">멀티 스레드 프로그램을 만드는 방법</h3>
<ol>
	<li>Thread 클래스를 상속</li>
	<li>Runnable 인터페이스를 구현</li>
</ol>

<h2 class="heading2">단일 스레드 프로그램과 멀티 스레드 프로그램의 비교</h2>

<h3 class="heading3">단일 스레드 예제</h3>

<em class="filename">SingleThread.java</em>
<pre class="prettyprint">
package net.java_school.thread.test;

public class SingleThread {
	
	public void doA() {
		char[] alphabet = {'A','B','C','D','E','F','G','H','I','J'};
		int length = alphabet.length;
		for ( int i=0; i &lt; length; i++ ) {
			System.out.print(alphabet[i]);
		}
	}

	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
		}
	}
	
	public static void main(String[] args) {
		SingleThread st = new SingleThread();
		st.doA();
		st.doB();
	}

}
</pre>

doA() 와 doB()는 같은 스레드에서 실행된다.<br />
따라서 호출된 순서인 doA()가 끝난 후 doB()가 실행된다.<br />

<h3 class="heading3">멀티 스레드 예제</h3>
방금 한 예제를 멀티 스레드 예제로 바꾸어 본다.<br />

<h4 class="heading4">Thread 클래스를 상속하여 만드는 멀티 스레드 프로그램</h4>
doA()와 doB()가 각각 다른 스레드에서 실행하게 구현할 것이다.<br />
Thread를 상속하는 방법을 택했는데 객체 생성 후 start() 메서드를 호출하면 다른 스레드가 생성되고 
doA()는 새로 생긴 스레드에서 실행되게 된다.<br />

<em class="filename">MultiThread1.java</em>
<pre class="prettyprint">
package net.java_school.thread.test;

public class MultiThread1 extends Thread {

	public void doA() {
		char[] alphabet = {'A','B','C','D','E','F','G','H','I','J'};
		int length = alphabet.length;
		for ( int i = 0; i &lt; length; i++ ) {
			System.out.print(alphabet[i]);
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void run() {
		doA();
	}
	
	public static void main(String[] args) {
		MultiThread1 mt1 = new MultiThread1();
		<strong>mt1.start();</strong>
		mt1.doB();
	}
}
</pre>

<h4 class="heading4">Runnable 인터페이스를 구현하여 만드는 멀티 스레드 프로그램</h4>

강조된 부분은 메인 메서드에서 자신 자신의 객체를 생성하고 Runnable 인터페이스 타입의 
레퍼런스를 인자 값으로 받는 Thread 생성자에 호출하여 자기 자신의 레퍼런스를 전달하고 있다.<br /> 

<em class="filename">MultiThread2.java</em>
<pre class="prettyprint">
package net.java_school.thread.test;

public class MultiThread2 implements Runnable {

	public void doA() {
		char[] alphabet = {'A','B','C','D','E','F','G','H','I','J'};
		int length = alphabet.length;
		for ( int i = 0; i &lt; length; i++ ) {
			System.out.print(alphabet[i]);
			
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
			
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void run() {
		doA();
	}
	
	public static void main(String[] args) {
		MultiThread2 mt2 = new MultiThread2();
		<strong>Thread t = new Thread(mt2);</strong>
		<strong>t.start();</strong>
		mt2.doB();
	}
}
</pre>


<h3 class="heading3">임계 영역(Critical Section) 테스트</h3>

임계 영역이란 공유된 자원을 접근하는 코드 부분을 말한다.
임계 영역을 제대로 다루지 않을 경우 발생하는 문제점을 예제를 통해 살펴보려 한다.<br />
은행 예제에서 NormalAccount의 withdraw() 메서드를 아래와 같이 변경한다.<br />
변경하는 이유는 일반 계좌의 잔고가 마이너스가 되는 확률을 높이기 위해서다.<br />

<pre class="prettyprint">
@Override
public void withdraw(long amount)  {
	<strong>try {
		Thread.sleep(5);
	} catch (InterruptedException e) {
		e.printStackTrace();
	}</strong>
	
	if (amount &lt;= balance) {
		Transaction transaction = new Transaction();
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
		transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
		transaction.setAmount(amount);
		transaction.setKind(Account.WITHDRAW);
		<strong>balance = balance - amount;</strong>
		transaction.setBalance(this.balance);
		transactions.add(transaction);
	} else {
		throw new InsufficientBalanceException("잔고가 부족합니다.");	
	}
	
}
</pre>

테스트를 위한 클래스를 작성한다.<br />

<pre class="prettyprint">
package net.java_school.bank;

public class ThreadTest extends Thread {
	private Bank bank = new ShinhanBank();
	private Account account;
	
	public ThreadTest() {
		bank.addAccount("101", "홍길동", Account.NORMAL);
		account = bank.getAccount("101");
		account.deposit(1000);
	}
	
	public void withdrawTest() {
		int i = 0;
		do {
			i++;
			try {
				account.withdraw(100);
			} catch (InsufficientBalanceException e) {}

			try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} while (i &lt; 100);

	}

	public void run() {
		withdrawTest();
	}
	
	public static void main(String[] args){
		ThreadTest t = new ThreadTest();
		t.start();
		t.withdrawTest();
		Account account = t.bank.getAccount("101");
		System.out.println(account);
	}
}
</pre>

여러 번 테스트해 보면 일반 계좌에서 잔고가 마이너스가 되는 경우가 생긴다.

<pre class="screen">
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|홍길동|0|일반
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|홍길동|0|일반
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|홍길동|0|일반
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
<span class="prompt-selection">101|홍길동|-100|일반</span>
</pre>

이런 문제가 발생하는 원인은 아래 그림과 같이 스레드가 진행하기 때문이다.<br />

<img src="images/critical-section-problem.png" alt="이 그림은 첫번째 스레드가 잔고를 수정하기 전에 두번째 스레드가 출금액과 잔고를 비교하는 로직을 통과하여 문제를 발생한다는 예를 보여주고 있다." /><br />
 
문제점을 해결하기 위해서 withdraw() 메서드에 synchronized 키워드를 적용한다.<br />
메서드에 synchronized를 적용하면 메서드에 진입한 스레드가 메서드 밖으로 나갈 때까지 다른 스레드가 진입하지 못한다.<br />

<pre class="prettyprint">
@Override
public <strong>synchronized</strong> void withdraw(long amount)  {
	.. 기존 코드와 같다 ..
}
</pre>


여러 번 테스트해 보고 더 이상 일반 계좌의 잔고가 마이너스가 되는 경우가 생기지 않는다는 것을 확인한다.<br />
아래 그림과 같이 첫 번째 진입한 스레드가 메서드 밖으로 나갈 때까지 두 번째 스레드는 메서드에 진입하지 못한다.<br />

<img src="images/critical-section-sync-1.png" alt="그림은 첫번째 스레드가 임계영역에 들어왔고 두번째 스레드가 임계영역 바로 앞까지 진행되는 것을 보여준다." /><br />
<img src="images/critical-section-sync-2.png" alt="그림은 첫번째 스레드가 임계영역에서 거의 통과하고 있는데 두번째 스레드는 아직 임계영역에 진입하지 못하는 것을 보여준다." /><br />
<img src="images/critical-section-sync-3.png" alt="그림은 첫번째 스레드가 임계영역을 막 통과하기 전이고 두번째 스레드는 아직 임계영역에 진입하지 못하고 있는 것을 보여준다." /><br />

첫 번째 스레드가 메서드 밖으로 나가면 대기하고 있던 스레드가 메서드에 진입하게 된다.<br />
<img src="images/critical-section-sync-4.png" alt="그림은 첫번째 스레드가 임계영역을 통과했고 이제야 두번째 스레드가 임계영역에 진입한 것을 보여준다." /><br />

withdraw() 메서드를 아래와 같이 되돌려 놓는다.<br />

<pre class="prettyprint">
@Override
public synchronized void withdraw(long amount)  {
	<strong>if (amount &gt; balance) {
		throw new InsufficientBalanceException("잔고가 부족합니다.");	
	}
	balance = balance - amount;</strong>
	Transaction transaction = new Transaction();
	Calendar cal = Calendar.getInstance();
	Date date = cal.getTime();
	transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
	transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
	transaction.setAmount(amount);
	transaction.setKind(Account.WITHDRAW);
	transaction.setBalance(this.balance);
	transactions.add(transaction);
}
</pre>

deposit() 메서드에도 synchronized 키워드를 적용한다.<br />

<pre class="prettyprint">
public <strong>synchronized</strong> void deposit(long amount) {
	//.. 기존 코드와 같다..
}
</pre>

컬렉션에서 Vector는 '스레드 안전' 한데 ArrayList는 그렇지 않다고 했다.<br />
Vector의 모든 메서드는 synchronize가 적용되어 있다.<br />
