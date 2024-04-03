# C# 学习笔记

# 1 发展概况

## 1.1 C#版本历史

[参考](https://www.tutorialsteacher.com/csharp/csharp-version-history)

| Version | .Net               | **Visual Studio**  | Important Features |
| ------- | ------------------ | ------------------ | ------------------ |
| C# 1.0  | .NET Framework 1.0 | Visual Studio 2002 | Basic features     |
| C# 2.0  | .NET Framework 2.0 | Visual Studio 2005 | Generics           |
| C# 3.0  | .NET Framework 3.0 | Visual Studio 2008 | Lambda expressions |
| C# 4.0  | .NET Framework 4.0 | Visual Studio 2010 |                    |
| C# 5.0  | .NET Framework 4.5 | Visual Studio 2012 |                    |
| C# 6.0  | .NET Framework 4.6 | Visual Studio 2013 |                    |
| C# 7.0  | .NET Core 2.0      | Visual Studio 2017 | out variables      |
| C# 8.0  | .NET Core 3.0      | Visual Studio 2019 | Readonly members   |
| C# 9.0  | .NET 5.0           | Visual Studio 2019 |                    |
| C# 10.0 | .NET 6.0           | Visual Studio 2022 |                    |

=>netcoreapp3.1 是 .NET Core 的一个版本号

## 1.2 .NET框架历史

[参考](https://codedefault.com/p/difference-between-net-framework-and-net-core)

### 1.2.1 .NET Framework

在.NET Core出现之前，微软的应用开发主要运行载体是自家的操作系统，即Windows操作系统。
2002年时，微软发布了.NET框架的早期版本，当前只有一个框架，即.NET Framework。不久之后，微软又发布了.NET 精简版框架(.NET Compact Framework)，这是.NET框架的一个子集，适用于更小的设备，特别是Windows移动设备(Windows Mobile)。这个精简版的框架是一个独立于.NET框架的代码库。它包括了整个运行时的垂直结构:运行时、框架和顶部的应用程序模型。

.NET Framework是微软为开发应用程序而创建的主要运行在Windows操作系统的软件框架。它包含了大量的FCL(Framework Class Library)框架类库并且提供了多种语言之间的跨语言互操作。.NET Framework平台的应用程序在公共语言运行时(CLR)中执行，CLR是一个应用程序的虚拟机，它提供安全、内存管理和异常处理等服务。因此，使用.NET Framework编写的计算机代码称为“托管代码”。框架类库(FCL)和公共语言运行时(CLR)一起构成了.NET Framework。

### 1.2.2 .NET Core

早期(.NET Core之前)的.NET应用程序是不跨平台(操作系统的)，它只能运行在Windows操作系统上，并且操作系统中还必须安装.NET Framework环境。如果要运行在其他操作系统上，需要借助第三方的框架，比如: **Mono**—一个开源的第三方.NET Framework框架，它可以运行在Linux和Mac OS操作系统上。

2011年5月,Mono开发者为了使用C#开发跨平台的移动设备应用，成立并发布了**Xamarin**后于2016年被微软收购，但这只是微软跨平台的第一步，毕竟Xamarin只适合开发移动端应用。

随意移动设备迅速占领市场，Windows平台的大势已去。直到.NET Core，.NET才算真正的跨平台，这也是微软重大的战略转变。2014年12月，微软拥抱开源社区，宣布开源了.NET Core的核心代码，也是.NET跨平台迈出的最重要的一步。

经过不断地迭代，2016年6月发布和.NET Core 1.0，2017年3月发布.NET Core1.1.1。

.NET Core是一种模块化实现，可用于各种垂直领域，从数据中心扩展到基于触摸的设备，它是**开源的，跨平台的**，能在Windows、LinuxMac OSX等操作系统上运行，同时还支持Docker等容器化环境安装和部署。

### 1.2.3 .NET

微软为了统一.NET平台，计划将所有的.NET运行时统一为一个.NET平台，并为所有应用程序模型(如：.NET Core, Windows Forms, WPF, UWP, Xamarin, Blazor)提供统一的基类库(BCL)。在2019年5月6日宣布了.NET 5将是.NET Core 3.0的下一个主要版本。

2020年3月，微软发布了.NET 5的第一个预览版，并在同年的11月10日发布了.NET 5的第一个正式版。

**.NET生态系统有三个主要的高级组件——.NET Framework、.NET Core和Xamarin组成。**=>.NET包含.NET Framework和.NET Core ！

**.NET Framework**：支持Windows和Web应用程序。现在，你仍然可以使.NET Framework作为目标框架来构建运行于Windows操作系统的Winform、WPF和UWP等桌面应用程序，以及基于ASP.NET MVC的Web应用程序。

**.NET Core**：是一个新的、开源的、跨平台框架，它用于构建适用于跨操作系统的应用程序，包括Windows、Mac和Linux。

如果你是一位.NET的初学者，并者没有历史项目(基于.NET Framework框架的项目)的包袱，建议你可以直接从.NET Core(.NET 5)入手学习，因为它具备现代开发技术的绝大多数优点：开源，跨平台，支持容器化部署等。



=> 总结来说 .NET Framework一直专用于Windows平台，然后第三方开源了跨平台的Xamarin，微软于是也拥抱开源，开发了跨平台的.NET Core ，之后又索性把这三个框架都联合起来继承进 .NET 里去了，所以很好理解.NET 取名字于.NET Framework和.NET Core的交集嘛。

VS2022就是偏重于跨平台开发，默认的就是 .NET 6.0 和 .NET 7.0（可以理解为继承自.NET Core，又同时把.NET Framework丰富的底层库给包含进来），那你能保证就专用于Windows平台，也行，就可以在.NET里去寻找 .NET Framework模块取用，比如创建项目时有WPF App和 WPF App(.NET Framework)两个种类，后者才能选择用.NET Framework 4.6.1  (2023.8.17)

## 1.3 C#编译原理

[参考](https://www.igiven.com/dotnet-2020-02-13-csharp-run/)

用C#编写的源代码会被**C#编译器**编译为一种符合CLI规范的中间语言（IL）。IL代码以一种称为**程序集**的可执行文件的形式(.dll/.exe)存储在磁盘上。

执行C#程序时，程序集将加载到CLR中，**即时编译器**(JIT: just-in-time Compiler)会将IL代码转换为本机机器指令。CLR还提供与自动垃圾回收、异常处理和资源管理有关的其他服务。由CLR执行的代码有时会称为“托管代码”。

> 什么是非托管代码(unmanaged code)？
>
> 非托管代码，直接编译成目标计算机码，在公共语言运行库环境的外部，由操作系统直接执行的代码，代码必须自己提供垃圾回收，类型检查，安全支持等服务。如需要内存管理等服务，必须显示调用操作系统的接口，通常调用Windows SDK所提供的API来实现内存管理。

### 1.3.1 CIL

> ##### CIL，公共中间语言（Common Intermediate Language）
>
> CLI，简称微软中间语言（MSIL）或者中间语言（IL）。CIL是编译器将.NET代码编译成公共语言运行时（CLR）能够识别的中间代码。它是一种介于高级语言（例如C#）和CPU指令之间的一种语言。当用户编译一个.NET程序时，编译器（例如VisualStudio）将C#源代码编译转换成中间语言 (MSIL)，它是一种能够被CLR转换成CPU指令的中间语言，当执行这些中间语言时，CLR提供的实时（JIT）编译器将它们转化为CPU特定的代码。由于公共语言运行库支持多种实时编译器，因此同一段中间语言代码可以被不同的编译器实时编译并运行在不同的CPU结构上。从理论上来说，MSIL将消除多年以来业界中不同语言之间的纷争。在.NET的世界中可能出现下面的情况一部分代码可以用C++实现，另一部分代码使用C#或VB.NET完成的，但是最后这些代码都将被转换为中间语言。这给程序员提供了极大的灵活性，程序员可以选择自己熟悉的语言，并且再也不用为学习不断推出的新语言而烦恼了。

### 1.3.2 CLI

> ##### CLI，公共语言基础架构（Common Language Infrastructure）
>
> CLI是一个开放的技术规范。它是由微软联合惠普以及英特尔于2000年向ECMA倡议的。通用语言基础架构定义了构成.NET Framework基础结构的可执行码以及代码的运行时环境的规范，它定义了一个语言无关的跨体系结构的运行环境，这使得开发者可以用规范内定义的各种高级语言来开发软件，并且无需修正即可将软件运行在不同的计算机体系结构上。CLI有时候会和CLR混用。但严格意义上说，这是错误的。因为CLI是一种规范，而CLR则是对这种规范的一个实现。
>
> 欧洲计算机制造商协会（ECMA）已经于2001年10月13日批准C#语言规范（ECMA-334）成为一种新诞生的计算机产业标准。同时国际标准组织ISO也同意该标准进入该组织的审批阶段。并且，作为.NET与CLR的核心部分，CLI与C#也同时获得了ECMA的批准（ECMA-335）。拥有了C#与CLI这两项标准，你可以自己写出能够运行于任何操作系统上的.NET平台（只要你愿意）。如前所述，著名的MONO项目就是这么干的，MONO项目包括三个核心的部分：一个C#语言的编译器，一个CLI和一个类库。

### 1.3.3 CLR

.NET框架由两大部分组成:

1. CLR（Common LanguageRuntime），又称公共语言运行时或公共语言运行环境，是.NET系统架构中核心的部分，CLR和Java虚拟机JVM一样是一个运行时环境。

2. FCL(Framework Class Library)，.NET框架类库（.NET Framework class library）是构成.NET框架的另一个实体，它提供数千个类、接口等工具供程序员使用。

> ##### BCL，基础类库（Base Class Library）
>
> BCL是一个公共编程框架，称为基类库，所有语言的开发者都能利用它。是CLI（Common Language Infrastructure，公共语言基础结构）的规范之一，主要包括：执行网络操作，执行I/O操作，安全管理，文本操作，数据库操作，XML操作，与事件日志交互，跟踪和一些诊断操作，使用非托管代码，创建与调用动态代码等，粒度相对较小，为所有框架提供基础支持。
>
> ##### FCL，框架类库（Framework Class Library）
>
> FCL提供了大粒度的编程框架，它是针对不同应用设计的框架 ，FCL大部分实现都引用了BCL，例如我们常说的开发框架：ASP.NET、MVC、WCF和WPF等等，提供了针对不同层面的编程框架 。

(2023.3.24)

### 1.3.4 程序集（Assembly）

> 程序集是代码进行编译是的一个逻辑单元，把相关的代码和类型进行组合，然后生成PE文件。程序集只是逻辑上的划分，一个程序集可以只由一个文件组成，也可由多个文件组成。不管是单文件程序集还是多文件程序集，它们都由固定的结构组成
>
> 常见的两种程序集：
>
> 可执行文件（.exe文件）和 类库文件（.dll文件）。

(2023.3.28)

### 1.3.5  项目配置文件

[Reference](https://cloud.tencent.com/developer/article/1341150)

#### 1.3.5.1 csproj 文件

> 在旧版本的项目文件中，项目所有的引用（dll/nuget/com/项目）全部糅杂在一起，对人来说很不友好。并且nuget包的引用全部保存在项目的packages.config文件中，但是包还原时却是还原在解决方案文件(sln)同目录的packages目录下，导致包路径错误的问题。
>
> 但是在新版风格（NetCore）的项目文件中，大大减少，文件默认使用文件系统引用，不再显示记录在csproj文件中，使得项目文件可以很容易的手动修改各种配置。

旧csproj 文件：

```xml
<?xml version="1.0" encoding="utf-8"?>
<!---所有的 csproj 文件都是以 Project 节点为根节点 -->
<Project ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <!--- 无论是新 csproj 还是旧 csproj 文件，都有两个 Import 节点。
  Import 进来的文件用两种扩展名，定义属性的那一种是 .props，定义行为的那一种是 .targets。这两种文件除了含义不同以外，内容的格式都是完全一样的——而且——就是 csproj 文件的那种格式！由于有 Import 的存在，所以一层一层地嵌套 props 或者 targets 都是可能的。-->
  <!--- 旧格式 csproj 文件中第一行一定会 Import 的 Microsoft.Common.props --> 
  <!--- 引入的 props 文件可以实现几乎与 csproj 文件中一样的功能 -->
  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')" />
  <!--- PropertyGroup是用来存放属性的地方 -->
  <!--- 些属性的含义完全是由外部来决定的，例如编译过程中会使用 TargetFrameworkVersion 属性，以确定编译应该使用的 .NET Framework 目标框架的版本 --> 
  <PropertyGroup>
    <Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
    <Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
    <ProjectGuid>{C16F1466-2440-4996-BA7E-933C21F78087}</ProjectGuid>
    <OutputType>Library</OutputType>
    <AppDesignerFolder>Properties</AppDesignerFolder>
    <RootNamespace>CsvToTable</RootNamespace>
    <AssemblyName>CsvToTable</AssemblyName>
    <TargetFrameworkVersion>v4.6.1</TargetFrameworkVersion>
    <FileAlignment>512</FileAlignment>
    <Deterministic>true</Deterministic>
    <NuGetPackageImportStamp>
    </NuGetPackageImportStamp>
  </PropertyGroup>
    <!--- 有的属性在 Debug 和 Release 下不一样（例如条件编译符 DefineConstants） -->
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
    <DebugSymbols>true</DebugSymbols>
    <DebugType>full</DebugType>
    <Optimize>false</Optimize>
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
    <DebugType>pdbonly</DebugType>
    <Optimize>true</Optimize>
    <OutputPath>bin\Release\</OutputPath>
    <DefineConstants>TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <!--- ItemGroup 是用来指定集合的地方 
    Reference: 引用某个程序集
	PackageReference: 引用某个 NuGet 包
	ProjectReference: 引用某个项目
	Compile: 常规的 C# 编译
    None: 没啥特别的编译选项，就为了执行一些通用的操作（或者是只是为了在 Visual Studio 列表中能够有一个显示）-->
  <ItemGroup>
    <Reference Include="System" />
    <Reference Include="System.Core" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="List.cs" />
    <Compile Include="Properties\AssemblyInfo.cs" />
  </ItemGroup>
  <ItemGroup>
    <ProjectReference Include="..\CommonAndConst\CommonAndConst.csproj">
      <Project>{0768f8e7-4dab-4c93-9563-cd8f7b70536f}</Project>
      <Name>CommonAndConst</Name>
    </ProjectReference>
  </ItemGroup>
  <ItemGroup>
    <None Include="app.config" />
    <None Include="packages.config" />
  </ItemGroup>
  <!--- Target 节点一般写在 csproj 文件的末尾，编译过程就是靠这些 Target 的组合来完成的。 --> 
  <!--- 引入的下面这份 .targets 文件便包含了 msbuild 定义的各种核心编译任务(即Target标签)。能够完成绝大多数项目的编译。 -->
  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" />
    <!--- 新的 Microsoft.NET.Sdk 以不兼容的方式原生支持了 NuGet 包管理。也就是说我们可以在不修改 csproj 的情况之下通过 NuGet 包来扩展 csproj 的功能。而旧的格式需要在 csproj 文件的末尾添加如下代码才可以获得其中一个 NuGet 包功能的支持： -->    
  <Import Project="..\packages\Stub.System.Data.SQLite.Core.NetFramework.1.0.118.0\build\net46\Stub.System.Data.SQLite.Core.NetFramework.targets" Condition="Exists('..\packages\Stub.System.Data.SQLite.Core.NetFramework.1.0.118.0\build\net46\Stub.System.Data.SQLite.Core.NetFramework.targets')" />  
  <Target Name="EnsureNuGetPackageBuildImports" BeforeTargets="PrepareForBuild">
    <PropertyGroup>
      <ErrorText>This project references NuGet package(s) that are missing on this computer. Use NuGet Package Restore to download them.  For more information, see http://go.microsoft.com/fwlink/?LinkID=322105. The missing file is {0}.</ErrorText>
    </PropertyGroup>
    <Error Condition="!Exists('..\packages\Stub.System.Data.SQLite.Core.NetFramework.1.0.118.0\build\net46\Stub.System.Data.SQLite.Core.NetFramework.targets')" Text="$([System.String]::Format('$(ErrorText)', '..\packages\Stub.System.Data.SQLite.Core.NetFramework.1.0.118.0\build\net46\Stub.System.Data.SQLite.Core.NetFramework.targets'))" />
  </Target>
</Project>
```

新csproj 文件：

> 新的项目文件会隐式生成程序集信息，无需Properties\AssemblyInfo.cs文件

```xml
<!--- 新格式中 Project 节点有 Sdk 属性，因为有此属性的存在，新csproj 文件才能如此简洁。 
所谓 Sdk，其实是一大波 .targets 文件的集合。它帮我们导入了公共的属性、公共的编译任务，还帮我们自动将项目文件夹下所有的 **\*.cs 文件都作为 ItemGroup 的项引入进来。-->  
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>WinExe</OutputType>
    <TargetFramework>net6.0-windows</TargetFramework>
    <UseWPF>true</UseWPF>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="MaterialDesignThemes" Version="4.9.0" />
    <PackageReference Include="Prism.Unity" Version="8.1.97" />
    <PackageReference Include="WindowsAPICodePack-Shell" Version="1.1.1" />
  </ItemGroup>
  <ItemGroup>
    <Resource Include="Resources\Eric.ico" />
  </ItemGroup>
</Project>
```

区别：

| 旧csproj         | 新csproj                   |
| ---------------- | -------------------------- |
| xml声明          |                            |
| Project          | Project(SDK)               |
| Import(props)    | Import(props)  => 可省略   |
| PropertyGroup    | PropertyGroup              |
| ItemGroup        | ItemGroup                  |
| Import(targets)  | Import(targets)  => 可省略 |
| Target => 可省略 | Target  => 可省略          |

> ### 编译器是如何将这些零散的部件组织起来的？
>
> 这里说的编译器几乎只指 msbuild 和 Roslyn，前者基于 .NET Framework，后者基于 .NET Core。不过，它们在处理我们的项目文件时的行为大多是一致的——至少对于通常项目来说如此。
>
> 当 Visual Studio 打开项目时，它会解析里面所有的 `Import` 节点，确认应该引入的 .props 和 .targets 文件都引入了。随后根据 `PropertyGroup` 里面设置的属性正确显示属性面板中的状态，根据 `ItemGroup` 中的项正确显示解决方案管理器中的引用列表、文件列表。——这只是 Visual Studio 做的事情。
>
> 在编译时，msbuild 或 Roslyn 还会重新做一遍上面的事情——毕竟这两个才是真正的编译器，可不是 Visual Studio 的一部分啊。随后，执行编译过程。它们会按照 `Target` 指定的先后顺序来安排不同 `Target` 的执行，当执行完所有的 `Target`，便完成了编译过程。
>
> ### 新旧 csproj 在编译过程上有什么差异？
>
> 新旧格式之间其实并没有什么差异。或者更严格来说，差异只有一条——新格式在 Project 上指定了 `Sdk`。真正造成新旧格式在行为上的差别来源于默认为我们项目 `Import` 进来的那些 .props 和 .targets 不同。新格式通过 `Microsoft.NET.Sdk` 为我们导入了更现代化的 .props 和 .targets，而旧格式需要考虑到兼容性压力，只能引入旧的那些 .targets。

#### 1.3.5.2 packages.config

> **Before VS2017 and .NET Core**, NuGet was not deeply integrated into MSBuild so it needed a separate mechanism to list dependencies in a project: `packages.config`. Using Visual Studio solution explorer's References context menu, developer adds `.csproj` references to restored packages in a solution-wide folder managed by NuGet.
>
> The reference added to the project file `.csproj` by Visual Studio looks like this:
>
> ```xml
> <Reference Include="EntityFramework, Version=6.0.0.0">				          <HintPath>..\packages\EntityFramework.6.4.4\lib\net45\EntityFramework.dll</HintPath>
> </Reference>
> ```
>
> **Starting with VS2017 and .NET Core**, NuGet becomes a first class citizen in MSBuild. NuGet package dependencies are now listed as PackageReference in the SDK-style project file `.csproj`
>
> A reference now looks like this:
>
> ```xml
> <PackageReference Include="EntityFramework" Version="6.4.4" />
> ```

（2023.10.16）

#### 1.3.5.3 .NET Upgrade Assistant

[refer](https://learn.microsoft.com/zh-cn/dotnet/core/porting/upgrade-assistant-overview)

1. NuGet Manager Console中安装 ：

   ```
   dotnet tool install -g upgrade-assistant
   ```

2. View->Terminal中执行：

   ```
   upgrade-assistant upgrade xxx.csproj/xxx.sln
   ```

3. 可选择只升级csproj文件

4. 删除package.config, Properties\AssemblyInfo.cs 以及诸如app.config这类旧版本自动生成的文件

(2023.10.17)

# 2 常规语法

## 2.1 语法

### 2.1.1 访问控制修饰符

**JAVA：**

1. 修饰类时：public 和 无访问控制修饰符 两种情况。每个 Java 程序的**有且只有一个**类是 public（入口Main函数所在的类），它被称为主类，其他外部类无访问控制修饰符，具有包访问性。
2. 修饰内部成员时：public, protected, 无访问控制修饰符, private.

**C#：**

> 如果被问到C#中默认的访问修饰符是什么？你该怎么回答，是不是感觉不太好说！我把资料整理如下， 仅供参考！
>
> 首先，必须明确的是C#中的访问修饰符有5种：
>
> 1. public
>    同一程序集中的任何其他代码或引用该程序集的其他程序集都可以访问该类型或成员。
> 2. private
>    只有同一类或结构中的代码可以访问该类型或成员。
> 3. protected
>    只有同一类或结构或者此类的派生类中的代码才可以访问的类型或成员。
> 4. **internal**
>    同一程序集中的任何代码都可以访问该类型或成员，但其他程序集中的代码不可以。
> 5. protected internal
>    由其声明的程序集或另一个程序集派生的类中任何代码都可访问的类型或成员。 
>    从另一个程序集进行访问必须在类声明中发生，该类声明派生自其中声明受保护的内部元素的类，并且必须通过派生的类类型的实例发生
>
> 下面分情况进行叙述：
>
> 1. 命名空间下元素的默认访问修饰符：**命名空间下只能使用两种访问修饰符public和internal**。如果没有显示的给这些元素访问修饰符，其修饰符默认为internal。
>
> 2. 各类型中的成员访问修饰符：类中所有的成员，**默认均为private**，当然也可以修改成其它的访问修饰符；接口的成员默认访问修饰符是public，也不可能是其他访问修饰符；命名空间，枚举类型成员默认public，也不可能是其他访问修饰符。
>
> 版权声明：本文为CSDN博主「卡尔曼和玻尔兹曼谁曼」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/theonegis/article/details/23109695

(2023.3.28)

### 2.1.2 继承与多态

=>相较于C++中的virtual关键字，可以分为一般虚函数和纯虚函数（函数末尾加“=0”的语法形式，必须被子类重写），C#中的virtual关键字就只一般虚函数，而且需要搭配override关键字进行重写。

另外，即便父类中没有virtual修饰特定函数，而你又特别想重写这个函数，你仍可以使用new关键字进行类似于重写的操作，即把父类相关函数隐藏，调用子类中重写new出来的函数。

new与override的区别：用父类类型变量去接收所创建的子类时，子类中override重写的方法仍旧可以覆盖父类中的方法，而new重写的方法就不行，即仍旧会调用父类中的同名方法。参考 [视频](https://www.bilibili.com/video/BV1aM411h75X/?spm_id_from=333.788&vd_source=6fc477a8e79179a3fd30bed2e2ba5fbe)(2023.11.29)

=>对于纯虚函数, C#中用 abstract 修饰，此函数在基类中不能被实现，而在子类中必须被实现。

```c#
    abstract class ImBase
    {
        protected ImBase() { }

        //abstract 与 virtual的区别
        protected abstract void FuncA();
        protected abstract void FuncB();
        protected virtual void FuncC() { return; }   
        protected void FuncD() { return; }
    }

    class Father : ImBase
    {
        protected Father() { }

        //必须实现FuncA()与FuncB()，可以选择不实现FuncC()
        //应用于方法或属性时，sealed 修饰符必须始终与 override 结合使用
        protected sealed override void FuncA() { return; }
        //public override void FuncB() { return; } => override覆盖不能改变 访问级别
        protected override void FuncB() { return; }
        public new void FuncD() { return; } // new覆盖可以 改变访问级别
    }

    class Child : Father 
    { 
        protected Child() { }

        //protected override void FuncA() { return; } => it can't be inherited， because it is sealed.
        protected override void FuncB() 
        {
            FuncA();
            return; 
        }      
    }
```

> 应用于某个类时，sealed 修饰符可阻止其他类继承自该类。 还可以对子类的虚方法或属性的方法或属性使用 sealed 修饰符。 这使你可以阻止子类的子类对其覆写。

=> C# 中的 sealed 与 Java 中的 final 作用基本相同。

(2023.10.28)

### 2.1.3 namespace

C++：

以C++中的标准输出为`std::cout`例:

```C++
#include<iostream> //cout所属类型ostream定义在iostream头文件中
using namespace std;//cout定义在命名空间std中
```



C#：

在代码中直接引用时，C#并不沿用C++中的域操作符`::`，而是用`.`操作符。如使用`System.Windows.Controls`命名空间中的`Button`对象。

```C#
internal System.Windows.Controls.Button Btn;
```

using语句的用法在C#相对于C++省略了`namespace`：

```C#
using System;
using System.Collections.Generic;
using System.IO;
//C#的命名空间相当于C++中头文件与命名空间的综合作用。

//C#6中支持这种写法，这样定义后可以可以访问类的静态成员(2023.10.20)
using static System.Console;
```

另外C#的namespace：

1. 可以加点号，例如

```c#
namespace Example_Tool.Views {
    //...
}
namespace Example_Tool.ViewModels {
    //...
}
namespace Example_Tool.Models {
    //...
}
```

2. **和文件名、目录层次无关**：C#里不要求文件名和类名、目录有对应关系

(2023.3.28)

=>一个namespace可以位于不同文件夹。

### 2.1.4 预处理

C++中编译过程中存在预处理器，预处理有两个作用：1.创建宏；2.条件编译。

C#的编译器没有一个单独的预处理器，其预处理只有条件编译这一用途。

```C#
#if true
   //...
#else
   //...
#endif    
```

(2023.4.14)

经常用于区别Debug版本与Release版本的不同逻辑：

```C#
                    catch (Exception ex)
                    {
#if DEBUG
                        ErrorMessage("---{" + ex.Message + ex.StackTrace + "}---");
#else
                        ErrorMessage("spc9999", "----", sheetName + ":" + sheetFieldName);
#endif
                    }
//DEBUG是被系统预先定义好的，无需手动控制
```

(2023.12.11)

### 2.1.5 struct

> C# 中结构类型和类类型在语法上非常相似，他们都是一种数据结构，都可以包括数据成员和方法成员。 结构和类的区别： 1、**结构是值类型，它在栈中分配空间；而类是引用类型，它在堆中分配空间，栈中保存的只是引用**。 2、结构类型直接存储成员数据，让其他类的数据位于堆中，位于栈中的变量保存的是指向堆中数据对象的引用。

=>最直观的区别就是，类中子类必须new后才能被使用，或定义时直接new，或在初始化器内new，而struct定义后直接可以被使用，更接近于字段。

(2023.8.1)

### 2.1.6 Lambda

**C#的Lambada形式：**使用**Lambda声明运算符=>**（该运算符读作”goes to”），从其主体中分离Lambda参数列表。若要创建Lambda表达式，需要在Lambda运算符左侧指定输入参数（如果有参数时），然后在另一侧输入表达式或语句块。

1. 表达式Lambda，表达式为其主体：

```csharp
(input-parameters) => expression
1
```

2. 语句Lambda，语句块作为其主体：

```csharp
(input-parameters) => {<sequence-of-statements>}
```

=>表达式和语句块的区别在于加不加{}

=>C#中Lambda声明运算符"=>"与C++中的"->"不同。



**C#中Lambada的主要用途：**

1. 用于委托中，简化委托的匿名语法；
2. 用于LINQ；

> 任何Lambda表达式都可以转换为委托类型，可以转换的委托类型由参数和返回值的类型定义。如果Lambda表达式不返回值，则可以将其转换为Action委托类型之一；否则，可将其转换为Func委托类型之一。例如，有两个参数且不返回值的Lambda表达式可转化为Action<T1, T2>委托。有一个参数且不返回值的Lambda表达式可转换为Func<T, TResult>委托。
> 例如：Lambda表达式x => x * x，指定名为x的参数，并返回x的平方值，并将表达式x => x * x分配给委托类型的变量。
>
> ```c#
> Func<int, int> Square = x => x * x;
> Console.WriteLine($"输出：{Square(10)}");
> //输出：100
> ```
>
> 用C#编写LINQ时，还可以使用Lambda表达式，如下所示：
>
> ```C#
> int[] numbers = { 1, 5, 3, 9, 28, 35, 5, 32, 34 };
> var squaredNumbers = numbers.Select(x => x * x);
> Console.WriteLine(string.Join("", squaredNumbers));
> ```

3. 用于异步处理；



**C#中Lambada的特性：**

> Lambda表达式中的类型推理：编写Lambda时，通常不必为输入参数指定类型，因为编译器可以根据Lambda主体、参数类型以及C#语言规范中描述的其它因素来推断类型。
>
> 捕获Lambda表达式中的外部变量和变量范围：Lambda可以引用外部变量。这些变量是在定义Lambda表达式的方法中或包含Lambda表达式的类型中的范围内变量。以这种方式捕获的变量将进行存储以备在Lambda表达式中使用，即使在其它情况下，这些变量将超出范围并进行垃圾回收。必须明确地分配外部变量，然后才能在Lambda表达式中使用该变量。
> ————————————————
> 版权声明：本文为CSDN博主「草原上唱山歌」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/shanniuliqingming/article/details/123663991

=>C#的Lambda不表明就可以引用外部变量，而不像C++需要事先声明捕获列表[=] (表示按值捕获变量)或 [&] (表示按引用捕获变量)。

(2023.4.20)

### 2.1.7 字符串相关特性

#### 2.1.7.1 @

> C# 中字符串常量可以以@ 开头声名，这样的优点是转义序列“不”被处理，按“原样”输出，即我们不需要对转义字符加上 \ （反斜扛），就可以轻松coding.

```C#
Class2.TextReader("C:\\test\\testreadtest.txt");
Class2.TextReader(@"C:\test\NewCsvFile123.csv");
```

#### 2.1.7.2 $

> C# 中`$`符号的作用是C#6.0中新出现的一个特性，也即是字符串的拼接优化。
>
> 还记得你们用过的格式化字符串吗？`string.Format()` 这个方法，是最常用的方法之一。
>
> 那`$`又是什么呢？它是为了替代`string.format()`的，**原先赋值需要占位符和变量**，当需要拼接多个变量会造成语句过长等不易理解问题。

> 语法格式：`$"string {参数}"`
>
> 解释：以`$`符号开头开始字符串，其中以`{}`来进行传参，可以多个参数累加。

例如：

```C#
Console.WriteLine($"Error !! : {csvList[i].Nodename} because {ex.Message}");
```

##### Appendix

> C# 占位符{}
>
> ```c#
> Console.WriteLine("A:{0}，a:{1}",65,97);
> //A:65，a:97
> ```
>
> **占位符从零开始计数**,且占位符中的数字不能大于第二个及后面的参数的总个数减一(要求占位符必须有可替换的值)。

#### 2.1.7.3 +

C#中连接字符串的方法，通常有以下几种：

方法1：利用+符号可以将两个字符串连接起来

```C#
var sw = new System.IO.StreamWriter(@"C:\Tool\DATA\" + $"{csvList[i].Nodename}.csv", true, Encoding.GetEncoding("UTF-8"))
```

方法2：Append（使用StringBuilder类）

> Append构建字符串的效率比使用+连接的高，如果有较多的字符串需要拼接，建议使用append进行拼接；少的话，使用用+更方便阅读。
>
> C#中也可以使用 **String.Concat 函数**来连接字符串。但是这不光是耗费内存，还耗费cpu执行的时间。不建议使用。

(2023.4.19)

### 2.1.8 this用法

C#的this有许多种用法，这里介绍其中一种：静态扩展方法，顾名思义给某个类增加自定义方法

> 扩展方法的**核心三要素是静态类，静态方法，和this参数**。

在下面的 WriteToCsvFile方法中，参数前面加 this ，可以理解为 给 DataTable类 添加了一个 静态方法 WriteToCsvFile，用于将DataTable输出为csv文件，我们可以在其他的类中使用 DataTable类型变量直接调用这个方法了，而不需要使用 DataTableExtensions.WriteToCsvFile() 这种方式调用。

```C#
//1.扩展的方法需是静态方法，且位于静态类中；
public static class DataTableExtensions
{
    //2.扩展方法的第一个参数以this修饰符为前缀，后跟要扩展的目标类型(DataTable)及参数；
    public static void WriteToCsvFile(this DataTable dataTable, string filePath)
    {
        StringBuilder fileContent = new StringBuilder();

        foreach (var col in dataTable.Columns)
        {
            fileContent.Append(col.ToString() + ",");
        }

        fileContent.Replace(",", System.Environment.NewLine, fileContent.Length - 1, 1);

        foreach (DataRow dr in dataTable.Rows)
        {
            foreach (var column in dr.ItemArray)
            {
                fileContent.Append("\"" + column.ToString() + "\",");
            }

            fileContent.Replace(",", System.Environment.NewLine, fileContent.Length - 1, 1);
        }

        System.IO.File.WriteAllText(filePath, fileContent.ToString());
    }
}

//3.扩展方法只能针对实例调用，也就是说，目标类不能为静态类；
DataTable dataTable = new DataTable();
dataTable.WriteToCsvFile("C:\\example.csv");
```

(2024.2.14)

## 2.2 数据结构

### 2.2.1 Dictionary

> **常用属性**
>
>   名称  说明
>   Comparer   获取用于确定字典中的键是否相等的 IEqualityComparer。
>   Count    获取包含在 Dictionary 中的键/值对的数目。
>   Item     获取或设置与指定的键相关联的值。
>   Keys     获取包含 Dictionary 中的键的集合。
>   Values    获取包含 Dictionary 中的值的集合。
>
> **常用方法**
>   名称  说明
>   Add         将指定的键和值添加到字典中。
>   Clear        从 Dictionary 中移除所有的键和值。
>   ContainsKey     确定 Dictionary 是否包含指定的键。
>   ContainsValue    确定 Dictionary 是否包含特定值。
>   Equals(Object)   确定指定的 Object 是否等于当前的 Object。 （继承自 Object。）
>   Finalize      允许对象在“垃圾回收”回收之前尝试释放资源并执行其他清理操作。 （继承自 Object。）
>   GetEnumerator    返回循环访问 Dictionary 的枚举器。
>   GetHashCode     用作特定类型的哈希函数。 （继承自 Object。）
>   GetObjectData    实现 System.Runtime.Serialization.ISerializable 接口，并返回序列化 Dictionary 实例所需的数据。
>   GetType       获取当前实例的 Type。 （继承自 Object。）
>   MemberwiseClone   创建当前 Object 的浅表副本。 （继承自 Object。）
>   OnDeserialization  实现 System.Runtime.Serialization.ISerializable 接口，并在完成反序列化之后引发反序列化事件。
>   Remove       从 Dictionary 中移除所指定的键的值。
>   ToString      返回表示当前对象的字符串。 （继承自 Object。）
>   TryGetValue     获取与指定的键相关联的值。,



```C#
public class Solution {
    public int NumIdenticalPairs(int[] nums) {
        //定义Dictionary =>记得使用前要像Java那样用new初始化，并不会像C++那样自动初始化
        Dictionary<int,int> map = new Dictionary<int,int>();
        for(int i = 0; i < nums.Length; ++i){
            if(map.ContainsKey(nums[i])){
                ++map[nums[i]];
            }else{
                map.Add(nums[i], 1);
            }           
        }

        int ans = 0;
		//遍历Dictionary中的key
        foreach(int key in map.Keys){
            int count = map[key];
            ans = ans + count*(count - 1)/2;            
        }

        return ans;         
    }
}
```

```C#
//Dictionary 初始化
        private Dictionary<string, string> beforeAfterDataTemplate = new Dictionary<string, string>()
        {
            //**********************************
            //Node Basic Information
            //**********************************
            /// NR NEID (gNBid)
            {"NR_NEID", "(Error)" },
            /// LTE NEID(eNBid)
            {"LTE_NEID", "(Error)" },
        }
//Dicitonary 拷贝
var beforeAfterData = new Dictionary<string, string>(beforeAfterDataTemplate);
```



### 2.2.2 String

#### 2.2.2.1 String与string的区别

> 1.string是c#中的类，String是.net Framework的类(在c# IDE中不会显示蓝色) ;
>
> 2.c# string映射为.net Framework的String ;
>
> 3.如果用string,编译器会把它编译成String，所以如果直接用String就可以让编译器少做一点点工作 ;
>
> 4.如果使用c#，建议使用string，比较符合规范 ; 
>
> 5.string始终代表 System.String(1.x) 或 ::System.String(2.0) ;
>
> 6.String只有在前面有using System;的时候并且当前命名空间中没有名为String的类型（class、struct、delegate、enum）的时候才代表System.String ;
>
> 7.string是关键字，String不是，也就是说string不能作为类、结构、枚举、字段、变量、方法、属性的名称，而String可以 ;
> ————————————————
> 版权声明：本文为CSDN博主「大成小示」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/ChengDeRong123/article/details/120502051

=>是否可以理解为.NET的CLR在编译时会为C#的字段自动包裹成为一个类？这种说法暗示string跟C/C++中一样只是单纯的类型，这是错误的，C#中的string是类，据MSDN而言它仅仅是C#为.NET中的String取的别名。

#### 2.2.2.2 数据转化

| 种类                  | 转换方式                     | 例子                              |
| --------------------- | ---------------------------- | --------------------------------- |
| int转string           |                              | `string b = Convert.ToString(a);` |
| string 转 int/double… | 数值类型.Parse()             | `int b = int.Parse(str);`         |
| string转char[]        | string类型的值.TocharArray() | `char[] b = str.ToCharArray();`   |
|                       |                              |                                   |

=>C#许多方法相对于JAVA，就是首字母变大写即可。

#### 2.2.2.3 常用方法

| 方法                   | 说明 | 例子                        |
| ---------------------- | ---- | --------------------------- |
| str.Insert(index, str) |      | `str = str.Insert(0, "a");` |
| str.Remove(Start, Len) |      | `ans = ans.Remove(0,1);`    |
|                        |      |                             |
|                        |      |                             |
|                        |      |                             |
|                        |      |                             |
|                        |      |                             |
|                        |      |                             |
|                        |      |                             |

=>注意无论是Insert()还是Remove(), 与JAVA很大不同的一点：C#需要自身去接收返回值，否则string不会改变！

=>C#的string和C++一样可以直接用下标取特定位置的值，而不必像Java那样必须使用特定方法。

(2023.7.21)

### 2.2.3 List

List的初始化：

```C#
//利用了集合初始化器语法，所以就出现了两个new
_items = new List<string>(new string[] { "BeforeLogAnalizer", "default","default"});
```

#### 2.2.3.1 List与ArrayList的区别

数组 => `ArrayList`  => `List` 的发展历史：

**数组：**

```C#
//数组
int[] arr = new int[3];
//赋值
arr[0] = 5;
arr[1] = 6;
arr[2] = 3;
//C#的数组和JAVA一样已经是个类了，而且有类的静态方法
Array.Sort(arr);
Console.WriteLine(arr.Length);
```

数组在实例化时，必须指定长度。不仅如此，我们的数组空间是连续，这也导致了存储效率低，插入和删除元素效率比较低，而且麻烦。

针对数组的这些缺点，C#中最先提供了`ArrayList`对象来克服这些缺点。

**`ArrayList`：**

```C#
//ArrayList
ArrayList list = new ArrayList();
//新增数据
list.Add("world");
list.Add(5678); 
//修改数据
list[2] = 34;
//移除数据
list.RemoveAt(0); 
//插入数据
list.Insert(0, "hello");
```

`ArrayList`实现了存储的数据动态扩充与收缩，故我们不用指定长度。但是同时它又暴露了一个问题，通过上面的例子，我们不难发现：我们可以将任何类型的数据添加到`ArrayList`中。这是因为，它会把所有插入其中的数据当作为object类型来处理。我们大家都知道object是所有类型的父类，我们在存取这些数据时，注定要经过繁琐的数据类型的转换，而这些过程，对于我们的数组来说，会造成类型不安全的问题隐患，同时它更会带来了很大的性能消耗。

那么为了解决这些问题，泛型List出现了。

**泛型`List`**：

```C#
List<int> list = new List<int>();
//新增数据
list.Add(123);
//修改数据
list[0] = 345;
//移除数据
list.RemoveAt(0);
```



数组可以具有多个维度，而 `ArrayList`或泛型List始终只具有一个维度，但是我们可以轻松创建数组列表或列表的列表。如：

```C#
 public List<List<string>> TemplateList = new List<List<string>>();
```

=>好像是在C#中`ArrayList`先于泛型概念出现，所以并没有像JAVA那样直接将其升级为`ArrayList<>`...就感觉`ArrayList`就成了历史发展中的淘汰垃圾...另外实际开发中基本上均用List而不是数组吧。



数组与List泛型的相互转化：

> 1. 从`System.String[]`转到`List<System.String>`=>数组转List泛型，直接初始化
>    `System.String[] str={"str","string","abc"};`
>    `List<System.String> listS=new List<System.String>(str);`
>
> 2. 从`List<System.String>`转到`System.String[]`=>List泛型转数组，通过方法`ToArray()`
>    `List<System.String> listS=new List<System.String>();`
>    `listS.Add("str");`
>    `listS.Add("hello");`
>    `System.String[] str=listS.ToArray();`

(2023.4.20)

#### 2.2.3.2 常用方法

| 方法/属性   | 说明                                                         | 例子                                          |
| ----------- | ------------------------------------------------------------ | --------------------------------------------- |
| Count       | 用于获取数组中当前元素数量                                   |                                               |
| Add( )      | 在List中添加一个对象的公有方法                               |                                               |
| Remove( )   | 移除与指定元素匹配的第一个元素                               |                                               |
| RemoveAt( ) | 移除指定索引的元素                                           |                                               |
| Clear()     | 清空List集合中的元素对象                                     |                                               |
| ToArray()   | 转化为数组                                                   |                                               |
| AddRange()  | 在List的末尾添加另一串List                                   |                                               |
| **Find()**  | 参数是一个委托，注意List对象为引用类型时，**返回值为指向该对象的内存地址** | `var n = record.Find(x => x.Name == "Host");` |
|             |                                                              |                                               |





### 2.2.4 Stack

| 方法/属性                    | 说明                                  | 例子 |
| ---------------------------- | ------------------------------------- | ---- |
| Count                        | 获取栈（stack）中的元素个数           |      |
| object Peek();               | 返回在 Stack 的顶部的对象，但不移除它 |      |
| object Pop();                | 移除并返回在 Stack 的顶部的对象       |      |
| void Push( object obj );     | 向 Stack 的顶部添加一个对象           |      |
| bool Contains( object obj ); | 判断某个元素是否在 Stack 中           |      |
| void Clear()                 | 从 Stack 中移除所有的元素             |      |
|                              |                                       |      |

=>Stack的方法，各个语言相差不大。

(2023.7.21)

### 2.2.5 Queue

| 方法/属性                    | 说明                                   |
| ---------------------------- | -------------------------------------- |
| void **Enqueue**(object obj) | 将对象添加到Queue 的结尾处             |
| object **Dequeue**()         | 移除并返回位于Queue 开始处的对象       |
| object **Peek**()            | 返回位于Queue 开始处的对象但不将其移除 |
| Count                        | 获取Queue 中的元素个数                 |
|                              |                                        |

```C#
//225. Implement Stack using Queues
public class MyStack {

    private Queue<int> q = new();
    
    public void Push(int x) {
        q.Enqueue(x);
        //把原本添加在末尾的x放到首位来，其他不变
        for(int i = 0; i < q.Count - 1; i++) q.Enqueue(q.Dequeue());
    }
    
    public int Pop() => q.Dequeue();
    
    public int Top() => q.Peek();
    
    public bool Empty() => q.Count == 0;
}
```

(2023.9.20)

# 3 高级语法

## 3.1 特殊关键字

### 3.1.1 `const` 和 `readonly` 

```C#
class Mycalss
{
    //两者都用来声明常量，但其实现的手段本质上不同
    public const int ConstValue = 0;
    public readonly int ReadonlyValue = 0;

    public static void TestMain()
    {
        //const得通过类来使用，说明它是静态的，即编译时已被放入只读内存段了
        int a = Mycalss.ConstValue;
        //readonly是配合类实例化为对象来使用，所以其也可以在构造函数中赋值。
        //readonly更像是编译器语法层面上的约束，它不像const天生就是常量，而是后天声明约束，然后初始化若尝试去修改，就会有错误提示。所以感觉readonly会比const更为灵活
        //C# 8.0引入readonly member，不仅可以修饰struct，甚至可以去修饰方法
        var cls = new Mycalss();
        int b = cls.ReadonlyValue;
    }
    
    //总结而言readonly灵活，const死板
    //比如下例中readonly换成const就不行，居然想用new去堆中开辟内存空间？
    public readonly List<string> _items = new List<string>(new string[] { "BeforeLogAnalizer", "default", "default" });
}
```

(2023.6.20)

### 3.1.2 `partial`

作用：能够拆分一个类、一个结构、一个接口或一个方法为两个或更多个的文件，分部的每个文件都可以包含自己的类型和方法，程序编译时会将同类的分部内容合并为一个。=>强烈怀疑专门为了使WPF中XAML所代表的UI代码与xaml.cs中的逻辑代码分离而创造这个关键词的。

使用场景说明：使用自动生成的源文件时，自动创建的源文件为一个内容，而对应的逻辑处理业务为一个内容，互不干扰，两个文件的内容可以相互调用。如WPF框架下：

```c#
//Example Tool\App.xaml.cs
using System.Windows;
namespace Example_Tool {
    public partial class App : Application
    {
        private IUnityContainer Container { get; } = new UnityContainer();
        //...
    }
```

```c#
//Example Tool\obj\Debug\App.g.cs

//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
namespace Example_Tool {
    public partial class App : System.Windows.Application {        
        // ...
        //[...]这个叫做Attribute，一般翻译为“特性”，而不是“属性”（因为“属性”已代表其他意思）。特性是一个继承自System.Attribute类的类，其实特性和注释（即“/* ... */”）类似，是用于描述程序集、类型、成员的“备注信息”，和注释不同的是：注释是给“人”看的，而特性是给“编译器”看的    
        [System.STAThreadAttribute()]
        public static void Main() {
            Example_Tool.App app = new Example_Tool.App();
            app.InitializeComponent();
            app.Run();
        }
    }
}
```

(2023.3.28)

### 3.1.3 `is` 和 `as`

**`is` 概述：**

> is关键字是判断类型，用于检查对象是否与给定类型兼容，不成功则不会抛出异常，如果兼容则返回true如果不兼容则返回false。在进行类型转换之前用。
>
> 在C#中提供的很好的类型转换方式总结为：
>
> 1. Object => 已知值类型——先使用is操作符来进行判断，再用类型强转换方式进行转换；
>
> ```C#
> if (myObject is Employee) //CLR用is运算符首先核实myObject是否兼容于Employee类型,注意是兼容而不是“是”。
> {
> 	Employee myEmployee = (Employee)myObject;//CLR会再次核实myObject是否引用一个Employee
> }
> ```
>
> 事实上，在上述语句中CLR重复核实了两次，会对性能造成一定影响。这是因为CLR首先必须判断变量(myObject)引用的对象的实际类型。然后，CLR必须遍历继承层次结构，用每个基类型去核对指定的类型（Employee）。由于这是一个相当常用的编程模式，所以C#专门提供了as运算符，目的就是简化这种代码写法，同时提升性能。
>
> 2. Object => 已知引用类型——使用as操作符完成；

**`as` 优点：**

> 在程序中，进行类型转换时常见的事，C#支持基本的强制类型转换方法，例如 
>
> ```c#
> Object obj = new NewType();
> NewType newValue = (NewType)obj;
> ```
>
> 这样强制转换的时候，这个过程是不安全的，因此需要用try-catch语句进行保护，这样一来，比较安全的代码方式应如下所示：
>
> ```c#
> Object obj = new NewType（）；
> NewType newValue = null；
> try
> {
> 	newValue = （NewType）obj；
> }
> catch （Exception err）
> {
> 	MessageBox.Show（err.Message）;
> }
> ```
>
> 但是上面的写法在C#中已是过时的写法，也是比较低效的写法，比较高效且时尚的写法是用as操作符，如下：
>
> ```c#
> Object obj1 = new NewType（）；
> NewTYpe newValue = obj1 as NewType；
> ```
>
> 安全性：as操作符不会做过的转换操作，当需要转化对象的类型属于转换目标类型或者转换目标类型的派生类型时，那么此转换操作才能成功，而且并不产生新的对象【当不成功的时候，会返回null】。因此用as进行类型转换是安全的。
>
> 效率：当用as操作符进行类型转换的时候，首先判断当前对象的类型，当类型满足要求后才进行转换，而传统的类型转换方式，是用当前对象直接去转换，而且为了保护转换成功，要加上try-catch，所以，相对来说，as效率高点。
>
> 需要注意的是，不管是传统的还是as操作符进行类型转换之后，在使用之前，需要进行判断转换是否成功，如下：
>
> ```c#
> if（newValue ！= null）
> {
> 	//Work with the object named “newValue“
> }
> ```

=>总结：`as`用于高效安全地进行对象的强制类型转化。如：

```C#
public CreateViewModel Viewmodel
{
     get { return this.DataContext as CreateViewModel; }
}
```

（2023.3.28）

**两者的区别：**

> **1.** AS在转换的同时兼判断兼容性，如果无法进行转换，则 as 返回 null（没有产生新的对象）而不是引发异常。有了AS就不要再用try-catch来做类型转换的判断了。因此as转换成功要判断是否为null。
>
> **2.** AS是引用类型类型的转换或者装箱转换，不能用与值类型的转换。如果是值类型只能结合is来强制转换。
>
> **3.** IS只是做类型兼容判断，并不执行真正的类型转换。返回true或false，不会返回null，对象为null也会返回false。
>
> **4.** AS模式的效率要比IS模式的高，因为借助IS进行类型转换，需要执行两次类型兼容检查。而AS只需要做一次类型兼容，一次null检查，null检查要比类型兼容检查快。

### 3.1.4 `ref` 和 `out` 

`ref`表明传入已初始化好的ref 变量地址进入方法内部，实现在一个方法中返回除return外的返回值。相当于C++中传入&variable.

而`out`实现同样的功能。唯一的区别在于`out`无需提前定义并初始化，进入方法内部后则必须初始化。也就是说 `ref`既可以向方法内部传值，也可以取得返回值，双向交互，而`out`只能由方法内部向外传值，单向传递。

```C#
namespace ConsoleApp3.TestArr
{
    internal class TestArr
    {
        private static void Outtest(out int outvalue)
        {
            //Console.WriteLine(outvalue); =>out无法使用外部传进来的值，只能内部初始化
            outvalue = 13;
        }
        private static void Reftest(ref int refvalue)
        {
            int x = refvalue;//ref可以取得外部传进来的值
            Console.WriteLine(x);
            refvalue = 13;
        }
        public static void Test()
        {
            //out
            //int x = 5;
            Outtest(out int x);//out在外部无需初始化(否则多此一举，反正进入内部要被重新初始化)，函数调用出定义即可；
            Console.WriteLine(x);
            //ref
            int y = 9;//ref必须提前初始化
            Reftest(ref y);
            Console.WriteLine(y);

        }
    }
}
```

`out`应用广泛，更贴近单向地返回多个值。

```C#
if (int.TryParse(value, out int pciCal))
{
    int remainder = 0;
    remainder = pciCal % 3;
    ret = ((pciCal - remainder) / 3).ToString();
}
break;
```

(2023.4.21)

### 3.1.5 `var` 和 `dynamic`





## 3.2 委托(Delegate)

### 3.2.1 与函数指针的异同

> **委托类似于函数指针**，但函数指针只能引用静态方法，而委托既能引用静态方法，也能引用实例方法。
>
> 委托使用分三步：1、委托声明。2、委托实例化。3、委托调用。
>
> ```c#
> using System;
> 
> namespace 委托
> {
> delegate int NumOpe(int a,int b); //第一步:委托声明
> class Class1
> {
>    static void Main(string[] args)
>    {
>        Class1 c1 = new Class1();
>        NumOpe p1 = new NumOpe(c1.Add); //第二步:委托实例化
>        Console.WriteLine(p1(1,2)); //第三步:委托调用
>        Console.ReadLine();
>    }
> 
>    private int Add(int num1,int num2)
>    {
>        return(num1+num2);
>    }
> }
> }
> ```
>
> 例中，委托NumOpe引用了方法Add。
> **委托声明了以后，就可以象类一样进行实例化**，实例化时把要引用的方法（如：Add）做为参数，这样委托和方法就关联了起来，就可以用委托来引用方法了。
>
> 委托和所引用的方法必须保持一致：
> 1、参数个数、类型、顺序必须完全一致。
> 2、返回值必须一致。

=>我推测委托本质实现上与类应该很类似，就像C++中的仿函数，伪装成类的函数，这个委托大概是伪装成类的指针。

### 3.2.2 多播

> 委托的多播（Multicasting of a Delegate）
>
> 委托对象可使用 "+" 运算符进行合并。一个合并委托调用它所合并的两个委托。只有相同类型的委托可被合并。"-" 运算符可用于从合并的委托中移除组件委托。
>
> 使用委托的这个有用的特点，您可以创建一个委托被调用时要调用的方法的调用列表。这被称为委托的 **多播（multicasting）**，也叫组播。下面的程序演示了委托的多播：
>
> ```c#
> using System;
> 
> delegate int NumberChanger(int n);//第一步:委托声明
> namespace DelegateAppl
> {
> 	class TestDelegate
> 	{
> 		static int num = 10;
> 		public static int AddNum(int p)
> 		{
>    		num += p;
>    		return num;
> 		}
> 
> 		public static int MultNum(int q)
> 		{
>    		num *= q;
>    		return num;
> 		}
> 		public static int getNum()
> 		{
>    		return num;
> 		}
> 
> 		static void Main(string[] args)
> 		{
>    		// 第二步:多个委托实例化
>   		NumberChanger nc;
>    		NumberChanger nc1 = new NumberChanger(AddNum);
>    		NumberChanger nc2 = new NumberChanger(MultNum);
>    		nc = nc1;
>    		nc += nc2;// 第三步:委托对象合并
>    		nc(5);// 第四步:多播委托调用
>    		Console.WriteLine("Value of Num: {0}", getNum());
>    		Console.ReadKey();
> 		}
> 	}
> }
> ```
>
> 当上面的代码被编译和执行时，它会产生下列结果：
>
> ```
> Value of Num: 75
> ```
>
> =>即第一个函数的方法作为第二个函数的入参？

### 3.2.3 委托中的Lambda

> Lambda表达式可用于简化C#中委托的匿名语法
>
> ```c#
> namespace ConsoleApp3
> {
> class Program
> {
>   public delegate void CountAdd(int x);
>   static void Main(string[] args)
>   {
>       int y = 2;
>       //此处为未使用Lambda表达式的匿名语法=>最原始的C#1.0写法
>       CountAdd CountAdd1 = delegate (int x)
>       {
>           x += 1;
>           Console.WriteLine("Before add the y value is  {0}", y);
>           Console.WriteLine("the add value is {0}", x);
>       };
>       CountAdd1(y);
>       	//C#3.0后使用lambda表达式替代匿名方法
> 		//此处为使用了Lambda表达式的语法， 在此语法中将声明的关键字delegate取消并在参数之后添加Lambda符号"=>"
>       	//Lambda表达式:=>的左边定义参数，右边编写逻辑代码。
>       CountAdd CountAdd2 = (int x) =>
>       {
>           x += 1;
>           Console.WriteLine("Before add the y value is  {0}", y);
>           Console.WriteLine("the add value is {0}", x);
>       };
>       //Lambda表达式的本质是“匿名方法”，即当编译我们的程序代码时，“编译器”会自动将“Lambda表达式”转换为“匿名方法”。
>       CountAdd2(y);
>   }
> }
> }
> ```
>
> ————————————————
> 版权声明：本文为CSDN博主「PittDing」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/PittDing/article/details/123763320

=>严格来说，Lambda和匿名方法还是有区别，即Lambda本质上确实是匿名方法，但因其简练的不同于匿名方法的表现形式才被称为Lambda.



换个角度来看委托随着C#版本更迭的形式变化：

> Lambda表达式，匿名委托
>
> 例如定义一个委托：
>
> ```c#
> delegate int DeMethod(int a, int b);
> ```
>
> 再定义一个方法：
>
> ```c#
> int Add(int a, int b)
> {
> return a + b;
> }
> ```
>
> 我可能需要这样通过委托调用方法：
>
> ```c#
> DeMethod m += Add;
> Console.WriteLine(m(2, 3));
> ```
>
> 采用 C# 2.0 的匿名方法语法：
>
> ```c#
> DeMethod m += delegate(int a, int b) { return a + b; }; //委托声明实例化合一了
> Console.WriteLine(m(2, 3));
> ```
>
> 采用C#3.0  Lambda 表达式：
>
> ```c#
> DeMethod m += (a ,b) => a + b; //Lambda表达式比传统的匿名方法更加简洁！
> Console.WriteLine(m(2, 3));
> ```
>
> 可以省去方法的定义。
> 实际上， Lambda 表达式只是简化了匿名方法的语法而已。
> ————————————————
> 版权声明：本文为CSDN博主「IT技术猿猴」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/baobingji/article/details/125014566

(2023.6.26)



WPF Prism中的委托用法实例：

```C#
//System.Func
//第一步:委托声明。（此处参数类型与返回值类型使用了泛型）
public delegate TResult Func<in T, out TResult>(T arg);
```

```C#
//Prism.Mvvm.ViewModelLocationProvider
//委托的匿名语法形式
private static Func<Type, Type> _defaultViewTypeToViewModelTypeResolver = delegate (Type viewType)
{
	//...            
};
//第二步:委托被用作方法形参。（这里可以看出委托与函数指针的类似处）
public static void SetDefaultViewModelFactory(Func<Type, object> viewModelFactory)
{
	//...
}
```

```c#
//App.xaml.cs
//第三步:Lambda作为实参传入方法，委托完成实例化
ViewModelLocationProvider.SetDefaultViewModelFactory(x => this.Container.Resolve(x));
```

(2023.3.31)

> 备考：
>
> 泛型委托Func和Action
> 方法的返回类型和签名千千万万，无法对每个方法都去定义对应的委托，.net为了方便使用委托，定义了两个泛型委托。
>
> 1. Action
>     Action<int T,1in T2,…>：表示引用一个void返回类型的方法。至多可以传递16种不同类型的参数。其中，Action可调用没有参数的方法。
>
> 2. Func
>     Func<in T1,in T2,…,out TResult>允许调用带返回类型的方法。至多可以传递16种不同类型的参数和一个返回类型。返回类型放在<>最后一个。其中，Func调用一个带返回类型且无参数的方法。
>     ————————————————
>     版权声明：本文为CSDN博主「香蕉有毒」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
>     原文链接：https://blog.csdn.net/u014677109/article/details/117355913

=>WPF Prism中用到的泛型委托`Func`其实是.net的系统定义。



除此之外，日常开发中也会使用，比如用于大量特殊规则来check数据：

```C#
//1.委托声明
public delegate bool errorCheckFunction(DataRow paramData, List<int> refParamName);
//2.可以看到，委托在声明之后，委托名已经可以以数据类型的角色来进行实例化，理所当然也可以作为字典的参数类型
private readonly Dictionary<string, errorCheckFunction> errorCheckList = new Dictionary<string, errorCheckFunction>();

//3.将与委托有相同的参数类型的方法加入字典，其实2与3共同完成了委托的实例化
errorCheckList.Add("num001", CheckCase_num001);
errorCheckList.Add("num002", CheckCase_num002);
errorCheckList.Add("num003", CheckCase_num003);

private bool CheckCase_num001(DataRow drData, List<int> targetColList)
{
    //...
}
//=>以上的用法跟C语言函数指针几乎如出一辙
```

(2023.6.20)

## 3.3 事件(Event)

通常开发中，使用已有事件的机会比较多，自己声明的机会比较少。以下例展示如何使用事件：

```C#
/*
 * 事件模型的五个组成部分
 * ①事件的拥有者: Timers
 * ②事件成员: timer.Elapsed
 * ③事件的响应者: boy and girl
 * ④事件处理器: boy.Action() and girl.Action()
 * ⑤事件订阅：把事件处理器与事件关联在一起 => += 就是订阅事件的操作符
 */
internal class EventExcecise
{
    public static void EventMain()
    {
        //①事件的拥有者
        System.Timers.Timer timer = new System.Timers.Timer();
        timer.Interval = 1000;
        Boy boy = new Boy();
        //②事件成员: timer.Elapsed => Elapsed 就是每间隔Interval时间，就触发一次事件
		//⑤事件订阅：把事件处理器与事件关联在一起 => += 就是订阅事件的操作符
        timer.Elapsed += boy.Action;

        //可以多个对象订阅同一个事件
        Girl girl = new Girl();
        timer.Elapsed += girl.GirlAction;

        timer.Start();
        Console.ReadLine();

    }       

    //③事件的响应者
    class Boy
    {
        //④事件处理器
        internal void Action(object sender, ElapsedEventArgs e)
        {
            Console.WriteLine("Jump");
        }
    }

    class Girl
    {
        internal void GirlAction(object sender, ElapsedEventArgs e)
        {
            Console.WriteLine("Sing!");
        }
    }

}
```

接着试着自己去定义一个事件。用以下代码来模拟顾客点菜。顾客点菜，服务员处理点菜这个事件：

```C#
internal class EventExcecise2
{
    public static void EventMain()
    {
        Customer customer = new Customer();//①事件的拥有者
        Waiter waiter = new Waiter();// ③事件的响应者
        customer.Order += waiter.Action;//⑤事件订阅
        customer.Action();//触发这个事件
        customer.PayTheBill();
    }


    //事件信息，命名规范：事件名+EventArgs.事件信息这个类必须继承自EventArgs
    public class OrderEventArgs : EventArgs
    {
        public string DishName { get; set; }
        public string Size { get; set; }
    }
    
#if false //简略声明版可省去
    //用来协助声明事件的委托的命名规范：事件名+EventHandler
    //委托参数的命名:第一个是object类型，名字为sender，实际上就是事件的拥有者。第二个是EventArgs的派生类，参数名一般都为e，也就是最前面说的事件参数。
    public delegate void OrderEventHandler(Customer customer, OrderEventArgs e);
#endif
        
    public class Customer
    {
#if false //简略声明版可省去
    	//事件的拥有者中先定义一个委托
        public OrderEventHandler orderEventHandler;
#endif
    
#if false //简略声明版可省去
        //此处可以看出来事件是基于委托的，事件的本质是委托字段的一个包装器
        public event OrderEventHandler Order //声明事件，event是声明事件关键字
        {
            add //对应+=符号
            {
                this.orderEventHandler = value;
            }
            remove//对应-=符号
            {
                this.orderEventHandler = value;
            }
        }
		//上述代码解释了为什么不直接用委托，非得用包装委托后的事件，限定了事件只能用+=符号，防止其他对象来触发这个事件
#else
        //②事件成员
        //简略声明的代码
        //public event OrderEventHandler Order;
        //进一步简略的声明：利用微软帮我们声明的委托EventHandler
        public event EventHandler Order;
#endif        
        //下面的方法用来触发事件
        //触发事件的方法的命名一般命名为On+事件名，并且这个方法的访问级别为protected，不能为public
        protected void OnOrder()
        {
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("Let me think...");
                Thread.Sleep(1000);
            }
            //if(orderEventHandler != null)
            if (Order != null)
            {
                OrderEventArgs e = new OrderEventArgs();
                e.DishName = "Kongpao Chicken";
                e.Size = "large";
                //触发事件处理器， 简略声明版本将orderEventHandler修改为Order
                //this.orderEventHandler.Invoke(this, e);
                this.Order.Invoke(this, e); //=>推测这个Invoke方法来源于event关键字,不能算并行处理，更像是goto跳转到另一个类中的方法。
                //事件Order后面不是只能加+=或者-=？为啥这里就能直接改，这就是微软设计的这个简略声明的代码的语法糖的作用；
            }
        }
        
        public void Action()
        {
            this.OnOrder();
        }
        
        public double Bill { get; set; }
        public void PayTheBill()
        {
            Console.WriteLine("I will pay ${0}.", this.Bill);
        }
    }



    public class Waiter
    {
        //④事件处理器
        //因为用了微软帮我们声明的委托EventHandler，入参要改
        //internal void Action(Customer customer, OrderEventArgs e)
        internal void Action(object sender, EventArgs e)
        {
            //入参被改了后，此处再转化过来
            Customer customer = sender as Customer;
            OrderEventArgs orderInfo = e as OrderEventArgs;

            Console.WriteLine("I will serve you the dish {0}", orderInfo.DishName);
            double price = 10;
            switch (orderInfo.Size)
            {
                case "small":
                    price *= 0.5;
                    break;
                case "large":
                    price *= 1.5;
                    break;
                default:
                    break;
            }
            customer.Bill += price;
        }
    }

}
//Added by 2023.8.2
//XXXEventHandler类型的数据 即为 事件， 可以将①事件的拥有者和事件信息作为参数，通过Invoke方法发出去
//拥有这个事件的即为 ①事件的拥有者，而这个事件即为②事件成员
//事件的 +- 方法即是 ⑤事件订阅
//被+-方法关联上的对象即为 ③事件的响应者，其中定义捕获事件的方法即为 ④事件处理器
```

> 从这个例子中，就可以看出来事件是基于委托的。
>
> 事件是基于委托的：1.事件需要用委托类型来做一个约束，这个约束既规定了事件能发送什么消息给响应者，也规定了响应者能收到什么样的事件消息，这就决定了事件响应者的事件处理器必须能够给这个约束匹配上，才能够订阅这个事件。
> 2.当事件的响应者给事件的拥有者提供了能够匹配这个事件的事件处理器之后，得找个地方把事件处理器保存或者记录下来，能够记录或者引用方法的任务也只有委托类型的实例能够做到。
> ————————————————
> 版权声明：本文为CSDN博主「超02」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/nameyichao/article/details/124646611

(2023.6.12)

## 3.4 属性(Property)

> **属性（Property）** 是类（class）、结构（structure）和接口（interface）的命名（named）成员。类或结构中的成员变量或方法称为 **域（Field）**。属性（Property）是域（Field）的扩展，且可使用相同的语法来访问。它们使用 **访问器（accessors）** 让私有域的值可被读写或操作。
>
> 属性（Property）不会确定存储位置。相反，它们具有可读写或计算它们值的 **访问器（accessors）**。
>
> 属性（Property）的**访问器（accessor）**包含有助于获取（读取或计算）或设置（写入）属性的可执行语句。访问器（accessor）声明可包含一个 get 访问器、一个 set 访问器，或者同时包含二者。

> ```c#
> class person
> {
> 	private int age;
> 	public int Age
> 	{
>  		/*
>  		set与get访问器
> 		- 当我们使用属性来访问私有成员变量时就会调用里面的get方法
> 		- 而当我们要修改该变量时就会调用set方法
> 		- 如果只定义get方法，那么这个相应变量就是“只读”的
> 		- 如果只定义set方法，那么这个相应变量就是“只写”的
> 		*/
> 		get { return age; }
> 		set { age = value; }
> 	}        
> }
> person A = new person();
> A.Age = 1;//set
> Console.WriteLine(A.Age);//get
> ```
>
> C#在定义类时，通常要把类中声明的对象封装起来，使得外界不能访问这个属性。上述代码中如果去掉set部分，则外界只能读取age的值，如果去掉get部分，则只能给age赋值。这样就可以控制外界对私有属性age的访问权限了，这种写法是C#的一个特性。
>
> 当然你也可以通过自己创建函数来对name进行取值和赋值，但这样就显得比较麻烦了。
>
> 属性与普通变量不同就在于, 普通变量就是放在屋子里的东西, 是什么样明明白白. 而属性则是在屋子的门口放了个守门人, 你拿东西放东西要经过他.
>
> 相对以前来说，没有属性访问器，需要通过函数来调用私有成员数据，**属性提供了高效的访问模式和简单的书写。**

=>就编译结果而言，属性可以看成一种略去返回值类型与入参(value)的方法，因而它相对于包装字段不会再CLR中增加内存，可以把属性看成C#推出的语法糖。（WPF中的依赖属性可以被通常的CLR属性包装，形成两层包装的感觉）



实际应用：

```C#
namespace Exampl_Tool.ViewModels
{
    public class CreateViewModel : BindableBase
    {
        private string m_Mode;
        public string Mode
        {
            get { return this.m_Mode; }
            set
            {
                //上下文关键字 value 用在普通属性声明的 set 访问器中。 此关键字类似于方法的输入参数。
                //这里的value代表外部调用赋予Mode的值
                if (value == "-d"){ DevMode = true;}
                else{ DevMode = false;}
            }
        }

        private bool m_Devmode = false;
        public bool DevMode
        {
            get { return this.m_Devmode; }
            set{this.SetProperty(ref this.m_Devmode, value);}
        }
    }
}    
```

(2023.3.28)



## 3.5 Nullable

### 3.5.1 单问号

> C# 提供了一个特殊的数据类型，nullable 类型（可空类型），可空类型可以表示其基础值类型正常范围内的值，再加上一个 null 值。
>
> 例如，Nullable< Int32 >，读作"可空的 Int32"，可以被赋值为 -2,147,483,648 到 2,147,483,647 之间的任意值，也可以被赋值为 null 值。类似的，Nullable< bool > 变量可以被赋值为 true 或 false 或 null。

> ? 单问号用于对 **int、double、bool** 等无法直接赋值为 null 的数据类型进行 null 的赋值，意思是这个数据类型是 Nullable 类型的。
>
> ```C#
> int? i = 3;
> //等同于：
> Nullable<int> i = new Nullable<int>(3);
> 
> //区别
> int i; //默认值0
> int? ii; //默认值null
> ```

### 3.5.2 双问号

> Null 合并运算符为类型转换定义了一个预设值，以防可空类型的值为 Null。
>
> 作用：用于判断并赋值,先判断当前变量是否为null,如果是就可以赋一个新值,否则跳过。
>
> ```c#
> //例子：
> public int? b; //默认值为null
> 
> public int IsNullOrSkip()
> {
> 	return b ?? 0; //返回值为0
> }
> 
> //错误例子：
> public int b; //默认值为0
> 
> public int IsNullOrSkip()
> {
> 	return b ?? 0; // 错误 运算符“??”无法应用于“int”和“int”类型的操作数	
> }
> ```

又如Prism中的例子：

```c#
private DelegateCommand _fieldName;
public DelegateCommand CommandName =>
    _fieldName ?? (_fieldName = new DelegateCommand(ExecuteCommandName));
```

(2023.7.12)

## 3.6 using(){} 

> using(){}作为语句，用于定义一个范围，在此范围的末尾将释放对象。
>
> **using 语句允许程序员指定使用资源的对象应当何时释放资源。using 语句中使用的对象必须实现 IDisposable 接口。此接口提供了 Dispose 方法，该方法将释放此对象的资源。**
>
> 当我们做一些比较占用资源的操作，而且该类或者它的父类继承了IDisposable接口，这样就可以使用using语句，在此范围的末尾自动将对象释放，常见的using使用在对数据库的操作的时候。

(2023.4.14)

也经常用于StreamWriter：

```c#
//这段代码用于向已有的csv文件追加不重复列，所以先读取该文件，后追加写入
List<string> neidContainer = new List<string>();
if (File.Exists(inFileName))
{
	//如果读入时不用using，会造成之后读取时抛出该文件正在被使用的异常
    using (FileStream stream = File.Open(inFileName, FileMode.Open, FileAccess.Read))
    {
        var csvReader = ExcelReaderFactory.CreateCsvReader(stream);
        var csvDataSet = csvReader.AsDataSet();


        foreach (var row in csvDataSet.Tables[0].AsEnumerable())
        {
            neidContainer.Add(row[0].ToString());
        }
    }
}

using (StreamWriter streamWriter = new StreamWriter(inFileName, true, enc))
{ 
    
    foreach (string str in inLines)
    {
        var neid = str.Split(',')[0];
        if (neidContainer.Contains(neid))
        {
            continue;
        }
        else
        {
            neidContainer.Add(neid);
            streamWriter.Write(str + "\n");
        }
    }
}
```

(2024.2.21)

## 3.7 初始化器

> C＃3.0（.NET 3.5）引入了*对象初始化器语法*，这是一种初始化类或集合对象的新方法。对象初始化程序允许您在创建对象时将值分配给字段或属性，而无需调用构造函数。
>
> ```c#
> public class Student
> {
>     public int StudentID { get; set; }
>     public string StudentName { get; set; }
>     public int Age { get; set; }
>     public string Address { get; set; }
> }
> 
> class Program
> {
>     static void Main(string[] args)
>     {
>         Student std = new Student() { StudentID = 1, 
>                                       StudentName = "Bill", 
>                                       Age = 20, 
>                                       Address = "New York"   
>                                     };
>     }
> }
> ```
>
> 在上面的示例中，没有任何构造函数的情况下定义了 Student 类。在 Main() 方法中，我们创建了Student对象，并同时为大括号中的所有或某些属性分配了值。这称为对象初始化器语法。
>
> 可以使用集合初始化器语法以与类对象相同的方式初始化集合。
>
> ```C#
> IList<Student> studentList = new List<Student>() { 
>                     new Student() { StudentID = 1, StudentName = "John"} ,
>                     new Student() { StudentID = 2, StudentName = "Steve"} ,
>                     new Student() { StudentID = 3, StudentName = "Bill"} ,
>                     new Student() { StudentID = 3, StudentName = "Bill"} ,
>                     new Student() { StudentID = 4, StudentName = "Ram" } ,
>                     new Student() { StudentID = 5, StudentName = "Ron" } 
>                 };
> ```
>
> 初始化器的优点：
>
> - 初始化程序语法使代码更具可读性，易于将元素添加到集合中。
> - 在多线程中很有用。

(2023.6.23)

## 3.8 特性与反射 

### 3.8.1 Attribute

特性本质上是用来给代码添加额外信息的一种手段，它可以应用于类、结构、方法、构造函数等。在 C# 中，特性是继承自 `Attribute` 基类的类。所有继承自 `Attribute` 的类都可以用作给代码添加额外信息。

可以通过使用特性向程序添加声明性信息。一个声明性标签是通过放置在它所应用的元素前面的方括号[ ]来描述的。如下：

```C#
[System.Diagnostics.DebuggerNonUserCodeAttribute()]
[System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
public void InitializeComponent() {
	this.Startup += new System.Windows.StartupEventHandler(this.Application_Startup);
}
```

> .Net 框架提供了三种预定义特性：
>
> - AttributeUsage
> - Conditional
> - Obsolete

> .Net 框架允许创建自定义特性，用于存储声明性的信息，且可在运行时被检索。该信息根据设计标准和应用程序需要，可与任何目标元素相关。
> 版权声明：本文为CSDN博主「此生不悔入海贼」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/LiKe11807/article/details/120873838

（若要使用特性，通常需要使用反射。）？？=>Yes,通过反射去去读取程序集的特性信息

（特性可以提供声明能力，但它们是一种元数据形式的代码，本身并不执行操作。）？？=>相当于注释，只是程序可以用反射去读取这个注释信息

### 3.8.2 Reflection

=>C#程序很多时候由许多程序集组成，在主程序中如何去获取程序集中细节信息，如类的类型，程序集中的特性信息等，这个到时候就需要借助反射。

> 反射多种应用场景
>
> （1）IOC容器：反射+ 配置文件+ 工厂
>
> （2）MVC框架：反射调用类型方法
>
> （3）ORM：反射+泛型+Ado.Net
>
> （4）AOP：在方法的前面后面添加处理内容
>



举例：

```c#
class TestAttr
{
    public static void TestMain()
    {
        var stu = new Student()
        {
            //初始化器用逗号
            Name = "ABC",
            Id = 5,
            FirstName = "A"
        };

        //此处的GetType()，GetProperties()就是基于反射机制
        var y2 = stu
            .GetType()
            .GetProperties()
            .Where(x =>
            {
                //BrowsableAttribute 是Browsable的全称
                //特性需要被基于反射机制的GetCustomAttribute<T>()方法读取
                var y = x.GetCustomAttribute<BrowsableAttribute>();
                if (y != null) { return y.Browsable; }
                else return true;
            })
            .Select(x => x.Name);

        foreach (var prop in y2)
        {
            Console.WriteLine(prop);
        }

    }
}


class Student
{
    //特性名Browsable不是随便自定义的，需被系统定义
    //当然也可以以继承Attribute父类的形式自定义
    [Browsable(true)]
    public string Name { get; set; }
    [Browsable(false)]
    public int Id { get; set; }
    [Browsable(true)]
    public string FirstName { get; set; }
}
```

(2023.8.15)

## 3.9 IOC和AOP

### 3.9.1 IOC

=>就我理解，IoC就是三个步骤：1.建立工厂；2.注册类型-实例对应关系；3.取用实例化。而其中注册类型时候有三种模式：1.Singleton；2.Transient；3.Scope.  WPF Prism默认支持两种IoC容器：1.DryLoC; 2.Unity. 当然你也可以采用别的MVVM框架如`CommunityToolkit.Mvvm`，拿`Microsoft.Extensions.DependencyInjection`来作为IoC容器。

以`Microsoft.Extensions.DependencyInjection`为例阐述IOC中的三种注册模式：

视频地址：[CtrlClickHere](https://www.bilibili.com/video/BV1KX4y1m7Su/?spm_id_from=333.999.0.0&vd_source=6fc477a8e79179a3fd30bed2e2ba5fbe)

```C#
namespace PlayWithCSharp.IoC
{
    internal class MicrosoftExtensionDependcyInjection
    {
        //注册为单例Singleton,工厂对于相同的类型只创立一个实例
        public static void testForSingleton()
        {
            var builder = new ServiceCollection();
            builder.AddSingleton<ILogger, MyLogger>();


            var service = builder.BuildServiceProvider();
            var logger = service.GetRequiredService<ILogger>();
            logger.Log("Hello");

            var logger2 = service.GetRequiredService<ILogger>();
            logger2.Log("Hello");
        }

        //注册为瞬时Transient,工厂每次遇到申请均为new一个新的实例
        public static void testForTransient()
        {
            var builder = new ServiceCollection();
            builder.AddTransient<ILogger, MyLogger>();


            var service = builder.BuildServiceProvider();
            var logger = service.GetRequiredService<ILogger>();
            logger.Log("Bye");

            var logger2 = service.GetRequiredService<ILogger>();
            logger2.Log("Bye");
        }

        //注册类型还有一个scope，多用于ASP.NET

        interface ILogger
        {
            void Log(string message);
        }

        class MyLogger : ILogger
        {
            private static int id = 0;
            public int Id { get { return id; } set { } }
            public MyLogger() { Id = id++; }


            public void Log(string message)
            { 
                Console.WriteLine(message+":"+Id);
            }  
        }
    }
}
```

(2023.7.15)

#### 3.9.1.1 Unity

Unity是一个微软团队开发的一个轻量级IOC(Inversion of Control)容器，用来实现依赖注入DI(Dependency DI），为松散耦合应用程序提供了很好的解决方案。使用NuGet程序包可以方便安装Unity插件。

> IOC：控制反转，把程序上层对下层的依赖，转移到第三方的容器来装配。是程序设计的目标，实现方式包含了依赖注入和依赖查找（.net里面只有依赖注入）
>
> DI：依赖注入，是IOC的实现方式。

先来看看最简单的Unity实现方式：

```C#
IUnityContainer container = new UnityContainer();//1、定义一个空容器
container.RegisterType<IDbInterface, DbMSSQL>();//2、注册类型，表示遇到IDbInterface的类型，创建DbMSSQL的实例
var db = container.Resolve<IDbInterface>();//3、遇到IDbInterface的类型，创建DbMSSQL的实例
Console.WriteLine(db.Insert());
Console.ReadKey();
```

再来看WPF中的应用：

```C#
using System.Windows;
using Prism.Mvvm;
using Unity;

namespace Example_Tool
{
    public partial class App : Application
    {
        //创建容器
        private IUnityContainer Container { get; } = new UnityContainer();

        private void Application_Startup(object sender, StartupEventArgs e)
        {
           //在WPF Prism框架中自定义view与ViewModels的绑定方式
           //据此初始化时view才能找到相应的viewmodel
           ViewModelLocationProvider.SetDefaultViewModelFactory(x => this.Container.Resolve(x));

            //获取对象实例
            var Main = this.Container.Resolve<Views.MainWindow>();
            Main.ViewModel.Mode = mode;
            Main.Show();
        }
    }
}

```

(2023.3.30)

### 3.9.2 AOP

C#的特性与Java的注解，Python的装饰器一样是各自语言中对AOP(Aspect Oriented Programming，即面向切面编程)设计模式的实现方式。

> AOP把系统分解为不同的关注点，或者称之为切面（Aspect），是一种**在运行时，动态地将代码切入到类的指定方法、指定位置上的编程思想**
>
> 比如现在有一个网站，有购物、社交、游戏等多种功能且对所有用户开放，现在需要限制只有高级会员才能使用其中的几个功能，我们可以在每个模块加上if判断，但这样侵入性太强，且会造成大量重复代码；换成AOP的方法就是使用装饰器，在需要高级会员的地方加上限制就行

=>即C#的AOP设计模式通过特性来体现。

# 4 OOP设计模式 

## 4.1 GoF中的23种设计模式

参考： [文字资料](https://www.runoob.com/design-pattern/strategy-pattern.html)  + 书籍：《大话设计模式》

| 设计模式                                     |                                                              |
| -------------------------------------------- | ------------------------------------------------------------ |
| Strategy Pattern (策略模式)                  | 定义一系列的算法,把它们一个个封装起来, 并且使它们可相互替换。此模式让算法的变化独立于使用算法的客户。 |
| Decorator Pattern (装饰器模式)               | 动态地给一个对象添加一些额外的职责。就增加功能来说，装饰器模式相比生成子类更为灵活。 |
| Proxy Pattern（代理模式）                    | 为其他对象提供一种代理以控制对这个对象的访问。=> 从is-a 转换为 has-a, 如基地局MixMode可以代理LTE与NR，而不是继承其中之一 |
| Factory Pattern (工厂模式)                   | 只需要通过 new 就可以完成创建的对象，无需使用工厂模式。如果使用工厂模式，就需要引入一个工厂类，会增加系统的复杂度。 => 如果需要解决客户端只需要调用基类中的方法，但却要实现许多子类，那么简单工厂模式会比较合适 |
| Prototype Pattern (原型模式)                 | 原型模式很少单独出现，一般是和工厂方法模式一起出现，通过 clone 的方法创建一个对象，然后由工厂方法提供给调用者。 |
| Template Pattern (模板模式)                  | 将子类共有的方法抽象到父类中作为模板方法。为防止恶意操作，一般模板方法都加上 final 关键词。 =>比如基地局数据转化中，无论LTE/NR类，均用公有方法，适合该模式 |
| Facade Pattern (外观模式)                    | 在客户端和复杂系统之间再加一层，这一层将调用顺序、依赖关系等处理好。=> 理想情况下客户端只要new一个Starter类，模块中所有功能依次实现 |
| Builder Pattern (建造者模式)                 | 一些基本部件不会变，而其组合经常变化的时候。                 |
| Observer Pattern (观察者模式)                | 让原本耦合的发布和订阅双方都依赖于抽象接口而不是具体类，是依赖倒转原则的最佳体现。C#的事件委托技术是对此模式的升级。 |
| Abstract Factory Pattern (抽象工厂模式)      | 围绕一个超级工厂创建其他工厂。该超级工厂又称为其他工厂的工厂。 |
| State Pattern (状态模式)                     | 状态模式与策略模式很相似，也是将类的"状态"封装了起来，在执行动作时进行自动的转换，从而实现，类在不同状态下的同一动作显示出不同结果。 |
| Adapter Pattern (适配器模式)                 | 系统的数据和行为都正确，但接口不符时，应该考虑用适配器。     |
| Memento Pattern (备忘录模式)                 | 在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。如打游戏时的存档。 |
| Composite Pattern (部分整体模式)             | 将对象组合成树形结构以表示"部分-整体"的层次结构。如公司组织图。关键代码：每个Component中包含一个`List<Component>` |
| Iterator Pattern (迭代器模式)                | Java 和 .Net 编程环境中非常常用的设计模式。=> `for each`     |
| Singleton Pattern (单例模式)                 | 保证一个类仅有一个实例，并提供一个访问它的全局访问点。关键代码：构造函数是私有的。 |
| Bridge Pattern (桥接模式)                    | 实现系统可能有多个角度分类，每一种角度都可能变化。把这种多角度分类分离出来，让它们独立变化，减少它们之间耦合。=> 如基地局即可按LTE/NR/MixMode分，也可以按CRAN/DRAN分，如果纯粹用继承，类的数量则是3x2乘积关系，用桥接则是3+2加和关系。 |
| Command Pattern (命令模式)                   | 一种数据驱动的设计模式，它属于行为型模式。请求以命令的形式包裹在对象中，并传给调用对象。将"行为请求者"与"行为实现者"解耦。     =>WPF的Command机制 |
| Chain of Responsibility Pattern (责任链模式) | 避免请求发送者与接收者耦合在一起，让多个对象都有可能接收请求，将这些对象连接成一条链，并且沿着这条链传递请求，直到有对象处理它为止。 =>WPF的Binding目标捕获Binding源所激发的事件 |
| Mediator Pattern (中介者模式)                | 多个类相互耦合，形成了网状结构时，可以将上述网状结构分离为星型结构。 |
| Flyweight Pattern (享元模式)                 | 在有大量对象时，有可能会造成内存溢出，我们把其中共同的部分抽象出来，如果有相同的业务请求，直接返回在内存中已有的对象，避免重新创建。关键代码：用 HashMap 存储这些对象。 |
| Interpreter Pattern (解释器模式)             | 给定一个语言，定义它的文法表示，并定义一个解释器，这个解释器使用该标识来解释语言中的句子。这种模式被用在 SQL 解析、符号处理引擎等。 |
| Visitor Pattern (访问者模式)                 | 主要将数据结构与数据操作分离。主要解决稳定的数据结构和易变的操作耦合问题。 |

Simple Factory Pattern 简单工厂模式 不在GoF的23种模式之中



## 4.2 设计原则

面向对象的的几种设计原则：

| 简称 | Link                                                         | 中文                       | 介绍                                                         |
| ---- | ------------------------------------------------------------ | -------------------------- | ------------------------------------------------------------ |
| SRP  | [Single Responsibility Principle](http://www.cnblogs.com/gaochundong/p/single_responsibility_principle.html) | 单一职责原则               | 软件设计就是对职责分门别类，引起类变化的原因应该仅有一个     |
| OCP  | [Open Closed Principle](http://www.cnblogs.com/gaochundong/p/open_closed_principle.html) | 开放封闭原则               | 开放扩展，封闭类内修改                                       |
| DIP  | [Dependency Inversion Principle](http://www.cnblogs.com/gaochundong/p/dependency_inversion_principle.html) | 依赖倒转原则               | 细节应该依赖于宏观的抽象（常识上说抽象依赖于细节，所以称为依赖倒转），典型就是接口编程：先有接口，然后在对其实现编程 |
| LSP  | [Liskov Substitution Principle](http://www.cnblogs.com/gaochundong/p/liskov_substitution_principle.html) | 里氏代换原则               | 子类可以在不影响软件单位功能的情况下替代父类                 |
| ISP  | [Interface Segregation Principle](http://www.cnblogs.com/gaochundong/p/interface_segregation_principle.html) | 接口分离原则               | 客户类不应被强迫依赖那些它们不需要的接口                     |
| LKP  | [Least Knowledge Principle](http://www.cnblogs.com/gaochundong/p/least_knowledge_principle.html) | 最少知识原则(迪米特拉法则) | 每个类尽量降低成员访问权限，强调类之间的松耦合               |



## 4.3 抽象类和接口

> 抽象类和接口的区别：
>
> 从表象上来说，抽象类可以给出一些成员的实现，接口却不包含成员的实现，抽象类的抽象成员可被子类部分实现，接口的成员需要完全实现，一个类只能继承一个抽象类，但可实现多个接口等等；
>
> 但以上都是从两者的形态上去区分。从设计的角度讲，有三点区别：
>
> 1. 类是对对象的抽象；抽象类是对类的抽象，接口是对行为的抽象；
> 2. 如果行为跨越不同类的对象，可使用接口；对于一些相似的类对象，用继承抽象类；
> 3. 从设计的角度讲，抽象类是从子类中发现了公共的东西，泛化出父类，然后子类继承父类。而接口是根本不知道子类的存在，方法如何实现还不确认，预先定义。
>
> 两者的思维过程是相反的，抽象类是自底而上抽象出来的，而接口则是自顶而下设计出来的，所以抽象类往往通过重构而来。
>
> (引用于《大话设计模式》)

=> 抽象类适用于 模板模式，将子类的共同行为集中于基类。

(2023.11.17)

# 5 .NET框架

## 5.1 LINQ

> LINQ是Language-Integrated Query的缩写，它可以视为一组语言和框架特性的集合。LINQ可以对本地对象集合或远程数据源进行结构化的类型安全的查询操作。LINQ支持查询任何实现了IEnumerable<T>接口的集合类型，无论是数组、列表还是XML DOM，乃至SQL Server数据库中的数据表这种远程数据源都可以查询。

=>LINQ可以直接操作数据库，也可以操作数组和集合，DataSet数据集和XML.

Enumerable 类 (位于`System.Linq`空间): 提供一组用于查询实现 `IEnumerable<T>` 的对象的 static方法=>LINQ. 该类中的大多数方法被定义为 `IEnumerable<T>` 的扩展方法。 这意味着可以像调用实现 `IEnumerable<T>` 的任意对象上的实例方法一样调用它们。如 :

```C#
//1.流式语法
var res2 = lst
    .Where(n => n % 2 == 0 && n >= 4)
    .OrderBy(n => n)
    .Select(n => n);
//也可以写成查询表达式形式（C#为LINQ查询提供的一种简化的语法结构）：
//这种语法就像是在C#中内嵌SQL
//2.查询表达式
 var res = from n in lst
           where n % 2 == 0 && n >= 4
           orderby n
           select n;
```

=>即能被LINQ操作的容器以实现`IEnumerable`接口为前提。因为本来LINQ就是`IEnumerable<T>` 的扩展方法嘛！



LINQ的重要性质：延迟执行

> 大部分查询运算符的一个重要性质是它们并非在构造时执行，而是在枚举（即在枚举器上调用MoveNext）时执行。
> 比如下面这个例子：
>
> ```c#
> var numbers = new List<int>() {1, 2, 3};  
> var res = numbers.Select(e => e * 10);  
> numbers.Add(4);  
> 
> foreach (var item in res)  
> {  
>  Console.Write(item+" ");  
> }  
> // 输出结果:  
> // 10 20 30 40
> 
> ```
>
> 从直觉上讲，这段代码的输出结果应该是10 20 30，毕竟numbers数组是在查询结束后才发生的改变。但事实并非如此。在查询语句创建结束后，向列表中新添加的数字也出现在了查询结果中。这是因为查询逻辑只有在foreach执行时才会生效，即延迟执行。
>
> 延迟执行是一个很重要的特性。因为它将查询的创建和查询的执行进行了解耦。这使得查询可以分多个步骤进行创建，尤其适用于创建数据库查询。

> 延迟执行原理：
>
> LINQ查询实际上使用了装饰模式。查询运算符通过返回装饰器序列来提供延迟执行的功能。装饰器序列不同于一般的集合类（如数组或链表），它（一般）并没有存储元素的后台结构。而是包装了一个在运行时才会生成的序列，并永久维护其依赖关系。当向装饰器序列请求数据时，它就不得不向被包装的输入序列请求数据。如下图中，只有当枚举lessThanTen时，才开始真正通过Where装饰器对数组执行查询。

> 简而言之装饰器模式就是动态的给一个对象添加一些额外的职责。就增加功能来说，装饰器模式比增加子类更为灵活
>
> 装饰器模式：装饰器模式（Decorator Pattern）允许向一个现有的对象添加新的功能，同时又不改变其结构。这种类型的设计模式属于结构型模式，它是作为现有的类的一个包装。这种模式创建了一个装饰类，用来包装原有的类，并在保持类方法签名完整性的前提下，提供了额外的功能。
>

=>记得Python中也有装饰器这样的语法糖。阅读5.1.1节就可以更好理解LINQ的装饰器概念。



实际工作中也会用到流式语法来代替多层for循环，即简洁~~速度也会大大加快！~~

```C#
//取得DataTable
DataTable siteInfo = GetTargetTable("基本情報");
//先将DataTable转化为IEnumerable
DataRow[] resultRows = siteInfo.AsEnumerable()
    .Where(row => row[columnNameMap["基本情報"]["ID"]].ToString() == inputNeid) //Lambda语法
    .Where(row => row[columnNameMap["基本情報"]["flag"]].ToString() == "有効")
    .Where(row => row[columnNameMap["基本情報"]["flag2"]].ToString() == "新局" ||
    row[columnNameMap["基本情報"]["flag2"]].ToString() == "BFD化")
    .Select(row => row)
    .ToArray();
```

> The best practice depends on what you need:
>
> 1. Maintainability: LINQ
> 2. Performance: manual code like For loop

=>LINQ的速度通常比不过For循环 (2023.8.16)



### 5.1.1 `IEnumerable` 和 `IEnumerator`

> IEnumerable接口和IEnumerator接口是.NET中非常重要的接口，二者有何区别？
>
> 1. 简单来说`IEnumerable`是一个声明式的接口，声明实现该接口的类就是“可迭代的enumerable”,但并没用说明如何实现迭代器iterator.其代码实现为：
>
> ```c#
>      public interface IEnumerable
>      {
>         IEnumerator GetEnumerator();
>      }
> ```
>
> 2. 而`IEnumerator`接口是实现式接口，它声明实现该接口的类就可以作为一个迭代器iterator.其代码实现为：
>
> ```c#
>     public interface IEnumerator
>     {
>         object Current { get; }
> 
>         bool MoveNext();
>         void Reset();
>      }
> ```
>
> 3.一个collection要支持Foreach进行遍历，就必须实现IEnumerable,并以某种方式返回迭代器对象:IEnumerator.

=>简而言之，为了完成`foreach`语法形式的语法糖，需要实现`IEnumerable`接口的类；而实现`IEnumerable`接口的类，必须也要定义相应的实现`IEnumerator`接口的迭代器。

```C#
class ExecerciseForEnum
 {
     public static void ClassMain()
     {
	#if true
         MyList my = new MyList();

         foreach (var item in my)
         {
             Console.WriteLine(item);
         }
	#else
         //等价于(若要编译通过，语法层面还需调整)
         MyList my = new MyList();

         MIEnumtor mIEnumtor = my.GetEnumerator();

         while (mIEnumtor.MoveNext())
         {
             Console.WriteLine(mIEnumtor.Current);
         }
	#endif
         //foreach其实是一种语法糖，用来简化对可枚举元素的遍历代码。
         //而被遍历的类通过实现IEnumerable接口和一个相关的IEnumerator枚举器来满足此语法糖
     }

     //模仿ArrayList来实现一个简单的MyList
     //1.实现IEnumerable接口
     public class MyList : IEnumerable
     {
         public int[] _data = new int[10] { 1, 5, 7, 9, 7, 8, 7, 8, 7, 4 };

         //索引器
         public int this[int index]
         {
             get
             {
                 return _data[index];
             }
         }


         IEnumerator IEnumerable.GetEnumerator()
         {
             Console.WriteLine("foreach:call  GetEnumerator");
             //给foreach返回一个IEnumerator枚举器，该方法只在进入foreach之际执行一次
             return new MIEnumtor(this);
         }

     }

     //2.实现与MyList紧密相关的IEnumerator枚举器
     public class MIEnumtor : IEnumerator
     {
         private MyList myList;
         private int index;
         public MIEnumtor(MyList my)
         {
             index = -1;
             myList = my;
         }

         //属性Current中负责返回当前index位置的元素
         //每循环一次执行一次
         public object Current
         {
             get
             {
                 Console.WriteLine("foreach:call  Current");
                 return myList[index];
             }
         }

         //MoveNext()负责让Current获取下一个值，并判断遍历是否结束
         //每循环一次执行一次
         public bool MoveNext()
         {
             Console.WriteLine("foreach:call  MoveNext");
             if (index < myList._data.Length - 1)
             {
                 index++;
                 return true;
             }
             index = -1;
             return false;
         }

         //Rest()负责重置枚举器的状态（在foreach中没有用到）
         public void Reset()
         {

         }
         //通过输出结果，我们可以发现，foreach在运行时会先调用MyList的GetIEnumerator函数获取一个MIEnumtor，
         //之后通过循环调用MIEnumtor的MoveNext函数，index后移，更新Current属性，然后返回Current属性，直到MoveNext返回false。
     }

 }
```

（2023.6.25）

### 5.1.2 LINQ中的Lambda

C#Lambda基本的表达形式：(参数列表) => {方法体}

> 参数列表中的参数类型可以是明确类型或者是推断类型
>
> 如果是推断类型，则参数的数据类型将由编译器根据上下文自动推断出来
>
>  Lambda 用在基于方法的 LINQ 查询中，作为诸如Where 和 Where 等标准查询运算符方法的参数。

```C#
var words = new[] { "the", "quick", "brown", "fox", "jumps" };

    //1.根据words中，字符的长度进行排序
         var query1 = from word in words
                      orderby word.Length
                      select word;

         foreach (var word in query1)
         {
             Console.WriteLine(word);
         }

//Lambda, 这个很好理解o是参数，o.Length即是函数体也是返回值
var query1L = words.OrderBy(o => o.Length)

   //1.Where，和sql语句中的Where一样
         var query = from word in words
                     where word.Length == 3
                     select word;
         foreach (var item in query)
         {
             Console.WriteLine(item);
         }

//Lambda，这个稍微难以理解，w是参数，w.Length ==3难道会被潜在扩展成条件判断啊...
var queryL = words.Where(w => w.Length ==3);
```

=>Lambda作为LINQ链式表达式的参数，有点像从数据容器中提炼各个数据的性质的感觉。另外还有点pipe的感觉，数据管道

(2023.6.26)



## 5.2 正则表达式 

C#中使用正则表达式的三个类主要位于命名空间`System.Text.RegularExpressions`下：`Regex,MatchCollection,Match`。

主要介绍Regex这个类，其静态方法主要有：

```C#
//IsMatch用于判断指定的字符串是否与正则表达式字符中匹配
Regex.IsMatch(text5, "^Conv"))；
//Replace函数是实现替换功能    
//把字符串inFileName中的pattern替换成空字符串    
Regex.Replace(inFileName, pattern, "")
```

也可以通过实例化类的形式来进行正则表达式操作：

```c#
Regex reg = new Regex("[0-9]*");//这是搜索匹配0-9的数字
Console.WriteLine(reg.Match("12asda"));//最后提取出了12成功
```

(2023.4.20)

=>`IsMatch`与`Match`的区别在于前者返回布尔值，后者返回匹配结果。

Match中的Group：

```C#
string example = "[2022-04-14 01:53:02] << PTNLRPS,1,0,1,0*57";
//注意表达式中的()符号，其用于配合group提取特定字段
//(pattern)=>匹配pattern并获取这一匹配。所获取的匹配可以从产生的Matches集合得到
var rex = new Regex("PTNLRPS,[0-9],[0-9],[0-9],([0-9]+)\\*[0-9]+");
var match= rex.Match(example);

int i = 0;
//下例展示Match的Group属性用法
while (match.Success)
{
    var groups_i = match.Groups;
    for (int j = 0; j < groups_i.Count; j++)
    {
        //Group[0] 默认返回全部匹配字符串
        //Group[1] 返回Regex第一个括号所框定的字段，上例即([0-9]+)
        //依次还有Group[2]...
        var group_i_j = groups_i[j].Value;
        Console.WriteLine("matches[{0}].Groups[{1}].Value= ┫{2}┣", i, j, group_i_j);
    }
    Console.WriteLine("---------------------------------------------------");

    match = match.NextMatch();    
    i++;
}
```



正则表达式 (regex) 基础知识：

| 标记      | 作用                                                         | 例如                                                        |
| --------- | ------------------------------------------------------------ | ----------------------------------------------------------- |
| .         | 匹配任何单个字符                                             | "bfnOffset.+(-[0-9]+)"                                      |
| +         | 表示字符的一个或多个实例                                     | [nop]+ 将匹配 n、o 或 p 字符中的一个或多个                  |
| x\|y      | 匹配x或y                                                     | “z\|food”能匹配“z”或“food”。“(z\|f)ood”则匹配“zood”或“food” |
| *         | 匹配前面的子表达式零次或多次。                               | 例如，zo*能匹配“`z`”以及“`zoo`”。                           |
| {n}       | 匹配前面的字符n次                                            | 例如，匹配五个数字  \d{5}或[0-9]{5}                         |
| $         | 匹配输入字符串的结束位置。                                   |                                                             |
| (pattern) | 匹配pattern并获取这一匹配。所获取的匹配可以从产生的Matches集合得到 |                                                             |
| [^xyz]    | 负值字符集合。匹配未包含的任意字符。                         | 例如\[^abc\]可以匹配“plain”中的“p”                          |
|           |                                                              |                                                             |

(2023.7.18)

### Appendix

1.如何以逗号分割字符串且忽略引号中的逗号？

```c#
//(pattern)：()表示捕获分组，()会把每个分组里的匹配的值保存起来，从左向右，以分组的左括号为标志，第一个出现的分组的组号为1，第二个为2，以此类推
//(?=pattern): (?:)表示非捕获分组，和捕获分组唯一的区别在于，非捕获分组匹配的值不会保存起来。例如，“Windows(?=95|98|NT|2000)”能匹配“Windows2000”中的“Windows”，但不能匹配“Windows3.1”中的“Windows”。
//(?:pattern):(?:pattern) 与 (?=pattern)都匹配pattern，但不会把pattern结果放到Matches的集合中，即Matcher.group()不会匹配到(?;pattern)与(?=pattern)。但是(?:pattern) 匹配得到的结果包含pattern，(?=pattern) 则不包含。例如“industr(?:y|ies)”等同于“industry|industries”。并且(?:pattern) 消耗字符，下一字符匹配会从已匹配后的位置开始。(?=pattern) 不消耗字符，下一字符匹配会从预查之前的位置开始。即后者只预查，不移动匹配指针。=>其实下例中似乎把(?:pattern)换成(pattern)也行，反正无需捕获


//这个问题最关键的就是 如何去匹配除括号内的逗号作为分隔符？ 
//如果一个逗号后面的引号数量是偶数就可以匹配，否则不匹配
string example = @"""GNBDUFunction=1,NRSectorCarrier=44051-1049797-2"",altitude,false";
var result3 = Regex.Split(example, ",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");
foreach (string s in result3) Console.WriteLine(s);
```

(2023.8.1)

## 5.3 ADO.NET

> **ADO.NET**是微软在.NET Framework中负责数据访问的类别库集，它可以让.NET上的任何编程语言能够连接并访问关系数据库与非数据库型数据源（例如XML，Excel或是文字档数据），或是独立出来作为处理应用程序数据的类别对象，其在.NET Framework中的地位是举足轻重。
>
> ADO.NET类封装在System.Data.dll中，并且与System.Xml.dll中的XML类集成。

### 5.3.1  DataSet vs DataTable

> ### ADO.NET架构
>
> ADO.NET由连线数据源（connected data source）以及离线数据模型（disconnected data model）两个部分构成，这两个部分是相辅相成的。
>
> 连线数据源：若没办法连线到数据库，则无法被称为数据访问组件。连线数据源便是用来连接数据库的对象类别，由下列接口构成：
>
> 1. **IDbConnection**，负责与数据库的连线管理，包含连线字符串（connection string），连线的开关，数据库交易的启始与连线错误的处理，所有的ADO.NET数据提供者都要实现此接口。
> 2. **IDbCommand**，负责执行数据库指令（在大多数的案例中都是[SQL](https://zh.wikipedia.org/wiki/SQL)指令），并传回由数据库中截取的结果集，或是执行不回传结果集的数据库指令。
> 3. DataReader对象：创建一个只可向前读取光标（forward-only）的数据读取器工具，以逐列读取方式访问数据，`IDbDataAdapter`内部也是由它来读取数据。
> 4. DataAdapter对象：负责将来自于IDbCommand执行获取的结果集，装载到离线型数据集（DataSet）或是离线型数据表（DataTable）中。
> 5. ...
>
> 离线数据模型：离线数据模型是微软为了改良ADO在网络应用程序中的缺陷所设计的，同时它也是IMDB技术的设计概念的实现品，但它并没有完整的IMDB功能，像是交易处理（transaction processing），但它仍不失为一个能在离线状态下处理数据的好帮手，它也可以透过连线数据源对象，支持将离线数据存回数据库的能力。离线数据模型由下列对象组成：
>
> 1. **DataSet**，离线型数据模型的核心之一，可将它当成一个离线型的数据库，它可以内含许多个DataTable，并且利用关系与限制方式来设置数据的完整性，它本身也提供了可以和XML交互作业的支持。
> 2. **DataTable**，离线型数据模型的核心之一，可将它当成一个离线型的数据表，是存储数据的收纳器。
> 3. ...(**DataRow**, **DataColumn**)

| Features | DataSet                                        | DataTable                                                    |
| -------- | ---------------------------------------------- | ------------------------------------------------------------ |
| Elements | DataSet  is formed collectively of datatables. | DataTable  is composed of multiple rows and columns to have better access to data. |

> Dataset defines the relationship between the tables and the constraints of having them in the dataset; since there is only one table represented in Datatable, the relationships need not be defined in the Datatable.

`DataSet`和`DataTable`是数据转换中非常重要的概念，`DataSet`就像一个存在于C#程序内存中的临时关系型数据库。C#从数据库或者Excel中取出数据，放入`DataSet`来管理其中各种Tables的关系，然后断开数据库。而`DataTable`正是这个临时数据库中的Table，由数据库中的表或者Excel中一个sheet页又或者CSV文件（CSV文件只能有一个sheet页）转化而来，其中又由`row`和`column`组成。

=>两者皆是ADO.NET框架中的离线数据模型。

DataTable的一些常用操作：

```C#
DataTable table = new DataTable("Table");

// 追加列
table.Columns.Add("教科");
table.Columns.Add("点数", Type.GetType("System.Int32"));
table.Columns.Add("氏名");
table.Columns.Add("Class");


table.Rows.Add("数学", 80, "田中　一郎", "A");
table.Rows.Add("英語", 70, "田中　一郎", "A");
table.Rows.Add("国語", 60, "鈴木　二郎", "A");
table.Rows.Add("数学", 50, "鈴木　二郎", "A");
table.Rows.Add("英語", 80, "鈴木　二郎", "A");
table.Rows.Add("国語", 70, "佐藤　三郎", "B");
table.Rows.Add("数学", 80, "佐藤　三郎", "B");
table.Rows.Add("英語", 90, "佐藤　三郎", "B");


Console.WriteLine("+++++++++++++++++++++");

//1.使用DataTable的Select方法摘选特定行并升序
//作为参数的字符串似乎会被方法进一步解析
var dr1 = table.Select($"教科='数学'", "点数 ASC");
foreach (var row in dr1)
{
    Console.WriteLine("{0}：{1}：{2}:{3}", row[0], row[1], row[2], row[3]);
}

Console.WriteLine("+++++++++++++++++++++");

//2.使用DataTable的Compute方法对数据进行简单计算
object ob = table.Compute("Max(点数)", "氏名 = '鈴木　二郎'");
Console.WriteLine("{0}点", (int)ob);


Console.WriteLine("+++++++++++++++++++++");

//3.1 使用LINQ操作DataTable
var dr2 = table.AsEnumerable()
    .Where(row => row[0] == "英語")
    .Select(row => row)
    .ToArray();

foreach (var row in dr2)
{
    Console.WriteLine("{0}：{1}：{2}:{3}", row[0], row[1], row[2], row[3]);
}
//3.2 
var dr3 = from row in table.AsEnumerable()
          where row[0] == "国語"
          select row;

foreach (var row in dr3)
{
    Console.WriteLine("{0}：{1}：{2}:{3}", row[0], row[1], row[2], row[3]);
}

//DataTable在WPF中还可以与GridData绑定，直接在GUI中显示

//往DaTaTable写入值 2024.2.16
var outputtable = new DataTable();
var newRow = outputtable.NewRow();
newRow[0] = "1";
outputtable.Rows.Add(newRow);
```

(2023.7.6)

实例：

```C#
private string GetFlagFromTable(string moid)
{
	//1.使用LINQ操作DataTable
    DataRow[] rows = table_kddi_ro_progress.AsEnumerable()
       .Where(row => row["メインオーダID"].ToString() == moid)
       .Select(row => row)
       .ToArray();
    //2.使用DataTable的Select方法摘选
    DataRow[] rows = table_kddi_ro_progress.Select($"[メインオーダID] = {moid}");
    //需要注意的是moid中存在-符号，会影响第二种方法的摘选精度，最终报错
}
```

(2023.11.29)

### 5.3.2 数据库

> ### ADO.NET数据提供者(Data Provider)
>
> 在.NET Framework中，ADO.NET默认提供了四种数据源：
>
> 1. SQL Server：由System.Data.SqlClient提供原生数据源，是微软官方建议访问SQL Server时建议使用的数据提供者。
> 2. OLE DB Data Source：由System.Data.OleDb提供支持，可适用于OLE DB Provider for ODBC以外的OLE DB数据提供者。
> 3. Oracle：由System.Data.OracleClient提供支持，必须同时引用 System.Data和  System.Data.OracleClient。
> 4. ODBC：补OLE DB Provider for ODBC的支持，由System.Data.Odbc提供支持。
>
> 其他厂商亦为不同的数据库提供数据源：
>
> - MySQL为本身的MySQL Database Server提供了ADO.NET的原生数据提供者。
> - Oracle自行开发的.NET Data Provider。
>
> 对每种Data Provider，ADO.NET要实现下述对象结构：
>
> - Connection对象提供与数据源的连接。
> - Command对象使您能够访问用于返回数据、修改数据、运行存储过程以及发送或检索参数信息的数据库命令。=>用来执行SQL语句。
> - DataReader对象从数据源中提供快速的，只读的数据流。=>暂存Command对象执行可读SQL语句后的结果。
> - DataAdapter对象提供连接 DataSet 对象和数据源的桥梁。DataAdapter 使用 Command 对象在数据源中执行 SQL 命令，以便将数据加载到 DataSet 中，并使对 DataSet 中数据的更改与数据源保持一致。
> - Parameter对象用于参数化查询。

#### 5.3.2.1 PostgreSQL

以Npgsql举例：

Npgsql is the open source .NET data provider for PostgreSQL.

```C#
//using Npgsql;
public ImportDB(string connetcionInfo, string path)
{
    this.ConnectionSetting = connetcionInfo;
    this.csvfilepath = path;
    //传入类似 xxx.postgres.database.azure.com port=5432 这样的数据库信息
    NpgsqlConnection conn = new NpgsqlConnection(ConnectionSetting);
    //Connection:Open() 开启数据库连线。
    conn.Open();
    NpgsqlCommand command = new NpgsqlCommand("select version()", conn);
    String serverversion;
    try
    {
        //Command:ExecuteScalar()：执行指令并回传第一列第一行中的值（object类型）。当没有数据时，ExcuteScalar方法返回System.DBNull。
        serverversion = (String)command.ExecuteScalar();
    } catch(Exception e)
    {
        throw new Exception("DB connection setting is error.please check the DB connection setting again!");
    }
    finally
    {
         //Connection:Close() 关闭数据库连线。
        conn.Close();
    }
}
```

```C#
public void InsertData(DataSet dataset)
{
    string dsn = ConnectionSetting;
    //把需要事务包裹的逻辑块写在using (TransactionScope ts = new TransactionScope())中,TransactionScope实现了IDispose接口。
    using (TransactionScope ts = new TransactionScope())
    {
        foreach (DataTable table in dataset.Tables)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(dsn))
            {
                var cmd_str = string.Format("INSERT INTO xxx VALUES xxx ");

                conn.Open();
                NpgsqlCommand cmd = new NpgsqlCommand(cmd_str, conn);
                //Command:ExecuteNonQuery()：执行不回传结果集的数据库指令，像是INSERT、UPDATE与DELETE指令，返回值为该命令所影响的行数。 对于其他所有类型的语句，返回值 为 -1。
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        //除非显示调用ts.Complete()方法。否则，系统不会自动提交这个事务。
        ts.Complete();
    }
}
```

```C#
public string GetData()
 {
     var dsn = ConnectionSetting;
     string columnlist = "";
     using (TransactionScope ts = new TransactionScope())
     {
         using (NpgsqlConnection conn = new NpgsqlConnection(dsn))
         {
             conn.Open();
             string columncmd = string.Format(@"SELECT * FROM XXX')");
             var columnlistcommand = new NpgsqlCommand(columncmd, conn);
             //Command:ExecuteReader()：执行指令并回传IDataReader对象，以读取数据集中的数据。
             var columnlistdataReader = columnlistcommand.ExecuteReader();
             while (columnlistdataReader.Read())
             {
                 columnlist = columnlistdataReader.GetValue(0).ToString();
             }
             columnlistdataReader.Close();
             conn.Close();
         }
         ts.Complete();
     }
     return columnlist;
 }
```

```C#
public void InsertData2()
{
    try
    {
        var connString = ConnectionSetting;
        var sql = "select * from z where x=y;"
        
        using (var connection = new NpgsqlConnection(connString))
        {
            connection.Open();
            
            DataTable dt = new DataTable();
            NpgsqlCommand cmd = new NpgsqlCommand(sql, connection);
            NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(cmd);
            //DataAdapter:Fill()：将数据填入离线型数据对象。
            adapter.Fill(dt);

            string OutputName = dt.Rows[0]["NAME"].ToString();

            cmd.Connection = connection;
            cmd.CommandText = "INSERT INTO xxx VALUES (@mid)";
            cmd.Parameters.AddWithValue("@mid", OutputName);
            cmd.ExecuteNonQuery();

            connection.Close();
        }
    }
    catch (Exception ex)
    {}
}
```

#### 5.3.2.2 SQLite

> 不像常见的客户端/服务器结构数据库管理系统，SQLite引擎不是一个应用程序与之通信的独立进程。SQLite库链接到程序中，并成为它的一个组成部分。这个库也可被动态链接。应用程序经由编程语言内的直接API调用来使用SQLite的功能，这在减少数据库访问延迟上有积极作用，因为在一个单一进程中的函数调用比跨进程通信更有效率。SQLite将整个数据库，包括定义、表、索引以及数据本身，作为一个单独的、可跨平台使用的文件存储在主机中。SQLite将PostgreSQL作为参考平台。项目将“PostgreSQL可能做些什么”作为SQL标准实现的开发参考.
>

=>SQLite产生的数据库以xxx.db 的本地文件形式与程序进行交互

```C#
internal class ValueCalc
{
    /// <summary>
    /// Connector to SQLite DB
    /// </summary>
    protected SQLiteConnection dbConnection;

    public ValueCalcBase(string shogenDBpath
    {
        this.shogenDBpath = shogenDBpath;
        // Connect to SQLite DB
        this.dbConnection = new SQLiteConnection($"Data Source={shogenDBpath + "XXX.db"}");
        dbConnection.Open();
    }
    
    protected override string GetValForSite_name()
    {
       string sql = $"select [site_info] from SYOGEN_Table where [site_info_ID] == {id}";

       SQLiteCommand command = new SQLiteCommand(sql, dbConnection);
       SQLiteDataReader reader = command.ExecuteReader();

       if (reader.Read()) return reader.GetString(0);
       else
       {
          return "(Error)";
       }
     }  
}
```

(2023.11.17)

### 5.3.3 Others

> ### ADO.NET的进化: Entity Framework
>
> 随着网络应用程序的进化，ADO.NET也随之做了许多的改变，但不变的是，ADO.NET的基础提供了强固的发展支持，这些进化的技术都是植基于ADO.NET的核心组件而来。
>
> 长久以来，程序员和数据库总是保持着一种微妙的关系，在商用应用程序中，数据库一定是不可或缺的组件，这让程序员一定要为了连接与访问数据库而去学习SQL指令，因此在信息业中有很多人都在研究如何将程序设计模型和数据库集成在一起，对象关系对应（Object-Relational Mapping）的技术就是由此而生，为此微软在.NET Framework 2.0发展时期，就提出了一个ObjectSpace的概念，ObjectSpace可以让应用程序可以用完全对象化的方法连接与访问数据库，微软将ObjectSpace纳入.NET Framework中，并且再加上一个设计的工具（Designer），构成了现在的ADO.NET Entity Framework。
>
> Entity Framework利用了抽象化数据结构的方式，将每个数据库对象都转换成应用程序对象（entity），而数据字段都转换为属性（property），关系则转换为结合属性（association），让数据库的E/R模型完全的转成对象模型，如此让程序员能用最熟悉的编程语言来调用访问。而在抽象化的结构之下，则是高度集成与对应结构的概念层、对应层和存储层，以及支持Entity Framework的数据提供者（provider），让数据访问的工作得以顺利与完整的进行。

=>Entity Framework：基于ADO.NET的ORM框架，实现特定实体类与数据库中的Tables之间的相互转化。

(2023.5.12)



## 5.4 多线程编程

微软强烈推荐使用Task，而不是Thread。

下例GUI中用WPF创建五个按钮，测试下列代码：

视频： [ClickHere](https://www.bilibili.com/video/BV16G4y1c72R/?spm_id_from=333.337.search-card.all.click&vd_source=6fc477a8e79179a3fd30bed2e2ba5fbe)

```C#
public partial class WindowForThread : Window
{
    public WindowForThread()
    {
        InitializeComponent();
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
        //在此 6 秒期间，窗体无法被移动
        Thread.Sleep(3000);
        MessageBox.Show("素菜做好了", "友情提示");
        Thread.Sleep(3000);
        MessageBox.Show("荤菜做好了", "友情提示");
    }

    private void Button_Click_1(object sender, RoutedEventArgs e)
    {
        //因为开辟了线程 "做菜"，在此 6 秒期间，外层窗体可以被移动
        //Thread是.Net最早的多线程处理方式，它出现在.Net Framework1.0时代，现在已逐渐被微软所抛弃，微软强烈推荐使用Task
        //.NET Framework2.0时代，出现了一个线程池ThreadPool，是一种池化思想，如果需要使用线程，就可以直接到线程池中去获取直接使用，如果使用完毕，在自动的回放到线程池去；
        Thread t = new Thread(() =>
        {
            Thread.Sleep(3000);
            MessageBox.Show("素菜做好了", "友情提示");
            Thread.Sleep(3000);
            MessageBox.Show("荤菜做好了", "友情提示");
        });
        t.Start();

    }

    private void Button_Click_2(object sender, RoutedEventArgs e)
    {
        //Task出现之前，微软的多线程处理方式有：Thread→ThreadPool→委托的异步调用，虽然也可以基本业务需要的多线程场景，
        //但它们在多个线程的等待处理方面、资源占用方面、线程延续和阻塞方面、线程的取消方面等都显得比较笨拙，在面对复杂的业务场景下，显得有点捉襟见肘了。正是在这种背景下，Task应运而生。
        //Task是微软在.Net 4.0时代推出来的，也是微软极力推荐的一种多线程的处理方式，
        //Task看起来像一个Thread，实际上，它是在ThreadPool的基础上进行的封装，Task的控制和扩展性很强，在线程的延续、阻塞、取消、超时等方面远胜于Thread和ThreadPool
        //所以，Task底层也是用Thread来实现的
        Task.Run(() => 
        {   
            Thread.Sleep(3000); 
            MessageBox.Show("素菜做好了", "友情提示"); 
            Thread.Sleep(3000); 
            MessageBox.Show("荤菜做好了", "友情提示");
        });

    }

    private void Button_Click_3(object sender, RoutedEventArgs e)
    {
        //同时起多个任务，并等多个任务并行结束之后，再向下运行
        List<Task> tasks = new List<Task>();
        tasks.Add(Task.Run(() =>
        {
            Thread.Sleep(3000);
            MessageBox.Show("素菜做好了", "友情提示");
        }));

        tasks.Add(Task.Run(() =>
        {
            Thread.Sleep(3000);
            MessageBox.Show("荤菜做好了", "友情提示");
        }));


        Task.WhenAll(tasks).ContinueWith(t =>
        {
            MessageBox.Show("菜都做好了，大家快来吃饭");
        });
    }


    //async/await是什么: C#5 (.NET4.5) 引入的语法糖
    //async/await好处: 既要有顺序，又要不阻塞，降低了编程难度 => 以同步编程的方式来写异步
    //async/await优势场景:计算机的计算任务可以分成两类，计算密集型任务和IO密集型任务,async/await和Task相比，降低了线程使用数量，性能相当，不能提高计算速度，
    //优势就是在同等硬件基础上系统的吞吐率更高，对计算密集型任务没有优势，IO密集型计算有优势
    //常见的IO密集型任务有：（1）Web请求，Api请求; （2）文件读写; （3）数据库请求; （4）跟第三方交互的（非托管资源）
    //async是用来修饰方法，如果单独出现，方法会警告，不会报错
    private async void Button_Click_4(object sender, RoutedEventArgs e)
    {
        //await在方法体内部，只能放在async修饰的方法内，必须放在task前面
        //主线程到await这里就返回了，执行主线程任务
        //task中的任务执行完毕以后，继续执行await后面的后续内容，有可能是子线程，也有可能是其他线程，甚至有可能是主线程来执
        //此处虽会等Task运行完才向下执行，然而等待时间里窗体可以被移动
        await Task.Run(() =>
        {
            Thread.Sleep(3000);
            MessageBox.Show("素菜做好了", "友情提示");
            Thread.Sleep(3000);
            MessageBox.Show("荤菜做好了", "友情提示");
        });

        MessageBox.Show("菜都做好了，大家快来吃饭");
    }
}
```

自动化工具项目中偶尔也会用到

```c#
var dtTask = Task.Run(() =>
{
    if (Model.Copytemplate(ApplyTemplateList.ToList<string>()))
    {
        ret = Model.CreateDT(radioname, specpath);
    }
}
```

(2023.8.17)

# 6 GUI Development

## 6.1 History

WPF是随着Windows Vista推出的UI框架，也有近二十年历史了。

总结来说，微软桌面软件开发的发展历史如下：

MFC => WinForm => WPF => UWP => WinUI3.

### 6.1.1 MFC

> MFC（Microsoft Foundation Classes, Microsoft基本类）是一组预定义的类，封装了Windows API，对Windows编程来说是一种面向对象的方法。
>
> windows底层 API 是由C语言写的，而MFC则是在此基础上通过C++进行了封装。
>
> 无论是UI库还是用户程序，要实现某功能最终都是要依赖于操作系统API的。关键点在于，操作系统需要提供多少数量的API函数函数，才足以构建一个图形界面程序。答案是：很少, 大概几十个。

Windows SDK 最早是1985年的产物，而MFC只是面对它用C++语言做了面向对象包装。

MFC与QT一样是传统电脑桌面C/S程序基于C++的UI框架，主要区别在于QT可以跨平台。

总结来说MFC虽然出得很早，但现在还有市场。因为它是基于C++而不是C#，竞争对手是QT。在微软内部自C#出来后当然是被替代的方案，然而某种程度上跟基于C#的WinForms -> WPF -> UWP -> WinUI3这些是不同的赛道。

但是即便在国内，MFC也快被淘汰了，大家宁可用QT。即被市场淘汰，也被微软自己淘汰。

### 6.1.2 Windows Forms

> WinForm是.Net开发平台中对Windows Forms的简称。.Net 为开发WinForm的应用程序提供了丰富的Class Library（类库）。这些WinFrom 类库支持RAD(快速应用程序开发)，这些类库被封装在一个名称空间之中，这个名称空间就是**System.Windows.Forms**。在此名称空间中定义了许多类，在开发基于.Net的GUI应用程序的时候，就是通过继承和扩展这些类才使得我们的程序有着多样的用户界面。

WinForms相比MFC那样直接去包裹WIN32 API来说的话，WinForms被更好地集成于.NET框架中。相当于基于C++语言的MFC移植到.NET框架里的C#版本。所以.NET什么时候被推出来，WinForms也差不多同个时间。

MFC是直接对接操作系统，所以并不属于.NET框架。

> Winform本质上就是在MFC上增加一层.Net API, 从06年开始就只有几个人在维护，基本上不增加任何新feature, 只是做bug fix.



=>就实操而言，WinForm中一个窗体就是一个cs文件，然后在Main函数中进行调用。设计时可以直接拖动ToolBox中的控件至窗体中进行界面布置，这个设计窗口像某个编译器直接将cs文件形象化展示了。可以看到WinForm中最主要的就是两块：窗体和控件。

窗体：Form窗体（最基本），MDI窗体（可叠加多个窗体），继承窗体（就是复用窗体类）

文本控件：Label控件（文本内容不可修改），Button控件，TextBox控件（即文本框控件，用于获取用户输入的数据）...

选择类控件：ComboBox控件（下拉组合框中显示数据），CheckBox控件（复选框控件），RadioButton控件（单选按钮控件，为用户提供多个互斥选项组成的选项集），ListBox控件...

分组类控件：Panel控件（容器控件），TabControl控件（选项卡控件，可以把窗体设计成多页）...

其他高级控件：MenuStrip控件（菜单栏），ListView控件...

=>如果单纯看入门资料的话，的确WinForm中的后台逻辑全在窗体或控件cs文件中，耦合度极高...

DataGridView控件: 能够像Excel那样将数据库(通过DataSet)中的数据以表的形式显示。

(2023.5.10)

### 6.1.3 WPF

> WPF（Windows Presentation Foundation）翻译为中文“Windows呈现基础” 是微软新发布的Vista操作系统的三个核心开发库之一，是微软推出的基于Windows Vista的用户界面框架，属于.NET Framework 3.0的一部分。它提供了统一的编程模型、语言和框架，真正做到了分离界面设计人员与开发人员的工作；同时它提供了全新的多媒体交互用户图形界面。

相较于WinForm简单对win API用托管代码再包装，WPF底层使用的接口DirectX就很高级了，是微软用于游戏开发的底层多媒体编程接口。从技术的角度，WPF比WinForm先进是不容置疑的。

=>相较于WPF使用DirectX，Winform和MFC中使用的还是相对老旧的GDI(Graphics Device Interface). 现代的游戏通常使用DirectX和OpenGL而不是GDI，因为这些技术能更好的让程序员利用硬件的特性来加速图形图像的显示。

此外，相较于WinFrom视图与业务逻辑的高耦合，WPF最为重要的在于其开创了MVVM的设计思想：

> MVVM是Model-View-ViewModel的简写。它本质上就是MVC （Model-View- Controller）的改进版。即模型-视图-视图模型。分别定义如下：
>
> 1. 【模型】指的是后端传递的数据。
> 2. 【视图】指的是所看到的页面。
> 3. 【视图模型】MVVM模式的核心，它是连接View和Model的桥梁。它有两个方向：
>    一是将【模型】转化成【视图】，即将后端传递的数据转化成所看到的页面。实现的方式是：数据绑定。
>    二是将【视图】转化成【模型】，即将所看到的页面转化成后端的数据。实现的方式是：DOM 事件监听。这两个方向都实现的，我们称之为数据的双向绑定。

以一个基于WPF Prism的项目举例：

1. 在主函数中(App.cs)用IOC容器工厂(Unity)绑定对应的View和ViewModel，并顺次实例化它们；
2. View模块下主要是对于XAML文件的编辑来展示UI布局，简单的事件类型方法：如Check Button；
3. ViewModel模块中需要实例化Model，然后将Check Button的Check事件与对应的Model方法绑定。起一个桥梁的作用；=>其实应该在ViewModel中用Command代替事件来减少耦合
4. Model模块中可以调用方法去实例化UI逻辑之外的接口，如数据转化类等；
5. 至此，一个WPF Prism的界面已经完成，UI界面逻辑与后台处理逻辑完全解耦。

> PrismPrism是一个用于在 WPF、Xamarin Form、Uno 平台和 WinUI 中构建松散耦合、可维护和可测试的 XAML 应用程序框架。

> XAML语言：是微软公司为构建应用程序用户界面而创建的一种新的“可扩展应用程序标记语言”，提供了一种便于扩展和定位的语法来定义和程序逻辑分离的用户界面。

Q&A：

初始化的时候，主窗口与其上的子窗口是如何联系在一起的？=>XAML文件，主窗口调用UserControl，或者直接使用Prism中的Navigation功能；

view与viewmodel确实有绑定行为，view初始化的时候暗含了一个viewmodel的对象创建过程，这些均在WPF框架里自动产生吗？=>依托于Prism的的ViewModelLocator功能实现view与viewmodel的自动绑定功能，有文件夹位置与命名的前提条件。(2023.7.18)

### 6.1.4 UWP

> UWP，全名Universal Windows Platform，翻译成中文为windows通用应用平台，跟framework相似，但有所不同的是uwp上开发的软件可以在所有装了win10的系统上运行，也就是说不管你是win10的电脑还是win10 的pad还是win10的手机，只要是UWP的软件都可在上面运行。uwp是微软为win10定制的趋势，是想让不管是开发者，还是使用者，都省事的平台，一款UWP应用针对各平台的代码大部分都是通用的（一个项目），只有很小一部分是平台特定的。在发布到应用商店时需要针对不同平台（处理器）分别编译。微软在宣传UWP时经常声称“编写一次，在各平台发布”，但这里的“在各平台发布”仅限win10平台，而且须硬件支持。

### 6.1.5 WinUI3

> Windows App SDK (WinUI 3) 
>
> Project Reunion作为面向次世代Windows App Development的统一工具集。在2021年11月，第三个稳定版正式以1.0的版本号发布的同时，改名部果断出手，以全新的名称Windows App SDK迎接2022年以及Windows 11。
>
> 在某软推荐UWP开发者迁移到Windows App SDK之后，曾有一波“放弃”UWP的新闻。其实在经历了WPF，Silverlight，UWP这些长得挺像（XAML）的UI框架后，开发者升级到Windows App SDK和WinUI 3并不是一件很困难的事情。毕竟这凑齐了XAML的四样写法，写代码的事，能叫放弃么？空气中顿时充满了快活的味道……
>
> 下面谈谈Windows App SDK中绕不开的WinUI 3，WinUI 3作为Windows App SDK中最为核心和关键的部分，即下一代Windows desktop app开发的原生UI框架，包括托管C#和非托管的C++以及Win32 API。可以理解为某软对过去二十年desktop开发技术的反思和集大成者。

### Appendix

Web Forms

> ASP.NET 是一个免费的 Web 框架，用于使用 HTML、CSS 和 JavaScript 构建出色的网站和 Web 应用程序。 还可以创建 Web API 并使用 Web 套接字等实时技术。

## 6.2 WPF

### 6.2.1 XAML

=> 读作zaml

```xaml
<Window x:Class="PlayWithPrism.Views.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:ui="http://schemas.modernwpf.com/2019"
        ui:WindowHelper.UseModernWindowStyle="True"
        xmlns:prism="http://prismlibrary.com/"
        prism:ViewModelLocator.AutoWireViewModel="True"
        Title="{Binding Title}" Height="650" Width="550" >
    <Grid>
        <StackPanel>
            <TextBlock Text="Select your Action"/>
            <StackPanel Orientation="Horizontal">
                <Button x:Name="ShogenCheckButton" Content="Shogen Important to DB" Command="{Binding ShogenCheckCommand}" />
                <Button x:Name="StCreaterButton" Content="DT Creater" Command="{Binding DTCreaterCommand}" />
            </StackPanel>
            <ContentControl prism:RegionManager.RegionName="ContentRegion" />
        </StackPanel>
    </Grid>
</Window>
```

XAML自XML派生而来，由标签声明元素，为标签赋值Attribute的方式有两种：

1. 非空标签：`<Tag Attribute=Value>Content</Tag>`;
2. 空标签：`<Tag Attribute=Value/>`;

一个标签所代表的元素即可以作为对象，也可以作为对象的属性。那么如何为标签所代表的对象声明属性呢：

1. 利用Attribute=Value形式：`<TextBlock Text="Select your Action"/>`；

2. 利用非空标签Content中的子级标签(属性元素)为父级标签(对象元素)赋值属性：

   ```
   <Rectangle x:Name="abc">
   	<Rectangle.Fill>Blue<Rectangle.Fill/>
   </Rectangle>	
   ```

   =>属性元素与对象元素的主要区别就是看看有没有逗号.

利用Attribute=Value形式为对象赋值属性时，可以采用标记扩展(Markup Extensions):

```xaml
<Button x:Name="ShogenCheckButton" Content="Shogen Important to DB" Command="{Binding ShogenCheckCommand}" />
```

即Value是由花括号括起来的，如：`Command="{Binding ShogenCheckCommand}`. 可以为作为的对象赋值Class类型的属性。

值得注意的是，Attribute=Value形式不仅可以为对象赋值属性，亦可以为对象声明内部方法，如`<Button x:Name="button" Click="button_Click"/>`.



XAML中引用名称空间的语法：

```xaml
xmlns:i="clr-namespace:System.Windows.Interactivity;assembly=System.Windows.Interactivity">
//xlmns继承自XML语言，可以定义名称空间
//i是映射名
//clr-namespace:System.Windows.Interactivity为类库中的名称空间的名字
//assembly=System.Windows.Interactivity是类库文件名
```

像`xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"`表示WPF相关的名称空间，作为默认命名空间，其可以不指定映射名。`xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"`表示xaml编译器相关工具的名称空间。=>注意它们两个虽然长得像URL，但其实是能够被XAML解析器解析的硬性编码而已，XAML解析器见到这些固定字符串，就会把相应的程序集引入。

xaml编译器相关工具的名称空间的映射名为x，其常用的工具有以下几种：

| 名称    | 在XAML中出现的形式 |
| ------- | ------------------ |
| x:Class | Attribute          |
| x:Key   | Attribute          |
| x:Name  | Attribute          |
| x:Null  | 标签扩展           |
| ...     | ...                |

(2023.7.24)

### 6.2.2 Controls and UI Layout

控件的派生图：

```
                          ...
                           |
                    DependencyObject=>依赖对象，作为绑定的Target
                    	   |
                        Visual
                           |
                       UIElement=>有许多路由事件相关的方法，例如事件响应者的AddHandler
           ----------------|-------------------从这里才开始进入WPF开发框架，以上还是通用的.NET Framework
                    FrameworkElement
              _____________|_____________             
              |       |         |        |
           Panel   Control   TextBlock  Image
              ________|_________________  
              |           |             |
          ContentControl  ItemsControl  TextBox
              |           |
 HeaderedContentControl   HeaderedItemsControl      
```



控件种类：

| 种类                   | 注释                    | 例子                                                         |
| ---------------------- | ----------------------- | ------------------------------------------------------------ |
| ContentControl         | 单一内容控件            | Button，CheckBox，Label，RadioButton，ScrollViewer，UserControl... |
| HeaderedContentControl | 带标题的单一内容控件    | GroupBox...                                                  |
| ItemsControl           | 以条目集合为内容的控件  | ComboBox，ListBox...                                         |
| HeaderedItemsControl   | 带标题的ItemsControl    |                                                              |
| Decorator              | 装饰其他元素            | Border...                                                    |
| TextBlock与TextBox     |                         | TextBlock，TextBox                                           |
| Shape                  | 用于图形绘制            |                                                              |
| Panel                  | 控制UI布局，WPF核心功能 | Grid，StackPanel，DockPanel...                               |



UI布局，主要以下五种：

| 布局元素   |                                      |
| ---------- | ------------------------------------ |
| Grid       | 如果要随窗体自动伸缩控件位置，选Grid |
| StackPanel | 垒积木，最简单方便的布局             |
| DockPanel  | 船舶靠岸，上下左右                   |
| Canvas     | 绝对坐标布局...不好用吧              |
| WrapPanel  | 没用过...                            |

### 6.2.3 高级特性

#### 6.2.3.1 Binding

Data Binding是WPF“数据驱动UI”理念的基础。=>即便是去绑定命令，同样可以理解为代表命令的数据段驱动了绑定它的UI，而不是事件驱动。

> Binding是架在展示层与逻辑层中间的桥梁。一般情况下，Binding源是逻辑层的对象，Binding目标是UI层的控件对象，这样，数据就会源源不断通过Binding送达UI层，被UI展现，也就完成了数据驱动UI的过程。

Binding的目标端可以参见依赖属性一章的说明，主要谈谈Binding源，以MVVM框架中常见的`BindableBase`为例：

```C#
//Prism中架构MVVM框架时，代表逻辑层的ViewModels中的类默认就继承BindableBase，天然作为Binding源
//当为Binding设置了数据源后，Binding就会自动侦听来自这个接口的PropertyChanged事件。
namespace Prism.Mvvm
{
    //如果一个类要作为Binding源，需要让类实现INotifyPropertyChanged接口
    public abstract class BindableBase : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        //需要让类中相应的属性的set语句中激发PropertyChanged事件，可使用SetProperty方法
        protected virtual bool SetProperty<T>(ref T storage, T value, [CallerMemberName] string propertyName = null)
        {
            if (EqualityComparer<T>.Default.Equals(storage, value)) return false;

            storage = value;
            RaisePropertyChanged(propertyName);

            return true;
        }

        protected virtual bool SetProperty<T>(ref T storage, T value, Action onChanged, [CallerMemberName] string propertyName = null)
        {
            if (EqualityComparer<T>.Default.Equals(storage, value)) return false;

            storage = value;
            onChanged?.Invoke();
            RaisePropertyChanged(propertyName);

            return true;
        }


        protected void RaisePropertyChanged([CallerMemberName] string propertyName = null)
        {
            OnPropertyChanged(new PropertyChangedEventArgs(propertyName));
        }


        protected virtual void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            PropertyChanged?.Invoke(this, args);
        }
    }
}
//从BindableBase的例子可以看出，数据源只是定义了一个CLR事件，并用Invoke激发。一旦数据源实现了INotifyPropertyChanged接口，则Binding就会捕获这个CLR事件并激发SourceUpdated路由事件被UI元素捕获
```



相比较Binding在C#代码中略微复杂的实现，如：

```C#
//定义Binding，并设置数据源的Source与Path
Binding binding = new Binding("SelectedItem.Id") { Source=this.listBoxStudents};//参数SelectedItem.Id不是任意的
//连接Binding目标端的依赖属性
this.textBoxId.SetBinding(TextBox.TextProperty, binding);
```

利用Prism框架，在XAML中利用标记扩展语法无疑更为简洁：

```xaml
<TextBox x:Name="FolderPathTextBox" Text="{Binding Path, Mode=TwoWay}" Width="250" Margin="10"/>
<Button x:Name="CheckLTEButton" Content="CheckLTE" Command="{Binding CommandCheck}" Margin="10" HorizontalAlignment="Left">
       <Button.CommandParameter>Check_LTE</Button.CommandParameter>
</Button>
```

=>为什么上例可以这么简洁？Binding目标端理所当然为TextBox的Text属性，而数据源则依靠Prism的ViewModelLocator功能去ViewModels命名空间下寻找与该xaml类名+ViewModel的类作为Source，其中的Path属性作为Path.



可以作为Binding数据源(Source)的对象很多：

1. 实现了`INotifyPropertyChanged`接口的类，如`BindableBase`；

2. 一般集合类型，如`List<T>, ObservableCollection<T>`等；=>在使用集合类型作为ItemsControl类控件的ItemSource时，一般使`用ObservableCollection<T>`代替`List<T>`，因为前者实现了`INotifyCollectionChanged`和`INotifyPropertyChanged`接口，能把集合的变化立刻通知显示它的列表控件，改变会立即显示出来。

3. 把容器的`DataContext`指定为Source(WPF的默认行为)；=>如果看到

   ```xaml
   <ListView x:Name="listViewStudents" Margin="15" Width="669">
       <ListView.View>
           <GridView>
               <GridViewColumn Header="Id" Width="60" DisplayMemberBinding="{Binding Id}" />
               <GridViewColumn Header="Name" Width="60" DisplayMemberBinding="{Binding Name}" />
           </GridView>
       </ListView.View>
   </ListView>
   ```

   基本就使用了WPF的默认行为，Binding会自动向UI元素树上层去寻找可用的`DataContext`对象作为Source，类似于继承机制，因为`DataContext`是个依赖属性，如果当前控件没有对其显性赋值，它就会借用上层容器的`DataContext`值。上例中就可以一直寻找到最外层Window中的该Path. 甚至如果Source本身就是Source的情况下，Path都可以省略，最终简化为`"{Binding}"`.

4. 把常作为Binding目标端的依赖对象指定为Source，依赖属性作为Path，可以形成Binding链；

5. 另外甚至还可以将ADO.NET中的DataTable等，XML数据，LINQ结果(对于ItemsControl类控件)等作为Source。=>只是个人觉得一般在后台操作这些数据，与表现层有隔层，不太实用吧...

   ```xaml
   <Window x:Class="PlayWtihWPF.WindowForDataTable"
           xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
           xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
           xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
           xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
           xmlns:local="clr-namespace:PlayWtihWPF"
           mc:Ignorable="d"
           Title="WindowForDataTable" Height="450" Width="800">
       <Grid>
           <DataGrid x:Name="dataGrid" ItemsSource="{Binding}" />
       </Grid>
   </Window>
   ```

   ```C#
   namespace PlayWtihWPF
   {
       public partial class WindowForDataTable : Window
       {
           public WindowForDataTable()
           {
               InitializeComponent();
               var table = ClassForDataTable.ClassMain();
               this.DataContext = table;
           }
       }
   }
   
   namespace PlayWtihWPF
   {
       internal class ClassForDataTable
       {
           public static DataTable ClassMain()
           {
               DataSet dataSet = new DataSet();
               DataTable table = new DataTable("Table");
               // カラム名の追加
               table.Columns.Add("教科");
               table.Columns.Add("点数", Type.GetType("System.Int32"));
               // DataSetにDataTableを追加
               dataSet.Tables.Add(table);
               table.Rows.Add("数学", 80);
               table.Rows.Add("英語", 70);
               table.Rows.Add("国語", 60);
               return table;
           }
       }
   }
   
   ```

(2023.8.3)

#### 6.2.3.2 Dependency Property

什么样的对象能够成为Binding的目标端(Target)? 

=> 拥有依赖属性(`DependencyProperty`)的依赖对象(`DependencyObject`).`DependencyObject`是WPF系统中相当底层的一个类，WPF所有的UI控件都是依赖对象，其类库在设计时充分利用了依赖属性的优势，大多数控件的属性均是依赖属性。

依赖属性的优点？

如果把一般的属性(3.3属性)称为CLR属性，其通常是包装一个字段。但如果使用依赖属性，则可以省去很多内存开销。省内存主要在于依赖属性的深层机制，即其只有在使用时才会被实例化，注册在一个全局的Hash table中。进一步其属性值还可以通过Binding依赖在其他对象上。即依赖对象借助依赖属性拥有实时分配内存或借用其他对象数据的能力。但值得注意的是，通常来说依赖属性仍需加一层CLR属性作为包装器以便于使用，所以依赖属性对标的其实是字段而不是属性。



**附加属性(Attached Property)**

举例而言位于Grid中的控件会额外拥有`Grid.Column`与`Grid.Row`属性来调整位于Grid的哪个区域，此即为附加属性。其作用就是将属性与数据类型(宿主)解耦，让数据类型的设计更加灵活。

附加属性本质上就是依赖属性，二者仅在注册和包装器上有一点区别。

下例为stackoverflow上一个用于TextBox随着内容输出自动下拉到末尾的自定义附加属性：

```c#
public class TextBoxBehaviour
{
    static readonly Dictionary<TextBox, Capture> _associations = new Dictionary<TextBox, Capture>();

    //附加属性的包装器与依赖属性不同:
    //1.依赖属性使用CLR属性对GetValue和SetValue两个方法进行包装；
    //2.附加属性则使用两个方法分别进行包装=>单纯为了保持语句行文上的通畅
    public static bool GetScrollOnTextChanged(DependencyObject dependencyObject)
    {
        //可以看到宿主类无需一定要继承自DependencyObject,此处可以改用类方法
        return (bool)dependencyObject.GetValue(ScrollOnTextChangedProperty);
    }

    public static void SetScrollOnTextChanged(DependencyObject dependencyObject, bool value)
    {
        dependencyObject.SetValue(ScrollOnTextChangedProperty, value);
    }


    //附加属性(依赖属性也一样)实例的声明特点很鲜明：
    //1.引用变量由public static readonly三个修饰符修饰；
    //2.实例并非使用new操作符而是使用DependencyProperty.RegisterAttached方法生成（依赖属性虽使用Register，但参数一样）
    //第一个参数：指明哪个CLR属性作为这个依赖属性的包装器。因为附加属性不定义CLR属性，这里其实可以是任意字符
    //第二个参数：指明此依赖属性存储的值的类型
    //第三个参数：指明依赖属性宿主的类型
    //第四个参数：可省略，给依赖属性的默认信息赋值，最为重要的即是Callback函数，依赖属性宿主值被改变时此函数会被调用
    public static readonly DependencyProperty ScrollOnTextChangedProperty =
        DependencyProperty.RegisterAttached("ScrollOnTextChanged", typeof(bool), typeof(TextBoxBehaviour), new UIPropertyMetadata(false, OnScrollOnTextChanged));

    static void OnScrollOnTextChanged(DependencyObject dependencyObject, DependencyPropertyChangedEventArgs e)
    {
        var textBox = dependencyObject as TextBox;
        if (textBox == null)
        {
            return;
        }
        bool oldValue = (bool)e.OldValue, newValue = (bool)e.NewValue;
        if (newValue == oldValue)
        {
            return;
        }
        if (newValue)
        {
            textBox.Loaded += TextBoxLoaded;
            textBox.Unloaded += TextBoxUnloaded;
        }
        else
        {
            textBox.Loaded -= TextBoxLoaded;
            textBox.Unloaded -= TextBoxUnloaded;
            if (_associations.ContainsKey(textBox))
            {
                _associations[textBox].Dispose();
            }
        }
    }

    static void TextBoxUnloaded(object sender, RoutedEventArgs routedEventArgs)
    {
        var textBox = (TextBox)sender;
        _associations[textBox].Dispose();
        textBox.Unloaded -= TextBoxUnloaded;
    }

    static void TextBoxLoaded(object sender, RoutedEventArgs routedEventArgs)
    {
        var textBox = (TextBox)sender;
        //Loaded为路由事件
        textBox.Loaded -= TextBoxLoaded;
        _associations[textBox] = new Capture(textBox);
    }

    //当我们自定义的类中引用某些非CLR托管资源，就需要实现IDisposable接口，实现对这些资源对象的垃圾回收。
    class Capture : IDisposable
    {
        private TextBox TextBox { get; set; }

        public Capture(TextBox textBox)
        {
            TextBox = textBox;
            //TextChanged为基于委托的一般事件（可看成能够被Text变化事件触发的函数指针）
            TextBox.TextChanged += OnTextBoxOnTextChanged;
        }

        private void OnTextBoxOnTextChanged(object sender, TextChangedEventArgs args)
        {
            //TextBox随着内容输出，自动下滑到最后一行功能实现的最关键逻辑
            TextBox.ScrollToEnd();
        }

        public void Dispose()
        {
            TextBox.TextChanged -= OnTextBoxOnTextChanged;
        }
    }

}
```

将此类添加于xaml文件同一namespace，然后在xaml作如下引用：

```xaml
<TextBox  Height="200" 
          Margin="5" 
          Text="{Binding Log}" 
          local:TextBoxBehaviour.ScrollOnTextChanged="True" 
          VerticalScrollBarVisibility="Auto"/>
```

(2023.7.30)

#### 6.2.3.3 Routed Event

像C#的属性系统（CLR属性）在WPF中进化为依赖属性，事件系统（CLR事件）在WPF中也升级为路由事件。

顾名思义，路由事件就是可以像路由那样在WPF逻辑树上沿着一定的方向传递且路过多个中转节点。

> 相对于CLR事件，路由事件的事件拥有者和事件响应者之间则没有直接显式的订阅关系，事件的拥有者只负责激发事件，事件将有谁响应它不知道，事件的响应者则安装有事件侦听器，针对某类事件进行侦听，当有此类事件传递至此时事件响应者就使用事件处理器来响应事件并决定事件是否可以继续传递。
>
> WPF系统中的大多数事件都是可路由事件。像ButtonBase中就有声明并注册路由事件，而且通常来说会为路由事件添加CLR事件包装器，让程序员不会感觉到与一般事件的区别，仍可以使用+-符号操作事件。激发路由很简单，调用元素的RaiseEvent方法(继承自UIElement类)把事件消息发出去。(注意，这与一般事件的Invoke方法激发不同，即路由事件的激发与其CLR包装器无关。)另一方面，所有UI元素均可作为事件响应者，用AddHandler方法(同样源于UIElement类)把想监听的事件与事件处理其关联起来。

```C#
//下例是 通过按下按钮，将后台属性数据值反映到文本框的部分代码
//注意以上过程其实有两个事件组成：1.Button点击事件；2.文本框显示文字事件。
internal class Student : INotifyPropertyChanged
{
    //2.文本框显示文字事件
    //事件的简略声明即可， 而不是：1.先定义委托规范事件的形参格式 2.在类中实例化这个委托 3.用包装器使这个实例成为事件
    //这个声明就可以看成:②事件成员，类中再补一个触发逻辑，可以是方法，也可以是属性中的set.
    //所以对于这个文本框显示文字事件而言，Student类即为:①事件的拥有者
    public event PropertyChangedEventHandler PropertyChanged;

    private string name;

    public string Name
    {
        get { return name; }
        set 
        { 
            name = value; 
            //触发事件的逻辑：
            if (PropertyChanged != null)
            {
                this.PropertyChanged.Invoke(this, new PropertyChangedEventArgs("Name"));
            }
        }
    }

}


public partial class Window3 : Window
{
    Student stu;
    public Window3()
    {
        InitializeComponent();

        stu = new Student();

        Binding binding = new Binding();
        binding.Source = stu;
        binding.Path = new PropertyPath("Name");

        //需要业务逻辑类的对象能发出路由事件怎么办？
        //在数据驱动UI架构中，业务逻辑会使用Binding对象与UI元素关联
        //一旦业务逻辑对象实现了INotifyPropertyChanged接口，则Binding就会激发SourceUpdated路由事件被UI元素捕获
        BindingOperations.SetBinding(this.textBoxName,TextBox.TextProperty, binding);
        //2.文本框显示文字事件
        //③事件的响应者=>毫无疑问就是作为绑定目标textBox，它是一个拥有依赖属性TextProperty的依赖对象
        //④事件处理器=>将绑定源和绑定path的值（经过转化器）反映到依赖属性TextProperty应该是UI元素借助Binding实现的...
        //⑤事件订阅=>路由事件
    }

    //1.Button点击事件
    //Windows3即是xaml最外层的窗体，它是:③事件的响应者，而Button_Click则是:④事件处理器
    //因为Button控件的父类ButtonBase中实现了路由事件定义，此即为：②事件成员
    //xaml中的Button控件无疑是：①事件的拥有者，其Click属性肯定是关联了RaiseEvent(arg)触发了事件
    //而路由事件无需：⑤事件订阅。可以像路由一样被WPF沿着Visual Tree自动外传直到被某个节点如根节点Window3捕获
    private void Button_Click(object sender, RoutedEventArgs e)
    {
        stu.Name += "WangShuhua";
    }
}
//综合上述，以上两个事件本质上均是基于路由事件，尽管2.文本框显示文字事件最原始是定义了CLR事件，但最终会转化为Binding的路由事件
```

(2023.8.2)

#### 6.2.3.4 Command

```C#
//下例是TextBox输入内容后，Button命令可用，点击发送后，作用域TextBox上删除其内容的例子：
namespace PlayWtihWPF
{
    public partial class Window8 : Window
    {
        public Window8()
        {
            InitializeComponent();
            InitializeCommand();
        }

        //WPF的命令系统由四个基本要素组成：
        //1.命令（Command）：RoutedCommand实现了ICommand接口类
        private RoutedCommand clearCmd = new RoutedCommand("Clear", typeof(Window8));

        private void InitializeCommand()
        {
            //2.命令源（Command Source）：命令发送者，如Button
            this.button1.Command = this.clearCmd;
			//3.命令目标（）：命令接收者，这里是TextBox
            this.button1.CommandTarget = this.textBox1;
			//4.命令关联（Command Binding）：负责一些外围逻辑与命令关联，如对命令是否可执行进行判断等
            CommandBinding cb = new CommandBinding();
            cb.Command = this.clearCmd;
            cb.CanExecute += new CanExecuteRoutedEventHandler(cb_CanExecuted);
            cb.Executed += new ExecutedRoutedEventHandler(cb_Executed);


            this.stackpanel.CommandBindings.Add(cb);
        }

        private void cb_CanExecuted(object sender, CanExecuteRoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(this.textBox1.Text))
            {
                e.CanExecute = false;
            }
            else
            {
                e.CanExecute = true;
            }

            e.Handled = true;
        }

        private void cb_Executed(object sender, ExecutedRoutedEventArgs e)
        {
            this.textBox1.Clear();

            e.Handled = true;
        }
    }
}
```

=>WPF原生的命令系统还是略微复杂，可以直接用Prism框架包装后的`DelegateCommand`

#### 6.2.3.5 Resource and Template

> WPF中控件拥有很多依赖属性（Dependency Property），我们可以通过编写自定义Style文件来控制控件的外观和行为，如同CSS代码一般。
> 总结一下WPF中Style样式的引用方法：
>
> **1.内联样式**
>
> 直接在控件的内部xaml代码中书写各种依赖属性，如下：
>
> ```xaml
> <Button Height="30" Width="60" Background="Green" Foreground="White"></Button>
> ```
>
> 这种方式比较直接方便，适用于单个控件、代码量较少的Style设置，代码不能重用。
>
> **2.嵌入样式**
>
> 在窗体（Window）或者页面（Page）的资源节点下面（Window.Resources或者Page.Resources）添加Style代码，这样在整个窗体或者页面范围内可以实现Style代码重用。
> 第1步，书写Style代码:
>
> ```xaml
> <Window.Resources>
>     <Style x:Key="myBtnStyle" TargetType="{x:Type Button}">
>         <Setter Property="Height" Value="72" />
>         <Setter Property="Width" Value="150" />
>         <Setter Property="Foreground" Value="Red" />
>         <Setter Property="Background" Value="Black" />
>         <Setter Property="HorizontalAlignment" Value="Left" />
>         <Setter Property="VerticalAlignment" Value="Top" />
>     </Style>
> </Window.Resources>
> ```
>
> 第2步，在Button的xaml代码中引用Style：　　
>
> ```xaml
> <Button Style="{StaticResource myBtnStyle}"></Button>
> ```
>
> **3.外联样式**：
>
> 前面说的两种方式，都无法设置整个应用程式里面的全局Style，现在我们介绍全局设置Style的方式。
> 3.1. 新建一个.xaml的资源文件，如/Theme/Style.xaml；
>
> 3.2. 在该文件中编写样式代码；
>
>  3.3. 　在App.xaml文件中的`<`Applictaion.Resources`>`节点下添加`<`ResourceDictionary`>`节点：
>
> ```xaml
> <Application.Resources> 
>     <ResourceDictionary>
>         <ResourceDictionary.MergedDictionaries>
>             <ResourceDictionary Source="/应用名称;component/Theme/Style.xaml"/>
>         </ResourceDictionary.MergedDictionaries>
>     </ResourceDictionary>
> </Application.Resources>
> ```
>
> 这种方式相比前面两种使得样式和结构又更进一步分离了。在App.xaml引用，是全局的，可以使得一个样式可以在整个应用程序中能够复用。在普通页面中引用只能在当前页面上得到复用。　

(2023.7.16)

=>根据上文第三条：全局设置Style的方式，可以利用Github上的Design theme and control library为你的界面程序整体性地穿上衣服，使程序外观焕然一新！

以MaterialDesignInXamlToolkit举例：

1. 在Nuget下载相依的库文件：`Install-Package MaterialDesignTheme`

2. 只要在既有的程序的App.xaml的ResourceDictionary中添加

   ```xaml
   <prism:PrismApplication x:Class="PlayWithPrism.App"
                xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                xmlns:local="clr-namespace:PlayWithPrism"
                xmlns:materialDesign="http://materialdesigninxaml.net/winfx/xaml/themes"           
                xmlns:prism="http://prismlibrary.com/" >
       <Application.Resources>
           <ResourceDictionary>
               <ResourceDictionary.MergedDictionaries>
                   <materialDesign:BundledTheme BaseTheme="Dark" PrimaryColor="LightBlue" SecondaryColor="DeepOrange" />
                   <ResourceDictionary Source="pack://application:,,,/MaterialDesignThemes.Wpf;component/Themes/MaterialDesignTheme.Defaults.xaml" />
               </ResourceDictionary.MergedDictionaries>
           </ResourceDictionary>
       </Application.Resources>
   </prism:PrismApplication>
   ```

   注意不要忘记添上相应的namespace：`xmlns:materialDesign="http://materialdesigninxaml.net/winfx/xaml/themes"`；

3. 然后在MainWindow.xaml的window属性栏中添加

   ```
           xmlns:materialDesign="http://materialdesigninxaml.net/winfx/xaml/themes"
           TextElement.Foreground="{DynamicResource MaterialDesignBody}"
           Background="{DynamicResource MaterialDesignPaper}"
           TextElement.FontWeight="Medium"
           TextElement.FontSize="14"
           FontFamily="{materialDesign:MaterialDesignFont}"
   ```

   这个阶段就已经整体换好Style了；

4. 如果要替换其中个别Control的默认风格，比如将TextBox中默认的无框设计替换成有框，可以在特定元素上绑定Style：

   ```xaml
   <TextBox Style="{StaticResource MaterialDesignOutlinedTextBox}" Height="200" Margin="5" Text="{Binding Log}" />
   ```

   

我们可以深入库文件中TextBox相关的xaml文件一探究竟：

```xaml
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                    xmlns:converters="clr-namespace:MaterialDesignThemes.Wpf.Converters"
                    xmlns:internal="clr-namespace:MaterialDesignThemes.Wpf.Internal"
                    xmlns:wpf="clr-namespace:MaterialDesignThemes.Wpf">
    
  <!--省略-->    
  <converters:BooleanToVisibilityConverter x:Key="BooleanToVisibilityConverter" />
  <converters:TextFieldClearButtonVisibilityConverter x:Key="ClearButtonVisibilityConverter" />
  <!--Style能够为控件自定义外观式样和行为动作--> 
  <!--构成Style最重要的两种元素是Setter和Trigger--> 
  <Style x:Key="MaterialDesignTextBoxBase" TargetType="{x:Type TextBoxBase}">
    <!--Setter类帮助设置控件的静态外观风格-->  
    <Setter Property="AllowDrop" Value="true" />
    <Setter Property="Background" Value="Transparent" />
    <Setter Property="Template">
      <Setter.Value>
        <!--ControlTemplate是最关键的类，能够将控件庖丁解牛，突破Logical Tree,进入Visual Tree将控件进行完全不同的改造--> 
        <!--另外WPF还有一个DataTemplate，对具体数据进行包装-->   
        <ControlTemplate TargetType="{x:Type TextBoxBase}">
          <Grid Cursor="{TemplateBinding Cursor, Converter={StaticResource ArrowCursorConverter}}">
            <Border HorizontalAlignment="Stretch"
                    VerticalAlignment="Stretch"
                    Background="{DynamicResource MaterialDesign.Brush.TextBox.HoverBackground}"
                    CornerRadius="{TemplateBinding wpf:TextFieldAssist.TextFieldCornerRadius}"
                    RenderTransformOrigin="0.5,0.5"
                    Visibility="{TemplateBinding wpf:TextFieldAssist.RippleOnFocusEnabled, Converter={StaticResource BooleanToVisibilityConverter}}">
              <Border.RenderTransform>
                <ScaleTransform x:Name="RippleOnFocusScaleTransform" ScaleX="0" ScaleY="0" />
              </Border.RenderTransform>
            </Border>
            <!--省略--> 
          </Grid>
          <ControlTemplate.Triggers>
            <!--Trigger类帮助设置控件的行为风格，即当某些条件满足时会触发一个行为--> 
            <!--MultiTrigger即需要满足多个条件才会触发一个行为--> 
            <MultiTrigger>
              <MultiTrigger.Conditions>
                <Condition Property="wpf:HintAssist.IsFloating" Value="True" />
                <Condition Property="IsKeyboardFocused" Value="True" />
              </MultiTrigger.Conditions>
              <Setter TargetName="Hint" Property="Foreground" Value="{Binding Path=(wpf:HintAssist.Foreground), RelativeSource={RelativeSource TemplatedParent}}" />
              <Setter TargetName="Hint" Property="HintOpacity" Value="1" />
            </MultiTrigger>
            <Trigger Property="wpf:TextFieldAssist.HasFilledTextField" Value="True">
              <Setter Property="Background" Value="{DynamicResource MaterialDesign.Brush.TextBox.FilledBackground}" />
            </Trigger>
            <!--省略-->
          </ControlTemplate.Triggers>
        </ControlTemplate>
      </Setter.Value>
    </Setter>
	<!--省略-->
  </Style>
  <!--省略-->
  <Style x:Key="MaterialDesignTextBox"
         TargetType="{x:Type TextBox}"
         BasedOn="{StaticResource MaterialDesignTextBoxBase}" />
  <Style x:Key="MaterialDesignFloatingHintTextBox"
         TargetType="{x:Type TextBox}"
         BasedOn="{StaticResource MaterialDesignTextBox}">
    <Setter Property="wpf:HintAssist.IsFloating" Value="True" />
  </Style>
  <!--这里设置了x:Key 才能被具体TextBox引用-->
  <Style x:Key="MaterialDesignFilledTextBox"
         TargetType="{x:Type TextBox}"
         BasedOn="{StaticResource MaterialDesignFloatingHintTextBox}">
    <Setter Property="Padding" Value="{x:Static wpf:Constants.FilledTextBoxDefaultPadding}" />
    <Setter Property="wpf:TextFieldAssist.HasFilledTextField" Value="True" />
    <Setter Property="wpf:TextFieldAssist.TextFieldCornerRadius" Value="4,4,0,0" />
    <Setter Property="wpf:TextFieldAssist.UnderlineCornerRadius" Value="0" />
  </Style>
</ResourceDictionary>
```

上面这个文件中ControlTemplate尽管可以用C#来创建，但绝大数情况下ControlTemplate是由XAML代码编写并放在资源词典里。作为资源，ControlTemplate可以放在三个地方：

1. Application的资源词典里；
2. 某个界面元素的资源词典里，如<Grid.Resource>...</>;
3. 放在外部XAML中，如上例；

WPF检索资源的时候，先查找控件自己的Resource属性，如果没有这个资源WPF会沿着逻辑树向上一级控件查找，如果连最顶层容器都没有这个资源，程序就回去查找Application.Resource(也就是程序的顶级资源)，如果还没找到，就只好抛出异常了。=>这也是具体控件可以设定Style来代替放在App.xaml中默认Style的原理。

当资源被存储进资源词典后，可以使用`StaticResource`和`DynamicResource`两种方式使用资源，前者只在初始化的时候使用一次，之后不再改变，后者可以在程序运行中进行改变。如：

```xaml
<TextBox Style="{StaticResource MaterialDesignOutlinedTextBox}" Height="200" Margin="5" Text="{Binding Log}" />
```

除了一般的WPF资源，WPF还可以使用二进制资源，如

```xaml
<ResourceDictionary Source="pack://application:,,,/MaterialDesignThemes.Wpf;component/Themes/MaterialDesignTheme.Defaults.xaml" />
```

上例中使用了Pack URI路径：`pack://application:,,,/【程序集名称】;【可选版本号】/【文件夹名称】/【文件名称】`访问二进制资源。

(2023.8.4)

### 6.2.4 Style Library

| Name                                                         |            |
| ------------------------------------------------------------ | ---------- |
| [MahApps.Metro](https://github.com/MahApps/MahApps.Metro)    | 开源控件库 |
| MahApps.Metro.IconPacks                                      | 图标库     |
| [MaterialDesignInXamlToolkit](https://github.com/MaterialDe.../MaterialDesignInXamlToolkit) | 开源控件库 |
| [ModernWpf](https://github.com/Kinnara/ModernWpf)            | 开源控件库 |
|                                                              |            |
|                                                              |            |
|                                                              |            |
|                                                              |            |
|                                                              |            |

### 6.2.5 其他

`CommonOpenFileDialog`：从GUI比如按钮，选择文件/文件夹的代码例：

```C#
//Please install WindowsAPICodePack-Shell in Nuget
using (var cofd = new CommonOpenFileDialog()
{
    Title = "Please Select  File",
    InitialDirectory = @"C:\",
    //设置IsFolderPicker，就只能选择文件夹，否则可以选择到具体文件
    IsFolderPicker = true,
})
{
    if (cofd.ShowDialog() != CommonFileDialogResult.Ok)
    {
        return;
    }
    System.Windows.MessageBox.Show($"{cofd.FileName} is Selected");
}
```



## 6.3 Prism

> [Introduction to Prism | Prism (prismlibrary.com)](https://prismlibrary.com/docs/index.html)

=>Prism是用于WPF中构建MVVM的程序框架。

### 6.3.1 ViewModelLocator

> The `ViewModelLocator` is used to wire the `DataContext` of a view to an instance of a ViewModel using a standard naming convention.

=>简而言之，Prism自动一对一关联Views与ViewModels文件夹下面符合一定命名约定的文件，如：Views\BeforeAfterMaker.xaml与ViewModels\BeforeAfterMakerViewModel.cs

这个功能的开关在MainWindow.xaml中：

```
        xmlns:prism="http://prismlibrary.com/"
        prism:ViewModelLocator.AutoWireViewModel="True"
```

### 6.3.2 Region Navigation

=>界面上对于某一区域的翻页功能

MainWindow.xaml中会有一行：

```
<ContentControl prism:RegionManager.RegionName="ContentRegion" />
```

建立复数个UserControl窗体后在 App.xaml.cs注册：

```C#
protected override void RegisterTypes(IContainerRegistry containerRegistry)
{
    containerRegistry.RegisterForNavigation<ShgetcAnalyzer>();
    containerRegistry.RegisterForNavigation<BeforeAfterMaker>();
}
```

然后在ViewModels\MainWindowViewModel.cs 把UserControl绑定到主窗口：

```C#
private readonly IRegionManager _regionManager;

//主窗口通过与命令相绑定的两个按钮来完成Navigation的效果
public DelegateCommand ShgetcAnalyzerCommand { get; private set; }
public DelegateCommand BeforeAfterMakerCommand { get; private set; }

public MainWindowViewModel(IRegionManager regionManager)
{
    this._regionManager = regionManager;

    ShgetcAnalyzerCommand = new DelegateCommand(ShgetcAnalyzer);
    BeforeAfterMakerCommand = new DelegateCommand(BeforeAfterMaker);
    
    //Initialize the default region view， 2024.3.14
    //Refer to https://stackoverflow.com/questions/54330435/navigate-to-a-default-view-when-application-loaded-using-prism-7-in-wpf
    regionManager.RegisterViewWithRegion("ContentRegion", "ShgetcAnalyzer");
    
}


void ShgetcAnalyzer()
{
    if (_regionManager != null)
    {
        _regionManager.RequestNavigate("ContentRegion", "ShgetcAnalyzer");
    }
}

void BeforeAfterMaker()
{
    if (_regionManager != null)
    {
        _regionManager.RequestNavigate("ContentRegion", "BeforeAfterMaker");
    }
}
```

### 6.3.3 DelegateCommand

=>`DelegateCommand`是Prism为WPF实现`ICommand`接口的类。

在Views文件夹下的XAML文件中实现`CommandReferece`等命令绑定：

```xaml
<StackPanel Orientation="Horizontal">
    <TextBox x:Name="FolderPathTextBox" Text="{Binding Path, Mode=TwoWay}" Width="250" Margin="10"/>
    <Button x:Name="ReferenceButton"  Command="{Binding CommandReferece}" Content="Reference" Margin="5"/>
    <Button x:Name="DiagnoseButton" Content="Diagnose" Command="{Binding CommandDiagnose}" Margin="5" />
    <Button x:Name="CheckButton" Content="Check" Command="{Binding CommandCheck}" Margin="10" HorizontalAlignment="Left">
           <Button.CommandParameter>Check</Button.CommandParameter>
    </Button>
</StackPanel>
```

然后在ViewModels文件夹下相对应的C#文件中实现`CommandReferece`等命令：

```c#
//Snippets:
//1.propp - Property, with a backing field, that depends on BindableBase
//2.cmd - Creates a DelegateCommand property with Execute method
//3.cmdfull - Creates a DelegateCommand property with Execute and CanExecute methods
//4.cmdg - Creates a generic DelegateCommand property
//5.cmdgfull - Creates a generic DelegateCommand property with Execute and CanExecute methods

private DelegateCommand _fieldReference;
public DelegateCommand CommandReferece =>
    _fieldReference ?? (_fieldReference = new DelegateCommand(ExecuteCommandReference));
void ExecuteCommandReference()
{
    //CommonOpenFileDialog需要从nuget安装WindowsAPICodePack-Shell包，用于弹出选择文件夹窗口
    using (var cofd = new CommonOpenFileDialog()
    {
        Title = "请选择文件夹",
        InitialDirectory = @"C:\Test\",
        IsFolderPicker = true,
    })
    {
        if (cofd.ShowDialog() != CommonFileDialogResult.Ok)
        {
            return;
        }
        this.Path = cofd.FileName;
        System.Windows.MessageBox.Show($"选择了{cofd.FileName}");
    }
}


private DelegateCommand _fieldDiagnose;
public DelegateCommand CommandDiagnose =>
    _fieldDiagnose ?? (_fieldDiagnose = new DelegateCommand(ExecuteCommandDiagnose, CanExecuteCommandDiagnose));

void ExecuteCommandDiagnose()
{
    Model.SetShogenFile(Path);
    Log = Model.Log;
}
//cmdfull相对于cmd多提供一个可以设置命令是否可以执行先决条件的方法
bool CanExecuteCommandDiagnose()
{
    if(string.IsNullOrEmpty(this.Path)) return false;
    return true;
}

//如果UI要向命令传递参数，则使用cmdg，泛型命令
private DelegateCommand<Object> _fieldCheck;
public DelegateCommand<Object> CommandCheck =>
    _fieldCheck ?? (_fieldCheck = new DelegateCommand<Object>(ExecuteCommandCheck, CanExecuteCommandCheck));

private void ExecuteCommandCheck(object obj)
{
    string type = (string)obj;
    if ("Check" == type)
    {
        //...
    }
    else
    {
		//...
    }
}
private bool CanExecuteCommandCheck(object arg)
{
    return true;
}
```



如果命令`CanExecute`函数依赖于其他属性的变化，需要在此属性里增加触发`CanExecute`函数的逻辑：

```xaml
<ComboBox Width="200" 
          ItemsSource="{Binding CheckedFolderList}" 
          SelectedValue="{Binding PropertyFile, Mode=TwoWay}" />
<Button Content="Create Strat" Command="{Binding CommandCreate}"/>
```

```C#
//
// 相对于List，ObservableCollection继承了INotifyPropertyChanged，可以实时与UI数据同步
private ObservableCollection<string> m_CheckedFolderList;
public ObservableCollection<string> CheckedFolderList
{
    get { return m_CheckedFolderList; }
    //SetProperty是继承自Bindable的方法，用于MVVM框架。其中包含RaisePropertyChanged方法，用于通知UI属性的变化
    set { SetProperty(ref m_CheckedFolderList, value); }
}


private string fieldFile;
public string PropertyFile
{
    get { return fieldFile; }
    set
    {
        SetProperty(ref fieldFile, value);
        //触发CommandCreate的CanExecute方法
        CommandCreate.RaiseCanExecuteChanged();
    }
}


private DelegateCommand _fieldCreate;
public DelegateCommand CommandCreate =>
    _fieldCreate ?? (_fieldCreate = new DelegateCommand(ExecuteCommandCreate, CanExecuteCommandCreate));

void ExecuteCommandCreate()
{
	//...
}

bool CanExecuteCommandCreate()
{
    if (String.IsNullOrEmpty(fieldFile)) return false;
    return true;
}        
```

(2023.7.30)

### 6.3.4 Dialog Service 

=>弹出小窗口功能

App.xaml.cs:

```c#
protected override void RegisterTypes(IContainerRegistry containerRegistry)
{
    containerRegistry.RegisterForNavigation<ModifyWindow>();
    containerRegistry.RegisterForNavigation<ShogenCheckWindow>();
	//与Navigation一样，需要注册一个窗体
    containerRegistry.RegisterDialog<AreaWindow>();
}
```

新建小窗口 AreaWindow.xaml

```xaml
<!--调用Style库，不同于Navigation各xaml位于同一窗口，Dialog是独立窗口，所以如果要应用式样库，需要单独引用命名空间--> 
<UserControl x:Class="ModifyTool2_0.Views.AreaWindow"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:ModifyTool2_0.Views"  
             xmlns:prism="http://prismlibrary.com/"
             xmlns:materialDesign="http://materialdesigninxaml.net/winfx/xaml/themes"
             TextElement.Foreground="{DynamicResource MaterialDesignBody}"
             Background="{DynamicResource MaterialDesignPaper}"
             TextElement.FontWeight="Medium"
             TextElement.FontSize="14"
             FontFamily="{materialDesign:MaterialDesignFont}"                                        
             mc:Ignorable="d" 
             d:DesignHeight="150" d:DesignWidth="300">
    <!--调整窗口大小，需要引用prism的WindowStyle--> 
    <prism:Dialog.WindowStyle>
        <Style TargetType="Window">
            <Setter Property="Width" Value="300"/>
            <Setter Property="Height" Value="300"/>
        </Style>
    </prism:Dialog.WindowStyle>    
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="1*"/>
            <ColumnDefinition Width="1*"/>
            <ColumnDefinition Width="1*"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="1*"/>
            <RowDefinition Height="2*"/>
            <RowDefinition Height="1*"/>
        </Grid.RowDefinitions>
        <TextBlock Grid.Column="0" Grid.Row="0" Grid.ColumnSpan="3" VerticalAlignment="Center"
            Text="Select target LTE shogen area"/>
        <ComboBox  Grid.Column="0" Grid.Row="1" Grid.ColumnSpan="3" VerticalAlignment="Top"
                  Text="{Binding TxtArea, Mode=TwoWay}" ItemsSource="{Binding AreaList}"/>
        <Button Content="OK" Grid.Column="1" Grid.Row="3"
                Command="{Binding CommandOK}"/>
    </Grid>
</UserControl>
```

建立AreaWindow的ViewModel：

```c#
//建立AreaWindow的ViewModel需要继承IDialogAware接口
class AreaWindowViewModel : BindableBase, IDialogAware
{
    #region IDialogAware interface
    public string Title { get; set; }
    public event Action<IDialogResult> RequestClose;
    public bool CanCloseDialog(){return true;}
    public void OnDialogClosed(){}
    public void OnDialogOpened(IDialogParameters parameters){}
    #endregion

    /// <summary>
    /// Property for selected Area 
    /// </summary>
    private string txtArea;
    public string TxtArea
    {
        get { return txtArea; }
        set
        {
            SetProperty(ref txtArea, value);
            _fieldOK.RaiseCanExecuteChanged();
        }
    }

    /// <summary>
    /// Property for area list
    /// </summary>
    private ObservableCollection<string> _areaList;
    public ObservableCollection<string> AreaList
    {
        get { return _areaList; }
        set { SetProperty(ref _areaList, value); }
    }


    public AreaWindowViewModel()
    {
        string[] areaList = { "NR only, unnecessary to load LTE shogen",
            "auC","auD","auEF","auH","auK","auN","auO","auQ","auS","auT"};

        _areaList = new ObservableCollection<string>(areaList);
    }


    /// <summary>
    /// Command for OK Button on AreaWindow
    /// </summary>
    private DelegateCommand _fieldOK;
    public DelegateCommand CommandOK =>
        _fieldOK ?? (_fieldOK = new DelegateCommand(ExecuteCommandOK, CanExecuteCommandOK));

    void ExecuteCommandOK()
    {
        //向母窗口回传参数
        IDialogParameters parameters = new DialogParameters();
        parameters.Add("Area", txtArea);
        RequestClose?.Invoke(new DialogResult(ButtonResult.OK, parameters));
    }

    bool CanExecuteCommandOK()
    {
        if (string.IsNullOrEmpty(txtArea))
        {
            return false;
        }

        return true;
    }
}
```

在母窗体ViewModel中调用：

```C#
//增加字段
private readonly IDialogService dialogService;
//构造函数中初始化
 public ShogenCheckWindowViewModel(IDialogService dialog) 
 {
     this.dialogService = dialog;
 }
//接收子窗口参数
 private DelegateCommand _fielddran;
 public DelegateCommand CommandDRAN_Diagnose =>
     _fielddran ?? (_fielddran = new DelegateCommand(ExecuteCommandDRAN_Diagnose, CanExecuteCommandDRAN_Diagnose));

 void ExecuteCommandDRAN_Diagnose()
 {
     IDialogParameters parameters = new DialogParameters();
     //ShowDialog与Show的区别在于，前者窗体打开时母窗口被锁定无法使用，后者可以
     dialogService.ShowDialog("AreaWindow", parameters, DialogCallback);
     //dialogService.Show("AreaWindow", parameters, DialogCallback);
 }

 bool CanExecuteCommandDRAN_Diagnose()
 {
     return true;
 }
```

(2024.3.19)

# 7 Files Operation

## 7.1 文本文件的读写

**StreamReader** 和 **StreamWriter** 类用于文本文件的数据读写。这些类从抽象基类 Stream 继承，Stream 支持文件流的字节读写。

**StreamReader** 类继承自抽象基类 TextReader，表示阅读器读取一系列字符。

```C#
        public static void TextReader(string inFilePath)
        {
            try
            {
                // 创建一个 StreamReader 的实例来读取文件 
                // using 语句能关闭 StreamReader,参见3.7
                using (StreamReader sr = new StreamReader(inFilePath, Encoding.UTF8))
                {
                    string line;
                    // 从文件读取并显示行，直到文件的末尾 
                    while ((line = sr.ReadLine()) != null)
                    {
                        Console.WriteLine(line);
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("The file could not be read:");
                Console.WriteLine(e.Message);
            }
        }
```

```C#
//读取文本
Class2.TextReader("C:\\test\\testreadtest.txt");
//csv实质上可以用文本打开，是以逗号相隔的字符串，理所当然也可以用StreamReader读取
//进一步可以对字符串操作，将csv表格数据存储到List<string>中去
//Excel没法用StreamReader读取
Class2.TextReader(@"C:\test\NewCsvFile123.csv");
```

**StreamWriter** 类继承自抽象类 TextWriter，表示编写器写入一系列字符。

```c#
//只需更改文件尾缀，即可输出CSV文件
		public static void TextWriter() 
        {
            string[] names = new string[] { "Zara Ali", "Nuha Ali" };
            using (StreamWriter sw = new StreamWriter("C:\\test\\names.txt"))
            {
                foreach (string s in names)
                {
                    sw.WriteLine(s);
                }
            }
         }
```

(2023.4.19)

### Appendix: C# I/O 类

> 一个 **文件** 是一个存储在磁盘中带有指定名称和目录路径的数据集合。当打开文件进行读写时，它变成一个 **流**。
>
> 从根本上说，流是通过通信路径传递的字节序列。有两个主要的流：**输入流** 和 **输出流**。**输入流**用于从文件读取数据（读操作），**输出流**用于向文件写入数据（写操作）
>
> System.IO 命名空间有各种不同的类，用于执行各种文件操作，如创建和删除文件、读取或写入文件，关闭文件等。
>
> 下表列出了一些 System.IO 命名空间中常用的非抽象类：
>
> | **I/O 类**   | **描述**                 |
> | ------------ | ------------------------ |
> | Directory    | 有助于操作目录结构。     |
> | File         | 有助于处理文件。         |
> | Path         | 对路径信息执行操作。     |
> | StreamReader | 用于从字节流中读取字符。 |
> | StreamWriter | 用于向一个流中写入字符。 |
> | ...          | ...                      |

(2023.4.20)

## 7.2 Excel文件的读写 

### 7.2.1 ExcelDataReader

用于载入本地Excel文件。

参考：[GitHub - ExcelDataReader/ExcelDataReader: Lightweight and fast library written in C# for reading Microsoft Excel files](https://github.com/ExcelDataReader/ExcelDataReader)

#### 7.2.1.1 CSV文件

```C#
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using ExcelDataReader;

namespace ConsoleApp.Loader
{
    public class CsvFileLoader
    {
        //存储特定路径下所有csv文件的数据到一个List中
        public List<DataTable> CsvData;
        public CsvFileLoader()
        {
            CsvData = new List<DataTable>();
        }

        public void AddCsvData(string directoryPathStr)
        {
            //获取特定路径下所有csv文件
            //Directory类属于命名空间System.IO
            string[] filePathList = Directory.GetFiles(directoryPathStr, "*.csv", SearchOption.AllDirectories);
			//遍历每一个csv文件
            foreach (string filePath in filePathList)
            {
                SetCsvData(filePath);
            }
        }


        public void SetCsvData(string filePathStr)
        {
            //Path类属于命名空间System.IO
            string FileName = Path.GetFileName(filePathStr);
			//File类属于命名空间System.IO
            FileStream stream = File.Open(filePathStr, FileMode.Open, FileAccess.Read);
            /*
            By default, ExcelDataReader throws a NotSupportedException "No data is available for encoding 1252." on .NET Core and .NET 5.0 or later.
To fix, add a dependency to the package System.Text.Encoding.CodePages and then add code to register the code page provider during application initialization (f.ex in Startup.cs):

System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance)

This is required to parse strings in binary BIFF2-5 Excel documents encoded with DOS-era code pages. These encodings are registered by default in the full .NET Framework, but not on .NET Core and .NET 5.0 or later.
            */
   System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
			/*
			ExcelDataReader：
			Lightweight and fast library written in C# for reading Microsoft Excel files
			VS=>Tools=>Nuget=>Search：ExcelDataReader and ExcelDataReader.DataSet
			https://github.com/ExcelDataReader/ExcelDataReader
			此库即是读取csv,Excel文件的关键
            */
			var csvReader = ExcelReaderFactory.CreateCsvReader(stream);
			//DataSet类，DataTable类属于命名空间System.Data
            //Make sure the project has a reference to the ExcelDataReader.DataSet package to use AsDataSet()
			DataSet csvDataSet = csvReader.AsDataSet();
            //遍历DataSet中的DataTable
			foreach (DataTable tableInfo in csvDataSet.Tables)
			{
				tableInfo.TableName = FileName;
				CsvData.Add(tableInfo);
			}
			csvReader.Close();
        }
    }
}
```

```C#
//调用该类
var loader = new CsvFileLoader();
loader.AddCsvData(@"C:\Users\zxb\test");
```

(2023.4.17)

#### 7.2.1.2 Excel文件

```c#
   public class ExcelFileLoader
    {
       //相较于CSV文件只能有一个sheet，所以可以看成DataTable
       //而Excel文件存在多个sheet，应当被看成DataSet
        public List<DataSet> ExcelData;

        public ExcelFileLoader()
        {
            ExcelData = new List<DataSet>();
        }


        public void AddData(string directoryPathStr)
        {
            string[] filePathList = Directory.GetFiles(directoryPathStr, "*.xls*", SearchOption.AllDirectories);

            foreach (string filePath in filePathList)
            {
                SetData(filePath);
            }
        }


        public void SetData(string filePathStr)
        {
            string FileName = Path.GetFileName(filePathStr);

            FileStream stream = File.Open(filePathStr, FileMode.Open, FileAccess.Read);
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

            var excelReader = ExcelReaderFactory.CreateReader(stream);
            //为AsDataSet增添配置ExcelDataSetConfiguration()，可以将特定行作为Table的列名，csv文件同样适用。2024.2.19
            DataSet excelDataSet = excelReader.AsDataSet(new ExcelDataSetConfiguration()
            {
                // Gets or sets a value indicating whether to set the DataColumn.DataType 
                // property in a second pass.
                UseColumnDataType = true,
                // Gets or sets a callback to determine whether to include the current sheet
                // in the DataSet. Called once per sheet before ConfigureDataTable.
                FilterSheet = (tableReader, sheetIndex) => true,
                // Gets or sets a callback to obtain configuration options for a DataTable. 
                ConfigureDataTable = (tableReader) => new ExcelDataTableConfiguration()
                {
                    // Gets or sets a value indicating the prefix of generated column names.
                    EmptyColumnNamePrefix = "Column",
                    // Gets or sets a value indicating whether to use a row from the data as column names.
                    // data as column names.
                    UseHeaderRow = true,
                    // Gets or sets a callback to determine which row is the header row. 
                    // Only called when UseHeaderRow = true.
                    ReadHeaderRow = (rowReader) => {
                        // F.ex skip the first two row and use the 3rdd row as column headers:
                        rowReader.Read();
                        rowReader.Read();
                    },
                    // Gets or sets a callback to determine whether to include the 
                    // current row in the DataTable.
                    FilterRow = (rowReader) => {
                        return true;
                    },
                    // Gets or sets a callback to determine whether to include the specific
                    // column in the DataTable. Called once per column after reading the 
                    // headers.
                    FilterColumn = (rowReader, columnIndex) => {
                        return true;
                    }
                }
            });
			//不像Datatable的tablename默认为sheet名，Dataset名需要手手动设置
            excelDataSet.DataSetName = FileName;
            ExcelData.Add(excelDataSet);

            excelReader.Close();

        }
    }
```

### 7.2.2 NPOI

> NPOI是POI的.NET版本,POI是一套用Java写成的库，我们在开发中经常用到导入导出表格、文档的情况，NPOI能够帮助我们在没有安装微软Office的情况下读写Office文件，如xls, doc, ppt等。NPOI采用的是Apache 2.0许可证（poi也是采用这个许可证），这意味着它可以被用于任何商业或非商业项目，我们不用担心因为使用它而必须开放你自己的源代码，所以它对于很多从事业务系统开发的公司来说绝对是很不错的选择。

=> ExcelDataReader没法对Excel进行输出，NPOI可以。

```C#
// load NPOI pakage from Nuget for operating Excel
//Don't suggest Microsoft.Office.Interop.Excel because of the risk of memory leak and time-consuming
//创建一个Excel，并往里面写入数据
class ExcelOutput
{
    private const string Outputpath = @"C:\Users\exzihon\OneDrive - Ericsson\Desktop\Repository\SelectNeidTool\Output\Output.xlsx";

    public ExcelOutput(List<List<string>> inputlists, string path = Outputpath)
    {
        using (FileStream stream = new FileStream(path, FileMode.Create, FileAccess.Write))
        {
            IWorkbook wb = new XSSFWorkbook();
            ISheet sheet = wb.CreateSheet("Sheet1");
            ICreationHelper cH = wb.GetCreationHelper();

            int i = 0;
            foreach (List<string> inputlist in inputlists)
            {
                IRow row = sheet.CreateRow(i);
                int j = 0;
                foreach (var item in inputlist)
                {
                    ICell cell = row.CreateCell(j);
                    cell.SetCellValue(cH.CreateRichTextString(item));
                    j++;
                }
                i++;
            }

            wb.Write(stream);
        }
    }

    public ExcelOutput(DataTable dt, string path = Outputpath)
    {
        using (FileStream stream = new FileStream(path, FileMode.Create, FileAccess.Write))
        {
            IWorkbook wb = new XSSFWorkbook();
            ISheet sheet = wb.CreateSheet("Sheet1");
            ICreationHelper cH = wb.GetCreationHelper();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                IRow row = sheet.CreateRow(i);
                for (int j = 0; j < 3; j++)
                {
                    ICell cell = row.CreateCell(j);
                    cell.SetCellValue(cH.CreateRichTextString(dt.Rows[i].ItemArray[j].ToString()));
                }
            }
            wb.Write(stream);
        }
    }

}


//复制一个既存的Excel，并往里面写入数据
internal class NeidListOutput
{
    public readonly string Basepath = @"C:\Users\Desktop\XXX.xlsx";
    public readonly string Outputpath = @"C:\Users\Desktop\yyy.xlsx";


    public NeidListOutput(List<List<string>> inputlists)
    {

        //Excel复制
        FileInfo beforAfterBaseFile = new FileInfo(Basepath);
        beforAfterBaseFile.CopyTo(Outputpath, true);
        var fs = File.OpenRead(Outputpath);


        //Put xlsx file into workbook
        var workbook = new XSSFWorkbook(fs);
        //Get the first sheet of xlsx file
        ISheet sheet = workbook.GetSheetAt(0);
        int rowNo = 1; 
        foreach (var inputlist in inputlists)
        {
            int column = 0;
            //Output columns for every row
            foreach (var item in inputlist)
            {
                //注意复制过来的Excel中，并不意味着拥有既存的无穷的行列
                //比如你写入数据后这个行才被NPOI是为既存（无论之后删除这个数据）
                SetCellValue(sheet, rowNo, column, item);
                column++;
            }
            rowNo++;
        }

        SaveExcel(Outputpath, workbook);

        return;
    }

    private void SetCellValue(ISheet sheet, int row, int column, String value)
    {
        ICell tmpCell = sheet.GetRow(row).GetCell(column);

        tmpCell.SetCellValue(value);
    }

    private void SaveExcel(String path, IWorkbook workbook)
    {
        FileStream fs = File.Create(path);
        workbook.Write(fs);
        fs.Close();
    }
}
```

(2023.10.23)

### 7.2.3 其他

#### 7.2.3.1 EPPlus

> EPPlus 是使用Open Office XML格式（xlsx）读写Excel 2007 / 2010文件的.net开发库。

注意EPPlus不支持.xls。

参考1：[C# Convert Excel To DataTable (c-sharpcorner.com)](https://www.c-sharpcorner.com/article/c-sharp-convert-excel-to-datatable/)

参考2：[GitHub - EPPlusSoftware/EPPlus: EPPlus-Excel spreadsheets for .NET](https://github.com/EPPlusSoftware/EPPlus/)

```c#
using OfficeOpenXml;
using System;
using System.Data;
using System.IO;
```

```c#
    public class ExcelUtility
    {
        public static DataTable ExcelDataToDataTable(string filePath, string sheetName, bool hasHeader = true)
        {
            var dt = new DataTable();
            var fi = new FileInfo(filePath);
            // Check if the file exists
            if (!fi.Exists)
                throw new Exception("File " + filePath + " Does Not Exists");

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            var xlPackage = new ExcelPackage(fi);
            // get the first worksheet in the workbook
            var worksheet = xlPackage.Workbook.Worksheets[sheetName];

            dt = worksheet.Cells[1, 1, worksheet.Dimension.End.Row, worksheet.Dimension.End.Column].ToDataTable(c =>
            {
                c.FirstRowIsColumnNames = true;
            });

            return dt;
        }
    }
```

```c#
//调用
var path = @"C:\test\file1.xlsx";
var data = ExcelUtility.ExcelDataToDataTable(path, "Sheet1");
var data2 = ExcelUtility.ExcelDataToDataTable(path, "Sheet2");
```

#### 7.2.3.2 GemBox

> GemBox.Spreadsheet.dll 是由GemBox公司开发的基于Excel功能的开发工具，该DLL很轻量，且使用起来很方便

可以用于创建Excel，写入并输出。

```C#
           // If you are using the Professional version, enter your serial key below.
            SpreadsheetInfo.SetLicense("FREE-LIMITED-KEY");

            // Create test DataSet with five DataTables
            DataSet dataSet = new DataSet();
            for (int i = 0; i < 5; i++)
            {
                DataTable dataTable = new DataTable("Table " + (i + 1));
                dataTable.Columns.Add("ID", typeof(int));
                dataTable.Columns.Add("FirstName", typeof(string));
                dataTable.Columns.Add("LastName", typeof(string));

                dataTable.Rows.Add(new object[] { 100, "John", "Doe" });
                dataTable.Rows.Add(new object[] { 101, "Fred", "Nurk" });
                dataTable.Rows.Add(new object[] { 103, "Hans", "Meier" });
                dataTable.Rows.Add(new object[] { 104, "Ivan", "Horvat" });
                dataTable.Rows.Add(new object[] { 105, "Jean", "Dupont" });
                dataTable.Rows.Add(new object[] { 106, "Mario", "Rossi" });

                dataSet.Tables.Add(dataTable);
            }

            // Create and fill a sheet for every DataTable in a DataSet
            var workbook = new ExcelFile();
            foreach (DataTable dataTable in dataSet.Tables)
            {
                ExcelWorksheet worksheet = workbook.Worksheets.Add(dataTable.TableName);

                // Insert DataTable to an Excel worksheet.
                worksheet.InsertDataTable(dataTable,
                    new InsertDataTableOptions()
                    {
                        ColumnHeaders = true
                    });
            }

            workbook.Save("C:\\test\\NewCsvFile135.xlsx");
```

#### 7.2.3.3  Microsoft.Office.Interop.Excel

用来操作Excel文件的库其实非常多。比如微软官方为C#写的Microsoft.Office.Interop.Excel

MSDN：https://learn.microsoft.com/zh-cn/dotnet/csharp/advanced-topics/interop/how-to-access-office-interop-objects

不仅可以操作Excel，也可以操作Word.

=>Microsoft.Office.Interop.Excel的缺点在于很容易造成内存泄漏(2023.10.23)

其他开源第三方的也非常多，比如：

[(Step by Step) Export to Excel Outputs in C# [Code Example\] | IronXL (ironsoftware.com)](https://ironsoftware.com/csharp/excel/how-to/c-sharp-export-to-excel/)

## 7.3 XML文件的操作

C#中对XML操作有两种方法：1. [XmlDocument](https://learn.microsoft.com/en-us/dotnet/api/system.xml.xmldocument?view=net-7.0&redirectedfrom=MSDN) 类；2.LINQ；

以LINQ为例：

```C#
using System.Xml.Linq;

//载入XML文件，根节点作为一个XElement(任意一个节点均为XElement类型)
var parseXMLfile = XElement.Load(inputFilePath);

//标记xlmns，LINQ操作时不能直接用"xx:yyy"的形式，无法识别其中的冒号，要用"xn+"yyy""
XNamespace xn = "genericNrm.xsd";

//Descendants表示从根节点parseXMLfile的所有层级子节点中进行搜索
IEnumerable<XElement> managedElementIds =
      from managedElementId in parseXMLfile.Descendants(xn + "managedElementId")
      select managedElementId;

//LINQ与正则表达式的结合
var rgx = new Regex(item.SearchMO.Id);
IEnumerable<XElement> elListOfContainers =
      from elListOfContainer in parseXMLfile.Descendants(xn + "VsDataContainer")
      let matches = rgx.Matches((string)elListOfContainer.Attribute("id"))
      where matches.Count > 0
      select elListOfContainer;

///链式检索标签，用于检索特定深度的tag
var vsDataType = el.Element(xn + "attributes").Element(xn + "vsDataType").Value;
```

(2023.8.3)

# Others

## 1 GIT

### 1.1 GIT原理

Git Data Transport Commands:

> workspace => index => local repository => remote repository
>
> add : workspace => index
>
> commit: index => local repository 
>
> push: local repository => remote repository
>
> fetch: local repository <= remote repository
>
> pull: local workspace <= remote repository
>
> checkout: workspace <= index

注意与SVN不同，git作为分布式版本控制软件，其最大的不同就在于这个local repository. 

=>index 和 local repository本质上是存在于.git文件夹里的文件

remote repository就比如说Github.

commit与push的区别：`commit`会将更改提交到本地存储库，而`push`会将更改推到远程存储库。

fetch和pull的区别：`git fetch`是从远程获取最新版本到本地，但不会自动merge, 你可以进一步用`git diff`与`git merge`来完成与`git pull`同样的效果。

=> 单单是 `git fetch`, 你看不到 `show log`, 要 `git merge` 后才能看到远端的更新。推测是`show log`基于workspace，而 `git fetch`仅仅是更新到local repository. 所以要进一步`git merge` 将workspace与local repository同步。(2023.4.28)

Git 提交代码步骤：

1. git pull，从远端仓库拿取最新版本
2. 一通修改后，git commit推送到本地仓库
3. git pull或git fetch, 查看这期间远端仓库是否有人更新，是否需要合并操作 => 遇到冲突，需要再次commit（可以忽略冲突强行commit后push覆盖远端冲突文件, 比如Excel文件你没法手动合并)(2023.6.21)①
4. git push, 将本地仓库推送到远端

注意：如果你省略第二步：git commit，那git不知道你做的修改，在第3步的时候把别人在这期间修改的版本pull下来，你有可能去覆盖掉别人的代码而没有任何通知。

(2023.4.14)

=> 针对上述问题，**在TortoiseGit，如果修改了本地文件却没有commit，是无法从远端仓库pull的**。这个时候有两个选项：1. commit后再pull，若没有冲突则可以直接push，若有冲突则merge后push；2. revert掉你本地修改与远端仓库保持一致，然后再pull.

(2023.6.7)

> ①两种commit：
>
> 一种是常规的 commit，也就是使用 `git commit` 提交的 commit；另一种是 **merge commit**，在使用 `git merge` 合并两个分支之后，你将会得到一个新的 merge commit
>
> merge commit 和普通 commit 的不同之处在于 merge commit 包含两个 parent commit，代表该 merge commit 是从哪两个 commit 合并过来的。

### 1.2 GIT文件操作

用git status 查看文件状态:

1. **Untracked**: 此文件虽在workspace 中，但并没有加入git库，不参与版本控制，可通过`git add`变为 Staged；
2. **Unmodify**: 此文件已进入git库，未修改，即版本库中的文件快照内容与workspace中完全相同。若被修改，则变为Modified状态。另外，若使用`git rm`, 则移除版本库，变成Untracked状态；
3. **Modified**: 文件被修改。通过`git add`变为Staged状态；或者使用`git checkout`, 丢弃修改，返回Unmodify状态。**这个`git checkout` 即从库中取出文件，覆盖当前修改！**
4. **Stage**: 暂存状态，使用git commit则将修改同步到库中，此时会变成Unmodify状态；执行`git reset HEAD filename`取消暂存，文件状态变为Modified.

### 1.3 GIT分支

```shell
#查看本地分支
git branch
#查看远程分支
git branch -r
#新建一个分支，但依然停留在当前分支
git branch [branch]
#新建一个分支，并切换到该分支
git checkout -b [branch]
#合并指定分支到当前分支
git merge [branch]
```

master住分支应该非常稳定，用来发布新版本，一般情况下不允许在上面工作。工作可以在新建的dev分支，等dev分支稳定后可以合并到主分支master上来。

#### 1.3.1 rebase与merge

> 构造两个分支master和feature，其中feature是在提交点B处从master上拉出的分支.
>
> Master：A=>B=>M
>
> feature:  B=>C=>D
>
> 此时我们切换到feature分支上，执行rebase命令，相当于是想要把master分支合并到feature分支（这一步的场景就可以类比为我们在自己的分支feature上开发了一段时间了，准备从主干master上拉一下最新改动。模拟了git pull --rebase的情形）
>
> ```shell
> # 这两条命令等价于git rebase master feature
> git checkout feature
> git rebase master
> ```
>
> 变基后的提交节点图: A=>B=>M=>C=>D
>
> 通俗解释（重要！！）：rebase，变基，可以直接理解为改变基底。feature分支是基于master分支的B拉出来的分支，feature的基底是B。而master在B之后有新的提交，就相当于此时要用master上新的提交来作为feature分支的新基底。实际操作为把B之后feature的提交先暂存下来，然后删掉原来这些提交，再找到master的最新提交位置，把存下来的提交再接上去（接上去是逐个和新基底处理冲突的过程），如此feature分支的基底就相当于变成了M而不是原来的B了。（注意，如果master上在B以后没有新提交，那么就还是用原来的B作为基，rebase操作相当于无效，此时和git merge就基本没区别了，差异只在于git merge会多一条记录Merge操作的提交记录）
>
> **大部分公司其实会禁用rebase，不管是拉代码还是push代码统一都使用merge，虽然会多出无意义的一条提交记录“Merge … to …”，但至少能清楚地知道主线上谁合了的代码以及他们合代码的时间先后顺序**

(2023.5.9)

### Appendix

#### Solution for error: RPC failed

问题现象：

```shell
remote: Counting objects: 66352, done.
remote: Compressing objects: 100% (10417/10417), done.
error: RPC failed; curl 18 transfer closed with outstanding read data remaining
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed
```

推测原因：网速没法保证一次性下载太大的文件。

解决方法：采用分步clone

```shell
//只克隆master分支的最近一次commit
//depth用于指定克隆深度，为1即表示只克隆最近一次commit
//适合用 git clone --depth=1 的场景：你只是想clone最新版本来使用或学习，而不是参与整个项目的开发工作
git clone http://XXX --depth 1
//show log只会有一条记录
//这个命令是认为当前local的这个目录下面是shallow（不完整的），把远端的<repository>和local的比较，然后把没有的下载下来。
git fetch --unshallow
//这时候switch其他分支，发现只下载了master分支...
git branch -a
//并且git并不认为当前local的目录是shallow, 而是complete
//产看配置信息
git config remote.origin.fetch
//结果=> +refs/heads/master:refs/remotes/origin/master
//只能下载master的原因是配置信息里只写了master
//修改为下载路径下所有分支
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
//确认是否修改
git config remote.origin.fetch
//最后更新，完成所有分支下载
git remote update
```

(2023.7.6)

#### .gitignore文件

在TortoiseGit中可以在commit时对Untracked文件右击Add to ignore list, 此时会在当前目录下自动创建.gitignore文件。(Windows下通过Git Bash来 touch .gitignore的话，编辑时回车符等不好处理。) =>参考 [Link](https://stackoverflow.com/questions/35740254/context-menu-for-folder-does-not-contain-add-to-ignore-list-tortoisegit)

然后可以通过编辑.gitnore来批量忽略一些不必要的文件，例如：

```
# 忽略.gitignore文件所在目录下.vs目录的内容，其他目录的.vs文件和目录不受影响
/.vs
# 忽略.gitignore文件所在目录下的所有bin目录(包括子目录下的bin文件夹都会被忽略)
bin/
obj/
```

(2023.12.27)

#### Command集

```shell
//查看本地分支
git branch
//查看远程分支
git branch -r
//查看远程仓库地址
git remote -v
//产看当前分支提交记录
git log
//删除本地分支
git branch -d localBranchName
//删除远程分支, 他人删除远程分支后，你这边需要 git fetch -p 同步分支列表
git push origin --delete remoteBranchName
//-p 的意思是“精简”。这样，你的分支列表里就不会显示已远程被删除的分支了。
git fetch -p
```



## 2 Access

> Microsoft Access**是一个关系数据库管理系统(RDBMS)，主要是为家庭或小型企业的使用而设计的**。 Access 在传统上被称为一个桌面数据库系统，因为它的功能旨在一台计算机上运行 (而不是应用程序安装在服务器上的服务器数据库应用程序，然后远程从多个客户机访问).

### 2.1 VBA

#### 2.1.1 VBA与VB

> **VB**
>
> Visual Basic（简称VB）是Microsoft公司开发的一种通用的基于对象的程序设计语言。 
> “Visual” 指的是开发图形用户界面 (GUI) 的方法——不需编写大量代码去描述界面元素的外观和位置，而只要把预先建立的对象add到屏幕上的一点即可。
>
> “Basic”表示源自于BASIC编程语言。
>
> VB拥有图形用户界面（GUI）和快速应用程序开发（RAD）系统，可以轻易的使用DAO、RDO、ADO连接数据库，或者轻松的创建Active X控件，用于高效生成类型安全和面向对象的应用程序 。

> **VBA**
>
> VBA（Visual Basic for Applications）是Visual Basic的一种宏语言，是在其桌面应用程序中执行通用的自动化任务的编程语言。主要能用来扩展Windows的应用程序功能，特别是Microsoft Office软件。它也可说是一种应用程式视觉化的 Basic 脚本。

> **区别**
>
> 1. VB是设计用于创建标准的应用程序，而VBA是使已有的应用程序(EXCEL等)自动化。
> 2. VB具有自己的开发环境，而VBA必须寄生于已有的应用程序。 
> 3. 要运行VB开发的应用程序，用户不必安装VB，因为VB开发出的应用程序是可执行文件(*.EXE)，而VBA开发的程序必须依赖于它的父应用程序，例如EXCEL。
> 4. VBA是VB的一个子集。

=>VB是像C#那样面向对象的语言，用于开发GUI。而VBA可以视为VB简化而来的脚本语言，所以在VBA中不必有main函数，修改后也无需编译后运行。基本上是GUI上一个控件连接一个宏，执行一段自动化procedure.

> 宏（Macro），是一种批量处理的称谓。就是把一些命令组织在一起，作为一个单独的命令完成一个特定任务。

#### 2.1.2 Sub与Function

> 在VBA中，Sub是一种过程（Procedure），用于执行一系列的VBA代码，类似于其他编程语言中的函数或子程序。Sub是Visual Basic的缩写，是Subroutine（子程序）的简写。
>
> 需要注意的是，Sub过程不返回值，它们只执行一系列操作。如果需要返回值，则需要使用Function过程。

=>可以将Sub理解为一个小脚本，它可以与GUI上的一个Click事件绑定。

#### 2.1.3 基本语法

```vb
'注意VBA的注释形式
'此处就是与GUI输出按钮连接的最外层的Sub
Private Sub cmd_Output_PreconDT_Click()
    '用Call调用子过程 
    '可以看到VBA语句结束没有分号
    Call OUTPUT_MAIN("Precon")
End Sub

Sub OUTPUT_MAIN(outType As String)
    Call CreateDT_Preparation(CurrentDb)    
    Me.Status_Text.Caption = "Please Wait...  Output Scripts"
    Me.Repaint   
    Call Create_DT_Script_Main(outType)
    Me.Status_Text.Caption = ""
    Me.Repaint
End Sub


Sub Create_DT_Script_Main(outputType As String)
    '变量定义的形式
    Dim db As DAO.Database
    Dim rsENB As DAO.Recordset
    '(省略)
    
    '设置变量值的形式
    Set db = CurrentDb
        'Function则是直接用变量接收，而无需像Sub那样使用Call
    Set rsENB = db.OpenRecordset("SELECT * FROM MUSEN_SYOGEN_COMMON WHERE NE_ID IN (SELECT NE_ID FROM BS_LIST WHERE NZ(IsOutput)='')")
    
    '条件判断的形式
    If rsENB.EOF Then
                MsgBox "No output file", vbExclamation
        rsENB.Close
        '与C语言一样有GoTo
        GoTo Exit_Create_DT_Script
    End If

'(省略)  
    'While循环的形式
    Do Until rsENB.EOF
        Call Set_zx_Site_Items(db, rsENB, FromRegion)
        Call Set_zx_Cell_Items(db, rsENB)
        Call Set_zx_Site_MME(db, rsENB)
        Call Set_zx_Site_BTS(db, rsENB)
        rsENB.MoveNext
    Loop
    
     'switch选择语句的形式        
     Select Case outputType
        Case "Precon"
'(省略)  
            'For循环的形式
            For Each fldSite In fld.SubFolders
                If Not Dir(fldSite.path & "\30_1_*.*", vbDirectory) = vbNullString Then
                    Kill fldSite.path & "\30_1_*.*"
                End If
            Next
'(省略) 
        Case "NWCNBR"
'(省略) 
    End Select
    
    rsENB.Close
    db.Close
    
Exit_Create_DT_Script:
'VBA不会自动释放变量，需手动清理，否则会影响其他Procedure        
    Set rsENB = Nothing
    Set db = Nothing
    Set ExApp = Nothing
'可以中途结束procedure
    Exit Sub
    
ErrorHandler:
    MsgBox Err.Number & ":" & Err.Description, 48
    GoTo Exit_Create_DT_Script
End Sub
```

(2023.7.27)

#### 2.1.4 重要方法

```vb
'Nz(variant, [valueifnull]),如果variant的值是空的话就用valueifnull代替。如果variant的值不是空就不变。
'valueifnull 可选。如果在查询中的表达式中使用Nz函数，而没有使用 valueifnull 参数，且variant 参数的值为Null，将返回数值零或零长度字符串（当用在查询表达式中时，始终返回零长度字符串）
'简而言之Nz()方法用来check字段是否为Null，类似C#中的 string b ?? "";
If region <> "Common" Then
    If Nz(Me.cmb_Region) = "" Then
        MsgBox "Please select region", 48
        Exit Function
    End If
End If


'InStr(string1, string2), 返回一个 Variant (Long) 值，指定string2在string1中首次出现的位置。若不含此字符串则return 0
If InStr(wb.Name, "NW_Master") > 0 Then
    MsgBox "Please check sheet [auX]"
Else
    MsgBox "Please check sheet [" & rsRule("SheetName").Value & "]"
End If
```

#### 2.1.5 交互Excel

```vb
Private Sub Open_Excel()
    Dim ExApp As Object
    Dim impSuccess As Boolean
    'ExApp相当于Excel程序，而不是具体某一个Excel文件
    Set ExApp = CreateObject("Excel.Application")
        ExApp.DisplayAlerts = False '关掉警告信息
    ExApp.EnableEvents = False        
    impSuccess = CommonImportExcel(ExApp)    
        
    ExApp.Quit
    Set ExApp = Nothing
Exit Sub
                
Public Function CommonImportExcel(ExApp As Object) As Boolean
    Dim wb As Object
    Dim ws As Object                
	'打开即存的Excel文件
    Set wb = ExApp.Workbooks.Open("path\file")

    '判断打开的Excel名，取得特定sheet的数据                    
    If InStr(wb.Name, "NW_Master") > 0 Then
    For Each ws In wb.Worksheets
        If ws.Name Like rsRule("SheetName").Value Then
            Exit For
        End If
    Next
	Else
    	Set ws = wb.Worksheets(rsRule("SheetName").Value)
	End If
    '对该sheet各种操作=>推测基本上与Excel中的VBA相同
    If ws.Range("F2").Value = "地域" And ws.Range("BA2").Value = "情报" Then
    	ws.Columns("B:B").Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    	ws.Columns("F:G").Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    	ws.Columns("H:H").Cut                        
                        
    '创建临时Excel文件
    Dim twb As Object
    Dim tws As Object
	Set twb = ExApp.Workbooks.Add
	Set tws = twb.Worksheets(1)  
                                
    '从ws sheet复制，注意没有变量接受，可以理解为Desktop上的Crtl+C 
    ws.Range(“C1:C5”).Copy 
    '粘贴到tws                                   
    tws.Range(“D1”).PasteSpecial    

    '将临时创建的Excel文件保存为csv文件                                
    Dim tfp As String
	tfp = CurrentProject.path & "\" & FSO.GetBaseName(FSO.GetTempName) & ".csv"                                  
   	twb.SaveAs FileName:=tfp, FileFormat:=xlCSV, ReadOnlyRecommended:=False, CreateBackup:=False, Local:=True
   	twb.Close False
   	Set twb = Nothing                                    
                                
    wb.Close False
    Set wb = Nothing 
Exit Function                            
```

#### 2.1.6 交互DB

```vb
Private Sub IMPORT_Files(ActionType As String)
    'ADO是应用层数据访问接口,DAO是面向对象的数据访问接口.通俗的理解就是ADO是DAO的升级版,后续产物,它使用OLEDB接口而不是ODBC,比他更灵活易用
    Dim db As DAO.Database
    '创建记录集对象，负责接收SQL执行后的内存
    Dim rsFile As DAO.Recordset
    Dim SQL As String
    
    '将db直接设置为当前，就可以操作Access界面上所定义的Tables'
    Set db = CurrentDb
    
	'执行SQL命令之后，提取到的数据会被加载到内存中，要用记录集接收        
    'FILE_CATEGORY,FILE_PATH,INSERT_DATE均为表FILE_MANAGEMENT中的列名   
    Set rsFile = db.OpenRecordset("SELECT * FROM FILE_MANAGEMENT WHERE FILE_CATEGORY like '" & ActionType & "' AND FILE_PATH IS NOT NULL AND INSERT_DATE IS NULL")  
    If rsFile.EOF Then
        MsgBox "没有数据", 48
        rsFile.Close
        Exit Sub
    Else
        Do Until rsFile.EOF
            tarCategory = tarCategory & ",'" & rsFile("FILE_CATEGORY").Value & "'"
            rsFile.MoveNext
        Loop
        rsFile.MoveFirst
        tarCategory = Mid(tarCategory, 2)
    End If
    
    '从Excel中读取数据，并于其中insert到Access的Table中
    impSuccess = CommonImportExcel(ExApp, fp, rsRule)            
                
   '各种操作Access界面上所定义的Tables
    db.Execute "DELETE FROM FILE_MANAGEMENT WHERE FILE_CATEGORY  in (" & tarCategory & ") AND INSERT_DATE IS NOT NULL"           

 	Select Case rsFile("FILE_CATEGORY").Value
     	Case "Musen_Syogen"
         	db.Execute "delete from MUSEN_SYOGEN_COMMON where FLG_1 <> '有效'"
     
         	db.Execute "UPDATE MUSEN_SYOGEN_SITE2G   INNER JOIN MUSEN_SYOGEN_COMMON ON MUSEN_SYOGEN_SITE2G.NE_ID   = MUSEN_SYOGEN_COMMON.NE_ID SET MUSEN_SYOGEN_SITE2G.SITE_ID_2G     = MUSEN_SYOGEN_COMMON.SITE_ID_2G   WHERE MUSEN_SYOGEN_SITE2G.SIGN_FLG ='桳'   and MUSEN_SYOGEN_SITE2G.SITE_ID_2G     <> MUSEN_SYOGEN_COMMON.SITE_ID_2G"
 	End Select
 End Sub
```

(2023.8.25)

### 2.2 SQL

=>不同数据库的SQL语句会略有些差别, 至少对于Access中的SQL语句是大小写不敏感的，包括诸如SELECT/select这些关键字

[ClickHere](https://www.bilibili.com/video/BV1V4411U7QN?p=19&vd_source=6fc477a8e79179a3fd30bed2e2ba5fbe)

#### 2.2.1 基本增删改查

SQL语句主要就是对记录的插入，删除，更新，查询：

```sql
insert into 表格名(列名1，列名2) value('电话'，'999')
delete from 表名 where 电话='999'
update 表名 set 电话='111' where 人名='Eric'
```

```vb
'实例
db.Execute "DELETE FROM FILE_MANAGEMENT WHERE FILE_CATEGORY  in (" & tarCategory & ") AND INSERT_DATE IS NOT NULL"
```

注意如何在SQL语句中使用变量：

```vb
'在SQL语句中使用变量,&为连接符，相当于C#中的+，前后连接字符串，各部分均需""括起来 
'举例
Dim str As String
str="update 学生 set 班级='2' where 性别='"    & str &     "'"
'实例
Set rsFile = db.OpenRecordset("SELECT * FROM FILE_MANAGEMENT WHERE FILE_CATEGORY like '" & ActionType & "' AND FILE_PATH IS NOT NULL AND INSERT_DATE IS NULL")
```

SQL语句中占据中心位置的是查询：

```sql
/* 提取不重复记录，使用distinct命令 */
select distinct 列名 from 表名  
/* 排序。默认升序。用order by  */                  
select 列名 from 表名 order by 成绩  
/* 降序,添加asc  */                        
select 列名 from 表名 order by 成绩 asc  
/* 连接两个SQL语句，用union */
select 列名 from 表名 union select 列名2 from 表名2
/* 条件查询。用where */
select * from 学生 where 性别<>'男'
/* 列表查询。用 In 或 Not In */
select * from 学生 where 研究方向 in('风险投资','项目投资')
/* 介于查询（Between）*/
select * from 成绩 where 成绩 between 80 and 90
/* 空值查询(NUll),不要用=或<>, 要用 is 和 not is */
select * from 成绩 where 成绩 is null
/* 字符连接，&。还可以为连接后的字段取别名 */
select 学号&姓名 as 学号姓名 from 学生
```

```vb
'实例
Set rsNwMaster = db.OpenRecordset("SELECT * FROM NW_MASTER WHERE NE_ID = '" & Nz(rsData("NE_ID")) & "' AND SITE_ID_NAME = '" & Nz(rsData("SITE_NAME")) & "'")
```

#### 2.2.2 模糊查询

```sql
/* 模糊查询。主要三个通配符 */
/* %  =>  相当于*,任意多个字符 */
select * from 员工 where 姓名 like '李%'
select * from 员工 where 简历 like '%组织能力强%'
select * from 员工 where 简历 not like '%组织能力强%'
/* _ => 相当于？，任意单个字符 */
select * from 员工 where 姓名 like '李_'
select * from 员工 where 姓名 like '___'
/* [] => 字符组，[A-Z],[0-9]。表示不在某个范围[!...] */
/* SQL语句中大小写不敏感,[h-m]%表示以[h-m]中的一个字母开头 */
select * from 员工 where 电子邮件 like '[h-m]%' 
select * from 员工 where 电子邮件 like '[!h-m]%' 
select * from 员工 where 身份证号 like '[!1，5，3]%' 
```

#### 2.2.3 聚合函数

```sql
/* 聚合函数，sum 纵向求和，avg，max,count,min
所谓聚合，就不管有多少行，结果都聚合成一行。所以普通字段不能和聚合函数一起用，条目数上对不上 */
select avg(年龄) as 平均年龄，count(*) as 人数 from 员工
/* 分组统计(group by)
'加了group by, avg聚合就按group来了，所以可以与字段部门一起用 */
select 部门，avg(年龄) as 平均年龄 from 员工 group by 部门
/* 小组筛选(having)，对分组之后形成的新表进行筛选，所以要跟在group by之后 */
select 部门，avg(年龄) as 平均年龄 from 员工 group by 部门 haveing avg(年龄) <= 35
/* select语句的执行顺序：from->where->group->having->select, 因为select最后执行，所以其中as取到的别名没法用到having语句中 */
/* 总结：普通字段如果与聚合函数同时出现在select后面，那么普通字段需要分组 */
```

```vb
'实例
strsql = "SELECT * FROM LTE_GWSW_IP WHERE NODE_NAME='" & GWSW & "' AND AP_NW_VLAN='" & VLAN & "'"
```

#### 2.2.4 嵌套查询

```sql
/* 将查询结果生成一个新表 */
select * into 优秀 from 成绩 where 成绩>=90
/* 将查询结果追加到已有的表，insert中value的位置直接添上select语句，select语句结果要跟即存表字段顺序一致 */
insert into 优秀 select from 成绩 where 成绩 between 85 and 89

/* 子查询：就是select嵌套他。 子查询必须要用括号；子查询一定是首先被实行的语句 */
/* 用法1：将子查询做数据源。*/
select 部门,count(*) as 人数 from (select * from 员工 where 年龄 >= 30 )
/* 用法2：将子查询做条件。*/
/* 当子查询的结果只有一个值的时候，可以用>等符号，如若有多个值的时候，要用in 和 not in*/
select 姓名,性别,部门,年龄,职务 from 员工 where 年龄 > (select avg（年龄) from 员工)

```

#### 2.2.5 多表查询

```sql
/* 等值连接，必须要有公共的连接字段，用where连接，多个表连接用and */
/* 另外需注意用点号连接表名和字段名 */
select * from 学生,课程,成绩 where 学生.学号 = 成绩.学号 and 成绩.课程代码 = 课程.课程代码
/* 因为where只能用一次，如果用与连接了，之后还需要加筛选条件，同样用and */
select * from 学生,课程,成绩 where 学生.学号 = 成绩.学号 and 成绩.课程代码 = 课程.课程代码 and 姓名='ZXB'

/* 内连接，与where连接一样属于等值连接，只是表达方式有区别 */
select * from 学生,课程 where 学生.学号 = 成绩.学号 
/* 把表间的逗号改为inner join，把where改为on  */
select * from 学生 inner join 课程 on 学生.学号 = 成绩.学号

/* 外连接，基本格式：from 左表 连接类型 右表 on 连接条件 */
/* 左连接：左表连接字段有的，而右表没有的，左表全部显示，右表留空*/
select * from 姓名,性别,职称,系号,系名 from 导师 left join 院系 on 导师.院系编号 = 院系.系号 
/* 右连接: 右表连接字段有的，而左表没有的，右表全部显示，左表留空 */
select * from 姓名,性别,职称,系号,系名 from 导师 right join 院系 on 导师.院系编号 = 院系.系号
/* 全连接 */
select * from 姓名,性别,职称,系号,系名 from 导师 full join 院系 on 导师.院系编号 = 院系.系号

/* 自连接：因为是同一张表，所以要取名t1,t2来区分 */
select * from 员工 t1 inner join 员工 t2 on t1.姓名 = t2.姓名
```

(2023.8.28)

#### Appendix

```vb
sqlGwSw = "SELECT * FROM LTE_GWSW" + nttArea + " WHERE BD_NAME = '" & Nz(rsNwMaster("SITE_ID_NAME")) & "'"
sqlGwSw = sqlGwSw & " UNION ALL SElECT * FROM LTE_GWSW_BTS WHERE BD_NAME = '" & Nz(rsNwMaster("SITE_ID_NAME")) & "'"

strsql = "SELECT * FROM LTE_GWSW_IP WHERE NODE_NAME='" & GWSW & "' AND AP_NW_VLAN='" & VLAN & "'"
strsql = strsql & " UNION SELECT * FROM LTE_GWSW_IP_BTS WHERE NODE_NAME='" & GWSW & "' AND AP_NW_VLAN='" & VLAN & "'"
```

> union和union all的区别：
>
> 1、union: 对两个结果集进行并集操作, 不包括重复行,相当于distinct, 同时进行默认规则的排序;
>
> 2、union all: 对两个结果集进行并集操作, 包括重复行, 即所有的结果全部显示, 不管是不是重复;

## 3 Visual Studio

insert mode 切换：

当输入字符时只能替换后面字符，不能添加字符的情况出现时，这是由“输入模式”进入了“修改模式”。在键盘上按一下“insert”即可切换输入和修改模式。



行注释方法：

注释：Ctrl + K, Ctrl + C

取消：Ctrl + K, Ctrl + U



Dell fn键切换：

fn+fn lock(可能是shift键也可能是ESC键)



Debug mode:  Ctrl+F11 =>能看汇编代码，厉害了...

(2023.6.21)

Ctrl + K ,  Ctrl + D.  自动整理代码

(2023.6.27)



自动给方法注释：

连续输入 ///

(2023.7.17)



Visual Studio中添加项目引用：

1. Solution下Add=>Existing Project，将新项目添加到可引用列表中;
2. 在主项目Add=>Reference，选取引用列表中刚添加的项目;

(2023.7.19)

=>注意不要遗漏第一步！(2023.9.8)



如何解决创建项目时无法选择 4.6.1 框架？

在保证 VS installer 已经安装4.6.1 包的情况下，创建WPF发现只支持 6.0和7.0

忽略了项目类型中 WPF App和 WPF App(.NET Framework)的区别！前者用于跨平台（VS2022倾向于支持跨平台），后者基于.NET Framework。

(2023.8.17)



> 使用微软内置输入法的时候，我经常会遇到输入英文字母间距变大的情况。
>
> 问题出现原因：间距变大是因为我们的输入法由原来的“半角”转换为“全角”。
>
> 解决方法：在输入法设置中修改，或者键盘同时敲击“shift”+“space”即可。

(2023.8.31)



如何为代码中的函数添加git history：

Tools → Options → Text Editor → All Languages → CodeLens

(2024.1.19)



### Code Snippets

[Reference](https://learn.microsoft.com/en-us/visualstudio/ide/visual-csharp-code-snippets?view=vs-2022)

How to use snippets in VS?

举例:在Prism框架中 输入“propp”，然后双击Tab键。

| **Name** | **Description**                                              | **Valid locations to insert snippet** |
| -------- | ------------------------------------------------------------ | ------------------------------------- |
| cw       | Creates a call to [WriteLine](https://learn.microsoft.com/en-us/dotnet/api/system.console.writeline). | Inside a Method, Not inside a Class   |
| prop     | Creates an [auto-implemented property](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/auto-implemented-properties) declaration. | Inside a class or a struct.           |
| propfull | Creates a property declaration with `get` and `set` accessors. | Inside a class or a struct.           |
|          |                                                              |                                       |
|          |                                                              |                                       |
|          |                                                              |                                       |
|          |                                                              |                                       |
|          |                                                              |                                       |
|          |                                                              |                                       |

(2023.8.1)



## 5 杂记

### 5.1 C#对象初始化顺序

Java：声明时为成员变量赋值，那么你一创建对象，这个赋值就进行，而且先于构造器执行。

执行顺序:
执行父类静态代码,执行子类静态代码
初始化父类成员变量（我们常说的赋值语句）
初始化父类构造函数
初始化子类成员变量
初始化子类构造函数



C++：对象的成员变量的初始化动作发生在进入构造函数本体之前。



C#：属性，成员函数不会被执行。=> 属性如果被赋值同样会先于构造函数初始化。

如果作为属性的List等容器没有被赋值(new), 后续方法中无法直接被使用，会报没实例化的错误。

### 5.2 C#数字处理

#### 5.2.1 进制转换 

```C#
/* 1.各种进制形式(字符串)转化为十进制(整型)
 *  ToInt64(string value,int frombase)是Convert里面的一个方法，是将数字的字符串表示形式转换为等效的64位有符号整数(也
 *  Value是需要转化的字符串，frombase是数字基数，即2，8，10，16，这里是将16进制转化，所以是16
 */
//将16进制字符串转化为十进制整型
string a16 = "0xFFFF";
Console.WriteLine(Convert.ToInt64(a16, 16));//=>65535
//将2进制字符串转化为十进制整型
string a2 = "1010";
Console.WriteLine(Convert.ToInt32(a2, 2));//=>10

/* 2.十进制(整型)转化为 各种进制形式(字符串)
 *  Convert.ToString(int value,int radix)是Convert里面的另一个方法，可以看成ToInt64的逆运算
 *  Value是需要转化的十进制整数值(其实可以是任何进制形式的，看输入者心情)，radix是进制，即2，8，10，16
 */
int a10 = 654;
Console.WriteLine(Convert.ToString(a10, 16));//=>28e

/* 2.1还有另一种方式将十进制(整型)转换为其他进制，比如十六进制(字符串)
 * 下面Tostring("X6")是将整型a10转化成字符串形式的16进制数
 * 其中：
 *  "x"小写输出十六进制的的字母为小写字母，"X"大写则输出的十六进制字母为大写；
 *  后面的数字6是表示自动补0补足6位；
 */
Console.WriteLine(a10.ToString("X6"));//=> 00028E
```

(2023.6.16)

#### 5.2.2 小数点后位数处理

```c#
string latitude = "1413334";
double mmmm_value = 0;
double.TryParse(latitude.Substring(latitude.Length - 2, 2), out mmmm_value);
//四舍五入
Console.WriteLine((Math.Round((mmmm_value / 60), 4) * 10000).ToString());
//直接截取
Console.WriteLine(Math.Floor(mmmm_value / 60 * 10000).ToString());
//主要就是 Math.Round 与 Math.Floor 的区别
```

(2023.11.29)

### 5.3 C#中字符串的分割

```C#
//用字符串自带的Split()方法
string teststring = "928__0__3395755__6521910__0__15__60__100__0";
string[] split = teststring.Split('_');
Console.WriteLine(split[0]);
//或者用正规表达式
string[] split2 = Regex.Split(teststring, "__");
```

(2023.8.10)

### 5.4 简单Logger设计

```C#
internal class Logger
{
    private static readonly string LOG_FORMAT = "{0} {1}：{2}";
    private static readonly string DATE_FORMAT = "yyyy/MM/dd HH:mm:ss";

    public static void info(string text)
    {
        string outputText = createOutputString("INFO", text);
        outputLog(outputText);
    }
    
    public static void debug(string text)
    {
        string outputText = createOutputString("DEBUG", text);
        outputLog(outputText);
    }

    public static void error(string text)
    {
        string outputText = createOutputString("ERROR", text);
        outputLog(outputText);
    }

    public static void exception(Exception ex)
    {
        string outputText = string.Format("{0}\n{1}\n{2}\n{3}\n{4}",
                                          "+++++++ ActivitySheetMaker Module ++++++++",
                                          "++++++++++++++++ ERROR +++++++++++++++++++",
                                          ex.Message,
                                          "++++++++++++++++ TRACE +++++++++++++++++++",
                                          ex.StackTrace);
        outputLog(outputText);
    }

    private static string createOutputString(string level, string text)
    {
        string outputText = string.Format(LOG_FORMAT,
                                          DateTime.Now.ToString(DATE_FORMAT),
                                          string.Format("{0, -6}", level),
                                          text);
        return outputText;
    }

    private static void outputLog(string text)
    {
        Console.WriteLine(text);
    }

}
```

将Console.WriteLine定向到字符串存储：

```C#
//Redirect Console.WriteLine to String
var sw = new StringWriter();
Console.SetOut(sw);
Console.SetError(sw);

try
{
    Action();
}
catch (Exception ex)
{
    Logger.exception(ex);
}

Log = sw.ToString();
```

(2023.2.19)
