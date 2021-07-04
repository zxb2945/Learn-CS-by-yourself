# MIT 6.824 Distributed Systems 2020 Spring

## Chapter 1 Introduction 20210407

Parallelism

fault tolerance 

physical security /  isolated 



challenges:

concurrency

partial failure

performance



Lab 1:MapReduce

2: Raft for fault tolerance
3: Key value server

​      4:shared key value server



Infrastructure   Abstractions

​	Storage

​	communication

​	computation



Implementation

​	RPC, threads, concurrency



Performance

​	scalability :  2x computers-> 2x throughput

​	

Fault Tolerance

​	Availability                |   Non-volatile storage

​	Recoverability           |   Replication

> 非易失存储，Non-Volatile Memory (NVM)，是相对DRAM（掉电后数据丢失）而言的，指可以持久化保存数据的存储介质。



Consistency



MapReduce framework

> MapReduce 是一个分布式运算程序的编程框架
>
> 引入 MapReduce 框架后，开发人员可以将绝大部分工作集中在业务逻辑的开发上，而将 分布式计算中的复杂性交由框架来处理
>
> 不能流式计算（MapReduce设计处理的数据源是静态的）
>
> MapReduce的工作流程
>
> input: MapReduce需要把要执行的大文件数据进行切割（split）,每一个输入分片（input split）对应一个map任务
>
> map: 程序员编写的map函数
>
> shuffle: 负责将map生成的数据传递给reduce
>
> reduce: 负责shuffle传递过来的数据进行合并，开发人员只需要专注于实现映射和reduce功能，M/R可以用Java编写
>
> output: 输出reduce中的数据信息



GFS: Google file system



## Chapter 2 Threads and RPC in Go 20210414

the reason of Threads:

IO concurrency  -> Network

parallelism  -> multi-core CPU

Convenience



Threads Challenges:

insert lock



Coordination :

​	Channels (in Golang)

​	Sync.Cond

​	wait Group



Deadlock



最后讲了个web crawler例子，用golang语言提了串行，协程并行，channel三种实现方式。



## Chapter 3 The Google File System(GFS) 20210417

Big storage

Why hard?

Performance -> sharing

Faults -> Tolerance

Tolerance -> Replication

Replication -> Inconsistency

Consistency -> Low Performance



Strong  Consistency

Bad replication design



GFS:

 Big,fast

 Global

 Sharing

 Automatic recovery

Single data center

Internal use

Big sequential access



clients -> master -> chunk servers



primary??? secondary??? -> refer to chunk servers???



> Google 使用的大数据平台主要包括 3 个相互独立又紧密结合在一起的系统：Google 文件系统（Google File System，GFS），针对 Google 应用程序的特点提出的 MapReduce 编程模式，以及大规模分布式数据库 BigTable。

> GFS 的系统架构主要由一个 Master Server（主服务器）和多个 Chunk Server（数据块服务器）组成。Master Server 主要负责维护系统中的名字空间，访问控制信息，从文件到块的映射及块的当前位置等元数据，并与 Chunk Server 通信。Chunk Server 负责具体的存储工作。数据以文件的形式存储在 Chunk Server 上。Client 是应用程序访问 GFS 的接口。

> GFS 的系统架构设计有两大优势。
>
> Client 和 Master Server 之间只有控制流，没有数据流，因此降低了 Master Server 的负载。
> 由于 Client 与 Chunk Server 之间直接传输数据流，并且文件被分成多个 Chunk 进行分布式存储，因此 Client 可以同时并行访问多个 Chunk Server，从而让系统的 I/O 并行度提高。

> Chunk Server 在硬盘上存储实际数据。Google 把每个 chunk 数据块的大小设计成 64MB，每个 chunk 被复制成 3 个副本放到不同的 Chunk Server 中，以创建冗余来避免服务器崩溃。如果某个 Chunk Server 发生故障，Master Server 便把数据备份到一个新的地方。





## Chapter 4 Primary Backup Replication 20210429

Failures

​	fail stop faults



State Transfer  -> memory

Replicated State Machine  -> operation from clients



VMware is a virtual machine company.

讲了Client跟Primary machine通信，然后Primary machine跟Backup machine同步，只是Backup machine的reply会在 VMware层丢弃，如果Backup发现与Primary的同步中断，它就会代替其与Client通信。

（按照叙述，virtual machine monitor是必须的啊...)

virtual machine monitor用来避免network card直接DMA到memory里，否则计算机不知道时间？？why？

virtual machine monitor主要用来Primary machine跟Backup machine同步，避免它们直接与Client即时通信。



讲了Primary machine crash的时候，Backup怎样去代替它与Client通行，要紧的在于Primary machine发送reply的时候先要与Backup同步，否则正好发完reply没同步前crash就尴尬了；

另一个是Primary machine跟Backup machine之间的通信中断的话，Backup不就也跟Client通信了嘛，这时候需要利用test and set server同时接受两个machine的信息，选择其中一个为Primary与Client通信。



## Chapter 5 Go Memory Model & Concurrency Primitives & Patterns, Debugging tips 20210517

介绍go语言

1. 函数内部直接定义匿名函数，就可以援引外围的局部变量

2. 介绍锁Lock： cond.wait...其实跟C语言中的性质类似

3. 介绍channel：避免buffer channel，它没啥用

   

介绍了一个常见的bug？然后debug手段...



## Chapter 6 Fault Tolerance RAFT(1) 20210524

RAFT:

> Raft是一种易于理解的一致性算法
>
> 一致性是分布式容错系统的基本功能
>
> Raft是专门针对Paxos难以理解的缺陷而重新设计的新算法，为使算法容易理解，采用了模块化设计方法，将整个过程划分为若干子过程，包括Leader选举，日志分发，确保一致性。

Split Brain

两个client访问两个server，发现一对一能访问，但每个client不能同时访问两个server（分布式的意义所在），这个时候最有可能的就是network部分线路有问题，这样的问题叫做split brain。

面对以上这个Fault，所提出来的策略是：把n个server组成的分布式系统扩展为n+1个server，取其中n个工作，一旦出现以上错误，就可以交替，这好像叫做：majority voting system

RAFT似乎是一种这样的distributed system，由一个leader server和多个follower server组成，由leader主要跟client交互，然后发送给follower们让它们进行更新日志等操作，只要有其中一个follower完成response给leader后，leader就给client回复了。

Leader Election

election timer -> start election ->timer++ ->request votes

每个server都有一个竞选时间片，它们要设定为长度不一并且一定间隔，每当其中一个竞选成功，就reset所有的server的timer，然后各个server会在将来不同时间竞选，就很容易得到大多选票，不至于有竞争对手。

所以当leader宕机，它不能有任何通知，只能等余下的其中一个server竞选时间片耗尽，发起选举，选举成功之后，其它server其实也不知道哪一个是leader，只是能够正常收到append log一类的信息就行。



## Chapter 7 Fault Tolerance RAFT(2) 20210527

Election Restriction

vote yes only if  high term on last entry, or same last term >> not log length

Persistence

一个server reboot之前最好能够保持 LOG, Current Term, Voted for等信息在永久性存储设备上，然而如果存储到disk上，就有Synchronous disk update方面的问题，一次IO，大量新的requests就来了，也许就需要disk之外的存储设备如flash，甚至特制的DRAM等...

Install Snapshots

感觉上向leader为了便于followers 回溯log流，在某一个时间节点做的数据记录...

Linearizability

如果一个client过来的requests or responses 流并不是overlap的，有明确时间上的先后顺序，那么我们说这个execution history 是 linearizable. 比如对某一个位置的write要在read前，各个request有先后顺序，所以避免在graph中形成cycle，那样的话就矛盾了。比如：

read 1 -> write 1  (X)

write 1 ->  write 2 -> read 1  (X)



## Chapter 8 Zookeeper 20210605

> zookeeper，它是一个分布式服务框架，是Apache Hadoop 的一个子项目，它主要是用来解决分布式应用中经常遇到的一些数据管理问题，如：统一命名服务、状态同步服务、集群管理、分布式应用配置项的管理等。
>
> 上面的解释有点抽象，简单来说zookeeper=文件系统+监听通知机制。



zookeeper允许client直接访问副本服务器，前提是只读访问，这样可提高效率。但这个也带来一个问题，恰好主机正在做更改，还没通知到followers，事实上这就不是linearizable. 

所以zookeeper只能做到linearizable writes，并且保证client request order做到FIFO，这样的话，虽然没法保证client读到最新状态的值，但一定程度上只要等待一定长的时间，总能得到正确的值。

进一步而言，当zookeeper做write操作时：

1. delete ready file
2. write f1
3. create ready file

当client往follower读时候：

1. exist（true？）
2. read f1

当client在follower里读的时候，master又开始修改的情况，follower会在response前收到notification。



Zookeeper is based on RAFT.

然后介绍了Zookeeper的一些增删改查的API

当一个client发给Zookeeper修改信息时，create+set data两步才能确保这一行为完成，但是这两步之间不是atomic，所以会增加一个版本变量，来验证中间是否有其它client进行了修改，若有，则反错，loop回来，重新接受修改request.

这样来说的话，上例就形成了一个sequence，就有点atomic，就是个database的atomic transaction.

也可以每一个client过来，就lock，再做处理，就是另一种方案。

但是以上两者都没法解决上千个client同时request过来的HERD问题（具体是什么问题？）



LOCK without HERD

ACQUIRE

1. CREATE SEQ "f" -  EPHEM-T

2. LIST f*

3. IF NO LOWER #FILE, RETURN

4. IF EXISTS( NEXT LOWER #, WATCH=T)

5. WAIT
6. GOTO 2

上述方案的优点在于：同时有上千个client访问时，第一个acquire lock的client创造一系列的文件（似乎此时同时会给所有waiting中的client标上序号），当第一个client完成操作，它只向下一个低序号的client发出release信号，这样的话，就不会存在上千个client同时竞争一个lock的现象。

上述方案被称为scalable lock. 细究之下，其实它不具有atomicity，因为如果在途中机器crash了，LOCK自动release，下一个client就会碰到一堆garbage。这里倾向于两种解决方案，第一是下一个client去分析这是不是garbage，需不需要delete；另一种方案像MapReduce，就由MapReduce自身来做这个分析恢复工作。



> Why zk
>
> API general purpose coord service （raft只是一个库，不能直接再app中使用）
> N倍的机器，N倍的吞吐量
> 大多数系统是读多写少的系统。让客户端去follower读取数据，可以达到增加服务器提升系统吞吐量的效果。写数据还是在leader
>
> 写请求 leader 读 replia （在replica读数据，为了保证一致性，前提是replcia的数据up to date）
>
> ZK guarantees:
>
> Linearizable writes
> 即使客户端并发写请求，但是系统会表现的像是某种顺序一次执行一个写请求。
> FIFO client order
> 如果有很多个客户端读，写。zookeeper的写操作顺序完全与client端发起的写请求顺序保持一致。（writes client specified order）
>
> Section 2.3
> 使用zookeeper读取配置数据的场景：
>
> ```
> write order         read order
> 
> delete("ready")
> write F1
> write f2
> create("ready")
>                  exists("ready")   // 写完再读，这种场景下不会有问题
>                  read f1
>                  read f2
> ```
>
> 
>
> ```
> write order         read order
> 
> create ready
> 
>                  exists("ready"),watch = true    // 写和读交错发生，这种场景下，需要设置watch，来保证读到的数据是最新的
>                  read f1
> 
> del ready
> write f1
> write f2
>                  read f2
> ```

> 设置了watch， 如果有人删除了ready，就会通知client。client再读取任何日志中的信息之前，会优先处理接受到的这个watch通知。
>
> More Actions(用途)
>
> configuration info 配置消息同步
>
> Master elect （leader 选举）
>
> Lock（分布式锁）
>
> zookeeper看起来像一个文件系统，具有目录层次结构。每个应用再不同的目录下。
>
> /App1/x
>
> NODES：
>
> REGULAR
>
> EPHEM
>
> SEQ：zookeeper保证同一时间如果有多个client端同时创建sequential文件，zookeeper生成的这些文件名的序号永远不会相同。
>
> ```
> CREATE(PATH, DATE, FLAGS)     // exclusive，同一时间只有一个client能够创建成功
> 
> DELETE(PATH, VERSION)
> 
> EXISTS(PATH, WATCH)
> 
> GETDATA(PATH, WATCH)
> 
> SETDATA(PATH, DATA, VERSION)
> 
> LIST(PATH)
> ```
>
> EXAMPLE - COUNT (K/V system) 有个系统计数器，类似于K/V system。
>
> PUT(K,V) GET(K) -> V
>
> ```
> GET(K)
> 
> PUT(K, X+1)
> 
> not atomic
> ```
>
> 正确处理方式：
>
> ```
> WHILE TRUE
>     X,V = GETDATA("f")
>     IF SETDATA("f",  X+1, V)  // 类似CAS,V不是最新的，就会set失败，然后重试
>         BREAK
>     redo...
> ```
>
> 再负载很高的情况下，如果有1000个客户端同时做计数操作，效率很低。O（N平方）herd effect，只适用于低负载的情况。
>
> ### LOCK(un scalable lock)
>
> ```
> ACQUIRE LOCK
> 
> 1 IF CREATE("F", EPHEM = T) RETURN
> 2 IF EXISTS("F", WATCH = T)   // 等待其他client释放锁，锁释放后所有client都收到通知
> 3     WAIT
> 4 GOTO 1
> ```
>
> herd effect。每次释放锁，所有剩下的clients都会收到watch通知，所有剩下的clients都会返回到步骤一发送create请求。
>
> ### LOCK WITHOUT HERD(scalable lock)
>
> ```
> 1 CREATE SEQUENCE "F" // zookeeper会保证以连续的升序创建文件
> 2 LIST F*
> 3 IF NOT LOWER FILE, RETURN
> 4 IF EXISTS(NEXT LOWER NUMBER FILE, WATCH=T)  // 此时只有一个获取锁的client收到通知，避免了herd effect
> 5    WAIT 
> 6 GOTO 2
> ```
>
> // 如果我们不是lock的获得者，如果前面还有很多文件，我们需要做的就是等待前一个命名文件的创建client获得锁，并等待它释放锁

> ————————————————
> 版权声明：本文为CSDN博主「Tyella」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/ty13572053785/article/details/115363720



## Chapter 9 More Replication, CRAQ 20210612

chain replication

> Chain replication是一种备份协议，用于支持大规模存储（更多是kv存储），获取高吞吐量和高可用性同时提供强一致性保障，提供分布式存储服务。链式备份本质上是主从备份的一种更高效的复用
>
> a. 更新：只能发生在数据头节点,然后更新逐步后移，直到更新到达尾节点，尾节点逐步向前确认已经完成更新，并由尾节点向客户确认更新成功。写操作的向后传播是顺序的，即：每个节点上已完成的更新操作是其predecessor节点的子集。
>    b. 查询：为保证强一致性，客户查询只能在尾节点进行
> ————————————————
> 版权声明：本文为CSDN博主「zimuxiaxi」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/zimuxiaxi/article/details/84597257

chain replication的话类似链表嘛，就是从head写到tail，读的时候反方向，这样就可以保证强一致性。

但是呢，中间两台server网络断了，就造成split brain的问题了，这时候似乎得借助于额外的configuration management来处理，而这个又是基于另一种算法（？）raft的。

宏观来说，chain replication 和raft，paxos一样是种分布式策略。（包括zookeeper?）



CRAQ : **(Chain Replication with Apportioned Queries )**

>  相对于Chain Replication的扩展的CRAQ流行于读为主的分布式存储架构中，它通过允许向任意的数据节点发送读请求来增强读的读取速率，同时它依旧提供强一致性的保证v. 



## Chapter 10 Cloud Replicated DB, Aurora 20210617

AURORA

HISTORY:

​	EC2->         它适用于给客户提供服务器service，但是database一旦crash，没有备份...

| Web server              | Database | 。。。 |
| ----------------------- | -------- | ------ |
| Linux                   | Linux    | 。。。 |
| Virtual machine monitor | ——       | ——     |



 	EBS->        同一个data center（比如一幢大楼里许多计算机）中多台计算机去备份这个database，然后EC2来mount这个EBS，解决单台EC2 crash的问题，但是进一步，如果整个data center crash的话怎么办？

{

首先我们得了解

DB Tutorial  ->  Crash Recovery

DB先在cache里操作数据，同时写入一个日志文件（万一crash，用来溯源），等完成之后再把结果反映到disk里去（这个时候也许要更新整个page页，数据量就会远远超过修改量），然后删除日志文件。

}

​	RDS->      比EBS更进一步，在多个data center进行备份，问题是通过网络传输的数据量要远大于修改量，就会降低速度。

 	Aurora->  与RDS相比，多个data center之间只是传输日志文件，这就提高了performance.

​					  另外，假设Aurora在三个data center备份了6台计算机，那么只要其中最快的4台完成备份，它就可以返给client OK了，这是另外一个提高performance的trick -- QUORUM

 			（据说，以上两个trick，帮助Aurora比RDS快了35倍）

​	

Aurora：

似乎来说分成了，database server和 storage server,  前者像是管理，后者是真正的储存。



Quorum机制：

> Quorum机制是“抽屉原理”的一个应用。定义如下：假设有N个副本，更新操作wi 在W个副本中更新成功之后，才认为此次更新操作wi 成功。称成功提交的更新操作对应的数据为：“成功提交的数据”。对于读操作而言，至少需要读R个副本才能读到此次更新的数据。**其中，W+R>N ，即W和R有重叠。**一般，W+R=N+1

然后怎么去判断那个副本是跟新的呢？这就不能用voting了,因为有可能只有一个量更新，所以这边要引入一个version number。

回到Aurora，因为N=6，所以W=4，R=3就可以满足Quorum机制了。

事实上，因为database server可以随时check各个storage server是不是更新到最新的版本，所以read的时候不必读到3，即使用Quorum机制。只是说万一database server crash了，初始化的时候就不得不读到3才能确定。



How Aurora deal with big data?

意思是一台电脑硬盘容量不足以满足customer的需求时，就把以上六台电脑看成一个protection group，可以无限叠加这些group来满足big data需求。



最后，因为read request远多于write request的实际情况，除了一台main database server之外，还可以加许多read only database server，可以在不打扰main的情况下直接去读storage server。





## Chapter 11 Cache Consistency, Frangipani 20210620

| User programs | 调用system call访问Frangipani，位于许多个work stations（协同工作） |
| ------------- | ------------------------------------------------------------ |
| Frangipani    | 本地的file system，位于kernel. 之后调用remote procedure call访问Petal.  事实上，这边可以看成一个cache，而且是write-back的。 |
|               |                                                              |
|               |                                                              |
|               |                                                              |
| Petal         | Share virtual disk，on a separate set of machines , like a disk driver used over a network |
| Physical disk |                                                              |

在group协同工作中，其实大部分users只是read/write他们各自的files，顶多是去read别人的files，这就给Frangipani作为一个write-back cache的速度优势了。



以上的模型最关键的问题在于如下三个：three of these challenges

1.Cache coherence

The property of a caching system that even if I have an old version of something cached, if someone modifies it in their cache, then their cache will automatically reflect their modifications.

2.Atomicity

不能发生2个文件同时创建，一个覆盖另一个的情况。

3.Crash recovery of individual server

We won't be able to have my workstation crash without disturbing the activity of anybody else using the same shared system even if they look at my dictionary in my files, they should see something sensible.



1.Cache coherence

coherence protocol

> 首先要了解的一个内容就是 在Frangipani的系统中有一个lock server（LS）的模块，用来提供全局的锁管理。
>
> 对于第一个问题，Frangipani是采用缓存一致性协议解决的。其协议主要有以下三个原则：
> （1）、只有获得锁，才可以cache data
> （2）、必须先获得锁，然后在可以从petal中读取
> （3）、释放锁之前必须先write-back
>
> 这里介绍一下其简化的流程：
> （1）、WS在进行文件的读写之时需要从LS中请求其对应的锁lock
> （2）、LS在收到WS的请求之后，查看其保护的锁元信息，如果此时锁lock没被其他WS占用（或者被占用但是其lock状态是idle），则将lock分配给WS。否则返回失败。
> (3)、如果WS获取到lock之后，则可以从petal中把对应的data复制到期cache中，修改之后，暂时不进行write-back，也暂时不释放锁。
>
> （4）、此时WS2如果来请求相同的文件读写，则向LS请求对应的锁
> （5）、LS查看对应的锁是否被占用并且其状态是idle，如果lock处于这个状态，则LS要求WS释放锁（revoke）
> （6）、WS收到LS发来的释放锁的请求之后，先把dirty data 回写到petal中，然后释放锁。
> （7）、LS返回lock给WS2
> （8）、WS2收到锁授权之后，即可进行文件的读写。
> ————————————————
> 版权声明：本文为CSDN博主「BLSxiaopanlaile」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/plm199513100/article/details/108310623



2.Atomicity

3.Crash recovery

对于一个workstation收到petal要求其release lock的请求之后，先把write log给petal，然后再write modified block，最后才是release lock。

所以当这个workstation crash的时候，其它ws可以根据其write log来完成其未完成的操作...

而且会给这个write log一个version number.



Frangipani会适应于一些小型的协同工作的情况，但一般不太用来设计为大型系统，比如大数据计算，因为cache毕竟容量有限。



## Chapter 12 Distributed Transactions  20210624

concurrency control + atomic commit => transactions

Transactions现在多用于database中，但是其实它是一种普遍的设计思想



ACID:

Atomic

Consistent

Isolated  -> serializable

Durable



Serializable: if 存在 serial order of execution of transactions that yields same result.

比如说两个transactions同时操作同一数据，t1修改，t2读取，虽然说同时，其实还是串行，只要其顺序确定，最后的结果是不变的，不会出现t2读到一半被t1修改了。

This definition allows truly parallel execution of transactions as long as they don't use the same data.



Concurrency control有两种strategies:

1.pessimistic

就是获得lock改数据，否则delay，修改成本大

2.optimisitc

就是直接改，最后check有没有其他人修改，有的话abort重来



Two-Phase commit: 一种protocol

> XA 是一个分布式事务协议，规定了事务管理器和资源管理器接口。因此，XA 协议可以分为两部分，即事务管理器和本地资源管理器。
>
> 事务管理器作为协调者，负责各个本地资源的提交和回滚；
> 资源管理器就是分布式事务的参与者.其中资源管理通常是 数据库。
> 基于 XA 协议的二阶段提交方法中，二阶段提交协议（The two-phase commit protocol，2PC），用于保证分布式系统中事务提交时的数据一致性，是 XA 在全局事务中用于协调多个资源的机制。
> ————————————————
> 版权声明：本文为CSDN博主「一只牛_007」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/yizhiniu_xuyw/article/details/114968528

Transaction Coordinator

> 投票为第一阶段:
>
> 1 协调者（Coordinator，即事务管理器）会向事务的参与者（Cohort，即本地资源管理器）发起执行操作的 CanCommit 请求，并等待参与者的响应.
> 2 参与者接收到请求后，会执行请求中的事务操作，记录日志信息(包含事务执行前的镜像)，同时锁定当前记录。参与者执行成功，则向协调者发送“Yes”消息，表示同意操作；若不成功，则发送“No”消息，表示终止操作。
> 3 当所有的参与者都返回了操作结果（Yes 或 No 消息）后，系统进入了提交阶段。
> 提为第二阶段：
>
> 协调者会根据所有参与者返回的信息向参与者发送 DoCommit 或 DoAbort 指令
>
> 若协调者收到的都是“Yes”消息，则向参与者发送“DoCommit”消息，参与者会完成剩余的操作并释放资源，然后向协调者返回“HaveCommitted”消息；
> 如果协调者收到的消息中包含“No”消息，则向所有参与者发送“DoAbort”消息，此时发送“Yes”的参与者则会根据之前执行操作时的回滚日志对操作进行回滚，然后所有参与者会向协调者发送“HaveCommitted”消息；
> 协调者接收到“HaveCommitted”消息，就意味着整个事务结束了。
> ————————————————
> 版权声明：本文为CSDN博主「一只牛_007」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/yizhiniu_xuyw/article/details/114968528



与raft相比，就quite low availability.  因为没有备份机制。



## Chapter 13 Spanner 20210703

spanner（Google）是为数不多全球分布多个数据中心的分布式数据库，它提供统一的更新时间，强一致性来处理read-only commit和一小部分的read-write commit.

基于paxos算法，对于A部分数据而言，它有一个分布于不同数据中心的paxos group，其中一个为leader. 不同部分的数据可以parallel, 许多google服务承载于其上. 采用paxos来备份基于两个原因，1是众所周知防止crash，2是比如中国的用户可以直接转去香港的服务器rather than 加利福尼亚，从而更快. 另外它似乎也支持quorum机制。

> raft是paxos的改进版



前二十分钟讲基于paxos与Two-Phase commit之上的transaction的流程，但是没看懂...

->Two-Phase commit是针对一个transaction而言的，而不是针对一个paxos group.  这就意味着所谓的coordinater及其它是针对不同的数据而言，比如存储于两个不同的paxos group的trasaction部分，所以我们可以推测coordinater应该是其中一个group的leader.

因为paxos原因，不用担心Two-Phase commit的availability.



相对于read/write操作，read不需要lock，不需要Two-Phase commit，用timestamp来serializable.(被称为 snapshot isolation)













