# AWS Certified Solutions Architect Associate AWS认证课程

## 001 Course Introduction 20220629

B站课程地址: https://www.bilibili.com/video/BV1wR4y1F7YM?p=11&vd_source=cfea4a81af3552025602bbed3cecda4f

知乎分享：https://zhuanlan.zhihu.com/p/512791644

## 011 IAM Introduction 

IAM = Identity and Access Management, Global service

**Users & Groups** can be assigned JSON documents called policies

These policies define the permission of the users 

Don't give more permissions than a user needs



IAM **Policies** Structure Consist of 

```json
{
    "version": "2022-6-29",
    "ID": "S3-Accout-Permissions",
    "Statement":
    {
        "Sid":"an identifier for the statement",
        "Effect":"allow/deny",
        "Principle":"acount to which this policy applied to",
        "Action":"list of actions this policy allows or denies",
        "Resource":"list of resources to which the action applied to"
    }
}
```



MFA: Multi Factor Authentication

MFA = password you know +security device  you own

Virtual MFA device => Google Authenticator( only for mobile)

## 017 AWS Access Keys, CLI and SDK

CLI: AWS Command Line Interface

SDK: AWS Softeware Developer Kit

Access Keys are secret, just like a password

CLI 可以安装到Windows or Linux

```
C:\Users\zxb29>aws configure
AWS Access Key ID [None]: AKIAUCM7DC2J57xxx
AWS Secret Access Key [None]: K9jD6qwn09naDly4PguLYmbLPWIs5SRxxx
Default region name [None]: ap-northeast-1
Default output format [None]:

C:\Users\zxb29>aws iam list-users
{
    "Users": [
        {
            "Path": "/",
            "UserName": "s_kouha123",
            "UserId": "AIDAUCM7DC2JZQFMIN5UN",
            "Arn": "arn:aws:iam::280043394707:user/s_kouha123",
            "CreateDate": "2022-06-29T06:29:58+00:00",
            "PasswordLastUsed": "2022-06-29T07:07:25+00:00"
        }
    ]
}

C:\Users\zxb29>
```

而 AWS CloudShell 直接网页打开，那么它是远程登陆主机吗？

## 024 IAM Roles for AWS Services

Some AWS service will need to perform actions on your behalf

To do so, we will assign permissions to AWS services with IAM Roles

## 025 IAM Security Tools

IAM Credentials Report(accout-level)

IAM Access Advisor(user-level)

## 031 EC2 Basics

EC2=Elastic Compute Cloud=Infrastrcture as a Service

It mainly consists in the capability of:

1. Renting virtual machines(EC2)
2. Storing data on virtual drives(EBS)
3. Distributing load across machines(ELB)
4. Scaling the services using an auto-scaling group(ASG)

Knowing EC2 is fundamental to understand how the Cloud works



It is possible to **bootstrap** our instances using an EC2 User data script.

bootstrapping means launching commands when a machine starts



EC2 instance => 就是一台具体计算机



Create an EC2 Instance with EC2 user data to have a website hands on

```shell
#!/bin/bash
#install httpd
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from:$(hostname -f)</h1>" > /var/www/html/index.html
```

当你stop一个instance，再重启，public IP会改变，private IP不会。

## 033 EC2 Instance Types Basics 20220630

**Amazon Machine Image (AMI)**: Amazon Linux 2, Ubuntu...Windows

AWS has the following naming convention:

```
m5.2xlarge
```

m: instance class

5:generation(AWS inproves them over time)

2xlarge: size with the instance class

## 034 Security Groups & Classic Ports Overview

Security Group can be attached to multiple instances

(比如说有三个 security group attach, 类似于电路串联而不是并联，有一个拒绝访问就不起作用)

Security Group live "outside" the EC2

(那就是另外建立了一个防火墙服务器)

It's good to maintain one separate security group for SSH access.

If your application is not accessible(time out),then it's a security group issue.

If your application gives a "connection refused" error, then it's an application error or it's not lauched.



SSH(Secure Shell): 22

FTP(File Transfer Protocol): 21

SFTP(Secure File Transfer Protocol): 22 -**upload files using SSH**

HTTP: 80

HTTPS:443

RDP(Remote Desktop Protocol): 3389



```
0.0.0.0/0   #所有IPV4地址
::/0 #所有IPV6地址
```

## 036 SSH Overview

windows 10 以下的版本不支持SSH，此时用PuTTY，界面类似winSCP

```
[root@localhost tmp]# ssh -i EC2Tutorial.pem ec2-user@13.115.10.70
The authenticity of host '13.115.10.70 (13.115.10.70)' can't be established.
ECDSA key fingerprint is SHA256:YQ7IP7AyGbZue1UitUIvT/VPcp39W9Mi2wj/j888tVM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '13.115.10.70' (ECDSA) to the list of known hosts.
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0755 for 'EC2Tutorial.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "EC2Tutorial.pem": bad permissions
ec2-user@13.115.10.70: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
[root@localhost tmp]# chmod 0400 EC2Tutorial.pem
[root@localhost tmp]# ssh -i EC2Tutorial.pem ec2-user@13.115.10.70

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
[ec2-user@ip-172-31-15-108 ~]$ 
```



EC2 Instance Connect 是浏览器基于SSH的远程登录



## 042 EC2 Instance Roles Demo

```
[ec2-user@ip-172-31-15-108 ~]$ aws --version
aws-cli/1.18.147 Python/2.7.18 Linux/5.10.118-111.515.amzn2.x86_64 botocore/1.18.6
[ec2-user@ip-172-31-15-108 ~]$ aws iam list-users
Unable to locate credentials. You can configure credentials by running "aws configure".
[ec2-user@ip-172-31-15-108 ~]$ aws configure
AWS Access Key ID [None]: 
AWS Secret Access Key [None]: 
Default region name [None]: 
Default output format [None]: 
[ec2-user@ip-172-31-15-108 ~]$ aws iam list-users
Unable to locate credentials. You can configure credentials by running "aws configure".
[ec2-user@ip-172-31-15-108 ~]$ aws iam list-users
{
    "Users": [
        {
            "UserName": "s_kouha123", 
            "PasswordLastUsed": "2022-06-29T07:07:25Z", 
            "CreateDate": "2022-06-29T06:29:58Z", 
            "UserId": "AIDAUCM7DC2JZQFMIN5UN", 
            "Path": "/", 
            "Arn": "arn:aws:iam::280043394707:user/s_kouha123"
        }
    ]
}
[ec2-user@ip-172-31-15-108 ~]$ 
```

将之前IAM创建的一个Role连接到这个Instance来

这个Role代表你去操作EC2这个服务，那么问题是这个“你”指哪个账户？

## 043 EC2 Instance Launch Types

EC2 On Demand: pay for what you use

EC2 Reserved Instance: Up to 75% discount compared to On-Demand, Recomended for database

Convertible Reserved instance: can change the EC2 instance type

Scheduled Reserved instance: lauch within time window you reserve

EC2 Spot Instance: Up to 90% discount compared to On-Demand, Instance that you can lose at any point of time if your max price is less than the current spot price. suitable for Batch jobs, Data analysis, any distributed workloads...

EC2 Dedicated Hosts: More expensive

EC2 Decicated Instances:像EC2 Dedicated Hosts软件版本，类似于共享硬件，虚拟机？？ May share hardware with other instances  in same account.

> **Dedicated Instance と Dedicated Hosts の違い**
>
> `Dedicated Instance` では、`別アカウントのインスタンスが同じ物理サーバ上で起動しないこと` だけを保証しますが、
> `Dedicated Hosts` では、`別アカウントのインスタンスが同じ物理サーバ上で起動しないこと` だけでなく、 `同じアカウントのインスタンスを配置させることが可能` になります。 (アカウントはIAM別ではなく、Rootアカウントが違えば違うアカウントとなる)

Dedicated Hosts大概可以配合硬件搞专属服务器的意思？不是很理解Dedicated Instance既然来说别的root account也没法进来配置，那不是客观上可以让你独自改动硬件配置嘛...

## 044 Spot Instances & Spot Fleet

You can only cancel spot instance requests that are open, active, or disable.

Cancelling a spot request does not terminate instances.

You must first cancel a spot request, and then terminate the associated spot instances.



Spot Fleets (最省钱)= set of Spot instance +(optional)On-Demand Instance

Strategies to allocate Spot Instances:

1. lowestPrice
2. diversified: distributed across all pools
3. capacityOptimized

## 046 Private vs Public vs Elastic IP

When you stop and then start an EC2 instance, it can change its public IP.

If you need to have a fixed public IP for you instance, you need an Elastic IP.

An Elastic IP is a public IPv4 Ip you own as long as you don't delete it.

You can only have 5 Elastic IP in your account.

Overall, try to avoid using Elastic IP. Instead, use a random public IP and register a DNS name to it.

## 048 EC2 Placement Groups

Strategies for the group:

1. Cluster: Same Rack, Same AZ(Availability Zone)
2. Spread: spreads instances across undelying hardware(max 7 instances per group per AZ)
3. Patition:spreads instances across many different partitions(which rely on different sets of racks) within an AZ. Scales to 100s of EC2 instances per group(Hadoop,Cassandra,Kafka). The instances in a partition do not share racks with the instances in the other partitions.

## 050 Elastic Network Interfaces(ENI)

Logical component in a VPC that represent a virtual network card

1. Primary private IPv4, one or more secondary IPv4
2. One Public IPv4
3. A MAC address

You can create ENI independentlu and attach them on the fly(move them)on EC2 instances for failover.（意思是可以随便移动ENI去别的instance来定位网络问题）

首先什么是VPC？其次，虚拟网卡独立于具体instance，这可怎么实现哦...一种软件技术吗？

手动创建的ENI不会随instance终止而消失

## 053 EC2 Hibernate

The RAM state is preserved

Under the hood: the RAM state is written to a file in the root EBS volume

这里的EBS相当于磁盘吧，Hibernate类似于VM虚拟机挂起

支持这个功能有instance特性上的限制，如磁盘空间

> To enable hibernation, space is allocated on the root volume to store the instance memory (RAM). Make sure that the root volume is large enough to store the RAM contents and accommodate your expected usage, e.g. OS, applications. To use hibernation, the root volume must be an encrypted EBS volume.

##   055 EC2-Advanced Concepts(Nitro, vCPU,Capacity Reservation)

Nitro: Underlying Platform for the next generation of EC2 instances

Understanding vCPU:

​    Muitiple threads can run on one CPU

​    Each thread is represented as a virtual CPU(vCPU)

这个vCPU指核心级线程吗？这样的话所谓的一个vCPU甚至没法运行一个多线程的进程...这样太弱了吧...

Capacity Reservations: ensure you have EC2 Capacity when need.

## 056 EBS Overview 20220703

An EBS(Elastic Block Store)Volume is a network drive you can attach to your instances while they run.

Think of them as a "network USB srick"

It's locked to an Availability Zone(AZ)

Controls the EBS behaviour when an EC2 instance terminates

1. By default, the root EBS volume is deleted
2. By default, any other attached EBS volume is not deleted



## 058 EBS Snapshots Overview

Make a backup(snapshot) of your EBS volume at a point in time

Can copy snapshots across AZ or Region



Action中Manage Fast Snapshot Restore  干嘛用的？？

## 060 AMI Overview

AMI: Amazon Machine Lmage

AMI are a customization of an EC2 instance

We can create your own AMI



创建一个AMI，肯定是关联到snapshot的，他人参照你这个AMI时候，它的存储EBS就是从你这个AMI关联的snapshot上创造出来的吧。

## 062 EC2 Instance Store

Compared to EBS, EC2 Instance Store has better I/O performance, and risk to loss data if hardware fails.

## 063 EBS Volume Types

gp(SSD): General purpose SSD

iol(SSD): Highest performance SSD

stl/scl(HDD): Low cost HDD



Only gp/iol can be used as boot volumes（用于操作系统启动，HDD也可以，大概是AMAZON考虑到顾客体验吧...）



io1/io2 with Multi-Attach: Attach the same EBS Volume to multiple EC2 instances in the same AZ. Application must manage concurrent write operations. (only io1/io2 can multi-attcach)

## 065 EBS Encryption

这个episode谈论了两种方式，一个未加密的snapshot，先复制为一个加密的snapshot，然后在这个加密的snapshot创造出一个volume，自动继承加密；一个未加密的snapshot，创造出volume时候加密，也成为一个加密的volume...(好无聊...)

## 066 EFS Overview

Managed NFS(network file system) that can be mounted on many EC2

EFS works with EC2 instances in multi-AZ (conpared to EBS)

scalable,expensive(3 x gp2)

Use cases: content management, web serving, data sharing...

Compatible with Linux(POSIX) based AMI(not Windows)

File system scales automatically, pay-per-use, no capacity planning!

Performance mode:

1. General purpoese(default):latency-sensitive use cases(web server...)
2. Max I/O:higher latency, higher parallel( big data...)

Throughout mode:

1. Bursting(1TB = 50MiB/s + burst of up to 100MiB/s) 与容量成正比
2. Provisioned: set your throughput regardless of storage size.

Storage Tiers:( Lifecycle management , 30days default)

1. Standard: for frequently accessed files
2. Infrequent access: cost to retrieve files, lower price to store

## 068 EBS vs EFS - Elastic Block Storage 20220704

To migrate an EBS volume across AZ

1. Take a snapshot
2. Restore the snapshot to another AZ
3. EBS backups use IO and you shouldn't run then while your application is handing a lot of traffic.

## 070 High Availability and Scalability

Vertical scalability指单个instance的硬件升级来提高performance

Horizontal  scalability 就运用分布式框架增加instance来提高performance

## 071 Elastic Load Balancing(ELB) Overview

Load Balances are servers that forward traffic to multiple servers downstream.

Health Check are crucial for Load Balancers

Types of load balancers on AWS

1. Classic Load Balancer-2009-CLB, HTTP,HTTPS,TCP,SSL
2. Application Load Balancer-2016-ALB, HTTP,HTTPS,WebSocket
3. Network Load Balancer-2017-NLB, TCP,TLS,UDP ->(layer4)
4. Gateway Load Balancer-2020-GWLB, Operating at layer3(IP)

Overall,it is recommended to use the newer generation load balancers as they provide more features.

## 074 Application Load Balancer(ALB)

Load balancing to multiple HTTP applications across machines

Load balancing to multiple HTTP applications on the same machine

Support redirects(from HTTP to HTTPS for example)=>has a port mapping feature to redirect to a dynamic port in ECS

ALB routing tables to different target groups based on HTTP(layer 7, URL), a great fit for micro sevices & container-based application(example:Docker &Amazon ECS)

The application servers don't see the IP of the client directly, the true IP of the client is inserted in the header X-Forwarded-For

(security group中的source中添加另一个安全组号来控制流量不太懂...security group不是规则的集合吗？难道还能作为主机IP的集合？？它的意思是特定另一个security group出来的流量？)

## 076 Network Load Balancer(NLB)

Network load balances(Layer 4) allow to:

1. Forward TCP&UDP traffic to your instances
2. Handle milions of request per seconds
3. Less latency ~100ms (vs 400ms for ALB)

NLB has **one static IP** per AZ, and supprots assigning Elastic IP(helpful for whitelisting specific IP)

## 078 Gateway Load Balancer(GWLB)

Deploy,scale,and manage a fleet of 3rd party network virtual appliances in AWS.

Example:Firewalls,Deeo Packet Inspection Systems...

Operates at Layer 3 (Network Layer)-IP Packets

从网上收集流量，先转发到第三方的3rd Party Secutiry Virtual Appliances分析，OK之后传回GWLB，GWLB再转发到Application. （网关嘛路由转发）

## 079 ELB-Sticky Sessions

Operation order:EC2->Target groups->my-first-target-group->Edit attributes

基于cookie，ELB将固定client转发到固定instances，会有expire时间

## 080 ELB-Cross-Zone Load Balancing

ELB必然也存在于一个特定的AZ，负载均衡时可以无视instance的AZ差异。只是对于ALB，默认开启且不能被关所以免费；对于NLB，默认关闭，启用收费；而CLB虽然默认关闭但启用不收费...

## 081 ELB-SSL Certificates

SSL: Secure Sockets Layer, used to encrypt connections (HTTPS)

TLS: Transport Layer Security, which is a newer version of SSL



SNL: Server Name Indication

SNI solves the problem of loading mutiple SSL certificates onto one web server(to serve multiple websites), it's a "newer" protocol, supported by ALB and NLB, not supported by CLB

CA: Certificate Authorities, such as Comodo, Symantec, etc...

ELB为不同instances上的instances去申请不同CA的能力

## 082 Connection Draining

在CLB，被称为Connection Draining, 对于ALB&NLB，叫作Deregistration Delay。

Time to complete "in-fight requests" while the instance is de-reistering or unhealthy.

比如下载某个文件这种需要一定时间完成的request，就需要将此设得时间长一些，ELB大概在这段时间里持续向特定的instance去询问吧。

Set to a low value if your requests are short.

## 083 Auto Scaling Group(ASG) Overview

Subnets => 子网

The goal of an Auto Scaling Group is to:

1. Scale out(add EC2 instances) to match an increased load
2. Scale in(remove EC2 instances) to match an decreased load
3. Ensure we have a minimum and maximum number of machines running
4. Automatically Register new instances to a load balancer

Auto Scaling Group in AWS with Load Balancer

Scaling policies can be on CPU,Network,even schedule

1. Dynamic scaling policies => target tracking policy(比如CPU利用率)
2. Predictive scaling policies  => based on machine learning
3. Scheduled actions



ASG Default Termination Policy:

1. Find the AZ which has the most number of instances
2. If there are multiple instances in the AZ to choose from, delete the one with the oldest launch configuration

ASG tries the balance the number of instances across AZ by default.



Lauch Template vs Launch Configuration:

都能提供AMI去launch EC2 instances, 只是前者更newer，Recommended By AWS

## 088 Amazon RDS Overview 20220705

RDS stands for Relational Database Service

It's managed DB **service** for DB use SQL as a query language.

It allows you to create databases in the cloud that are managed by AWS

​	PostgreSQL,MySQL,MariaDB,Oracle,Microsoft SQL Server,Aurora

But you can't SSH into your instances.



DB Snapshots compared to Backups:

1. Manually triggered by the user
2. Retention of backup for as long as you want.



RDS backups and scales automatically for you.



> Amazon RDS 提供三个存储类型：通用型 SSD（也称为 gp2）、预置 IOPS SSD（也称为 io1）和磁性存储（也称为标准）。它们的性能特性和价格不同，这意味着您可以根据数据库工作负载需求定制存储性能和成本。您可以创建最多具有 64 TiB 存储的 MySQL、MariaDB、Oracle 和 PostgreSQL RDS 数据库实例。您可以创建最多具有 16 TiB 存储的 SQL Server RDS 数据库实例。对于此存储量，请使用预配置 IOPS SSD 和通用型 (SSD) 存储类型。
>
> 下面的列表简要介绍这三个存储类型：
>
> - **通用型 SSD** – 通用型 SSD 卷提供了适用于各种工作负载的经济高效的存储。这些卷可以提供几毫秒的延迟，能够突增至 3000 IOPS 并维持一段较长的时间。这些卷的基准性能是由卷的大小决定的。
>
>   有关通用型 SSD 存储的更多信息（包括存储大小范围）。
>
> - **预配置 IOPS** – 预配置 IOPS 存储符合 I/O 密集型工作负载（尤其是数据库工作负载）的需求，此类工作负载需要低 I/O 延迟和一致的 I/O 吞吐量。
>
>   有关预配置 (IOPS) 存储的更多信息 (包括存储大小范围)。
>
> - **磁性** – Amazon RDS 还支持磁性存储以实现向后兼容。我们建议您采用通用型 SSD 或预配置 IOPS 来满足所有新存储需求。磁性存储上的数据库实例允许的最大存储量少于其他存储类型的这种量。

## 089 RDS Read Replicas vs Multi AZ

RDS Read Replicas for read scalability

​	up to 5 Read Replicas

​	With AZ, Cross AZ or Cross Region

For RDS Read Replicas within the same region, you don't pay that fee.

(RDS 是托管服务)



RDS Muiti AZ (Disaster Recovery)

​	SYNC replication

​	One DNS name-automatic app failover to standby

​	Not used for scaling

Note: The Read Replicas can be setup as Multi AZ for Disaster Reconvery.



RDS-From Single-AZ to Muti-AZ:

1. A snapshot is taken
2. A new DB is restored from the snapshot in a new AZ
3. Synchronization is established between the two databases.

So just click on "modify" for the database, it's Zero downtime operation.(no need to stop the DB)

RDS的security group还是在EC2上统一管理的。

## 091 RDS Encryption+Security

Encruption has to be defined at launch time.

If the master is not encrypted, the read replicas cannot be encrypted.

SSL certificates to encrypt data to RDS in flight.



IAM database authentication only works with MySQL and PostgreSQL.

## 092 Aurora Overview

Postgres and MySQL are both supported as Aurora DB(that means your drivers will work as if Aurora was a Postgres or MySQL database)

Aurora is "**AWS cloud optimized**" and claims 5x performance improvement over MySQL on RDS, over 3x the performance of Postgre on RDS.

 

Aurora High Availability and Read Scaling:

6 copies of your data across 3 AZ

​	4 copies out of 6 needed for writes

​	3 copies out of 6 need for reads

​	self healing with peer-to-peer replication

Auto Expanding



Between Client and Aurora DB cluster:

Writer Endpoint：Pointing to the master, DNS name don't change even failover

Reader Endpoint: Connection Load Balancing because of Auto Scaling 

这里的Auto Scaling大概是两个层次，其一是单一Aurora，其二是read-only server层面的自动扩容。

## 094 Aurora-Advanced Concepts

Aurora Replicas-Auto Scaling

Custom Endpoints: Define a subset of Aurora Instances as a Custom Endpoint. Example-Run analytical queries on specific replicas. The reader endpoint is generally not used after defining Custom Endpoints.

Aurora Serverless: Automated database instantiation and auto-scaling based on actual usage.

Aurora Multi-Master: Every node does R/W => an immediate failover for writer

Global Aurora: 1 Primary Region(r/w); Up to 5 secondary(read-only) region.

Aurora Machine Learning: Simple ,optimized, and secure intergration between Aurora and AWS ML sevices(Amazon SageMaker, Amazon Conprehend)

## 095 ElastiCache Overview

The same way RDS is to get managed Relational Database...

ElasticCache is to get managed Redis or Mencahced.

Cache are in-memory databases with really high performance,low latency

AWS takes care of OS maintance,configuration,failure recovery...

Using ElatiCache involves heavy application code changes...



ElasticCache Solution Architecture:

1. DB Cahce: Applications queries ElastiCache(Cache hit),if not(Cache miss),get from RDS and store in ElasticCache.
2. User Session Store:



Redis vs Memcached:  High availibity vs No High availibity 

 

All caches in ElastiCache:

​	Do not support IAM authentication

​	IAM policies on ElastiCache are only used for AWS API-level security

Redis AUTH

​	You can set a password/token when you create a Redis cluster

​	Support SSL in flight encryption



Memcached: Support SASL-based authentication(advanced)

cannot use SQL

## 099 What is a DNS

Domain Name System

Domain Register:Amazon Route 53,GoDaddy...

FQDN(Full Qualified Domain Name): Protocol//:Domain Name(api.www.google.com.)=>Sub Domain Name(www.google.com.)=>Second Level Domain(google.com.)=>Top Level Domain(.com.)=>Root(.)



Web Browser => Local DNS Server => Root DNS Server, TLD DNS Server, SLD DNS server

## 100 Route 53 Overview

Why Route 53? 53 is a reference to the traditional DNS port.

A highly available,scalable,fully managed and Authoritative DNS(the customer you can update the DNS records)

Route 53 is also a Domain Registrar



Route 53  supports the following DNS record types:

​    A/AAAA/CNAME/NS

A:maps a hostname to IPv4

AAAA:maps a hostname to IPv6

CNAMW:maps a hostname to another hostname

NS:Name Servers for the Hosted Zone => DNS name or address

> | 类型  | **目的**                                                     |
> | ----- | ------------------------------------------------------------ |
> | A     | 地址记录，用来指定域名的 IPv4 地址，如果需要将域名指向一个 IP 地址，就需要添加 A 记录。 |
> | AAAA  | 用来指定主机名(或域名)对应的 IPv6 地址记录。                 |
> | CNAME | 如果需要将域名指向另一个域名，再由另一个域名提供 ip 地址，就需要添加 CNAME 记录。 |
> | MX    | 如果需要设置邮箱，让邮箱能够收到邮件，需要添加 MX 记录。     |
> | NS    | 域名服务器记录，如果需要把子域名交给其他 DNS 服务器解析，就需要添加 NS 记录。 |
> | SOA   | SOA 这种记录是所有区域性文件中的强制性记录。它必须是一个文件中的第一个记录。 |
> | TXT   | 可以写任何东西，长度限制为 255。绝大多数的 TXT记录是用来做 SPF 记录(反垃圾邮件)。 |

Hosted Zone: A container for records that define how to route traffic to a domain and its subdomains. (可以理解为你专属DNS服务器的一个分机)

Public Hosted Zone / Private Hosted Zone

你可以独占一个Route 53.

## 104 Route 53 - TTL

Time to Live

是时间，不是次数...

client will cache the result for the TTL of the record

## 105 Route 53 CNAME vs Alias

CNAME是一般DNS服务器通用性质，而Alias是AWS特有的，an extension to DNS functionality.

Alias Record: Maps a hostname tp an AWS resource. Unlike CNAME,it can be used for the top node of a DNS namespace(Zone Apex). But you can't set TTL.

Alias Records Targets: ELB, S3 Websites...but You can't set it for an EC2 DNS name

## 106 Routing Policy 20220706

Difine how Route 53 responds to DNS queries.(Don't confused by the word "routing", DNS does not route any traffic, it only responds to the DNS queries)

Route 53 Supports the following Routing Policies（一个DNS name,多个IP前提下）:

### Simple

Can specify multiple values in the same record

If multiple values, are retured, a random one is chosen by the client.

### Weighted

Control the % of the requests that go to each specific resource

DNS records must have the same name and type

对于同一个名字，如douban.com, 它对应多个IP，加权比重概率返回其中一个IP.

### Latency-based

 Redirect to the resource that has he least latency close to us.

Latency is based on the traffic between users and AWS Regiones

### Failover

对一个DNS name, 两个IP的情况，将两个IP分为Primary和Secondary，前者的

Health Check是mandatory, 后者optional，前者失败failover到后者。

### Geolocation

Diffrent from Latency-based!

This routing is based on user location(这个并不是说靠近原则，而是需要手动指定某个区域去某个DNS服务器)

Should create a "Default" record(in case there's no match no location)

### Geoproximity

Route traffic to your resources based on the geographic location of users and resources

Ability to shift more traffic to resources based on the defined bias.

当bias=0, 基本可以等同于就近原则，当你想更广范围的users到这个服务器上来访问时，就增加这个服务器的bias.

### Multivalue Answer

Use when routing traffic to multiple resources

Can be associated with Health Checks(return only values for healthy resources)

这个相对Simple，就是可以运用Health Checks? 其他就是形式上，Simple只是一条record，只是value写多个地址，而Multivalue则是多条records.

## 109 Route 53 - Health Checks

可以理解为在因特网上AWS专属？的定期检查端点通信状况的HTTP协议服务。

不适用于Simple Routing Policy.

Health checks that monitor CloudWatch Alarms(helpful for private resources)

不仅是Route 53, 也可以放到ELB上。



Tips for the whole lecture: if you see connection timeout, you should check firewall first.

## 114 Route 53 - Traffic flow

Simplify the process of creating and maintaining records in large and complex configurations

Visual editor to manage complex routing decision trees

可视化组合各种Routing Policy，Geoproximity尤其对此依赖。

## 116 3rd Party Domains & Route 53

Domain Registrar != DNS service

But every Domain Registrar usually comes with some DNS features



If  you buy your domain on a 3rd party registrar, you can still use Route 53 as the DNS Service provider.

所以Route 53首先是一个可以买卖域名的Domain Registrar，然后它通过Hosted Zone的形式提供DNS Service. 我们所谓的独占其实也是这个Hosted Zone.

## 119 WhatsTheTime.com

Elastic IP vs Route 53 vs Load Balancers

Maintaining EC2 instances manually vs Auto Scaling Groups

Multi AZ to survive disasters

这里需要注意的是，Multi AZ 是在ELB而不是Auto Scaling处设置的。??抑或是两处要协调设置...

 We're considering 5 pollars for a well architected application:

​	costs,performance,reliability,security,operational excellence

## 120 MyClothes.com

活用ELB Stickiness避免用户访问其他instances丢失存储于EC2上的购物信息. 

但可以另外换一个思路，将用户购物信息存储于浏览器的Cookies上，就不需要Stickiness. 这样的的框架有一下性质：

Stateless(指EC2不需要存储购物信息)

Http requests are heavier => Cookie must be less than 4KB

Security risk(cookies can be altered) => Cookie must be validated

进一步，我们加上一个ElsaticCache存储购物信息，而Cookies只放上session_id信息，在ElastiCache 中 Store/retrive session data, 性能也很好，又安全

再进一步，加上RDS，在ElastiCache miss的情况下访问RDS，然后设置write master, read scaling.

最后，在ELB，EC2，RDS等设置Multi-AZ，Security Group来提高安全性

## 121 MyWordPress.com

这里两个EC2各自连接EBS肯定不行，但是更换成一个EFS后，与两个EC2之间为什么要加ENI, 我觉得不是必需的吧...

## 123 Elastic Beanstalk

Elastic Beanstalk is a developer centric view of deploying an application on AWS.

Managed service:

1. Automatically handles capacity provisioning, load balancing, scaling, application health monitoring, instance configuration...
2. Just the application code is the responsibility of the developer.

We still have full control over the configuration.

## 126 S3 Buckets and Objects

Amazon S3 allows people to store objects(file) in "buckets"(directories)

Buckets must have a globally unique name

Name convention:

1. No uppercase
2. No underscore
3. 3-63 characters long
4. Not an IP
5. Must start with lowercase letter or number



Obejects(files) have a key, The key is the FULL path.

s3://my-bucket/my_file.txt

## 128 S3 Versioning

You can version your files in Amazon S3

Easy roll back to previous version

Notes:

1. Any file that is not versioned prior to enabling versioning will have version "null"
2. Suspending versioning does not delete the previous versions

## 130 S3 Encryption

There are 4 methods of encrypting objects in S3:

1. SSE-S3
2. SSE-KMS
3. SSE-C: S3 does not store the encryption key you provide,HTTPS is mandatory for SSE-C.
4. Client Side Encryption

前三者都是 server-side encryption, 只是前两者的key由S3提供。

## 132 S3 Security & Bucket policies

User based: 

1. IAM policies=>which API calls should be allowed for a specific user from IAM console

Resource Based: 

1. Bucket policies=>bucket wide rules from the s3 console-allows cross account
2. ACL(Access Control List)



Bucket Policies: JSON based policies

Bucket settings for Block Public Access

**These settings were created to prevent company data leaks**

## 134 S3 Websites

S3 can host static websites and have them accessible on the WWW.

Operation:Properties=>Static website hosting

接下来做两步对public开放：

1. Block public access Edit
2. Bucker policy Edit => permit to get any objects

## 135 S3 CORS 20220707

CORS: CORS means Cross-Origin Resource Sharing

Origin: a protocol + host domian + port(http://www.google.com)

谷歌网站上不同文件路径就是same origin,谷歌跟百度就是different origin.

不同bucket就是different origin, (Enabled as a website前提)

The requests won't be fulfilled unless the other origin allows for the requests, using CORS Headers(ex: Access-Control-Allow-Origin)

Web Browser based mechanism to allow requests to other ogrigins while visting the main origin.

浏览器会去被引用的网站问一下是否允许被引用，no的话浏览器就拒绝加载

## 138 IAM Roles and Policies

IAM中一个Role可以有很条Policies，这些policies允许你去各个服务如S3增删改查，policy可以自定义

测试这个性质可以用一个在线工具：AWS Policy Simulator

## 140 AWS EC2 Instance Metdadata

```
curl http://169.254.169.254/latest/meta-data/
```

上述IP基本上是AWS内部网点，它只作用于用你的EC2去访问，查询EC2的关联信息。（类似于EC2作为此内部网点的用户？）

It allows AWS EC2 instances to "learn about themselves" without using an IAM Role for that purpose.

## 142 S3 MFA Delete

字面是理解是要完全删除某个版本需要MFA的功能。

启用这个功能目前不能通过UI，而是客户端来操作，十分繁琐

然后演示中，它也没出现输入MFA的界面...只是开启关闭这个功能来寻求不同...

## 144 S3 Default Encryption

One way to force encryption is to use a bucket policy and refuse any API call to PUT an S3 object without encryption headers;

Another way is to use the default encryption iption in S3

这两个内容昨天不是讲了吗？总结？

## 145 S3 Access Logs

Any request made to S3, from any account, authorized or denied, will be logged into **another** S3 bucket.

Warning:

Do not set your loggin bucket to be the monitored bucket

It will create a logging loop, and your bucket will grow in size exponentially.

## 147 S3 Replication(CRR&SRR)

Must enable versioning in source and destination

CRR:Cross Region Repilication

SRR:Same Region Replication

Buckets can be in different accouts



Notes；

After activatin, only new objects are replicated

There is no "chaining" of replication(不会连续复制，1自动复制到2，2不会将此自动复制到3，所以2不将复制过来的文件视为写入。)

For Delete oprations: can replicate delete markers from source to target(optional setting)

## 149 S3 Pre-sgined URLs

Can generate pre-signed URLs using SDK or CLI

Valid for a default of 3600 seconds, can change timeout with expires.(generating URLs dynamically)

Users given a pre-signed URL inherit the permissions of the person who generated the URL for GET/PUT

注意到console中bucket中文件显示的地址没法打开(S3 变公开就可以打开)，而下载键后打开网页其实是一个新的URL，这个就是pre-signed URL.

## 151 S3 Storage Classes & Glacier

Standard: High durabiliry(99.999999%)

Standard-Infrequent Access(IA):useCases=>backup

One Zone-infrequent Access:Low cost compared to IA

Intelligent Tiering: Automatically moves objects between two access tiers based on changing access patterns(Standard <=> IA)

Glacier: very low cost, 取用时需要额外的唤醒时间(1-12hours)

Glacier Deep Archive: for super long storage, even cheaper, more retrieval time(12-48hours) 

## 153 S3 Lifecycle Rules

You can transition objects between storage classes

Moving objects can be automated using a lifecycle configuration

Lifecycle Rules:

1. transition actions
2. expiration actions

相当于移动不要的文件到低成本存储的自动化脚本

## 155 S3 Analytics

Storage Class Analysis

You can setup S3 Analytics to help determine when to trasition objects from Standard to Standard_IA

## 156 S3 Performance

Baseline Performance: Amazon S3 automatically scales to high request rates,latency 100-200 ms.

If you use SSE-KMS, you may be impacted by the KMS limits

recommended Muti-Part upload for files >100MB

讨论上传下载性能的限制与优化

## 157 S3 Select & Glacier Select

Retrieve less data using SQL by performing server side filtering

Can filter by rows & colums(simple SQL statements)

Less network transfer, less CPU cost client-side.

大概是S3侧开启Server-side filtering功能...没有hands on, 具体不知...

## 158 S3 Event Notifications

Types: SNS, SQS, Lambda Function

## 160 S3 Requester pays

In general ,bucket owners pay for all Amazon S3 storage and data transfer costs associated with their bucket

With Requester Pays buckets, the requester instead of the bucket owner pays the cost of the request and the data download from the bucket.

Helpful when you wang to share large datasets with other accounts

## 161 Athena Overview

Serverless query service to perform analytics against S3 objects

Uses standard SQL language to query the files

Support CSV,JSON...(built on Presto)

相当于一个可以分析S3各种行为的独立的服务器。

```
create database sa_access_logs_db

CREATE EXTERNAL TABLE `sa_access_logs_db.mybucket_logs`(
  `bucketowner` STRING,
  `bucket_name` STRING,
  `requestdatetime` STRING,
  `remoteip` STRING,
  `requester` STRING,
  `requestid` STRING,
  `operation` STRING,
  `key` STRING,
  `request_uri` STRING,
  `httpstatus` STRING,
  `errorcode` STRING,
  `bytessent` BIGINT,
  `objectsize` BIGINT,
  `totaltime` STRING,
  `turnaroundtime` STRING,
  `referrer` STRING,
  `useragent` STRING,
  `versionid` STRING,
  `hostid` STRING,
  `sigv` STRING,
  `ciphersuite` STRING,
  `authtype` STRING,
  `endpoint` STRING,
  `tlsversion` STRING)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  'input.regex'='([^ ]*) ([^ ]*) \\[(.*?)\\] ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) (-|[0-9]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) ([^ ]*)(?: ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*))?.*$')
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mysqlzxb/WorkNote/'
  
  SELECT * FROM sa_access_logs_db.mybucket_logs WHERE
key = 'images/picture.jpg' AND operation like '%DELETE%';
```

source: https://aws.amazon.com/cn/premiumsupport/knowledge-center/analyze-logs-athena/

=>如何使用 Athena 分析我的 Amazon S3 服务器访问日志？

前提是 “s3://mysqlzxb/WorkNote/” 作为S3 Access Logs.

## 163 S3 Lock Policies & Glacier Vault Lock

Glacier Vault Lock:

Adopt a WORM(Write Once Read Many) model

Lock the policy for future edits(can no longer be changed)

S3 Objects Lock(versioning must be enabled):

Adopt a WORM(Write Once Read Many) model

Block an object version deletion for a specified amount of time

没有hands on, 没有印象...

> 借助 S3 对象锁定，您可以使用*一次写入，多次读取* (WORM) 模式存储对象。对象锁定可帮助防止在固定的时间段内或无限期地删除或覆盖对象。可以使用对象锁定来帮助您满足需要 WORM 存储的法规要求，或只是添加另一个保护层来防止对象被更改和删除。
>
> 对象锁定仅适用于受版本控制的存储桶，保留期限和依法保留则适用于单个对象版本。当您锁定某一对象版本时，Amazon S3 会将锁定信息存储在该对象版本的元数据中。对对象实施保留期限或依法保留仅保护在请求中指定的版本。它不阻止创建该对象的新版本。

## 164 CloudFront Overview 20220709

Content Delivery Network(CDN)

Improve read performance, content is cahced at the edge



CloudFront - Origins =》 S3 Bucket:

1. For distributing files and caching them at the edge
2. Enhanced security with CloudFront Origin Access Identity(OAI)

CloudFront - Origins =》 Custom Origin(HTTP): ALB,EC2,S3 website,Any HTTP backend you want



Client<=> Edge Location <=> Origin:S3 or HTTP(Globally) 

你在美国去澳大利亚读取内容，次数多了，澳大利亚的内容就被缓存到美国边缘节点，与S3 Cross Region Replication 比多为static content而不是dynamic content.

## 166 CloudFront Signed URL/Cookies

You want to distribute paid shared content to premium users over the world.

Signed URL = access to individual files( one signed URL per file)

Signed Cookies = access to multiple files( one signed cookie for many files)

CloudFront Signed URL vs S3 Pre-Signed URl, 差不多，非要说就是是否直连S3 bucket，前者CloudFront与S3之间还有个OAI.

## 167 CloudFront Advanced Concepts

CloudFront Edge  locations are all around the world

The cost of data out per edge location varies

Multi-Origin

Origin Groups: High availibilty

Field Level Encryption: Sensitive information encrypted at the edge close to user

## 168 AWS Global Accelerator Overview 20220710

背景：一个美国Client访问位于印度的Server，如果Public network需要跳太多路由器，所以先去访问位于美国的Edge Location，然后通过AWS私网直接去访问印度的Server，来减少延迟。中间运用所谓的Anycast IP，不细究...

Unicast IP: one server holds one IP address

Anycast IP: all servers hold the same IP address and the client is routed to the nearest one

后者是怎么实现的呢？就是不同IP的服务器通过~~同一台~~Proxy向全球各地users提供服务，而这台Proxy就是所谓的Accelerator

AWS Global Acceleraor vs CloudFront:

**They both use the AWS global network and its edge locations around the world**

Both services integrate with AWS Shield for DDos protection.

因为AWS Global Acceleraor更多是Proxy，而不是缓存，所以我觉得更安全

## 170 AWS Snow Family Overview

Highly-secure, portable **devices** to collect and process data at the edge, and migrate data into and out of AWS.

Amazon将一些硬件邮寄给你，你可以用来比网络速度更快的硬件数据迁移，然后寄回去，直接插到网络服务中...下面从小到大共有三种，最小的Snowcone可以放到无人机上，最大的Snowmobile居然是辆大卡车...

1. Snowcone
2. Snowball Edge
3. Snowmobile

除了Data migration外，上述前两者还可以做Edge computing，就是暂时不能联网的地方，比如海船上做机器学习产生了大量数据，所以要求除了硬盘，还要CPU.

不是所有地区都提供...

Snowball cannnot import to Glacier directly, you must use Amzon S3 first, in combination with an S3 lifecycle policy.

## 173 Storage Gateway Overview

所谓的Hybrid Cloud for Storage，就是一部分infrastructure在云上，一部分在本地...问题是怎样将S3（Unlike EFS/NFS）延伸到本地呢？

AWS Storage Cloud Native Options:

1. Block: Amazon EBS, EC2 instance Store
2. File: Amazon EFS, Amazon FSx
3. Object: Amazon S3, Amazon Glacier



AWS Storage Gateway: Bridge between on -premises data(本地？) and cloud data in S3.

3 types of Storage Gateway:

1. File gateway: Store files as objects in S3, with a local cache for low-latency access to your most recently used data.
2. Volume gateway: Block storage in S3 with point-in-time backups as EBS snapshots.
3. Tape gateway: Backup your data to S3 and archive in Glacier using your existing tape-based processes.

这个gateway应该在你本地网络虚拟化，如果没有，也可以向Amazon买Hardware appliance. Tape gateway是本地磁盘化然后存到S3去？File gateway似乎可以用NFS相关协议...而后两者用iSCSI interface来连接Application Server和Gateway，Volume gateway可以整个cache到本地，定期向云端backup？所介绍的功能越来越边缘且无趣...

## 175 Amazon FSx Overview

EFS is a shared POSIX system for Linux systems



FSx for Windows is a fully managed Windows file system share drive

Support SMB protocol & Windows NTFS



FSx for Lustre: a type  of parallel distributed file system, for large-scale computing. The name Lustre is derived from "Linux" and "cluster" => Machine Learning, High Performance Computing(HPC), Seamless integration with S3...



> **Amazon FSx for NetApp ONTAP**
>
> Amazon FSx for NetApp ONTAP 提供功能丰富、高性能且高度可靠的存储，这些存储基于 NetApp 流行的 ONTAP 文件系统构建，完全由 AWS 托管。
>
> - 可通过各种 Linux、Windows 和 macOS 计算实例和容器访问(在 AWS 上或本地部署运行)，支持行业标准的 NFS、SMB 和 iSCSI 协议。
> - 提供流行的 ONTAP 数据管理功能，例如快照、SnapMirror (用于数据复制)、FlexClone (用于数据克隆)和数据压缩/重复数据删除。
> - 提供几十万个 IOPS 以及一致的亚毫秒级延迟，以及高达 3 GB/s 的吞吐量。
> - 提供高度可用且高度持久的多可用区 SSD 存储，支持跨区域复制并内置完全托管式备份功能。
> - 自动将不频繁访问的数据分层到容量池存储，容量池存储是一个完全弹性的存储层，可以扩展到 PB 级，并为不频繁访问数据优化了成本。
> - 与 Microsoft Active Directory (AD)集成以支持基于 Windows 的环境和企业。



> **Amazon FSx for OpenZFS**
>
> Amazon FSx for OpenZFS 提供基于 OpenZFS 文件系统和 AWS Graviton 处理器构建的简单、经济高效、高性能文件存储，可通过行业标准 NFS 协议访问此存储。
>
> - 可从各种 Linux、Windows 和 macOS 计算实例和容器(在 AWS 上或本地部署运行)通过行业标准的 NFS 协议(v3、v4.0、v4.1 和 v4.2)访问。
> - 提供强大的 OpenZFS 数据管理功能，包括 Z-Standard 压缩、即时时间点快照和数据克隆。
> - 提供高达 100 万 IOPS 和仅仅数百微秒的延迟，同时吞吐量高达 12.5 GB/s。
> - 提供高度可用且高度持久的单可用区 SSD 存储，以及内置的完全托管备份。
> - 通过每个文件系统的多个卷、精简资源预置和用户/组配额，跨多个用户和应用程序实现成本高效的共享文件系统。

## 177 AWS Transfer Family

A  fully-managed service for file transfers into and out of Amazon S3 or EFS using FTP protocol.

Support Protocols: FTP, FTPS(FTP over SSL), SFTP(Secure FTP)

Users<=>Route 53(optional)<=>AWS Transfer For FTP<=>S3/EFS

## 180 SQS-Standard Queues Overview

Oldest offering(over 10 years old), Fully managed service, used t decouple applications



Produced to SQS using the SDK (SendMessage API)

The message is persisted in SQS until a consumer deletes it

Message retention: default 4 days, up to 14 days



SQS with Auto Scaling Group(ASG) => common in exam

Security=>In -flight encryption using HTTPS API => 它是个服务器？

## 182 SQS Queue Access Policy 20220711

Cross Accout Access

Publish S3 Event Notifications TO SQS Queue

```
{
    "Version": "2012-10-17",
    "Id": "example-ID",
    "Statement": [
        {
            "Sid": "example-statement-ID",
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": [
                "SQS:SendMessage"
            ],
            "Resource": "arn:aws:sqs:ap-northeast-1:280043394707:EventFromS3",
            "Condition": {
                "ArnLike": {
                    "aws:SourceArn": "arn:aws:s3:::zhouxingbobucket"
                },
                "StringEquals": {
                    "aws:SourceAccount": "2800-4339-4707"
                }
            }
        }
    ]
}
# failure... Please check again
```

## 183 SQS - Message Visibility Timeout

After a message is polled by consumer, it becomes invisible to other consumers

By default, the message visibility timeout is 30 seconds

That means the message has 30 seconds to be processed

After the message visibility timeout is over, the message is visible in SQS (Not return, 即如果没被删掉的话)

If a mesage is not processed within the visibility timeout, it will be processed twice

A consumer could call the ChangeMessageVisibility API to get more time(demo 没有展示，大概是关于编程层面了)

## 184 SQS - Dead Letter Queue

If a cosumer fails to process a message within the Visibility Timeout...the message goes back to the queue!

We can set a threshold of how many times a message can go back to the queue

After the MaximumRecieves threshold is exceeded, the message goes into a dead letter queue(DLQ)

Make sure to process the message in the DLQ before they expire(Useful for debugging)

相当于一个自动定期清理的垃圾箱

这个DLQ基于普通的Queue，设定一个retention of period, 然后就可以作为其他Queue的DLQ.

## 185 SQS - Request-Response Systems

通过Correlation ID来标记

## 186 SQS - Delay Queues

Delay a message(consumers don't see it immediately) up to 15 minutes

Default is 0 seconds.

## 187 SQS - FIFO Queues

FIFO = First in first out(odering of messaes in the queue)

Exactly-once send capability(by removing duplicates)

Messages are processed in order by consumer

## 188 SQS + Auto Scaling Group

SQS Queue => Auto Scaling Group => CloudWatch Custom Metric: Queue Lenth/Number of Instances => CloudWatch Alarm => Auto Scaling Group 

## 189 Amazon SNS - Overview

The event producer only sends message to one SNS topic

As many event reciever(subcriptions) as we want to listen to the SNS topic nififications

Each subscriber to the topic will get all the messages

Subscribers can be: SQS, HTTP, Lambda, Emails, SMS messages, Mobile Notifications

## 190 SNS and SQS - Fan Out Pattern 20220713

Push onece in SNS, receive in all SQS queues that are subscribers

SNS - FIFO Topic

SNS - Message Filtering

所以原则是SNS发所有消息去所有SQS，但相应SQS可以配套filtering，从而各个SQS得到不同的消息。

## 192 Kinesis Overview

Make it easy to collect, process, and analyze streaming data in real-time

1. Kinesis Data Streams: capture, process, and store data streams
2. Kinesis Data Firehose: load data streams into AWS data stores=> S3,Amazon Redshift(copy through S3), Amazon ElasticSearch or Custom HTTP Destinations
3. Kinesis Data Analytics: analyze data streams with SQL or Apache Flink
4. Kinesis Video Streams: capture, process, and store video streams

用Kinesis Data Streams收集data，再利用Kinesis Data Firehose转运到S3去，注意Kinesis Data Firehose会有一个缓存，缓存未满一定时间后才发送到S3. 

## 194 Kinesis vs SQS ordering

Kinesis 可以有许多shards 来hash各种数据的种类，而SQS只有一个接收端口，必须要指定Group ID 来给consumer分组...(视频里虽说有很大不同，但据我理解感觉一样...)

## 195 Kinesis vs SNS vs SQS

SNS: Data is not persisted(lost if not delivered)

## 196 Amazon MQ

SQS,SNS are cloud-native services, and they're using prorietary protocols from AWS

Traditional applications running from on-premise may use open protocos such as:MQTT, STOMP...

When migrating to the cloud, instead of re-engineering the application to use SQS and SNS, we can use Amazon MQ.

## 197 Docker Introduction

Docker is a software development platform to deploy apps

Apps are packaged in containers that can be run on any OS

Apps run the same, regardless of where ther're run



EC2实际上就是虚拟机

Docker vs Virtual Machines:

Docker is sort of a virtualization technology, but not exactly

Resources are shared with the host => many containers on one server

## 198 ECS Overview 20220714

ECS = Elastic Container Service

Launch Docker containers on AWS

Has integrations with ALB



Fargate: You do not provision the infrastructure(no EC2 instances to manage) -simpler!   That's why it's called serverless offering.(所谓的serverless是指无服务器的服务？)

AWS just runs containers for you based on the CPU/RAM you need.(再分配一个ENI，确保足够的IP分配)

所以Fatgeta是ECS的一种启动类型？: Fargete Launch Type for ECS; EC2 Launch Type for ECS



ECS Task Role: Allow each task to have a specific role. Use different roles for the different ECS Servie you run.  简而言之，由ECS启动的container访问特定服务如S3所使用的IAM Roles.

EC2 Instance Profile: EC2 Launch Type for ECS时，作为 EC2 instance上的ECS Agent.



共享资源用EFS去mount.

## 199 ECS Service & Tasks, Load Balancing

理解以下层次：

Container definition -> Task definition -> Service -> Cluster

然后介绍了ALB对于两种方式的ECS的不同点，EC2 Launch Type就是如何找right port，Fargete Launch Type的话，Each task has a unique IP, 如何找IP了.

最后讲了一个 ECS tasks invoked by Event Bridge的例子.

## 201 ECS Scaling

也是配合 CloudWatch Metric(ECS seivice CPU Usage)监视CPU Usage来trigger CloudWatch Alarm, 然后去scale

对于EC2 Launch Type for ECS，当没有足够EC2来启动Contaner时候也会在更高层次上（Scale ECS Capacity Providers）去scale EC2 instances，所以这里有两个层次的扩展: Auto scaling, Auto scaling Group



除了监视CPU Usage，另一种方式 SQS+ASG.(之前也反复提到)也可以来用到这里.

## 202 ECS Rolling Updates

When updating from v1 to v2, we can control how many tasks can be started and stopped , and in which order.

比如四个tasks：4->2->2+2->2->2+2, 这样的顺序可以把所有task都更新一遍的同时，保证始终有一个最小Minmun的task在运行.

## 203 ECR Overview

Elastic Container Registry

Store, manage and deploy containers in AWS

Fully integrated with ECS&IAM for security, backed by Amzon S3

## 204 EKS Overview

Amazon Elastic Kubernetes Service

It is a way to launch managed Kubernetes clusters on AWS

Kubernetes is an open-source system for automatic deployment, scaling and management of containerized(usually Docker) application

It's an altenative to ECS, similar goal but different API

Use case: if your company is already using Kubernetes on-premises or in another cloud, and wants to migrate to AWS using Kubernetes.

## 206 Serverless Introduction

Serveless is a new paradigm in which the developers don't have to manage servers anymore... They just deploy functions!

Initially...Serverless was pioneered by AWS Lambda but now also includes anything that's managed: "databases, messaging, storage, etc."

**Serverless does not mean there are no servers... it means you just don't manage/provision/see them.**

## 207 Lambda Overview

| Amazon EC2                                | Amazon Lambda                          |
| ----------------------------------------- | -------------------------------------- |
| Virtual Servers in the Cloud              | Virtual functions-no servers to manage |
| Limited by RAM and CPU                    | Limited by time-short executions       |
| Continously running                       | Run on-demand                          |
| Scaling means intervention to add servers | Scaling is automated!                  |

感觉Lambda像一个多语言支持的编译平台。

## 209 Lambda Limits 20220716

Execution:

1. Memeory allocation: 128MB-10GB
2. Maximum execution time: 15min
3. Environment Variables: 4KB
4. Disk capacity in the function container(in /tmp): 512MB
5. Concurrency executions: 1000
6. Lambda function deployment size(compressed .zip): 50MB, 250MB(uncompressed)

## 210 Lambda@Edge

You have deployed a CDN using CloudFront

What if you wanted to run a global AWS Lambda alongside?

Or how to implement request filtering before reaching your application?

=>For this, you can use Lambada@Edge

You can use Lambda to change CloudFront requests and responses

You can also generate responses to viewers without ever sending the request to the origin.

(Runs code in each CloudFront Edge, globally)

## 211 DynamoDB Overview

NoSQL database - not a relational database

Scales to massive workloads, distributed database

Intergrated with IAM for security, authorization and administration



Read/Write Capacity Modes:

1. Provisioned Mode(default)
2. On-Demand Mode => more expensive, great for unpredictable workloads.

## 213 DynamoDB Advanced Fratures

**DynamoDB Accelerator(DAX)**: Help solve read congestion by caching.

DAX vs ElatiCache: 前者适应于DynamoDB的Query & Scan cache, 而后者比如Application的计算结果的缓存？？..

**DynamoDB Streams**: Ordered stream of item-level modifications(crate/update/delete) in a table.

就是修改日志数据流可以发送到Kinesis或者Lambda等去分析。

**DynamoDB Global Tables**: Application an read/write to the table in any region

并不是一张table，而是各个区域的table通过DynamoDB Streams来同步

**TTL**: Automatically delete items after an expiry timestamp

## 214 API Gateway Overview

```python
import json

def lambda_handler(event, context):
    print(event)
    body = "Hello from Lambda!"
    statusCode = 200
    return{
        "statusCode": statusCode,
        "body": json.dumps(body),
        "headers":{
            "Content-Type": "application/json"
        }
    }
```

AWS Lambda + API Gateway: NO infrastructure to manage

Support for the WebSocket Protocol



API Gateway can invoke Lambda function, easy way to expose REST API backed by AWS Lambda

所以你用一个定位到该API的URL就可以触发相应Lambda，为什么不把Lambda直接暴露给client呢，有IAM上的考虑，API Gateway 也有其它功能：rate limit, caching, authenticatins...

## 216 API Gateway Security

IAM Permissions

Custome Authorizers

Cognito User Pools

## 217 AWS Cognito Overview 20220720

We want to give our users an identify so that they can interact with our application.

**Cognito User Pools**: Integrate with API Gateway. 

Create a serveless database of user for your mobile apps

Can enable Federated Identities(Facebook, Google...) 用脸书账号登录,作为Identity Provider

Send back a Json Wen Tokens

本质上，Cognito User Pools(CUP)是和Google，Facebook一样的Identity Provider.

**Cognito Identity Pools(Federated Identity)**: Integrate with Cognito User Pools as an identity provider

Example: provide(temporary access to write to S3 bucket using Facebook Login)



以上两者的区别还是不清不楚..是后者可以第三方进行验证，直接访问AWS资源？？前者跟Google，Facebook一个性质，后者把他们对接了？前者可以用Google来代替，与后者配合...

关键是Coginito可以提供一个临时凭证给远端手机用户去访问S3...

> Amazon Cognito 提供用户池和身份池。用户池是为您的应用程序提供注册和登录选项的用户目录。身份池提供 AWS 凭证以向用户授予对其他 AWS 服务的访问权限。

CUP可以提供Token去登陆Facebook，而CIP是来验证Facebook的Token来访问S3一类的东西。



## 218 AWS SAM

SAM = Serverless Application Model

Framework for developing and deploying serverless applications

一个管理Lambda, DynamoDB, API Gateway, CUP这些serverless的框架

## 219 Mobile Application-MyTodoList

Moble client <-> API Gateway ->Lambda <- DAX Caching layer-> DynamoDB

Mobile client <->Cognito <->API Gateway

首先这是一个serverless框架，所以不用考虑EC2这类的，至于read/write性能优化，主要有DynamoDB中DAX Caching layer缓存实现，另外API Gateway中也 Caching the REST requests. Cognito 跟API Gateway搭配起来.

## 220 Serverless Website-MyBlog.com

Client->CloudFront Global distribution->S3->Lambda/SQS/SNS: trigger thumnail->S3

Moble client <-> API Gateway ->Lambda <- DAX Caching layer-> DynamoDB Global Table->DynamoDB Stream->Lambda->Amazon Simple Email Service(SES)

要做到全球分发，就要想到CloudFront，边缘缓存，S3可以调用Lambda去做缩略图存储. 另外，注册新用户发邮件的架构可利用Lambda去处理DynamoDB Stream.

（P2 明显难起来是因为我缺乏Web服务器搭建经验）

## 221 Micro Services architecture

We want to switch to a micro service architecture

Many services interact with each other directly using a REST API

## 222 Distributing Paid Content

a fully serverless solution:

CloudFront can only be used using Signed URLs to prevent unauthorized users.

## 223 Software updating distribution

放在EC2上的软件更新补丁，短时间大量用户来更新补丁requests，Auto scaling产生大量费用，此时往架构添加CloudFront，放个静态缓存：Easy way to make an existing application more scalable and cheaper

## 224 Big Data Ingestion Pileline

S3也是severless...

## 225 Choosing the right database 20220721

### RDS

### Aurora

### ElastiCache

### DynamoDB

NoSQL, Serverless

### S3

Great for big objects.

Serverless

### Athena

Fully Serverless database with SQL capabilities.

可以将其视为S3之上的SQL层。

### Redshift

Reshift is based on PostgreSQL, but it's not used for OLTP

It's OLAP- online analytical processing

Data is loaded from S3, DynamoDB, other DBs...

可以通过Kinesis Data Firehose从S3 Loding data，也可以直接用copy command.

### Glue

Managed extract, transform, and load (ETL) service

Useful to prepare and transform data for analytics

Fully serverless service

S3/RDS -> Glue ETL -> Redshift

### Neptune

Fully managed **graph** database

比如说Wikipedia，一个页面有各种其它链接，形成一个Graphs

### ElasticSearch

Example: In DynamoDB, you can only find by primary key or indexes.

With ElasticSearch, you can search any field, even partially matches.

正则表达式？

It's common to use ElasticSearch as a complement to another database.

## 238 AWS CloudWatch Metrics

CloudWatch provides merics for every service in AWS

Metric is a variable to monitor( CPU utilization,erc...)

## 239 CloudWatch Custom Metrics

Possibility to define and send your own custom metrics to CloudWatch

Example: memory(RAM) usage...

Use API call Put MetricData

## 240 AWS CloudWatch Dashboards

自定义Dashboards布局

## 241 AWS CloudWatch Logs

Application can send logs to CloudWatch using the SDK

## 242 CloudWatch Agent 20220722

By default, no logs from your EC2 machine will go to CloudWatch.

You need to run a CloudWatch agent on EC2 to push the log files you want.

1. CloudWatch Logs Agent
2. CloudQatch Unified Agent

后者更新，除了log，还可以发送system-level metrics such as RAM,processes...



想想有道理，之前均是像S3这样的serverless的服务可以无agent就发送log至CloudWatch.

## 243 AWS CloudWatch Alarms

Alarms are used to trigger notifications for any metric

Targets:

1. Stop,Terminate,Reboot,or recover an EC2 instance
2. Trigger Auto Scaling Action
3. Send notification to SNS

Alarms can be created based on CloudWatch Logs Metrics Filters

## 245 EC2 Instance Recovery with CloudWatch

Recover: Same Private,Public,Elastic IP, metadata, placement group

就是配置文件会恢复，EC2上面存储的数据会丢失，除非配个EBS

## 246 AWS CloudWatch Events

Intercept events from AWS services

比如，检测到EC2 Pending, 然后就创建一个事件：发送邮件。类似于Alarms，但Event本质上是可以触发调用许多API（包括SNS，SQS，Lambda），而Alarms可触发的选择范围较小。



> **CloudWatch Events 现在名为 EventBridge**
>
> Amazon EventBridge 在 CloudWatch Events 上构建并对其进行扩展。它使用相同的服务 API 和终端节点，以及相同的底层服务基础设施。对于现有 CloudWatch Events 客户，什么都没改变 - 您可以继续使用相同的 API 以及 CloudFormation 模板。所有现有的 CloudWatch Events API 和开发工具包继续以与 EventBridge 相同的方式工作。现有的默认事件总线、规则和事件还可以在 Amazon EventBridge 控制台中访问。

## 247 Amazon EventBridge

EventBridge is the next evolution of CloudWatch Events

Default event bus是来自CloudWatch的events, 但是现在增加了第三方Saas平台(如Salesforce)而来的events，还有自定义应用的events，为这些events创建rules（similar to CloudWatch Events）

EventBridge can analyze the events in your bus and infer the schema=>Schema Registry

这个性质不是很理解，提前推断出总线中的数据结构，有什么用？

> schema 用于定义在 Amazon EventBridge 中通过事件总线传递的事件的结构和内容。您可以浏览或搜索 EventBridge 上所有 AWS 服务的 schema。您可以自动为事件总线上的事件生成 schema，创建或上传自定义 schema，并在自定义注册表中组织自定义 schema。

## 249 CloudTrail Overview

> 持续记录您的 AWS 账户活动
>
> 使用 CloudTrail 满足您 AWS 账户的治理、合规性和审计需求。

CloudTrail is enabled by default

Get an history of events /API calls made within your AWS Accout by Console,CLI...

Can put logs from CloudTrail into CloudWatch Logs or S3

 

CloudTrail Insights:to detect unusual activity in your accout.

Retention:Events are stored for 90 days in CloudTrail, to keep events beyong this period, log them to S3 and use Athena

## 251 AWS Config Overview 20220723

> AWS Config 提供了与您的 AWS 账户关联的资源的详细视图，包括它们的配置方式、彼此关联的方式以及配置及其关系是如何随着时间变化的。

Helps woth auditing and recording compliance of your AWS resources

Questions that can be solved by AWS Config: Is there unrestricted SSH access to my security groups?...

AWS Config Rule does not prevent actions from happening(no deny)

你虽然不能阻止不合规变化发生，但你可以在Config中进行Remediations 补救。

## 253 CloudTrail vs CloudWatch vs Config

For example, for an ELB

CloudTrail: Track who made any changes to the ELB with API calls

Cloudwatch: Monitor metric and make a dashboard to get an idea of performance

Config:Track security group rules and configuration changes for ELB

三者互补

## 254 AWS STS Overview

AWS STS: Security Token Service

Allows to grant limited and temporary access to AWS resources.

AssumeRole, Cross Accout Access

## 255 Identity Federation & Cognito 20220724

Federation lets users outside of AWS to assume temporary role for accessing AWS resources.

比如你用你的facebook账号来登录amazon

STS相当于amazon内部提供credential的第三方，但推荐用Cognito？<=错...

> ADFS的全称是Active Directory Federation Services.
>
> 在ADFS中, 身份的联合(identity federation )是通过在两个组织的安全边界间建立信任关系来实现的. 在一端(account side)的federation server 负责通过在Active Directory domain services中的标准方式认证一个用户, 然后生成一个包含一系列包含有关这个用户的claims的token, 包括federation server的实体本身. 另一端(resource side), 另一个federation server会校验这个token, 然后生成另一个token供本地服务器接受claimd identify所用. 这允许系统为它的资源提对另外一个安全边界的某用户供可控制的访问权限, 而不需要让这个用户直接登录系统, 也不需要两个系统共享用户的identify和密码.
>
> ADFS与Active Directory Domain Services进行了集成, 使用Domain Services作为identify provicer. ADFS可以与其他的符合WS-* 和 SAML 2.0的federation services兼容.

Cognito由CUP和Federated Identity组成的一个服务，APP从Google取个Token过来问Federated Identity来验证，OK的话，Federated Identity再产生一个临时的Token交给APP去访问S3，那这个临时的Token就要去找STS(Security Token Service) 要了。

## 256 Directory Services Overview

What is Microsoft Active Directory(AD)?

> 活动目录，Active Directory，简称为”AD“
>
> 活动目录是负责管理一定区域「1」内Windows网络中各类资源的Windows Server组件之一。
>
> 「1」:可以是一台计算机，一个小型局域网（LAN）或多个广域网(WAN）的结合。
>
> 在由windows系统组成的网络中，存在着各种资源，如服务器、客户机、用户账户、打印机、各种文件等，这些资源都分布于各台计算机上。没有使用“活动目录”之前，需要在每台计算机上单独管理这些资源 。
>
> 使用“AD”的主要作用是：
>
> 为了集中管理windows网络的各类资源，“活动目录”就像是一个数据库，存储着windows网络中的所有资源。
> Active Directory域内的directory database（目录数据库）用来存储用户账户、计算机账户、打印机与共享文件夹等对象，而提供目录服务的组件是Active Directory Domain Services，AD DS（活动目录域服务），它负责目录数据库的存储、新建、删除、修改与查询等工作[1]。
> 普通用户通过“活动目录”可以很容易找到并使用网络中的各种资源。
> 管理员也可以通过活动目录，对网络上的所有资源进行集中管理，以控制不同用户在不同计算机上对不同资源的访问。
> ————————————————
> 版权声明：本文为CSDN博主「NOWSHUT」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/NOWSHUT/article/details/107851255

Centralized security management, create accout, assign permission.

类似 Network Information Services (NIS server) 这个服务器吧？=>还是很不一样

> Directory Service：帮助您存储信息和管理对资源的访问。
>
> 基于您的需求选择目录类型。依赖 Microsoft Active Directory (AD)域服务的客户提供了三个选项来帮助您将依赖于 Active Directory 的应用程序迁移到 AWS Cloud。利用这些解决方案，用户还可以使用其 Active Directory 凭证登录 AWS 应用程序，例如 Amazon WorkSpaces 和 Amazon QuickSight。不需要 Active Directory 的开发人员可使用 Amazon Cloud Directory 创建云规模目录，从而组织和管理分层信息，例如组织图表、课程目录和设备注册表。Amazon Cognito 用户池向移动和 Web 应用程序开发人员提供了 Internet 规模的用户目录与集成的注册和登录功能。
>
> 适用于 Microsoft Active Directory 的 Directory Service 解决方案：
>
> AWS Managed Microsoft AD:
>
> Create your own AD in AWS, manage users locally, support MFA
>
> AWS Directory Service for Microsoft Active Directory (标准版或企业版)是 AWS 云中的实际 Microsoft Active Directory。您可以使用它来支持 Active Directory 可识别的工作负载；适用于 Microsoft SQL Server 的 Amazon Relational Database Service；AWS Managed Services，例如 Amazon WorkSpaces 和 Amazon QuickSight；或需要 LDAP 目录的 Linux 应用程序。您的最终用户可从 Windows 集成的单一登录体验中受益，无论您是在 AWS 云中将它用作单独目录，还是使用 Active Directory 信任将现有 Active Directory 基础架构扩展到 AWS Cloud 中。
>
> AD Connector:
>
> Directory Gateway(Proxy) to redirect to on-premise AD
>
> AD Connector 是一种代理，它允许您将现有的自托管 Microsoft Active Directory (AD)中的身份用于兼容的 AWS 应用程序。您还可以使用 AD Connector 将 Amazon EC2 实例连接到您的 AD 域，并使用现有的组策略对象管理这些实例。这样一来，您可以更轻松地在这些 Amazon EC2 实例上部署 AD 感知应用程序，并使用您的自托管 AD 进行用户和组授权。
>
> Simple AD:
>
> AD-compatible managed directory on AWS
>
> Simple AD 是一种兼容基础 Active Directory 的小规模的低成本目录。您可以在 AWS Cloud 中将它用作独立目录以支持 AWS 应用程序和服务、Samba 4 兼容的应用程序以及需要 LDAP 目录的 Linux 应用程序。

总而言之就是Amazon提供的兼容Microsoft AD的方案。

## 257 Organizations Overview

Global service 

Allows to manage multiple AWS accouts

The main account is the master accout

Consolidated Billing across all accouts- single payment method

Organizational Units = OU: OU是高于Account的level

Service Control Policies(SCP): Whitelist or blacklist IAM actions

## 259 IAM Adavanced

IAM Conditions : 比如基于IP，区域等对访问进行限制，强制使用MFA

IAM for S3

IAM Roles vs Resource Based Policies

比如账户A要访问账户B中的S3，B可以为A创建一个Role，或者为S3做一个访问策略。

## 260 IAM Policy Evaluation Logic

IAM Permission Boundaries : Advanced feature to use a managed policy to set the maximum permissions an IAM entity can get.

## 261 Resource Access Manager(RAM)

Share AWS resources that you own with other AWS accounts

比如, 账户1创建一个VPC，Private subnet，它可以将这个subnet分享给账户2，但是这两个账号各自管理在这个subnet上的资源，所分享的仅仅是网络层配置。

## 262 AWS Sinle Sign On(SSO) Overview 20220725

Centrally manage Single Sign-On to access multiple accounts and 3rd-party business applications.

Intergrated with AWS Organizations

> 提到SAML (Security Assertion Markup Language), 很多人都会联想到单点登录SSO。那么Saml到底是什么，它跟sso到底有什么联系？
>
> 安全声明标记语言（SAML）是一种开放标准，允许身份提供商（IDP）将授权凭证传递给服务提供商（SP）。 这个术语的含义是您可以使用一组凭据登录许多不同的网站。 管理每个用户仅需一次登录比管理电子邮件、客户关系管理（CRM）软件、Active Directory等公司业务系统都需要单独登录要简单得多。
>
> SAML使用可扩展标记语言（XML）进行身份提供商和服务提供商之间的标准化通信。 SAML是用户身份验证和使用服务授权之间的链接。

## 265 Encryption

1. Encryption in flight(SSL) => HTTPS
2. Server side encryption at rest: 服务器收到数据加密存储，发送前解密，防止服务器被劫持。
3. Client side  encryption: 客户端加密，服务器不解密，只是存储

## 266 KMS Overview

AWS KMS: Key Management Service

Anytime you hear "encryption" for an AWS service, it's most likely KMS.

Fully integrated with IAM for authorization



KMS-Customer Master Key(CMK) Types:

1. Symmetric(AES-256 keys) : 对称key，AWS大多时候采用的，可以调用KMS API
2. Asymmetric(RSA & ECC key paris) : 非对称key，有公钥私钥，不能访问KMS API



Coping Snapshots across regions: key跟region对应，跨区要重新加密



AWS managed keys or Custom managed keys : 即便是后者也是调用KMS API来创建的。

## 268 KMS Key Rotation

Only for Customer-managed CMK, if enable: automatic key rotation happens every 1 year.

## 269 SSM Parameter Store Overview

> 集中存储和管理您的密钥和配置数据，例如密码、数据库字符串和许可证代码。您可以将值加密，或存储为纯文本，还能实现每个级别的安全访问。

Serverless

可以连接AWS KMS来加密Parameter

不仅可以用CLI来取用Parameter，还可以通过Lambda来取，记得为Lambda的IAM Role添加允许访问SSM，KMS的IAM Policy.

## 272 AWS Secrets Manager

Newer service, meant for storing secrets

Capability to force rotation of scerets every X days

Secrets are encypted using KMS

> 使用 Secrets Manager 来存储、转动、监控和控制对数据库凭证、API 密钥和 OAuth 令牌等密钥的访问。使用内置集成对 Amazon RDS 上的 MySQL、PostgreSQL 和 Amazon Aurora 启用密钥转动。您还可以使用 AWS Lambda 函数启用其他密钥的转动。要检索密钥，您只需通过调用 Secrets Manager API 来更换应用程序中的硬编码密钥，无需暴露明文密钥。

## 274 CloudHSM

Dedicated Hardware(HSM = Hardware Security hardware)

You manage your own encryption keys entirely

Supports both symmetric ans asymmetric encryption(SSL/TLS keys)

有相应的客户端软件

可以比较一下CloudHSM和KMS的区别

## 275 Shield - DDos Protection

DDos

> 1、中文名称：分布式拒绝服务，英文全称：distributed denial-of-service 。
>
> 2、具体含义
>
> 通过大规模互联网流量淹没目标服务器或其周边基础设施，以破坏目标服务器、服务或网络正常流量的恶意行为。
>
> 更加形象的比喻：
>
> 如果把互联网上的网站或服务器看作一个个商店（比如淘宝、京东、微信等等），每个访问网站的网民看作是商店里的顾客。DDoS 就相当于一堆小混混装成正常顾客涌入商店，逛来逛去赖着不走让正常的顾客进不来，或者跟售卖员有一搭没一搭地说话，占用他们的时间，让他们无法正常服务客户。

1. AWS Shield Standard:

Provides protection from layer 3/4 attacks

应用层攻击的话，就不保护了？主要是免费自带

2. AWS Shield Advanced：

3000 doller每个月...

## 276 Web Application Firewall(WAF)

Protects your web application from common web exploits(Layer 7)

Deploy only on **ALB, API Gateway, CloudFront** => Shield 基本部署于每台服务器

Protects from common attack-SQL injection and Cross-Site Scripting(XSS)

> 百度百科的解释: XSS又叫CSS  (Cross Site Script) ，跨站脚本攻击。它指的是恶意攻击者往Web页面里插入恶意html代码，当用户浏览该页之时，嵌入其中Web里面的html代码会被执行，从而达到恶意用户的特殊目的。
>
>
> 它与SQL注入攻击类似，SQL注入攻击中以SQL语句作为用户输入，从而达到查询/修改/删除数据的目的，而在xss攻击中，通过插入恶意脚本，实现对用户游览器的控制，获取用户的一些信息。

Difine Web ACL：IP, HTTP headers, or URL...

 还可以设定特定国家区域的请求通不通过

Rate-based rules - for DDos protection

不是免费的



AWS Firewall Manager: Manage rules in all accounts of an AWS Organization

Common set of security rules:

1. WAF rules
2. AWS Shield Advanced
3. Security Groups for EC2 and ENI resources in VPC

## 278 Amazon GuardDuty

Inteligent Threat discover to protect AWS Accout

Uses Machine Learning algorithms to analyze logs

Can protect against CryptoCurrency attacks



CloudTrail Logs, DNS logs => GuardDuty => CloudWatch Event => SNS, Lambda

## 279 Amazon Inspector

Only for EC2 instances

Analyze the running OS against known vulnerabilities

AWS Inspector Agent must be installed on OS in EC2 instances

之后才能跟Inspector Service交互

## 280 Amazon Macie

用机器学习来分析搜索在S3中的敏感数据，such as personally identifiable information(PII)

S3 => Macie => CloudWatch Events EventBridge => SNS, Lambda

## 285 VPC Overview 20220726

All new AWS accounts have a default VPC

VPC = Virtual Private Cloud

Because VPC is private, only the Private IPv4 ranges are allowed:

10.0.0.0-10.255.255.255

172.16.0.0-172.31.255.255

192.168.0.0-192.168.255.255

## 287 Subnet Overview

AWS reserves 5 IP address(first 4 & last 1) in each subnet.

These 5 IP address are not available for use and can't be assigned to an EC2 instance.

Example: if CIDR block 10.0.0.0/24, then reserved IP addresses are:

10.0.0.0- Network Address

10.0.0.1- reserved by AWS for the VPC router

10.0.0.2- reserved by AWS for mapping to Amazon-provided DNS

10.0.0.3- reserved by AWS for future use

10.0.0.255- Network Broadcast Address, AWS does not support broadcast in a VPC,

therefore the address is reserved.

## 289 Internet Gateway & Route Tables

Internet Gateway(IGW): Allows resources in a VPC connect to the Internet

Must be created separetely from a VPC

Route table must also be edited!

创建一个VPC，划分出数个子网，创建路由表指向本地部分子网，最后创建网关，编辑路由表指向此互联网网关，最终该子网上的EC2就可以使用Public IP了。

## 291 Bastion Hosts

We can use a Bastion Host(EC2 instance) to SSH into our private EC2 instances

The bastion is in the public subnet which is then connected to all other private subnets.

基本就是在EC2 界面操作，创建私网EC2时创建安全组，将安全组source设置为公网EC2的安全组名称，然后就可以通过公网内的EC2登录私网EC2了，此时这个公网EC2就被称为Bastion Host.

Windows可以用Powershell来登录EC2，就是公网EC2公钥这块出现了下面的问题导致没法成功登录私网...按下不表，也不知道passphrase是什么...

```
Enter passphrase for key 'Key.pem':
```

上记问题，重新制作密钥，解决...

## 293 NAT Instances

NAT = Network Address Translation (outdated, but still at the exam)

NAT Allow EC2 instances in private subnets to connect to the Internet

NAT Must be lauched in a public subnet

NAT实际上也是一个EC2(can be used as Bastion Host)，因为需要改写IP头，所以Source/destination Check Must be disabled.

## 295 NAT Gateways 20220727

AWS-managed NAT, higher bandwidth, high availability, no administration

Requirea an IGW (Private Subnet => NATGW => IGW)

Can't be used by EC2 instance in the same subnet(only from other subnets)?

操作很简单，直接创建，然后编辑私网中EC2的路由器指向这个NAT Gatways就行，大概IGW需要提前创建，然后会自动连接？

## 297 DNS Resolution Options & Route 53 Praivate zones

DNS Resolution 可以利用Amazon提供的 Route 53，也可以Custome DNS Server.

If you use costom DNS domain names in a Private Hosted Zone in Route 53, you must set both these attributes(enableDnsSupport & enableDnsHostname) to true.

比如，你想为你的EC2访问谷歌时使用别名，你就需要启动这两个特性。

enableDnsSupport 默认启动，就是使用Route 53 而不是自定义。

enableDnsHostname默认的VPC是启动的，自建的VPC关闭，它赋予你在公网中的EC2一个DNS domain name.

## 299 NACL & Security Groups

NACL和SG都可以编辑出入规则，组合使用。区别在于前者是Stateless =>(return traffic must be explicitly allowed by rules, think of ephemeral ports)，就是不管你的信息是发送还是回复，一律检查；而后者是Stateful => (return traffic is automatically allowed, regardless of any rules)，回复的消息就直接通过。

NACL = Network Access Control List

NACL are like a firewall which control traffic on a subnet level. (SG operates at the instance level)

客户端回信时，会选择一个临时端口，Ephemeral Ports, 所以NACL设置rule时对于回信是设置一个端口范围的。

```
#安装web服务器
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo su
echo "hello wrold" > /var/www/html/index.html
```

在NACL中，Rule number很重要，它会据此自从排序，越小的数字越靠前执行，优先度越高。默认NACL的number是100，它允许所有流量通过。

## 301 VPC Reachability Analyzer

It builds a model of the network configuration, then checks the reachablity based on these  confugrations( it doesn't send packets)

## 303 VPC Peering

Privately connect two VPCs using AWS's network

Make them behave as if they were in the same network

Must not have overlapping CIDRs

VPC Peering connection is Not transitive(Must be established for each VPC that need to communicate with one another)

=>比如A与B通过一个VPC Peering连接，B与C通过另一个VPC Peering连接，不表示A与C能够通信。

Must update route tables in each VPC's subnets

## 305 VPC Endpoints

比如说Amazon DynamoDB因为是Public Serves, EC2可以通过Internet Gateway去访问。但CloudWatch， S3这些服务应当有不经过公网的更好的访问形式-VPCEndpoints

VPC Endpoints(AWS PrivateLink):

Every AWS service is publicly exposed(public URL)

VPC Endpoints(powered by AWS PrivateLink) allows you to connect to AWS services using a private network instead of using the public internet.

举例说访问SNS，如果使用internet，首先网络状况没有私网好，另外NAT Gateway等配置也要费用

Types of Endpoints:

1. Interface Endpoints: 配置一个ENI，所以要设置SG，support most AWS Service
2. Gateway Endpoints:must be used as a target in a route table, only support S3 and DynamoDB

## 307 VPC Flow Logs 20220728

Capture information about IP trafiic going into your interfaces

Helps to monitor connectivity issues

收发IP端口以及是否被Firewall通过拒绝等信息，是在VPC层面上的，类似于tcpdump?

Query VPC logs using Athena on S3 or CloudWatch Logs Insights.



Athena如何去操作S3呢？Athena在某个S3路径下对其log进行表创建，以及之后的SQL Query操作。

## 309 Site to Site VPN Connections

Virtual Praivate Gateway (VGW): VPN concentrator on the AWS side of the VPN connection

Customer Gateway(CGW): Software application or physical device on customer side of the VPN connection

AWS VON CloudHub: Provide sevure communication between multiple sites, if you have multiple VPN connections.

就是多个CGW跟这个VGW通信的话，这些CGW之间也可以通过这个VPN交流，此时VGW就相当于一个CloudHub了。

> 您一次能将一个VGW连接到 VPC。要将同一 Site-to-Site VPN 连接连接到多个 VPC，我们建议您改为探索使用中转网关。

> 要避免因您的CGW不可用而造成连接中断，您可使用CGW来为您的 VPC 和虚拟私有网关设置第二个站点到站点 VPN 连接。通过使用冗余站点到站点 VPN 连接和CGW，您可以在对其中一个设备进行维护时保证流量可以继续流经第二个CGW站点到站点 VPN 连接。

It's a VPN connection so it goes over the public internet.

主义的是CGW实体虽然在对端，但AWS侧你还是要设置CGW IP等信息的。

## 311 Direct Connect(DX)

Provides a dedicated private connection from a remote network to your VPC

相对于之前VPN通过公网通信，这可以通过私网通信，所以网络状况更好？

You need to setup a Virtual Private Gateway on your VPC

Access public resources S3 and private(EC2) on same connection

总的而言，似乎是Customer Network与VPC之间建立一个AWS Direct Connect location（其中有AWS Direct Connect Endpoint, Customer router等节点），然后通过Private virtual interface 去连接VPG. 而S3等可以用AWS Direct Connect Endpoint用Public virtual interface去连接.

Direct Connect Gateway: If you want to setup a Direct Connect to one or more VPC in many different regions(same account), you must use a Direct Connect Gateway

这个Direct Connect Gateway就在AWS Direct Connect location和多个VPC的VPG之间。

## 312 AWS PrivateLink - VPC Endpoint Service

背景：Exposing services in your VPC to other VPC. 你可以通过Public Internet，不怎么安全，也可以通过VPC peering，但需要将VPC全部expose.

 Service VPC需要设置一个Network Load Balancer, Customer VPC需要设置ENI，然后两者组成了AWS Private Link.

注意305p所讲的VPC endpoint是指内部私网EC2 如何去访问S3, 这里是另一个VPC通过endpoint去访问，当然其构架基础肯定有共通之处。

## 314 AWS ClassicLink

Has been deprecated

## 315 Transit Gateway

背景：如果有很多VPC各自Peering Connection，与Customer Gateway进行VPN Connetion等，网络拓扑图十分复杂，全部接到Transit Gateway就清晰明了了。

For having transitive peering between thousands of VPC and on-premises, hub-and-spoke connection

除此之外，Transit Gateway有以下功能：

Site to site VPN ECMP: Equal-cost multi-path routing

> ECMP(Equal-cost multi-path)
>
> ECMP是一个逐跳的基于流的负载均衡策略，当路由器发现同一目的地址出现多个最优路径时，会更新路由表，为此目的地址添加多条规则，对应于多个下一跳。可同时利用这些路径转发数据，增加带宽。ECMP算法被多种路由协议支持，例如：OSPF、ISIS、EIGRP、BGP等。在数据中心架构VL2中也提到使用ECMP作为负载均衡算法。
>
> **特别是基于数据流的转发，对某一个结点运用ECMP时的前提是，这些数据流的目标地址相同，源地址不同。比如来自源地址A的数据流和来自源地址B的数据流都要经过R到达目标地址D，而R到D有两条路径，那么R可能会把来自A的数据流转发到路径1上，把来自B的数据流转发到路径2上。**
>
> **感觉ECMP是用在MPLS网络上。**

这个功能也要收钱，过分...

Share Direct Connect between multiple accouts

## 316 VPC Traffic Mirroring

Allows you to capture and inspect network traffic in your VPC

简而言之，复制一份到某个EC2的流浪route到一个分析架构上

## 317 IPv6 for VPC

IPv4 cannot be disabled for your VPC and subnets.

所以一个instance可以同时拥有IPv4和IPv6，出现没法lauch基本上都是前者耗尽的问题。

## 319 Egress-only Internet Gateway

similar to a NAT Gateway but for IPv6

中文名：**仅出口互联网网关**

## 323 Networking Costs in AWS 20220731

Use Private IP instead of public IP for good savings and better network performance

Use same AZ for maximum savings

Try to keep as much internet traffic within AWS to minimize costs

## 324 Disaster Recovery in AWS

RPO-Recovery Ponit Objective: 过去的备份时间点，Data loss

RTO-Recovery Time Objective: 将来的恢复时间点，Down time



Backup and Restore

Pilot Light

Warm Standby

Multi Site/Hot Site Approach

All AWS Multi Region

## 325 DMS-Database Migration Service

Quickly and securely migrate databases to AWS, resilient, self healing

You must create an EC2 instance to perform the replication tasks

AWS Schema Conversion Tool(SCT): 两个不同的database enginner之间迁移时所需要

## 327 On-Premise strategy with AWS

Ability to download Amazon Linux 2 AMI as a VM(.iso format) => VMWare

说明EC2是个虚拟机

VM Import/Export: Migrate existing applications into EC2; Can export back the VMs from EC2 to on-premise

## 328 DataSync Overview

Move large amount of data from on-premise to AWS

在本地设置一个AWS DataSync Agent，与AWS DataSync 用TLS连接，进行本地与云数据同步

另一个用例- EFS to EFS: 在一个region的VPC搞一个EC2 instance with DataSync Agent与EFS相连，然后另一个region的VPC中搞一个AWS DataSync Service endpoint与EFS相连。

## 330 AWS Backup Overview

Fully managed service

No need to create custom scripts and manual processes

可以将EC2，EBS，RDS...各种Resources Automatacally backed up to Amazon S3

所以备份目的地除S3无它

## 332 Event Processing in AWS 20220801

SQS=>Lambda, ANA=>Lambda

SNS => Multi SQS    <= Fan Out Pattern: deliver to multiple SQS

S3 Events => SNS, SQS, Lambda Function

## 333 Caching Strategies in AWS

Client=>CloudFront=>API Gateway=>App logic(EC2/Lambda)=> Redis Memcached DAX, Database

上述，CloudFront, API Gateway, Redis Memcached DAX有缓存功能

## 334 Blocking an IP Address in AWS

NACL，Security group(虽然没有deny rule，但allow rule反过来就是deny)，Optional Firewall Software in EC2

如果EC2和Client之间有ALB，那么ALB上也有Security Group，此时EC2的SG就source向ALB SG，就像委托一样。

注意：NLB跟ALB不同，没有SG，它对Client来的流量是透传，既不像ALB收到后，然后以ALB的IP重新包装给EC2的步骤

如果ALB与Cient存在CloudFront，后者可以用Geo Restriction屏蔽一个特定国家IP，另外也可以装WAF功能，指定复杂的IP address filtering的规则屏蔽特定IP，WAF也可以加在ALB，作为补充。

## 335 High Performance Computing(HPC) on AWS

Data Management & Transfer: AWS Direct Connect, Snowball & Snowmobile, AWS DataSync

Computing and Networking: EC2, EC2 Placement Group， EC2 Enhanced Networking=>ENA(Elatic Network Adapter), Elastic Fabric Adapter(EFA)=>only for Linux,

Storage: EBS, S3, EFS, FSx,

Automation and Orchestration: AWS Batch, AWS ParallelCluster

亚马逊鼓励作为一个云上大型计算机给客户提供HPC服务。

## 336 EC2 Instance High Availability

Public EC2 => CloudWatch Evnet => Lambda => Standby EC2 

Auto Scaling Gruop: 1min, 1max, 1desired, >= 2 AZ

前者用Lambda来连接Elastic IP Address，后者用EC2上的启动脚本

ASG + EBS：最初想，那EC2去attach旧的EBS不就完事，但大概因为不同AZ，所以还是要通过EBS Snapshot

## 337 Bastion Host High Availability

反复说要用NLB而不是ALB去连接Bastion Host, 因为ALB是第七层的HTTP，而登录Bastion Host用的是SSH，不搭嘎

## 339 CICD Introduction

Continuous Intergration:  => build server

Developer push the code to a code repository often

The developer gets feedback about the tests and checks that have passed/failed

Continuous Delivery:  => Deployment Server

Ensure that the software can be released reliably whenever needed

Ensure deployment happen often an are quick

Code: AWS Codecommit, like Github

Build,test: AWS CodeBuild

Deploy,Provision: AWS Elastic Beanstalk / AWS CodeDeploy+CloudFormation

