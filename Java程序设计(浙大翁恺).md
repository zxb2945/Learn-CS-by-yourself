# 翁恺 Java程序设计

## 1.1.2 第一个JAVA程序 20210825

```java
package hello;


public class Hello {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
        System.out.println("Hello World");
        System.out.println("中文");
        
        java.util.Scanner in = new java.util.Scanner(System.in);
        System.out.println("echo:" + in.nextLine());
        
        System.out.print(2+3 + "=2+3=" + (2+3));
        System.out.println("End");
        
// error     System.out.println("2+" + in.nextInt + "=" + (2+in.nextInt()));
//  in.nextInt与in.nextLine的区别可以看到in这个对象针对不同数据类型有不同方法     
        int price = in.nextInt();
        System.out.println("2+" + price + "=" + (2+price));
        
        float aTaa = 1.23F;
        double aTbb = 1.23;
// 与C语言不同的是，float类型数字后需加上F，否则好像会被认为是double类型...
// 有必要吗，类型申明了不就完事了嘛...        
	}
}

```



### 问题1：`print`与`println`的区别？

> `System.out.print()`，这个方法与`System.out.println()`很像，区别就在于，`System.out.println()`会在标准的输出中显示文字后换行，`System.out.print()`输出文字后不会换行。
>
> `Printf()`的使用方式也是一样的，用在`System.out`上，然后可以通过第一个格式控制符号来格式化输出的内容。  =>  参考C语言



### 问题2：package与 import机制？

 描述：好像Golang也是这样，Python只有后者... 假若说import相当于命名空间的话，那么多次import后产生冲突该如何解决？

> 让我们先了解一下，Java 的 package 到底有何用处。
>
> 其实，package 名称就像是我们的姓，而 class 名称就像是我们的名字。package 名称有很多 . 的，就好像是复姓。比如说 java.lang.String，就是复姓 java.lang，名字為 String 的类别；java.io.InputStream 则是复姓java.io，名字為 InputStream 的类别。
>
> 可是问题来了，因為很多套件的名称非常的长，在写程式时，会多打好多字，花费不少时间，於是，Sun 想了一个办法，就是 import。这个 import 就是在程式一开头的时候，先说明程式中会用到那些类别的简称，也就是只称呼名字，不称呼他的姓。
>
> 為甚麼我一开始说 import 跟 #include 不同呢？因為 import 的功能到此為止，它不像 #include 一样，会将档案内容载入进来。import 只是请编译器帮你打字，让编译器把没有姓的类别加上姓，并不会把别的档案的程式码写进来。如果你想练习打字，可以不要使用 import，只要在用到类别的时候，用它的全部姓名来称呼它就行了(就像例子一开始那样)，跟使用import 完全没有甚麼两样。

综合上述，package应该只是一个名命空间，而import是这个名命空间的导入。



### 问题3：System是怎样一个类？

描述：System是个类？那out是类中的类？

>  import java.lang.System;
>
> 因為java.lang 这个套件实在是太常太常太常用到了，几乎没有程式不用它的，所以不管你有没有写 import java.lang;，编译器都会自动帮你补上，也就是说编译器只要看到没有姓的类别，它就会自动去 java.lang 裡面找找看，看这个类别是不是属於这个套件的。所以我们就不用特别去import java.lang 了。



> java导入包中的任何一个public的类和接口(只有public类和接口才能被导入)
>
> 上面说到导入声明仅导入声明目录下面的类而不导入子包，这也是为什么称它们为类型导入声明的原因。
>
> 导入的类或接口的简名(simple name)具有编译单元作用域。这表示该类型简名可以在导入语句所在的编译单元的任何地方使用.这并不意味着你可以使用该类型所有成员的简名,而只能使用类型自身的简名。
> 例如: java.lang包中的public类都是自动导入的,包括Math和System类.但是,你不能使用它们的成员的简名PI()和gc(),而必须使用Math.PI()和System.gc().你不需要键入的是java.lang.Math.PI()和java.lang.System.gc()。
>
> 程序员有时会导入当前包或java.lang包，这是不需要的，因为当前包的成员本身就在作用域内,而java.lang包是自动导入的。java编译器会忽略这些冗余导入声明
> ————————————————
> 版权声明：本文为CSDN博主「一支纯牛奶」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/qq_25665807/article/details/74747868



### 问题4：JAVA的编译机制？

描述：+ 重载为字符串连接，这个重载机制定义在哪里？无需事先任何声明，是类似于JAVA运行库吗？

描述：System无需类似include这样的机制吗？



## 2.1.1 关系运算 20210827

> java里的ture和false不像c++中的bool型变量，在c++中ture和false都是有值的，分别为1和0，并且可以比较大小。
>
> 例如：（3>4）的值为0，（4==4）的值为1。所以（4==4）>(3>4)，或者ture==1也是对的。但在java里面ture和false是简单的字符表示正确或错误。他们不能与任意其他数比较大小并且ture和false也不能互相比较大小。因为他们是没有具体的值的，只是简单的**表示逻辑的字符串**而已。
> ————————————————
> 版权声明：本文为CSDN博主「唐流雨」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/qq_40808344/article/details/79605486

true和false如果本质上是字符串的话，它们能用“==”，这个容易理解，字符串对运算符号的重载嘛。

事实上，true和false在JAVA中有专门有别于整型和字符串的数据类型`boolean`.



## 3.1.1 循环 

与C语言相同，JAVA中的while和for可以互换，基本可以推测其在汇编层面上是相同的。Python是因为for有迭代器概念，两者汇编层面实现应该不同。



## 5.1.1 初识数组 20210831

```java
package hello;


public class Hello {

	public static void main(String[] args) {
		// TODO Auto-generated method stub        
        java.util.Scanner in = new java.util.Scanner(System.in);
        
        int x;
        int[] numbers = new int[100];
        double sum = 0;
        int cnt = 0;
        
        x = in.nextInt();
        while( x > -1 )
        {
            numbers[cnt] = x;
            sum = sum + x;
            cnt++;
            x = in.nextInt();
        } 
        if( cnt > 0 )
        {
            double average = sum/cnt;
            for( int i = 0; i < cnt; i++ )
            {
                if( numbers[i] > average )
                {
                    System.out.println(numbers[i]);
                }
            }
        }
	}
}

```

JAVA中的数组一旦定义了，它的长度就固定住了，这么说来跟C也没区别...C++似乎都可以伸缩...

（但似乎可以自己写类来做个动态的数组）

编译器不检查数组下标越界，运行时抛出异常，直接终止...



也可以，动态输入数组长度，然后再定义数组，如下

```java
        cnt = in.nextInt();
        int[] numbers = new int[cnt];
```

C语言是不可以这样做的，因为编译阶段，函数进栈，首先要预先获取固定长度的本地变量的栈，所以数组初始化长度必须固定。那么JAVA是如何处理这个问题的呢？

### 问题5：JAVA为什么能动态输入数组长度？

> 1.Java的内存机制
> 　Java 把内存划分成两种：一种是栈内存，另一种是堆内存。在函数中定义的一些基本类型的变量和对象的引用变量都是在函数的栈内存中分配，当在一段代码块定义一个变量时，Java 就在栈中为这个变量分配内存空间，当超过变量的作用域后（比如，在函数A中调用函数B，在函数B中定义变量a，变量a的作用域只是函数B，在函数B运行完以后，变量a会自动被销毁。分配给它的内存会被回收），Java 会自动释放掉为该变量分配的内存空间，该内存空间可以立即被另作它用。
>
> 　　**堆内存用来存放由 new 创建的对象和数组**，在堆中分配的内存，由 Java 虚拟机的自动垃圾回收器来管理。在堆中产生了一个数组或者对象之后，还可以在栈中定义一个特殊的变量，让栈中的这个变量的取值等于数组或对象在堆内存中的首地址，栈中的这个变量就成了数组或对象的引用变量，以后就可以在程序中使用栈中的引用变量来访问堆中的数组或者对象，引用变量就相当于是为数组或者对象起的一个名称。引用变量是普通的变量，定义时在栈中分配，引用变量在程序运行到其作用域之外后被释放。而数组和对象本身在堆中分配，即使程序运行到使用 new 产生数组或者对象的语句所在的代码块之外，数组和对象本身占据的内存不会被释放，数组和对象在没有引用变量指向它的时候，才变为垃圾，不能在被使用，但仍然占据内存空间不放，在随后的一个不确定的时间被垃圾回收器收走（释放掉）。这也是 Java 比较占内存的原因，实际上，栈中的变量指向堆内存中的变量，这就是 Java 中的指针！
> ————————————————
> 版权声明：本文为CSDN博主「haozi_ncepu」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/u013851082/article/details/72284330



```JAVA
        int[] a = new int[10];
        int[] b = a;
        b[5] = 100;
        
        System.out.println(a[5]);
```

上述代码输出 100，这就意味着a,b实质上可以看成指针。

在C语言中，数组不能互相赋值，因为地址名是地址常量。而JAVA中的数组名是地址指针，可以互相赋值！

(感觉上就介于C与Python之间，Python连一般的变量只要指向一定值范围内的数字常量，地址都是一样的...)



遍历一个数组的时候，特别适合用 for-each 循环模式。

```java
        int[] data = { 1, 2, 3, 4, 5};

        for( int k : data )
        {
            if(data[k] == 3)
            {
                System.out.println("Bingo"); 
                break;
            }
        }  
```

上例可以看到数组一种新的初始化方式。并且这个 for-each 就类似于Python中的 for...in 了，感觉隐含着一个迭代器的思想，这肯定与一般的for循环汇编实现不同，算是给数组遍历特别设计的一种语法吧。 而且这个 k 似乎只能在for中定义，不能拿出来...



另外来说，JAVA中的数组虽然不能伸缩，但仍然相对于C语言而言，已经被构建为一个类，所以有点运算符可以用，比如下例的`a.length`:

```java
        int[] a = new int[10];
        for(i=0;i<a.length;i++)
        {
            System.out.println("OK");
        }        
```



## 6.1.1 字符类型 20210901

> 回车”（Carriage Return）和“换行”（Line Feed）这两个概念的来历和区别。

`\r`:    回车

`\n` :   换行

源自以前打字机，打字机打字有一个车在移动，从头到尾，首先要将车从尾回到头（return），然后再将滚筒从上往下移一格（	next ）, 这就是打字机换行需要两个字符的由来。

> 在windows下：\r\n代表换行，拆分两个代码是：回到行首+换到下一行
> 但是在linux下的区别是：只用\n即可以代表换行。



JAVA主要四种数据类型：boolean, char, int, double （从6.2.1开始继续看）

