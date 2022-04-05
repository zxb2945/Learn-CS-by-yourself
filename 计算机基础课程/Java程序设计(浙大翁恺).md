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
            if(data[k] == 3)  //这里错了吧？应该是if( k == 3), k不是下标而是成员
            {
                System.out.println("Bingo"); 
                break;
            }
        }  
```

上例可以看到数组一种新的初始化方式。并且这个 for-each 就类似于Python中的 for...in 了，感觉隐含着一个迭代器的思想，这肯定与一般的for循环汇编实现不同，算是给数组遍历特别设计的一种语法吧。 而且这个 k 似乎只能在for中定义，不能拿出来...

> 1.传统的for循环遍历，基于计数器的：
>
> 　　遍历者自己在集合外部维护一个计数器，然后依次读取每一个位置的元素，当读取到一最后一个元素后停止。主要是需要按元素的位置来读取。这也是最原始的集合遍历方法
>
> ​		从代码分析 ArrayList for遍历是通过数组下标获取数据
>
> 2.foreach 循环遍历：
>
> 屏蔽了显式声明的Iterator和计数器。内部也是采用了Iterator的方式实现，只不过Java编译器帮我们生成了这些代码
>
> Iterator本来是OO的一个设计模式，主要目的是屏蔽不同数据集合的特点，统一遍历集合的接口。Java作为一个OO语言，自然也在Collections中支持了Iterator模式。相比于传统for循环，Iterator取缔了显式的遍历计数器。所以基于存储集合的Iterator可以直接按位置访问数据。
>
> 　　优点：代码简洁，不易出错
>
> 　　缺点：只能做简单的遍历，不能在遍历过程中（删除、替换）数据集合
>
> ​		从代码分析 ArrayList forEach遍历 是通过Iterator迭代器遍历数据，也是通过数组下标获取数据
>
> ————————————————
> 版权声明：本文为CSDN博主「秋叶华」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/u014614478/article/details/109248113



另外来说，JAVA中的数组虽然不能伸缩，但仍然相对于C语言而言，已经被构建为一个类，所以有点运算符可以用，比如下例的`a.length`:

```java
        int[] a = new int[10];
        for(i=0;i<a.length;i++)
        {
            System.out.println("OK");
        }        
```



## 6.1.1 字符类型 20210904

> 回车”（Carriage Return）和“换行”（Line Feed）这两个概念的来历和区别。

`\r`:    回车

`\n` :   换行

源自以前打字机，打字机打字有一个车在移动，从头到尾，首先要将车从尾回到头（return），然后再将滚筒从上往下移一格（	next ）, 这就是打字机换行需要两个字符的由来。

> 在windows下：\r\n代表换行，拆分两个代码是：回到行首+换到下一行
> 但是在linux下的区别是：只用\n即可以代表换行。



JAVA主要四种基础数据类型：boolean, char, int, double

这些类型实际上都有相对应的包裹类型，其包裹类型有许多系统自带的方法，比如

```java
        int i = 10;
        Integer K =5;
        K = i;
        
        System.out.println(Integer.MAX_VALUE);
```

这个`Integer`就是`int`的包裹类型，而`Character`就是`char`的包裹类型。



字符串类型为`String`，首字母大写，表明它不是JAVA中的基础数据类型，而是由此发展而来的包裹类型，包裹类型实际上是系统自带的类！JAVA所谓的包裹类型正是C语言所没有的。

```java
        String input = in.next();
        if( input.equals("bye"))
        {
            System.out.println("OK");
        }
```

从上述角度来说，JAVA中的数组类型严格意义上也应该是包裹类型。

=》不应该这样认为，因为数组它不是一个类，没有方法可以调用，它只是在基础类型上的一个聚合类型？然后非常值得注意的是，这边数组定义的时候类型表现形式`int[] a`，这个C语言的定义很不相同，后者虽然有`char *argv[]`的形式，但还是不同，前者毕竟是堆里生成，后者栈中产生，只是特定条件下可以由编译器探测到长度而已。JAVA中数组的定义形式有可能是因为在堆中产生，所以编译器对其定义形式有了不同于C的新的追加。

以下引用援引C语言。

> 注意数组指针与指针数组的区别：
>
> ```
> char a[n][10]; /* a为数组指针，不可变，储存一个地址（相当于2级指针） */
> char *a[n]; /* 指针数组，适用于指向若干字符串，字符串没有大小限制，编译器一般优化为连续储存 */
> ```
>
> （另外，注意 *(a+1) 与 *(a[0]+1) 的区别）
>
> 了解指针数组作为main函数形参的形式：
>
> ```
> int main(int argc, char *argv[]); /* arguement count, arguement value */
> int main(int argc, char **argv); /* *argv[] => argv[][] => **argv, */
> ```
>
> 一般来说，argv[0]被系统自动赋值为程序运行的全路径名，而argv[argc]为NULL；
>
> （2019.9.18）



字符串因为是个对象，所以它自带点符号而来的字符串操作，而不用像C语言需要借助库函数。



## 8.1.0 对象的识别 20210907

```java
package display;


public class display {
    private int value = 0;
    private int limit = 0;
    
    public display(int limit) {
        this.limit = limit;
    }
    
    public void increase() {
        value++;
        if( value == limit ) {
            value = 0;
        }
    }
    
    public int getvalue() {
        return value;
    }

    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        display D = new display(24);
        
        for(;;)
        {
           D.increase();
           System.out.println(D.getvalue());
        }
    }

}

```

如果有一个成员函数的名字和类的名字完全相同，那么在创建每一个这个类的对象时，这个函数都会被调用，这个就被称为是**构造函数**。

一个类中重名但参数不同的函数构成了**重载函数**。



关于类与对象的关系，可以用用SICP中以下观点：

> 先创建类，从外层的类到基类，调用层层深入进去，然后实例化对象，从基类开始往外依此调用初始化函数最终抵达实例。（比喻来说，创建时先一层层进去拿到最核心的字典，即基类的字典，然后实例化时在从这个核一层层出来，包裹各层次之间的颜料，最后形成实例。）
>
> 每一个层次的字典（可以理解为方法集）都不一样，就可以理解类与对象各自有相应的方法，某种程度上类似于类与基类，从而也能理解各个层次间方法重载的机制，先是调用实例中的方法，如果找不到，就去类中寻找，并绑定到实例中执行。虽然也就一知半解，但感觉非常棒！



### 问题6：同一类的不同对象，在调用相同的成员函数时，入口地址相同吗？

> 一般成员函数的第一个参数默认是this（可以不写），this指针指向调用这个函数的对象，所以可以给函数传入不同的参数，输出不同的值，而且互不影响。
> 但是静态成员函数没有this指针。
>
> 定义的对象，编译器应该是分配了两个内存，内存之间数据是相互不影响的。你可以new出来指针查看变量地址。如果是打印的话，只能重载了或者用多态
>
> 即同一个类的对象使用不同的内存段，但静态成员共享相同的内存空间，只要不是静态成员函数，互相不会发生关系，也不存在冲突的问题。
>
> ————————————————
> 版权声明：本文为CSDN博主「羽生少年」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/jusu10/article/details/109220349

据以上分析，`static`成员估计是在类这一层次唯一存储，没有复制这一说，而成员函数，因为有默认参数`this`的存在，其实用不着复制各自分配内存，同样在类这一层次分配一次就足够了。

=》课程中把`static`称为类变量，同样有类函数，如

```java
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        display D = new display(24);
        
        for(;;)
        {
           D.increase();
           System.out.println(D.getvalue());
        }
```

这就表明该函数属于类，而不是具体一个对象。当然调用时，无论对象还是类均可以。

类函数就内存存储上其实与一般函数一样，难道区别仅仅是类函数没有默认的`this`参数？？？好像是哦，上例中的`main`里面创建了一个该类的对象然后通过对象才能去访问相关函数，所以它不属于任何对象，里面倒是可以直接访问类变量，仅此而已。



另外需要注意一点：类中方法内的本地变量和类的成员变量有生存期上的区别。



## 8.2.1 对象的交互 20210908

### 问题7：为什么`private`关键词要强调本类，而不是本对象？

好像有点没意思的问题...暂且不管



### 问题2：package与 import机制？

`pakage`实质是文件目录，一个工程一般有`src`和`bin`两个目录，前者下面的文件名就是`pakage`，然后其中就是一个或多个`.java`文件，这些`.java`文件自动被标记为该`pakage`。所以它是`src`和`.java`之间的一个文件目录层次。当然这并不意味着JAVA工程只能有一层目录，可以用`pakage1.pakage2`的形式多层目录，换句话说，即`src`与`.java`之间所有文件层次均为`pakage`。

而`import`一个其它`pakage`中的类，可以使当前调用方的类省略名字，类似起一个名命空间的 作用，当然也可以不`import`，直接写全名，所以没有像`include`那样是强制的。另外一般推荐`import`到类为止，而不是直接就把整个`pakage`塞进去，这样容易名命冲突，也就是说JAVA不自动解决这种冲突。

一个点`.java`文件是一个编译单元，一个编译单元可以有多个类，但是只有一个类可以为`public`，而且这个`public`类必须与文件名相同。为什么呢？因为其它`.java`文件`import`时表面上是到某个类为止，但实质上是到某个`.java`文件为止，所以它们应当同名，便于理解。

`pakage`是JAVA对包的管理机制由上体现。

```java
package clock;

import display.display;

public class clock {

    private display Hour = new display(24);
    private display Minute = new display(60);
    
    public void start() {
        while(true) {           
            Minute.increase();
            if(Minute.getvalue()==0) {
                Hour.increase();
            }
            System.out.printf("%02d:%02d\n",Hour.getvalue(),Minute.getvalue());
        }
    }
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        clock Clock = new clock();
        Clock.start();
    }

}
```



## 8.3.2 容器类型 20210915

容器需要两个类型：一个是容器自身的类型，一个是容器里的对象的类型

```java
package notebook;

import java.util.ArrayList;

public class notebook {
    
    private ArrayList<String> notes = new ArrayList<String>();
    
    public void AddNote(String e) {
        notes.add(e);
    }
    
    public int GetSize() {
        return notes.size();
    }
    
    public String[] List() {
        String[] a = new String[notes.size()];
        notes.toArray(a);
        return a;
    }

    public static void main(String[] args) {
        // TODO Auto-generated method stub

        notebook A = new notebook(); //设计上感觉，notebook就是继承ArrayList类的一个类
        A.AddNote("first");          //当然它不能用for-each循环
        A.AddNote("second");

        System.out.println(A.GetSize());
        
        String[] a = A.List();
        for(String e : a ) {
            System.out.println(e);
        }
        
        ArrayList<String> arr = new ArrayList<String>();
        arr.add("third");
        arr.add("forth");
        
        for(String e : arr ) {    //ArrayList和String一样可以用for-each循环
            System.out.println(e);
        }       
        
    }

}

```

ArrayList是系统内库中的一个类，可以看到是基于数组的，所以之前所说的JAVA中的数组不可动态扩展感觉跟C++不同，其实层次比较错误了，C++中数组当然也不能扩展，只是两者的数组基础上的容器可以！



正如上例中的`String[] a = new String[notes.size()];`, 对于对象数组而言，每个元素存放的是指向对象的指针（确切说应该是引用，但是JAVA中的引用更像是C中的指针），可以看成指针数组，所以可以初始化为`null`，而且默认就是初始化为`null`，要对对象中存放的字符串进行额外复制才能初始化，比如`a[0] = ""+1`.    这个在C中需要类比结构体数组，但是C中的结构体名是个变量，结构体数组里的元素无需是所谓的结构体指针，它能在栈中开辟出连续内存，通过类型判断进行数组下标移位操作，而JAVA对象数组中的元素就必须是指针，因为它在堆中开辟内存。

> Java的引用，并不与C++的引用相同，因此它不是一个别名；与对象变量也不同，它只是表示一个内存位置，该位置就是存在一个对象的位置，而不是真实的对象变量。并且从指针的意义角度来说，C/C++的指针与Java的引用却是不谋而合。它们都表是一个内存地址，都可以通过这个内存地址来操纵它所对应的对象。因此Java的引用更像C++中的指针，在下文中把它称为Java中的指针，同样也可称为Java中的引用。
>
> 上面只要谈到Java中指针与C++中指针相同或类似的部分，我觉得两者之间是有差别的，差别主要有三个。
>
>    C++中的指针是可以参与和整数的加减运算的，当一个指对指向一个对象数组时，可以通过自增操作符访问该数组的所有元素；并且两个指针能进行减运算，表示两个指表所指向内存的“距离”。而Java的指针是不能参与整数运算和减法运算的。
>
>    C++中的指针是通过new运算或对象变量取地址再进行赋值而初始化的，可以指向堆中或栈中的内存空间。Java同样是类似的，通new运算得到初始化。Java中指针只能是指向堆中的对象，对象只能生存在堆中。C语言是可以通过远指针来指向任意内存的地址，因而可以该问任意内存地址（可能会造成非法访存）；Java中的指针向的内存是由JVM来分配的中，由于new运算来实现，不能随所欲为地指向任意内存。
>
>    C++中通过delete和delete[] 运算符进行释放堆中创建的对象。如果对象生存周期完结束，但没有进行内存释放，会出现内存泄露现象。在Java中，程序员不用显式地释放对象，垃圾回收器会管理对象的释放问题，不用程序员担心。Java使用了垃圾回收机制使得程序不用再管理复杂的内存机制，使软件出现内存泄露的情况减少到最低。
>
>
> 版权声明：本文为CSDN博主「海枫」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/linyt/article/details/1573864



JAVA跟Python有许多类似的特点：比如说任何一个类实现`String toString()`方法，就可以被打印出字符串形式，这个跟Python中所谓的泛用方法就很类似，JAVA中被称为接口？？   

另外还有，JAVA中同样有类似Python中set集合的容器，比如说`HashSet`.

也可以像Python一样有类似字典的容器，如下

```java
        HashMap<Integer, String> name = new HashMap<Integer, String>();
        //HashMap作为容器，不能使用基本类型如int，而是要用其包裹类型Integer
        name.put(1, "one");
        name.put(2, "second");
        
        System.out.println(name.get(1));
```



## 8.4.2 继承和多态 20210921

```java
	public class CD extends Item{
        
    }
```

`protected`与`private`的区别：前者可以被子类调用，后者只能父类自己使用。所以这个`protected`主要针对继承来说的。

构造器初始化顺序：先初始化父类，再初始化自身定义初始化，最后初始化构造器内的变量。（Debug可观察）

### 问题8：构造器中`super()`的作用

> supersuper可以理解为是指向自己超（父）类对象的一个指针，而这个超类指的是离自己最近的一个父类。super也有三种用法：
>
> 1.普通的直接引用与this类似，super相当于是指向当前对象的父类，这样就可以用super.xxx来引用父类的成员。
>
> 2.子类中的成员变量或方法与父类中的成员变量或方法同名
>
> ```
> class  Country {
>      String name;
>      void  value() {
>         name =  "China" ;
>      }
> }
>   
> class  City  extends  Country {
>      String name;   
>      void  value() {
>      name =  "Shanghai" ;
>      super .value();       //调用父类的方法
>      System.out.println(name);
>      System.out.println( super .name);
>      } 
>      public  static  void  main(String[] args) {
>         City c= new  City();
>         c.value();
>         }
> }
> ```
>
> 运行结果：Shanghai China
>
> =》**子类父类可以有相同成员名，存储地址是不同的！不是简单覆盖**
>
> 可以看到，这里既调用了父类的方法，也调用了父类的变量。若不调用父类方法value()，只调用父类变量name的话，则父类name值为默认值null。
>
> 3.引用构造函数super（参数）：调用父类中的某一个构造函数（应该为构造函数中的第一条语句）。this（参数）：调用本类中另一种形式的构造函数（应该为构造函数中的第一条语句）。
>
> super和this的异同：
>
> - super（参数）：调用基类中的某一个构造函数（应该为构造函数中的第一条语句） 
> - this（参数）：调用本类中另一种形成的构造函数（应该为构造函数中的第一条语句）
> - super:　它引用当前对象的直接父类中的成员（用来访问直接父类中被隐藏的父类中成员数据或函数，基类与派生类中有相同成员定义时如：super.变量名  super.成员函数据名（实参）
> - this：它代表当前对象名（在程序中易产生二义性之处，应使用this来指明当前对象；如果函数的形参与类中的成员数据同名，这时需用this来指明成员变量名）
> - 调用super()必须写在子类构造方法的第一行，否则编译不通过。每个子类构造方法的第一条语句，都是隐含地调用super()，如果父类没有这种形式的构造函数，那么在编译的时候就会报错。
> - super()和this()类似,区别是，super()从子类中调用父类的构造方法，this()在同一类内调用其它方法。
> - super()和this()均需放在构造方法内第一行。
> - 尽管可以用this调用一个构造器，但却不能调用两个。
> - this和super不能同时出现在一个构造函数里面，因为this必然会调用其它的构造函数，其它的构造函数必然也会有super语句的存在，所以在同一个构造函数里面有相同的语句，就失去了语句的意义，编译器也不会通过。
> - this()和super()都指的是对象，所以，均不可以在static环境中使用。包括：static变量,static方法，static语句块。
> - 从本质上讲，this是一个指向本对象的指针, 然而super是一个Java关键字



变量的多态指在这个变量运行的时候，在具体的某一个时刻，他所管理的对象的类型有可能是不同的。即多态变量有两种类型：声明类型和动态类型。调用函数也有类似的多态现象，这里的技术基础是动态绑定。（静态绑定就是根据声明类型来绑定函数，而动态绑定是根据动态类型来绑定函数，JAVA中所有的成员函数调用皆是后者）。子类中与父类中有名字与参数完全相同的函数时，会出现override覆盖现象。

=>所谓的多态不仅仅是构造函数不同参数的函数重载，同样出现在继承中子类与父类成员函数的选择上

为什么子类对象能放进父类容器中 =》对于父类容器而言，声明时是父类类型，但实际执行时会多态成具体的子类类型。并不是对子类进行阉割放进父类中。这其实隐含着一种叫**向上造型**（cast）的机制，但对象的cast不同于普通类型的强制转化，后者就有可能有所谓的阉割，而前者不对对象自身有任何触碰，所以可以父类可以造型子类，但一般子类没法造型父类，这里的造型意味着被当作被看待，而不是被改造。

这里还有一个原因在于在除C++之外的面向对象语言中，对象是不可以进行赋值的，对象名严格意义上像一个类似指针的东西，他们之间的赋值只是管理权的变更，没法对某一具体的对象内容进行更改。



JAVA是个单根结构语言，即所有的类都是一个叫Object类的子类，而这个Object就是所谓的root.(除了C++其它OP语言都实现了这个单根) 

这个Object类中就有`toString()`和`equal()`以及一些线程处理方法.

因为`==`只能来说明两个对象是否管理同一对象，所以可以用`equal()`来比较两个对象具体的某一个内容。

注意 `@override`给编译器说去check一下是否完全覆盖父类的相关函数，包括名字与参数，否则报错。





面向对象不仅仅是语法层面加了个类，整个编程指导思想也要跟着改变。不是像C那种流程图，全是硬编码。各种if-else。比如说类之间要低耦合，首先数据能不用`public`就要用`private`, 尽量以框架+数据（数据和表现一开始就分开）来拓展可扩展性。比如说现在的工作中远程上锁代码，各个业务做个MAP映射数据结构是不是好一点？

### 问题9：String和StringBuffer之间的区别

> ```
> String str="abc";
> System.out.println(str);
> str=str+"de";
> System.out.println(str);
> ```
>
> 运行这段代码会发现先输出“abc”，然后又输出“abcde”，好像是str这个对象被更改了，其实，这只是一种假象罢了，JVM对于这几行代码是这样处理的，首先创建一个String对象str，并把“abc”赋值给str，然后在第三行中，其实JVM又创建了一个新的对象也名为str，然后再把原来的str的值和“de”加起来再赋值给新的str，而原来的str就会被JVM的垃圾回收机制（GC）给回收掉了，所以，str实际上并没有被更改，也就是前面说的String对象一旦创建之后就不可更改了。所以，Java中对String对象进行的操作实际上是一个不断创建新的对象并且将旧的对象回收的一个过程，所以执行速度很慢。
>
>  而StringBuilder和StringBuffer的对象是变量，对变量进行操作就是直接对该对象进行更改，而不进行创建和回收的操作，所以速度要比String快很多。
> ————————————————
> 版权声明：本文为CSDN博主「无忧少年」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/qq_45515432/article/details/103464806



## 8.6.1 抽象与接口 20210927

有抽象的函数的类不能被实例化，就是抽象类

```java
package shapes;

public abstract class Shape {   //因为有抽象函数，类前也要加abstract
    
    public abstract void draw();  //抽象函数没有函数体！即没{}
}

```



多继承（即同时从两个父类继承）在JAVA是不被允许的，事实上除了C++，所有OP语言（Python也除外？）都不支持多继承。

这里可以引出接口。

接口是纯抽象类：

1. 所有的成员函数都是抽象函数
2. 所有的成员变量都是`public static final` => `static`表明这个变量属于类而不是对象，`final`表示这个是常量（？），编译时就已经知道值

> 在JAVA中，如果一个类只由抽象方法和全局常量组成，那么这种情况下不会将其定义为一个抽象类。只会定义为一个接口，所以接口严格的来讲属于一个特殊的类，而这个类里面只有抽象方法和全局常量，就连构造方法也没有。

```java
package cell;

public interface Cell {   //interface默认是抽象类，连abstract都可以省了
    void draw();//用来画画展示
}
```

```java
public class Fox extends Animal implements cell{
    //...Override cell中的各个虚函数，然后可以作为一个cell类被使用
}
```

interface是一种特殊的class，它的引入是JAVA成功的关键。

设计程序时先定义接口，在实现类  =》 适合多人开发

任何需要在函数里传入传出的**一定是接口**而不是类（真的吗？）

也是JAVA受批评的原因，会导致代码量膨胀臃肿



`instanceof`也是关键词，用于判断某个对象是否属于某个类...





## 8.7.2 控制反转 20210930

> Swing 是一个为Java设计的GUI工具包。
>
> Swing是JAVA基础类的一部分。
>
> Swing包括了图形用户界面（GUI）器件如：文本框，按钮，分隔窗格和表
>
> 容器又分为顶级容器和中间容器。顶级容器是指图形界面最外层的容器，如窗口(Window)。中间容器是指存放在顶级容器或者中间容器中的一种容器，如面板(Panel)。在实际编程中，要开发一个界面应该是这样的，顶级容器在最外面(JFrame),其次是中间容器，放在窗体上(JPanel),最后是基本组件，如按钮(Button), 放在中间容器上。这里需要注意的是，容器中除了可以存放基本组件外，还可以存放容器
>
> 在Swing中，每个组件在容器中都有一个具体位置和大小，而在容器中摆放各种组件时很难判断其具体位置和大小。布局管理器提供了Swing组件安排、展示在容器中的方法及基本的布局功能。————————————————
> 版权声明：本文为CSDN博主「纪文啊！」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/qq_41338249/article/details/82413689



容器 Container

部件 Component

部件可以被加到容器中，因为容器本身也是一个部件，所以容器也可以被加到容器中



> 学习过Spring框架的人一定都会听过Spring的IoC(控制反转) 、DI(依赖注入)这两个概念
>
> **Ioc—Inversion of Control，即“控制反转”，不是什么技术，而是一种设计思想。**在Java开发中，**Ioc意味着将你设计好的对象交给容器控制，而不是传统的在你的对象内部直接控制。**
>
> **IoC对编程带来的最大改变不是从代码上，而是从思想上，发生了“主从换位”的变化。应用程序原本是老大，要获取什么资源都是主动出击，但是在IoC/DI思想中，应用程序就变成被动的了，被动的等待IoC容器来创建并注入它所需要的资源了。**
>
> 　　**IoC很好的体现了面向对象设计法则之一—— 好莱坞法则：“别找我们，我们找你”；即由IoC容器帮对象找相应的依赖对象并注入，而不是由对象主动去找**
>
> **DI—Dependency Injection，即“依赖注入”**：**组件之间依赖关系**由容器在运行期决定，形象的说，即**由容器动态的将某个依赖关系注入到组件之中**。**依赖注入的目的并非为软件系统带来更多功能，而是为了提升组件重用的频率，并为系统搭建一个灵活、可扩展的平台。**通过依赖注入机制，我们只需要通过简单的配置，而无需任何代码就可指定目标需要的资源，完成自身的业务逻辑，而不需要关心具体的资源来自何处，由谁实现。

> ### 2.1、IoC(控制反转)
>
> 　　首先想说说**IoC（Inversion of Control，控制反转）**。这是**spring的核心**，贯穿始终。**所谓IoC，对于spring框架来说，就是由spring来负责控制对象的生命周期和对象间的关系。**这是什么意思呢，举个简单的例子，我们是如何找女朋友的？常见的情况是，我们到处去看哪里有长得漂亮身材又好的mm，然后打听她们的兴趣爱好、qq号、电话号、ip号、iq号………，想办法认识她们，投其所好送其所要，然后嘿嘿……这个过程是复杂深奥的，我们必须自己设计和面对每个环节。传统的程序开发也是如此，在一个对象中，如果要使用另外的对象，就必须得到它（自己new一个，或者从JNDI中查询一个），使用完之后还要将对象销毁（比如Connection等），对象始终会和其他的接口或类藕合起来。
>
> 那么IoC是如何做的呢？有点像通过婚介找女朋友，在我和女朋友之间引入了一个第三者：婚姻介绍所。婚介管理了很多男男女女的资料，我可以向婚介提出一个列表，告诉它我想找个什么样的女朋友，比如长得像李嘉欣，身材像林熙雷，唱歌像周杰伦，速度像卡洛斯，技术像齐达内之类的，然后婚介就会按照我们的要求，提供一个mm，我们只需要去和她谈恋爱、结婚就行了。简单明了，如果婚介给我们的人选不符合要求，我们就会抛出异常。整个过程不再由我自己控制，而是有婚介这样一个类似容器的机构来控制。**Spring所倡导的开发方式**就是如此，**所有的类都会在spring容器中登记，告诉spring你是个什么东西，你需要什么东西，然后spring会在系统运行到适当的时候，把你要的东西主动给你，同时也把你交给其他需要你的东西。所有的类的创建、销毁都由 spring来控制，也就是说控制对象生存周期的不再是引用它的对象，而是spring。对于某个具体的对象而言，以前是它控制其他对象，现在是所有对象都被spring控制，所以这叫控制反转。**
>
> ### 2.2、DI(依赖注入)
>
> 　　**IoC的一个重点是在系统运行中，动态的向某个对象提供它所需要的其他对象。这一点是通过DI（Dependency Injection，依赖注入）来实现的**。比如对象A需要操作数据库，以前我们总是要在A中自己编写代码来获得一个Connection对象，有了 spring我们就只需要告诉spring，A中需要一个Connection，至于这个Connection怎么构造，何时构造，A不需要知道。在系统运行时，spring会在适当的时候制造一个Connection，然后像打针一样，注射到A当中，这样就完成了对各个对象之间关系的控制。A需要依赖 Connection才能正常运行，而这个Connection是由spring注入到A中的，依赖注入的名字就这么来的。那么DI是如何实现的呢？ Java 1.3之后一个重要特征是反射（reflection），它允许程序在运行的时候动态的生成对象、执行对象的方法、改变对象的属性，spring就是通过反射来实现注入的。
>
> 　　理解了IoC和DI的概念后，一切都将变得简单明了，剩下的工作只是在spring的框架中堆积木而已。



同一个java文件中各个类可以畅通地调用，不用拘泥于顺序声明。

进一步，在一个类中定义另外一个类，那么后者就成为了**内部类**，成为前者的成员，可以去使用前者的private变量，这是内部类最大的优势。

再进一步，类的函数中，在new对象的时候直接紧跟花括号给出类的定义形成**匿名类**，匿名类可以继承某类，也可以实现某一个接口，Swing的消息机制广泛使用匿名类。（匿名类是一种内部类，但不一定是类的内部类，有可能是类内函数的内部类）



Swing中实现Inversion of Control：

1. 由按钮公布一个守听者接口和一对注册，注销函数
2. 你的代码用匿名类形式自由调用当前类的成员变量和函数final本地变量实现那个接口，将守听者对象注册在按钮上
3. 一旦按钮被按下，就会反过来调用你的受听者对象的某个函数



MVC：Model+View+Control 设计模式  Model跟数据相关



## 8.8.4 异常 20211020

```java
package hello;

import java.util.Scanner;

public class Hello {

    public static void main(String[] args) {
        // TODO Auto-generated method stub               
        int[] a = new int [10];
        int idx;
        Scanner in = new Scanner(System.in);
        idx = in.nextInt();
        try {
            a[idx] = 10;
            System.out.println("hello");
        }catch(ArrayIndexOutOfBoundsException e){
            System.out.println("catch");
        }
                    
    }
}
```



假若说try里不断嵌套函数，并且函数中又有捕捉其它异常的try，JAVA的机制是就近check，从内而外，直到catch到相应的异常。这里就有个问题：发生异常的语句是否先验知道自己处于try语句中，还是发生异常后，层层出去detect？如果是后者，那么要出去到main才能终结吧...抛出异常走过的路还不少...

还可以在catch里添加`throw`，继续往外层抛，不然就在这一层面处理掉了。

为什么要用异常抛出机制？比如对于open,read,close的文件操作流，C语言中用return也能搞定，但是可读性就很差...没有try+catch来得明了，后者可以清晰地分离业务逻辑处理和异常处理，而不是像前者那样混杂在一起。



> ```java
> //必须声明它会抛出 BadException
> public void takeTisk() throws BadException {
>     if(abandonallHopes) {
>         //创建 Exception 对象并抛出
>         throw new BadException();
>     }
> }
> ```
>
> ```java
> public void crossFingers() {
>     //如果不用 try - catch包裹起来, 就必须声明 throws BadException  
>     try {
>         anObject.takeRisk();
>     } catch (BadException ex) {
>         System.out.println("Aaargh");
>         ex.printStackTrace();
>     }
> }
> 作者: Rikka
> 链接: https://www.bilibilianime.com/2020/12/27/Java%20%E5%9F%BA%E7%A1%80/Java_abc_11/
> 来源: 极东魔术昼寝结社
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
> ```
>
> 3. 什么东西可以扔出来
> 任何继承了 Throwable 类的对象
> Exception 类继承了 Throwbale
> throw new Exception();
> throw new Exception(“Something”);
>
> 4. catch 是怎样捕捉异常的
> 抛出子类的异常会被捕捉父类异常的 catch 捕捉到, 如 catch(Exception e){}会捕捉到所有的异常
> 运行时刻异常
> 像 ArrayIndexOutOfBoundsException 这样的异常不需要声明
> 5. 异常遇到继承
> 父类中的某个 Method 在子类中覆盖时, 必须保证子类中的同名方法不声明更多的异常抛出
> 子类的构造器中必须声明父类的全部异常
>
> 作者: Rikka
> 链接: https://www.bilibilianime.com/2020/12/27/Java%20%E5%9F%BA%E7%A1%80/Java_abc_11/
> 来源: 极东魔术昼寝结社
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



## 8.8.8 流 20211025

所有IO操作如read等都要配着异常机制一起搞...

Eclipse多行注释=》 Ctrl+/

```java
package hello;

import java.io.IOException;
import java.util.Scanner;

public class Hello {

    public static void main(String[] args) {
        // TODO Auto-generated method stub        
        
        System.out.println("hello world!");
        byte[] buffer = new byte[1024];  //byte也是JAVA中一种基本类型
        try {
            int len = System.in.read(buffer);
            String s = new String(buffer,0,len); //将byte类型转化为字符串（重载）然后打印
            System.out.println(s);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
                           
    }
}
```

> char是Java中的保留字，与别的语言不同的是，char在Java中是16位的，因为Java用的是Unicode。不过8位的ASCII码包含在Unicode中，是从0~127的。
>
> Java中使用Unicode的原因是，Java的Applet允许全世界范围内运行，那它就需要一种可以表述人类所有语言的字符编码。Unicode。但是English，Spanish，German, French根本不需要这么表示，所以它们其实采用ASCII码会更高效。这中间就存在一个权衡问题。
>
> char c='c'; //字符，可以是汉字，因为是Unicode编码
>
> char 在java中是2个字节。java采用unicode，2个字节（16位）来表示一个字符。
>
> 
>
> char与byte的区别:
>
> **byte** 是字节数据类型 ，是有符号型的，占1 个字节；大小范围为-128—127 。**char** 是字符数据类型 ，是无符号型的，占2字节(Unicode码 ）；大小范围 是0—65535 ；char是一个16位二进制的Unicode字符，JAVA用char来表示一个字符 。

