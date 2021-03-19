# Structure and Interpretation of Computer Programs (Python)

## 1.1 引言

> 从零开始，一步一步构建整个语言。

本书一个主干线，去追寻这个过程很重要。

> 广泛地说，计算机程序包含的语句：计算某个值，或执行某个操作

好像是这么一回事...

> 函数是对象，对象是函数，解释器是二者的实例。然而，对这些概念，以及它们在代码组织中的作用的清晰理解，是掌握编程艺术的关键。

看了这本书，去同意编程为什么是一种艺术的观点。是不是函数第一章，对象第二章，解释器第三章？

## 1.2 编程元素

> 在编程中，我们处理两种元素：函数和数据。数据是我们想要操作的东西，函数描述了操作数据的规则。

> 一种基本表达式就是数值。

对于Python而言，单一个数字它就是一个表达式。

> 任何运算符都可以表示为带有名字的函数。如 + => add(x,y)

可以简单认为“2 + 3”就是add(2, 3)的快捷方式。这个观点很重要，program=data+procedure，而data与procedure本质上也是一样的。

**回头看：** 最基本的概念什么？表达式（数值）和 表达式的绑定（即赋值语句，最基础的抽象）。然后是调用表达式（数值+运算符）。运算符本质上就是函数，这里就引出了第一章的主题，函数。进一步稍微复杂一点，函数可以嵌套。

## 1.3 定义新的函数

> 1.  数值是内建数据，算数运算是函数。
> 2.  嵌套函数提供了组合操作的手段。
> 3.  名称到值的绑定提供了有限的抽象手段。
>

组合，抽象这么形而上的概念其实就在最基础的操作中。

> 名称绑定到值上面

这其实是python不同于C的一个设计视角，"="用绑定来代替赋值这一说法。

如果用这本书来学习python，那就酸爽了...

> 函数定义应该能够隐藏细节。函数的用户可能不能自己编写函数，但是可以从其它程序员那里获得它作为“黑盒”。用户不应该需要知道如何实现来调用。Python 库拥有这个特性。许多开发者使用在这里定义的函数，但是很少有人看过它们的实现。实际上，许多 Python 库的实现并不完全用 Python 编写，而是 C 语言。

黑盒概念就这吗...    

原来许多Python库用C写...有意思

## 1.4 实践指南：函数的艺术

> 不要重复劳动（DRY）是软件工程的中心法则。所谓的DRY原则规定多个代码段不应该描述重复的逻辑。

> 当你以函数名称作为参数来调用`help`时，你会看到它的文档字符串

相当于Linux的man。

## 1.5 控制

> 我们现在也能理解多行的程序了。
>
> + 执行语句序列需要执行第一条语句。如果这个语句不是重定向控制，之后执行语句序列的剩余部分，如果存在的话。
>
> 这个定义揭示出递归定义“序列”的基本结构：一个序列可以划分为它的第一个元素和其余元素。语句序列的“剩余”部分也是一个语句序列。所以我们可以递归应用这个执行规则。这个序列作为递归数据结构的看法会在随后的章节中再次出现。
>
> 这一规则的重要结果就是语句顺序执行，但是随后的语句可能永远不会执行到，因为有重定向控制。

这个翻译得佶屈聱牙，但还是可以看出原文对编程的理解非常unique，如这个多行程序的说明。

> 我们已经看到了重复的一种形式：一个函数可以多次调用，虽然它只定义一次。迭代控制结构是另一种将相同语句执行多次的机制。

重复归根到底就是递归和迭代。

> **断言。**程序员使用`assert`语句来验证预期，例如测试函数的输出。

C语言中也有断言，但这种测试方式效率一般，用GDB不香嘛。

> 我们可以这样理解我们已经见到的语句：
>
> + 表达式、返回语句和赋值语句都是简单语句。
> + `def`语句是复合语句。`def`头部之后的组定义了函数体。

> 通常，Python 的代码是语句的序列。一条简单的语句是一行不以分号结束的代码。复合语句之所以这么命名，因为它是其它（简单或复合）语句的复合。复合语句一般占据多行，并且以一行以冒号结尾的头部开始，它标识了语句的类型。同时，一个头部和一组缩进的代码叫做子句（或从句）。复合语句由一个或多个子句组成。

**回头看：** 接着1.2讲，函数由什么组成？语句。表达式、返回语句和赋值语句(逗号在赋值语句中分隔了多个名称和值)都是简单语句。其基础上有def（定义），if（条件），while（重复）等复合语句。（语句的序列实质上也是个first+rest的递归结构。）

> 要记住逗号在赋值语句中分隔了多个名称和值。

这本书很多东西都讲到C基础python语言学习者的盲点上

## 1.6 高阶函数

> 通常，缺少函数定义会对我们非常不利，它会强迫我们始终工作在特定操作的层级上，这在语言中非常原始（这个例子中是乘法），而不是高级操作。我们应该从强大的编程语言索取的东西之一，是通过将名称赋为常用模式来构建抽象的能力，以及之后直接使用抽象的能力。函数提供了这种能力。

这样来说，看CSAPP，其实是一个寻根究底，解构抽象的过程。

```
def <name>(n):
    total, k = 0, 1
    while k <= n:
        total, k = total + <term>(k), <next>(k)
    return total
```

> 这个通用模板的出现是一个强有力的证据，证明有一个实用抽象正在等着我们表现出来。这些函数的每一个都是式子的求和。作为程序的设计者，我们希望我们的语言足够强大，便于我们编写函数来自我表达求和的概念，而不仅仅是计算特定和的函数。我们可以在 Python 中使用上面展示的通用模板，并且把槽位变成形式参数来轻易完成它。

回想来骆昊python100天中没有提到模板啊；另外C中函数做返回值因该有，但是作为实参没看见过，但理论上而言是可以的，形参就是个函数指针嘛。

> 首先，命名和函数允许我们抽象而远离大量的复杂性。当每个函数定义不重要时，由求值过程触发的计算过程是相当复杂的，并且我们甚至不能展示所有东西。其次，基于事实，我们拥有了非常通用的求值过程，小的组件组合在复杂的过程中。理解这个过程便于我们验证和检查我们创建的程序。

就自己从事的过程化编码来看，逐步操作流程，抽象上其实做得一般，感受不到任何算法的复杂性。上面的理解其实在一个架构师的水平上看待程序。

> 就像局部赋值，局部的`def`语句仅仅影响当前的局部帧。

防止全局帧被小型函数弄乱，也是python的一个特点。

关于词法作用域，有C基础，就有判断力。

> 牛顿法是一个传统的迭代方法，用于寻找使数学函数返回值为零的参数。是一个用于解决微分方程的强大的通用计算方法。

实际上是一个利用函数的递归来求导的过程。

> Python 提供了特殊的语法，将高阶函数用作执行`def`语句的一部分，叫做装饰器。

```
>>> def trace1(fn):
        def wrapped(x):
            print('-> ', fn, '(', x, ')')
            return fn(x)
        return wrapped
>>> @trace1
    def triple(x):
        return 3 * x
>>> triple(12)
->  <function triple at 0x102a39848> ( 12 )
36
```

等价于：

```
>>> def triple(x):
        return 3 * x
>>> triple = trace1(triple)
```

装饰器是个语法糖，比较费解。从上例来看，@function形式上参数与返回值都需要是函数指针，由此才能等价。

逻辑上费解的在于：wrapped定义在局部帧的地址作为返回值赋予triple不矛盾？另外x是如何形式传进去trace1中的？难道在传参以及返回值的时候不是函数地址，默认进行了函数的调用？

回答：装饰之后，triple函数其实已经变为wrapped了；理解为triple = trace1(triple)对triple 重新赋值后进行triple(12)调用，这个时候12作为wrapped(x)中的参数进行相关操作，然后最终在return中对原本的triple进行调用。综合上述，可见装饰器结构之精巧...

> Lambda 表达式是函数体具有单个返回表达式的函数，不允许出现赋值和控制语句。

这个类似于C中的difine，但进一步具有匿名性。

**回头看：**  讲了函数可以作为参数，返回值，是语言的一等元素，可以被嵌套定义，高阶函数可以像操作数据一样去操作函数（进一步构建抽象，所以本书除了递归之外，另一个重要概念应该是抽象）。然后提了如果不需要给函数过程绑定名称就可以用匿名函数Lambda，外加了个语法糖装饰器。

## 2.1 引言

> 我们区分了函数和数据：函数执行操作，而数据被操作。当我们在数据中包含函数值时，我们承认数据也拥有行为。函数可以像数据一样被操作，但是也可以被调用来执行计算。

从这个角度上讲data和procedure是同一的。

> Python 包含了三个原始数值类型：整数（`int`）、实数（`float`）和复数（`complex`）。

注意原始数值这个概念，之后所有的抽象数据类型都是基于此构建起来，最终形成一个python大厦。

## 2.2 数据抽象

通过有理数的构造过程，来展示抽象的层次。表现为几分之几的有理数数据结构由二元元组(偶对的形式)来实现，而元组的下标访问方式其实可以用另一种逻辑函数来实现（即可以同样通过函数来实现偶对），从另一个角度表明函数可以像元组一样作为一等对象。

> 编程语言中的一等对象定义为：运行时创建，可赋值给变量或数据结构，可作为参数传递，可作为返回值返回。

这边更重要的一点是，这里的偶对可以通过函数操作原始数值类型来实现，可以看成是函数，而元组就是个扩展了的偶对。

## 2.3 序列

> 嵌套偶对

```
>>> ((1, 2), (3, 4))
((1, 2), (3, 4))
```

> 我们将这种将元组以这种方式嵌套的能力叫做元组数据类型的封闭性。通常，如果组合结果自己可以使用相同的方式组合，组合数据值的方式就满足封闭性。封闭性在任何组合手段中都是核心能力，因为它允许我们创建层次数据结构 -- 结构由多个部分组成，它们自己也由多个部分组成，以此类推。

> 递归列表

```
>>> (1, (2, (3, (4, None))))
(1, (2, (3, (4, None))))
```

> 这个嵌套的结构通常对应了一种非常实用的序列思考方式，一个非空序列可以划分为：
>
> + 它的第一个元素，以及
> + 序列的其余部分。

上面说明了列表是可以基于偶对去实现的。

可以用迭代来实现长度和元素选择。（注意Python 的内建序列类型以不同方式实现，它对于计算序列长度和获取元素并不具有大量的计算开销。）

> **映射。**将一个元组变换为另一个元组的强大手段是在每个元素上调用函数，并收集结果。这一计算的常用形式叫做在序列上映射函数，对应内建函数`map`。它是元组的构造器。

> 映射本身就是通用计算模式的一个实例：在序列中迭代所有元素。为了在序列上映射函数，我们不仅仅需要选择特定的元素，还要依次选择每个元素。这个模式非常普遍，Python 拥有额外的控制语句来处理序列数据：`for`语句。

从这个描述上来看，不是既存的for追加功能去操作序列，而是因为序列引进了for语法。这本书介绍python完全是另一套思维，妙不可言。（第一章讲函数如何迭代重复是特地用了while来表示）

```
>>> pairs = ((1, 2), (2, 2), (2, 3), (4, 4))
>>> for x, y in pairs:
        if x == y:
            same_count = same_count + 1
>>> same_count
2
```

> 程序中的一个常见模式是，序列的元素本身就是序列，但是具有固定的长度。`for`语句可在头部中包含多个名称，将每个元素序列“解构”为各个元素。这个绑定多个名称到定长序列中多个值的模式，叫做序列解构。它的模式和我们在赋值语句中看到的，将多个名称绑定到多个值的模式相同。

> `range`是另一种 Python 的内建序列类型，它表示一个整数范围。范围可以使用`range`函数来创建，它接受两个整数参数：所得范围的第一个数值和最后一个数值加一。

```
>>> for _ in range(3):
        print('Go Bears!')

Go Bears!
Go Bears!
Go Bears!
```

> 常见的惯例是将单下划线字符用于`for`头部，如果这个名称在语句组中不会使用。要注意对解释器来说，下划线只是另一个名称，但是在程序员中具有固定含义，它表明这个名称不应出现在任何表达式中。

我觉得这本书说for语法的每一个点都说到心坎上去了，相较于C，python中for的改造在哪里？

> Python 没有单独的字符类型，任何文本都是字符串，表示单一字符的字符串长度为 1

字符串和tuple，list等均为python的序列类型，以此角度反思C，其实就数组和链表两种序列，字符串只是数组的一种特殊形式。

> 生成器表达式组合了过滤和映射的概念，并集成于单一的表达式中，以下面的形式：

```
<map expression> for <name> in <sequence expression> if <filter expression>
```

> 生成器表达式是使用可迭代（例如序列）接口约定的特化语法。这些表达式包含了`map`和`filter`的大部分功能，但是避免了被调用函数的实际创建（或者，顺便也避免了环境帧的创建需要调用这些函数）。

记不起来何处特别说明了生成器表达式与单纯将将函数链接成流水线两者效率上的差别。但从汇编角度上来思考，又不存在重复步骤，效率上不应该有很大差距啊...

## 2.4 可变数据

非常有意思，本书先介绍数值，布尔值，文本值（字符串），元组等不可变的原生数据类型。这又提供了以下问题的额外视角：有了list之后为什么还要tuple？因为list在tuple的基础上进行想象。SICP组织python的介绍顺序真是不一样...

> 通过引入`nonlocal`语句，我们发现了赋值语句的双重作用。它们修改局部绑定，或者修改非局部绑定。实际上，赋值语句已经有了两个作用：创建新的绑定，或者重新绑定现有名称。

nonlocal有点类似于C中的static，放到这章讲，是作为可变数据的第一个例子。通过之前的学习，我们知道函数也是一种数据类型，特地分了纯函数和非纯函数，它们之间最本质的区别就是是否可变。前者只要特定的参数，return肯定是不变的，后者假若引进nonlocal变量，return值就是可变的。

> 之前，我们的值并没有改变，仅仅是我们的名称和绑定发生了变化。当两个名称`a`和`b`绑定到`4`上时，它们绑定到了相同的`4`还是不同的`4`并不重要。我们说，只有一个`4`对象，并且它永不会改变。

所以python与C中关于“=”的意义是不一样的。

> Python 引入了两个比较运算符，叫做`is`和`is not`，测试了两个表达式实际上是否求值为同一个对象。如果两个对象的当前值相等，并且一个对象的改变始终会影响另一个，那么两个对象是同一个对象。身份是个比相等性更强的条件。

为了去补救重新绑定的操作引起的认识论问题：它对于两个相同的值意味着什么。（如果清楚C中指针的概念的话，其实就很好理解）。对于不可变类型，值相同对象就相同，对于可变类型就不尽然。

```
>>> from unicodedata import lookup
>>> [lookup('WHITE ' + s.upper() + ' SUIT') for s in suits]
['♡', '♢', '♤', '♧']
```

> 列表推导式使用扩展语法来创建列表，与生成器表达式（元组）的语法相似使用序列的接口约定增强了数据处理的范式

此处反过来去理解上一章中的序列的接口约定：对于输入输出均为序列的procedure，如何使用通用的计算模式，例如映射、过滤和累计，来组合序列的接口约定上的操作。

> 列表是序列，就像元组一样。Python 语言并不提供给我们列表实现的直接方法，只提供序列抽象，和我们在这一节介绍的可变方法。为了克服这一语言层面的抽象界限，我们可以开发列表的函数式实现，再次使用递归表示。

这个想法上挺好的，像一般的教材，给你一个list，你就直接接受了这层抽象概念。但其实去探究list可以怎样去实现，归根到底是递归函数，注意：简而言之list是一个函数！结合上面所说的nonlocal去理解它的非纯函数的性质。怪不得人家介绍SICP时，总是特意强调递归这个概念。

> 字典的目的是提供一种抽象，用于储存和获取下标不是连续整数，而是描述性的键的值。
>

字典的底层实现跟列表无异吧。

本章最后一节组合了非局部赋值、列表和字典来构建一个基于约束的系统，支持多个方向上的计算。这真是开了我的眼界，理解连接器和约束，把它们看成key为函数名，value为函数过程去理解。最新颖在于这个这个基于约束网络特征的无方向计算。

## 2.5 面向对象编程

> 点运算符是 Python 的语法特征，它形成了消息传递的隐喻。

类与方法之间的点可以视作为一个运算符。其实我这个浸淫C多年的coder刚看python就对这个点运算符比较懵逼。点运算符隐式地把方法的第一个参数设为了self。ps这本书的叙述也非常有意思。

> 所有包含点运算符的赋值语句都会作用于右边的对象。如果对象是个实例，那么赋值就会设置实例属性。如果对象是个类，那么赋值会设置类属性。作为这条规则的结果，对对象属性的赋值不能影响类的属性。

也就是说，对象的方法可以重新赋值来重载类本身的方法。

## 2.6 实现类和对象

> 字典本身是抽象数据类型。我们使用列表来实现字典，我们使用偶对来实现列表，并且我们使用函数来实现偶对。就像我们以字典实现对象系统那样，要注意我们能够仅仅使用函数来实现对象。

结论是即使编程语言没有面向对象系统，程序照样可以面向对象。

```
def make_instance(cls):
    """Return a new object instance, which is a dispatch dictionary."""

    def get_value(name):
        if name in attributes:
            return attributes[name]
        else:
            value = cls['get'](name)
            return bind_method(value, instance)

    def set_value(name, value):
        attributes[name] = value

    attributes = {}
    instance = {'get': get_value, 'set': set_value}
    return instance

def bind_method(value, instance):
    """Return a bound method if value is callable, or value otherwise."""
    if callable(value):
        def method(*args):
            return value(instance, *args)

        return method
    else:
        return value

def make_class(attributes, base_class=None):
    """Return a new class, which is a dispatch dictionary."""

    def get_value(name):
        if name in attributes:
            return attributes[name]
        elif base_class is not None:
            return base_class['get'](name)

    def set_value(name, value):
        attributes[name] = value

    def new(*args):
        return init_instance(cls, *args)

    cls = {'get': get_value, 'set': set_value, 'new': new}
    return cls

def init_instance(cls, *args):
    """Return a new object with type cls, initialized with args."""
    instance = make_instance(cls)
    init = cls['get']('__init__')
    if init:
        init(instance, *args)
    return instance

def make_account_class():
    """Return the Account class, which has deposit and withdraw methods."""

    def __init__(self, account_holder):
        self['set']('holder', account_holder)
        self['set']('balance', 0)

    def deposit(self, amount):
        """Increase the account balance by amount and return the new balance."""
        new_balance = self['get']('balance') + amount
        self['set']('balance', new_balance)
        return self['get']('balance')

    def withdraw(self, amount):
        """Decrease the account balance by amount and return the new balance."""
        balance = self['get']('balance')
        if amount > balance:
            return 'Insufficient funds'
        self['set']('balance', balance - amount)
        return self['get']('balance')

    return make_class({'__init__': __init__,
                       'deposit': deposit,
                       'withdraw': withdraw,
                       'interest': 0.02})

def main():
    Account = make_account_class()
    jim_acct = Account['new']('Jim')

    jim_acct['get']('holder')
    jim_acct['get']('interest')
    jim_acct['get']('deposit')(20)
    jim_acct['get']('withdraw')(5)

    print("OOP结束")

if __name__ == '__main__':
    main()
```

以上代码是十分类似于 Python 内建对象系统的实现的构建在字典上的对象系统，可以在pycharm中使用debugger来看一下类与对象是如何建立起来的。先创建类，从外层的类到基类，调用层层深入进去，然后实例化对象，从基类开始往外依此调用初始化函数最终抵达实例。（比喻来说，创建时先一层层进去拿到最核心的字典，即基类的字典，然后实例化时在从这个核一层层出来，包裹各层次之间的颜料，最后形成实例。）

每一个层次的字典（可以理解为方法集）都不一样，就可以理解类与对象各自有相应的方法，某种程度上类似于类与基类，从而也能理解各个层次间方法重载的机制，先是调用实例中的方法，如果找不到，就去类中寻找，并绑定到实例中执行。虽然也就一知半解，但感觉非常棒！

另一方面我们也可以理解为什么C的编译器可以用C来编写，因为就如同Python的某些机制如类与对象可以由更为低层次的抽象概念字典与函数来实现一样，语言的建构是一个不断抽象累积的过程。

## 2.7 泛用方法

> 数据值的字符串表示在类似 Python 的交互式语言中尤其重要，其中“读取-求值-打印”的循环需要每个值都拥有某种字符串表示形式。

这里的数据值同样包括ADT，即自己构造的数据类型，这就要求对于每一个ADT都要去实现字符串表示这个功能。字符串的构造函数`str`返回人类可读的字符串，它在参数上调用了叫做`__str__`的方法。因此每个ADT要去实现针对自身的`__str__`，从而展现了这个函数的多态性。

> 抽象数据类型由构造器、选择器和额外的行为条件定义。与之紧密相关的概念是接口，它是共享消息的集合，带有它们含义的规定。响应`__str__`特殊方法的对象都实现了通用的接口，它们可以表示为字符串。

> 术语“抽象数据类型”（ADT）和“接口”的关系是微妙的。ADT 包含构建复杂数据类的方式，以单元操作它们，并且可以选择它们的组件。在面向对象系统中，ADT 对应一个类，虽然我们已经看到对象系统并不需要实现 ADT。接口是一组与含义关联的消息，并且它可能包含选择器，也可能不包含。概念上，ADT 描述了一类东西的完整抽象表示，而接口规定了可能在许多东西之间共享的行为。

读到这里时候，ADT与接口的概念的记忆已经很模糊了。

> 在JAVA中，如果一个类只由抽象方法和全局常量组成，那么这种情况下不会将其定义为一个抽象类。只会定义为一个接口，所以接口严格的来讲属于一个特殊的类，而这个类里面只有抽象方法和全局常量，就连构造方法也没有。

以`__str__`为例，可以先用ADT实例化一个对象，然后implements 有关于`__str__`的interface，翻译过来就是数据类型（ADT）XX实现了YY的接口。但python中似乎不用显式地表示implements的过程...

> Python 拥有一个简单的特性，用于从零个参数的函数凭空计算属性（Attribute）。`@property`装饰器允许函数不使用标准调用表达式语法来调用。

装饰器将方法变成属性一样，这里的凭空计算属性的说法就很有意思。

## 3.1 引言

> 第一章和第二章描述了编程的两个基本元素：数据和函数之间的紧密联系。我们看到了高阶函数如何将函数当做数据操作。我们也看到了数据可以使用消息传递和对象系统绑定行为。

> 典型的解释器拥有简洁的通用结构：两个可变的递归函数，第一个求解环境中的表达式，第二个在参数上调用函数。这一章接下来的两节专注于递归函数和数据结构，它们是理解解释器设计的基础。

开始做解释器了，如上所说，目前还不理解。

## 3.2 函数和所生成的过程

以下是C写的Fibonacci数列递归调用，可以从汇编的角度去理解递归函数：函数前半段不断重复进去到底，然后后半段不断重复出来到最外层。（而尾部递归函数就省略后半段）

```
#include <stdio.h>

int func( int n )
{
        int value = 0;
        if( n ==  1 )
        {
                value = 1;
        }
        else if( n == 2 )
        {
                value = 2;
        }
        else
        {
                value = func( n - 1) + func( n - 2);
        }

        return value;
}

int main()
{
        int value = 0;
        int n = 3;

        scanf("%d", &n );

        value = func( n );

        printf("output is %d\n", value);

        return 0;
}
```

```
	.file	"main.c"
	.text
.globl func
	.type	func, @function
func:
.LFB2:
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	pushq	%rbx
.LCFI2:
	subq	$24, %rsp
.LCFI3:
	movl	%edi, -28(%rbp)
	movl	$0, -12(%rbp)
	cmpl	$1, -28(%rbp)
	jne	.L2
	movl	$1, -12(%rbp)
	jmp	.L4
.L2:
	cmpl	$2, -28(%rbp)
	jne	.L5
	movl	$2, -12(%rbp)
	jmp	.L4
.L5:
	movl	-28(%rbp), %edi
	subl	$1, %edi
	call	func
	movl	%eax, %ebx
	movl	-28(%rbp), %edi
	subl	$2, %edi
	call	func
	leal	(%rbx,%rax), %eax
	movl	%eax, -12(%rbp)
.L4:
	movl	-12(%rbp), %eax
	addq	$24, %rsp
	popq	%rbx
	leave
	ret
.LFE2:
	.size	func, .-func
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"output is %d\n"
	.text
.globl main
	.type	main, @function
main:
.LFB3:
	pushq	%rbp
.LCFI4:
	movq	%rsp, %rbp
.LCFI5:
	subq	$16, %rsp
.LCFI6:
	movl	$0, -4(%rbp)
	movl	$3, -8(%rbp)
	leaq	-8(%rbp), %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	scanf
	movl	-8(%rbp), %edi
	call	func
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	ret  
```

> 通常把递归调用看做函数抽象更清晰一些。也就是说，我们不应该关心`fact(n-1)`如何在`fact`的函数体中实现；我们只需要相信它计算了`n-1`的阶乘。将递归调用看做函数抽象叫做递归的“信仰飞跃”（leap of faith）。

> 通常，迭代函数必须维护一些局部状态，它们会在计算过程中改变。在任何迭代的时间点上，状态刻画了已完成的结果，以及未完成的工作总量。

所以递归与迭代思考方式上是截然不同的。

> 我们使用记忆函数的例子展示了编程中的通用模式，即通常可以通过增加所用空间来减少计算时间，反之亦然。

可以对递归的Fibonacci函数加上个记忆函数，来使计算量变成线性。

提出一个增长度的概念来描述算法计算量，这点在算法和数据结构中是核心概念。

## 3.3 递归数据结构

> 嵌套表达式和树形数据结构的联系，在我们这一章稍后对解释器设计的讨论中起到核心作用。

先mark。树形数据结构借用偶对的嵌套来形成。

> 除了列表、元组和字典之外，Python 拥有第四种容器类型，叫做`set`。

SICP只是编排方式独具特色，该讲的都还是讲到啊...为什么这里讲呢，因为set不是有序序列，它是无序的容器。

本节先介绍了之前的递归列表（即first与rest集）和树形结构，在此基础上介绍了集合的三种实现方法，分别是无序集合，有序集合以及平衡二叉树集合，来比较应用于各种计算交并等的优劣，这事实上就是算法和数据结构的内容，所以SICP这本书非常综合性。ps python内建的集合构造不同于书中所提三种方式。

## 3.4 异常

> 异常在使用 Python 实现解释器时是个非常实用的特性。

## 3.5 组合语言的解释器

> 编程语言的解释器是一个函数，它在语言的表达式上调用，执行求解表达式所需的操作。

> 解析器实际上由两个组件组成，词法分析器和语法分析器。首先，词法分析器将输入字符串拆成标记（token），它们是语言的最小语法单元，就像名称和符号那样。其次，语法分析器从这个标记序列中构建表达式树。

这一节就是编译原理的内容...词法分析器和语法分析器简而言之就是两个函数。

简而言之，构造计算器语言的解释器：在“读取-求值-打印”循环的交互模式中（一个loop），利用词法分析器和语法分析器去解析原始文本输入生成表达式树，中间通过异常机制健壮语法错误检查，然后将表达式树输入计算逻辑函数得出结果。然后，你输入符合语法的字符串（代码文本）就可以被相应执行。

补充一点是，表达式本身也可以算做一个operand，以此定义一个类来表示嵌套。

```
from operator import mul
from functools import reduce


class Exp(object):
    """A call expression in Calculator."""

    def __init__(self, operator, operands):
        self.operator = operator
        self.operands = operands

    def __repr__(self):
        return 'Exp({0}, {1})'.format(repr(self.operator), repr(self.operands))

    def __str__(self):
        operand_strs = ', '.join(map(str, self.operands))
        return '{0}({1})'.format(self.operator, operand_strs)

#Syntactic analysis
def calc_apply(operator, args):
    """Apply the named operator to a list of args."""
    if operator in ('add', '+'):
        return sum(args)
    if operator in ('sub', '-'):
        if len(args) == 0:
            raise TypeError(operator + ' requires at least 1 argument')
        if len(args) == 1:
            return -args[0]
        return sum(args[:1] + [-arg for arg in args[1:]])
    if operator in ('mul', '*'):
        return reduce(mul, args, 1)
    if operator in ('div', '/'):
        if len(args) != 2:
            raise TypeError(operator + ' requires exactly 2 arguments')
        numer, denom = args
        return numer / denom


def calc_eval(exp):
    """Evaluate a Calculator expression."""
    if type(exp) in (int, float):
        return exp
    elif type(exp) == Exp:
        arguments = list(map(calc_eval, exp.operands))
        return calc_apply(exp.operator, arguments)

def analyze_operands(tokens):
    """Analyze a sequence of comma-separated operands."""
    assert_non_empty(tokens)
    operands = []
    while tokens[0] != ')':
        if operands and tokens.pop(0) != ',':
            raise SyntaxError('expected ,')
        operands.append(analyze(tokens)) #recursively call analyze
        assert_non_empty(tokens)
    tokens.pop(0)  # Remove )
    return operands


def analyze_token(token):
    """Return the value of token if it can be analyzed as a number, or token."""
    try:
        return int(token)
    except (TypeError, ValueError):
        try:
            return float(token)
        except (TypeError, ValueError):
            return token


def assert_non_empty(tokens):
    """Raise an exception if tokens is empty."""
    if len(tokens) == 0:
        raise SyntaxError('unexpected end of line')

known_operators = ['add', 'sub', 'mul', 'div', '+', '-', '*', '/']
def analyze(tokens):
    """Create a tree of nested lists from a sequence of tokens."""
    assert_non_empty(tokens)
    token = analyze_token(tokens.pop(0))
    if type(token) in (int, float):
        return token
    if token in known_operators:
        if len(tokens) == 0 or tokens.pop(0) != '(':
            raise SyntaxError('expected ( after ' + token)
        return Exp(token, analyze_operands(tokens))
    else:
        raise SyntaxError('unexpected ' + token)


#Lexical analysis
def tokenize(line):
    """Convert a string into a list of tokens."""
    spaced = line.replace('(', ' ( ').replace(')', ' ) ').replace(',', ' , ')
    return spaced.split()

#Parse
def calc_parse(line):
    """Parse a line of calculator input and return an expression tree."""
    tokens = tokenize(line)   
    expression_tree = analyze(tokens)  #return EXP class
    if len(tokens) > 0:
        raise SyntaxError('Extra token(s): ' + ' '.join(tokens))
    return expression_tree


def read_eval_print_loop():
    """Run a read-eval-print loop for calculator."""
    while True:
        try:
            expression_tree = calc_parse(input('calc> '))
            #expression_tree = calc_parse('add(1,2)')
            print(calc_eval(expression_tree))
        except (SyntaxError, TypeError, ZeroDivisionError) as err:
            print(type(err).__name__ + ':', err)
        except (KeyboardInterrupt, EOFError):  # <Control>-D, etc.
            print('Calculation completed.')
            return


def main():
    read_eval_print_loop()

if __name__ == '__main__':
    main()

```



## 3.6 抽象语言的解释器

> 程序可以重新编写自己来执行是一个强大的概念，并且作为人工智能（AI）早期研究的基础。Lisp 在数十年间都是 AI 研究者的首选语言。

> 许多 Lisp 的方言都需要圆括号，所以就拥有了显式嵌套的语法。

我对Lisp为数不多的印象。

> 这个互相递归过程的通用结构在解释器中非常常见：求值以应用定义，应用又使用求值定义。这个递归循环终止于语言的基本类型。求值的基本条件是，求解基本表达式、变量、引用表达式或定义。函数调用的基本条件是调用基本过程。这个互相递归的结构，在处理表达式形式的求值函数，和处理函数及其参数的应用之间，构成了求值过程的本质。

这就是我在Lisp视频中没有看懂的部分，看了书还是不懂，写得不够详细...

看了英文版（有时候中文翻译确实更难以理解）：求值粗略地来说可以得到基本表达式和函数，这个函数就需要调用过程，而过程中去读取每一行的代码有需要递归去调用求值来确定值，从而互相递归，最终停止于基本表达式。

数据即程序这一点，从用户的程序是解释器的数据的角度来理解。

本节主要就是介绍了Scheme和Logo两种Lisp方言的语法，感觉跟上一节的计算器语言很类似...跟C就是大相径庭。

## 4 分布式和并行计算

只是大体讲了分布式计算的概念，计算机网络与并行计算中同步问题，比如死锁什么的，pass。

## 5 序列和协程

> 序列支持两个操作：获取长度和由下标访问元素。
>

list，tuple等共同概念。

隐式序列的迭代器，顾名思义，引入一个局部变量，来跟踪序列的处理过程。它可以迭代计算序列元素而不用事先存储它们。

```
>>> counts = [1, 2, 3]
>>> for item in counts:
        print(item)
1
2
3
```

```
>>> i = counts.__iter__()
>>> try:
        while True:
            item = i.__next__()
            print(item)
    except StopIteration:
        pass
1
2
3
```

以上两例其实是等效的。有序序列counts其实隐含着迭代器接口`__iter__`和`__next__`,“for item in counts”先是用前者返回迭代器，再用后者依此调用序列中的元素，直到出现一个异常（隐式）跳出循环。

> 生成器是由一类特殊函数，叫做生成器函数返回的迭代器。生成器函数不同于普通的函数，因为它不在函数体中包含`return`语句，而是使用`yield`语句来返回序列中的元素。

根据书里的描述，生成器应该是迭代器的一种，yield与return的区别在于，它返回值出去之后仍然可以在当前位置继续执行下去。

> 流提供了一种隐式表示有序数据的最终方式。流是惰性计算的递归列表。就像第三章的`Rlist`类那样，`Stream`实例可以响应对其第一个元素和剩余部分的获取请求。同样，`Stream`的剩余部分还是`Stream`。然而不像`RList`，流的剩余部分只在查找时被计算，而不是事先存储。也就是说流的剩余部分是惰性计算的。就像递归列表提供了序列抽象的简单实现，流提供了简单、函数式的递归数据结构，它通过高阶函数的使用实现了惰性求值。

> 流和迭代器不同，因为它们可以多次传递给纯函数，并且每次都产生相同的值。素数流并没有在转换为列表之后“用完”。也就是说，在将流的前缀转换为列表之后，`p1`的第一个元素仍旧是`2`。

在这之前，不了解stream的本质特点，惭愧！从迭代器，生成器讲到流真是循序渐进，编排得好！

> Python 的生成器函数也可以使用`(yield)`语句来接受一个值。生成器对象上有两个额外的方法：`send()`和`close()`，创建了一个模型使对象可以消耗或产出值。定义了这些对象的生成器函数叫做协程。

所以协程（coroutine）本质上是生成器函数，又称微线程，是种用户级别的轻量级线程，对于CPU而言，多个协程相当于同个线程，虽然各自有独立的寄存器上下文和栈。它用来创建高效、模块化的数据处理流水线。