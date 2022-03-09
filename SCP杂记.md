# SCP杂记

## 1.MAP

### 1.1 SCTP

流控制传输协议（SCTP，Stream Control Transmission Protocol）是一种在网络连接两端之间同时传输多个数据流的协议。SCTP提供的服务与UDP和TCP类似。

和TCP类似，SCTP是面向连接、端到端、全双工、带有流量和拥塞控制的可靠传输协议。SCTP的连接称为关联。SCTP的关联通过4次握手建立。相对于TCP的3次握手建立连接，SCTP的关联能够抵御拒绝服务(DoS)攻击，从而提高了安全性。

### 1.2 M3UA

M3UA（MTP3 User Adaptation）表示MTP（Message Transfer Part，消息传递部分）第三级用户的适配层协议。

用户层消息，比如一个IAM（Initial Address Message，初始地址消息）消息，在SEP（Signaling End Point，信令端节点）处，采用MTP层层封装后，才能通过E1线路送到SG（Signaling Gateway，信令网关），SG解封装MTP-1、MTP-2、MTP-3，然后看到此IAM消息，但它并不处理，而是采用NIF（Node Interworking Function，节点互通功能）将此消息原封不动的封装进M3UA，外面再封装SCTP（Stream Control Transmission Protocol，流控制传输协议）和IP，通过IP网络送给软交换系统，**软交换系统打开IP、SCTP、M3UA包装**，才看能到SEP送来的IAM消息

M3UA协议是MTP第三级的适配层协议，七号信令网通过M3UA和MTP3的无缝配合，平滑地从SCN网延伸到IP网络中

### 1.3 SCCP

信令连接控制部分（SCCP，Signaling Connection Control Part）在No.7信号方式的分层结构中，属于MTP的用户部分之一，同时为MTP提供基于全局码的路由和选路功能，以便通过[No.7信令网](https://baike.baidu.com/item/No.7信令网/16588127)在电信网中的交换局之间传送电路相关的、非电路相关的信息和其他类型的信息，建立无连接或面向连接的服务。

当用户要求传送的数据超过MTP的限制时，SCCP还要提供必要的分段和重新组装功能。SCCP属于No.7信令网第三层，完成MTP3的补充寻址功能，即与MTP3结合,提供相当于[OSI参考模型](https://baike.baidu.com/item/OSI参考模型/708028)的网络层功能。

[消息传递部分](https://baike.baidu.com/item/消息传递部分/16688323)（MTP）的主要功能是在信令网中提供可靠的信令消息传递，将源信令点的用户发出的信令单元正确无误地传递到目的地信令点的指定用户，并在信令网发生故障时采取必要的措施以恢复信令消息的正确传递。 [3] 

> MTP由[信令数据链路](https://baike.baidu.com/item/信令数据链路/16688324)功能（MTP1）、[信令链路](https://baike.baidu.com/item/信令链路/5925769)功能（MTP2）和[信令网](https://baike.baidu.com/item/信令网/7830343)功能（MTP3）3个功能级组成。 [4] 
>
> 1. 信令数据链路级：信令数据链路级是No.7信令系统最低层，在这一层里规定了信令数据链路的物理、电气和功能特性，并确定[数据链路](https://baike.baidu.com/item/数据链路/7181323)的接入方式，为信令链路提供了一个[信息载体](https://baike.baidu.com/item/信息载体/4309185)。信令数据链路提供传送信令消息的物理通道，它由一对传送速率相同、工作方向相反的数据通路组成，完成二进制[比特流](https://baike.baidu.com/item/比特流/6435599)的透明传输。信令数据链路有数字和模拟两种信令数据链路传输通道。数字信令链路指传输通道的[传输速率](https://baike.baidu.com/item/传输速率/10839944)为64kbit/s和2.048Mbit/s的高速信令[链路](https://baike.baidu.com/item/链路/9410314)，模拟信令数据链路指传输速率为4.8kbit/s的低速信令链路。 [4] 
> 2. 信令链路功能级：信令链路功能级规定了在一条信令数据链路上，信令消息的传递和与传递有关的功能和过程，包括信令单元[定界](https://baike.baidu.com/item/定界/2704271)和定位、差错校正、初始定位、信令链路[差错率](https://baike.baidu.com/item/差错率/327811)监视、信令业务[流量控制](https://baike.baidu.com/item/流量控制/3441910)、处理机故障控制等。 [4] 
> 3. 信令网功能级：信令网功能是在信令网中当信令链和信令转接点发生故障的情况下，为保证可靠地传递各种信令消息，规定在信令点之间传送管理消息的功能和程序。它是在信令链路功能基础上实现的，信令网功能包括信令消息处理功能和信令网管理功能两部分。

为了解决以上问题，[CCIT](https://baike.baidu.com/item/CCIT/8458752)在1984年提出了一个新的结构分层，在不修改[MTP](https://baike.baidu.com/item/MTP/20493580)的前提下，增加了SCCP（信令连接控制部分）部分来弥补MTP的功能不足。

| OSI  |             |      |
| ---- | ----------- | ---- |
| 7    | MSC/HLR/VLR |      |
| 7    | MAP         |      |
| 7    | TCAP        |      |
| 4-6  | ISP         |      |
| 3    | SCCP        |      |
| 3    | MTP-3       |      |
| 2    | MTP-2       |      |
| 1    | MTP-1       |      |

### 1.4 TCAP

TCAP：事务处理能力应用部分 （Transaction Capabilities Application Part）

TCAP 信息包含于 MSU 的 SCCP 部分。一个 TCAP 信息由两部分构成：**[事务](https://baike.baidu.com/item/事务)****部分（transaction portion ）和组成部分（component portion）。**允许应用调用远端信令点的一个或多个操作，并返回操作的结果。比如，数据库访问或远端调用处理命令等。使用SCCP无连接业务（基本的或有序的），TCAP在两个用户应用之间提供事务处理对话。

Invoke （Last）：调用程序。例如，一个 Query with Permission [事务](https://baike.baidu.com/item/事务)可以包括一个 Invoke （Last） 成分，来请求 800 拨号的 SCP 转换。该组成部分是查询中的 "last" 成分。

Invoke （Not Last）：类似于 Invoke（Last）组成部分，只是其后面还有一个或多个组成部分。

Return Result （Last）：返回调用操作的结果。该成分是响应部分的 "last" 成分。

Return Result （Not Last）：类似于 Return Result （Last），只是其后面还有一个或多个组成部分。

Return Error：报告调用操作失败。

Reject：表明接收到一个不正确的数据包类型或组成部分。

### 1.5 SIGTRAN

 什么是SIGTRAN？SIGTRAN是Signaling Transport的缩写。SIGTRAN协议是IETF的信令传送工作组建立的一套在IP网络上传送PSTN信令的传输控制协议。SIGTRAN定义了一个比较完善的SIGTRAN协议堆栈，分为IP协议层、信令传输层、信令传输适配层和信令应用层。每层所含内容如下：

- IP协议层：IP
- 信令[传输层](https://baike.baidu.com/item/传输层)：SCTP
- 信令传输[适配层](https://baike.baidu.com/item/适配层)：[SUA](https://baike.baidu.com/item/SUA)、M3UA、[M2UA](https://baike.baidu.com/item/M2UA)、[M2PA](https://baike.baidu.com/item/M2PA)、IUA
- 信令[应用层](https://baike.baidu.com/item/应用层)：TCAP、TUP、ISUP、SCCP、MTP3、Q931/[QSIG](https://baike.baidu.com/item/QSIG)

| 7号信令网络 | 信令网关     | IP网络     |
| ----------- | ------------ | ---------- |
| NO.7用户层  |              | NO.7用户层 |
| MTP-3       |              | M3UA       |
| MTP-2       |              | SCTP       |
| MTP-1       | 节点互通功能 | IP         |
|             |              |            |
|             |              |            |



### 1.6 其它

**PDC** (**Personal Digital Cellular**) 是一种由[日本](https://baike.baidu.com/item/日本)开发及使用的[2G](https://baike.baidu.com/item/2G)[移动电话](https://baike.baidu.com/item/移动电话)通信标准。与[D-AMPS](https://baike.baidu.com/item/D-AMPS)及[GSM](https://baike.baidu.com/item/GSM)相似，PDC采用[TDMA](https://baike.baidu.com/item/TDMA)技术。标准由RCR（其后变成[ARIB](https://baike.baidu.com/item/ARIB)）在1991年4月制定。而[NTT DoCoMo](https://baike.baidu.com/item/NTT DoCoMo)在1993年3月推出其数字MOVA服务。PDC采用25 kHz载波、3个时间格、pi/4-[DQPSK](https://baike.baidu.com/item/DQPSK) 编码及低速率11.2 kbit/s 及 5.6 kbit/s（半速率）话音[编解码器](https://baike.baidu.com/item/编解码器)。

全球移动通信系统(Global System for Mobile Communications) ，缩写为GSM，由[欧洲电信标准组织](https://baike.baidu.com/item/欧洲电信标准组织)[ETSI](https://baike.baidu.com/item/ETSI)制订的一个[数字移动通信](https://baike.baidu.com/item/数字移动通信)标准。它的空中接口采用时分多址技术 [1] 。自90年代中期投入商用以来，被全球超过100个国家采用。GSM标准的无处不在使得在移动电话运营商之间签署"漫游协定"后用户的国际漫游变得很平常。 GSM 较之它以前的标准最大的不同是它的[信令](https://baike.baidu.com/item/信令/99474)和语音[信道](https://baike.baidu.com/item/信道/499862)都是数字式的，因此GSM被看作是第二代 ([2G](https://baike.baidu.com/item/2G/3110701))移动电话系统 [2] 。