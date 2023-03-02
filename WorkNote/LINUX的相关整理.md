# 工作五年LINUX的相关整理

## 1 Linux介绍

GNU/Linux：hardware->kernel->shell->App

进程：进程即程序的实例。输入命令，linux就创建一个新的进程，可用ps -f查看，ppid为父进程，用户大部分命令都将shell作为父进程，一个窗口即是一个bash进程。kill -9 xx结束，也可以用Ctrl+c结束进程。

## 2 常用命令

**rm -rf xx**

r表示递归，f表示强制（强制），用于删除文件夹。



**grep "xx" -r -n ./**

该命令用语抓取字符段。

r表示遍历子目录，无所谓大小写，-R亦可；

n（小写）表示显示行数；

“/”表示根目录，“./”表示当前目录，“../”上上级目录；

grep "xx"位置固定，之后参数位置可灵活调换，”xx“冒号可以省略；

“grep xx xx.log"表示在某文件里抓取相应字符。



**find ./ -name "xx"**

寻找文件。

-name 表示文件名，“xx”可以不用加冒号；

自动递归，不用r；

"-size +20M"表示查找20M大以上的文件。



**find . -type d -name xxx | xargs rm -rf**

在相应路径下查找所有某文件夹名的文件并删除。

-type d 表示文件夹

-type f 表示文件，注意区别

xargs命令可以通过管道接受字符串，并将接收到的字符串通过空格分割成许多参数(默认情况下是通过空格分割) 然后将参数传递给其后面的命令，作为后面命令的命令行参数。如果单纯使用管道的话，只是将之前命令的标准输出作为之后命令的处理内容，而`rm`,`kill`这两个命令只接受命令行参数中指定的处理内容，不从标准输入中获取处理内容。想想也很正常，kill 是结束进程，rm是删除文件，如果要结束的进程pid和要删除的文件名需要从标准输入中读取，这个也很怪异吧。 但是像 cat与grep这些文字处理工具从标准输入中读取待处理的内容则很自然。



**chown -R root:root xx**

将文件xx所有者改为root。

root:root 表示 组：名。



**df -h**

查看系统硬盘空间。



**less -N xx.c**

-N表示显示行号（grep就必须用n，所以参数大小写就比较不统一）。



**zip -r obeject source**

-r表示压缩文件夹，否则data为0；

解压用unzip。

```
tar -xzvf file.tar.gz //解压tar.gz
```



**ln -s xx/tmp xx/dir/linktemp**

link,s表示软连接，即创建快捷方式。linktemp为快捷方式。



**chmod 777 filename**

更改文件相应权限，777为所有权限。



**ls** 

|              |                        |
| ------------ | ---------------------- |
| ls -a        | 查看隐藏文件           |
| ls -lh       | 按M显示大小            |
| ls -l\|wc -l | 表示当前目录下的文件数 |



**ps**

|         |                |
| ------- | -------------- |
| ps u    | 当前用户的进程 |
| ps -aux |                |
| ps -ef  |                |



**touch filename**

文件不存在时创建一个空文件。



**who am i**

查看自己的用户名。



**alias s="ls;ps aux"**

当前shell下重命名linux命令。



**echo $$**

打印显示相关的值，如当前进程号。



**scp -p ./files/abc.log  192.168.214.188:/tmp/**

将当前服务器下某文件传输到另一台服务器上。

如果是文件夹的话

```
scp -r TOOL emergency@129.76.3.193:/home/emergency/Gsc
```



**cat /proc/cpuinfo**

查看cpu型号



**man ascii**

查看ASCII码。



`du -sh *`

查看当前目录下各个文件占用空间大小。



**tree -L n**

用tree只表示n层（不穷根到底）。



**diff 1.log 2.log**

比较文件。



**tail -f -n0 debug.log**

-f用语监视File文件的增长，-n表示从第N行位置读取指定文件。



`rename File file *.txt`

将当前目录下所有txt文件名中的File字段替换成file。

（2020.10.26）



**su** 

普通用户切换到超级用户root

> `su`默认只是切换身份，并没有切换环境变量，环境变量依然是普通用户的。
>
> `su - root` 不仅切换身份，而且切换环境变量。

从root用户切回普通用户则用`su - zxb`. 注意破折号前后有空格。

注意某些用户也可以通过`sudo 执行文件`来暂时获得root的权限。前提是该用户被记载在sudoers文件中。

> `sudo -i`: 为了频繁的执行某些只有超级用户才能执行的权限，而不用每次输入密码，可以使用该命令。提示输入密码时该密码为当前账户的密码。没有时间限制。执行该命令后提示符变为“#”而不是“$”。想退回普通账户时可以执行“exit”或“logout” 。 要求执行该命令的用户必须在sudoers中才可以
>
> (2022.12.2)



**which**

查看可执行文件的位置。比如`which bash`。



**screen**

screen是一个全屏窗口管理器，它在多个进程（通常是交互式shell）之间多路传输物理终端。

创建：screen -S 屏幕名称

进入：screen -r 屏幕名称

展示屏幕列表：screen -ls

关闭：screen -S 对应ID -X quit

切回主屏幕：ctrl+A+D



## 3 linux执行命令结果输出到文件

|                    |                |
| ------------------ | -------------- |
| echo "xx" >文件    | 覆盖写入       |
| echo "xx" >>文件   | 追加写入       |
| xx >/dev/null 2>&1 | 忽略所有的输出 |

“>/dev/null”表示空文件，写进去全部丢失。

"2>&1",0为stdin，1为stdout，2为stderr。1为默认值，"&"表示等同。

也就是说"1 >/dev/null 2>&1",命令执行时屏幕上产生的任何信息写入空文件中，2和1一起写进去。



理解`>/dev/null 2>&1`就需要理解**Linux下一切皆文件**这句话。任何一个进程启动后会自动打开三个文件，分别是标准输入，标准输出，标准错误（它们的文件最终表现均为终端显示），他们的文件描述符`fd`分别为0，1，2。打开的文件的描述符会存放于进程PCB中的`files_struct`中，这与用`fopen`函数打开一个存放于磁盘的文件机理相同。一般设备文件，如鼠标键盘等会放在`/dev`目录下，而`/dev/null`就是Linux中一个特殊的虚空文件(不妨想象为连接着计算机的外接垃圾箱)，所以`>/dev/null 2>&1`表示为将输入到标准输出，标准错误重定向到`/dev/null`中。

扩展开来说，Linux下的设备通常分为三类，字符设备，块设备和网络设备。见的字符设备有鼠标、键盘等。常见的块设备有各种硬盘。在Linux里一个网络设备也可以叫做一个网络接口，如eth0网卡，需要注意的是，应用程序通过Socket来对网络设备文件进行I/O操作，而不是常规的文件操作函数`read/write`。

## 4 GDB(The GNU Project Debugger)

进程包含线程。进程有自己的内存空间，线程与该进程的其它线程共享这个内存，但堆栈各自独立。进程通过IPC（进程间通信）来管理进程间的共享数据。

ps为最基本的进程查看命令。

gdb可直接执行程序文件，并可手动设参，如

```
（gdb）set args SE MODE:IMT ...
```

也可attach当前运行程序，gdb -p  \<PID\> 或 gdb --pid \<PID>  -x xx.c:150 （提前打断点）。

但前提是，gcc编译时需要留意DEBUG和release版本的区别：是否加 -g

| 多线程调试   |                                          |
| ------------ | ---------------------------------------- |
| info threads | 前面有*的为当前调试的线程                |
| thread ID    | 切换线程，存在断点时会自动切换到断点线程 |
| bt           | 查看线程栈结构                           |

| GDB常用命令        |                                                              |
| ------------------ | ------------------------------------------------------------ |
| r                  |                                                              |
| b fun/N/file.c:N   |                                                              |
| d N                | 删断点                                                       |
| info break         |                                                              |
| c                  |                                                              |
| finish             | 运行到当前函数结束                                           |
| s                  | 进入子函数                                                   |
| return N           | 对当前函数，强制回值并结束                                   |
| p var              | 打印变量，也可赋值                                           |
| set var=val        |                                                              |
| q                  | 退出                                                         |
| info locals        | 打印所有初始局部变量                                         |
| x/\<n/f/u> \<addr> | 比如x/16db 0xXX， 查看该地址16个单位，以十进制单字节显示的值 |
| l                  | 查看代码.c文件（注意编译时机差异.c文件与.o文件不一致情况）   |

（2019.6.10）

## 5 GCC

gcc编译的四个阶段：

|               |                                   |
| ------------- | --------------------------------- |
| Preprocessing | 对include，define分析             |
| Compilation   | -S(大写) 表示生成汇编文件后停止   |
| Assembly      | -c 表示生成目标文件后停止，不链接 |
| Linking       | 链接函数库                        |

链接之前，已是二进制文件，内存已分配完毕。

.a 为静态库，代码全塞进去； .so为动态库，运行时加载（win系统下为.lib和.dll）。

之前微码生成静态库塞到驱动，驱动提供动态库给应用层，比如

```
gcc -shared -fPIC -o libhello.so hello.c 
/*-fPIC参数声明链接库的代码段是可以共享的，-shared参数声明编译为共享库*/
gcc main.c -L. -lhello 
/*-L.告诉编译器在当前目录中查找库文件*/
```

gcc最基本的用法就是：gcc [options] [filenames] => gcc test.c （简洁不！）。

| [options] |                                         |
| --------- | --------------------------------------- |
| -o        | 若不给，则生成a.out（可执行文件）       |
| -Wall     | 编译后显示所有警告                      |
| -g        | 生成可以使用gdb的版本                   |
| -Dxxx     | 条件编译，例如 -DDBG，相当于#define DBG |
|           |                                         |

（2019.7.1）

## 6 ctags

ctags是个程序，3条命令：

|          |                                        |
| -------- | -------------------------------------- |
| ctags -R | 创建tags                               |
| Ctrl + ] | 跳进去，注意只能在有tags文件目录下操作 |
| Ctrl + T | 跳出来                                 |

在Linux下可以用vim + ctags组合来写程序。

（2019.6.26）

## 7 vi/vim

### 复制粘贴

1.yy复制当行，p光标下粘贴；

2.5yy复制光标下5行；

3.5p同一行粘贴5份；

4.v进入选取模式，上下左右-》按y-》按p， 复制一大块或按d删除；

5.dd删除当行，3dd删除光标下3行；

6.yw复制一个单词，dw删除一个单词，x删除一个字符。

### 替换查找

1.查找 :/keyword 

查找自动高亮，取消高亮用 :nohlsearch

2.替换 :%s/beforeword/afterword/g

%s表示每一行，g表示全文替换。

### 其它

撤销 :undo 

ctrl+r表示恢复；

ctrl+d表示向前滚动半屏；

ctrl+u表示先后滚动半屏；

移动到文件第n行 :n

## 8  shell

shell 命令行解释器，本身就是一个c语言写的程序。

分交互式shell，linux命令行界面本身就是一个shell，即用户登录系统就启动了一个bash，也可以输入一个bash再启动一个交互shell，bash->Bourne Again shell.

非交互式shell，如常见的shell script脚本，注意句首#!/bin/bash 句末不加分号。

### 变量

系统变量，如$HOME,$PATH...

自定义变量

可以用set命令显示所有变量

基本语法为 变量=值 **（中间不能有空格）**

撤销为 unset 变量

readonly 变量

将命令的返回值赋给变量（也可以直接作为函数的参数），例如 

```
A=`ls`
A=$(ls)
```

### 设置环境变量

环境变量在当前shell进程及子进程中可用，子进程可以理解为一份拷贝，从而增删对父进程无影响。程序可直接调用环境变量。

修改/etc/profile文件，可永久性修改环境变量，注意如`export PATH`的命令不是对原本存在的环境变量PATH替代，而是在此基础上追加，类似用`;`隔开表示；

直接使用export添加，只对当前shell及子进程有效；

另外，C程序中获取当前系统环境变量可调用getenv().

### 位置参数变量

| $n    | test.sh 1 2 3        |
| ----- | -------------------- |
| $0    | 代表命令本身         |
| $1~$9 | 代表输入参数         |
| $*    | 全部位置参数（整体） |
| $@    | 全部位置参数（分别） |
| #     | 参数个数             |
| ${#n} | 入参长度             |

### 预定义变量

|      |                                      |
| ---- | ------------------------------------ |
| $$   | 当前进程号                           |
| $!   | 后台最后一个进程                     |
| $?   | 上一条命令的返回值，成功为0，失败为1 |

### 运算式

echo $[5+6] 或 echo $((5+6))

### 判断式

```
if [ $1 -lt 5 ]  /*if与[之间必须要有空格，括号内也要有空格，lt=less than*/
then
  echo ...
elif [ $1 = string ] /*=与!=只能比较字符串*/
then
  echo...
fi
```

也可以用if [ $1 -lt 5 ];then 的形式。

### 流程控制

```
for i in "$*"
do
  ...
done
或者
for((j=0;j<5;j++))
do
  ...
done
```

另外，while与case也可以。

### 函数

系统函数，如basename,dirname...

自定义函数，function(){ ... },任意参数用$1~$9，函数名用$0表示。

### 举例

以下为一个将当前目录下的压缩文件解压后批量重命名的shell script.

```
#!/bin/bash

FILE=`ls`

for i in $FILE
do
  if [ $i != test.sh ];then
  echo $i
  unzip -l $i /*-l：显示压缩文件内所包含的文件；*/
  fi
done

rm *.zip

for i in $FILE
do
  NN=$(echo $i | sed 's/_/-/g')
  echo $NN
  mv $i $NN
done

:<<!
mv $i vvv
!
```

（2019.9.3）

## 9  shell脚本的运行问题

### "."与"./"执行的区别

"./"相当于新建一个shell，不继承父进程非export类型变量；

"."的方式类似于将脚本中的每一行指令逐条在当前shell中执行，与"./"环境变量的作用域有区别；

"./"只能执行拥有权限的文件，"."则可以暂时提升。

### #!/bin/bash

shell脚本中第一行#!/bin/bash到底其不起作用？

起作用，但使用指定解释器运行脚本时，第一行自动失效。

|            |                                   |
| ---------- | --------------------------------- |
| bash解释器 | BourneAgain Shell                 |
| sh解释器   | Bourne Shell，Unix标准默认的shell |

### 不同OS下修改对shell的影响

在windows系统下修改的shell脚本放到linux上会出现的问题。主要是回车键在两个系统下操作不同，可以用":set ff"查看，":set ff=unix"修改。

## 10 Makefile

Makefile会一层一层去找文件的依赖关系，直到完成第一个目标文件。所以在Makefile中规则顺序很重要，因为它只有一个最终目标。

像clean，不被第一个目标直接关联，不会被自动执行。更为稳健的方式是 .PHONY:clean ,声明clean为伪目标。

操作系统命令要以Tab键为开头，反斜杠为换行符。两个命令逻辑执行用“；”隔离，例如

```
	cd /home;pwd
```

大工程中嵌套执行make，传递某些变量到下一级make用 export，例如

```
export vari=vlaue
```

可使用条件语句，如ifeg,else与endif，也可使用函数，如循环函数foreach。

$@表示目标文件，$^表示所有依赖文件，$<表示第一个依赖文件。

另外，注意重编译时，makefile没法察觉.h文件被修改，从而不会对相应的.o文件重新编译，此时需要clean后重编译。

下例是一个最简单的编译当前目录下所有c文件的makefile文件：

```
CC = gcc

CFLAGS = -Wall

HPATH = ../                       /*不要定义成系统变量PATH*/

INCLUDE = -I$(HPATH)Times -I$(HPATH)APL/head  -I$(HPATH)MAST/head  -I$(HPATH)head
                                  /*-I表示在参数指定目录下寻找*/

SRCS = $(wildcard *.c)            /*取当前目录下所有c文件最为SRCS*/

OBJS = $(patsubst %c,%o,$(SRCS))  /*$函数调用声明，patsubst为字符串替换函数*/
                                  /*%.c是GNUmake语法层，*.c是linux shell语法层*/
.PGHONY:clean
	
$(OBJS):$(SRCS)                   /*左记会重复编译，应当使用 %.o:%.c */
	$(CC) -c $^ $(INCLUDE) $(CFLAGS)
	
clean:
	rm -f $(OBJS) $(TARGET)       /*“-”表示强制执行 */
```

（2019.7.12）

## 11 Linux 文本处理三剑客

linux下一切皆文件。

grep长于查找（单纯查找匹配），sed长于取行和替换（编辑匹配到的文件），awk长于取列（格式化文本）。

### grep

Global Regular Expression Print

grep xxx [Options] [File]

​                 -i 忽略大小写

​                 -n 显示行号

### sed

流编辑器。每次处理一行，与vim全文本对照。

例如，支持替换

```
sed 's/_/-/g'          
sed -i 's/替/换/g' 文件名    /* -i表示直接文件中替换，终端输出 */
```

又如，当前路径下，所有文件中，某特定字符串特定替换

```
sed -i 's/替/换/g' `grep 替 -rl ./`    /* -rl 表示递归且输出所有匹配到文字串的文件 */
```

又如输出文件13行

```
sed -n '13p' xx.txt
```

### awk

处理文本的编程语言工具，文本格式化能力。

awk [option] 'pattern{action}' File

pattern指查找内容，action指所执行的命令。

例如指定分隔符打印

```
awk -F: '{print $1}' xx.sh   /* -F:指定 ： 为分隔符 */
```

若不指定分隔符，则默认空格为分隔符切割所逐行读入的文件，每行切片，逐行进行各种分析处理。

可以与sed组合使用，如

```
par=view abc.log|sed -n '5p'|awk '{print $8}'|awk -F ':' '{print $2}'
```

（2019.10.17）

## 12 Linux 进程间通信机制

主要有共享内存，消息队列，信号灯，管道，套接字（socket）等5种进程通信间机制。

### IPC

IPC包括共享内存（share memory）,消息队列（message queue）,信号量（semaphore)。系统为IPC提供了一个统一系统调用ipc()，内核实现是sys.ipc()。

相关命令有

```
ipcs [-a|-m|-q|-s]  /*ipc show all/memory/queue/semaphore */
ipcrm [-q id]       /*ipc remove,以msgid删除队列消息 */
ipcs -l             /*可以查看系统允许最大的信号量集，当出现'No space left on device'问题时*/
```

### Share Memory

在多进程运行的设备上，进程之间相互通信，每个进程起来，初始化时就需要去attach其它进程的共享内存块或者建立本进程的共享内存块。比如某个程序的单体环境测试过程中，测试进程启动，因为其他进程提供的library的缺乏，需模拟函数库，模拟过程如下：

1.调用getkey取得用户uid来设置key；（如此，可以保证多个测试人员启动进程时共享内存不冲突）

2.调用shmget取得相应共享内存，存在则取得，不存在则新建；

（2021.7.19补充）：如果想事先确认共享内存是否存在，可以使用`shmget(key,0,0)`来确认，同时也可以通过`shmctl`来删除相应共享内存。创建时，如果`shmflg`为`IPC_EXCL|IPC_CREAT|0666`时，其中0666为读写控制bit，与`chmod 777`中777一样。

（2021.12.20补充）：不建议用`errno`来确认共享内存存在，因为`errno`虽然是线程独立全局变量，但是它就近存储上一次系统调用出错信息，即便本次调用正常，也并不一定会重置为0.

3.调用shmat，将共享内存映射到当前进程；（从进程虚拟地址来看，共享内存应该位于堆栈之间的中间区域，至于实际地址就不存在比较意义，零碎分布也有可能）

4.调用fopen打开本地模拟数据文件；

5.调用fgets取用本地模拟数据文件中数据与临时变量；

5.调用str2den将临时变量中的数据串变成整型变量并存放于共享内存；

6.程序结束时，调用shmdt，使进程detach共享内存。

另外，注意_errno函数，使用系统调用函数或库函数时，出错时会被调用，如errno17表示File exists。

### Message Queue

消息队列函数由msgget、msgctl、msgsnd、msgrcv四个函数组成。

在某个程序的单体环境构建过程中，可以自写工具程序用msgsnd发送消息队列到测试程序中，用msgrcv接受从而完成相关送受信测试，而msgget则用于发送接受之前的id取得。

|        |                     |
| ------ | ------------------- |
| msgget | 取msgid，没有则新建 |
| msgsnd | 发送队列消息        |
| msgrcv | 接受队列消息        |

Message Queue是一个存在于内存的消息的链表，相较于pipe，它所返回的id并不是文件标识符fd，所以并不存在Message Queue文件这种说法。

### Semaphore

信号量实际上是个计数器，用于多进程之间的同步与排他操作。

注意与mutex互斥锁的区别：

1.Semaphore是一件可以容纳N人的房间，如果人不满就可以进去，如果人满了，就要等待有人出来。对于N=1的情况，称为binary semaphore。一般的用法是，用于限制对于某一资源的同时访问；

2.Mutex是一把钥匙，一个人拿了就可进入一个房间，出来的时候把钥匙交给队列的第一个。一般的用法是用于串行化对critical section代码的访问，保证这段代码不会被并行的运行。

对于Binary semaphore与Mutex，这两者之间就存在了很多相似之处，有的系统中Binary semaphore与Mutex是没有差异的。

|        |                                            |
| ------ | ------------------------------------------ |
| semget | 既存信号量id取得或新建                     |
| semctl | 根据入参不同，可设定初期值，亦可删除信号量 |
| semop  | 进行上锁解锁操作，用来同步或者排他         |

注意以上函数不是标准函数，位于<sys/sem.h>.

(2021.7.6)补充：信号量有两种实现：传统的System V信号量和新的POSIX信号量。POSIX信号量来源于POSIX技术规范的实时扩展方案(POSIX Realtime Extension)，常用于线程；system v信号量，常用于进程的同步。这两者非常相近，但它们使用的函数调用各不相同。前一种的头文件为semaphore.h，函数调用为sem_init(), sem_wait(), sem_post(), sem_destory()等等。后一种头文件为<sys/sem.h>,函数调用为semctl(), semget(), semop()等函数。

### Pipe

Pipe不同于Message Queue，它不能区分字节流的边界。

一般只适合父子进程间单向通信。如把两个命令连接起来

```
ls -l | grep "4月"   /* 查找当前目录下4月份修改的文件 */
```

以下代码展示了如何在父子进程间单向通信：

```
#include <stdio.h>  
#include <unistd.h>  
#include <string.h>  
#include <errno.h>  
int main()  
{  
    int fd[2];  
    int ret = pipe(fd);  
    //说到底就是这个pipe函数，给进程返回两个文件标识符，写端和读端
    //这里的返回的文件事实上是Linux一种特殊的文件类型管道文件，它指向内核的一块缓冲区
    if (ret == -1)  
    {  
        perror(”pipe error\n”);  
        return 1;  
    }  
    pid_t id = fork();  
    if (id == 0)  
    {//child  
        int i = 0;  
        close(fd[0]); 
        //子进程关闭写端管道文件
        char *child = “I am  child!”;  
        while (i<5)  
        {  
            write(fd[1], child, strlen(child) + 1);  
            sleep(2);  
            i++;  
        }  
    }  
    else if (id>0)  
    {//father  
        close(fd[1]);
        //关闭父进程读端的管道文件
        char msg[100];  
        int j = 0;  
        while (j<5)  
        {  
            memset(msg,’\0’,sizeof(msg));  
            ssize_t s = read(fd[0], msg, sizeof(msg));  
            if (s>0)  
            {  
                msg[s - 1] = ’\0’;  
            }  
            printf(”%s\n”, msg);  
            j++;  
        }  
    }  
    else  
    {//error  
        perror(”fork error\n”);  
        return 2;  
    }  
    return  0;  
}  
```

(2021.5.2)

### Socket

 Socket是应用层与TCP/IP协议族通信的中间软件抽象层，它是一组接口。

具体来说，服务器端先初始化Socket，然后与端口绑定(bind)，对端口进行监听(listen)，调用accept阻塞，等待客户端连接。在这时如果有个客户端初始化一个Socket，然后连接服务器(connect)，如果连接成功，这时客户端与服务器端的连接就建立了。客户端发送数据请求(write,send)，服务器端接收请求并处理请求(read,recv)，然后把回应数据发送给客户端，客户端读取数据，最后关闭连接(close)，一次交互结束。

| FUN         |                                                              |
| ----------- | ------------------------------------------------------------ |
| socket      | 创建一个socket描述符（socket descriptor），它唯一标识一个socket。可以指定TCP/UDP协议。 |
| bind        | 把一个ipv4或ipv6地址和端口号组合赋给socket。                 |
| listen      | socket()函数创建的socket默认是一个主动类型的，listen函数将socket变为被动类型的，等待客户的连接请求。 |
| connect     | 客户端通过调用connect函数来建立与服务器的连接。              |
| accept      | 服务端通过accept接受请求，由内核返回一个新的socket描述符.    |
| read/write  | 调用网络I/O进行读写操作，即实现了网咯中不同进程之间的通信    |
| recv/send   | 相较read/write，多一个阻塞选项，发送接收全部数据前可处于阻塞状态 |
| close       | 关闭socket描述符                                             |
| select/poll | 能同时监听多个文件描述符，用于并发网络编程                   |

socket中TCP的三次握手建立连接于客户端的connect与服务端的accept的SYN，ACK信号交互间，确切来讲，connect只是起一个通知客户端内核发起三次握手的作用，服务端的accept通常处于阻塞态，服务端的内核完成三次握手后再通知accept解除阻塞，也就是说三次握手建立连接其实是由操作系统的内核部分来完成的。（这里需要清楚一个概念，即操作系统确实是程序，但它不是进程，因为进程的概念建立于操作系统之上）。另外，有时候可以利用poll函数提前去监听，这样就不必使accept处于阻塞状态，并有利于并发。（poll函数并不属于socket系）

socket中TCP的四次握手释放连接于两端的close交互间，即客户端先发送FIN信号给服务端，告知预备关闭，服务端给予返信告知收到；服务端若没有剩余信息需要发送，则发送FIN信号给客户端，并立即close，客户端收到这个信号后，给予返信，并等待一定时间close。

一个服务器通常只创建一个监听socket描述字，它在该服务器的生命周期内一直存在，这个套接字不能用于与客户端之间发送和接收数据。accept接受一个客户端的连接请求，并返回一个新的套接字，服务器与本次接受的客户端的通信是通过在这个新的套接字上发送和接收数据来完成的，最后close关闭的也是这个accept返回建立的socket描述字。

(2021.3.25)

## 13 Linux 线程相关函数库pthread

### Linux pthread线程库历史

1.Linux2.6之前不知道线程这个概念，自然不支持；

2.Linux2.6之后，没法实现内核级线程，便开发了pthread函数库用创建轻量级进程来模拟线程(1:1的用户级线程)；

3.Redhat公司的NPTL项目用clone实现线程，更接近复合POSIX标准的内核级线程。

### 线程启动及结束过程

一般来说一个进程起来，先会进行进程间通信IPC的初始化工作，然后开始起线程。

1.pthread_attr_init,线程相关属性的初始化；

2.调用相关属性设置函数；

3.pthread_cond_init,线程间通信初始化；

4.pthread_mutex_init,互斥锁初始化；

5.pthread_create,启动线程，一般多线程就用一个循环，而线程各个属性包括线程入口函数可以做成一个全局变量的结构体；

6.pthread_exit，在当前线程结束线程，如果用其他线程结束该线程，则调用pthread_cancel；

7.pthread_cleanup_push和pthread_cleanup_pop是成对的线程资源清理函数，线程异常终止时（如被pthread_cancel终止），锁资源等需要释放。

### 线程间通信的实现

线程间通信的确可以用全局变量，也可以动态申请，但如何实现？

|                       |                         |
| --------------------- | ----------------------- |
| pthread_mutex_init    | 互斥锁初期化            |
| pthread_cond_init     | 线程间送受信初期化      |
| malloc                | 申请动态内存            |
| pthread_mutex_lock    | 线程1上锁               |
| memcpy                | 拷贝数据到动态内存      |
| pthread_cond_signal   | 发送通信信号            |
| pthread_mutex_unlock  | 线程1解锁               |
| pthread_mutex_lock    | 线程2上锁               |
| pthread_cond_wait     | 线程2解锁，处于挂起状态 |
|                       | 收到通信信号，线程2上锁 |
| memcpy                | 从动态内存拷贝数据      |
| pthread_mutex_unlock  | 线程2解锁               |
| pthread_mutex_destroy | 终止互斥锁              |
| pthread_cond_destroy  | 终止送受信              |
| free                  | 释放动态内存            |

以上，理解pthread_cond_wait是关键，其中隐含了对互斥锁的操作。

（2020.12.25）

## 14 网络通信工具

ping hostname/ip,发送ICMP；

telnet hostname/ip,登录远程计算机；

tcpdump,分析网络中传运的数据包；

```
tcpdump -v -i any -s 4096  port 9000  -w http.cap
tcpdump (-i eth0) icmp     //配合ping，来确认两台服务器是否通信
                           //单是ping的话，存在IP冲突，发送到其他服务器的可能性（2022.4.7）
```

netstat,检验各端口的情况；

lsof -i, list open file.

（2019.7.17）

### IP地址

一个IP地址，如`192.168.103.18`，形式上被点分隔为四个部分，实质上只是分为网络号和主机号，前者表示哪个网络，后者表示哪台主机，最初受限于形式上所分隔的四个部分，有所谓的ABCDE类型地址，不能灵活分配网络数和主机数，针对这个问题，引入了无类型域间选路（CIDR）形式，即`192.168.103.18/24`，后面24的意思是，32位中，前24位是网络号，后8位是主机号。伴随着CIDR存在的，一个是广播地址，用来向该网络所有主机发送消息；另一个是子网掩码，用来计算网络号。

=>The **/32** denotes one IP address, and the **/0** refers to the entire network.

在日常的工作中，几乎不用划分A，B，C类了，所以时间长了，很多人就忘记了这个分类，而只记得CIDR。但是有一点还是要注意的，就是公有ip地址和私有ip地址。

| 类别 | IP地址范围                | 最大主机数 | 私有IP地址范围              |
| ---- | ------------------------- | ---------- | --------------------------- |
| A    | 0.0.0.0-127.255.255.255   | 16777214   | 10.0.0.0-10.255.255.255     |
| B    | 128.0.0.0-191.255.255.255 | 65534      | 172.16.0.0-172.31.255.255   |
| C    | 192.0.0.0-233.255.255.255 | 254        | 192.168.0.0-192.168.255.255 |

公有ip地址有个组织统一分配，你需要去买。如果你搭建有一个网站，给你学校的人使用，让你们学校的IT人员给你一个IP地址就行。但是假如你要做一个类似163这样的网站，就需要有公有ip地址，这样全世界的人才能访问。

 不需要将十进制转为2进制就能明显看出`192.168.0`是网络号，后面是主机号。而整个网络里面的第一个地址`192.168.0.1`，往往就是你这个私有网络的出口地址。例如你家里的电脑链接wifi，wifi路由器的地址就是`192.168.0.1`，而`192.168.0.255`就是广播地址。一旦放松这个地址，整个`192.168.0`网络里面的所有机器都能收到。

`127.0.0.1 `是回环地址，用于本机通信，经过内核处理后直接返回，不会在任何网络中出现。

`0.0.0.0`表示本机所有ip的集合，不管主机有多少个网口，多少个IP，如果监听本机的0.0.0.0上的端口，就等于监听机器上的所有IP端口。数据报的目的地址只要是机器上的一个IP地址，就能被接受。

MAC地址是一个很容易让人误解的地址，因为mac地址号称全局唯一，**不会有两个网卡有相同的mac地址**。而且网卡自生产出来，就带着这个地址。既然这样，整个互联网的通信，全部用mac地址就好了，只要知道了对方的mac地址，就可以把信息传过去。这样当然是不行的。一个网络包要从一个地方传到另一个地址，除了要有确定的地址，还需要有定位功能。而有门牌号码属性的ip地址，才是有远程定位功能的。mac地址更像是身份证，是一个唯一的标识。它的唯一性设计是为了组网的时候，不同的网卡放在一个网络里面的时候，可以不用担心冲突。从硬件角度，保证不同的网卡有不同的标识。

### 网卡

网卡(Network Interface Card，简称NIC)，也称网络适配器，是电脑与局域网相互连接的设备。无论是普通电脑还 是高端服务器，只要连接到局域网，就都需要安装一块网卡(eth0)。如果有必要，一台电脑也可以同时安装两块或多块网卡(eth1-eth3)。

一块网卡包括OSI 模型的两个层， 物理层和数据链路层。以太网卡中数据链路层的芯片一般简称之为 MAC 控制器，物理层的芯片我们简称之 为PHY。许多网卡的芯片把MAC 和PHY 的功能做到了一颗芯片中。

每一个网卡设备都有一个mac地址，**但是却可以有多个IP地址（比如通过secondary IP机制，在物理的子网上创建逻辑子网）**，因为linux的协议栈实现完全解除耦合，也就是说ip层完全不依赖链路层以及物理层的物理布局。

举例：FS服务器与FEP，USP服务器组成一个逻辑子网，FS服务器与HTTPSIM服务器组成另一个逻辑子网，最后FS服务器通过不同的网卡跟远程踏板登录服务器再组成另一个网络。这样就形成了FS服务器可以使用不同的IP地址分别与USP，HTTPSIM，登录服务器通信，但USP，HTTPSIM和登录服务器之间无法通信的网络配置。

这其中的关键在于每个服务器所维护的三张表：路由表，MAC表，ARP表。

| 路由表、ARP表、MAC表整     | 报文转发步骤                                       |
| -------------------------- | -------------------------------------------------- |
| Routing Table              | 确定目的IP是否可达（例如OSPF就是一种动态路由协议） |
| Address Resolution Table   | 获取到IP地址地址对应的Mac地址信息（ARP协议）       |
| Media Access Control Table | 确定物理地址（交换机）                             |

（2022.4.7）

### ifconfig 和 ip addr show

两者均可查看本机网卡及ip相关信息。（注意windows下是`ipconfig`，有一字之差...）区别在于分属不同的工具箱，ifconfig属于net-tools，主要配置老式Linux内核的网络功能。自2001年以后，它在Linux社区的发展就止步不前了。CentOS/RHEL 7等一些Linux发行版已经弃用了net-tools，改而使用iproute2。后者就属于iproute2。

| net-tools           | iproute2      | 功能                     |
| ------------------- | ------------- | ------------------------ |
| ifconfig            | ip addr show  | 查看本机网卡及ip相关信息 |
| netstat -tunlp      | ss -l         | 查看本机监听ip端口       |
| netstat -ra / route | ip route show | 查看本机路由表           |
| arp                 | ip neigh      | 查看本机ARP表            |
| ...                 |               |                          |

工作使用中`ss -l`一直显示无此命令，奇怪...

（2021.10.21）

### telnet 和 ssh

ssh与telnet的相同点：

1.两种协议都可以远程登录另一台主机

2.两种协议都属于基于TCP/IP的协议

ssh与telnet的不同点：

1.telnet是明文传送；ssh是加密传送，并且支持压缩。

2.telnet的默认端口号为23；ssh的默认端口号为22.

```shell
//可以向远程终端打入命令
ssh usp00 /SYSTEM/LM/apl/virtual/cmd/bin/PHSC
```

此外，scp(Secure Copy Protocol)用于Linux之间复制文件和目录。基于ssh登陆进行安全的远程文件拷贝命令。SSH连接隧道是安全的，因而基于SCP协议的文件传输是安全的。

sftp(Secure File Transfer Protocol)与 ftp 有着几乎一样的语法和功能。是ssh的其中一部分。用法如下：

```shell
sftp username@ip
cd 文件存储的位置
put [本地文件的地址] [服务器上文件存储的位置]
get (-r) [服务器上文件存储的位置] [本地要存储的位置]
bye
```

(2022.2.10)

### http 和 ftp

http 与ftp的相同点：

1.都运行在TCP上，即都使用TCP（而不是UDP）作为其支撑的运输层协议。 

http 与ftp的不同点：

1.HTTP是超文本传输协议，是面向网页的；FTP是文件传输协议，是面向文件的。

2.HTTP协议默认端口：80号端口。FTP协议默认端口：21号端口。

(2022.1.12)

## 15 正则表达式

> - 正则表达式用来在文件中匹配符合条件的字符串，正则是包含匹配。grep、awk、sed 等命令可以支持正则表达式。
> - 通配符用来匹配符合条件的文件名，通配符是完全匹配。ls、find、cp 这些命令不支持正则表达式，所以只能使用 shell 自己的通配符来进行匹配了。

| 元字符 | 作用                                                         |
| ------ | ------------------------------------------------------------ |
| *      | 前一个字符匹配0次或任意多次。                                |
| .      | 匹配除了换行符外任意一个字符。                               |
| ^      | 匹配行首。^hello，匹配hello开头的行。                        |
| $      | 匹配行尾。hello$，匹配hello结尾的行。                        |
| []     | 匹配中括号中指定的任意一个字符，只匹配一个字符。 [aeiou]、[0-9] |
| [^]    | 匹配除了中括号内字符以外的任意一个字符。`[^a-z]`             |
| \      | 转义符。                                                     |
| {n}    | 表示其前面的字符恰好出现n次。[0-9]{4} 匹配4位数字。          |
| {n，}  | 表示其前面的字符出现不小于n次。[0-9]{2，} 匹配2位及以上的数字。 |
| {n，m} | 表示前面的字符至少出现n次，最多出现m次。                     |
| ...    | ...                                                          |

以下是利用正则表达式统计C++工程规模的例子：

```shell
#!/bin/bash								
echo "file count:"								
find . -name "*pp"|wc -l								
echo "code count:"
#使用-v命令查找不包含某字符的行
#-e表示匹配多个
#^:匹配行首，$:匹配行尾，所以^$表示匹配空行
#POSIX BRE模式下，匹配任意空白字符要用[[:space:]]，^[[:space:]]*$表示匹配全是空白字符的行
#^[[:space:]]*\/\/.*$ 表示匹配“//”开头的注释行
find . -name "*pp"|xargs cat|grep -v -e ^$ -e ^[[:space:]]*$ -e ^[[:space:]]*\/\/.*$|wc -l								
echo "comment count:"								
find . -name "*pp"|xargs cat|grep  ^[[:space:]]*\/\/.*$|wc -l								
echo "blank count:"								
find . -name "*pp"|xargs cat|grep -e ^$ -e ^[[:space:]]*$|wc -l								
echo "total count:"								
find . -name "*pp"|xargs cat|wc -l								
```

(2023.2.14)

## 16 TTL脚本

目前为止接触的工程，都是Linux系统的远程服务器，当前的用Tera Term远程连接，Winscp文件交互，而TTL脚本正是Tera Term自动化脚本，以下是一个单体测试运行GDB的TTL脚本：

```
;; IP
HOSTADDR = '186.32.120.27' 
;; 用户名密码
USERNAME = 's_kouha' 
PASSWORD = 's_kouha' 

;;GDB断点
BREAKPOINTS = 'main'
;============================================= 
COMMAND = HOSTADDR 
strconcat COMMAND ':23 /nossh /T=1'

;;连接1 
connect COMMAND
 
;;登录
wait	'login:' 
sendln 	USERNAME 
wait	'Password:' 
sendln	PASSWORD

;;进入测试环境
sendln 'cd /home/user/s_kouha'
;;运行程序
sendln './Process'
timeout = 3
wait 'Continuing'
unlink

;;连接2 
connect COMMAND
 
;;登录
wait	'login:' 
sendln 	USERNAME 
wait	'Password:' 
sendln	PASSWORD

sendln 'cd /home/user/s_kouha'

;;本地建立文件存放脚本运行log
getenv 'USERNAME' username
sprintf2 filename '%s\GDB.log' '\\10.2.5.10\UDBlog' username 
logopen filename 1 1 0 0 1

;;gdb attach测试程序
temp = '"./IFAT"'
sprintf2 cmd "pid=$(ps u | grep Process | awk '{if($11==%s){print $2}}')" temp
sendln cmd
sendln 'gdb attach $pid'

timeout = 3
wait 'pause'

BP = "b "
strconcat BP BREAKPOINTS
sendln BP 
sendln 'c'
timeout = 3
wait 'Continuing'
unlink
```

## 17 常用字符集

### ASCII

针对英文。

### Unicode

支持欧亚几乎所有文字，号称万国码，~~但各种语言之间不通，比如常见的电脑系统原本用日文形式编码的unicode文件若用中文形式解析，就乱码，反过来也是（即中日对同一个汉字unicode不同）。~~

其实就是把世界上所有的文字符号，全部用唯一编码表示，从而可以世界各地通用。所以Unicode编码在中日文系统均可兼容。汉字应该使用的是同一编码段。

### UTF-8

8-bit Unicode Transformation Format ，与Unicode相较而言，适配ASCII。

Unicode在表示英文字符时，存在空间浪费，UTF-8就可以很好地根据不同文字符号，空间上可以自动调整。

### EUC

Extended Unix Code，主要用于储存汉字，日语（EUC_JP），韩语文字。

### SJIS

Shift_JIS，日本电脑系统常用的编码表，支持假名，文字，拉丁字母...

### GBK

中国大陆汉字编码。

（2019.12.12）

## 18 Linux串口编程
串口是计算机上的串行通讯的物理接口。计算机历史上，串口曾经被广泛用于连接计算机和终端设备和各种外部设备。虽然以太网接口和USB接口也是以一个串行流进行数据传送的，但是串口连接通常特指那些与RS-232标准兼容的硬件或者调制解调器的接口。虽然现在在很多个人计算机上，原来用以连接外部设备的串口已经广泛的被USB替代；而原来用以连接网络的串口则被以太网替代但是，一方面因为串口本身造价便宜技术成熟，另一方面因为串口的控制台功能RS-232标准高度标准化并且非常普及，所以直到现在它仍然被广泛应用到各种设备上。

| net-tools           | iproute2      | 
| ------------------- | ------------- | 
| /dev/tty           | 当前控制终端Terminal | 
| /dev/tty1     | （虚拟）控制台终端       | 
| /dev/console  | 系统控制终端，系统的错误信息什么的都输出到这里 |
| /dev/ttyS0                  | 串行端口终端(Serial Port Terminal)，接串口线使用的端口设备     | 
| /dev/ttyUSB0              |     USB转串口终端，接USB转串口线可用此端口设备           | 
| /dev/ttyACM0              |     USB转串口终端，gps设备就是/dev/ttyACM0           | 

理解为何有的USB串口叫ttyUSB而有的叫ttyACM:对于转换桥，功能较单一，归类为ttyUSB;对于带通信规约的接口，实现复杂，归类为ttyACM。

Linux系统中打开计算机的串口的demo：
```
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h> /* File control definitions */
#include <errno.h>
#include <termios.h> /* POSIX terminal control definitions */

/*
 * 'open_port()' - Open serial port 1
 * Returns the file descriptor on success or -1 on error.
 */

int open_port(void)
{
	int fd; /* File descriptor for the port */

	fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NDELAY);
	if (fd == -1)
	{
		/*
		 * Could not open the port.
		 */
		perror("open_port: Unable to open /dev/ttyS0 -");
	}
	else
	{
		fcntl(fd, F_SETFL, 0);
		return (fd);
	}
}
```
