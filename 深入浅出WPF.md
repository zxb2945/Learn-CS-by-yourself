# 深入浅出WPF

视频地址：https://www.bilibili.com/video/BV1ht411e7Fe?p=5&vd_source=cfea4a81af3552025602bbed3cecda4f

## P1 Lesson1 剖析最简单的WPF程序

可以直接用Microsoft Windows SDK命令行界面csc编译器编译WPF，编译WPF hello world的时候引用一个WindowsPresentation的dll动态库，把target设置为winexe而不是exe就能编译出一个无控制台背景的wpf程序了。

在VS界面 项目->属性 里实际上就有这些 编译器选项。

vs的target有三种：windows程序，控制台程序和类库。 这三者被称为程序集。

```xaml
<Application x:Class="DataTransferTool.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:DataTransferTool" xmlns:ui="http://schemas.modernwpf.com/2019"
             StartupUri="MainWindow.xaml">
<!--StartupUri:启动的主窗口-->
    <Application.Resources>
    </Application.Resources>
</Application>
```

```xaml
<Window x:Class="DataTransferTool.MainWindow"      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DataTransferTool" Height="195" Width="430">
    <Grid>

    </Grid>
</Window>
<!--xmlns告诉编译器，如果见到如下字符串，就把一系列类库引入xaml文件中。
相当于C#文件的using...
所以切记它不是一个浏览器能够打开的网站，而是微软的硬编码。
-->
<!--xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"是xaml编译相关的类库，把它命名为x。那为什么xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"没有这个x呢，因为wpf规定有一个名称空间可以不加名字，被称为默认命名空间。
-->
```

```xaml
<!--如果你非要命名默认命名空间，也行。但你同时需要在<Window>和<Grid>加上修改后的名称空间，因为这两个标签属于 xmlns:n="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
-->
<n:Window x:Class="DataTransferTool.MainWindow"
        xmlns:n="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DataTransferTool" Height="195" Width="430">
    <n:Grid>

    </n:Grid>
</n:Window>
<!-- x:Class="DataTransferTool.MainWindow" 啥意思？ x命名空间下的Class，用来指示xaml编译器把编译的结果与C#文件MainWindow.xaml.cs中的DataTransferTool.MainWindow类以partial的形式编译在一起.
所以xaml.cs绝不是xaml的C#形式，而是辅助xaml的C#文件，他们甚至可以各自单独编译，如：
-->
```

```xaml
<!-- 将x:Class="DataTransferTool.MainWindow"改成x:Class="DataTransferTool.MyMainWindow"
-->
<Window x:Class="DataTransferTool.MyMainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DataTransferTool" Height="195" Width="430">
    <Grid>

    </Grid>
</Window>
```

```C#
namespace DataTransferTool
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            //InitializeComponent();=>需要注释掉
        }
    }
}
```

## P2 Lesson2 浅析用户界面的树形结构

WinForm：控件都在同一个平面上

WPF：xaml由xml派生而来，界面自然就像个树结构，所以所有控件有从属关系，就像C#项目的文件布局

## P3 在XAML中为对象属性赋值Attribute=Value

XAML是一种声明性语言，每创建一个标签，编译器就创建一个对象（注意不是变量）。

既然是对象，就可以用属性（注意不是字段）。

可以有三种形式对属性赋值：

1. 直接用Attribute=Value，value均为字符串类型

```
 Title="DataTransferTool" Height="195" Width="430"
```

2. 属性标签

可以利用转化器将字符串类型value转化为其他类型，转换器实质上是利用了C#的特性，将某个转化器AOP到某个类之前。

## P4 在XAML中为对象属性赋值.属性标签+标签扩展

注释 : Ctrl + k + c
取消注释 : Ctrl + k + u

其实分开按应该也可以 :

注释 : 先按Ctrl + k 再按Ctrl + c
取消注释 : 先按Ctrl + k 再按Ctrl + u



2. 属性标签：由类名.属性名构成。加在标签开始和结尾的部分被称为标签的内容，不要把标签的内容与对象的内容搞混。=>不懂啊，一个标签不就是一个对象嘛...大概需要把属性标签与一般标签区别开，前者实质是属性，而不是类

```xaml
<Window x:Class="DataTransferTool.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DataTransferTool" Height="195" Width="430">
    <Grid>
        <Button Width="120" Height="30">
            <!--Content-->
            <!--属性标签：由类名.属性名构成-->
            <Button.Content>
                <Rectangle Width="20" Height="20" Stroke="DarkBlue" Fill="Azure" />
            </Button.Content>
        </Button>
    </Grid>
</Window>
```

使用渐变色的例子

```xaml
<Window x:Class="DataTransferTool.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DataTransferTool" Height="195" Width="430">
    <Grid>
        <Button Width="120" Height="30">
            <!--Content-->
            <Button.Content>
                <Rectangle Width="20" Height="20" Stroke="DarkBlue">
                    <Rectangle.Fill>
                        <LinearGradientBrush>
                            <LinearGradientBrush.StartPoint>
                                <Point X="0" Y="0" />
                            </LinearGradientBrush.StartPoint>
                            <LinearGradientBrush.EndPoint>
                               <Point X="1" Y="1" />
                            </LinearGradientBrush.EndPoint>
                            <LinearGradientBrush.GradientStops>
                                <GradientStopCollection>
                                    <GradientStop Offset="0.2" Color="BlanchedAlmond"></GradientStop>
                                    <GradientStop Offset="0.7" Color="Black"></GradientStop>
                                    <GradientStop Offset="1.0" Color="WhiteSmoke"></GradientStop>
                                </GradientStopCollection>
                            </LinearGradientBrush.GradientStops>
                        </LinearGradientBrush>
                    </Rectangle.Fill>
                </Rectangle>
            </Button.Content>
        </Button>
    </Grid>
</Window>
```

可以简洁一些，能用Attribute=Value的形式的

```xaml
<Window x:Class="DataTransferTool.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DataTransferTool" Height="195" Width="430">
    <Grid>
        <Button Width="120" Height="30">
            <!--Content-->
            <Button.Content>
                <Rectangle Width="20" Height="20" Stroke="DarkBlue">
                    <Rectangle.Fill>
                        <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                            <LinearGradientBrush.GradientStops>
                                <GradientStop Offset="0.2" Color="BlanchedAlmond"></GradientStop>
                                <GradientStop Offset="0.7" Color="Black"></GradientStop>
                                <GradientStop Offset="1.0" Color="WhiteSmoke"></GradientStop>
                            </LinearGradientBrush.GradientStops>
                        </LinearGradientBrush>
                    </Rectangle.Fill>
                </Rectangle>
            </Button.Content>
        </Button>
    </Grid>
</Window>
```

3. 标签扩展：语法形式跟Attribute=Value，只是Value加花括号

   ```xaml
   <Window x:Class="DataTransferTool.MainWindow"
           xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
           xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
           xmlns:sys="clr-namespace:System;assembly=netstandard"
           Title="DataTransferTool" Height="195" Width="430">
       <Window.Resources>
           <sys:String x:Key="stringHello">Hello</sys:String>
       </Window.Resources>
       <Grid>
           <TextBlock Height="24" Width="120" Background="LightBlue"
                      Text="{StaticResource ResourceKey=stringHello}"/>
       </Grid>
   </Window>
   ```

   