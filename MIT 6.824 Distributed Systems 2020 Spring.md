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



关于 time synchronization, 政府lab通过GPS卫星广播，或多或少会有delay，对于基于Two-Phase commit上的read/write操作就无需担心同步问题，但是read-only就需要注意。

系统一般应用两条rule来增强read-only的external consistency：

Start rule： read-only与read/write操作计时开始略有区别？

Commit wait： read/write操作commit之际，似乎要进行一定的延迟？

不是很明白，但是PC向true time system取时间的时候其实是一个时间范围，read-only与read/write操作都取一定时间范围的末端作为时间戳？来保证能读到最近的commit值。

讲课的人讲这个是spanner这份paper里最有趣的点。



> 【摘要】Spanner 是谷歌公司研发的、可扩展的、多版本、全球分布式、同步复制数据库。它是第一个把数据分布在全球范围内的系统，并且支持外部一致性（内部一致性指数据库一致性，外部一致性指分布式一致性，详见：https://blog.csdn.net/songchuwang1868/article/details/89839921）的分布式事务。本文描述了 Spanner 的架构、特性、不同设计决策的背后机理和一个新的时间 API，这个 API 可以暴露时钟的不确定性。这个 API 及其实现，对于支持外部一致性和许多强大特性而言，是非常重要的，这些强大特性包括:非阻塞的读、不采用锁机制的只读事务、原子模式变更。

> 作为一个全球分布式数据库，Spanner 提供了几个有趣的特性:第一，在数据的副本配置方面，应用可以在一个很细的粒度上进行动态控制。应用可以详细规定，哪些数据中心包含哪些数据，数据距离用户有多远(控制用户读取数据的延迟)，不同数据副本之间距离有多远(控制写操作的延迟)，以及需要维护多少个副本(控制可用性和读操作性能)。
>
> 实现这种特性的关键技术就是一个新的 TrueTime API 及其实现。这个 API 可以直接暴露时钟不确定性（不仅给出时间戳，还给出不确定性，比如3秒正负4微秒）
>
> 与 BigTable 不同的是，Spanner 会把时间戳分配给数据，这种非常重要的方式，使得 Spanner 更像一个多版本数据库。
>
> TrueTime 会显式地把时间表达成 TTinterval，这是一个时间区间，具有有界限的时间不确定性(不像其他 的标准时间接口，没有为客户端提供―不确定性‖这种概念)。
>
> 在底层，TrueTime 使用的时间是 GPS 和原子钟。TrueTime 使用两种类型的时间，是因为它们有不同的失败模式。GPS 参考时间的弱点是天线和接收器失效、局部电磁干扰和相关失败(比如设计上的缺陷导致无法正确处理闰秒和电子欺骗)，以及 GPS 系统运行中断。原子钟也会失效，不过失效的方式和 GPS 无关
>
> Spanner 在 2011 年早期开始进行在线负载测试，它是作为谷歌广告后台 F1[35]的重新实现的一部分。这个后台最开始是基于 MySQL 数据库
>
> 我们的设计中一个亮点特性就是 TrueTime。我们已经表明，在时间 API 中明确给出时钟不确定性，可以以更加强壮的时间语义来构建分布式系统。此外，因为底层的系统在时钟不确定性上采用更加严格的边界，实现更强壮的时间语义的代价就会减少。作为一个研究群体，我们在设计分布式算法时，不再依赖于弱同步的时钟和较弱的时间 API。



## Chapter 14 Optimistic Concurrency Control 20210708

FaRM:  相较Spanner来说还不完善，并且不同于Spanner拥有多个data centers,  FaRM就只有一个，尽管FaRM也有Primary, Backup的fault tolerance机制，加之其相较使用disk，为了提高速度（速度可以比Spanner快上几百倍）使用的都是RAM，所以一旦整个data center断电，它采用的是每台service都有独立备用电池...

1. Non-Volatile RAM: 就是为了应对datacenter power failure，在备用电池短暂运作时间里将RAM数据迁移到Disk中的一个trick.
2. Kernel Bypass: Application越过kernel，不用system call，直接访问Network Interface Card的stack告诉它怎么做，然后网卡通过DMA直接访问Application的memory. 实现这个trick需要对OS进行一定修改.
3. RDMA( Remote Direct Memory Access):  本地电脑直接通过两个网卡交互，直接访问远端Application的memory，不仅不经过kernel，甚至远端Application也不知道，这就需要两个网卡提供一种类似kernel中的TCP协议栈的protocol来保证reliability.
4. Optimistic Concurrency Control: 因为transaction和RDMA看起来不怎么兼容，所以引进OCC.



Pessimistic: 

1. Locks -> like 2PC;

2. Conflicts -> Block.

Optimistic:  实现one-side RDMA

1. read without locks;
2. buffer writes;
3. commit -> validation;
4. conflict -> abort;



> 乐观并发控制：
> Execute Phase
> 读取值和版本号。计算结果暂时写到本地。
> Commit Phase
> 四个步骤：
> LOCK、锁住要写的region
> VALIDATE、 检查读过的region版本号未改变
> COMMIT-BACKUP、将新值直接写入到backup的log
> COMMIT-PRIMARY、叫primary将新值写入
>
> 四个步骤与RDMA：
> LOCK需要对方CPU参与
> 因为单纯RDMA没有办法实现compare-and-swap。
> 加锁需要CM利用单边RDMA write将加锁请求放到primary的log中，等对方CPU执行一个CAS操作。
> 对方通过LOCK-REPLY消息答复加锁是否成功。
> VALIDATE和COMMIT-BACKUP是RDMA单边读、RDMA单边写
> 完全不用对方cpu参与
> COMMIT-BACKUP和COMMIT-PRIMARY都只等硬件答复ACK。不等对方CPU真正把log应用到数据区Region。
> 这样速度快。log应用到数据区与CM处理事务可以并行。
>
> ————————————————
> 版权声明：本文为CSDN博主「颛顼子」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/hohomi77/article/details/102511679



## Chapter 15 Big Data - Spark 20210719

Spark 与 MapReduce 类似，但是对于比如一个PageRank算法，会有更少的I/O操作。

视频通过讲解一段代码（存在loop）在Spark上逐行运行来说明整个PageRank流程，完全云里雾里，难道类似于MapReduce的map，shuffle，reduce全部在这一段代码中全部实现吗？那这一小段代码是如何去操作整个分布式计算框架？另外，所谓分布式框架的并行的运算单位，是一小段代码还是一小块数据呢？

从HDFS中input file以chunk的形式被不同的workers所read，然乎这些workers各自独立map，把各自的chunk分类成各种<key,value>，到此为止都是narrow处理。然后每台workers在以一个key为主，去其它workers那里进行此key的集约，叫distinct，这就开始了wide阶段，有各种交互，非常expensive。

（以上看来，narrow处理阶段就相当于MapReduce的map阶段，而wide阶段就是Reduce阶段）

以上来看，这个分布式框架，是每台worker都运行同一段代码，处理不同的数据，中间有一个GroupByKey的交互。相比MapReduce，Spark在各个worker交互过程中用的是内存，而不是磁盘。

最后稍微提了一下single node lose时候的fault tolerance.

（大概所谓大数据云计算，MapReduce就是一个典型框架吧）



## Chapter 16 Cache Consistency - Memcached at Facebook 20210720

Facebook的Web服务器在Apache等Front-ends服务器和数据库服务器之间，加了层硬件改造更为快速的缓存服务器Memcached( 其实就是利用CPU利用率高，内存利用率低的计算机 )。所以缓存服务器与数据库服务器之间的数据一致性就成了issue，另一方面因为缓存服务器承担了绝大部分的访问，一旦crash，Front-ends直接访问数据库的话，数据库服务器承受不住，所以需要在缓存服务器这一层做fault tolerance.

关于缓存服务器与数据库服务器之间的数据一致性，不用在意秒级的，即稍微不一致也可以，但是对于用户自己所更新的数据，就有更高的要求。

此架构的read/write操作流程：

```
read:
value=get(key)  from Memcached
if value is null
	value = fetch from DB
	set(key) to Memcached
wirte:
send <key,value> to DB
delete key from Memcached
```

因为write时候的顺序，这里存在没法取到最新修改的数据的可能性。

进一步，假若有大量front-end在 访问这个修改的key，全部miss，全部去database，就比就糟糕。这个时候可以采用write的时候在memcached里立个bit，告诉其它request等一等。同样，在一个read miss时候复写缓存时，这中间如果有write，delete操作的话，这里也需要立个bit，告诉无需复写了。以上可以归结为Race问题。



Two main way to get extra hardware high performance: Partition, Replication (针对hot key效果不同，不太理解...)  =>  它的意思是多台memcached的情况下，这些memcahced分别存储不同的数据，即partition，还是同样的数据，即replication.

然后众多web服务器和众多Memcached服务器会组成一个个cluster. 然后各cluster之间还有共享的memcached机群,称为regional pool。来存储那些并不那么hot的key（从这个意义上讲，各cluster之间数据是replication？)

接着讲了，如果新增一个cluster的时候，一开始其中的memecached没有任何数据，大概率hit不了cache，要去database取，就会有一段cold time，这个时候可以直接去既存的cluster中取来代替。



## Chapter 17 COPS, Causal Consistency 20210728

> COPS是保序系统的集群(Clusters of Order Preserving System)的简称。
>
> COPS系统能够提供因果+一致性causal+ consistency，设计为支持复杂的在线应用，这些应用托管在少量的大规模数据中心，每个应用都是有前端服务器(COPS客户端)以及后端key-value数据存储，COPS在本地数据中心以线性化方式执行所有的put写操作和get读操作，然后会跨数据中心以因果一致性的顺序在后台进行复制。
>
> 下面看看什么是因果一致性。我们假设一个key-value数据存储，有两个基本操作: put(key,val) 和 get(key)=val. 这个类似于在单机的共享内存系统中的读操作和写操作(可参考：Go语言Goroutine与Channel内存模型)。
>
> 　　我们约定遵循下面三个规则表示潜在一致性，用符号表达 ->：
>
> 　　在同一执行线程：. 如果a 和 b 是一个执行线程中的两个操作，如果操作a发生在操作b之前，那么a ->b;
>
> 　　不同线程Gets From. 如果 a是一个put放入操作，且b是一个获得操作，能返回被a放入的写操作结果值，那么a->b;
>
> 　　传递性Transitivity. 对于操作a, b, 和 c, if a -> b 且 b -> c, 那么 a -> c.
>
> 　　这些规则在同一个线程内的操作之间以及在与数据存储交互的不同线程的操作之间创建了潜在的因果关系，这个模型，并不允许线程直接通讯，而是通过数据存储进行通讯。



假若有3个data center，local client可以就近迅速从data center读写数据，然后此data center维护一个queue去给其它data centers传递数据修改消息。对于一data center而言，它有自己从client收到的，也有其他data center转送过来的，这些消息是乱序的，此时可以给各个消息加 time stamps. 【这就是spanner的机制了】

Lamport Clocks: Tmax = highest v# seen; T = MAX(Tmax + 1, real time)

Conflict write: 如果两个data center同时向另一个data center传递对同一数据的修改，则last writer win policy.



【Dynamo（Amazon 公司的一个分布式 key/value 存储引擎）】

>  Cassandra在2008年7月被Facebook开源。Cassandra最初的版本主要是由亚马逊(Amazon)和微软(Microsoft)的一名前雇员编写的。它深受亚马逊首创的分布式key/value数据库Dynamo的影响。



Eventual Plus Barrier:

如果你放一张photo，然后为它添一个link这两个操作，到其它data center的时候，先收到link，然后去点这个link的那一瞬间是看不到photo的，关键在于photo与link之间有规定的先后顺序，需要对收到的这两个操作进行synchronize, 这事实上就需要client的相关操作不得不wait.

另一种solution，是为每一个data center配一个log server，通过传递操作log来linearizable，但是在很大的数据量的情况下，log server会有越来越慢的缺点。



(接下来才正式介绍Cops：)

一个问题：所谓操作的order是谁规定的？Client？每个value给一个version，但这个version怎么确定？也许是Client所在的程序编码者来组织吧...但programmer不可能知道version啊...

比如一个put(z,x,y)操作以两个get(x),get(y)操作为前提，那么这个put操作所在的server就要向其他server询问相应version的x,y，这里肯定有delay，比如万一这个x也有其他的dependency呢。这里隐含着操作的前提信息需要该server来保存。

上面那个photo例子也可以用Cops来解决。

接下来介绍了The definition of causal consistency，即：

> 在同一执行线程：. 如果a 和 b 是一个执行线程中的两个操作，如果操作a发生在操作b之前，那么a ->b;
>
> 不同线程Gets From. 如果 a是一个put放入操作，且b是一个获得操作，能返回被a放入的写操作结果值，那么a->b;
>
> 传递性Transitivity. 对于操作a, b, 和 c, if a -> b 且 b -> c, 那么 a -> c.

a ->b理解为b depends on a.



Causal consistent system is faster than linearizable system.



## Chapter 18 Fork Consistency, Certificate Transparency 20210801

1995年，man-in-the-middle attack：截获client发往DNS的包，发fake reply获取用户的密码，代替其登录相应server。

为此，提出SSL, TLS, HTTPS:

> 在正式开始讲解https之前我们还得先搞清楚两个概念：什么是对称加密，以及什么是非对称加密？这两个概念都是属于加密学中的基础知识，其实非常好懂。
>
> 对称加密比较简单，就是客户端和服务器共用同一个密钥，该密钥可以用于加密一段内容，同时也可以用于解密这段内容。对称加密的优点是加解密效率高，但是在安全性方面可能存在一些问题，因为密钥存放在客户端有被窃取的风险。对称加密的代表算法有：AES、DES等。
>
> 而非对称加密则要复杂一点，它将密钥分成了两种：公钥和私钥。公钥通常存放在客户端，私钥通常存放在服务器。使用公钥加密的数据只有用私钥才能解密，反过来使用私钥加密的数据也只有用公钥才能解密。非对称加密的优点是安全性更高，因为客户端发送给服务器的加密信息只有用服务器的私钥才能解密，因此不用担心被别人破解，但缺点是加解密的效率相比于对称加密要差很多。非对称加密的代表算法有：RSA、ElGamal等。

> 使用http传输数据至少存在着数据被监听以及数据被篡改这两大风险，因此http是一种不安全的传输协议。
>
> 那么解决方案大家肯定都知道是使用https，但是我们先尝试着自己思考一下该如何保证http传输的安全性，进而也就能一步步地理解https的工作原理了。
>
> 既然数据以明文的形式在网络上传输是不安全的，那么我们显然要对数据进行加密才行

> 如果我们想要安全地创建一个对称加密的密钥，可以让浏览器这边来随机生成，但是生成出来的密钥不能直接在网络上传输，而是要用网站提供的公钥对其进行非对称加密。由于公钥加密后的数据只能使用私钥来解密，因此这段数据在网络上传输是绝对安全的。而网站在收到消息之后，只需要使用私钥对其解密，就获取到浏览器生成的密钥了。
>
> 另外，使用这种方式，只有在浏览器和网站首次商定密钥的时候需要使用非对称加密，一旦网站收到了浏览器随机生成的密钥之后，双方就可以都使用对称加密来进行通信了，因此工作效率是非常高的。
>
> 那么，上述的工作机制你认为已经非常完善了吗？其实并没有，因为我们还是差了非常关键的一步，浏览器该怎样才能获取到网站的公钥呢？

> CA机构专门用于给各个网站签发数字证书，从而保证浏览器可以安全地获得各个网站的公钥。
>
> 我们作为一个网站的管理员需要向CA机构进行申请，将自己的公钥提交给CA机构。CA机构则会使用我们提交的公钥，再加上一系列其他的信息，如网站域名、有效时长等，来制作证书。
>
> 证书制作完成后，CA机构会使用自己的私钥对其加密，并将加密后的数据返回给我们，我们只需要将获得的加密数据配置到网站服务器上即可。
>
> 然后，每当有浏览器请求我们的网站时，首先会将这段加密数据返回给浏览器，此时浏览器会用CA机构的公钥来对这段数据解密。
>
> 如果能解密成功，就可以得到CA机构给我们网站颁发的证书了，其中当然也包括了我们网站的公钥。
> ————————————————
> 版权声明：本文为CSDN博主「guolin」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/guolin_blog/article/details/104546558



Web server和CA(Certificate Authorities) 商议公钥的时候，这一事件要公之于众才行。

> ## 证书透明度
>
> ### 为什么 Certificate Transparency 非常重要？
>
> 当前模式要求所有用户都必须相信，数百个 CA 组织在为任何网站签发证书时不会出现任何错误。但在有些情况下，人为错误或假冒行为可能会导致误发证书。Certificate Transparency (CT) 改变了签发流程，新流程规定：证书必须记录到可公开验证、不可篡改且只能附加内容的日志中，用户的网络浏览器才会将其视为有效。通过要求将证书记录到这些公开的 CT 日志中，任何感兴趣的相关方都可以查看由授权中心签发的所有证书。这能够促使授权中心在签发证书时更加负责，从而有助于形成一个更可靠的系统。最终，如果使用 HTTPS 的某个网站的证书未记录到 CT 日志中，那么当用户访问该网站时，浏览器可能不会显示安全连接挂锁图标。
>
> 证书透明度Certificate Transparency是谷歌力推的一项拟在确保证书系统安全的透明审查技术，只有支持CT技术签发的EV SSL证书，谷歌浏览器才会显示绿色单位名称，否则chrome浏览器不显示绿色单位名称。
>
> 证书透明度是Google为了减少恶意颁发未经授权证书的一种新规范，CA创建了一个被称为"pre-certificate"并将其发送到通过谷歌认证的Log Server(日志服务器)，日志服务器给预签证返回一个"已签证书时间戳"（Signed Certificate Timestamp）给CA，称为STC数据，此数据被嵌入到正式签发的证书中或通过TLS模式提供部署到Web服务器中。简单的说：就是为合法签发的证书做了一个白名单，谷歌浏览器在验证证书时同时也会去查看这个证书是不是在白名单里面。如果不在的话，是不会显示绿色单位名称的，也不会显示证书透明度信息。

针对这个CT log： Append-only;  No forks, No equivocation; Untrusted.



为了避免客户下载整个CT log，其采用Merkel Tree进行存储，本质上是一个二叉树，各节点是hash函数，从而将CT log分成许多小块。

> Merkle Tree，通常也被称作Hash Tree，顾名思义，就是存储hash值的一棵树。Merkle树的叶子是数据块(例如，文件或者文件的集合)的hash值。非叶节点是其对应子节点串联字符串的hash。



Proof of Inclusion:

STH: Sign Tree Head -> The log server gave it to client.

> 叶节点HA,HB,HC和HD分别存储了交易A,B,C,D进行hash运算之后得到的哈希值；中间节点HAB,HCD则各存储了其左右两个子节点经过hash运行后的哈希值；同理，最上层的根节点（Merkel树根）存储了其左右子节点HAB和HCD经过hash运算后得到的哈希值，该值就是这颗Merkel树的根哈希。
>
> Merkel树逐层记录哈希值的特点，使得底层数据的任何变动，都会传递到其父节点，一层层的沿着路径一直到树根。这意味着根哈希代表了对底层所有数据的“数据摘要”。
>
> 但是根据上述哈希算法的特点，我们知道数据摘要是哈希算法最重要的一个用途。
> 那么直接对区块中的所有交易进行一次哈希运算hash(A+B+C+D)，同样可以保证区块中的所有交易的完整性。为什么还需要Merkel树呢？这就不得不提到Merkel树两个重要的特性：
>
> 快速定位修改：如果交易B的数据被篡改，会影响到HB,HAB和Root(HABCD)。一旦发现根节点Root的哈希值发生变化，沿着Root -> HAB -> HB 最多通过O(lgn)时间即可快速定位到实际发生改变的交易B。
>
> 零知识证明：它指的是证明者能够在不向验证者提供任何有用的信息的情况下，使验证者相信某个论断是正确的。例如如何证明某个区块中包含交易B？只需要构造如图所示的Merkel树，公布HA，HCD和Root(HABCD)。交易B的拥有者通过验证生成的Root是否与公布的一致，即可证明交易B是否被包含在该区块中，整个过程无需知道其他交易的真实内容。
> ————————————————
> 版权声明：本文为CSDN博主「李小西033」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/lissdy/article/details/90733285

上面应用中的零知识证明就是proof of inclusion.

上述proof of inclusion适用于bitcoin，而视频中主要就是讲browser去log server里验证Certificate对不对，log server会给browser一个STH，即Merkel Tree的root以及其它关联节点的hash信息，从而可以确定该数据块对不对.

Fork Attack -> Equivocation

就是有人通过fork服务器中的log来产生不同的STH来trick相应的client，这个其实不同monitor中看到的STH比较一下就可以防止，但是另一方面其实append log的时候也会造成STH不同，所以这两种STH的变动需要做区分。

Merkel log consistency proof: 事实上append log造成的STH变动其实是父子节点的增加，可以用prefix和suffix等操作来确认？？没大听明白



## Chapter 19 Peer-to-peer, Bitcoin 20210803

The goal is we want agreement on a single transaction log because we want prevent double spending.

(所谓double spending 就是一个节点Y先后向Q,Z发送transaction，记入log时顺序由于各种原因与发送顺序不同)

> 数字货币的提出，也带来了很多问题，最主要的问题是双花问题（double-spending problem）。双花问题即是使用同一货币进行多次支付，从而达到欺诈的目的。
>
> 根据网上的资料，可以了解到有两种手段可以达成该目的：
>
> 1、0确认
>
> 例如A共有1个比特币，并先后支付给B和C各一个比特币购买商品。若B和C尚未等该笔交易写入新的区块（比特币每10分钟产生一个新的区块，包含前一区块信息和这十分钟所发生的交易），就提供商品，那么B能收到比特币，C不能收到，受到欺诈。
>
> 这个问题会对交易的及时性产生一定影响，需要收款方等待一定时间，完成确认后进行交易就能避免这种情况发生。
>
> 2、算力攻击
>
> 区块链存在一个特性，当同时产生多个正确区块时，产生支链。矿工按自己受到区块广播的先后顺序，把先到达的区块作为上一区块进行计算。经过一段时间后，最长的支链被确认成为主链，其他被抛弃。根据这一特性，当A支付一笔比特币后，若能更改交易记录，并使错误记录成为主链后，就能完成欺诈。
> 为了解决这一问题，许多数字货币采用了POW，以太坊正在往POS与DPOS过渡。
>
> POW是Proof of Work的缩写，即工作证明，是中本聪受到Adam Back的哈希现金（Hashcash）算法的启发。哈希现金主要用于垃圾邮件的过滤，让发邮件的人完成一个难以计算却容易验证的问题，在内容后添加后缀，使计算的hash值前指定位数为0。因为后缀对hash值的影响难以预料，只能通过不断试错的方式进行。对于普通的邮件发送者，发送少量的邮件只需让计算机进行几秒的计算，对于垃圾邮件发送者，大量的计算会耗费大量的算力。对于区块链来说，每个区块的产生也需要指定该区块头hash值的0的位数，0位越多，计算难度越高，难度会根据全网算力动态调整。
>
> 回到算力攻击，使用算力占全网算力的比例来代表挖到新区块的概率。中本聪在论文中指出，若恶意攻击者的算力小于可信矿工的算力，那么随着时间过去，恶意攻击者让错误区块成为主链的可能性迅速下降。POW的作用是让可信矿工用算力来证明自己的可信度。但是若恶意攻击者掌握全网51%的算力，那么算力攻击可能实现。
> ————————————————
> 版权声明：本文为CSDN博主「fusun523」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/ywy19930523/article/details/80104824



为此引入了 Block Chain的设计框架，即一个节点发送一个transaction，需要flooding all over the system. 

个人理解是Block Chain按一定顺序组织，所以按这一顺序遍历就不存在double spending？？那速度肯定会很慢？另外某人付你bitcoin，产生新的block什么意思？一个transaction一个block？？

This action of creating a new block is called **mining**, and the technique that's used to produce a new block is often also called proof of work, in the sense that it requires a lot of CPU time to produce a new block, and so the production of a new block essentially proves that you control a real live CPU, and you're not just mining new blocks on a fake computer. 

What a mining computers do is that they try different by different values for the nonce, just pick one with a random number generator that'll stick it in there copy of the block they are trying to mine, and then they'll compute the hash on the block.

 以上看来mining就是去计算block上的hash，那这个block就是bitcoin？



> ### 比特币的原理和运转机制
>
> 首先，对比特币有一个整体的了解，比特币实际上可以理解为一个文件，确切的说可以理解为一个账本。
>
> 在比特币世界中，是没有账户余额概念的，只有一笔笔的从一个账户转到另外账户的转账信息。每当发起一比交易的时候，比特币系统会先通过你的比特币地址查到你之前的所有交易记录，看你是否有足够的钱去支付这笔交易。
>
> 这个账本不同于私人账本或者是银行的账本，它是一个全网都有的账本，不归属于某个人，而且全网都一样，每个网络节点人手一份，而且都是相同的。
>
> 当某个人A想要向B转账5个比特币，A会在比特币网络中广播这个消息，收到消息的节点一边将账本的副本信息更新，一边将这个消息继续广播，直到全网所有节点都收到。
>
> 如何来判断这个A转账到B5个比特币的消息是正确的呢？
> 针对每一笔交易，除了有转账信息，还会有一个数字签名，这个数字签名是有比特币地址账号唯一的私钥将转账消息的数字摘要加密创建生成的，每个网络节点拿着A的公钥对数字签名进行解密验证，就可以判断消息的准确性。
> 如果把转账信息比作是一份合同，那这个数字签名，你就可以理解为是类似于合同上一个亲笔签名的东西，来确保消息的准确性。
> 比特币系统中，每时每刻都会有无数多的交易在发生，比特币系统将这些交易信息按组分配，每个组称之为一个区块(block)，然后将这些区块按照时间顺序用链表一个一个的串起来，称之为区块链(the block chain)。区块链中的每个区块会引用前一个区块，你可以反向追踪至第一个区块中的交易信息。未在区块链中的信息是“未交易”或者未排序的信息，任何节点都有能力将一组未经确定的交易打包进区块，然后将它打包进区块的事实广播出去。
> 比特币系统显然不会让所有节点都参打包区块，这样非乱死不可，比特币系统会以每十分钟为一个周期，出一道计算题，这个计算题超级难，让全网的节点参与计算，这道计算题其实就是对当前区块的全部内容做一个特殊计算，得到一个哈希值，全网的所有网络节点通过比拼计算速度，强行匹配出哈希的值，最先计算出哈希值的节点将取得打包区块的权利，生成一个新的块block并连入现有的区块链，然后广播至所有其他节点，其他节点开始同步更新；最先计算出结果的节点除了拥有“记账”的权利，还可以获得一定量的比特币，这其实就是比特币的发行过程。参与打包区块的过程其实就是“挖矿”，参与“挖矿”的节点就是“矿工”。
> 比特币是如何保持总量恒定的呢？
>
> 随着越来越多的计算机加入比特币网络，“矿工”的计算能力会越来越强，为了让“矿工”恒定在每十分钟打包一个区块发行一次比特币，中本聪设计矿工挖矿的难度每过2016个区块动态提高一次，使得调整后的难度保持在十分钟。
> 每个比特币可以细分到小数点后八位，也就是说可以拿着0.00000001个比特币来交易。
> 刚开始每打包一个区块发行50个比特币，每21万个区块后，打包一个区块发行的比特币减半，比特币系统规定每十分钟打包一个区块，这样打包21万个区块需要四年的时间，直至2140年，比特币将无法细分，比特币发行完毕，发行总量约为2100万枚。
> ————————————————
> 版权声明：本文为CSDN博主「菜刚」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/i6448038/article/details/80184525



Bitcoin peers之间怎么communicate？

I'm a new peer, you know I've install a new computer, I get Bitcoin software installed on my computer, and I want to join the Bitcoin network. How do I know who to talk? The straightforward answer to that is that the Bitcoin software has built into it on the IP address of a whole bunch of current peers and so your software when you first fire it up into  the source whatever, the Bitcoin software has a whole bunch of IP addresses, and you try to make TCP connections to those existing peers. Look I'm new, please give me a copy of the blockchain as it exist now, and they'll send you the current block team.



到目前为止，认识是每台computer都可以拥有一个完整的Blockchain，Blockchain中的一个Block记载的是一部分交易信息，每十分钟会产生一个新的Block并由这个Block来记载新的交易信息，然后遍历全部网点，产生这个新的Block需要计算一个hash，计算出这个hash的computer会被奖励一定量的比特币。

问题是众多Transactions如何被集约到一个Block呢？节点之间是怎么通信来保证consistency的？

所有即时产生的transaction会记录到新产生的Block中。

并且，产生Fork现象时，abandoned fork上的信息如何处置？

产生Fork时，其中一条chain如果slightly longer，就会聚集大量的mining，从而形成长的越长的局面。而另一条chain上的信息就会被遗弃，不merge，所以要求只有确定本chain是winning chain后，其上的transaction才会被正式确认。

如果malicious attacker有超过51%的CPU power，就可以强行开出一条更快的Fork chain。

另外，Bitcoin支付至少得花费十分钟来确认，至于其anonymous，相对于credit card固然是好，但每个用户需要提供Public key，一笔交易后人家还是会弄清楚你是谁。



Centralization or Decentralization



## Chapter 20 BlockStack  20210806

先介绍了现在普遍的中心化的Web sites构成的优缺点(high performance, low privacy)，然后介绍Decentralized Architecture:

终端上的APP将数据存储于用户独立的Cloud上，而不是所有用户的数据存储于服务器Database中，

其它终端通过一定的权限认证可以来此用户的Cloud上访问数据。



Naming

human names - "Robert"

1. name -> data location

2. name -> public key

     ACLs -> names: 

      1. unique - global

      2. human- readable

      3. decentralized

         以上三点很难同时满足

PKI: Public Key Infrastructure



We can stick transactions into bitcoin log.

Naming  on Bitcoin

first-come first-server scheme: 先登记有效，后登记被忽略

以上利用Bitcoin就可以同时满足上文提到的三点



Bitcoin提供三点同时满足的name后，专门会有一个中间层ATLAS去记录name关联的data location, public key等信息，然后再去链接叫GAIA的storage.

> 这个过程分4步：
>
> 1. 在虚拟链中查找名称以获得(名称、散列)对。
> 2. 将用户名解析为数据(通过BNS和Atlas网络控制)，以获得相应的区域文件。
> 3. 从zonefile中发现存储后端URI，并查找连接到存储后端的URI。
> 4. 从gaia服务规范中获取数据。

Blockstack naming  system (BNS) server -> 名字转换还需要中心化的服务器？

register name need to pay, free lead to waste domain.

> 在Blockstack命名系统中，通过使用智能定价功能，可以防止域名在DNS上被抢注。较小的名称和名称空间更昂贵，因为它们可能更受欢迎。没有数字的名字比有数字的名字更受欢迎。

> #### Blockstack的4层架构:
>
> **第一层：** 像比特币这样的区块链存储了关于系统状态的权威全球共识。
>
> **第2层-虚拟链:** 一个与区块链无关的层，它接受来自区块链的输入，可以创建任意类型的状态机。例如，DNS状态机可以与标识状态机不同。这一层也可以处理任何你想要的区块链，但可靠性和安全性将是基础区块链的衍生物。Virtuachain还将名称绑定到它们的值。zonefile的散列存储在这个层中。
>
> **第3层路由:** 该层实现一个DHT，它存储值的路由信息。Blockstack使用像zonefile这样的DNS来指示数据的最终存储位置。基本上，第3层的任务是发现与给定名称关联的最终数据。任何用户都可以通过验证存储在第2层中的散列来验证zonefile的完整性。
>
> **第4层-存储:** 这是存储所有值的地方。这可以是在AWS或dropbox或任何第三方供应商。这里有两种类型。

终端上的APP需要通过Blockstack browser(存储private key的特定软件)来访问

Bitcoin ->BNS -> Bitcoin ->Atlas -> Gaia



Certificate Transparency 相对于 Bitcoin没法解决 name conflics的问题。



讲师对Blockstack应用的前景不是太看好，相较于中心化服务器，编程上会更麻烦...