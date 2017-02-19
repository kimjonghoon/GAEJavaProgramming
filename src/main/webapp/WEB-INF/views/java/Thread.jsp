<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<div class="last-modified">Last Modified 2017.2.3</div>
	
<h1>Thread</h1>

<p>
Programs run sequentially from top to bottom, left to right.
If you run the code along with a pencil, it will look like a thread.
So the program execution flow is called a thread.
So far we have seen only single-threaded programs.
In this article, I'll show you how to make a program that has more than two threads.
Such a program is called a multi-thread program.
</p>

<h3>How to create a multi-threaded program</h3>
<ol>
	<li>Inherit Thread class</li>
	<li>Implement the Runnable interface</li>
</ol>

<h2>Comparison of single-threaded and multithreaded programs</h2>

<h3>Single-threaded example</h3>

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

<p>
DoA () and doB () are executed on the same thread.
Therefore doB () is executed after doA () ends.
</p>

<h3>Multi-threaded example</h3>
<p>
Let's turn our example into a multi-threaded example.
</p>

<h4>Creating a multi-threaded program by inheriting the Thread class.</h4>
<p>
We will implement doA () and doB () to execute on different threads, respectively.
First, I will demonstrate how to inherit a Thread.
If you call the start () method after creating the object, another thread will be created and doA () will be executed on the new thread.
</p>

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
				//Take 0.01 seconds to allow another thread to take control.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
			try {
				//Take 0.01 seconds to allow another thread to take control.
				Thread.sleep(10);
			} catch (InterruptedException e) {
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

<h4>Create a multi-threaded program by implementing the Runnable interface.</h4>

<p>
The highlighted part of the main method is:
Creates a MultiThread2 object.
Call the Thread constructor and pass in a reference to the MultiThread2 object as an argument.
The parameter type of this constructor is the Runnable interface.
</p>

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
				//Take 0.01 seconds to allow another thread to take control.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
			
			try {
				//Take 0.01 seconds to allow another thread to take control.
				Thread.sleep(10);
			} catch (InterruptedException e) {
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


<h3>Critical Section</h3>

<p>
A critical section is a piece of code that accesses a shared resource.
Let's look at an example of the problems that occur if the critical section is not handled properly.
In the bank example, change the withdraw() method of NormalAccount as shown below.
The reason for the change is to increase the probability that the balance of the normal account becomes negative.
</p>

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
		throw new InsufficientBalanceException("There is not enough balance.");	
	}
	
}
</pre>

<p>
Create a test class.
</p>

<pre class="prettyprint">
package net.java_school.bank;

public class ThreadTest extends Thread {
	private Bank bank = new ShinhanBank();
	private Account account;
	
	public ThreadTest() {
		bank.addAccount("101", "Alison", Account.NORMAL);
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

<p>
When you test several times, there is a case where the balance of the Noraml Account is negative.
</p>

<strong class="screen-header"><b>C:\</b> Command Prompt</strong>
<pre class="screen">
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|Alison|0|Normal
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|Alison|0|Normal
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|Alison|0|Normal
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
<span class="prompt-selection">101|Alison|-100|Normal</span>
</pre>

<p>
The cause of this problem is that the thread proceeds as shown below.<br />
<img src="images/critical-section-problem.png" alt="This figure shows an example where the second thread goes through the logic of comparing the withdrawal amount and the balance before the first thread corrects the balance." /><br />
To solve the problem, apply the synchronized keyword to the withdraw() method.
Applying synchronized to a method prevents other threads from entering until the thread entering the method exits the method.
</p>

<pre class="prettyprint">
@Override
public <strong>synchronized</strong> void withdraw(long amount)  {
	.. Same as existing code ..
}
</pre>

<p>
Test it several times and make sure that there is no longer a negative balance in your normal account.<br />
As shown in the figure below, the second thread will not be able to enter the method until the first thread has left the method.<br />
<img src="images/critical-section-sync-1.png" alt="The figure shows that the first thread has entered the critical area and the second thread is proceeding just before the critical area." /><br />
<img src="images/critical-section-sync-2.png" alt="This figure shows that the first thread is almost passing through the critical area and the second thread is not yet in the critical area." /><br />
<img src="images/critical-section-sync-3.png" alt="This figure shows that the first thread has just passed the critical area and the second thread is not yet in the critical area." /><br />
When the first thread goes out of the method, the waiting thread enters the method.<br />
<img src="images/critical-section-sync-4.png" alt="This figure shows that the first thread has passed the critical area and the second thread has just entered the critical area." /><br />

Return the withdraw () method as shown below.
</p>

<pre class="prettyprint">
@Override
public synchronized void withdraw(long amount)  {
	<strong>if (amount &gt; balance) {
		throw new InsufficientBalanceException("There is not enough balance.");	
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

<p>
Apply the synchronized keyword to the deposit() method.
</p>

<pre class="prettyprint">
public <strong>synchronized</strong> void deposit(long amount) {
	//.. Same as existing code ..
}
</pre>

<p>
The Vector is thread-safe, but the ArrayList is not.
All methods of Vector are synchronized.
</p>

</article>