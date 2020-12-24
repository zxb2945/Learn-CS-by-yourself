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

### ls -l|wc -l

表示当前目录下的文件数。

### zip -r obeject source

-r表示压缩文件夹，否则data为0；

解压用unzip。

### ln -s xx/tmp xx/dir/linktemp

link,s表示软连接，即创建快捷方式。

### chmod 777 filename

更改文件相应权限，777为所有权限。

### ls -a

查看隐藏文件。

### touch filename

文件不存在时创建一个空文件。

### who am i

查看自己的用户名。

### alias s="ls;ps aux"

当前shell下重命名linux命令。

### echo $$

打印显示相关的值，如当前进程号。

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
gcc -shared -fPIC -o libhello.so hello.c /*-fPIC参数声明链接库的代码段是可以共享的，-shared参数声明编译为共享库*/
gcc main.c -L. -lhello /*-L.告诉编译器在当前目录中查找库文件*/
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

### 位置参数变量

| $n    | test.sh 1 2 3        |
| ----- | -------------------- |
| $0    | 代表命令本身         |
| $1~$9 | 代表输入参数         |
| $*    | 全部位置参数（整体） |
| $@    | 全部位置参数（分别） |
| #     | 参数个数             |

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

## 10 Makefile

## 11 Linux文本处理三剑客

## 12 Linux 进程间通信机制

主要有共享内存，消息队列，信号灯，管道，套接字（socket）等进程通信间机制。

### 管道

只适合父子进程间单向通信。如把两个命令连接起来

```
ls -l | grep "4月"   /* 查找当前目录下4月份修改的文件 */
```

## 13 常用字符集