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



