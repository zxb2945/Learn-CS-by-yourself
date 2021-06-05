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









