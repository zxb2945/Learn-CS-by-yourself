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



## 2.1.1 关系运算

