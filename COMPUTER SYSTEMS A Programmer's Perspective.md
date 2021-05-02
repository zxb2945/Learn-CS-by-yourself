# COMPUTER SYSTEMS A Programmer's Perspective

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

