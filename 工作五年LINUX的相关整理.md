# 工作五年LINUX的相关整理

## 1 Linux介绍

GNU/Linux：hardware->kernel->shell->App

### 进程

进程即程序的实例。

输入命令，linux就创建一个新的进程，可用ps -f查看，ppid为父进程，用户大部分命令都将shell作为父进程，一个窗口即是一个bash进程。

kill -9 xx结束，也可以用Ctrl+c结束进程。

### 网络通信工具

ping hostname/ip,发送ICMP；

telnet hostname/ip,登录远程计算机；

tcpdump,分析网络中传运的数据包；

netstat,检验各端口的情况；

lsof -i, list open file.

（2019.7.17）

## 2 常用命令

### rm -rf xx

r表示递归，f表示强制（强制），用于删除文件夹。

### grep "xx" -r -n ./

该命令用语抓取字符段。

r表示遍历子目录，无所谓大小写，-R亦可；

n（小写）表示显示行数；

“/”表示根目录，“./”表示当前目录，“../”上上级目录；

grep "xx"位置固定，之后参数位置可灵活调换，”xx“冒号可以省略；

“grep xx xx.log"表示在某文件里抓取相应字符。

### find ./ -name "xx"

寻找文件。

-name 表示文件名，“xx”可以不用加冒号；

自动递归，不用r；

"-size +20M"表示查找20M大以上的文件。

### chown -R root:root xx

将文件xx所有者改为root。

root:root 表示 组：名。

### df -h

查看系统硬盘空间。

### less -N xx.c

-N表示显示行号（grep就必须用n，所以参数大小写就比较不统一）。

### zip -r obeject source

-r表示压缩文件夹，否则data为0；

解压用unzip。

### ln -s xx/tmp xx/dir/linktemp

link,s表示软连接，即创建快捷方式。

### chmod 777 filename

更改文件相应权限，777为所有权限。

### ls 

|              |                        |
| ------------ | ---------------------- |
| ls -a        | 查看隐藏文件           |
| ls -lh       | 按M显示大小            |
| ls -l\|wc -l | 表示当前目录下的文件数 |

### ps

|         |                |
| ------- | -------------- |
| ps u    | 当前用户的进程 |
| ps -aux |                |
| ps -ef  |                |

### touch filename

文件不存在时创建一个空文件。

### who am i

查看自己的用户名。

### alias s="ls;ps aux"

当前shell下重命名linux命令。

### echo $$

打印显示相关的值，如当前进程号。

### scp -p ./files/abc.log  192.168.214.188:/tmp/

将当前服务器下某文件传输到另一台服务器上。

### cat /proc/cpuinfo

查看cpu型号

### man ascii

查看ASCII码。

### du -sh *

查看当前目录下各个文件占用空间大小。

### tree -L n

用tree只表示n层（不穷根到底）。

### diff 1.log 2.log

比较文件。

### tail -f -n0 debug.log

-f用语监视File文件的增长，-n表示从第N行位置读取指定文件。

### rename File file *.txt

将当前目录下所有txt文件名中的File字段替换成file。

（2020.10.26）

## 3 linux执行命令结果输出到文件

|                    |                |
| ------------------ | -------------- |
| echo "xx" >文件    | 覆盖写入       |
| echo "xx" >>文件   | 追加写入       |
| xx >/dev/null 2>&1 | 忽略所有的输出 |

“>/dev/null”表示空文件，写进去全部丢失。

"2>&1",0为stdin，1为stdout，2为stderr。1为默认值，"&"表示等同。

也就是说"1 >/dev/null 2>&1",命令执行时屏幕上产生的任何信息写入空文件中，2和1一起写进去。

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

| [options] |                                   |
| --------- | --------------------------------- |
| -o        | 若不给，则生成a.out（可执行文件） |
| -Wall     | 编译后显示所有警告                |
|           |                                   |

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

将命令的返回值赋给变量，例如 

```
A=`ls`
A=$(ls)
```

### 设置环境变量

环境变量在当前shell进程及子进程中可用，子进程可以理解为一份拷贝，从而增删对父进程无影响。程序可直接调用环境变量。

修改/etc/profile文件，可永久性修改环境变量；

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

### Pipe

只适合父子进程间单向通信。如把两个命令连接起来

```
ls -l | grep "4月"   /* 查找当前目录下4月份修改的文件 */
```

(2020.3.3)

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

socket中TCP的三次握手建立连接于客户端的connect与服务端的accept的SYN，ACK信号交互间；

socket中TCP的四次握手释放连接于两端的close交互间，即各自close后向对方发送FIN信号。

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

## 14 TTL脚本

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

## 15 常用字符集

### ASCII

针对英文。

### Unicode

支持欧亚几乎所有文字，号称万国码，但各种语言之间不通，比如常见的电脑系统原本用日文形式编码的unicode文件若用中文形式解析，就乱码，反过来也是（即中日对同一个汉字unicode不同）。

### UTF-8

8-bit Unicode Transformation Format ，与Unicode相较而言，适配ASCII。

### EUC

Extended Unix Code，主要用于储存汉字，日语（EUC_JP），韩语文字。

### SJIS

Shift_JIS，日本电脑系统常用的编码表，支持假名，文字，拉丁字母...

### GBK

中国大陆汉字编码。

（2019.12.12）

