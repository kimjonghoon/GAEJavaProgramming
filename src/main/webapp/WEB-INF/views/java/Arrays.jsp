<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<article>
<div class="last-modified">Last Modified 2013.12.7</div>

<h1>Arrays</h1>

An array is a container object that holds values of a same type.

<img src="https://lh3.googleusercontent.com/-iLIT7b27vBo/Vvy0K3Fs5eI/AAAAAAAACto/WJw-WrH8EtENW0RZRVweV-vjoMqqXb4DACCo/s913-Ic42/variable-array.png" alt="variable and array" style="width: 100%;" /><br />

Each item in an array is called an element, 
and each element is accessed by its numerical index, 
numbering begins with 0, and square brackets, e.g., arr[4].
In Java, the array is an object. 
So, you need to create an array object.

<h3>Examples of Array</h3>

<pre class="prettyprint">
int[] arr = null;//declares an array of integers.

arr = new int[4];
/*
4 is the size of array. 
This value is stored in the length member variable of array and never change.
All elements are initialized to 0.
*/

arr[0] = 1;//1st element is assigned to 1.
arr[1] = 2;//2nd element is assigned to 2.
arr[2] = 3;//3rd element is assigned to 3.
arr[3] = 4;//Last element is assigned to 4.
</pre>

Alternatively, you can use the shortcut syntax to create and initialize an array;

<pre class="prettyprint">
int[] arr2 = {1, 2, 3, 4};
</pre>

<pre class="prettyprint">
String[] arr3 = null;//declares an array of Strings.
arr3 = new String[4];//The length is fixed at 4 and all elements are initialized to null.

arr3[0] = "Java";//1st element is assigned to "Java" object’s reference.
arr3[1] = "School";//2nd element is assigned to "School" object’s reference.
</pre>

you can use the shortcut syntax to create and initialize an array;

<pre class="prettyprint">
String[] arr4 = {"Java", "School"};
</pre>


<h3>How to use String[] parameter in main method</h3>

<pre class="prettyprint">
public class Test {
    public static void main(String[] args) {
        System.out.print(args[0] + "/");
        System.out.print(args[1] + "/");
        System.out.print(args[2]);
    }
}
</pre>

<pre class="screen">
C:\javaApp>javac Test.java

C:\javaApp>java Test 2016 12 31
2016/12/31
</pre>
</article>