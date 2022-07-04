# AWS Certified Solutions Architect Associate AWS认证课程

## 001 Course Introduction 20220629

site: https://www.bilibili.com/video/BV1wR4y1F7YM?p=11&vd_source=cfea4a81af3552025602bbed3cecda4f

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

