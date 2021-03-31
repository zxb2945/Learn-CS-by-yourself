# 浙江大学_Python程序设计

## 2021.1.9

交互与文件两种类型，跟shell很像，本来就是解释型语言嘛
Python官网下载的自带环境很像Linux。
讲到identifiers 了，就是编译原理里正则表达式定义的嘛。据说新的版本里中文也行。
与c不同，变量的类型是动态绑定的，运行时才确定，没有编译时提前确定。一个问题：python那不叫编译器吧，解释器？两者之间有什么机理区别吗？
可以对一个变量反复赋值，类型还可以不一样，赋值了，就自动给你定类型了。编译原理里两者区别也讲到了。
但是一个重点：python中如何去实现的呢，它的整形类型跟c的字符串类型一样，一定范围内的小整数直接分配了内存，像a=1,b=1.   a与b的地址就是被直接分配了内存地址的1的地址。但大整型如1000好像跟c一样重新分配内存……
介绍了input(),int(),type(),print()等。
奇怪的是函数嵌套有int(input())，也有input().split()，这什么鬼？
感觉有各种库，数学库就算了，还有专门画五角星的库……

## 2021.1.10
与c不同int不会溢出……什么原理？大概是因为动态绑定类型吧，不用在编译时提前开辟内存，运行时随便写……
 但浮点数凭什么就有范围限制呢？
还有数学中的复数概念，牛逼……
运算符中除法与c不同，整数相除得浮点型，要跟c一样，就双斜杠
没有单字符概念，只有字符串
还有三引号，可以表示文本换行……还可以加号表示连接字符串，乘号表示复制字符串，这像运算符重载啊……
字符串还能反向索引……a[-1]，倒数第一个字符……

```
's'
>>> s1
'1,2,3'
>>> s1[0]
'1'
>>> s1[-1]
'3'
>>> s1[-3]
'2'
>>> s1[-2]
','
```

布尔值True,False,解释器直接定义了
一些奇怪的运算符的细节，具体遇到具体查
逻辑运算符直接用英文and or not来……
内置转换函数一类的，遇到在调查对吧，就像c，来日本后才遇到在查的嘛
If else后面要加冒号的，shell也不一样嘛，发现脚本语句结束也没分号，表示代码逻辑是通过缩进来实现，而不是花括号一类的，整个代码形式跟c还是不一样。
for ... in ...
Python中的列表跟c数组的区别就是其中元素类型可以不同。我感觉这种东西类似于cpp 的STL数据模版……根据列表还可以用列表推导式来产生，用for乃至if……
比如

```
[int(‘6’*i) for i in range(1,10)]
```

Print函数中的占位符也不一样，要用format(),这类就参照拷贝，理解就好

## 2021.1.11

列表和字符串都是序列类型的容器，可以用in ，not in判断元素在不在容器中：

```
>>> s1='1,2,3'
>>> '1' in s1
True
>>> '5' not in s1
True
>>> 
```

字符串这种对象不支持元素的赋值

一般的列表就支持元素赋值

```
>>> array=[1,2,3]
>>> array[0]=2
>>> array
[2, 2, 3]
>>> string='123'
>>> string[0]=2
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'str' object does not support item assignment
>>> 
```

字符串和列表切片

```
>>> 
>>> 
>>> array=[1,2,3,4,5,6,7,8]
>>> array[1:3]
[2, 3]
>>> 
>>> 
>>> 'zhejiang'[:3]
'zhe'
>>> 'zhejiang'[4:]
'iang'
>>> 'zhejiang'[3:]
'jiang'
>>> 
>>> len(array)
8
>>> array
[1, 2, 3, 4, 5, 6, 7, 8]
>>> min(array)
1
>>> max(array)
8
>>> 
```

## 2021.1.13

min,max等是全局函数，而字符串函数是字符串的函数，则是 string.function()的形式。

```
>>> 
>>> s
'AAA'
>>> s1=s.lower()
>>> s1
'aaa'
>>> 
```

字符串输出占位符 %d %.1f什么的跟C一样，只是之后用 % 号来代替 逗号，更像是一种运算符重载，%被称为字符串的格式化运算符。

```
>>> ' it is %d c ' %25
' it is 25 c '
>>> 
```

python可以进行列表形式上的赋值，实质是指针赋值，与整数赋值是不同的，如下：

```
>>> a=[1,2,3]
>>> b = a
>>> b
[1, 2, 3]
>>> b[0]=5
>>> a
[5, 2, 3]
>>> 
```

所以列表在python中比较特殊，它实质上是列表的管理者，而不是所有者。

如果是实质上的赋值，可以利用切片，如下：

```
>>> a
[5, 2, 3]
>>> b=a[:]
>>> b
[5, 2, 3]
>>> b[0]=7
>>> b
[7, 2, 3]
>>> a
[5, 2, 3]
>>> 
```

切片在等号左边时，还可以给原有列表赋值，乃至插入。。。还可以用del来做列表的删除,还可以用string.remove(n)来删除。。。

```
>>> 
>>> a
[5, 2, 3]
>>> a[1:3]=['a','b','c']
>>> a
[5, 'a', 'b', 'c']
>>> 
>>> 
>>> a
[5, 'a', 'b', 'c']
>>> del a[1]
>>> a
[5, 'b', 'c']
>>> 
```

列表的函数，即加点调用的函数：append(),extend(),insert()...

一个新的语言无非是基本数据类型，流程等，主要是库函数的了解需要经验...



目前为止，学得最复杂的无非是两种序列：字符串和列表，两者之间的转化主要通过字符串的函数。

```
>>> s='this is a test'
>>> s.split()
['this', 'is', 'a', 'test']
>>> t=s.split()
>>> t
['this', 'is', 'a', 'test']
>>> ' '.join(t)
'this is a test'
>>> 
>>> time='12:35'
>>> time.split(':')
['12', '35']
>>> 
```



元组（tuple）与列表的区别，元组像字符串一样不能被赋值，如下

```
>>> l=[1,2,3]
>>> a=(1,2,3)
>>> l
[1, 2, 3]
>>> a
(1, 2, 3)
>>> l[0]=5
>>> l
[5, 2, 3]
>>> a[0]=5
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
>>> 
```

在python中，逗号隔开的数字之间被默认为是tuple，而tuple主要用来不想被他人修改的数据类型（感觉类似默认const修饰），如

```
>>> 
>>> p=3,4
>>> p
(3, 4)
>>> 
```



列表的排序，乱序：

```
>>> t=[2,5,4,7,5,9]
>>> t.sort()
>>> t
[2, 4, 5, 5, 7, 9]
>>> import random
>>> random.shuffle(t)
>>> t
[5, 7, 9, 5, 2, 4]
>>> 
```



## 2021.1.14

```
while True:
	x=int(input())
	if x>0:
		if x>1:
			a=1
			b=2
	elif x=0:
		a=2
		b=1
	else:
		a=b=0
		break
print(a)

#判断是否是素数
x=int(input())
for k in range(2,x):
	if x%k == 0:
		break
else:
	printf('is prime')
```

python永远用缩进来表达层次

if语句之后的冒号跟接下来语句前的缩进是表达：接下来两句从属于这个if判断

<u>for之后也可以跟else</u>，表示for的循环正常结束，就会执行else，若被break不被执行

关于range()这个函数，可以有1到三个参数，这个像C++中的什么特性来着？参数不同，执行函数体也不同，重载？

```
>> [i for i in range(1,100) if i%2==0]
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98]
>>> 
>>> list(range(2,100,2))
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98]
>>> 
```



异常是程序运行时的一个保护措施

```
#!/usr/bin/env python3

x=int(input())
t=[1,2,3,4,5]

try:
        print(t[x])
except:
        print('x is not valid')
```

try+except用来保护某一段代码抛出异常时，不会造成程序直接终止，即不运行出现异常的语句。

（许多特性c++有的，c没有的，毕竟python比较新的语言嘛。）

## 2021.1.18

集合是一种无序的容器，程序员无法指定集合中的顺序。C中好像没有集合的容器，集合就是数学中的概念，其中元素不能重复，顺序不重要。

集合的创建可以用set把列表转化为集合。

集合和字典两种容器共用{}。

集合空集用set()表示，而{}表示字典空集。

可以用add(),remove()等许多函数操作集合

集合的对象没法去访问其某个具体元素，没法通过下标访问

对集合的操作基本上是数学中对集合的操作，加减乘除全部重载了。

（感觉集合能干吗用？估计用途很少吧）

通常利用集合元素的唯一性来干事。



字典是现代编程语言中常用的一个容器。

{'key1':value1,'key2':value2}

d['key1']=value1;

可以直接用[]取值赋值，不用函数。

字典也是一个无序容器。

可以用for去遍历字典key，通过key来获取value。

需要用del来删除，len，max什么函数也可以。

许多操作能不能做并不取决于字典，而是取决于字典中的key。



字典类型可用于python对json的转换，python里自带库

```
#!/usr/bin/python3

import json

# Python 字典类型转换为 JSON 对象
data = {
    'no' : 1,
    'name' : 'w3big',
    'url' : 'http://www.w3big.com'
}

json_str = json.dumps(data)
print ("Python 原始数据：", repr(data))
print ("JSON 对象：", json_str)
```



（总结而言，因为集合跟字典两种容器，后者类似与c中结构体。。。）

## 2021.1.19

### 1函数定义

```
def fibs(n):
    result=1
    return result
```

（函数的定义也是python一贯的风格：冒号加缩进，无分号）

函数另一种定义方式：lamda表达式，相对def简单的函数定义

```
g=lambda x,y,z:x+y+z
#输出10
print(g(1,2,3))   
```

（就像c中define定义的类似函数的表达式）

### 2函数参数

python中参数*和**的使用方法：关键字参数

*的这种用法是传递一个元组

**的这种用法是传递一个字典



（可以联系c中main中形参定义，实现机理上应该是类似的）

但是是传地址？还是仅仅是值呢？-》应该是值吧，等同于元组直接赋予？

NONONO，前面讲了python列表之间的赋值，其实是列表地址的赋值，所以传参是等同于赋值，其实是传地址，传进去列表值改了，出来相应的列表中的值也要变化。



而且形参可以直接指定default值，即不传参，就会有默认值，并且可以直接形参=value的赋值，也就是说，可以指定最后一个形参的值，其它采用默认值的传参方式。

### 3函数返回值

return

不使用return，就默认返回None，None类似于NULL？？？不代表任何数据。

### 4命名空间

解释器启动，自动起一个全局命名空间

每个函数起来，也是独立命名空间

可以用dir()来查询

Python中赋值即定义

（python中似乎无需特殊声明命名空间，都是隐式规定的）

全局变量需要用global关键词（c语言中是定义在函数体外。。。但在python中不好这么做，有命名空间的概念）

### 5递归

递归的能力在于用有限的语句来定义对象无限的集合

### 6内置函数

sorted：一个排序函数

zip：一个用于多个列表间元素配对重生成元组的函数

eval

exec:可以执行python程序

以上两个函数体现了python的动态性？？？

（这些函数碰到一个就查，不然记不住）

### 7程序结构

通过import来实现各个py文件间的函数调用

多个py文件在同一个目录下+init.py组成一个包，为了使python应用更具扩展性。

## 2021.1.20

文件读写操作

多行文件的读写

输入输出重定向：从读入文本输入输出转化为键盘输出输入



python模块函数的三个层次：

1.内置函数

直接调用

2.标准模块函数

用import引入后再调用，如math

3.第三方模块函数

安装后用import引入再调用，如pandas模块

pandas是python一个重要的数据分析包



各种第三方模块中可以去读取excel文件，json文件，数据库文件读写等等



plotly模块可以用于数据可视化



（简而言之吧，任何一个第三方模块就可以学习一阵子，语言学习本来就是这样，先预览语言大概语法，然后在后续开发中学习各种库或者模块。）

## 2021.1.25

类和对象的概念

Python完全采用面向对象程序设计的思想，是真正面向对象的高级编程语言，完全支持面向对象的基本功能，如封装，继承，多态以及对基类方法的覆盖或重写。

不仅类，常量，函数都是对象，万物皆对象...

（怪不得，字符串后可以加+点+函数，因为字符串是个对象，它有方法）

变量值修改一类的基本上跟C++没什么差

运行都不用main函数，因为直接解释了嘛



注意类变量与实例变量的区别：后者位于“_init\_中用self.来赋值，是对象本省的变量，而不是这个类固有的变量（C++中好像没有强调这个...）；相应还有类的方法与实例的方法的区别；

Python中可以动态增加类变量，这在C++中可没有，估计也是因为它是解释型语言；

Python类的成员没有访问控制限制，与C++不同，但是以下划线开头的方法名变量名有特殊含义（应该只是约定？）如_init\_

  所以子类继承父类，加个括号就行？并且来说super表示父类？

```
calss ECar(Car):
	def _init_(self,name):
		super()._init_(name) #初始化父类的属性
		self.battery_size = 300
		
	def getEcar("Tesla"):
		printf(...)
```



## 2021.1.27

```
'''
Function:
    经典坦克大战小游戏
Author:
    Charles
微信公众号:
    Charles的皮卡丘
'''
#其实import os就是在python环境下对文件，文件夹执行操作的一个模块。
import os
#装载当前路径下的cfg.py文件吧
import cfg
#pygame是跨平台Python模块，专门为电子游戏设计，包含图像、声音等；简单的说它是别人已经编写好的程序，并放在了一个类似库里，专门给别人使用的；
import pygame 
#用正则表达式插入自己写的库吧
from modules import *


'''主函数'''
#难道import之后，文件名.参数 直接拿来可以用？似乎就可以...
def main(cfg):
    pygame.init()
    pygame.mixer.init()
    screen = pygame.display.set_mode((cfg.WIDTH, cfg.HEIGHT))
    pygame.display.set_caption(cfg.TITLE)
    #字典空集
    sounds = {}
    for key, value in cfg.AUDIO_PATHS.items():
        sounds[key] = pygame.mixer.Sound(value)
        # 不知道这个函数返回了个什么，可以调用set_volume...
        sounds[key].set_volume(1)
    is_dual_mode = gameStartInterface(screen, cfg)
    #sorted()函数对一个列表进行排序
    levelfilepaths = [os.path.join(cfg.LEVELFILEDIR, filename) for filename in sorted(os.listdir(cfg.LEVELFILEDIR))]
    #在一个for循环中同时遍历两个列表,或者同时循环index和item
    #enumerate多用于在for循环中得到计数，比如对一个列表，既要遍历索引又要遍历元素时
    for idx, levelfilepath in enumerate(levelfilepaths):
        switchLevelIterface(screen, cfg, idx+1)
        game_level = GameLevel(idx+1, levelfilepath, sounds, is_dual_mode, cfg)
        is_win = game_level.start(screen)
        if not is_win: break
    is_quit_game = gameEndIterface(screen, cfg, is_win)
    return is_quit_game

#这一段代码不是很懂？上面解释到时不是已经开始main函数了嘛
'''run'''
if __name__ == '__main__':
    while True:
        is_quit_game = main(cfg)
        if is_quit_game:
            break
```

严格来说pygame这个第三方库不了解，os不了解，以上这个程序就没法看



Flask是一个使用python编写的轻量级Web应用框架。

装饰器只是一种接受函数（就是那个你用“@”符号装饰的函数）的函数，并返回一个新的函数。CSDN上看了一下，还是嵌套调用，并用语法糖，逻辑绕好几层。。。



