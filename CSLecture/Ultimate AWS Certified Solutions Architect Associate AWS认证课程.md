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

These settings were created to prevent company data leaks

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

Unicast IP: one server holds one IP address

Anycast IP: all servers hold the same IP address and the client is routed to the nearest one

后者是怎么实现的呢？就是不同IP的服务器通过同一台Proxy向全球各地users提供服务，而这台Proxy就是所谓的Accelerator

AWS Global Acceleraot vs CloudFront:

They both use the AWS global network and its edge locations around the world

Both services integrate with AWS Shield for DDos protection.

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

