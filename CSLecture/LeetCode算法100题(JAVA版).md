# 编程练习

## 1 Palindrome Number

2022.11.25

> Given an integer `x`, return `true` *if* `x` *is a* ***palindrome****, and* `false` *otherwise*.

```java
class Solution {
    public boolean isPalindrome(int x) {
        String str = String.valueOf(x);
        String str2 = new StringBuffer(str).reverse().toString();  
        if(str.equals(str2)){
            System.out.println(str);
            return true;
        }
        System.out.println(str2);
        return false;
    }
}
```

## 2 Remove Duplicates from Sorted Array

> Given an integer array `nums` sorted in **non-decreasing order**, remove the duplicates in-place such that each unique element appears only **once**. The **relative order** of the elements should be kept the **same**.
>
> Return `k` *after placing the final result in the first* `k` *slots of* `nums`.

```java
class Solution {
    public int removeDuplicates(int[] nums) {

        int count=1;
        for(int i =0 ;i<nums.length-1;i++){
            if(nums[i] != nums[i+1]){
                nums[count] =nums[i+1];
                count++;
            }
        }
        return count;
    
    }
}
```

## 3 Majority Element

> Given an array `nums` of size `n`, return *the majority element*.
>
> The majority element is the element that appears more than `⌊n / 2⌋` times. You may assume that the majority element always exists in the array.

```java
class Solution {
    public int majorityElement(int[] nums) {
        int i;

        Arrays.sort(nums);
        i = nums.length/2;

        return nums[i];       
    }
}
```

## 4 Happy Number

> Write an algorithm to determine if a number `n` is happy.
>
> A **happy number** is a number defined by the following process:
>
> - Starting with any positive integer, replace the number by the sum of the squares of its digits.
> - Repeat the process until the number equals 1 (where it will stay), or it **loops endlessly in a cycle** which does not include 1.
> - Those numbers for which this process **ends in 1** are happy.
>
> Return `true` *if* `n` *is a happy number, and* `false` *if not*.

```java
class Solution {
    int getNext(int n){
        int sum = 0;
        //split the number to digits
        while(n != 0){
            sum += Math.pow(n%10,2);
            n = n/10;
        }
        return sum;
    }
    
    public boolean isHappy(int n) {
        int slow, fast;
        slow = n;
        fast = n;

        while(true){
            slow = getNext(slow);
            fast = getNext(getNext(fast));
            if(slow == 1 || fast == 1){
                return true;
            }
            if(slow == fast){
                return false;
            }
        }
    }       
}
```

## 5 Best Time to Buy and Sell Stock

> You are given an array `prices` where `prices[i]` is the price of a given stock on the `ith` day.
>
> You want to maximize your profit by choosing a **single day** to buy one stock and choosing a **different day in the future** to sell that stock.
>
> Return *the maximum profit you can achieve from this transaction*. If you cannot achieve any profit, return `0`.

```java
class Solution {
    public int maxProfit(int[] prices) {
        int minP = prices[0], profit = 0, i;

        for(i = 0; i < prices.length; i++){
            minP = Math.min(prices[i],minP);
            profit = Math.max(profit, (prices[i] - minP));
            //minP = prices[i] > minP ? minP : prices[i];
            //profit = profit > (prices[i] - minP) ? profit : (prices[i] - minP);
        }
        
        return profit;        
    }
}
```

## 6 Reverse Bits

> Reverse bits of a given 32 bits unsigned integer.
>
> **Note:**
>
> - Note that in some languages, such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
> - In Java, the compiler represents the signed integers using [2's complement notation](https://en.wikipedia.org/wiki/Two's_complement). Therefore, in **Example 2** above, the input represents the signed integer `-3` and the output represents the signed integer `-1073741825`.

```java
public class Solution {
    // you need treat n as an unsigned value
    public int reverseBits(int n) {
        int ans = 0;
        for (int i = 0; i < 32; ++i){
           ans <<= 1;
           ans = ans | (n&1);
           n >>= 1;   
        } 
       return ans;       
/*		想通过转化为string来完成反转，JAVA没有stringstream类就很不方便
        byte[] arr = new byte[4];
        for(int i = 0; i < 4; i++){
            arr[i] = (byte)(n >> (i*8) & 0xFF);
            System.out.println(arr[i]);
        }
        System.out.println(Arrays.toString(arr));
        //StringBuffer str = new StringBuffer(arr);
        String str = new String(arr);
        System.out.println(str);
        String str2 = new StringBuffer(str).reverse().toString();
        System.out.println(str);  
        byte[] arr2 = str.getBytes();
        return 0;
 */      
    }
}
```

## 7 Contains Duplicate

> Given an integer array `nums`, return `true` if any value appears **at least twice** in the array, and return `false` if every element is distinct.

```java
class Solution {
    public boolean containsDuplicate(int[] nums) {
        Arrays.sort(nums);
        for(int i = 1; i < nums.length; i++){
            if(nums[i] == nums[i-1]){
                return true;
            }
        }
        return false;
    }
}
```

## 8 Same Tree

> Given the roots of two binary trees `p` and `q`, write a function to check if they are the same or not.
>
> Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isSameTree(TreeNode p, TreeNode q) {
        if(p == null && q != null) return false;
        if(p != null && q == null) return false;
        if(p == null && q == null) return true;
        if(p.val != q.val) return false;

        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
    }
}
```

## 9 Remove Duplicates from Sorted List

> Given the `head` of a sorted linked list, *delete all duplicates such that each element appears only once*. Return *the linked list **sorted** as well*.

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
         if(head == null) return head;
        
        ListNode temp = head;
        while(temp != null){
            if(temp.next != null && temp.val == temp.next.val){
                temp.next = temp.next.next;
            }else{
                temp = temp.next;
            }
        }

        return head;       
    }
}
```

## 10 Search Insert Position

> Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
>
> You must write an algorithm with `O(log n)` runtime complexity.

```java
class Solution {
    public int searchInsert(int[] nums, int target) {
        int i=0, j=nums.length-1;
		while(i<=j){
			int mid=i+(j-i)/2;
			if(nums[mid]==target){return mid;}
			else if(nums[mid]>target){j=mid-1;}
			else{i=mid+1;}
		}
		return i;
        
    }
}
```

## 11 Ugly Number

(2022.11.28)

> An **ugly number** is a positive integer whose prime factors are limited to `2`, `3`, and `5`.
>
> Given an integer `n`, return `true` *if* `n` *is an **ugly number***.

```java
class Solution {
    static int count=0;//static的用法
    public boolean isUgly(int n) {
        count++;
        if(n == 0) return false; //Otherwise runtime error
        if(n == 1){
            System.out.println("1");
            System.out.println("count="+count);//注意+
            return true;
        }        
        else if(n%2 == 0){
            System.out.println("2");
            n/=2; 
            return isUgly(n);
        } 
        else if(n%3 == 0){
            System.out.println("3");
            n/=3;
            return isUgly(n); 
        } 
        else if(n%5 == 0){
            System.out.println("5");
            n/=5;
            return isUgly(n); 
        } 

        return false;
    }
}
```

## 12 Fizz Buzz

> Given an integer `n`, return *a string array* `answer` *(**1-indexed**) where*:
>
> - `answer[i] == "FizzBuzz"` if `i` is divisible by `3` and `5`.
> - `answer[i] == "Fizz"` if `i` is divisible by `3`.
> - `answer[i] == "Buzz"` if `i` is divisible by `5`.
> - `answer[i] == i` (as a string) if none of the above conditions are true.

```java
class Solution {
    public List<String> fizzBuzz(int n) {
        //String[] answer = new String[n];
        List<String> answer = new ArrayList<>();
        for(int i = 1; i <= n; i++){
           // if(i%3 == 0 && i%5 == 0){
           if(i%15 == 0){   
                answer.add("FizzBuzz");
            }else if(i%3 == 0){
                answer.add("Fizz");
            }else if(i%5 == 0){
                answer.add("Buzz");
            }else{
                answer.add(i + "");
            }
        }
        return answer;
    }
}
```

备注：java类型转换 int=>String

```java
//num + "", String追加，这样会比较耗费时长，新建了2个对象
String var = num + "";
//String.valueOf(num)在底层调用的是Integer.toString(num)
Strng var = String.valueOf(num);
//为封装类转换,效率最快
String var = Integer.toString(num);
```

## 101 NOTE

### 1  Java-数组常用api

1. 获取数组长度：`arrays .length()`

   ```java
   //在Java中要求一个数组的长度也可以直接用length属性来获取
   int []A = {1,2,3}; 
   int len = A.length;
   ```

2. 返回指定数组的元素以字符串的形式：`arrays.toString();` 所以toSrting方法可以直接通过类名Arrays调用，可以提取目标数组所有元素，并按顺序转化为字符串

   ```java
   System.out.println(Arrays.toString(newArr));
   //输出：[1, 2, 4, 5, 6, 6, 5, 4, 7, 6, 7, 5]，带括号
   ```

3. 数组也有对应的增强for语句，语法结构如下：

   ```java
   //需要注意的是，必须新声明一个变量，使用声明过的变量是不可以的
   for(int i : array){
   System.out.println(i) //i依次取数组array每一个元素的值
   }
   ```

4. sort：数组排序

   ```java
   int[] a={10,2,30,45,5};
   Arrays.sort(a);
   ```

5. ...

### 2 Java的八大常用类

#### 2.1 包装类：

(Wrapper Class), 8种基本数据类型分别对应一个包装类,包装类均位于java.lang包。如：

| 基本数据类型 | 包装类  |
| ------------ | ------- |
| int          | Integer |
| ...          | ...     |

包装类的功能:		

1. 将字符串转化为数字`Integer.parseInt("100")`
2. 将数字转化为字符串`Integer.toString(100)`
3. 等等

#### 2.2 String类

String类、StringBuilder类、StringBuffer类是三个字符串相关类。String类的对象代表不可变的字符序列,StringBuilder类和StringBuffer类代表可变字符序列

#### 2.3 StringBuffer和StringBuilder类

StringBuffer和StringBuilder类非常相似,均代表可变的字符序列,两个类都是抽象类AbstractStringBuilder的子类,方法几乎一模一样
两个类的区别主要是:
- StringBuffer JDK1.0提供的类,线程安全,做线程同步检查,效率较低
- StringBuilder JDK1.5提供的类,线程不安全,不做线程同步检查,因此效率较高,建议使用

#### 2.4 Date类和DateFormat类

#### 2.5 Calender类日期类

#### 2.6 JDK8的日期类

#### 2.7 Math类和Random类

```Java
public class TestMath {
    public static void main(String[] args) {
        System.out.println(Math.max(10,2));//获得最大值
        System.out.println(Math.min(10, 5));//获得最小值
        System.out.println(Math.abs(-20));//获得绝对值
        System.out.println(Math.random());//生成0-1的随机数
    }
}
```

#### 2.8 枚举

所有的枚举类型隐性地继承自java.lang.Enum. 枚举实质上还是类!

### 3 JDK介绍（什么是JDK、JRE）

#### 3.1 JDK

JDK: ava Development Kit    Java开发工具包

JDK = JRE + Java 开发工具包（例如Javac，Java编译工具等）

JDK是提供给Java开发人员使用的，其中包含了Java的开发工具

版本历史

| **Java SE版本** | **JDK版本** | **发布时间** |
| --------------- | ----------- | ------------ |
| Java 1.0        | JDK1.0      | 1996-01-23   |
| J2SE 1.4        | JDK1.4      | 2004-09-29   |
| Java SE 5.0     | JDK1.5      | 2002-02-13   |
| Java SE 9       | JDK1.9      | 2017-09-21   |
| Java SE 10      | JDK10       | 2018-03-20   |
| Java SE 17      | JDK17       | 2021-09-14   |

#### 3.2 JRE

JRE: Java Runtime Environment    Java运行环境

JRE = JVM + Java SE (Standard Edition)标准类库

包括Java虚拟机（JVM Java Virtual Machine）和Java程序所需的核心类库等，如果想运行一个开发好的Java程序，计算机中只需要安装JRE即可。

#### 3.3 JVM 

JVM: Java Virtual Machine

JVM在整个jdk中处于最底层，负责于操作系统的交互，用来屏蔽操作系统环境.

Java语言的一个非常重要的特点就是与**平台的无关性**。而使用Java虚拟机是实现这一特点的关键。

### 4 Java中的类（基础详解）

#### 类 = 字段+方法

```java
class person{
    //name和age属于类中的字段
    String name;
    int age;
    //sayhello()函数属于类的方法
    void sayhello(){
        System.out.println("嗨嘿嗨");
    }
}
```

#### 类的修饰符 / 控制符

作用：可以修饰**类**，也可以修饰类中的成员（字段，方法）

第一类：访问修饰符

public: 可以被其他类所访问

private: 只能在同一个类中被访问

protected: 可以被不同包中的子类中被访问

如果不加修饰符，则只能在同一个类和同一个包中，这2中情况下访问。

备注：java文件中可以有多个类，但是只能有一个public类（这个public类的名字必须和文件名相同）。因为每一个java程序运行的时候都会先执行public这个类，而且只执行public类中的代码



第二类：其他修饰符 / 非访问控制符

static：静态的，非实例的，类的

final: 

1. 如果一个类被final修饰符所修饰和限定，说明这个类不能被继承，即不会拥有子类
2. final字段和final局部变量：它们的值一旦给定，就不能更改。

abstract: 抽象类, 不能被实例化。

### 5 Java.util包的框架

util包的框架：常用的**集合类**主要实现两个“super接口”而来：`Collection`和`Map`。

(Java集合类是我们在工作中运用最多的、最频繁的类。相比于数组(Array)来说，集合类的长度可变，更加适合于现代开发需求；)

#### 5.1 Collection

`Collection`有两个子接口：`List`, `Set`和`Queue`

`List`特点是**元素有序，且可重复**。实现的常用集合类有`ArrayList`、`LinkedList`，和`Vector`（线程安全）。

`Set`特点是**元素无序，不可重复**。实现的常用集合类有`HashSet`，`LinkedHashSet`，`TreeSet`（可排序）

##### 5.1.1 List

List中主要有ArrayList、LinkedList、Vector三个实现类；

`ArrayList`的实现最简单，采用的顺序表，底层就是一个`Object`数组，初始容量为10，每当元素要超过容量时，重新创建一个更大的数组，并把原数据拷到新数组中来。

```java
//创建ArrayList集合：
ArrayList<String> list = new ArrayList<String>();
ArrayList<String> list2 = new ArrayList<String>();
//按照顺序添加数据
list.add("a");
//在第N个数据后面添加一个数据
list.add(1,"b");
//将一个ArrayList中的所有数据添加到另外一个ArraList中
list.add(list2);
//将一个ArrayList中的所有数据添加到另外一个ArraList中的第N个元素之后
list.add(2,list2);
//按照位置删除单个数据
list.remove(2);
//按照内容删除单个数据
list.remove("a");
//...
//获取指定位置元素
String ele = list.get(2);
//修改指定位置的元素
list.set(2, "M");
//清空ArrayList
list.clear();
```

`LinkedList`采用双向链表。集合中的每一个元素都会有两个成员变量`prev`和`next`，分别指向它的前一元素和后一元素。

`Vector`底层实现和`ArrayList`类似，区别在于在许多方法上加了`synchronized`关键字，来实现了多线程安全。但代价是性能的降低。由于加锁的是整个集合，所以并发情况下进行迭代会锁住很长时间。

##### 5.1.2 Set

##### 5.2.3 Queue

#### 5.2  Map

`Map`是key、value键值对的集合.

特点是**key值无序不可重复，value值可重复**。常用的有`HashMap`，`HashTable`（线程安全），`TreeMap`（可排序）

### 6 Java.lang包简单总结

### 7 Java泛型详解

Java 泛型（generics）是 JDK 5 中引入的一个新特性.

泛型的本质是**类型参数化**，即给类型指定一个参数，然后在使用时再指定此参数具体的值，那样这个类型就可以在使用时决定了。这种参数类型可以用在类、接口和方法中，分别被称为泛型类、泛型接口、泛型方法。

```java
List<String> ans = new ArrayList<>();
```

#### 7.1 为什么使用泛型？

在没有泛型之前，从**集合中**读取到的每一个对象都必须进行类型转换，如果不小心插入了错误的类型对象，在运行时的转换处理就会出错。

比如：没有泛型的情况下使用集合：

```java
public static void noGeneric() {
ArrayList names = new ArrayList();
names.add("mikechen的互联网架构");
names.add(123); //编译正常
}
```

有泛型的情况下使用集合：

```java
public static void useGeneric() {
ArrayList<String> names = new ArrayList<>();
names.add("mikechen的互联网架构");
names.add(123); //编译不通过
}
```

有了泛型后，定义好的集合names在编译的时候add(123)就会编译不通过。

相当于告诉编译器每个集合接收的对象类型是什么，编译器在编译期就会做类型检查，告知是否插入了错误类型的对象，使得程序更加安全，增强了程序的健壮性。

#### 7.2 如何使用泛型

##### 7.2.1 泛型类

```java
//定义泛型类，在类名后添加一对尖括号，并在尖括号中填写类型参数，参数可以有多个，多个参数使用逗号分隔：
public class GenericClass<T> {
    private T value; 
    public void setValue(T value) {
        this.value = value;
    }
}
```

这个后面的参数类型也是有规范的

> T：任意类型 type
> E：集合中元素的类型 element
> K：key-value形式 key
> V： key-value形式 value

##### 7.2.2 泛型接口

```java
public interface GenericInterface<T> {
void show(T value);}
}

public class StringShowImpl implements GenericInterface<String> {
@Override
public void show(String value) {
System.out.println(value);
}}
```

##### 7.2.3 泛型方法

```java
/**
     *
     * @param t 传入泛型的参数
     * @param <T> 泛型的类型
     * @return T 返回值为T类型
     * 说明：
     *   1）public 与 返回值中间<T>非常重要，可以理解为声明此方法为泛型方法。
     *   2）只有声明了<T>的方法才是泛型方法，泛型类中的使用了泛型的成员方法并不是泛型方法。
     *   3）<T>表明该方法将使用泛型类型T，此时才可以在方法中使用泛型类型T。
     *   4）与泛型类的定义一样，此处T可以随便写为任意标识，常见的如T、E等形式的参数常用于表示泛型。
     */
    public <T> T genercMethod(T t){
        System.out.println(t.getClass());
        System.out.println(t);
        return t;
    }
 
 
public static void main(String[] args) {
    GenericsClassDemo<String> genericString  = new GenericsClassDemo("helloGeneric"); //这里的泛型跟下面调用的泛型方法可以不一样。
    String str = genericString.genercMethod("hello");//传入的是String类型,返回的也是String类型
    Integer i = genericString.genercMethod(123);//传入的是Integer类型,返回的也是Integer类型
}
```

### 8 java中接口（interface）详解

