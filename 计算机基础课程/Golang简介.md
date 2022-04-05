# Golang简介（8小时转职Golang工程师--刘丹冰）

2021.5.7 ~ 2021.5.16

## Linux下的安装

```
/usr/lib/golang  #安装路径+配置环境变量$GOROOT，$GOPATH
go version  #查看版本
go --help   #查看命令
```



## Golang的优势

1.即可以解释器直接执行，也可以编译器编译后执行；

2.语言层面天然支持并发，几行代码就可以实现协程，充分利用多核；



## Golang的基本语法

### main

```
package main //程序的包名

/*
import "fmt"
import "time"
*/
//import多个包建议下面方式
import (
	"fmt"
	"time"
)

//main函数
func main() { //函数的{  一定是 和函数名在同一行的，否则编译错误
	//golang中的表达式，加";", 和不加 都可以，建议是不加
	fmt.Println(" hello Go!")

	time.Sleep(1 * time.Second)
}
```



### 变量声明

```
fmt.Println
fmt.Printf    //f表示格式化
```

在初始化的时候，可以省去数据类型，通过值自动匹配当前的变量的数据类型 =》 跟python一样

最有特点的变量声明方式，用`:=`直接表示初始化并赋值，类型等信息自动匹配，如下

```
    e := 100   //不过这种变量声明方式只能用于函数体内
```

多种变量声明方式 =》跟python一样，似乎有内嵌迭代器

```
	var xx, yy int = 100, 200
	fmt.Println("xx = ", xx, ", yy = ", yy)
```



### 多返回值

```
func foo2(a string, b int) (int, int) {
	fmt.Println("a = ", a)
	fmt.Println("b = ", b)

	return 666, 777
}
```

跟python一样吧，既然变量声明可以多个，返回值估计也可以多个吧，大概其机理是一样的。



我感觉go最大的特点就是type放在变量名后面哈哈



### import导包

包名一般是跟文件名保持一致，便于查阅。

> go 里面一个目录为一个package, 一个package级别的func, type, 变量, 常量, 这个package下的所有文件里的代码都可以随意访问, 也不需要首字母大写.

一般导包的时候，就去GOROOT和GOPATH下面依此去找，注意不会自动-r，所以得写全路径

函数名首字母大小写决定是当前包私有函数还是公有函数。（对象以及对象中的方法也是通过首字母大小写的语法机制来区分）=>相当于C中的static



这个import有点C的include头文件感觉



golang也支持指针，虽然不常用



### defer

```
package main

import "fmt"

func main() {
	//写入defer关键字
	defer fmt.Println("main end1")
	defer fmt.Println("main end2")


	fmt.Println("main::hello go 1")
	fmt.Println("main::hello go 2")
}
```

`defer`关键词，字面上就是推迟执行的意思了，如上图，表示fmt.Println在main结束之际执行，常用于打开某个文件时立即`defer`一个关闭函数；

可以有多个`defer`关键字，实际上就是个压栈过程，所以先进后出。

`defer`甚至比`return`都后执行...



### slice

数组：固定数组与动态数组(slice)的区别，一般就只用动态数组

```
package main

import "fmt"


func printArray1(myArray1 [10]int) {
	//值拷贝，与C数组传参，退化为指针完全不同

	//golang中的range有python中enumerate的影子，能同时返回索引和值
	for index, value := range myArray1 {
		fmt.Println("index = ", index, ", value = ", value)
	}

	myArray1[0] = 100
}

func printArray2(myArray2 []int) {
	//引用传递，这就跟C数组传参，传指针一样了
	
	for index, value := range myArray2 {
		fmt.Println("index = ", index, ", value = ", value)
	}

	myArray2[0] = 100
}

func main() {
    myArray1 := [10]int{1,2,3,4} //固定数组
	myArray2 := []int{1,2,3,4} // 动态数组，切片 slice

	fmt.Printf("myArray1 type is %T\n", myArray1)
	printArray1(myArray1)

	fmt.Printf("myArray2 type is %T\n", myArray2)
	printArray2(myArray2)

	fmt.Println(" ==传参修改之后== ")

	// _ 表示匿名的变量
	for _, value := range myArray1 {
		fmt.Println("myArray1 value = ", value)
	}
	for _, value := range myArray2 {
		fmt.Println("myArray2 value = ", value)
	}
}
```

slice(动态数组)的len和cap不同，cap表示容量，其实隐含着slice的动态扩容机制。

而关于切片的截取就跟python一样，需要注意的是，截取后新的slice其实跟原slice指向同一块内存地址，如果要新备份出来的话，要先开辟内存，然后再调用copy函数进行截取。



Golang中的内存申请删除函数：make(), delete()



Golang中的`map`就是跟Python中的`dictionary`一样，是一个`key:value`键对形式的数据结构。

需要注意的是无论是`map`还是`dictionary`为什么是无序的？因为它们底层都是基于hash表实现的，即首先根据这个key求得一个hash值，然后再根据hash表求得index值，而这个index就跟内存偏移量相关，所以对于key而言的话，遍历一般是无序的。



### 面向对象

原来结构体struct主要就C/C++有，JAVA/Python都没有，而Golang中保留了。



```
package main

import "fmt"

//如果类名首字母大写，表示其他包也能够访问
type Hero struct {
	//如果说类的属性首字母大写, 表示该属性是对外能够访问的，否则的话只能够类的内部访问
	Name  string
	Ad    int
	level int
}

/*
func (this Hero) SetName(newName string) {
	//this 是调用该方法的对象的一个副本（拷贝）
	this.Name = newName
}
*/

func (this *Hero) SetName(newName string) {
	//this *是调用该方法的对象自身
	this.Name = newName
}
```

如上，Golang上的面向对象是基于结构体的，通过使用`this`在结构体外绑定方法组合成一个对象表示。



关于Golang中对象的继承，直接将父类名写在子类的结构体中就继承了，很简洁，方法可以重写，就没有各种私有共有继承之分，对外就是包外包内这个分隔线。



所谓多态：1.有一个父类；2.子类去各自实现父类的方法；3.父类的变量指针指向子类实现的方法；

就形成了，用父类调用，但呈现的确实各种各样子类的方法，呈现多态现象。

Golang中实现多态的方法是通过接口interface，（接口跟虚基类基本就一样吧）Golang中接口名就是个指针。



### reflect

By the way，interface{}还可以当万能数据类型，相当于C中的void*, 但是有更多功能，比如类型断言机制。

我推测：在C语言中，程序运行时应该是没有数据类型的信息的，所以没有相关操作去专门获取数据对应的类型，但是在编译阶段的语义分析阶段，编译器自身（注意不是该程序自身）应该是维护着该程序数据与类型对应的结构体信息，所以编译时类型不匹配时会报warning。进一步讲，程序运行时虽然没有相关数据类型的信息，但是编译器已将将其转化为特定的寻址方式，比如说float类型与int类型存取时的寄存器就不一样，这已经反映在编译后的汇编代码里，也正因为如此，一定程度可以反汇编。

与C相比较而言，Golang它程序自身估计也有类似编译器一样的数据与类型对应的结构体信息，这应该就是作者所说的`变量的内置pair结构`，所以interface{}不仅可以通过数据名去判断其值，而且可以通过数据名去断言其类型。

然后Golang的reflect包就是基于以上所说的原理使Golang能够实现这种所谓的reflect机制。

reflect机制不仅能够断言其类型，数据其它类型也是可以获取的，比如说在Golang中有结构体标签的说法，如下的`json:"title"`等，json数据包通过reflect机制（？有点不确定，但底层原理大概一样）获取结构体中的json标签，这就非常方便json与结构体之间的相互转化。

```
package main

import (
	"encoding/json"
	"fmt"
)

type Movie struct {
	Title  string   `json:"title"`
	Year   int      `json:"year"`
	Price  int      `json:"rmb"`
	Actors []string `json:"actors"`
}

func main() {
	movie := Movie{"喜剧之王", 2000, 10, []string{"xingye", "zhangbozhi"}}

	//编码的过程  结构体---> json
	jsonStr, err := json.Marshal(movie)
	if err != nil {
		fmt.Println("json marshal error", err)
		return
	}

	fmt.Printf("jsonStr = %s\n", jsonStr)

	//解码的过程 jsonstr ---> 结构体
	//jsonStr = {"title":"喜剧之王","year":2000,"rmb":10,"actors":["xingye","zhangbozhi"]}
	myMovie := Movie{}
	err = json.Unmarshal(jsonStr, &myMovie)
	if err != nil {
		fmt.Println("json unmarshal error ", err)
		return
	}

	fmt.Printf("%v\n", myMovie)
}
```



## Golang的并发机制

### goroutine

协程（co-routine)应该就是用户级线程，然后在Golang语言中被称为goroutine, 并且goroutine在内存开销以及切换速度上做了一定的优化。

照理来说，用户级线程没什么意思...但Golang采用核心级线程与用户级线程多对多的形式，通过优化它们之间的协程调度器，内部完成多并发的机制。大概是因为协程创建数量上没有限制，程序可以被分为无数多的time slice，然后通过协程调度器分发到多个核心级线程完成并行，所以Golang程序在多核处理器的机器上才能发挥出它的优势来吧，否则也谈不上什么并行，当然并发是可以的，但意义在哪？

然后，Golang创建goroutine语法上非常简洁，用一个`go`关键字就可以起协程：

```
package main

import (
	"fmt"
	"time"
)

//子goroutine
func newTask() {
	i := 0
	for {
		i++
		fmt.Printf("new Goroutine : i = %d\n", i)
		time.Sleep(1 * time.Second)
	}
}

//主goroutine
func main() {
	//创建一个go程 去执行newTask() 流程
	go newTask()

	//死循环，防止主线程跑完，协程全结束
	for {
		time.Sleep(1 * time.Second)
	}
}

```

也可以用匿名函数直接定义在main中创建协程，协程用`runtime.Goexit`退出。

### channel

协程之间通过channel通信，感觉类似于进程之间的消息队列，通过`make`就可以创建一个channel，也很简洁，下例中这个channel事实上无缓冲，但是其内在是有同步两个协程的作用，即发送后未接收，或接收时没数据，各自协程会阻塞，从而双方达到同步。

```
package main

import "fmt"

func main() {
	//定义一个channel
	c := make(chan int)

	go func() {
		defer fmt.Println("goroutine结束")

		fmt.Println("goroutine 正在运行...")

		c <- 666 //将666 发送给c
	}()

	num := <-c //从c中接受数据，并赋值给num

	fmt.Println("num = ", num)
	fmt.Println("main goroutine 结束...")
}
```

当然也可以创建有缓存的channel，同样有同步机制（细节上略微不同），如下

```
c := make(chan int, 3) //带有缓冲的channel
```

可以用`close`关闭channel，关闭后可以从那里接收数据，但不能往里面写了：

```
close(c)
```

可以使用range来迭代不断操作channel：

```
	for data := range c {
		fmt.Println(data)
	}
```

单流程下一个go只能监视一个channel的状态，select可以完成对多个channel的监控，类似C语言中select函数监视多个socket等IO状态：

```
for {
		select {
		case c <- x:
			//如果c可写，则该case就会进来
			x = y
			y = x + y
		case <-quit:
			//如果quit可读，则该case就会进来
			fmt.Println("quit")
			return
		}
	}
```



## 项目案例：即时通信系统

### 基础server构建

写个入口函数main，然后建立一个server的对象，启动server的函数，包裹**socket,listen,accept,close**等socket函数，每accept到一个消息，就go一个协程去处理；

### 用户上线及广播功能

在server中创建用户对象，即之前accept到一个消息，就go的协程中，创建一个用户对象，然后加入到server对象中的管理用户表，然后go一条用户的listen协程来接受广播，如下：

```
main routine--------------------------------------------------------------------------
                |
                server listern routine--------------------------------------------------------
                                        |
                                        accept and handler routine-----------------------------------------
                                                                      |
                                                                      usr listen routine-------------------------
```

这样如果有两个用户连到服务器，则有3+1*2=5条协程，广播即是accept到一个新用户，就往各个usr协程中channel写入信息“上线”，而usr协程中有**write**这个socket函数，在客户端界面就可以打印出“上线”；

### 用户消息广播功能

在每个usr协程里写**read**这个socket函数，去channel里读别的usr协程写的信息，并打印出来；

...