# QT学习

1.Qt creator的Options中Kits，Qt versions，Compilers之间的关系是什么？

> 1.1 先说Compilers,即编译器。在windows平台一般用MSVC和MinGW这两种。MSVC是指微软的MicroSoft Visual C++ 编译器，MinGW即Minimalist GNU on Windows，是GNU组织提供的编译器。
>
> 1.2 再说Qt version:，即Qt 版本。不严格来说，Qt是一个编译好的各种工具的库，每次发布这个库都会有一个版本号（比如你安装的5.9.1），并且用MinGW和MSVC各编译一份。如果你安装了MinGW的库，之后开发程序就用MinGW的编译器编译，发布的时候使用MinGW的库。如果安装的MSVC的库，就用MSVC的。同时都安装也是可以的，一般不交叉使用。库中有一个很重要的可执行程序叫qmake.exe（它自然也分MinGW和MSVC两种），是用来构建Qt项目的。在Qt version界面，就是以qmake作为qt版本的依据。
>
> 1.3 Kits，中文翻译叫构建套件。如果点击你那个Qt 5.9.1 MinGW，就会看到，里面包含了套件名字，设备，C/C++编译器，调试器，Qt 版本等信息。这些东西搭配在一起，成为一个套件。常见的情况是以MSVC编译 + CDB调试，作为一个套件，MinGW编译+
> GDB调试作为另一个套件。当你开发/导入一个Qt项目的时候，就需要选择相应的套件。
>
> 2、qt-opensource-windows-x86-msvc2013_64-5.5.1.exe 是一个综合的安装包，下载后安装的时候可以选择装哪个编译器对应的库。一般选MinGW 或者MSVC，也可以选Android开发用的arm编译器。安装完成时，如果系统里已经有MSVC编译器、或者安装了Qt提供的MinGW编译器，一般是会自动给你配置好kit的，不需要再配置。



2.anchors.fill和anchors.centerIn区别

> **anchors**翻译过来叫“锚”，锚可能不好理解，在我看来，可以把anchors当成是一个控件浓缩而成的一个点，可以通过设置点的上下左右等属性来控制界面外观，控制项与项之间的关系。
>
> anchors.centerIn:parent,是将子控件放在父控件的正中心，子控件的宽高是自己设置的；anchors.fill：parent, 是在子控件的大小设置与父控件大小一样，特别是mouseArea中经常使用anchors.fill：parent，这是为了指定鼠标事件接受的范围。如果是两个矩形控件，颜色不同，那么子控件会完全覆盖父控件，全是子控件的颜色显示。



# c++

Difference between C and C++

C++ was developed as an extension of [C](https://www.w3schools.com/c/index.php), and both languages **have almost the same syntax**.

The main difference between C and C++ is that C++ **support classes and objects,** while C does not.



C++ is an **object-oriented programming language** which gives a clear structure to programs and allows code to be reused, lowering development costs.



> 1、继承   
>  被继承的是父类（基类），继承出来的类是子类（派生类），子类拥有父类的所有的特性。
>  继承方式有公有继承、私有继承，保护继承。默认是私有继承
>
> 公有继承中父类的公有和保护成员在子类中不变，私有的在子类中不可访问。
> 私有继承中父类的公有和保护成员在子类中变为私有，但私有的在子类中不可访问。
> 保护继承中父类的公有和保护成员在子类中变为保护，但私有的在子类中不可访问。
>  c++语言允许单继承和多继承，
>  
> 优点：继承减少了重复的代码、继承是多态的前提、继承增加了类的耦合性；
> 缺点：继承在编译时刻就定义了，无法在运行时刻改变父类继承的实现；父类通常至少定义了子类的部分行为，父类的改变都可能影响子类的行为；如果继承下来的子类不适合解决新问题，父类必须重写或替换，那么这种依赖关系就限制了灵活性，最终限制了复用性。
> 虚继承：为了解决多重继承中的二义性问题，它维护了一张虚基类表。
>
> ## Inheritance
>
> In C++, it is possible to inherit attributes and methods from one class to another. We group the "inheritance concept" into two categories:
>
> - **derived class** (child) - the class that inherits from another class
> - **base class** (parent) - the class being inherited from
>
> To inherit from a class, use the `:` symbol.
>
> In the example below, the `Car` class (child) inherits the attributes and methods from the `Vehicle` class (parent):
>
> 2、多态
>  多态性是指对不同类的对象发出相同的消息将会有不同的实现
>  C++有两种多态，称为动多态（运行期多态）和静多态（编译器多态），静多态主要是通过模板来实现，而动多态是通过虚函数来实现的。即在基类中存在虚函数（一般为纯虚函数）子类通过重载这些接口，使用基类的指针或者引用指向子类的对象，就可以调用子类对应的函数，动多态的函数调用机制是执行器期才能确定的，所以他是动态的。
>  
> 优点：大大提高了代码的可复用性；提高了了代码的可维护性，可扩充性；
> 缺点：易读性比较不好，调试比较困难； 模板只能定义在头文件中，当工程大了之后，编译时间十分的变态；
>
> ## Polymorphism
>
> Polymorphism means "many forms", and it occurs when we have many classes that are related to each other by inheritance.
>
> Like we specified in the previous chapter; [**Inheritance**](https://www.w3schools.com/CPP/cpp_inheritance.asp) lets us inherit attributes and methods from another class. **Polymorphism** uses those methods to perform different tasks. This allows us to perform a single action in different ways.
>
> For example, think of a base class called `Animal` that has a method called `animalSound()`. Derived classes of Animals could be Pigs, Cats, Dogs, Birds - And they also have their own implementation of an animal sound (the pig oinks, and the cat meows, etc.):
>
> 3、封装
>  隐藏类的属性和实现细节，仅仅对外提供接口，
>  封装性实际上是由编译器去识别关键字public、private和protected来实现的，体现在类的成员可以有公有成员(public)，私有成员(private)，保护成员(protected)。私有成员是在封装体内被隐藏的部分，只有类体内说明的函数(类的成员函数)才可以访问私有成员，而在类体外的函数时不能访问的，公有成员是封装体与外界的一个接口，类体外的函数可以访问公有成员，**保护成员是只有该类的成员函数和该类的派生类才可以访问的。**
>
>  优点：隔离变化；便于使用；提高重用性；提高安全性
>  缺点：如果封装太多，影响效率；使用者不能知道代码具体实现。
>
> The meaning of **Encapsulation**, is to make sure that "sensitive" data is hidden from users. To achieve this, you must declare class variables/attributes as `private` (cannot be accessed from outside the class). If you want others to read or modify the value of a private member, you can provide public **get** and **set** methods.
>
> 
>
> 重载和覆盖
> 定义：
> 重载：写一个与已有函数同名但是参数表不同的函数。
> 覆盖：虚函数总是在派生类中被改写，即函数名和参数都一样，只是函数的实现体不一样。。
> 类的关系区别：
> 覆盖是子类和父类之间的关系，是垂直关系；重载是同一个类中方法之间的关系，是水平关系
>
> ## Function Overloading
>
> With **function overloading**, multiple functions can have the same name with different parameters:
>
> 
>
> ————————————————
> 版权声明：本文为CSDN博主「你看看这个C还有++」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/qq_43414142/article/details/100892336





c++中 双冒号作用

符号::的前面一般是类名称，后面一般是该类的成员名称，C++为例避免不同的类有名称相同的成员而采用作用域的方式进行区分
如：A,B表示两个类，在A,B中都有成员member。那么
   A::member 就表示 类A 中的 成员member
   B::member 就表示 类B 中的 成员member 



C++子类的构造函数后面加冒号的作用

1. 对父类进行初始化

2. 对类成员进行初始化

3. 对类的const成员变量进行初始化



模板（Template）指 C++ 程序设计设计语言中采用类型作为参数的程序设计，支持通用程序设计。C++ 的标准库提供许多有用的函数大多结合了模板的观念，如 STL 以及 IO Stream

```
1.函数模板
template <class T> void swap(T& a, T& b){}，
 返回类型 函数名(参数列表)
2.类模板
template<class T> class A
```

