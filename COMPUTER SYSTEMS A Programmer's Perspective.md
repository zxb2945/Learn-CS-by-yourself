# COMPUTER SYSTEMS A Programmer's Perspective

## 1 A Tour of Computer Systems

### 1.1 Information Is Bits + Context

> Files such as `hello.c` that consist exclusively of ASCII characters are known as **text files**.  All other files are known as **binary files**.

虽说 `hello.c` 归根到底也是二进制object，text files和binary files还是有给人读和给机器读的区分。

> The only thing that distinguishes different data objects is the context in which we view them. For example, in different contexts, the same sequence of bytes might represent an integer, floating-point number, character string, or machine instruction.

一个看待程序语言的重要观点。

### 1.2 Programs Are Translated by Other Programs into Different Forms

四个阶段：

1. Preprocessing phase
2. Compilation phase
3. Assembly phase
4. Linking phase

### 1.3 It Pays to Understand How Compilation System Work

### 1.4 Processors Read and Interpret Instructions Stored in Memory

#### 1.4.1 Hardware Organization of a System

#### 1.4.2 Running the `hello` Program

### 1.5 Caches Matter

### 1.6 Storage Devices Form a Hieraychy

### 1.7 The Operating System Manages the Hardware

#### 1.7.1 Processes

#### 1.7.2 Threads

#### 1.7.3 Virtual Memory

#### 1.7.4 Files

### 1.8 Systems Communicate with Other Systems Using Networks

### 1.9 Important Themes

#### 1.9.1 Amdahl's Law

> The main idea is that when we speed up one part of a system, the effect on the overall system performance depends on both how significant this part was and how much it sped up.

#### 1.9.2 Concurrency and Parallelism

1. Thread-Level Concurrency
2. Instruction-Level Parallelism
3. Single-Instruction, Multiple-Data(SIMD) Parallelism

#### 1.9.3 The Importance of Abstractions in Computer Systems

> On the processor side, the **instruction set architecture** provides an abstraction of the actual processor hardware. On the OS side, we have introduced **three** abstractions: files as an abstraction of I/O devices, virtual memory as an abstraction of program memory, and processes as an abstraction of a running program.

### 1.10 Summary



## 2 Representing and Manipulating Information

核心就是建立在Two-valued signals的integer和floating-pointer数据类型。

### 2.1 Information Storage

> Although the C compiler maintains this type information, the actual machine-level program it generates has no information about data types.

理解这点很重要，采用不同的格式%c，%d打印，同一串二进制就会表现为不同的数据。

#### 2.1.1 Hexadecimal Notation

#### 2.1.2 Data Sizes

> Even when compiled for 64-bit systems, data type int is usually just 4 bytes. Data type long commonly has 4 bytes in 32-bit programs and 8 bytes in 64-bit programs.

32bit和64bit machine的数据类型字节数略有不同确实是C语言设计时的历史遗留问题，所以之后版本中是有改进的。（即便是C也是有version evolution的）

> ISO C99 introduced a class of data types where the data sizes are fixed regardless of compiler and machine settings. Among these are data types int32_t and int64_t, having exactly 4 and 8 bytes.

GCC编译默认是C语言最早的GNU 89 version，如果要编译ISO C99 version，之后需要加参数`-std=c99`.

> many programmers historically assumed that an object declared as type int could be used to store a pointer. This work for most 32-bit machine, but it leads to problems for 64-bit programs.

也就是说，指针字节长度是由machine基本单位位数决定的，而不受指向数据的类型的影响。

#### 2.1.3 Addressing and Byte Ordering

> Most Intel-compatible machines operate exclusively in little-endian mode. On the other hand, most machines fron IBM operate in big-endian mode.
>
> ARM microprocessors, used in many cell phones, have the hardware that can either little-or-big-endian, but the most common OS for these chips--Android and IOS--operate only in little-endian mode.

 little-or-big-endian不是针对一个byte中bit位序而言！！（想想位操作时第一个bit位表示正负，能反过来吗！）。

在C语言中除了8位的char型之外，还有32位的int型等，对于位数大于8位的CPU，例如32位或者64位的CPU，由于寄存器宽度大于一个字节，那么必然存在着如何将多个字节安排的问题。因此就导致了大端存储模式和小端存储模式。

主流芯片都是反常识（所谓反常识，其实就如同逆鳞而行，局部顺序不同于整体顺序）的 little--endian。比如12345十六进制为0x00003039，它在Intel IA32 processor以及x86-64中储存形式均为 39 30 00 00. 

事实上，用怎样的规则存放，就用怎样的规则转换数据类型，我们不会特意用指针去操作一个int数据中的byte位，所以无论大端小端，C编码层面上一般不受影响。

> The two formats--floating-point and the integer data--use defferent encoding schemes.

算是常识，即两者表达同一个numeric value 12345，存放的byte patterns完全不同。

#### 2.1.4 Representing Strings

#### 2.1.5 Representing Code

#### 2.1.6 Introduction to Boolean Algebra

> Computer generate color pictures on a vedio screen by mixing three colors: red, green, and blue.

#### 2.1.7 Bit-Level Operations in C

> One common use of bit-level operation is to implement masking operations.

#### 2.1.8 Logical operations in C

#### 2.1.9 Shift operations in C

> 【问题描述】在写嵌入式的程序中，常会将数据定义为unsigned int，这样定义有什么好处呢？下面从逻辑右移和算术右移的角度进行分析。
>
> 【分析】
>
> 1 逻辑右移和算术右移
>
> 逻辑右移，移走的位填充为0；算术右移，移走的位填充与符号位有关，例如如果为负数，则移走的位填充为1。
>
> 2 unsigned int 和 int
>
> C语言的标准指出，无符号数执行的所有移位操作都是逻辑的，而对于有符号数，采用哪种方式取决于编译器。算术左移和逻辑左移是相同的，而算术右移和逻辑右移，取决于符号位。因此，一个程序如果使用了有符号数，是不可移植的。嵌入式的程序通常采用交叉编译开发，如果定义为有符号的，就无法保证右移操作能跨平台使用，这就是为什么用unsigned int，而不用int的主要原因。
> ————————————————
> 版权声明：本文为CSDN博主「tandesir」的原创文章，遵循CC 4.0 BY文链接：https://blog.csdn.net/tandesir/article/details/7385955

左移无所谓logical或arithmetic，右移则要注意。

> In contrast to C, JAVA has a precise definition of how right shifts should be performed.

### 2.2 Integer Representations

#### 2.2.1 Integral Data Type

> We have seen that some C data types, especially long, have different ranges on different machines.

主要是 `long`型数据在32/64bit machine 中不同。

> Java only supports only signed numbers.

#### 2.2.2 Unsigned Encodings

#### 2.2.3 Two's-Complement Encodings

> When the sign bit is set to 1, the represented value is negative.

```
0111 + 0001 = 1000
7    +    1 = -8
最大极反转，可以看到 sign bit 不是仅表示正负，它表示一个负的最大值
```

其实在最初接触C语言时，就思考过这个问题，要把Two's-Complement Encodings类比成像时钟那样的闭环去理解。

#### 2.2.4 Conversions between Signed and Unsigned

> Casting from signed to unsined changed the nemeric value, but not the bit representation.

编译器cast时，比较从简，要么截断，要么原封不动搬运bit。(细节详见2.2.7)

#### 2.2.5 Signed versus Unsigned in C

> Adding character 'U' or 'u' as a suffix creates an unsigned constant; For example, 12345U or 0x1A2Bu.

第二章就是深入C语言细节。

C的原则就是：The underlying bit representation does not change, the numeric vlaue changed by data type.

#### 2.2.6 Expanding the Bit Representation of a Number

> Converting from a smaller to a larger data type, however, should always be possible.
>
> PRINCIPE:
>
> 1. Expansion of an unsigned number by zero extension;
> 2. Expansion of a two's-complement number by sign extension;

对于第二条原则的解释，也就是说，对于`short`类型负数，转化为`int`类型，多出来的bit位全部填充sign bit即1，而不是0. 

对于coder而言，底层的各种细节就是为了支持表层的逻辑自洽。

#### 2.2.7 Truncating Numbers

1.长转短（一般避免），直接截断；

2.中转中，原封不动搬bit；

3.短转长，根据情况填补0或者1。

综合上述，其实就怎么简单粗暴怎么来，另一方面，对于正常编码来说，原则避免casting就行了。

#### 2.2.8 Advice on Signed versus Unsigned

> One way to avoid such bugs is to never use unsigned numbers. In fact, few languages other than C support unsigned integers.

### 2.3 Integer Arithmetic

#### 2.3.1 Unsigned Addition

> Some programming languages, such as Lisp, actually support arbitrary size arithmetic to allow integers of any size( within the memory limits of the computer, of course.)

#### 2.3.2 Two's-Complement Addition

讲对于fixed-size arithmetic, 加法导致边界上的overflow，各种算数式乃至图像，没get到...跳过

#### 2.3.3 Two's-Complement Negation

Negation-> 非，否定。

```
-x = ~x + 1    负数等于相应正数取反加一
```

#### 2.3.4 Unsigned Multiplication

#### 2.3.5 Two's-Complement Multiplication

不管计算机底层怎样去实现乘法计算，目的就是给表层以数学上的逻辑自洽。某种程度上，无需关心。

#### 2.3.6 Multiplying by Constants

> Historically, the integer multiply instruction on many machines was fairly slow, requiring 10 or more clock cycles, whereas other integer operations--such as addition, subtraction, bit-level operation, and shifting--required only 1 clock cycles.

> C compilers will try to optimize multiplition to the combinations of shifting, adding and substraction.

乘法编译时优化的原理在于，左移1bit，相当于乘2，被称为 Powers of 2.

#### 2.3.7 Dividing by Powers of 2

同理，除法比乘法更费时间，同样可以通过shifting来优化。

#### 2.3.8 Final Thoughts on Integer Arithmetic 

### 2.4 Floating Point

> A floating-point representation encodes rational numbers of the form V= a x 2^b. It's useful for performing computations involving very large numbers, numbers very close to 0, and more generally as an approximation to the real arithmetic.

浮点数表示很大的值是一方面，更关键在于其在小数点上的表现力。

#### 2.4.1 Fractional Binary Numbers

即分数在二进制中的表现形式，理解其为什么只能是一种近似值。

#### 2.4.2 IEEE Floating-Point Representation

以32位单精度浮点数为例，分成三部分：

第1个bit：表示正负，(-1)^0=1，0表示正数；

第2个bit到第9个bit：表示exponent，即指数的上标值，指数的上标值本身也有正负表示，但注意这里并没采用Two's-Complement Encodings，而是由其自定义的规则表示正负以及0与无穷大；

第10个bit到第32bit：因为科学计数法，1<1.xxx<2，所以这个1直接默认不表示了，从小数位后开始列陈。

#### 2.4.3 Example Numbers

#### 2.4.4 Rounding

> Floating-point arithmetic can only approximate real arithmetic.

因此有相应四舍五入上的规则，跳过。

#### 2.4.5 Floating-Point Operations

#### 2.4.6 Floating-Point in C

> When casting values between int and float formats, the program changes the bit representations.

`int` cast 到 `float` 是要变bit位的，这跟整数型互转就本质不同，而且有可能被四舍五入，因为不得不表示为科学计数法，变成小数形式嘛。

### 2.5 Summary

> Different encodings are used for representing integers, real numbers, and characterstrings.
>
> Understanding these encodings at the bit-level, as well as understanding the mathematical characteristics of the arithmetic operations, is important for writing programs.



## 3 Machine-Level Representation of Programs

与编译原理相较，本章更侧重于结果是什么，而不是过程

> With modern optimizing compilers,even change recursive computations into iterative ones.
>
> GCC and Linux
>
> the problem of out-of-bounds memory and buffer overflow attacks.

### 3.1 A Historical Perspective

> A CPU history from 8086 ,Pentium to Core i7.
>
> designed to be backward compatible
>
> Moore's Law about semiconductor

### 3.2 Program Encodings 

the C preprocessor -> compiler -> assembler ->linker

#### 3.2.1 Machine-Level Code

> ISA: Instruction Set Architecture, such as x86、ARM v8、MIPS

指令集决定CPU架构，进而决定汇编语言，可以推想到博通的微码对应的是不同于Haswell的芯片架构

> the program memory is addressed using virtual addresses

理解这一点很重要，比如堆栈之间的地址在哪里，因为不连续所以不重要

#### 3.2.2 Code Example

#### 3.2.3 Notes on Formatting

> AT&T or Intel assembly-code formats

### 3.3 Data Formats

> Combining assembly code with C programs

### 3.4 Accessing Information

细到registers bit位的赋值的汇编语言语法说明

#### 3.4.1 Operand Specifiers

#### 3.4.2 Data Movement Instructions

#### 3.4.3 Data Movement Example

介绍了不同类型指针间的赋值转化

> The C operator '*' performs pointer dereferencing, and '&' creates a pointer.

脱落与创造，与中文教科书截然相反的说明

#### 3.4.4 Pushing and Popping Stack Data

> stack: a "last-in, first-out" discipline

### 3.5 Arithmetic and Logical Operations

明白了，说明C中各个运算符在汇编层面的实现

#### 3.5.1 Load Effective Address

```
leaq S,D     D <- &S
leaq 9(%rdx), %rax   #把9(%rdx)这个值所在的地址赋给%rax
```

#### 3.5.2 Unary and Binary Operations

单目和双目运算符

#### 3.5.3 Shift Operations

#### 3.5.4 Discussion

> Only right shifting requires instructions that differentiate between signed versus unsigned data.

#### 3.5.5 Special Arithmetic Operations

### 3.6 Control

> Some constructions in C, such as conditionals, loops, and switches, require conditional execution.
>
> The condition code can be altered with a jump instruction.

#### 3.6.1 Condition Codes

```
cmp S1,S2
test S1,S2
```

#### 3.6.2 Accessing the Condition Codes

cmp与test都可与set配合来完成Condition Codes。

#### 3.6.3 Jump Instructions

```
jmp Label
```

#### 3.6.4 Jump instruction Encodings

#### 3.6.5 Implementing Conditional Branches with Conditional Control

任何if/else 都可以用 goto来实现，后者更贴近汇编jmp是如何实现的

#### 3.6.6 implementing  Conditional Branches with Conditional Move

编译器会对分支进行预测而优化汇编代码，但一旦预测错误，反而会更慢。因此，还有另一种汇编层面的分支处理策略，就是利用cmov而不是jmp，即对两个路径均计算，最后比较选取其中一个。

#### 3.6.7 Loops

> No loops corresponding instructions exist in machine code.

while和for在machine code层面是一样的，均由test和jump来实现。

#### 3.6.8 Switch Statements

switch不仅使C语言更readable，而且在machine code层面更为efficient，jump table可以看成array，等效于“goto *jt[index]”。

### 3.7 Procedures

> first describing control, then data passing, and, finally, memory management.

#### 3.7.1 The Run-Time Stack

函数调用进出栈

> Indeed, many functions do not even require a stack frame. This occurs when all of the local variables can be held in registers and the function does not call any other functions.

#### 3.7.2 Control Transfer

```
call Label
ret
```

汇编语言中有详细说明，具体是操作两个寄存器，完成类似跳转的作用

#### 3.7.3 Data Transfer

> With x86-64, most of these data passing to and from procedures take place via registers.
>
> When  a function has more than six integal arguments, the other ones are passed on the stack.

#### 3.7.4 Local Storage on the Stack

当进入一个函数，编译器会自上而下check一遍Function所有Local Data初始化需要多少空间，一次性allocate，所以Array[i]初始化就会报错（不初始化的话编译可以通过）。

#### 3.7.5 Local Storage in Registers

高阶函数中，防止寄存器overwrite等问题，规定了某些register的固定用法。比如说%rax用来return，但return中还有别的计算时，它就先会传递至给%rbx暂时保存。

#### 3.7.6 Recursive Procedures

recursive function就像不断调用其它函数一样，会消耗栈资源，但不会产生悖论。这也是procedure中recursive可行的根本原因。甚至对于简单的递归函数，只需要寄存器互相反复传递value就能完成递归，不需要消耗栈资源。

### 3.8 Array Allocation and Access

#### 3.8.1 Basic Principles

```
E[i]
the address of E is stored in %rdx
i is stored in %rcx
movl (%rdx, %rcx, 4), %eax   =>  %eax=%rdx+4*%rcx
4是由type决定的值。
这也是a[i][j]中*(a+i)与*(a[0]+i)不同在machine code上的原因。
```

#### 3.8.2 Pointer Arithmetic

#### 3.8.3 Nested Array

```
int A[5][3]
is equivalent to the declaration
typedef int row3_t[3];
row3_t A[5];
row3_t is defined to be an array of three integers
A can also be viewed as a two-demensional array with 5 rows and 3 colums
```

#### 3.8.4 Fixed-Size Arrays

#### 3.8.5 Variable-Size Arrays

C没法定义可变长的数组，除非通过定义一个如下的构造函数

```
int var_ele(long n, int A[n][n], long i, long j){
	return A[i][j];
}
```

### 3.9 Heterogeneous Data Structures

#### 3.9.1 Structure

> C could represent an object as a struct.

感觉 p-> item 像C为structure做的一个语法糖

#### 3.9.2 Unions

#### 3.9.3 Data Alignment

> The x86-64 hardware will work correctly regardless of the alignment of data. However, Intel recommends that data be aligned to improve memory system peformance.

### 3.10 Combining Control and dangData in Machine-Level Programs

#### 3.10.1 Understanding Pointers

> Pointers are a central feature of the C programming language.

#### 3.10.2 Life in the Real World: Using the GDB Debugger

#### 3.10.3 Out-of-Bounds Memory References and Buffer Overflow

GDB可以打印寄存器 info registers

> Using such as gets, strcpy, strcat, sprintf, or any function that can overflow storage is considered a bad programming practice.

通过阅读gets的代码可以看到，它无视调用它的函数为形参分配的地址空间，可以一直读入造成踩内存。尽管一般来说，编译器会让上层函数多allocate大概16bytes作为buffer和return之间的Unused atack space。但不足以消除这个隐患。 

#### 3.10.4 Thwarting Buffer Overflow Attacks

> Worm(can run by itself) and virus(adds itself to other programs)

因为buffer overflow是最常见通过网络攻击计算机的方法，所以操作系统或编译器会通过Stack randomization（防止黑客预测），Stack Corruption Detection（在特定寄存器周围设置余裕空间，踩到就报错），Limiting Executable Code Regions(separating the read and execute access modes)来防止此类攻击。

#### 3.10.5 Supporting Variable-Size Stack Frames

> All the functions have the property that the compiler can determine an advance the amount of space that must be allocated for their stack frames.

这句话意思是函数栈提前allocate多少在编译时已经确定好了，而不是运行时确定的。但是x86-64利用一个frame pointer提供了一种可变方案，使特定函数（如下）的栈大小不会对其它函数产生影响。（具体细节没看懂...)

```
long vframe(long n, long idx, long *q){
	long i;
	long *p[n];
	p[0] = &i;
	for(i=1, i<n, i++)
		p[i]=q;
	return *p[idx];
}
```

### 3.11 Floating-Point Code

#### 3.11.1 Floating-Point Movement and Conversion Operations

简而言之，浮点数操作各种汇编层面的operand都是与其它的不一样，寄存器似乎也不一样。

#### 3.11.2 Floating-Point Code in Procedures

#### 3.11.3 Floating-Point Arithmetic Operations

#### 3.11.4 Defining and Using Floating-Point Constants

浮点数常量像字符串一样有专门的Lable+地址，与整数型不一样。

#### 3.11.5 Using Bitwise Operations in Floating-Point Code

#### 3.11.6 Floating-Point Comparision Opeerations

#### 3.11.7 Observation about Floating-Point Code

### 3.12 Summary  



## 4 Processor Architecture

### 4.1 The Y86-64 Instruction Set Architecture

#### 4.1.1 Programmer-Visible State

从x86-64简化而来的ISA。

> The program counter (PC) holds the address of the instruction currently being executed.

Y86-64 ISA由15个Program registers, 3个single-bit的conditons codes(CC),PC,一个status code Stat和Memory五部分组成。

#### 4.1.2 Y86-64 Instructions

mov,jmp等就是instruction，合起来就是instruction set。

汇编语言由ISA决定，ATT只是一种assembly-code format,表现形式而已

> Instruction encodings range between 1 and 10 bytes.An instruction consists of a 1-byte instruction specifier,possibly a 1-byte register specifier,and possibly an 8-byte constant word.

Instruction encodings可以理解为机器码，1-byte register specifier最多可以表示两个4-bit的寄存器标识符，而余下8-byte可以表示一个地址，因而可以mov地址到寄存器，但不能mov地址到地址。

#### 4.1.3 Instruction Encoding

> The program registers are stored within the CPU in a register file, a small random access memory where the register IDs serve as address.

意思指寄存器本质上也是RAM？

> RISC processors have done very well in the market for embedded processors.

x86-64的演化源CISC比ARM的演化源RISC更为历史悠久，后者更为简洁。

#### 4.1.4 Y86-64 Exceptions

> The status code Stat describes the overall state of the executing program. The processor will halt for any code other than Normal operation.

#### 4.1.5 Y86-64 Programs

讲同一段C程序，x86-64与Y86-64的汇编语言区别。

#### 4.1.6 Some Y86-64 Instruction Details

### 4.2 Logic Design and the Hardware Control Language HCL

> Three major components are required to implement a digital system: combinational logic to compute functions on the bits, memory elements to store bits, and clock signals to regulate the updating of the memory elements.

难怪可以作为《计算机组成与原理》的教材

#### 4.2.1 Logic Gates

#### 4.2.2 Combinational Circuits and HCL Boolean Expressions

> Logical expressions in C have the property that they might only be partially evaluated. For example:

```
(a && !a) && fun(b,c)
```

#### 4.2.3 Word-Level Combinational Circuits and HCL Integer Expressions

> The output of the combinational circuits that tests whether two 64-bit words A and B are equal will equal 1 if and only if each bit of A and B are equal.  The outputs of these single-bit circuits are combined with an AND gate to form the circuit output.

千里之堤，累于毫末

> One important combinational circuit, known as an arithmetic/logic unit(ALU), perform one of four different arithmetic and logical operations : X+Y, X-Y, X&Y,X^Y. 

#### 4.2.4 Set Membership

#### 4.2.5 Memory and Clocking

> Our Y86-64 processors will use clocked registers to hold the program counter(PC),the condition code(CC) and the program status(Stat). directly connected to the rest of the circuit by its input and output wires.

> When necessary to avoid ambiguity ,we will call the two registers "hardware registers" and "program registers".

> The register file is not a combinational circuit, since it has internal storage. 

联系上下文，PC,CC,STAT等应该是属于hardware registers，与其它常规寄存器区别开来。

### 4.3 Sequential Y86-64 Implementations

> Our purpose in developing SEQ is to provide a first step toward our ultimate goal of implementing an efficient pipelined processor.

#### 4.3.1 Organizing Processing into Stages

一条指令执行步骤详解。

| Stage      | Discription                                                  |
| ---------- | ------------------------------------------------------------ |
| Fetch      | read instruction from memory, using  PC as the memory address. |
| Decode     | read up to 2 operands from the register file.                |
| Excute     | operate the ALU to compute memory address or the stack pointer by instruction. |
| Memory     | write or read data from memory.                              |
| Write back | write up to results to the register file.                    |
| PC update  | set PC to the address of the next instruction.               |

#### 4.3.2 SEQ Hardware Structure

> Our implementation of SEQ consists of combinational logic and two forms of memory devices: clocked registers(the program conuter and condition code register) and random access memories(the register file, the instrction memory, and the data memory).

#### 4.3.3 SEQ Timing

> In SEQ , all of the processing by the hardware units occurs within a single clock cycle.

#### 4.3.4 SEQ Stage Implementations

深挖至一个Register file的详解图。

### 4.4 General Principles of Pipelining

应该可以翻译成流水线吧，这就解释了编译器预测分支失败反而会大大浪费时间。

#### 4.4.1 Computational Pipelines

粗略大概估算，若分成n个步骤，那么Pipelines下的运行效率就可以提高n倍。

#### 4.4.2 A Detailed Look at Pipeline Operation

#### 4.4.3 Limitations of Pipelining

#### 4.4.4 Pipelining a System with Feedback

### 4.5 Pipelined Y86-64 Implementations

#### 4.5.1 SEQ+: Rearranging the Computation Stages

把PC update stage提到最前面。

#### 4.5.2 Inserting Pipeline Registers

insert extra register into every stage.

#### 4.5.3 Rearranging and Relabeling Signals

#### 4.5.4 Next PC Prediction

> If the fetched instruction is a conditional branch, we will not know whether or not the branch should be taken until several cycles later, after the instruction has passed through the execute stage.

因为branch prediction strategies 的不同，可以推测不同程序在不同CPU上运行表现不同。

#### 4.5.5 Pipeline Hazards

> Avoiding Data Hazards by Stalling: dynamically insert a nop instructions.

> Avoiding Data Hazards by Forwarding.

大概是提前拿来用？需要额外的硬件支持吧。

> Avoiding Control Hazards: the pipeline can cancel the misfetched instructions by injuecting bubbles into decode and execute stages on the following cycle while also fetching the instrcution fllowing the jump instruction.

我的理解是提供了一个架构，当意识到进入错误分支时，可以紧接着输入一定数量的nop指令去取消之前进入的指令。

#### 4.5.6 Exception Handling

> external exceptions, such as when the processor receives a signal that the network interface has received a new packet or the user has clicked a mouse button. We must determine the processor should report to the operating system.

#### 4.5.7 PIPE Stage Implementation

#### 4.5.8 Pipeline Control Logic

#### 4.5.9 Performance Analysis

> We have developed models of our Y86-64 processor designs in the Verilog hardware description language. We have been able to make the HDL onto field-programmable gate array(FPGA) hardware, and run the processors on actual programs.

#### 4.5.10 Unfinished Business

> In a medium-performance processor such as PIPE, typical execution times for these operations range from 3 or 4 cycles for floating-point addition up to 64 cycles for integer division.

除法计算特别费时间。

### 4.6 Summary



## 5 Optmizing Program Performance

相比算法与数据结构对程序效率的影响，适配编译器优化就不在一个量级吧。

### 5.1 Capabilities and Limitations of Optmizing Complier

> For example, invoking GCC with the command-line option -Og (Optimization general) specifies that it should apply a basic set of optimizations. Invoking  GCC with option -O1 or higher (e.g. -O2 or -O3) will cause it to more extensive optimizations.

讲述了一些优化上的逻辑困难：比如说纯函数与非纯函数（return值受全局变量影响），编译器无法区分。

### 5.2 Expressing Program Performance

介绍了一个性能指标单位CPE。

### 5.3 Program Example

"-O1" 效率上有时可以优化至一倍，展示了编译器优化能力。

### 5.4 Eliminating Loop Inefficiencies

```
void lower1(char *s)
{
	long i;
	
	for(i=0;i<strlen(s);i++)
		if(s[i]>='A' && s[i]<='Z')
			s[i]-=('A'-'a')
}

void lower2(char *s)
{
	long i;
	long len=strlen(s);
	
	for(i=0;i<len;i++)
		if(s[i]>='A' && s[i]<='Z')
			s[i]-=('A'-'a')
}
```

上例中，因为编译器没法辨别strlen是否为纯函数，所以没法把lower2优化为lower1，随着字符串长度增长，其运行效率相差很大。So programmers must do such transformations themselves.

### 5.5 Reducing Procedure calls

简单来说，指尽量把loop中的函数调用移到loop外去。

### 5.6 Eliminating Unneeded Memory References

在loop中尽量少用指针，即消除多余地址参照。因为指针相对于变量在汇编层面重复了memory到register的交互过程。

> Unfortunately, a compiler cannot make a judegement about the conditions under which a function might be used and what the programmer's intentions might be. So the conservative approach is to keep reading and writing memory, even though this is less efficient.

简直有点手把手教你写代码了...

### 5.7 Understanding Modern Processors

> Up to this point, we have applied optimizations that did not rely on any features of machine. As we seek to push the performance further,  we must consider optimizations that exploit the microarchitecture of the processor.

#### 5.7.1 Overall Operation

介绍到 Instrution-level Parallelism 的物理构成实现上...

#### 5.7.2 Functional Unit Performance

Instrution-level Parallelism 好像用于花费多个clock cycle的计算，比如Division，对Addition没什么影响吧？

#### 5.7.3 An Abstract Model of Processor Operation

略复杂...

### 5.8 Loop Unrolling

> That is, the loop index i is incremented by 2 or more on each iteration.

有必要至此吗...`gcc -O3`会利用Loop Unrolling来优化。

### 5.9 Enhancing Parallelism

#### 5.9.1 Multiple Accumulators

先举例单偶各加的Loop Unrolling，即2x2 unrolling，可以平行处理。

尽可能得利用Pipeline。

#### 5.9.2 Reassociation Transformation

兴趣阑珊，编译器做的事。

### 5.10 Summary of Results for Optimizing Combining Code

10x10 unrolling 策略可以比 -O1 优化效率提高十倍左右。

### 5.11 Some Limiting Factors

#### 5.11.1 Register Spilling

寄存器数量会限制 Loop Parallelism，多出的会压入stack。

#### 5.11.2 Branch Prediction and Misprediction Penalties

### 5.12 Understanting Memory Performance

> All modern processors contain one or more cache memories to provide fast access to such small amounts of memory.

#### 5.12.1 Load Performance

#### 5.12.2 Store Performance

> writes a register value to memory.

这几章草草浏览，简直是锱铢必较得提高效率，量级上不是算法那种质变，如同“内卷”。

### 5.13 Life in the Real World: Performance Improvement Techniques

> High-level design: Choose appropriate algorithms and data structures for the problem at hand.
>
> Basic-level principles: Avoid optimization blockers so that a compiler can generate efficient code.
>
> ​	Eliminate excessive function calls. Move computations out of the loop when possible.
>
> ​	Eliminate unnecessary references, introduce temporary variables to hold intermediate results.
>
> Low-level optimizations: Structure code to take advantage of the hardware capabilities.

Low-level optimizations一般来说不考虑，看了也是屠龙之技。

### 5.14 Identifying and Eliminating Performance  Bottlenecks

#### 5.14.1 Program Profiling

```
gcc -Og -pg prog.c -o prog  #利用-pg 可以使程序运行时产生一个各个函数运行时间的分析文档
```

#### 5.14.2 Using a Profiler to Guide Optmization

### 5.15 Summary



## 6 The Memory Hierarchy

### 6.1 Storage Technologies

#### 6.1.1 Random Access Memory

> RAM comes in two varieties - static and dynamic. SRAM is faster and more expensive than DRAM, It's used for cache memories. DRAM is used for the main memory plus the frame buffer of a graphics system.

微观结构上，SRAM每个bit上有6个transistors，所以比每个bit 1个transistor的DRAM更稳定更快，因而也更贵。而DRAM相较SRAM更容易受干扰，没法像SRAM那样自动恢复，所以需要内存系统需要定期refresh DRAM。也是因此DRAM更显得dynamic.

> SDRAM: Synchronous DRAM
>
> DDR SDRAM: Double Data-Rate SDRAM
>
> By 2010, most servers and desktop systems were built with DDR3 SDRAMs.

SRAM和DRAM都属于volatile memory，像PC的BIOS( basic input/output system)就需要放在nonvolatile memory，就是ROMs: read-only memories。

> PROM: programmable ROM, it can be programmed exactly once.
>
> EPROM: erasable PROM, it can be reprogrammed 1000 times.
>
> EEPROM: electrically EPROM, it can be reprogrammed 10^5 times.
>
> Flash memory is based on EEPROMs.
>
> SSD: solid state disk, it's based on Flash memory.

某种程度上说，固态硬盘源于ROM，所以它读写次数有上限，但这个上限够用几百年，所以无所谓。

#### 6.1.2 Disk Storage

> Rotating disks: magnetic recording material.

磁盘读写速度是SRAM的4万倍，DRAM的2500倍。

> Before a disk can be used to store data, it must be formatted by the disk controller.

这一章就有种《计算机组成与原理》的感觉了...

> Unlike the system and memory buses, which are CPU-specific, I/O buses are independent of the underlying CPU. Although it is slower, it can accommodate a wide variety of third-party I/O devices, such as graphics adapter, USB(Universal Serial Bus ) controller, Disk controller, network adapter.

三种buses汇聚在I/O bridge，此节点用来转换电子信号。内存和磁盘间直接通过DMA(Direct Memory Access)来进行通信，DMA不是一个的硬件设备，而是内存与磁盘独立于CPU的一个逻辑处理。

#### 6.1.3 Solid State Disks

#### 6.1.4 Storage Technology

### 6.2 Locality

The principle of locality: 经常访问的数据应当能被更快得访问到。

#### 6.2.1 Locality of References to Program Data

Temporal locality: 被引用过一次的存储器位置在未来会被多次引用（通常在Loop中）。

Spatial locality: 如果一个存储器被引用，那么将来它附近的位置也会被引用。

```
int sumarrayrows(int a[M][N])
{
	int i,j,sum=0;
	for(i=0;i<M;i++)
		for(j=0;j<N;j++)
		sum += a[i][j]
	return sum;
}
```

上例中，sum在每个loop中都被访问，所以它有好的temporal locality，而`a[i][j]`整个loop中只被访问一次，所以是poor temporal locality，但另一方面它的数据相邻，有好的spatial locality，所以整体而言上例有好的locality，但如果将两个loop换个顺序，它的spatial locality就变得poor了。

#### 6.2.2 Locality of Instruction Fetches

#### 6.2.3 Summary of Locality

Locality跟Cache密切相关。

### 6.3 The Memory Hierarchy

|      |                          |                          |
| ---- | ------------------------ | ------------------------ |
| L0   | Registers                |                          |
| L1   | Cache                    | SRAM                     |
| L2   | Cache                    | SRAM                     |
| L3   | Cache                    | SRAM                     |
| L4   | Main memory              | DRAM                     |
| L5   | Local secondary storage  | local disks              |
| L6   | Remote secondary storage | distributed file systems |

#### 6.3.1 Caching in the Memory Hierarchy

这里的Cache更多指广义的层级间的设计模式，比如L6就是L5的Cache。

#### 6.3.1 Summary of Memory Hierarchy Concepts

### 6.4 Cache Memories

#### 6.4.1 Generic Cache Memory Organization

#### 6.4.2 Direct-Mapped Caches

#### 6.4.3 Set Associative Caches

#### 6.4.4 Fully Associative Caches

#### 6.4.5 Issues with Writes

#### 6.4.6 Anatomy of a Real Cache Hierarchy

#### 6.4.7 Performance Impact of Cache Parameters

### 6.5 Writing Cache-Friendly Code

> Repeated references to local variables are good because the compiler can cache them in the register file(temporal locality);
>
> Stride-1 references patterns are good because caches at all levels of the memory hierarchy store data as contiguous blocks(spatial locality).

简而言之: 1.少用指针；2.访问数组要row by row, 而不是column by column。

### 6.6 Putting It Together: The Impact of Caches on Program Performance

#### 6.6.1 The Memory Mountain

> So even when a program has poor temporal locality, spatial locality can still come to the rescue and make a significant difference.

换句话说，有时候即便去内存中读取一块连续数据(poor temporal locality)也要比从缓存中读取不连续数据(poor spatial locality)来得快。两者表示横竖轴，读取速度表示纵轴，就形成一座三维的山丘。

#### 6.6.2 Rearranging Loops to Increase Spatial Locality

#### 6.6.3 Exploiting Locality in Your Programs

### 6.7 Summary



## 7 Linking

### 7.1  Compiler Drivers

> The GNU compilation system provide a compiler driver -- GCC that invokes the language preprocessor -- cpp, compiler -- cc1, assembler -- as, and linker -- ld, as needed on behalf of the user.

确切说，GCC是一个Compiler Deiver, 而cc1才是compiler。

> To run the executable prog, we type its name on the Linux shell's command line: ./prog  
>
> The shell invokes a code in the OS called the loader, which copies the code and data in the executable file into memory, and then transfers control to the beginning of the program.

所以执行程序是由一个shell通过调用OS的loader函数来完成的，这个shell就是“执行器”。

### 7.2 Static Linking

> The two main tasks of the linker:
>
> 1. Symbol resolution : to associate each symbol reference with exactly one symbol definition.
>
> 2. Relocation

### 7.3 Object Files

> 1. Relocatable object file;
>
> 2. Ececutable object file;
>
> 3. Shared object file;
>
> Modern x86-64 Linux systems use Executable and Linkable Format (ELF)

### 7.4 Relocatable Object Files

> .bss is ab abbreviation for "Better Save Space"

ELF文件中的.bss 与 .data 数据段的区别在于 其存放 uninitialized global and static C variables, 为什么要做这种区分呢？是为了节省文件空间，即.bss在磁盘上不占任何实际空间，只在文件头里（ELF header）有一个placeholder，程序载入时才分配内存空间。（否则最简洁的话，只要.text和.data就足够逻辑区分了）

### 7.5 Symbols and Symbol Tables

ELF文件中的.symtab段存储functions和global variables的相关信息（注意不是变量自身，要与.data区分）。

> In C, source files play the role of modules. 

在C中，凡是被static修饰的functions和global variables可以被看作是该模块private，不被static修饰的则为public。（联系C++ 和 JAVA）

但当某模块引用其它模块的public变量时，需extern声明（单个），或者include包含其声明的头文件，否则gcc编译器一般会报“warning: implicit declaration ”的警告。

（另一方面，而define定义只在该模块内有效。）

对一个具体的module而言，存在三种Symbols:

1. 本模块内的Global symbols;
2. 别的模块里所定义的Global symbols；
3. 本模块内的Static symbols.

以上三种会被记录在.symtab中，不同模块的stacic symbol可以同名，编译器隐式地会在.symtab中作区分。而该模块中的local nonstatic variables不被包括，它们跟Linker就没什么关系。

### 7.6 Symbol Resolution

未定义的全局变量到链接阶段才会报错；

> Overloaded functions in C++ work because the compiler encodes each unique method and parameter list combination into a unique name for the linker.

#### 7.6.1 How Linkers Resolve Duplicate Symbol Names

> Strong symbols: Functions and initialized global variables.
>
> Weak sumbols: Uninitialized global variables.
>
> Rule1: Muitiple strong symbols with the same name are not allowed;
>
> Rule2: Given a strong symbol and multiple weak symbols with the same name, choose the strong symbol;
>
> Rule3: Given muitiple weak symbols with the same name, choose any of the weak symbols.

因为如上规则的存在，若遇到多个同名uninitialized global variables，编译器会将其放在COMMON段，而不是.bss段，如果Global variables有被初始化为0，则继续放在.bss段。而Static variables对同名无所谓，未初始化仍可继续放在.bss段。

#### 7.6.2 Linking with Static Libraries

> ISO C99 defines an extensive collection of standard I/O, string manipulation, and integer math funtions in the **libc.a** library. And also defines an extensive collection of floating-point math functions in the **libm.a** library.
>
> In fact, C compiler drivers always pass **libc.a** to the linker, it is unnecessary for gcc to mention it.

`.a`文件可以看成一个可分解为多个`.o`文件的集合，一般程序只链接其中一部分`.o`文件即可，若将其编译成一个`.o`文件，则连未被参照的部分也需被链接，造成链接时间和磁盘空间两方面的浪费。

#### 7.6.3 How Linkers Use Static Libraries to Resolve References

> The general rule for libraries is to place them at the end of the command line.

```
gcc foo.c libx.a libz.a
```

否则，Linker因为链接时scan顺序的关系，造成foo.c中的reference无法匹配到libx.a中的defination。

### 7.7 Relocation

两个层面：1.将各个`.o`文件按各数据段合并；2.Relocating symbol references within sections.

#### 7.7.1 Relocation Entries

#### 7.7.2 Relocating Symbol References

> Relocating PC-Relative References
>
> Relocating Absolute References

### 7.8 Executable Object Files

> Read-only memory segment: code segment
>
> Read/Write memory segment: data segment
>
> Symbol table and debugging info: not loaded into memory

### 7.9 Loading Executable Object Files

> When the shell runs a program, the parent shell process forks a child process that is a duplicate of the parent. The child process invokes the loader via the `execve` syetem call. The loader deletes the child's existing virtual memory segments and creates a new set of code, data, heap, and stack segments.

| Kernel Memory                                 |
| --------------------------------------------- |
| User stack                                    |
|                                               |
| **Memory-mapped region for shared libraries** |
|                                               |
| Run-time heap                                 |
| Read-only memory segment                      |
| Read/Write memory segment                     |
| **0地址**                                     |

### 7.10 Dydamic Linking with Shared Libraries

对于Shared Libraries而言，首先在Link阶段，它将Relocation and symbol table info编入Relocatable object file组成Partially linked executable object file, 然后在Load阶段，将Code and data部分通过Dynamic linker载入到Fully linked executable in memory。

### 7.11 Loading and Linking Shared Libraries from Applications

> Linux systems provide  simple interfaces ` dlopen` and `dlclose`  to the dynamic linker that allows applications to load and link shared libraries **at run time**.

High-performance Web severs就用到这个技术直接调用相关函数，而不是去fork and execve一个子进程；

还有从JAVA调用C/C++ functions时，可以将后者打包成一个Shared Libraries，通过`dlopen`接口去调用, 即JNI技术。

### 7.12 Positon-Independent Code(PIC)

GCC中链接Shared Libraries时的`-fPIC`选项代表了PIC，任何Shared Libraries在各个进程中装载时（参见7.9 Memory-mapped region for shared libraries的位置，共享库无论是数据部分还是代码部分都不嵌入到可执行文件的相应段中） ，code部分是共享的，而data部分是各自独立的。

一般来说，模块内的code部分和data部分的相对地址是固定的，天然就可以做到绝对地址无关。但是不同模块之间，尤其是共享库之间code部分中的全局变量访问以及函数调用，就要借用GOT表做地址无关，即将code部分中的绝对地址引用放到data部分的GOT表（增加了一个跳转层），从而每个进程就可以通过独立的GOT表对共享库进行访问，从而共享库可以在载入时不用顾忌各个进程之间的引用冲突。

进一步，为了减少程序启动时，进程对共享库函数调用GOT表构造所花费的时间（共享库中全局变量耦合度原因数量其实很少，对启动时间影响不大），又为函数调用增加了一个跳转层PLT--Lazy Binding，实现调用时再构造GOT表，从而减少程序启动时间。

### 7.13 Libraries Interpositioning

这是项什么技术呢？举例来说，你原有程序中调用Libraries中的malloc函数，你可以通过手动写的mymalloc来包裹它并代替它被调用，包裹层里你就可以加trace等信息来追踪malloc调用情况。（有点类似Python装饰器）

#### 7.13.1 Compile-Time Interpositioning

编译时需要解决的一个问题在于如何使wrapper中的malloc函数不被wrapper替换而造成递归呢？因为wrapper定义在自定义的malloc.h中，此时存在两个malloc.h: in the current directory and usual system directory. GCC编译时参数设置不同，编译器寻找malloc.h的顺序不同，就可以单独先编译wrapper。

#### 7.13.2 Link-Time Interpositioning

#### 7.13.3 Run-Time Interpositioning

后两者就要利用Linker和Dynamic Linker(LD-LINUX.so)的相关mechanism了，不表。

### 7.14 Tools For Manipulating Object Files

`READELF` and `OBJDUMP`.

### 7.15 Summary

> Linkers manipulate **binary files** called object files, which come in three different forms: relocatable, excutable, shared;
>
> The two main tasks of linkers are symbol resolution and relocation;
>
> Muitiple object file can be concatenated in a single static library; (图书馆有很多书，形象！)
>
> At load time the loader maps the partially linked executable into memory and then calls a **dynamic linker**.



## 8 Exceptional Control Flow

### 8.1 Exceptions

#### 8.1.1 Exception Handling

> Exception handlers run in kernel mode.

Exception Handler处理完异常后，根据异常类型，会有三种后续处理可能：1.回到发生异常时的指令位置；2.回到发生异常时下一条指令位置；3.直接跳到内核中的abort routine里terminate当前进程。

#### 8.1.2 Classes of Exceptions

> **Interrupts**: Interrupts occur asynchronously as a result of signals from I/O devices that are external to the processor.

所谓的硬件中断。

> **Traps** and System Calls: Traps are intentional exceptions that occur as a result of executing an instruction. The most important use of traps is to provide a procedure-like interface between user programs and the kernel, known as a system call.

所谓的软件中断，主要是系统调用。

> **Faults**: Faults result from error conditions that a handler might be able to correct. A classic example of a fault is the Page fault exception.

> **Aborts**: Aborts result from unrecoverable fatal errors, typically hardware errors such as parity errors that occur when DRAM or SRAM bits are corrupted.

所以以上两者的区别主要在于错误是否可以被re-executing.

#### 8.1.3 Exceptions in Linux/x86-64 Systems

关于Linux常见的几种Faults和Aborts：

1. Floating exceptions: 当进程中有被0除的处理，Unix不会去试图恢复这种errors。
2. Segmentation faults: 当进程访问未定义地址，或者试图修改只读代码段。
3. Page fault：内存磁盘读入读出操作时。
4. Machine check：当进程觉察到硬件错误时。

### 8.2 Processes

进程如何做到独占CPU和独占内存的抽象，就是OS的核心了。

本节基本上是OS知识，多进程图谱和虚拟地址，还是很好理解的。

#### 8.2.1 Logical Control Flow

#### 8.2.2 Concurrent Flows

#### 8.2.3 Private Address Space

#### 8.2.4 User and Kernel Modes

#### 8.2.5 Context Switches

### 8.3 System Call Error Handling

> When Unix system-level functions encounter an error, they typically return -1 and set the global integer variable errno to indicate what went wrong.

所以这个errno是个全局变量，用于记录Unix设计层面上为系统调用提供的错误记录。

### 8.4 Process Control

介绍Unix为C程序提供的系统调用接口。

#### 8.4.1 Obtaining Process IDs

```
pid_t getpid(void);    返回当前进程pid
pid_t getppid(void);   返回当前进程父进程（parent）的pid
```

#### 8.4.2 Creating and Terminating Processes

```
void exit(int status);  终止一个进程
```

```
pid_t fork(void);   复制生成一个子进程,子进程返0，父进程返子进程id（非0）
```

> When the parent calls fork, the stdout file is open and directed to the screen. Because the child gets identical copied of any of the parent's open file descripters, the child inherits this file, and thus its output is also directed to the screen.

可以看到，stdout就是个file，只是它被定向到screen上了而已。

#### 8.4.3 Reaping Child Processes

> When a process terminates for any reason, the kernel does not remove it from the system immediately. Instead, the process is kept around in a terminated state until it is reaped by its parent. A terminated process that has not yet been reaped is called a zombie.
>
> When a parent process terminates, the kernel arranges for the init process to become the adopted parent for any orphaned children. The init process, which has a PID of 1, is created by the kernel during system start-up, never terminates, and is the ancestor of every process.

据上，所谓僵尸进程是因为它自生被终止，尚未被父进程收割前，称为僵尸。并不是因为父进程先于子进程终止一类的原因，这种情况下，init进程会代替成为其父进程。

```
pid_t waitpid(pid_t pid, int *status, int options);   
#父进程用于收割被终止的子进程的系统调用，参数复杂...
```

#### 8.4.4 Putting Processes to Sleep

```
unsigned int sleep(unsigned int secs);
int pause(void);   强制休眠，直到收到相应信号
```

#### 8.4.5 Loading and Running Programs

```
int execve(const char *filename, const char *argv[], const char *envp[]);
#execve is called once and never return.
```

> By convention, argv[0] is the name of the executable file.

> After execve loads filename, it calls the start-up code, the start-up code sets up the stack and passes control to the main routine of the new program.
>
> ```
> int main(int argc, char **argv, char **envp);
> ```

所以对于一个进程而言，启动时配置的参数以及环境变量都是从main函数传进去的，它们会被率先压入stack中。而且应该是被压入内核栈里。因为需要一下系统调用对环境变量进行读取：

```
char *getenv(const char *name);
int setenv(...);
void unsetenv(const char *name);
```

#### 8.4.6 Using fork and execve to Run Programs

> Programs such as Unix shell and Web servers make heavy use of the fork and execve functions.
>
> A shell is an interactive application-level program that runs other programs on behalf of the user.

shell的本质。

> The execve function loads and runs a new program in the context of the current process. While it overwrites the address space of the current process, it does not create a new process.

要清楚fork和execve的区别...通力合作运行一个新的进程。

补足：fork与execve的区别在于， 前者是同一个program在不同process之间的复制，而后者是同一个process中不同program的替换。从这里也可以看出程序与进程的区别。

### 8.5 Signals

> We have seen how hardware and software cooperate to provide the fundamental **low-level exception** mechanism. In this section, we will study a **higher-level software form** of exceptional control flow, known as a Linux signal, that allows processes and the kernel to interrupt other processes.

> Low-level hardware exceptions are processed by the kernel's exception handlers and would not normally be visible to user processes. Linux signals provide a mechanism for exposing the occurrence of such exceptions to user processes.

#### 8.5.1 Signal Terminology

#### 8.5.2 Sending Signals

1.Sending Signal with the /bin/kill Program

kill当然算是个程序，能够发送signal给别的进程，某种程度上讲也算是进程间的通信；

2.Sending Signals from Keyboard

Typing Ctrl+C: terminate the foreground process group.

Typing Ctrl+Z: stop(suspend) the foreground process group.

两者还是略微不同；

3.Sending Signals with the kill Function

程序kill估计就是包裹kill函数吧；

4.Sending Signal with the alarm Function

大概是硬件中断等Exceptions有时候只是通知kernel，kernel就直接操作进程了，而signal就是kernel通知进程的过程了，所以确切说，不是进程间的通信，而是kernel与进程之间的通信。

#### 8.5.3 Receiving Signals

> Each signal type has a predefined defaults action, which is one of the folowing:
>
> 1.The process terminates;
>
> 2.The process terminates and dump core;
>
> 3.The process stops(suspends) until restarted by a SIGCONT signal;
>
> 4.The process ignores the signal;

#### 8.5.4 Blocking and Unblocking Signals

#### 8.5.5 Writing Signal Handlers

存在几个难点：

1.Handlers事实上与main program是线程级别的并发，所以要注意多线程编程的注意点，许多库函数并不是线程安全的；

2.多个signal过来的时候，并不是queue缓存；

3.像read，accept等slow sysytem calls会被signal打断；

#### 8.5.6 Synchronizing Flows to Avoid Nasty Concurrency Bugs

#### 8.5.7 Explicitly Waiting for Signals

### 8.6 Nonlocal Jumps

```
int setjmp(jmp_buf env);  
#将当前Program Counter,Stack Pointer等运行环境信息存储在jmp_buf结构体中。
int longjmp(jmp_buf env, int retval); 
#取出之前的运行环境信息，并return到之前setjmp处，并初始化运行环境
```

以上两个函数配合，可以无视the normal call-and-return sequence, 达到不同函数间跳转的效果。

主要用途有两个：

1.比如在层层嵌套函数深处出现error，可以直接跳回最外层函数，就栈的情况来说，越深处的函数的栈越往下，即往低地址方向延伸，longjmp后直接跳回高地址，得到外层函数的栈信息，然后配合相应的寄存器信息，就完成了跳转，至于低地址处嵌套函数的栈信息，就舍弃了，反正也不需要特地去初始化为0.

> The exception mechanisms provided by C++ and JAVA are higher-level, more structured version of the C setjmp and longjmp functions. You can think of a catch clause inside a try statement as being akin to a setjmp function. Similayly, a throw statement is similar to a longjmp function.

C++和JAVA的异常处理机制就源于C这个特性实现的。事实上，还可以配合抓取Signal，比如Typing Ctrl+C不去终止进程，而是跳到该进程某一位置，从而形成不断Ctrl+C，不断循环的结果。

2.进一步，可以根据此，实现协程。比如在golang语言中的for几个go关键字，相当于设置多个setjmp，然后在main routine中，longjmp按照分配器算法选择其中一个setjmp跳，在所跳到的协程中，根据相应条件longjmp到另外一个setjmp中，从而完成协程之间的切换。

### 8.7 Tools for Manipulating Processes

### 8.8 Summary

> Exceptional control flow(ECF) occurs at all levels of a computer system and is a basic mechanism for providing concurrency in a computer system.



## 9 Virtual Memory

### 9.1 Physical and Virtual Addressing

> Dedicated hardware on the CPU chip called the **memory management unit**(MMU) translates virtual addresses.

### 9.2 Address Spaces

> The concept of an address space is important because it make a clean distinction between data objects (bytes) and their arributes(addresses).

简而言之，就是指针和值的区别，确实是当年入门C时候一个重要的概念区分。

### 9.3 VM as a Tool for Caching

#### 9.3.1 DRAM Cache Organization

这里应该就指内存，内存换进换出的算法。因为内存也是可以看成disk的cache嘛。

#### 9.3.2 Page Tables

#### 9.3.3 Page Hits

#### 9.3.4 Page Faults

#### 9.3.5 Allocating Pages

> For example, as a result of calling `malloc`.

#### 9.3.6 Locality to the Rescue Again

因为Locality的关系，Page Faults没有预想中的频繁。

### 9.4 VM as a Tool for Memory Management

> **Simplify linking**: A separate address space allows each process to use the same basic format for its memory image, regardless of where the code and the data actually reside in physical memory.
>
> **Simplifying loading**
>
> **Simplifying sharing**：For example, every process must call the same operating system kernel code, and every C program makes calls to rountines in the standard C library such as printf.
>
> **Simplifying memory allocation**：When a user process requests additional heap space, it can be located anywhere in physical memory.

### 9.5 VM as a tool for Memory Protection

### 9.6 Address Translation

讲MMU的工作原理，这个太深了...

MMU就像Virtual Memory的边界物理墙，CPU到MMU这一段是Virtual Memory，之后就是实际地址了。

#### 9.6.1 Integrating Caches and VM

讲程序访问SRAM的缓存是否用VM，好像大部分OS直接用physical address.

#### 9.6.2 Speeding Up Address Translation with a TLB

MMU中也有一小块cache叫做translation lookaside buffer(TLB).

#### 9.6.3 Multi-Level Page Tables

就是多级索引吧，pass

#### 9.6.4 Putting It Together: End-to-End Address Translation

Pass, 没啥兴趣

### 9.7 Case Study: The Intel Core i7/Linux Memory System

VM其实有两部分——CPU和OS组成，之前OS课程中就不太会涉及MMU这一块。

#### 9.7.1 Core i7 Address Translation

#### 9.7.2 Linux Virtual Memory System

| The virtual memory of a Linux process            |
| ------------------------------------------------ |
| PCB, kernel stack(Different for each process)    |
|                                                  |
| Kernel code and data(Identical for each process) |
| User stack                                       |
|                                                  |
| Memory-mapped region for shared libraries        |
|                                                  |
| Run-time heap                                    |
| Read-only memory segment                         |
| Read/Write memory segment                        |
| **0地址**                                        |

### 9.8 Memory Mapping

回顾ELF文件中的.bss 与 .data 数据段的区别，为什么未初始化以及初始化为0的global varient和static varient要被放在.bss数据段，是因为在memory mapping 阶段Linux把其当作Anonymous file(包括Stack, Heap, .bss)处理，不用特地去磁盘swap in，No data are actually transferred between disk and memory.

#### 9.8.1 Shared Objects Revisited

进程之间read-only的physical memory基本是共享的，诸如同一程序不同进程的代码区，又如C program requires functions from the standard C library such as printf.

但是，值得注意的是，对于某些进程的private area，也存在共享的可能性，先给其标read-only的flag，然后进程一旦试图去写入，就trigger a protection fault，然后it creates a new copy of the page in physical memory. 也就是说不更改不copy，便于节省空间。这被称为`copy-on-write`技术。

#### 9.8.2 The `fork` Function Revisited

紧接上节，fork函数就是基于`copy-on-write`技术的。

#### 9.8.3  The `execve` Function Revisited

> Loading and running a.out requires the following steps；
>
> 1. Delete existing area.
> 2. Map private areas.
> 3. Map shared areas.
> 4. Set the program counter(PC)

#### 9.8.4 User-Level Memory Mapping with the `mmap` function

Linux中的两种共享内存方式：IPC(shm)和存储映射I/O(mmap).

传统的read/write对文件的操作：

1. 从disk往内存缓存copy.
2. 再从内核缓存往用户空间copy.

而mmap只需要从disk到用户空间一次数据copy，效率更高，并可实现不同进程间共享内存，相互通信的方式。

### 9.9 Dynamic Memory Allocation

> A dynamic memory allocator maintains an area of a process's virtual memory known as the heap.
>
> Explicit allocators: malloc package...
>
> Implicit allocators: garbage collectors in such as Lisp, Java...

#### 9.9.1 The `malloc` and `free` Functions

事实上，这里隐含着如何malloc与free堆上内存的策略，做得高效率和高利用率。

#### 9.9.2 Why Dynamic Memory Allocation

比如你在编译时不能确定数组的大小，需要动态分配。（必须用的场景也没那没多...）

#### 9.9.3 Allocator Requirements and Goals

速度与利用率之间的平衡。

#### 9.9.4 Fragmentation

指存储空间不能充分利用，有两类：

1. internal fragmentation : 指heap内部因为alignment等问题碎片化。
2. external fragmentation : 指外部没有连续物理内存分配给heap了。

#### 9.9.5 Implementation Issues

#### 9.9.6 Implicit Free Lists

heap分成许多块block，每一块block需要一个structure来记载block size + Allocated/Free等信息。

#### 9.9.7 Placing Allocated Blocks

#### 9.9.8 Splitting Free Blocks

#### 9.9.9 Getting Additional Heap Memory

#### 9.9.10 Coalescing Free Blocks

1. 申请一块内存用于heap.
2. malloc空间不够了，Coalesce一下.
3. 仍不够，调用sbrk函数向kernel再申请.

#### 9.9.11 Coalescing with Boundary Tags

一种提高coalescing效率的改进机制。

#### 9.9.12 Putting It Together: Implementing a Simple Allocator

#### 9.9.13 Explicit Free Lists

> A better approach is to organize the free blocks into some form of explicit data structure.

另一种block的组织方式，比如说 

> The heap can be organized as a doubly linked free list by including a pred and succ pointer in each free block.

#### 9.9.14 Segregated Free Lists

类似于二叉树的一种block组织方式？查询与合并空闲块更快的一种算法与数据结构。

### 9.10 Garbage Collection

#### 9.10.1 Garbage Collector Basics

> A garbage collector's view of memory as a directed **graph**:
>
> Root nodes: Root nodes correspond to locations not in the heap that contain pointers into the heap. These locations can be registers, variables on the stack, or global variables.
>
> Heap nodes:   Reachable / Unreachable( garbage )

> Collectors can run as separate threads in parallel.
>
> The key idea is that the collector calls `free` instead of the application.

#### 9.10.2 Mark&Sweep Garbage Collectors

#### 9.10.3 Conservative Mark&Sweep for C Programs

因为

> C does not tag memory locations with any type information.

所以会过于保守，而没法确保清除干净。

### 9.11 Common Memory-Related Bugs in C Programs

#### 9.11.1 Dereferencing Bad Pointers

#### 9.11.2 Reading Uninitialized Memory

这里提到heap并不被loader初始化为0，与9.8节将Run-time heap视为demand-zero page是矛盾的...

#### 9.11.3 Allowing Stack Buffer Overflows

#### 9.11.4 Assuming That Pointers and the Objects They Point to Are the Same Size

#### 9.11.5 Making Off-by-One Errors

#### 9.11.6 Referencing a Pointer Instead of the Object It Points To

#### 9.11.7 Misunderstanding Pointer Arithmetic

#### 9.11.8 Referencing Nonexistent Variables

#### 9.11.9 Referencing Data in Free Heap Blocks

#### 9.11.10 Introducing Memory Leaks

### 9.12 Summary



## 10 System-Level I/O

### 10.1 Unix I/O

### 10.2 Files

### 10.3 Opening and Closing Files

### 10.4 Reading and Writing Files

是否可以这样理解，Linux下一切皆文件，而System-Level I/O就是操作这些文件，所以Open, Close, Read，Write理所当然是最主要的几个接口了。

> In some situation, `read` and `write` transfer fewer bytes than the application requests. Such `short counts` do not indicate an error. They occur for a number of reasons:
>
> 1. Encountering EOF on reads.
> 2. Reading text lines from a terminal.
> 3. Reading and writing network sockets.

所谓的`short count`就是`read`或`write`的时候，读到或写入的字节数比所设定参数值要少，这是I/O里一个重要issue.

尤其值得注意的是第三点：

> If open file corresponds to a network socket, then internal buffering constraints and long network delays can cause `read` and `write` to return short counts. Short counts can also occur when you call `read` and `write` on a Linux `pipe`, an interprocess communication mechanism that is beyond our scope.

### 10.5 Robust Reading and Writing with the `RIO` Package

> The RIO (Robust I/O) package provides convenient, robust, and efficient I/O in applications such as network programs that are subject to short counts.

#### 10.5.1 `RIO` Unbuffered Input and Output Functions

主要是`RIO` Package中的`rio_writen`跟UNIX I/O级别的`write`一样不带缓冲（只是增加了错误类型修复，见本节引用1），所以它相对于带缓冲且支持格式化输入输出的标准IO库的`fwrite`更适合网络编程。原因见本节引用2.

> RIO还帮助我们处理了可修复的错误类型:EINTR。考虑`read`和`write`在堵塞时被某个信号中断，在中断前它们还未读取/写入不论什么字节，则这两个系统调用便会返回-1表示错误，并将errno置为EINTR。这个错误是能够修复的。而且应该是对用户透明的。用户无需在意read 和 write有没有被中断。他们仅仅须要直到read 和 write成功读取/写入了多少字节，所以在RIO的`rio_read()`和`rio_write()`中便对中断进行了处理。

> 试想一个场景。你正在写一个http的请求报文，然后将这个报文写入了相应socket的文件描写叙述符的缓冲区。假设缓冲区大小为8K。该请求报文大小为1K。那么，假设缓冲区被设置为被填满才会自己主动将其真正写入文件（而且一般也是这样做的）。那就是说假设没有提供一个刷新缓冲区的函数手动刷新，我还须要额外发送7K的数据将缓冲区填满。这个请求报文才干真正被写入到socket其中。所以。一般带有缓冲区的函数库都会一个刷新缓冲区的函数，用于将在缓冲区的数据真正写入文件其中。即使缓冲区没有被填满，而这也是C标准库的做法。然而，假设一个程序猿一不小心忘记在写入操作完毕后手动刷新。那么该数据（请求报文）便一直驻留在缓冲区，而你的进程还在傻傻地等待响应。
> ————————————————
> 版权声明：本文为CSDN博主「五张牌」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/qq_41570835/article/details/112859497

#### 10.5.2 `RIO` Buffered Input Functions

而`RIO` Package中的`rio_readnb`与标准IO库一样是可以带有缓冲的，意思是它在内核区可以申请一块缓存区，而且是为每个file descriptor分配，在`rio_reaninitb`中申请，所以是线程安全的。相对于UNIX I/O级别的`read`而言，避免了频繁地在用户态与内核态之间进行切换，不言而喻效率更高。

### 10.6 Reading File Metedata

> An application can retrieve information about a file (sometimes called the file's metadata) by calling the `stat` and `fstat` functions.

### 10.7 Reading Directory Contents

就各种各样前所未闻的IO。

### 10.8 Sharing Files

在fd与inode之间其实还有一个File table，文件被读取时，记录着相应的位置等信息，当子进程复制父进程时，所拷贝的正是这个File table.

如果你用一个`open`函数打开同一个文件名两次，就会产生指向同一个inode的两个File table.

### 10.9 I/O Redirection

文件redirection的原理事实上就是将fd指向另一个File table.

相应的IO函数为`dup2`.

### 10.10 Standard I/O

> The C language defines a set of higher-level I/O functions, called the **standard I/O library**( libc, <stdio.h>). 
>
> The standard I/O library model an open file as a **stream**.

对于libc而言的话，倾向于将stream放在buffer里来减少频繁地system call，这大概是其整体设计策略.

### 10.11 Putting It Together: Which I/O Functions Should I Use?

> Standard I/O functions: fopen, fread, fwrite, fclose, fflush, fseek, fgets, fputs,  scanf, printf...
>
> Rio functions: rio_readinitb, rio_readlineb, rio_writen...
>
> Unix I/O functions: open, read, write, close, lseek...

### 10.12 Summary

> Linux provides a small number of system-level functions, based on the Unix I/O model, that allow applications to open, close, read, write files, to fetch file metadata, and to perform I/O redirection.



## 11 Network Programming

### 11.1 The Client-Server Programming Model

> It is important to realize that clients and servers are processes and not machines, or hosts as they are often called in this context.

### 11.2 Networks

> Encapsulation is the key.

### 11.3 The Global IP Internet

#### 11.3.1 IP Addresses

> It would make more sense to define a scalar type for IP addresses, but it is too late to change now because of the enormous installed base of applications.

#### 11.3.2 Internet Domain Names

> Each Internet host has the locally defined domain name `localhost`, which always maps to the loopback address 127.0.0.1

#### 11.3.3 Internet Connections

> The port in the client's socket address is assigned automatically by the kernel when the client makes a connection request and is known as an `ephemeral port`.

客户端端口任意，服务端端口固定。

### 11.4 The Sockets Interface

#### 11.4.1 Socket Address Structures

#### 11.4.2 The `socket` Function

#### 11.4.3 The `connect` Function

> The `connect` function blocks until either the connection is successfully established or an error occurs.

#### 11.4.4 The `bind` Function

#### 11.4.5 The `listen` Function

> A server calls the `listen` function to tell the kernel that the descriptor will be uesd by a server instand of a client.

告诉kernel本进程是服务器。

#### 11.4.6 The `accept` Function

> The distinction between a listening descriptor and a connected descriptor confuses many students. The listening descriptor serves as an end point for client connection requests. It is typically created once and exists for the lifetime of the server. The connected descriptor is the end point of the connection that is established between the client and the server. It is created each time the server accepts connection requests and exists only as long as it takes the server to service a client.

#### 11.4.7 Host and Service conversion

> The `getaddrinfo` Function
>
> The `getnameinfo` Function
>
> The property allows us to write clients and servers that are independent of any paticular version of the IP protocol.

就是加一层中间层转化为统一格式给socket用。

#### 11.4.8 Helper Functions for the Sockets Interface

本书自己做的一个一键打开listen fd函数？

#### 11.4.9 Example Echo Client and Server

### 11.5 Web server

#### 11.5.1 Web Basics

> What distinguishes Web services from conventional file retrievel services such as FTP? The main difference is that Web content can be written in a language known as HTML. An HTML program(page) contains instrctions(tags) that tell the browser how to display various text and graphical objects in the page.

视角不一样，Web services其实也是从去远端服务器拿文献这一行为发展过来的。

#### 11.5.2 Web Content

> Web servers provide content to clients in two different ways:
>
> Fetch a disk file and return its contents to the client. The disk file is known as **static content** and the process of returning the file to the client is known as **serving static content**.
>
> Run an executable file and return its output to the client. The output produced by the executable at run time is known as **dynamic content**, and the process of running the program and returning its output to the client is known as **server dynamic content**.

这个就是存储静态资源的Apache和存储动态资源的Tomcat的由来。

#### 11.5.3 HTTP Transactions

> The `telnet` program has been largely supplanted by SSH as a remote login tool, but it can also be used to request the homepage from Web server.

可以在Linux命令行上用telnet去request某网站的html页面。

#### 11.5.4 Serving Dynamic Content

> How does the client pass program arguments to the server?

Arguments for GET requests are passed in the URL.

> How does the server pass arguments to the child?

`fork`+`execve`启动一个符合CGI standard的进程, 通过设置环境变量形式传进去。

> Where does the child send its output?

It uses the Linux `dup2` function to redirect standard output to the connected descriptor that is associated with the client.

#### 11.6 Putting It Together: The Tiny Web Server

在发送response往body写入阶段，连续多次调用没有缓存的write不会造成随写随发，对端收报文时断断续续的现象吗？大概内核的TCP/IP这一部分会对其做一次整合后再发送。所以write和TCP/IP也许有两个层次的缓存。

### 11.7 Summary

> Every network application is based on the client-server model.
>
> A simple but functioning Web server that serves both static and dynamic content can be implemented in a few hundred lines of C code.



## 12 Concurrent Programming

Concurrency含义比较广，包括第八章的logical control flows, 只要they overlap in time. 但是一般来说，我们讲Application-level concurrency, 主要是以下三种：

1. Processes;
2. I/O multiplexing;
3. Threads.

### 12.1 Concurrent Programming with Processes

#### 12.1.1 A Concurrent Server Based on Processes

> A natural approach for building a concurrent server is to accept client connection requests in the parent and then create a new child process to service each new client using `fork` and `exec`.

#### 12.1.2 Pros and Cons of Processes

> Processes have a clean model for sharing state information between parents and children: file tables are shared and user address spaces are not.

IPC: Inter Process Communications.

没看懂章名的意思...但就是笼统讲了进程间可以怎么通信吧。=> 优缺点的意思。

### 12.2 Concurrent Programming with I/O Multiplexing

> Suppose you are asked to write an echo server that can also respond to interactive commands that the user types to standard input. In this case, the server must respond to two independent I/O events, which event do we wait for first?
>
> One solution to this dilemma is a technique called I/O multiplexing. The basic idea is to use the `select` function to ask the kernel to suspend the process, returning control to the application only after one or more I/O events have occurred.

事实上，就是instead of waiting for a connection request by calling the `accept` function, we call the `select` function, which blocks until either the listening descriptor or standard input( 两个不同的fd ) is ready for reading. 这样的解决方法仍然会存在一个问题：因为其仍然是同一个线程，虽然解决了顺序难题，但进行一个I/O时仍无法去回应另一个I/O. 即if you type a command to standard input when the server connects to a client, you will not get a response until it is finished with the client.

#### 12.2.1 A Concurrent Event-Driven Server Based on I/O Multiplexing

> I/O multiplexing can be used as the basis for concurrent **event-driven programs**, where flows make progress as a result of certain events. The general idea is to model logical flows as **state machine**.

原来这也是一种状态机。

> State machine for a logical flow in a concurrent event-driven echo server:
>
> 1. Input event: "descriptor A is ready for reading"  =>`select`
> 2. State: "waiting for A to be ready for reading" =>`accept`
> 3. Transition: "read a text line from A" =>`read` and `close`

`select`一开始只监视listenfd，之后再在监视池里陆续加入listenfd中收到的connfd。So the server calls the `select` function to detect two different kinds of input events: 1. a connection request arriving from a new client, and 2. a connected descriptor for an existing client being ready for reading.

#### 12.2.2 Pros and Cons of I/O Multiplexing

相对于process-based designs, I/O Multiplexing各个event之间的通信更为方便，因为有相同的上下文。但是It's vulnerable to a malicious client that sends only a partial text line and halts. Because as long  as some logical flow is busy reading a text line, no other logical flow can make progress. 另外也不方便适配multi-core processors.

### 12.3 Concurrent Programming with Threads

#### 12.3.1 Thread Execution Model

> The **main** thread is distinguished from other threads only in the sense that it is always the first thread to run in the process. The main impact of this notion of a pool of **peers** is that a thread can kill any of its peers or wait for any of its peers to terminate.

相比进程，就没什么父子线程之说。

#### 12.3.2 Posix Threads

> Posix threads( Pthreads ) is a standard interface for manipulating threads from C programs.

#### 12.3.3 Creating Threads

`pthread_create`: 略

`pthread_self`: 获取当前线程ID

#### 12.3.4 Terminating Threads

四种情况：

1. 隐式地随着上一级线程的return而终止；
2. 该线程自身调用`pthread_exit`显式终止，如果该线程是main thread，则会等所有peer threads终止后，终止整个process；
3. 调用`exit`直接终止process，所有线程都会随之终止；
4. 当前线程想终止其它线程，需要调用`pthread_cancel`.

#### 12.3.5 Reaping Terminated Threads

`pthread_join`: 使当前线程block，直到某一特定其它线程终止，去reaps any memory resources held by the terminated thread.

#### 12.3.6 Detaching Threads

Thread的一个重要属性就是它是否可以被其它线程killed和reaped，如果可以，则为**joinable**,  Its memory resources(such as the stack) not freed until it is reaped by another thread. 

In contrast, 如果不可以，则为**detached**，Its memory resources are freed automatically by the system when it terminates.

By default, threads are created **joinable**. `pthread_detach` 可以将其变成**detached**.

#### 12.3.7 Initializing Threads

`pthread_once`: It is useful whenever you need to dynamically initialize global variables that are shared by multiple threads.  

> 这种情况一般用于某个多线程调用的模块使用前的初始化，但是无法判定哪个线程先运行，从而不知道把初始化代码放在哪个线程合适的问题。
> 当然，我们一般的做法是把初始化函数放在main里，创建线程之前来完成，但是如果我们的程序最终不是做成可执行程序，而是编译成库的形式，那么main函数这种方式就没法做到了。

顾名思义，可以写到多个threads中，但全程只被调用一次。

#### 12.3.8 A Concurrent Server Based on Threads

需要注意的一点，从main thread 创建peer thread时，传进去的参数尽管位于前者的stack，但仍然是共享的。

### 12.4 Shared Variable in Threaded Programs

#### 12.4.1 Threads Memory Model

thread有各自的stack，但你特意要去访问其它线程的stack，其实也行，并没强制的保护措施。

#### 12.4.2 Mapping Variable to Memory

> Global variables
>
> Local automatic variables
>
> Local static variables

#### 12.4.3 Shared Variables

> It's important to realize that local automatic variables such as `msgs` can also be shared.

只要这个局部变量msgs被全局指针确定地址。

### 12.5 Synchronizing Threads with Semaphores

因为在汇编层面，全局变量会暂时转移至寄存器进行相关计算，而寄存器是不会共享的，所以两个线程各自独立累加某个全局变量的情况，即便代码只有一行，也不能保证原子性，仍会出错。

#### 12.5.1 Progress Graphs

用图来表达critical section和mutual exclusion的概念。

#### 12.5.2 Semaphores

概括来说就是两个操作：

 	1. P(s)：如果s不为0，则减一返回，为0则suspend the thread;
 	2. V(s):   就是将s增一返回，如果当前thread从0变成非0，则restart;

#### 12.5.3 Using Semaphores for Mutual Exclusion

> A semaphore that is used in this way to protect shared variables is called a **binary semaphore** because its value is always 0 or 1. Binary semaphores whose purpose is to provide mutual exclusion are often called **mutexes**. Performing a P operation on a mutex is called locking the mutex.

#### 12.5.4 Using Semaphores to Schedule Shared Resources

> Producer-Consumer Problem: For example, the producer detects mouse and keyboard events and insert them in the buffer. The consumer removes the events from the buffer in some priority-based manner and paints the screen.

此处的关键在于不仅producers和consumers之间需要互斥(mutex)，而且producer和consumer之间还有先后顺序(schedule)，这就要求需要互斥锁和信号量组合使用。

```
void insert()
{
	P(slot);     /*Wait for available slot*/
	P(mutex);    /*Lock*/
	/*Insert the item*/
	V(mutex);    /*Unlock*/
	V(item);     /*Announce available item*/
}

void remove()
{
	P(item);     /*Wait available item*/
	P(mutex);    /*Lock*/
	/*Remove the item*/
	V(mutex);    /*Unlock*/
	V(slot);     /*Announce for available slot*/
}
```

两个函数头尾semaphores不同来schedule! 

实质上上例总共使用了三组semaphores.

形象地说，Producer先查看仓库有没有空间，有的话生产，然后告诉Consumer仓库里有东西了，然后Consumer先查看仓库里有没有东西，有的话消费，然后告诉Producer仓库里有空间了。而仓库空间假若说有十个东西可以存储，就可以够十个Producers和Consumers同时忙活。



> Readers-Writes Problem: For example, in a online airline reservation system, an unlimited number of customers are allowed to concurrently inspect the seat assignments, but a customer who is booking a seat must have exclusive access to the database.

就Readers可以同时处理critical section，而Writers需要排他。

```
void reader()
{
	P(mutex);
	readcnt++;
	if(readcnt==1)  /*first in*/
		P(write);
	V(mutex);
	
	/* Critical section*/
	
	P(mutex);
	readcnt--;
	if(readcnt==0)  /*last out*/
		V(write);
	V(mutex);	
}

void writer()
{
	while(1){
		P(write);
		
		/*critical section*/
		
		V(write);
	}
}
```

上例中的mutex仅仅是为了计数安全，并不重要。归结而言，Reader是头个读者Lock和最后一个读者Unlock，从而保证各个Readers之间不排它，而每个Writer都要要Lock，保证互相之间排他并且和Readers排他.

#### 12.5.5 Putting It Together: A Concurrent Server Based on Prethreading

类比12.2.1

### 12.6 Using Threads for Parallelism

> A parallel program is a concurrent program running on multiple processors. Thus, the set of parallel programs is a proper subset of the set of concurrent programs.

这里的parallel概念就是并发之上的并行。

> Synchronization overhead is expensive and should be avoided if possible.

### 12.7 Other Concurrency Issues

#### 12.7.1 Thread Safety

> A function is said to be thread-safe if and only if it will always produce correct results when called repeatedly from multiple concurrent threads.

#### 12.7.2 Reentrancy

> The set of reentrant functions is a proper subset of the thread-safe functions.

大概可以理解为纯函数吧， 入参确定，返回值就一定的感觉。

#### 12.7.3 Using Existing Library Functions in Threaded Programs

> Common thread-unsafe library functions:
>
> `rand`, `strtok`, `asctime`, `ctime`, `gethostbyaddr`, `gethostbyname`, `inet_ntoa`, `localtime`.

#### 12.7.4 Races

比如main thread传递local变量给peer thread时，因为两个线程trajectory并不会总如人所愿有固定地前后，造成抵达某一逻辑点顺序不同，导致结果不同，称为race.  在例子的情况，可以考虑用heap变量代替local变量。

#### 12.7.5 Deadlocks

> Mutex lock ordering rule: Given a total ordering of all mutexes, a program is dead-free of each thread acquires its mutexes in order and release them in reverse order.

就一条rule。

### 12.8 Summary

