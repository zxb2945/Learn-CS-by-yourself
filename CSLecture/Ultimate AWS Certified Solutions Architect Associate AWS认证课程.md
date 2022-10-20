# AWS Certified Solutions Architect Associate AWS认证课程

## 001 Course Introduction 20220629

B站课程地址: https://www.bilibili.com/video/BV1wR4y1F7YM?p=11&vd_source=cfea4a81af3552025602bbed3cecda4f

知乎分享：https://zhuanlan.zhihu.com/p/512791644

刷题网站SAAC02：https://www.examtopics.com/exams/amazon/aws-certified-solutions-architect-associate-saa-c02/view/

刷题网站SAAC03：https://www.examtopics.com/exams/amazon/aws-certified-solutions-architect-associate-saa-c03/view/

Udemy试题：https://www.udemy.com/cart/success/821309364/

## 011 IAM Introduction 

IAM = Identity and Access Management, Global service

**Users & Groups** can be assigned JSON documents called policies

=>IAM是有Group的

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

To access AWS, you have three options:

1. AWS Management Console(protected by password + MFA)
2. AWS Command Line Interface(CLI): protected by **access keys** =>Direct access to the public APIs of AWS services
3. AWS Softeware Developer Kit(SDK)-**for code**: protected by access keys

Access Keys are secret, just like a password

=>When you use the AWS Management Console to create a user, you must choose to include at least a console password or access keys. By default, a brand new IAM user created using the AWS CLI or AWS API has no credentials of any kind.

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

=>One IAM Role can be assigned to multiple EC2 instances in the different regions.

=>You can use an IAM role to delegate access to resources that are in different AWS accounts that you own. You share resources in one account with users in a different account. By setting up **cross-account access** in this way, you don't need to create individual IAM users in each account. In addition, users don't have to sign out of one account and sign into another in order to access resources that are in different AWS accounts.

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

> 例题
>
> An application running on an Amazon EC2 instance needs to access an Amazon DynamoDB table. Both the EC2 instance and the DynamoDB table are in the same AWS account. A solutions architect must configure the necessary permissions.
> Which solution will allow least privilege access to the DynamoDB table from the EC2 instance?
>
> - A. Create an IAM role with the appropriate policy to allow access to the DynamoDB table. Create an instance profile to assign this IAM role to the EC2 instance. **Most Voted**
> - B. Create an IAM role with the appropriate policy to allow access to the DynamoDB table. Add the EC2 instance to the trust relationship policy document to allow it to assume the role.
> - C. Create an IAM user with the appropriate policy to allow access to the DynamoDB table. Store the credentials in an Amazon S3 bucket and read them from within the application code directly.
> - D. Create an IAM user with the appropriate policy to allow access to the DynamoDB table. Ensure that the application stores the IAM credentials securely on local storage and uses them to make the DynamoDB calls.
>
> 分析
>
> A is correct Roles are designed to be “assumed” by other principals which do define “who am I?”, such as users, Amazon services, and EC2 instances. An instance profile, on the other hand, defines “who am I?” Just like an IAM user represents a person, an instance profile represents EC2 instances. The only permissions an EC2 instance profile has is the power to assume a role. So the EC2 instance runs under the EC2 instance profile, defining “who” the instance is. It then “assumes” the IAM role, which ultimately gives it any real power. https://medium.com/devops-dudes/the-difference-between-an-aws-role-and-an-instance-profile-ae81abd700d#:~:text=Roles%20are%20designed%20to%20be,instance%20profile%20represents%20EC2%20instances.

## 043 EC2 Instance Launch Types

EC2 On Demand: pay for what you use

想用就用，临时租用的感觉

=>There is a vCPU-based On-Demand Instance limit per region, when subsequent requests failed. Just submit the limit increase form to AWS 就是你有可能不能一次性启动太多EC2 On Demand，需要申请

EC2 Reserved Instance: Up to 75% discount compared to On-Demand, Recomended for database

**长期租用**嘛，当然打折扣 => 一礼拜这样的就不行

> 例题
>
> A company needs guaranteed Amazon EC2 capacity in three specific Availability Zones in a specific AWS Region for an upcoming event that will last 1 week.
> What should the company do to guarantee the EC2 capacity?
>
> - A. Purchase Reserved Instances that specify the Region needed.
> - B. Create an On-Demand Capacity Reservation that specifies the Region needed.
> - C. Purchase Reserved Instances that specify the Region and three Availability Zones needed.
> - D. Create an On-Demand Capacity Reservation that specifies the Region and three Availability Zones needed.

Convertible Reserved instance: can change the EC2 instance type

Scheduled Reserved instance: lauch within time window you reserve

EC2 Spot Instance: Up to 90% discount compared to On-Demand, **Instance that you can lose at any point of time if your max price is less than the current spot price.** suitable for Batch jobs, Data analysis, any distributed workloads...

EC2 Dedicated Hosts: More expensive

EC2 Decicated Instances:像EC2 Dedicated Hosts软件版本，类似于共享硬件，虚拟机？？ May share hardware with other instances  in same account.

> **Dedicated Instance と Dedicated Hosts の違い**
>
> `Dedicated Instance` では、`別アカウントのインスタンスが同じ物理サーバ上で起動しないこと` だけを保証しますが、
> `Dedicated Hosts` では、`別アカウントのインスタンスが同じ物理サーバ上で起動しないこと` だけでなく、 `同じアカウントのインスタンスを配置させることが可能` になります。 (アカウントはIAM別ではなく、Rootアカウントが違えば違うアカウントとなる)

Dedicated Hosts大概可以配合硬件搞专属服务器的意思？不是很理解Dedicated Instance既然来说别的root account也没法进来配置，那不是客观上可以让你独自改动硬件配置嘛...

> 例题
>
> A company is planning to migrate a commercial off-the-shelf application from its on-premises data center to AWS. The software has a software licensing model using sockets and cores with predictable capacity and uptime requirements. The company wants to use its existing licenses, which were purchased earlier this year.
> Which Amazon EC2 pricing option is the MOST cost-effective?
>
> - A. Dedicated Reserved Hosts
> - B. Dedicated On-Demand Hosts
> - C. Dedicated Reserved Instances
> - D. Dedicated On-Demand Instances
>
> 分析
>
> requirement is "software has a software licensing model using sockets and cores" dedicated-hosts = visibility of sockets and physical cores

## 044 Spot Instances & Spot Fleet

You can only cancel spot instance requests that are open, active, or disable.

Cancelling a spot request does not terminate instances.

You must first cancel a spot request, and then terminate the associated spot instances.



Spot Fleets (**最省钱**)= set of Spot instance +(optional)On-Demand Instance

Strategies to allocate Spot Instances:

1. lowestPrice
2. diversified: distributed across all pools
3. capacityOptimized

## 046 Private vs Public vs Elastic IP

When you stop and then start an EC2 instance, it can change its public IP.

If you need to have a fixed public IP for you instance, you need an Elastic IP.

An Elastic IP is a public IPv4 Ip you own as long as you don't delete it.

You can only have 5 Elastic IP in your account.

=>  EIP will actually remain associated with your instance even after stopping it.

Overall, try to avoid using Elastic IP. Instead, use a random public IP and register a DNS name to it.

## 048 EC2 Placement Groups

Strategies for the group:

1. Cluster: Same Rack, Same AZ(Availability Zone)
2. Spread: spreads instances across undelying hardware(max 7 instances per group per AZ) => can span across diffirent AZ
3. Patition:spreads instances across many different partitions(which rely on different sets of racks) within an AZ. Scales to 100s of EC2 instances per group(Hadoop,Cassandra,Kafka). The instances in a partition do not share racks with the instances in the other partitions. => Can span across AZs in the same region

以上策略的优缺点，就是网络性能与Availability 之间的取舍。

## 050 Elastic Network Interfaces(ENI)

Logical component in a VPC that represent a virtual network card

1. Primary private IPv4, one or more secondary IPv4
2. One Public IPv4
3. A MAC address

You can create ENI independently and attach them on the fly(move them)on EC2 instances for failover.（意思是可以随便移动ENI去别的instance来定位网络问题）

> 例题
>
> A company plans to run a monitoring application on an Amazon EC2 instance in a VPC. Connections  are made to the EC2 instance using the instance’s private IPv4 address. A solutions architect needs to  design a solution that will allow traffic to be quickly directed to a standby EC2 instance if the application  fails and becomes unreachable. Which approach will meet these requirements? 
>
> A) Deploy an Application Load Balancer configured with a listener for the private IP address and register the  primary EC2 instance with the load balancer. Upon failure, de-register the instance and register the  standby EC2 instance.  
>
> B) Configure a custom DHCP option set. Configure DHCP to assign the same private IP address to the  standby EC2 instance when the primary EC2 instance fails. 
>
> C) Attach a secondary elastic network interface to the EC2 instance configured with the private IP address.  Move the network interface to the standby EC2 instance if the primary EC2 instance becomes  unreachable.  
>
> D) Associate an Elastic IP address with the network interface of the primary EC2 instance. Disassociate the  Elastic IP from the primary instance upon failure and associate it with a standby EC2 instance.

首先什么是VPC？其次，虚拟网卡独立于具体instance，这可怎么实现哦...一种软件技术吗？

手动创建的ENI不会随instance终止而消失

## 053 EC2 Hibernate

The RAM state is preserved

Under the hood: the RAM state is written to a file in the root EBS volume

这里的EBS相当于磁盘吧，Hibernate类似于VM虚拟机挂起

支持这个功能有instance特性上的限制，如磁盘空间

> To enable hibernation, space is allocated on the root volume to store the instance memory (RAM). Make sure that the root volume is large enough to store the RAM contents and accommodate your expected usage, e.g. OS, applications. To use hibernation, the root volume must be an encrypted EBS volume.

=>It is not possible to enable or disable hibernation for an instance after it has been launched. =>所以如果要对原本不支持的instance搞hibernation，那就只能**Migrate**

> 例题
>
> A company runs an application on an Amazon EC2 instance backed by Amazon Elastic Block Store (Amazon EBS). The instance needs to be available for 12 hours daily. The company wants to save costs by making the instance unavailable outside the window required for the application. However, the contents of the instance's memory must be preserved whenever the instance is unavailable.
> What should a solutions architect do to meet this requirement?
>
> - A. Stop the instance outside the application's availability window. Start up the instance again when required.
> - B. Hibernate the instance outside the application's availability window. Start up the instance again when required. **Most Voted**
> - C. Use Auto Scaling to scale down the instance outside the application's availability window. Scale up the instance when required.
> - D. Terminate the instance outside the application's availability window. Launch the instance by using a preconfigured Amazon Machine Image (AMI) when required.

##   055 EC2-Advanced Concepts(Nitro, vCPU,Capacity Reservation)

**Nitro**: Underlying Platform for **the next generation of EC2 instances**

Understanding vCPU:

​    Muitiple threads can run on one CPU

​    Each thread is represented as a virtual CPU(vCPU)

这个vCPU指核心级线程吗？这样的话所谓的一个vCPU甚至没法运行一个多线程的进程...这样太弱了吧...

**Capacity Reservations**: ensure you have EC2 Capacity when need.

## 056 EBS Overview 20220703

An EBS(Elastic Block Store)Volume is a network drive you can attach to your instances while they run.

Think of them as a "network USB srick"

It's locked to an Availability Zone(AZ) =>**EBS volumes can only be attached to an EC2 instance in the same Availability Zone.**

Controls the EBS behaviour when an EC2 instance terminates

1. By default, the root EBS volume is deleted
2. By default, any other attached EBS volume is not deleted



## 058 EBS Snapshots Overview

Make a backup(snapshot) of your EBS volume **at a point in time** =>备份某一时间点的状态，That mean the EBS volume can be used while the snapshot is in progress.

Can copy snapshots across AZ or Region



Action中Manage Fast Snapshot Restore  干嘛用的？？

## 060 AMI Overview

AMI: Amazon Machine Lmage

AMI are a customization of an EC2 instance

We can create your own AMI



创建一个AMI，肯定是关联到snapshot的，他人参照你这个AMI时候，它的存储EBS就是从你这个AMI关联的snapshot上创造出来的吧。

## 062 EC2 Instance Store

Compared to EBS, **EC2 Instance Store** has better I/O performance, and risk to loss data if hardware fails.

> 例题
>
> A company has a custom application running on an Amazon EC instance that:
> \* Reads a large amount of data from Amazon S3
> \* Performs a multi-stage analysis
> \* Writes the results to Amazon DynamoDB
> The application writes a significant number of large, temporary files during the multi-stage analysis. The process performance depends on the temporary storage performance.
> What would be the fastest storage option for holding the temporary files?
>
> - A. Multiple Amazon S3 buckets with Transfer Acceleration for storage.
> - B. Multiple Amazon Elastic Block Store (Amazon EBS) drives with Provisioned IOPS and EBS optimization.
> - C. Multiple Amazon Elastic File System (Amazon EFS) volumes using the Network File System version 4.1 (NFSv4.1) protocol.
> - D. Multiple **instance store volumes** with software RAID 0.



## 063 EBS Volume Types

gp(SSD): General purpose SSD

iol(SSD): Highest performance SSD

stl/scl(HDD): Low cost HDD  =>Magnetic volumes



Only gp/iol can be used as boot volumes（用于操作系统启动，HDD也可以，大概是AMAZON考虑到顾客体验吧...）



io1/io2 with Multi-Attach: Attach the same EBS Volume to multiple EC2 instances in the same AZ. Application must manage concurrent write operations. (**only io1/io2** can multi-attcach)

## 065 EBS Encryption

这个episode谈论了两种方式，一个未加密的snapshot，先复制为一个加密的snapshot，然后在这个加密的snapshot创造出一个volume，自动继承加密；一个未加密的snapshot，创造出volume时候加密，也成为一个加密的volume...(好无聊...)

=>**Amazon EBS encryption** offers a simple encryption solution for your EBS volumes without the need to build, maintain, and secure your own key management infrastructure.

Encryption and decryption are handled transparently(you have nothing to do)



EBS Encryption leverages keys from KMS(AES-256) =>Amazon EBS does not support asymmetric CMKs, 非对称key，有公钥私钥，不能访问KMS API

**Encryption by default** is a Region-specific setting. If you enable it for a Region, you cannot disable it for individual volumes or snapshots in that Region.If you enabled encryption by default, Amazon EBS encrypts the resulting new volume or snapshot using your default key for EBS encryption. Even if you have not enabled encryption by default, you can enable encryption when you create an individual volume or snapshot.

## 066 EFS Overview

Managed NFS(network file system) that can be mounted on many EC2

EFS works with EC2 instances in multi-AZ (compared to EBS)

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

> 例题
>
> A solutions architect is designing a solution that involves orchestrating a series of Amazon Elastic Container Service (Amazon ECS) task types running on
> Amazon EC2 instances that are part of an ECS cluster. The output and state data for all tasks needs to be stored. The amount of data output by each task is approximately 10 MB, and there could be hundreds of tasks running at a time. The system should be optimized for high-frequency reading and writing. As old outputs are archived and deleted, the storage size is not expected to exceed 1 TB.
> Which storage solution should the solutions architect recommend?
>
> - A. An Amazon DynamoDB table accessible by all ECS cluster instances.
> - B. An Amazon Elastic File System (Amazon EFS) with Provisioned Throughput mode.
> - C. An Amazon Elastic File System (Amazon EFS) file system with Bursting Throughput mode.
> - D. An Amazon Elastic Block Store (Amazon EBS) volume mounted to the ECS cluster instances.
>
> 分析
>
> Keywords: data for all tasks needs to be stored - meaning EFS by each task is approximately 10 MB - meaning storage could get really low once archived optimized for high-frequency reading and writing not expected to exceed 1 TB - this one is begging not to chose Bursting mode “There are two throughput modes to choose from for your file system, Bursting Throughput and Provisioned Throughput. With Bursting Throughput mode, throughput on Amazon EFS scales as the size of your file system in the standard storage class grows. For more information about EFS storage classes, see EFS storage classes. With Provisioned Throughput mode, you can instantly provision the throughput of your file system (in MiB/s) independent of the amount of data stored.” High Throughput regardless of storage which can be provided only by B

Storage Tiers:( Lifecycle management , 30days default)

1. Standard: for frequently accessed files
2. **Infrequent access**: cost to retrieve files, lower price to store =>不止S3有，EFS也有这个功能。

> 例题
>
> A solutions architect is designing the cloud architecture for a new application being deployed to AWS. The application allows users to interactively download and upload files. Files older than 2 years will be accessed less frequently. The solutions architect needs to ensure that the application can scale to any number of files while maintaining high availability and durability.
> Which scalable solutions should the solutions architect recommend? (Choose two.)
>
> - A. Store the files on Amazon S3 with a lifecycle policy that moves objects older than 2 years to S3 Glacier.
> - B. Store the files on Amazon S3 with a lifecycle policy that moves objects older than 2 years to S3 Standard-Infrequent Access (S3 Standard-IA) 
> - C. Store the files on Amazon Elastic File System (Amazon EFS) with a lifecycle policy that moves objects older than 2 years to EFS Infrequent Access (EFS IA).
＝＞is incorrect because the maximum days for the EFS lifecycle policy is only 90 days. The requirement is to move the files that are older than 2 years or 730 days.
> - D. Store the files in Amazon Elastic Block Store (Amazon EBS) volumes. Schedule snapshots of the volumes. Use the snapshots to archive data older than 2 years.
> - E. Store the files in RAID-striped Amazon Elastic Block Store (Amazon EBS) volumes. Schedule snapshots of the volumes. Use the snapshots to archive data older than 2 years.

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
2. Application Load Balancer-2016-ALB, HTTP,HTTPS,WebSocket,**gRPC**
3. Network Load Balancer-2017-NLB, TCP,TLS,UDP ->(layer4)
4. Gateway Load Balancer-2020-GWLB, Operating at layer3(IP)

Overall,it is recommended to use the newer generation load balancers as they provide more features.

所以ELB是一个统称

=>ELB is designed to only run in one region and not across multiple regions.所以搞ASG+ELB时，当只有一个ELB时，所有EC2就只能deploy在同一个region的不同AZ.

## 074 Application Load Balancer(ALB)

Load balancing to multiple HTTP applications across machines

Load balancing to multiple HTTP applications on the same machine

Support redirects(from HTTP to HTTPS for example)=>has a port mapping feature to redirect to a dynamic port in ECS

ALB routing tables to different target groups based on HTTP(layer 7, URL), a great fit for micro sevices & container-based application(example:Docker &Amazon ECS)

The application servers don't see the IP of the client directly, the true IP of the client is inserted in the header X-Forwarded-For

(security group中的source中添加另一个安全组号来控制流量不太懂...security group不是规则的集合吗？难道还能作为主机IP的集合？？它的意思是特定另一个security group出来的流量？)

=>Today, we are announcing **weighted target groups** for application load balancers. It allows developers to control how to distribute traffic to multiple versions of their application.

## 076 Network Load Balancer(NLB)

Network load balances(Layer 4) allow to:

1. Forward TCP&UDP traffic to your instances
2. Handle milions of request per seconds
3. Less latency ~100ms (vs 400ms for ALB)

NLB has **one static IP** per AZ, and supprots assigning Elastic IP(helpful for whitelisting specific IP)   => you can't assign an Elastic IP address to an Application Load Balancer. 

> 例题
>
> A company is designing a new web service that will run on Amazon EC2 instances behind an Elastic Load Balancer. However, many of the web service clients can only reach IP addresses whitelisted on their firewalls.
> What should a solutions architect recommend to meet the clients' needs?
>
> - A. A Network Load Balancer with an associated Elastic IP address. **Most Voted**
> - B. An Application Load Balancer with an associated Elastic IP address
> - C. An A record in an Amazon Route 53 hosted zone pointing to an Elastic IP address
> - D. An EC2 instance with a public IP address running as a proxy in front of the load balancer

## 078 Gateway Load Balancer(GWLB)

Deploy,scale,and manage a fleet of 3rd party network virtual appliances in AWS.

Example:Firewalls,Deeo Packet Inspection Systems...

Operates at Layer 3 (Network Layer)-IP Packets

从网上收集流量，先转发到第三方的3rd Party Secutiry Virtual Appliances分析，OK之后传回GWLB，GWLB再转发到Application. （网关嘛路由转发）

> 例题
>
> A company has a three-tier web application that is deployed on AWS. The web servers are deployed in a public subnet in a VPC. The application servers and database servers are deployed in private subnets in the same VPC. The company has deployed a third-party virtual firewall appliance from AWS Marketplace in an inspection VPC. The appliance is configured with an IP interface that can accept IP packets.
> A solutions architect needs to integrate the web application with the appliance to inspect all traffic to the application before the traffic reaches the web server.
> Which solution will meet these requirements with the LEAST operational overhead?
>
> - A. Create a Network Load Balancer in the public subnet of the application's VPC to route the traffic to the appliance for packet inspection.
> - B. Create an Application Load Balancer in the public subnet of the application's VPC to route the traffic to the appliance for packet inspection.
> - C. Deploy a transit gateway in the inspection VPConfigure route tables to route the incoming packets through the transit gateway.
> - D. Deploy a Gateway Load Balancer in the inspection VPC. Create a Gateway Load Balancer endpoint to receive the incoming packets and forward the packets to the appliance.

## 079 ELB-Sticky Sessions

Operation order:EC2->Target groups->my-first-target-group->Edit attributes

基于cookie，ELB将固定client转发到固定instances，会有expire时间

## 080 ELB-Cross-Zone Load Balancing

ELB必然也存在于一个特定的AZ，负载均衡时可以无视instance的AZ差异。只是对于ALB，默认开启且不能被关所以免费；对于NLB，默认关闭，启用收费；而CLB虽然默认关闭但启用不收费...

=>With Application Load Balancers, **cross-zone load balancing** is always enabled.

With Network Load Balancers and Gateway Load Balancers, cross-zone load balancing is disabled by default. After you create the load balancer, you can enable or disable cross-zone load balancing at any time.

## 081 ELB-SSL Certificates

SSL: Secure Sockets Layer, used to encrypt connections (HTTPS)

**TLS**: Transport Layer Security, which is **a newer version of SSL**

(Nowadays, TLS certificates are mainly used, but people still refer as SSL)

Public SSL certificates are issued by Certificate Authorities(CA)



**SNI**: Server Name Indication

SNI solves the problem of **loading mutiple SSL certificates onto one web server**(to serve multiple websites), it's a "newer" protocol, **supported by ALB and NLB**, CloudFront, not supported by CLB

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

**Scaling policies** can be on CPU,Network,even schedule

1. Dynamic scaling policies

   1.1 **target tracking policy**(比如通过扩展收缩使CPU利用率稳定在40%)

   1.2 Simple/Step Scaling: set up CloudWatch alarm(比如CPU到30%，增加一个，到70%增加两个...)

   1.3 **Scheduled actions**

2. **Predictive scaling policies**  => based on machine learning

> 例题
>
> A company hosts its website on AWS. To address the highly variable demand, the company has implemented Amazon EC2 Auto Scaling. Management is concerned that the company is over-provisioning its infrastructure, especially at the front end of the three-tier application. A solutions architect needs to ensure costs are optimized without impacting performance.
> What should the solutions architect do to accomplish this?
>
> - A. Use Auto Scaling with Reserved Instances.
> - B. Use Auto Scaling with a scheduled scaling policy.
> - C. Use Auto Scaling with the suspend-resume feature.
> - D. Use Auto Scaling with a target tracking scaling policy.



ASG Default Termination Policy:

1. Find the AZ which has the most number of instances
2. If there are multiple instances in the AZ to choose from, delete the one with **the oldest launch** configuration

ASG tries the balance the number of instances across AZ by default.



Scaling Cooldowns: After a scaling activity happens, you are in the cooldown period( default 300 seconds). During the cooldown period, the ASG will not lauch or terminate additional instances( to allow for mereics to stabilize)



**Lifecycle Hooks:** You have the ability to perform extra steps before the instance in service(Pending state or terminating state)

为什么叫Hooks，就是说ASG流程中Pending到Inservice状态流程外挂上一个钩子，在钩子里进行额外操作，比如向instance配置文件，收集log.



Lauch Template vs **Launch Configuration**:

都能提供AMI去launch EC2 instances, 只是前者更newer，Recommended By AWS

另外Launch Configuration Must be re-created every time.

> 例题
>
> A company must re-evaluate its need for the Amazon EC2 instances it currently has provisioned in an Auto Scaling group. At present, the Auto Scaling group is configured for a minimum of two instances and a maximum of four instances across two Availability Zones. A Solutions architect reviewed Amazon CloudWatch metrics and found that CPU utilization is consistently low for all the EC2 instances.
> What should the solutions architect recommend to maximize utilization while ensuring the application remains fault tolerant?
>
> - A. Remove some EC2 instances to increase the utilization of remaining instances.
> - B. Increase the Amazon Elastic Block Store (Amazon EBS) capacity of instances with less CPU utilization.
> - C. Modify the Auto Scaling group scaling policy to scale in and out based on a higher CPU utilization metric.
> - D. Create a new launch configuration that uses smaller instance types. Update the existing Auto Scaling group.

## 088 Amazon RDS Overview 20220705

RDS stands for Relational Database Service

It's managed DB **service** for DB use SQL as a query language.

It allows you to create databases in the cloud that are managed by AWS

​	PostgreSQL,MySQL,MariaDB,Oracle,Microsoft SQL Server,Aurora

But you can't SSH into your instances.



DB Snapshots compared to Backups:

1. Manually triggered by the user
2. Retention of backup for as long as you want.



RDS backups and **scales automatically** for you.



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

Enhanced Monitoring is a feature of Amazon RDS.=>好像可以用来监测线程
=>Enhanced Monitoring metrics are useful when you want to see how different processes or threads on a DB instance use the CPU.

## 089 RDS Read Replicas vs Multi AZ

RDS Read Replicas for read scalability

​	up to 5 Read Replicas

​	With AZ, Cross AZ or Cross Region

For RDS Read Replicas within the same region, you don't pay that fee.
=> **Read Replica provides an asynchronous replication** instead of synchronous.

=> it does not support automatic failover, need to manually promote as primary instance 

(RDS 是托管服务)



RDS Muiti AZ (Disaster Recovery)

​	**SYNC replication**

​	One DNS name-automatic app failover to standby

​	Not used for scaling

=> you can't directly connect to the standby instance.

=> Muiti AZ in the same region

Note: The Read Replicas can be setup as Multi AZ for Disaster Reconvery.



RDS-From Single-AZ to Muti-AZ:

1. A snapshot is taken
2. A new DB is restored from the snapshot in a new AZ
3. Synchronization is established between the two databases.

So just click on "modify" for the database, it's Zero downtime operation.(no need to stop the DB)

> 例题
>
> A company hosts an online shopping application that stores all orders in an Amazon RDS for PostgreSQL Single-AZ DB instance. Management wants to eliminate single points of failure and has asked a solutions architect to recommend an approach to **minimize database downtime** without requiring any changes to the application code.
> Which solution meets these requirements?
>
> - A. Convert the existing database instance to a Multi-AZ deployment by modifying the database instance and specifying the Multi-AZ option.
> - B. Create a new RDS Multi-AZ deployment. Take a snapshot of the current RDS instance and restore the new Multi-AZ deployment with the snapshot.
> - C. Create a read-only replica of the PostgreSQL database in another Availability Zone. Use Amazon Route 53 weighted record sets to distribute requests across the databases.
> - D. Place the RDS for PostgreSQL database in an Amazon EC2 Auto Scaling group with a minimum group size of two. Use Amazon Route 53 weighted record sets to distribute requests across instances.

RDS的security group还是在EC2上统一管理的。

> 您只能在创建 Amazon RDS 数据库实例时而不是创建该数据库实例之后加密该数据库实例。
>
> 不过，由于您可以加密未加密快照的副本，因此，您可以高效地为未加密的数据库实例添加加密。也就是说，您可以创建数据库实例快照，然后创建该快照的加密副本。然后，您可以从加密快照还原数据库实例，从而获得原始数据库实例的加密副本。

> 例题
>
> Application developers have noticed that a production application is very slow when business reporting users run large production reports against the Amazon
> RDS instance backing the application. The CPU and memory utilization metrics for the RDS instance do not exceed 60% while the reporting queries are running.
> The business reporting users must be able to generate reports without affecting the application's performance.
> Which action will accomplish this?
>
> - A. Increase the size of the RDS instance.
> - B. Create a read replica and connect the application to it.
> - C. Enable multiple Availability Zones on the RDS instance.
> - D. Create a read replica and connect the business reports to it. **Most Voted**

## 091 RDS Encryption+Security

Encruption has to be defined at launch time.

If the master is not encrypted, the read replicas cannot be encrypted.

SSL certificates to encrypt data to RDS in flight.



Access Management:

IAM database authentication only works with MySQL and PostgreSQL.

**IAM Authentication**: Yout don't need a password, just an authentication token obtained through IAM $ RDS API calls 

IAM centrally manage users instead of DB. => 用于EC2和RDS通信，安全加密且方便登录

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

Reader Endpoint: Connection **Load Balancing** because of Auto Scaling 

这里的Auto Scaling大概是两个层次，其一是单一Aurora，其二是read-only server层面的自动扩容(你可以设定)。

> 例题
>
> A company decides to migrate its three-tier web application from on-premises to the AWS Cloud. The new database must be capable of dynamically scaling storage capacity and performing table joins.
> Which AWS service meets these requirements?
>
> - A. Amazon Aurora
> - B. Amazon RDS for SqlServer
> - C. Amazon DynamoDB Streams
> - D. Amazon DynamoDB on-demand

## 094 Aurora-Advanced Concepts

Aurora Replicas-Auto Scaling

> 例题
>
> A company recently started using Amazon Aurora as the data store for its global ecommerce application. When large reports are run, developers report that the ecommerce application is performing poorly. After reviewing metrics in Amazon CloudWatch, a solutions architect finds that the ReadIOPS and CPUUtilization metrics are spiking when monthly reports run.
> What is the MOST cost-effective solution?
>
> - A. Migrate the monthly reporting to Amazon Redshift.
> - B. Migrate the monthly reporting to an Aurora Replica. **Most Voted**
> - C. Migrate the Aurora database to a larger instance class.
> - D. Increase the Provisioned IOPS on the Aurora instance.

Writer **Endpoint** :与Client相连，writer与read通过不同endpoint

Reader Endpoint

**Custom Endpoints**: Define a subset of Aurora Instances as a Custom Endpoint. Example-Run analytical queries on specific replicas. The reader endpoint is generally not used after defining Custom Endpoints.

> 例题
>
> An application running on AWS uses an Amazon Aurora Multi-AZ DB cluster deployment for its  database. When evaluating performance metrics, a solutions architect discovered that the database reads  are causing high I/O and adding latency to the write requests against the database. What should the solutions architect do to separate the read requests from the write requests? 
>
> A) Enable read-through caching on the Aurora database. 
>
> B) Update the application to read from the Multi-AZ standby instance. 
>
> C) Create an Aurora replica and modify the application to use the appropriate endpoints. 
>
> D) Create a second Aurora database and link it to the primary database as a read replica

Aurora Serverless: Automated database instantiation and auto-scaling based on actual usage. （似乎就不分master，read-only了）=>Aurora DB cluster转变为Aurora Serverless需要用AWS Database Migration Service

Aurora Multi-Master: Every node does R/W => an immediate failover for writer

Global Aurora: 1 Primary Region(r/w); Up to 5 secondary(read-only) region.

Aurora Machine Learning: Simple ,optimized, and secure intergration between Aurora and AWS ML sevices(Amazon SageMaker, Amazon Conprehend)

## 095 ElastiCache Overview

The same way RDS is to get managed Relational Database...

ElasticCache is to get managed Redis or Memcahced.

Cache are in-memory databases with really high performance,low latency

AWS takes care of OS maintance,configuration,failure recovery...

Using ElatiCache involves heavy application code changes...



ElasticCache Solution Architecture:

1. DB Cahce: Applications queries ElastiCache(Cache hit),if not(Cache miss),get from RDS and store in ElasticCache.
2. User Session Store:



Redis vs Memcached:  High availibity vs No High availibity 

> 例题
>
> A company has developed a new video game as a web application. The application is in a three-tier architecture in a VPC with Amazon RDS for MySQL. In the database layer several players will compete concurrently online. The game's developers want to display a top-10 scoreboard in near-real time and offer the ability to stop and restore the game while preserving the current scores.
> What should a solutions architect do to meet these requirements?
>
> - A. Set up an Amazon ElastiCache for Memcached cluster to cache the scores for the web application to display.
> - B. Set up an Amazon ElastiCache for Redis cluster to compute and cache the scores for the web application to display. **Most Voted**
> - C. Place an Amazon CloudFront distribution in front of the web application to cache the scoreboard in a section of the application.
> - D. Create a read replica on Amazon RDS for MySQL to run queries to compute the scoreboard and serve the read traffic to the web application.



All caches in ElastiCache:

​	**Do not support IAM authentication**

​	IAM policies on ElastiCache are only used for AWS API-level security

**Redis AUTH**   =>Using Redis AUTH command can improve data security by requiring the user to enter a password before they are granted permission to execute Redis commands on a password-protected Redis server.

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

CNAME:maps a hostname to another hostname

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

Alias Records Targets: **ELB**, S3 Websites...but You can't set it for an EC2 DNS name

=> To route domain traffic to an **ELB** load balancer, use Amazon Route 53 to create an **alias** record that points to your load balancer. 

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

**Health Check**是mandatory, 后者optional，前者失败failover到后者。

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



You can use **Route 53 health checking** to configure active-active and active-passive failover configurations. 

**Active-Active Failover**：就是两个都Active,不分primary和secondary .

**Active-Passive Failover**：primary resource 是Active， secondary resource只有当Failover是才从Passive变为Active.



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

1. **Automatically handles capacity provisioning, load balancing, scaling,** application health monitoring, instance configuration...
2. Just the application code is the responsibility of the developer.

We still have full control over the configuration.

=>Elastic Beanstalk environments have limited resources; for example, Elastic Beanstalk does not create a VPC for you. CloudFormation on the other hand is more of a low-level service that you can use to model the entirety of your AWS environment. In fact, Elastic Beanstalk uses CloudFormation under the hood to create resources. =>Beanstalk 偏向**quickly deploy and manage applications**， 而CloudFormation偏向an easy way to create a **collection of related AWS resources** .

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

1. SSE-S3 : Each object is encrypted with a unique key. As an additional safeguard, it encrypts the key itself with a master key that it regularly rotates. (AES-256)
2. SSE-KMS =>**refer to Chapter 266** : Similar to SSE-S3, but also provides you with an audit trail that shows when your CMK was used and by whom. Additionally, you can create and manage customer-managed CMKs or use AWS managed CMKs that are unique to you
3. SSE-C: S3 does not store the encryption key you provide,HTTPS is mandatory for SSE-C.
4. Client Side Encryption

**Client-side encryption** is the act of encrypting data before sending it to Amazon S3. To enable client-side encryption, you have the following options:

\- Use an AWS KMS-managed customer master key. （you provide an AWS KMS customer master key ID (CMK ID) to AWS. ）

\- Use a client-side master key.



前三者都是 server-side encryption, 只是前两者的key由S3提供。

> 例题
>
> A company’s security team requires that all data stored in the cloud be encrypted at rest at all times  using encryption keys stored on premises. Which encryption options meet these requirements? (Select TWO.) 
>
> A) Use server-side encryption with Amazon S3 managed encryption keys (SSE-S3). 
>
> B) Use server-side encryption with AWS KMS managed encryption keys (SSE-KMS). 
>
> **C)** Use server-side encryption with customer-provided encryption keys (SSE-C). 
>
> **D)** Use client-side encryption to provide at-rest encryption. 
>
> E) Use an AWS Lambda function invoked by Amazon S3 events to encrypt the data using the customer’s  keys.

## 132 S3 Security & Bucket policies

User based: 

1. IAM policies=>which API calls should be allowed for a specific user from IAM console

Resource Based: 

1. Bucket policies=>bucket wide rules from the s3 console-allows **cross account**
2. ACL(Access Control List)



Note: an IAM principle can access an S3 object if

1. the user IAM permissions allow it OR the resource policy Allows it
2. AND there is no explicit Deny.

后者有三种状态：Allow，Deny，模糊。而前者是在后者没有Deny的前提下。



Bucket Policies: JSON based policies

Use S3 bucket for policy to:

1. Grant public access to the bucket
2. Force objects to be encrypted at upload
3. Grant access to another accout(**Cross Accout**)

> 例题
>
> A company has multiple AWS accounts for various departments. One of the departments wants to share an Amazon S3 bucket with all other department.
> Which solution will require the LEAST amount of effort?
>
> - A. Enable cross-account S3 replication for the bucket.
> - B. Create a pre-signed URL for the bucket and share it with other departments.
> - C. Set the S3 bucket policy to allow cross-account access to other departments.
> - D. Create IAM users for each of the departments and configure a read-only IAM policy.



Bucket settings for Block Public Access

**These settings were created to prevent company data leaks**

## 134 S3 Websites

S3 can host static websites and have them accessible on the WWW.

Operation:Properties=>Static website hosting

static content: **HTML, CSS, Javascript**

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

> 例题
>
> An analytics company is planning to offer a web analytics service to its users. The service will require  that the users’ webpages include a JavaScript script that makes authenticated GET requests to the  company’s Amazon S3 bucket. What must a solutions architect do to ensure that the script will successfully execute? 
>
> A) Enable cross-origin resource sharing (CORS) on the S3 bucket. 
>
> B) Enable S3 Versioning on the S3 bucket. 
>
> C) Provide the users with a signed URL for the script. 
>
> D) Configure an S3 bucket policy to allow public execute privileges.

## 138 IAM Roles and Policies

IAM中一个Role可以有很条Policies，这些policies允许你去各个服务如S3增删改查，policy可以自定义

测试这个性质可以用一个在线工具：AWS Policy Simulator

## 140 AWS EC2 Instance Metdadata

```
curl http://169.254.169.254/latest/meta-data/
```

上述IP基本上是AWS内部网点，它只作用于用你的EC2去访问，查询EC2的关联信息。（类似于EC2作为此内部网点的用户？）

It allows AWS EC2 instances to "learn about themselves" without using an IAM Role for that purpose.

> 例题
>
> A user wants to list the IAM role that is attached to their Amazon EC2 instance. The user has login access to the EC2 instance but does not have IAM permissions.
> What should a solutions architect do to retrieve this information?
>
> - A. Run the following EC2 command: curl http://169.254.169.254/latest/meta-data/iam/info **Most Voted**
> - B. Run the following EC2 command: curl http://169.254.169.254/latest/user-data/iam/info
> - C. Run the following EC2 command: http://169.254.169.254/latest/dynamic/instance-identity/
> - D. Run the following AWS CLI command: aws iam get-instance-profile --instance-profile-name ExampleInstanceProfile

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

=>**AWS CloudTrail logs** provide a record of actions taken by a user, role, or an AWS service in Amazon S3, while **Amazon S3 server access logs** provide detailed records for the requests that are made to an S3 bucket.
ELB has the feature of access logs =>Access logging is an optional feature of Elastic Load Balancing that is disabled by default. After you enable access logging for your load balancer, Elastic Load Balancing captures the logs and stores them in the Amazon S3 bucket that you specify as compressed files. You can disable access logging at any time.

## 147 S3 Replication(CRR&SRR)

Must enable **versioning** in source and destination

CRR:Cross Region Repilication

SRR:Same Region Replication

Buckets can be in different accouts



> 例题
>
> A company has copied 1 PB of data from a colocation facility to an Amazon S3 bucket in the us-east-1 Region using an AWS Direct Connect link. The company now wants to copy the data to another S3 bucket in the us-west-2 Region. The colocation facility does not allow the use of AWS Snowball.
> What should a solutions architect recommend to accomplish this?
>
> - A. Order a Snowball Edge device to copy the data from one Region to another Region.
> - B. Transfer contents from the source S3 bucket to a target S3 bucket using the S3 console.
> - C. Use the aws S3 sync command to copy data from the source bucket to the destination bucket. 
> - D. Add a cross-Region replication configuration to copy objects across S3 buckets in different Regions. 



Notes；

After activatin, only new objects are replicated

There is no "chaining" of replication(不会连续复制，1自动复制到2，2不会将此自动复制到3，所以2不将复制过来的文件视为写入。)

For Delete oprations: can replicate delete markers from source to target(optional setting)



> **Amazon S3 Transfer Acceleration** 是一项存储桶级别功能，可在您的客户端和 S3 Bucket 之间实现快速、轻松、安全的远距离文件传输。Transfer Acceleration 旨在优化从世界各地传入 S3 存储桶的传输速度。Transfer Acceleration 利用 Amazon CloudFront 中的全球分布式边缘站点。当数据到达某个边缘站点时，数据会被经过优化的网络路径路由至 Amazon S3。
>
> =>就跟CRR等无关



> 例题
>
> A company collects data for temperature, humidity, and atmospheric pressure in cities across multiple continents. The average volume of data that the company collects from each site daily is 500 GB. Each site has a high-speed Internet connection.
> The company wants to aggregate the data from all these global sites as quickly as possible in a single Amazon S3 bucket. The solution must minimize operational complexity.
> Which solution meets these requirements?
>
> - **A.** Turn on S3 Transfer Acceleration on the destination S3 bucket. Use multipart uploads to directly upload site data to the destination S3 bucket.
> - B. Upload the data from each site to an S3 bucket in the closest Region. Use S3 Cross-Region Replication to copy objects to the destination S3 bucket. Then remove the data from the origin S3 bucket.
> - C. Schedule AWS Snowball Edge Storage Optimized device jobs daily to transfer data from each site to the closest Region. Use S3 Cross-Region Replication to copy objects to the destination S3 bucket.
> - D. Upload the data from each site to an Amazon EC2 instance in the closest Region. Store the data in an Amazon Elastic Block Store (Amazon EBS) volume. At regular intervals, take an EBS snapshot and copy it to the Region that contains the destination S3 bucket. Restore the EBS volume in that Region.



## 149 S3 Pre-sgined URLs

Can generate pre-signed URLs using SDK or CLI

Valid for a default of 3600 seconds, can change timeout with expires.(generating URLs dynamically)

Users given a pre-signed URL inherit the permissions of the person who generated the URL for GET/PUT

注意到console中bucket中文件显示的地址没法打开(S3 变公开就可以打开)，而下载键后打开网页其实是一个新的URL，这个就是pre-signed URL.

## 151 S3 Storage Classes & Glacier

Standard: High durabiliry(99.999999%)

Standard-Infrequent Access(IA):useCases=>backup => suitable for data that is less frequently accessed, but requires rapid access when needed.

One Zone-infrequent Access:Low cost compared to IA

**Intelligent Tiering**: Automatically moves objects between two access tiers based on changing access patterns(Standard <=> IA)

> 例题
>
> A company is creating a web application that will store a large number of images in Amazon S3. The images will be accessed by users over variable periods of time. The company wants to:
> ✑ Retain all the images
> ✑ Incur no cost for retrieval.
> ✑ Have minimal management overhead.
> ✑ Have the images available with no impact on retrieval time.
> Which solution meets these requirements?
>
> - A. Implement S3 Intelligent-Tiering
> - B. Implement S3 storage class analysis
> - C. Implement an S3 Lifecycle policy to move data to S3 Standard-Infrequent Access (S3 Standard-IA).
> - D. Implement an S3 Lifecycle policy to move data to S3 One Zone-Infrequent Access (S3 One Zone-IA).

Glacier: very low cost, 取用时需要额外的唤醒时间(1-12hours)

​	Amazon Glacier-3 retriecal options:

​		**Expedited**(1 to 5 minutes) +**Provisioned capacity**

​		Standard(3 to 5 hours)

​		Bulk(5 to 12 hours)

​		**这个说明，即便Glacier也可以5分钟以内搜索到，只是搜索成本高一些。**

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

=>比如Get CSV with S3 Select, 在S3侧先过滤，然后通过网络传输的流量就少了

=>**Amazon Glacier Select** is not an archive retrieval option, 与Expedited,Bulk等区别

## 158 S3 Event Notifications

Types: SNS, SQS, Lambda Function

> 例题
> 
> A company's application integrates with multiple software-as-a-service (SaaS) sources for data collection. The company runs Amazon EC2 instances to receive the data > and to upload the data to an Amazon S3 bucket for analysis. The same EC2 instance that receives and uploads the data also sends a notification to the user when an upload is complete. The company has noticed slow application performance and wants to improve the performance as much as possible.
> Which solution will meet these requirements with the LEAST operational overhead?
> 
> A. Create an Auto Scaling group so that EC2 instances can scale out. Configure an S3 event notification to send events to an Amazon Simple Notification Service (Amazon SNS) topic when the upload to the S3 bucket is complete.
> 
> B. Create an Amazon AppFlow flow to transfer data between each SaaS source and the S3 bucket. Configure an S3 event notification to send events to an Amazon Simple > Notification Service (Amazon SNS) topic when the upload to the S3 bucket is complete.
> 
> C. Create an Amazon EventBridge (Amazon CloudWatch Events) rule for each SaaS source to send output data. Configure the S3 bucket as the rule's target. Create a second EventBridge (Cloud Watch Events) rule to send events when the upload to the S3 bucket is complete. Configure an Amazon Simple Notification Service (Amazon  SNS) topic as the second rule's target.
> 
> D. Create a Docker container to use instead of an EC2 instance. Host the containerized application on Amazon Elastic Container Service (Amazon ECS). Configure Amazon CloudWatch Container Insights to send events to an Amazon Simple Notification Service (Amazon SNS) topic when the upload to the S3 bucket is complete.

## 160 S3 Requester pays

In general ,bucket owners pay for all Amazon S3 storage and data transfer costs associated with their bucket

With Requester Pays buckets, the requester instead of the bucket owner pays the cost of the request and the data download from the bucket.

Helpful when you wang to share large datasets with other accounts

=>You pay for all bandwidth into and out of Amazon S3, except for the following:

- Data transferred in from the Internet.
- Data transferred out to an Amazon EC2 instance, when the instance is in the same AWS Region as the S3 bucket (including to a different account in the same AWS region).
- Data transferred out to Amazon CloudFront.

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

1. Governance mode: users cannot overwrite or delete an object **version** or alter its lock setting unless they have special permission
2. Complicance mode: 用于给监管部门查看的，随意甚至root也无法修改

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

=>比如这样的场景：to deliver their content to a specific client

Signed URL = access to individual files( one signed URL per file)

**Signed Cookies** = access to multiple files( one signed cookie for many files)

CloudFront Signed URL vs S3 Pre-Signed URl, 差不多，非要说就是是否直连S3 bucket，前者CloudFront与S3之间还有个OAI.

## 167 CloudFront Advanced Concepts

CloudFront Edge  locations are all around the world. The cost of data out per edge location varies  => Price Classes

Multi-Origin: To route to different kind of origins based on the context type

**Origin Groups:** High availibilty and do failover, If the primary origin fails, the second one is used.

**Field Level Encryption**: Sensitive information encrypted at the edge close to user

> 例题
>
> A solutions architect is creating a new Amazon CloudFront distribution for an application. Some of the information submitted by users is sensitive. The application uses HTTPS but needs another layer of security. The sensitive information should be protected throughout the entire application stack, and access to the information should be restricted to certain applications.
> Which action should the solutions architect take?
>
> - A. Configure a CloudFront signed URL
> - B. Configure a CloudFront signed cookie.
> - C. Configure a CloudFront field-level encryption profile.
> - D. Configure a CloudFront and set the Origin Protocol Policy setting to HTTPS. Only for the Viewer Protocol Pokey.

## 168 AWS Global Accelerator Overview 20220710

背景：一个美国Client访问位于印度的Server，如果Public network需要跳太多路由器，所以先去访问位于美国的Edge Location，然后通过AWS私网直接去访问印度的Server，来减少延迟。中间运用所谓的Anycast IP，不细究...

Unicast IP: one server holds one IP address

Anycast IP: all servers **hold the same IP address** and the client is routed to the nearest one

~~后者是怎么实现的呢？就是不同IP的服务器通过同一台Proxy向全球各地users提供服务，而这台Proxy就是所谓的Accelerator~~

在全球各地部署同一个静态IP的Proxy来收取packet？

Work with Elastic IP, EC2 instances, **ALB**, NLB, public or private

Security：only 2 external IP to be whitelisted?=>私网的两个端点IP...不太懂

AWS Global Acceleraor vs CloudFront:

**They both use the AWS global network and its edge locations around the world**

但是：cloudfront are talking about application layer - serves HTTP requests. only for Layer7 HTTP/HTTPS/websites and S3 mostly??

Both services integrate with AWS Shield for DDos protection.

因为AWS Global Acceleraor更多是Proxy，而不是缓存，所以我觉得更安全

> 例题
>
> A company that develops web applications has launched hundreds of Application Load Balancers (ALBs) in multiple Regions. The company wants to create an allow list for the IPs of all the load balancers on its firewall device. A solutions architect is looking for a one-time, highly available solution to address this request, which will also help reduce the number of IPs that need to be allowed by the firewall.
> What should the solutions architect recommend to meet these requirements?
>
> - A. Create a AWS Lambda function to keep track of the IPs for all the ALBs in different Regions. Keep refreshing this list.
> - B. Set up a Network Load Balancer (NLB) with Elastic IPs. Register the private IPs of all the ALBs as targets to this NLB. **（B is wrong, because IP of ALB is always changing.）**
> - C. Launch AWS Global Accelerator and create endpoints for all the Regions. Register all the ALBs in different Regions to the corresponding endpoints. （**assist lower the number of IPs that the firewall must accept or AnyCast IP -> Usually associated with Global Accelator**）
> - D. Set up an Amazon EC2 instance, assign an Elastic IP to this EC2 instance, and configure the instance as a proxy to forward traffic to all the ALBs.

## 170 AWS Snow Family Overview

Highly-secure, portable **devices** to collect and process data at the edge, and migrate data into and out of AWS.



Times to Transfer:

|       | 100Mbps | 1Gbps   | 10Gbps  |
| ----- | ------- | ------- | ------- |
| 10TB  | 12days  | 30hours | 3hours  |
| 100TB | 124days | 12days  | 30hours |



Amazon将一些硬件邮寄给你，你可以用来比网络速度更快的硬件数据迁移，然后寄回去，直接插到网络服务中...下面从小到大共有三种，最小的Snowcone可以放到无人机上，最大的Snowmobile居然是辆大卡车...

1. Snowcone
2. Snowball Edge
3. Snowmobile (100PB of capcity)

除了Data migration外，上述前两者还可以做Edge computing，就是暂时不能联网的地方，比如海船上做机器学习产生了大量数据，所以要求除了硬盘，还要CPU.

> 例题
>
> A company has a 143 TB MySQL database that it wants to migrate to AWS. The plan is to use Amazon Aurora MySQL as the platform going forward. The company has a 100 Mbps AWS Direct Connect connection to Amazon VPC.
> Which solution meets the company's needs and takes the LEAST amount of time?
>
> - A. Use a gateway endpoint for Amazon S3. Migrate the data to Amazon S3. Import the data into Aurora.
> - B. Upgrade the Direct Connect link to 500 Mbps. Copy the data to Amazon S3. Import the data into Aurora.
> - C. Order an AWS Snowmobile and copy the database backup to it. Have AWS import the data into Amazon S3. Import the backup into Aurora.
> - D. Order four 50-TB AWS Snowball devices and copy the database backup onto them. Have AWS import the data into Amazon S3. Import the data into Aurora.

不是所有地区都提供...

Snowball cannnot import to Glacier directly, you must use Amzon S3 first, in combination with an S3 lifecycle policy.

## 173 Storage Gateway Overview

所谓的Hybrid Cloud for Storage，就是一部分infrastructure在云上，一部分在本地...问题是**怎样将S3**（Unlike EFS/NFS）延伸到本地呢？

AWS Storage Cloud Native Options:

1. Block: Amazon EBS, EC2 instance Store
2. File: Amazon EFS, Amazon FSx
3. Object: Amazon S3, Amazon Glacier



AWS Storage Gateway: **Bridge** between **on -premises** data(本地？) and cloud data in **S3**.

3 types of Storage Gateway:

1. File gateway: Store files as objects in S3, with a local cache for low-latency access to your most recently used data. =>Configure S3 buckets are accessible using NFS and SMB protocol, intergrated with AD
2. Volume gateway: **Block storage** in S3 with point-in-time backups as EBS snapshots. =>**iSCSI**  =>联想SAN，就像一个硬盘->不够准确，有两个类型 Cached volumes: low latency access to most recent data, Store volumes:entire dataset is on premise, schedules backups to S3.
3. Tape gateway: Backup your data to S3 and archive in Glacier using your existing tape-based processes. =>iSCSI  ->Some companies have backup process using physical tapes.

这个gateway应该在你本地网络虚拟化，如果没有，也可以向Amazon买Hardware appliance. Tape gateway是本地磁盘化然后存到S3去？File gateway似乎可以用NFS相关协议...而后两者用iSCSI interface来连接Application Server和Gateway，Volume gateway可以整个cache到本地，定期向云端backup？所介绍的功能越来越边缘且无趣...

> 例题
>
> A company requires a durable backup storage solution for its on-premises database servers while ensuring on-premises applications maintain access to these backups for quick recovery. The company will use AWS storage services as the destination for these backups. A solutions architect is designing a solution with minimal operational overhead.
> Which solution should the solutions architect implement?
>
> - A. Deploy an AWS Storage Gateway file gateway on-premises and associate it with an Amazon S3 bucket.
> - B. Back up the databases to an AWS Storage Gateway volume gateway and access it using the Amazon S3 API. 
> - C. Transfer the database backup files to an Amazon Elastic Block Store (Amazon EBS) volume attached to an Amazon EC2 instance.
> - D. Back up the database directly to an AWS Snowball device and use lifecycle rules to move the data to Amazon S3 Glacier Deep Archive.
>
> 解析
>
> it should be A. **For SG volume gateway, you cannot directly access the backups using Amazon S3 API**. Q: When I look in Amazon S3 why can’t I see my volume data? A: Your volumes are stored in an Amazon S3 bucket maintained by the AWS Storage Gateway service. Your volumes are accessible for I/O operations through AWS Storage Gateway. You cannot directly access them using Amazon S3 API actions. You can take point-in-time snapshots of gateway volumes that are made available in the form of Amazon EBS snapshots, which can be turned into either Storage Gateway Volumes or EBS Volumes. Use the File Gateway to work with your data natively in S3.



## 175 Amazon FSx Overview

EFS is a shared POSIX system for Linux systems



FSx for Windows is a fully managed Windows file system share drive

Support **SMB protocol** & Windows NTFS



FSx for Lustre: a type  of **parallel distributed file system**, for large-scale computing. The name Lustre is derived from "Linux" and "cluster" =>** Machine Learning**, High Performance Computing(HPC), Seamless integration with S3...

> 例题
>
> A company wants to use high performance computing (HPC) infrastructure on AWS for financial risk modeling. The company's HPC workloads run on Linux. Each
> HPC workflow runs on hundreds of AmazonEC2 Spot Instances, is short-lived, and generates thousands of output files that are ultimately stored in persistent storage for analytics and long-term future use.
> The company seeks a cloud storage solution that permits the copying of on premises data to long-term persistent storage to make data available for processing by all EC2 instances. The solution should also be a high performance file system that is integrated with persistent storage to read and write datasets and output files.
> Which combination of AWS services meets these requirements?
>
> - A. Amazon FSx for Lustre integrated with Amazon S3
> - B. Amazon FSx for Windows File Server integrated with Amazon S3
> - C. Amazon S3 Glacier integrated with Amazon Elastic Block Store (Amazon EBS)
> - D. Amazon S3 bucket with a VPC endpoint integrated with an Amazon Elastic Block Store (Amazon EBS) General Purpose SSD (gp2) volume



> **Amazon FSx for NetApp ONTAP**
>
> Amazon FSx for NetApp ONTAP 提供功能丰富、高性能且高度可靠的存储，这些存储基于 NetApp 流行的 ONTAP 文件系统构建，完全由 AWS 托管。
>
> - 可通过各种 Linux、Windows 和 macOS 计算实例和容器访问(在 AWS 上或本地部署运行)，支持行业标准的 NFS、SMB 和 iSCSI 协议。
> - 提供流行的 ONTAP 数据管理功能，例如快照、SnapMirror (用于数据复制)、FlexClone (用于数据克隆)和数据压缩/重复数据删除。
> - 提供几十万个 IOPS 以及一致的亚毫秒级延迟，以及高达 3 GB/s 的吞吐量。
> - 提供高度可用且高度持久的多可用区 SSD 存储，支持跨区域复制并内置完全托管式备份功能。
> - 自动将不频繁访问的数据分层到容量池存储，容量池存储是一个完全弹性的存储层，可以扩展到 PB 级，并为不频繁访问数据优化了成本。
> - 与 **Microsoft Active Directory (AD)**集成以支持基于 Windows 的环境和企业。



> **Amazon FSx for OpenZFS**
>
> Amazon FSx for OpenZFS 提供基于 OpenZFS 文件系统和 AWS Graviton 处理器构建的简单、经济高效、高性能文件存储，可通过行业标准 NFS 协议访问此存储。
>
> - 可从各种 Linux、Windows 和 macOS 计算实例和容器(在 AWS 上或本地部署运行)通过行业标准的 NFS 协议(v3、v4.0、v4.1 和 v4.2)访问。
> - 提供强大的 OpenZFS 数据管理功能，包括 Z-Standard 压缩、即时时间点快照和数据克隆。
> - 提供高达 100 万 IOPS 和仅仅数百微秒的延迟，同时吞吐量高达 12.5 GB/s。
> - 提供高度可用且高度持久的单可用区 SSD 存储，以及内置的完全托管备份。
> - 通过每个文件系统的多个卷、精简资源预置和用户/组配额，跨多个用户和应用程序实现成本高效的共享文件系统。



> 例题
>
> A company is migrating to the AWS Cloud. A file server is the first workload to migrate. Users must be able to access the file share using the Server Message
> Block (SMB) protocol. Which AWS managed service meets these requirements?
>
> - A. Amazon Elastic Block Store (Amazon EBS)
> - B. Amazon EC2
> - C. Amazon FSx
> - D. Amazon S3

## 177 AWS Transfer Family

A  fully-managed service for file transfers into and out of Amazon S3 or EFS using FTP protocol.

Support Protocols: FTP, FTPS(FTP over SSL), SFTP(Secure FTP)

Users<=>Route 53(optional)<=>AWS Transfer For FTP<=>S3/EFS

## 180 SQS-Standard Queues Overview

Oldest offering(over 10 years old), Fully managed service, used t decouple applications



Produced to SQS using the SDK (SendMessage API)

The message is persisted in SQS **until a consumer deletes it**

Message retention: default 4 days, up to 14 days



**SQS with Auto Scaling Group(ASG) => common in exam**(可以通过CloudWatch)

Security=>In -flight encryption using HTTPS API => 它是个服务器？



you cannot set a priority to individual items in the SQS queue. it is best to create 2 separate SQS queues for each type of member. 

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

> 例题
>
> A company is working with an external vendor that requires write access to the company's Amazon Simple Queue Service (Amazon SQS) queue. The vendor has its own AWS account.
> What should a solutions architect do to implement least privilege access?
>
> - A. Update the permission policy on the SQS queue to give write access to the vendor's AWS account. **Most Voted**
> - B. Create an IAM user with write access to the SQS queue and share the credentials for the IAM user.
> - C. Update AWS Resource Access Manager to provide write access to the SQS queue from the vendor's AWS account.
> - D. Create a cross-account role with access to all SQS queues and use the vendor's AWS account in the trust document for the role.

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

After the **MaximumRecieves** threshold is exceeded, the message goes into a dead letter queue(DLQ)  => Clinet 发回 SQS， SQS察觉超threshold了，发给DLQ

> 例题
>
> A solutions architect is redesigning a monolithic application to be a loosely coupled application composed of two microservices: Microservice A and Microservice
> B.
> Microservice A places messages in a main Amazon Simple Queue Service (Amazon SQS) queue for Microservice B to consume. When Microservice B fails to process a message after four retries, the message needs to be removed from the queue and stored for further investigation.
> What should the solutions architect do to meet these requirements?
>
> - A. Create an SQS dead-letter queue. Microservice B adds failed messages to that queue after it receives and fails to process the message four times.
> - B. Create an SQS dead-letter queue. Configure the main SQS queue to deliver messages to the dead-letter queue after the message has been received four times.
> - C. Create an SQS queue for failed messages. Microservice A adds failed messages to that queue after Microservice B receives and fails to process the message four times.
> - D. Create an SQS queue for failed messages. Configure the SQS queue for failed messages to pull messages from the main SQS queue after the original message has been received four times.

Make sure to process the message in the DLQ before they expire(Useful for debugging)

相当于一个自动定期清理的垃圾箱

这个DLQ基于普通的Queue，设定一个retention of period, 然后就可以作为其他Queue的DLQ.

> 例题
>
> A company has two applications: a sender application that sends messages with payloads to be processed and a processing application intended to receive messages with payloads. The company wants to implement an AWS service to handle messages between the two applications. The sender application can send about 1,000 messages each hour. The messages may take up to 2 days to be processed. If the messages fail to process, they must be retained so that they do not impact the processing of any remaining messages.
> Which solution meets these requirements and is the MOST operationally efficient?
>
> - A. Set up an Amazon EC2 instance running a Redis database. Configure both applications to use the instance. Store, process, and delete the messages, respectively.
> - B. Use an Amazon Kinesis data stream to receive the messages from the sender application. Integrate the processing application with the Kinesis Client Library (KCL).
> - C. Integrate the sender and processor applications with an Amazon Simple Queue Service (Amazon SQS) queue. Configure a dead-letter queue to collect the messages that failed to process.
> - D. Subscribe the processing application to an Amazon Simple Notification Service (Amazon SNS) topic to receive notifications to process. Integrate the sender application to write to the SNS topic.

## 185 SQS - Request-Response Systems

通过Correlation ID来标记

不同的Producer通过同一个Request Queue标记不同的Correlation ID来发信息到应用ASG的Responders，然后Responders创建不同的Response Queue来回信。=> 一条Request Queue 和多条数量动态变化的Response Queue

To implement this pattern: use the SQS Temporary Queue Client

> 例题
>
> A company is Re-architecting a strongly coupled application to be loosely coupled. Previously the application used a request/response pattern to communicate between tiers. The company plans to use Amazon Simple Queue Service (Amazon SQS) to achieve decoupling requirements. The initial design contains one queue for requests and one for responses. However, this approach is not processing all the messages as the application scales.
> What should a solutions architect do to resolve this issue?
>
> - A. Configure a dead-letter queue on the ReceiveMessage API action of the SQS queue.
> - B. Configure a FIFO queue, and use the message deduplication ID and message group ID.
> - C. Create a **temporary** queue, with the Temporary Queue Client to receive each response message. **Most Voted**
> - D. Create a queue for each request and response on startup for each producer, and use a correlation ID message attribute.

## 186 SQS - Delay Queues

Delay a message(consumers don't see it immediately) up to 15 minutes

Default is 0 seconds.

## 187 SQS - FIFO Queues

FIFO = First in first out(odering of messaes in the queue)

Exactly-once send capability(by removing duplicates)

Messages are processed in order by consumer

=>与 Standard Queue的杂乱无序和At-Least-Once Delivery相较，FIFO就不会出现Duplicates现象.

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

SNS - **Message Filtering** => **Filter Policy是在SNS中的Json，而不是SQS**

所以原则是SNS发所有消息去所有SQS，但相应SQS可以在SNS里配套filtering，从而各个SQS得到不同的消息。=>SNS+SQS Pattern

## 192 Kinesis Overview

Make it easy to collect, process, and analyze streaming data in real-time

1. **Kinesis Data Streams**: capture, process, and **store** data streams => A Kinesis data stream stores records from **24 hours by default** to a maximum of 8760 hours (365 days).
2. **Kinesis Data Firehose**: load data streams into AWS data stores=> S3,Amazon Redshift(copy through S3), Amazon ElasticSearch or Custom HTTP Destinations
3. Kinesis Data Analytics: analyze data streams with SQL or Apache Flink
4. Kinesis Video Streams: capture, process, and store video streams

用Kinesis Data Streams收集data，再利用Kinesis Data Firehose转运到S3去，注意Kinesis Data Firehose会有一个缓存，缓存未满一定时间后才发送到S3. （两者不一定要配合：最终都是producer=>XXX=>consumer模式）

> Apache Kafka 是一个开源，分布式，可伸缩的发布-订阅消息系统。 依赖 ZooKeeper 来运行。
>
> Kinesis 就是 AWS 的对Kafka 在云平台的实现。

## 194 Kinesis vs SQS ordering

Kinesis 可以有许多shards 来hash各种数据的种类，而SQS只有一个接收端口，必须要指定Group ID 来给consumer分组..~~.(视频里虽说有很大不同，但据我理解感觉一样...)~~

=>最关键的是Kinesis是分布式并发，所以很容易给数据分类，一个shard一种数据类型嘛，SQS是FIFO，肯定需要对信息标识才能分类嘛。

## 195 Kinesis vs SNS vs SQS

SNS: Data is not persisted(lost if not delivered)

> 例题
>
> A company is designing a web application using AWS that processes insurance quotes. Users will request quotes from the application. Quotes must be separated by quote type must be responded to within 24 hours, and must not be lost. The solution should be simple to set up and maintain.
> Which solution meets these requirements?
>
> - A. Create multiple Amazon Kinesis data streams based on the quote type. Configure the web application to send messages to the proper data stream. Configure each backend group of application servers to pool messages from its own data stream using the Kinesis Client Library (KCL).
> - B. Create multiple Amazon Simple Notification Service (Amazon SNS) topics and register Amazon SQS queues to their own SNS topic based on the quote type. Configure the web application to publish messages to the SNS topic queue. Configure each backend application server to work its own SQS queue.
> - C. Create a single Amazon Simple Notification Service (Amazon SNS) topic and subscribe the Amazon SQS queues to the SNS topic. Configure SNS message filtering to publish messages to the proper SQS queue based on the quote type. Configure each backend application server to work its own SQS queue. 
> - D. Create multiple Amazon Kinesis Data Firehose delivery streams based on the quote type to deliver data streams to an Amazon Elasticsearch Service (Amazon ES) cluster. Configure the web application to send messages to the proper delivery stream. Configure each backend group of application servers to search for the messages from Amazon ES and process them accordingly.

## 196 Amazon MQ

SQS,SNS are cloud-native services, and they're using prorietary protocols from AWS

Traditional applications running from on-premise may use open protocos such as:MQTT, STOMP...

When migrating to the cloud, instead of re-engineering the application to use SQS and SNS, we can use Amazon MQ.

If you're using messaging with existing applications and want to move your messaging service to the cloud quickly and easily, it is recommended that you consider **Amazon MQ**.

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

Launch **Docker containers** on AWS

Has integrations with ALB



Fargate: You do not provision the infrastructure(no EC2 instances to manage) -simpler!   That's why it's called **serverless** offering.(所谓的serverless是指无服务器的服务？) =>By default, Fargate tasks are given a minimum of 20 GiB of free ephemeral storage

AWS just runs containers for you based on the CPU/RAM you need.(再分配一个ENI，确保足够的IP分配)

所以Fargate是ECS的一种启动类型？: Fargete Launch Type for ECS; EC2 Launch Type for ECS

> 例题
>
> A company's near-real-time streaming application is running on AWS. As the data is ingested, a job runs on the data and takes 30 minutes to complete. The workload frequently experiences high latency due to large amounts of incoming data. A solutions architect needs to design a scalable and serverless solution to enhance performance.
> Which combination of steps should the solutions architect take? (Choose two.)
>
> - A. Use Amazon Kinesis Data Firehose to ingest the data. **Most Voted**
> - B. Use AWS Lambda with AWS Step Functions to process the data. (**We know lambda can run max for 15 min and the job is of 30 min so lambda is out.**)
> - C. Use AWS Database Migration Service (AWS DMS) to ingest the data.
> - D. Use Amazon EC2 instances in an Auto Scaling group to process the data.
> - E. Use AWS Fargate with Amazon Elastic Container Service (Amazon ECS) to process the data. **Most Voted**



ECS Task Role: Allow each task to have a specific role. Use different roles for the different ECS Servie you run.  简而言之，由ECS启动的container访问特定服务如S3所使用的IAM Roles.

EC2 Instance Profile: EC2 Launch Type for ECS时，作为 EC2 instance上的ECS Agent.



**共享资源用EFS去mount.**

## 199 ECS Service & Tasks, Load Balancing

理解以下层次：

Container definition （比如httpd）-> Task definition （选择 Launch Type） -> Service -> Cluster

然后介绍了ALB对于两种方式的ECS的不同点，EC2 Launch Type就是如何找right port，Fargete Launch Type的话，Each task has a unique IP, 如何找IP了.

=> ECS Cluster是最高层次的，Container就是个起特定端口的进程嘛（比如httpd）。ALB可以进行端口映射...

最后讲了一个 ECS tasks invoked by Event Bridge的例子.

## 201 ECS Scaling

也是配合 CloudWatch Metric(ECS seivice CPU Usage)监视CPU Usage来trigger CloudWatch Alarm, 然后去scale

对于EC2 Launch Type for ECS，当没有足够EC2来启动Contaner时候也会在更高层次上（Scale ECS Capacity Providers）去scale EC2 instances，所以这里有两个层次的扩展: Auto scaling, Auto scaling Group

=>就是说EC2上launch Container，可以搞Auto scaling；但是EC2空间被大量Container用完了，那么再通过Scale ECS Capacity Providers去做Auto scaling Group来提供更多的EC2.   也就是说两个层次的扩展: 进程和服务器



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

> K8S的全称为Kubernetes，用于自动部署、扩展和管理“容器化（containerized）应用程序“的开源系统。可以理解成K8S是负责自动化运维管理多个容器化程序（比如Docker）的集群，是一个生态极其丰富的容器编排框架工具。

It is a way to launch managed Kubernetes clusters on AWS

Kubernetes is an **open-source** system for automatic deployment, scaling and management of containerized(usually Docker) application

It's an altenative to ECS, similar goal but different API

Use case: if your company is already using Kubernetes on-premises or in another cloud, and wants to migrate to AWS using Kubernetes.

> 例题
>
> A company is building applications in containers. The company wants to migrate its on-premises development and operations services from its on-premises data center to AWS. Management states that production systems must be cloud agnostic and use the same configuration and administrator tools across production systems. A solutions architect needs to design a managed solution that will align open-source software.
> Which solution meets these requirements?
>
> - A. Launch the containers on Amazon EC2 with EC2 instance worker nodes.
> - B. Launch the containers on Amazon Elastic Kubernetes Service (Amazon EKS) and EKS worker nodes.
> - C. Launch the containers on Amazon Elastic Containers service (Amazon ECS) with AWS Fargate instances.
> - D. Launch the containers on Amazon Elastic Container Service (Amazon ECS) with Amazon EC2 instance worker nodes.

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

而且，Lambda独立于用户的VPC，所以访问VPC中的component时要确保足够的subnet ENIs 和 IPs, 访问私网时要确保配置NAT gateway...

## 209 Lambda Limits 20220716

Execution:

1. Memeory allocation: 128MB-10GB
2. Maximum execution time: 15min
3. Environment Variables: 4KB
4. Disk capacity in the function container(in /tmp): 512MB
5. Concurrency executions: 1000
6. Lambda function deployment size(compressed .zip): 50MB, 250MB(uncompressed)

## 210 Lambda@Edge

You have deployed a CDN using **CloudFront**

What if you wanted to run a global AWS Lambda alongside?

Or how to implement request filtering before reaching your application?

=>For this, you can use Lambada@Edge

You can use Lambda to change CloudFront requests and responses

You can also generate responses to viewers without ever sending the request to the origin.

(Runs code in each CloudFront Edge, **globally**) => run code closer to users of your application

> 例题
>
> A company's packaged application dynamically creates and returns **single-use text files** in response to user requests. The company is using Amazon CloudFront for distribution, but wants to further reduce data transfer costs. The company cannot modify the application's source code.
> What should a solutions architect do to reduce costs?
>
> - A. Use Lambda@Edge to compress the files as they are sent to users.
> - B. Enable Amazon S3 Transfer Acceleration to reduce the response times.
> - C. Enable caching on the CloudFront distribution to store generated files at the edge.
> - D. Use Amazon S3 multipart uploads to move the files to Amazon S3 before returning them to users.
>
> =>补充  The **Multipart upload** API enables you to upload large objects(比如超过5G) to S3

## 211 DynamoDB Overview

NoSQL database - not a relational database => **key-value** store models

Scales to massive workloads, distributed database

Intergrated with IAM for security, authorization and administration



Read/Write Capacity Models:

1. Provisioned Mode(default)=> **predictable** application traffic=> **Possibility** to add Auto Scaling model. (也就是说不是default的)
2. On-Demand Mode => more expensive, automatically scale up/down, great for **unpredictable** workloads.

> 例题
>
> A solutions architect is helping a developer design a new ecommerce shopping cart application using AWS services. The developer is **unsure of the current database schema** and expects to make changes as the ecommerce site grows. The solution needs to be highly resilient and capable of automatically scaling read and write capacity.
> Which database solution meets these requirements?
>
> - A. Amazon Aurora PostgreSQL
> - B. Amazon DynamoDB with on-demand enabled **Most Voted**
> - C. Amazon DynamoDB with DynamoDB Streams enabled
> - D. Amazon SQS and Amazon Aurora PostgreSQL

## 213 DynamoDB Advanced Fratures

**DynamoDB Accelerator(DAX)**: Help solve read congestion by caching.

DAX vs ElatiCache: 前者适应于DynamoDB的Query & Scan cache, 而后者比如Application的计算结果的缓存？？..

**DynamoDB Streams**: Ordered stream of item-level modifications(crate/update/delete) in a table.

就是修改日志数据流可以发送到Kinesis或者Lambda等去分析。

**DynamoDB Global Tables**: Application an read/write to the table in any region

并不是一张table，而是各个区域的table通过DynamoDB Streams来同步

> 例题
>
> A company with facilities in North America, Europe, and Asia is designing new distributed application to optimize its global supply chain and manufacturing process. The orders booked on one continent should be visible to all Regions in a second or less. The database should be able to support failover with a short
> Recovery Time Objective (RTO). The uptime of the application is important to ensure that manufacturing is not impacted.
> What should a solutions architect recommend?
>
> - A. Use Amazon DynamoDB global tables.
> - B. Use Amazon Aurora Global Database. 
> - C. Use Amazon RDS for MySQL with a cross-Region read replica.
> - D. Use Amazon RDS for PostgreSQL with a cross-Region read replica.
>
> 分析
>
> Answer is A 
>
> because 1. RTO is comparable for both Global database and global table but 2. Aurora has one primary region for Read and Write and other regions can only do read which means order update/write in other regions wont be possible except primary region but with DynamoDb global table Instead of writing your own code, you could create a global table consisting of your three Region-specific CustomerProfiles tables. DynamoDB would then automatically replicate data changes among those tables so that changes to CustomerProfiles data in one Region would seamlessly propagate to the other Regions. In addition, if one of the AWS Regions were to become temporarily unavailable, your customers could still access the same CustomerProfiles data in the other Regions. https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GlobalTables.html 
>
> So Dynamodb Global Table is true answer here

**TTL**: Automatically delete items after an expiry timestamp

> 例题
>
> A company is creating a three-tier web application consisting of a web server, an application server, and a database server. The application will track GPS coordinates of packages as they are being delivered. The application will update the database every 0-5 seconds.
> The tracking will need to read a fast as possible for users to check the status of their packages. Only a few packages might be tracked on some days, whereas millions of package might be tracked on other days. Tracking will need to be searchable by tracking ID customer ID and order ID. Order than 1 month no longer read to be tracked.
> What should a solutions architect recommend to accomplish this with minimal cost of ownership?
>
> - A. Use Amazon DynamoDB Enable Auto Scaling on the DynamoDB table. Schedule an automatic deletion script for items older than 1 month.
> - B. Use Amazon DynamoDB with global secondary indexes. Enable Auto Scaling on the DynamoDB table and the global secondary indexes. Enable TTL on the DynamoDB table. **Most Voted**
> - C. Use an Amazon RDS On-Demand instance with Provisioned IOPS (PIOPS). Enable Amazon CloudWatch alarms to send notifications when PIOPS are exceeded. Increase and decrease PIOPS as needed.
> - D. Use an Amazon RDS Reserved Instance with Provisioned IOPS (PIOPS). Enable Amazon CloudWatch alarms to send notification when PIOPS are exceeded. Increase and decrease PIOPS as needed.



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

所以你用一个定位到该API的URL就可以触发相应Lambda，为什么不把Lambda直接暴露给client呢，有IAM上的考虑，API Gateway 也有其它功能：**rate limit, caching**, authenticatins...

（Throttling limits can be set for standard rates and bursts. Although it can scale using AWS Edge locations, you still need to configure the throttling to further manage the bursts of your APIs.）

> 例题
>
> A company wants to move a multi-tiered application from on premises to the AWS Cloud to improve the application's performance. The application consists of application tiers that communicate with each other by way of RESTful services. Transactions are dropped when one tier becomes overloaded. A solutions architect must design a solution that resolves these issues and modernizes the application.
> Which solution meets these requirements and is the MOST operationally efficient?
>
> - A. Use Amazon API Gateway and direct transactions to the AWS Lambda functions as the application layer. Use Amazon Simple Queue Service (Amazon SQS) as the communication layer between application services. **Most Voted**
> - B. Use Amazon CloudWatch metrics to analyze the application performance history to determine the server's peak utilization during the performance failures. Increase the size of the application server's Amazon EC2 instances to meet the peak requirements.
> - C. Use Amazon Simple Notification Service (Amazon SNS) to handle the messaging between application servers running on Amazon EC2 in an Auto Scaling group. Use Amazon CloudWatch to monitor the SNS queue length and scale up and down as required.
> - D. Use Amazon Simple Queue Service (Amazon SQS) to handle the messaging between application servers running on Amazon EC2 in an Auto Scaling group. Use Amazon CloudWatch to monitor the SQS queue length and scale up when communication failures are detected.
>
> 解析
>
> I think it's A as it both decouples (modernizes) the application using SQS, and provides scalability through Lambda.
>
> "RESTful services" -> API gateway to be used

You can use **AWS X-Ray** to trace and analyze user requests as they travel through your Amazon API Gateway APIs to the underlying services. 

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

=>You can add multi-factor authentication (MFA) to a user pool to protect the identity of your users. 

**Cognito Identity Pools(Federated Identity)**: Integrate with Cognito User Pools as an identity provider

Example: provide(temporary access to write to S3 bucket using Facebook Login)



~~以上两者的区别还是不清不楚..是后者可以第三方进行验证，直接访问AWS资源？？前者跟Google，Facebook一个性质，后者把他们对接了？前者可以用Google来代替，与后者配合...~~

=> CUP就是和Google，Facebook一样的Identity Provider，并可以跟API Gateway集成。而CIP通过跟STS交流来回应，给临时凭证

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

Moble client <-> API Gateway ->Lambda <- DAX Caching layer-> DynamoDB Global Table->**DynamoDB Stream->Lambda**->Amazon Simple Email Service(SES)

要做到全球分发，就要想到CloudFront，边缘缓存，S3可以调用Lambda去做缩略图存储. 另外，注册新用户发邮件的架构可利用Lambda去处理DynamoDB Stream.

（P2 明显难起来是因为我缺乏Web服务器搭建经验）

## 221 Micro Services architecture

We want to switch to a micro service architecture

Many services interact with each other directly using a REST API

=> 用API Gateway+Lambda, ELB+ECS等框架

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

> **OLAP，也叫联机分析处理（Online Analytical Processing）**系统，有的时候也叫DSS决策支持系统，就是我们说的数据仓库。在这样的系统中，语句的执行量不是考核标准，因为一条语句的执行时间可能会非常长，读取的数据也非常多。所以，在这样的系统中，考核的标准往往是磁盘子系统的吞吐量（带宽），如能达到多少MB/s的流量

=>用于市场决策参考

Data is loaded **from S3**, DynamoDB, other DBs...

可以通过Kinesis Data Firehose从S3 Loding data，也可以直接用copy command.

=>configure cross-region snapshot copy to implement a disaster recovery plan

### Glue

Managed extract, transform, and load (ETL) service

Useful to prepare and transform data for analytics

Fully serverless service

S3/RDS -> Glue ETL -> Redshift

> AWS Glue 是一项无服务器数据集成服务，可让使用分析功能的用户轻松发现、准备、移动和集成来自多个来源的数据。您可以将其用于分析、机器学习和应用程序开发。它还包括用于编写、运行任务和实施业务工作流程的额外生产力和数据操作工具。
>
> 通过使用 AWS Glue，您可以发现并连接到 70 多个不同的数据来源，并在集中式数据目录中管理您的数据。您可以直观地创建、运行和监控“提取、转换、加载（ETL）”管道，以将数据加载到数据湖中。此外，您可以使用 Amazon Athena、Amazon EMR 和 Amazon Redshift Spectrum 立即搜索和查询已编目数据。

### Neptune

Fully managed **graph** database

比如说Wikipedia，一个页面有各种其它链接，形成一个Graphs

> Amazon Neptune 是一项快速、可靠且完全托管的图形数据库服务，可帮助您轻松构建和运行使用高度互连数据集的应用程序。Neptune 的核心是一个专门打造的高性能图形数据库引擎，它经过优化，可存储数十亿个关系并能以毫秒级延迟进行图形查询。Neptune 支持常见的图形查询语言 Apache TinkerPop Gremlin 和 W3C SPARQL，可让您构建查询，高效地浏览高度互连数据集。Neptune 支持图形使用案例，如建议引擎、欺诈检测、知识图谱、药物开发和网络安全。

### ElasticSearch

Example: In DynamoDB, you can only find by primary key or indexes.

With ElasticSearch, you can search any field, even partially matches.

正则表达式？

It's common to use ElasticSearch as a complement to another database.

## 238 AWS CloudWatch Metrics

CloudWatch provides merics for every service in AWS

Metric is a variable to monitor( CPU utilization,erc...)

**Note**:EC2 Memeory usage is by fault not pushed(must be pushed from inside the instance as a custom metric)
Remember that by default, CloudWatch doesn't monitor memory usage but only the CPU utilization, Network utilization, Disk performance, and Disk Reads/Writes.

## 239 CloudWatch Custom Metrics

Possibility to define and send your own custom metrics to CloudWatch

Example: memory(RAM) usage, disk space...

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

> 例题
>
> A company operates a website on Amazon EC2 Linux instances. Some of the instances are failing. Troubleshooting points to insufficient swap space on the failed instances. The operations team lead needs a solution to monitor this.
> What should a solutions architect recommend?
>
> - A. Configure an Amazon CloudWatch SwapUsage metric dimension. Monitor the SwapUsage dimension in the EC2 metrics in CloudWatch.
> - B. Use EC2 metadata to collect information, then publish it to Amazon CloudWatch custom metrics. Monitor SwapUsage metrics in CloudWatch.
> - C. Install an Amazon CloudWatch agent on the instances. Run an appropriate script on a set schedule. Monitor SwapUtilization metrics in CloudWatch. **Most Voted**
> - D. Enable detailed monitoring in the EC2 console. Create an Amazon CloudWatch SwapUtilization custom metric. Monitor SwapUtilization metrics in CloudWatch.

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

 

CloudTrail Events:

1.Management Event: Example, Configuring security,  routing data...

2.Data Event: By default, are not logged. S3 object-level activity(get,put,delete..)

3.CloudTrail Insights Evnet:to detect unusual activity in your accout.

> 例题
>
> The financial application at a company stores monthly reports in an Amazon S3 bucket. The vice president of finance has mandated that all access to these reports be logged and that any modifications to the log files be detected.
> Which actions can a solutions architect take to meet these requirements?
>
> - A. Use S3 server access logging on the bucket that houses the reports with the read and write data events and log file validation options enabled.
> - B. Use S3 server access logging on the bucket that houses the reports with the read and write management events and log file validation options enabled.
> - C. Use AWS CloudTrail to create a new trail. Configure the trail to log read and write data events on the S3 bucket that houses the reports. Log these events to a new bucket, and enable log file validation. **Most Voted**
> - D. Use AWS CloudTrail to create a new trail. Configure the trail to log read and write management events on the S3 bucket that houses the reports. Log these events to a new bucket, and enable log file validation.



Retention:Events are stored for 90 days in CloudTrail, to keep events beyong this period, log them to S3 and use Athena

By default, CloudTrail event log files are encrypted using Amazon S3 server-side encryption (SSE). 

## 251 AWS Config Overview 20220723

> AWS Config 提供了与您的 AWS 账户关联的资源的详细视图，包括它们的配置方式、彼此关联的方式以及配置及其关系是如何随着时间变化的。

Helps woth auditing and recording compliance of your AWS resources

Questions that can be solved by AWS Config: Is there unrestricted SSH access to my security groups?...

AWS Config Rule does not prevent actions from happening(no deny)

你虽然不能阻止不合规变化发生，但你可以在Config中进行Remediations 补救。

> 例题
>
> A company is reviewing its AWS Cloud deployment to ensure its data is not accessed by anyone without appropriate authorization. A solutions architect is tasked with identifying all open Amazon S3 buckets and recording any S3 bucket configuration changes.
> What should the solutions architect do to accomplish this?
>
> - A. Enable AWS Config service with the appropriate rules
> - B. Enable AWS Trusted Advisor with the appropriate checks.
> - C. Write a script using an AWS SDK to generate a bucket report
> - D. Enable Amazon S3 server access logging and configure Amazon CloudWatch Events.

## 253 CloudTrail vs CloudWatch vs Config

For example, for an ELB

CloudTrail: Track who made any changes to the ELB with API calls => **record API calls made** within your account by everyone

Cloudwatch: Monitor metric and make a dashboard to get an idea of performance

Config:Track security group rules and configuration changes for ELB =>**record configuration changes**

三者互补

CloudTrail相当于对某一资源更改履历，你可以特定谁该了某个动作；而Config预先设定了rule，然后这个rule可以评估任何configuration改动是否compliance. 

> 例题
>
> An operations team has a standard that states IAM policies should not be applied directly to users. Some new team members have not been following this standard. The operations manager needs a way to easily identify the users with attached policies.
> What should a solutions architect do to accomplish this?
>
> - A. Monitor using AWS CloudTrail.
> - B. Create an AWS Config rule to run daily.
> - C. Publish IAM user changes to Amazon SNS.
> - D. Run AWS Lambda when a user is modified.

## 254 AWS STS Overview

AWS STS: Security Token Service

Allows to grant limited and temporary access to AWS resources.

Token is valid for up to one hour.

AssumeRole, **Cross Accout Access** =>别的账户通过STS来获得此账户的某个IAM Role的临时凭证，然后就可以用这个IAM Role去访问类如S3.

Return cres for users logged with an Idp(Facebook Login, Google Login...), but AWS reconmends against using this, and using Cognito instead.

## 255 Identity Federation & Cognito 20220724

Federation lets users outside of AWS to assume temporary role for accessing AWS resources.

比如你用你的facebook账号来登录amazon

过程：

1. 去访问Identity provider(如Facebook)拿Client SAML assertion;
2. 拿着SAML assertion去访问AWS的STS拿temporary security credentials；
3. 用credentials去访问AWS resource如S3； 

一般不同的Identity provider与Federated Identity间用SAML2.0协议来规范，但如果不采用，那么Custom侧要用Identity Broker Application来determine the appropriate IAM policy来用于接收credentials后去访问S3.

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
> **AWS Managed Microsoft AD**:
>
> Create your own AD in AWS, manage users locally, support MFA
>
> AWS Directory Service for Microsoft Active Directory (标准版或企业版)是 AWS 云中的实际 Microsoft Active Directory。您可以使用它来支持 Active Directory 可识别的工作负载；适用于 Microsoft SQL Server 的 Amazon Relational Database Service；AWS Managed Services，例如 Amazon WorkSpaces 和 Amazon QuickSight；或需要 LDAP 目录的 Linux 应用程序。您的最终用户可从 Windows 集成的单一登录体验中受益，无论您是在 AWS 云中将它用作单独目录，还是使用 Active Directory 信任将现有 Active Directory 基础架构扩展到 AWS Cloud 中。
>
> **AD Connector**:
>
> Directory Gateway(Proxy) to redirect to on-premise AD
>
> AD Connector 是一种代理，它允许您将现有的自托管 Microsoft Active Directory (AD)中的身份用于兼容的 AWS 应用程序。您还可以使用 AD Connector 将 Amazon EC2 实例连接到您的 AD 域，并使用现有的组策略对象管理这些实例。这样一来，您可以更轻松地在这些 Amazon EC2 实例上部署 AD 感知应用程序，并使用您的自托管 AD 进行用户和组授权。
>
> **Simple AD**:
>
> AD-compatible managed directory on AWS
>
> Simple AD 是一种兼容基础 Active Directory 的小规模的低成本目录。您可以在 AWS Cloud 中将它用作独立目录以支持 AWS 应用程序和服务、Samba 4 兼容的应用程序以及需要 LDAP (Lightweight Directory Access Protocol )目录的 Linux 应用程序。

总而言之就是Amazon提供的兼容Microsoft AD的方案。

## 257 Organizations Overview

Global service 

Allows to manage multiple AWS accouts

The main account is the master accout

**Consolidated Billing** across all accouts- single payment method

Organizational Units = OU: OU是高于Account的level

Service Control Policies(**SCP**): Whitelist or blacklist IAM actions

> 例题
>
> A solutions architect is designing a security solution for a company that wants to provide developers with individual AWS accounts through AWS Organizations, while also maintaining standard security controls. Because the individual developers will have AWS account root user-level access to their own accounts, the solutions architect wants to ensure that the mandatory AWS CloudTrail configuration that is applied to new developer accounts is not modified.
> Which action meets these requirements?
>
> - A. Create an IAM policy that prohibits changes to CloudTrail, and attach it to the root user.
> - B. Create a new trail in CloudTrail from within the developer accounts with the organization trails option enabled.
> - C. Create a service control policy (SCP) the prohibits changes to CloudTrail, and attach it the developer accounts.
> - D. Create a service-linked role for CloudTrail with a policy condition that allows changes only from an Amazon Resource Name (ARN) in the management account.

=> Adding the aws **PrincipalOrgID** global condition key with a reference to the organization ID to the S3 bucket policy can prevent the members who don't belong to your organization to access the resource

## 259 IAM Adavanced

IAM Conditions : 比如基于IP，区域等对访问进行限制，强制使用MFA

IAM for S3

IAM Roles vs Resource Based Policies

比如账户A要访问账户B中的S3，B可以为A创建一个Role，或者为S3做一个访问策略。

## 260 IAM Policy Evaluation Logic

IAM Permission Boundaries : Advanced feature to use a managed policy to set the maximum permissions an IAM entity can get.

## 261 Resource Access Manager(RAM)

Share AWS resources that you own with other AWS accounts.

Share with any accout or **within your Organization**

比如, 账户1创建一个VPC，Private subnet，它可以将这个subnet分享给账户2，但是这两个账号各自管理在这个subnet上的资源，所分享的仅仅是网络层配置。

## 262 AWS Single Sign On(SSO) Overview 20220725

Centrally manage Single Sign-On to access multiple accounts and 3rd-party business applications.

~~所谓的accounts是指比如同时登陆脸书，谷歌邮箱这种感觉。~~ 

=> 登录 SSO console, 就可直接click去登录multiple accounts.

Intergrated with AWS Organizations

Intergration with on-premise Active Directory

> 提到SAML (Security Assertion Markup Language), 很多人都会联想到单点登录SSO。那么Saml到底是什么，它跟sso到底有什么联系？
>
> 安全声明标记语言（SAML）是一种开放标准，允许身份提供商（IDP）将授权凭证传递给服务提供商（SP）。 这个术语的含义是您可以使用一组凭据登录许多不同的网站。 管理每个用户仅需一次登录比管理电子邮件、客户关系管理（CRM）软件、Active Directory等公司业务系统都需要单独登录要简单得多。
>
> SAML使用可扩展标记语言（XML）进行身份提供商和服务提供商之间的标准化通信。 SAML是用户身份验证和使用服务授权之间的链接。

SSO vs AssumeRoleWithSAML: 后者就是需要第三方3rd IDP Login Protal与AWS侧的Broser Interface用SAML协议交互，然后Broser Interface去STS去取Token来登录AWS的资源；而前者就不需要这个第三方了，roser Interface直接登录SSO Login Poral，内置集成SAML，一次性可以访问多个账户。需要注意的是即便是AWS跨账户临时访问，其核心还是STS. => Although the AWS SSO service uses STS, it does not issue short-lived credentials by itself. AWS Single Sign-On (SSO) is a cloud SSO service that makes it easy to centrally manage SSO access to multiple AWS accounts and business applications.

=>**AWS IAM Identity Center**  is the successor to AWS Single Sign-On

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

=> S3 doesn't provide AES-128 encryption, only AES-256

Three types of Customer Master Keys(CMK):

1. AWS Managed Service Default CMK:free
2. User keys created in KMS

3. User keys imported(must be 256-bit symmetric key)

比如你要加密数据库登录密码，你可以发送到KMS加密，对方可以发送去KMS解密



Coping Snapshots across regions: key跟region对应，跨区要重新加密

AWS managed keys or Custom managed keys : 即便是后者也是调用KMS API来创建的。

AWS KMS supports **multi-Region keys**, which are AWS KMS keys in different AWS Regions that can be used interchangeably – as though you had the same key in multiple Regions. 

## 268 KMS Key Rotation

Only for Customer-managed CMK, if enable: automatic key rotation happens every 1 year.

## 269 SSM Parameter Store Overview

> 集中存储和管理您的密钥和配置数据，例如密码、数据库字符串和许可证代码。您可以将值加密，或存储为纯文本，还能实现每个级别的安全访问。

Serverless

可以连接AWS KMS来加密Parameter

不仅可以用CLI来取用Parameter，还可以通过Lambda来取，记得为Lambda的IAM Role添加允许访问SSM，KMS的IAM Policy.

## 272 AWS Secrets Manager

Newer service, meant for storing secrets （newer to SSM Parameter Store）

Capability to force rotation of scerets every X days

Intergraion with Amazon RDS(Mostly meant for RDS integration)

Secrets are encypted using KMS

> 使用 Secrets Manager 来存储、转动、监控和控制对数据库凭证、API 密钥和 OAuth 令牌等密钥的访问。使用内置集成对 Amazon RDS 上的 MySQL、PostgreSQL 和 Amazon Aurora 启用密钥转动。您还可以使用 AWS Lambda 函数启用其他密钥的转动。要检索密钥，您只需通过调用 Secrets Manager API 来更换应用程序中的硬编码密钥，无需暴露明文密钥。

> 例题
>
> A company has recently updated its internal security standards. The company must now ensure all Amazon S3 buckets and Amazon Elastic Block Store (Amazon
> EBS) volumes are encrypted with keys created and periodically rotated by internal security specialists. The company is looking for a native, software-based AWS service to accomplish this goal.
> What should a solutions architect recommend as a solution?
>
> - A. Use AWS Secrets Manager with customer master keys (CMKs) to store master key material and apply a routine to create a new CMK periodically and replace it in AWS Secrets Manager.
> - B. Use AWS Key Management Service (AWS KMS) with customer master keys (CMKs) to store master key material and apply a routine to re-create a new key periodically and replace it in AWS KMS. 
> - C. Use an AWS CloudHSM cluster with customer master keys (CMKs) to store master key material and apply a routine to re-create a new key periodically and replace it in the CloudHSM cluster nodes.
> - D. Use AWS Systems Manager Parameter Store with customer master keys (CMKs) to store master key material and apply a routine to re-create a new key periodically and replace it in the Parameter Store.

## 274 CloudHSM

Dedicated Hardware(HSM = Hardware Security hardware)

You manage your own encryption keys entirely

Supports both symmetric ans asymmetric encryption(SSL/TLS keys)

有相应的客户端软件

可以比较一下CloudHSM和KMS的区别: 前者有三种Master keys: AWS owned CMK, AWS Managed CMK, Customer Managed CMK, 后者只有Customer Managed CMK

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

 **还可以设定特定国家区域的请求通不通过**

**Rate-based** rules - for **DDos** protection     => Set rate limit 

不是免费的

> 例题
>
> A solutions architect is performing a security review of a recently migrated workload. The workload is a web application that consists of Amazon EC2 instances in an Auto Scaling group behind an Application Load Balancer. The solutions architect must improve the security posture and minimize the impact of a DDoS attack on resources.
> Which solution is MOST effective?
>
> - A. Configure an AWS WAF ACL with rate-based rules. Create an Amazon CloudFront distribution that points to the Application Load Balancer. Enable the WAF ACL on the CloudFront distribution.
> - B. Create a custom AWS Lambda function that adds identified attacks into a common vulnerability pool to capture a potential DDoS attack. Use the identified information to modify a network ACL to block access.
> - C. Enable VPC Flow Logs and store then in Amazon S3. Create a custom AWS Lambda functions that parses the logs looking for a DDoS attack. Modify a network ACL to block identified source IP addresses.
> - D. Enable Amazon GuardDuty and configure findings written to Amazon CloudWatch. Create an event with CloudWatch Events for DDoS alerts that triggers Amazon Simple Notification Service (Amazon SNS). Have Amazon SNS invoke a custom AWS Lambda function that parses the logs, looking for a DDoS attack. Modify a network ACL to block identified source IP addresses.



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



Amazon GuardDuty can generate findings based on suspicious activities such as requests coming from known **malicious IP addresses, changing of bucket policies/ACLs** to expose an S3 bucket publicly, or suspicious API call patterns that attempt to discover misconfigured bucket permissions. => 守卫不被可疑IP更改各种安全策略

## 279 Amazon Inspector

Only for EC2 instances

Analyze the **running OS** against known vulnerabilities => OS层面上有什么不安全的

AWS Inspector Agent must be installed on OS in EC2 instances

之后才能跟Inspector Service交互 



## 280 Amazon Macie

用机器学习来分析搜索**在S3中的敏感数据**，such as personally identifiable information(PII)

S3 => Macie => CloudWatch Events EventBridge => SNS, Lambda

> 例题
>
> A company has an application that provides marketing services to stores. The services are based on previous purchases by store customers. The stores upload transaction data to the company through SFTP, and the data is processed and analyzed to generate new marketing offers. Some of the files can exceed 200 GB in size.
> Recently, the company discovered that some of the stores have uploaded files that contain personally identifiable information (PII) that should not have been included. The company wants administrators to be alerted if PII is shared again. The company also wants to automate remediation.
> What should a solutions architect do to meet these requirements with the LEAST development effort?
>
> - A. Use an Amazon S3 bucket as a secure transfer point. Use Amazon Inspector to scan the objects in the bucket. If objects contain PII, trigger an S3 Lifecycle policy to remove the objects that contain PII.
> - B. Use an Amazon S3 bucket as a secure transfer point. Use Amazon Macie to scan the objects in the bucket. If objects contain PII, use Amazon Simple Notification Service (Amazon SNS) to trigger a notification to the administrators to remove the objects that contain PII.
> - C. Implement custom scanning algorithms in an AWS Lambda function. Trigger the function when objects are loaded into the bucket. If objects contain PII, use Amazon Simple Notification Service (Amazon SNS) to trigger a notification to the administrators to remove the objects that contain PII.
> - D. Implement custom scanning algorithms in an AWS Lambda function. Trigger the function when objects are loaded into the bucket. If objects contain PII, use Amazon Simple Email Service (Amazon SES) to trigger a notification to the administrators and trigger an S3 Lifecycle policy to remove the meats that contain PII.

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

创建一个VPC，划分出数个子网，在Router中创建路由表指向本地部分子网，最后创建网关，编辑路由表指向此互联网网关，最终该子网上的EC2就可以使用Public IP了。

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

Requirea an Internet Gateway (Private Subnet => NATGW => IGW)

Can't be used by EC2 instance in the same subnet(only from other subnets)?=>NAT Gateways在公网，instance在私网，当然不是同一个subnet啦

操作很简单，直接创建，然后编辑**私网中**EC2的路由器指向这个NAT Gatways就行，大概IGW需要提前创建，然后会自动连接？

注意NAT Gateway与NAT instance的区别：前者Managed by AWS, 后者Managed by you.

> 例题：
>
> A company recently deployed a two-tier application in two Availability Zones in the us-east-1 Region. The databases are deployed in a private subnet while the web servers are deployed in a public subnet. An internet gateway is attached to the VPC. The application and database run on Amazon EC2 instances. The database servers are unable to access patches on the internet. A solutions architect needs to design a solution that maintains database security with the least operational overhead.
> Which solution meets these requirements?
>
> - A. Deploy a NAT gateway inside the public subnet for each Availability Zone and associate it with an Elastic IP address. Update the routing table of the private subnet to use it as the default route.
> - B. Deploy a NAT gateway inside the private subnet for each Availability Zone and associate it with an Elastic IP address. Update the routing table of the private subnet to use it as the default route.
> - C. Deploy two NAT instances inside the public subnet for each Availability Zone and associate them with Elastic IP addresses. Update the routing table of the private subnet to use it as the default route.
> - D. Deploy two NAT instances inside the private subnet for each Availability Zone and associate them with Elastic IP addresses. Update the routing table of the private subnet to use it as the default route.

## 297 DNS Resolution Options & Route 53 Praivate zones

DNS Resolution 可以利用Amazon提供的 Route 53，也可以Custome DNS Server.

If you use costom DNS domain names in a Private Hosted Zone in Route 53, you must set both these attributes(enableDnsSupport & enableDnsHostname) to true.

比如，你想为你的EC2访问谷歌时使用别名，你就需要启动这两个特性。

enableDnsSupport 默认启动，就是使用Route 53 而不是自定义。

enableDnsHostname默认的VPC是启动的，自建的VPC关闭，它赋予你在公网中的EC2一个DNS domain name.

## 299 NACL & Security Groups

NACL和SG都可以编辑出入规则，组合使用。区别在于前者是Stateless =>(return traffic must be explicitly allowed by rules, think of ephemeral ports)，就是不管你的信息是发送还是回复，一律检查；而后者是Stateful => (return traffic is automatically allowed, regardless of any rules)，回复的消息就直接通过。

还有一点： **security group has only "Allow" option.**

> 例题
>
> A company is planning on deploying a newly built application on AWS in a default VPC. The application will consist of a web layer and database layer. The web server was created in public subnets, and the MySQL database was created in private subnets. All subnets are created with the default network ACL settings, and the default security group in the VPC will be replaced with new custom security groups.
> The following are the key requirements:
> ✑ The web servers must be accessible only to users on an SSL connection.
> ✑ The database should be accessible to the web layer, which is created in a public subnet only.
> ✑ All traffic to and from the IP range 182.20.0.0/16 subnet should be blocked.
> Which combination of steps meets these requirements? (Choose two.)
>
> - A. Create a database server security group with inbound and outbound rules for MySQL port 3306 traffic to and from anywhere (0 0.0.0/0).
> - B. Create a database server security group with an inbound rule for MySQL port 3306 and specify the source as a web server security group.
> - C. Create a web server security group with an inbound allow rule for HTTPS port 443 traffic from anywhere (0.0.0.0/0) and an inbound deny rule for IP range 182.20.0.0/16.
> - D. Create a web server security group with an inbound rule for HTTPS port 443 traffic from anywhere (0.0.0.0/0). Create network ACL inbound and outbound deny rules for IP range 182.20.0.0/16.
> - E. Create a web server security group with inbound and outbound rules for HTTPS port 443 traffic to and from anywhere (0.0.0.0/0). Create a network ACL inbound deny rule for IP range 182.20.0.0/16.

NACL = Network Access Control List

NACL are like a firewall which control traffic on a subnet level. (SG operates at the instance level)

客户端回信时，会选择一个临时端口，Ephemeral Ports, 所以NACL设置rule时对于回信是设置一个端口范围的。

> 例题
>
> A company has a web server running on an Amazon EC2 instance in a public subnet with an Elastic IP address. The default security group is assigned to the EC2 instance. The default network ACL has been modified to block all traffic. A solutions architect needs to make the web server accessible from everywhere on port
> 443.
> Which combination of steps will accomplish this task? (Choose two.)
>
> - A. Create a security group with a rule to allow TCP port 443 from source 0.0.0.0/0. **Most Voted**
> - B. Create a security group with a rule to allow TCP port 443 to destination 0.0.0.0/0.
> - C. Update the network ACL to allow TCP port 443 from source 0.0.0.0/0.
> - D. Update the network ACL to allow inbound/outbound TCP port 443 from source 0.0.0.0/0 and to destination 0.0.0.0/0.
> - E. Update the network ACL to allow inbound TCP port 443 from source 0.0.0.0/0 and outbound TCP port 32768-65535 to destination 0.0.0.0/0. **Most Voted**

```
#安装web服务器
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo su
echo "hello wrold" > /var/www/html/index.html
```

在NACL中，Rule number很重要，它会据此自从排序，**越小的数字越靠前执行**，优先度越高。默认NACL的number是100，它允许所有流量通过。

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

(对于特定VPC通过Endpoint访问S3=>可以使用存储桶策略控制从 VPC 端点的访问)

=>补充Endpoint到S3之间，有两层控制策略：endpoint policy与bucket policy

> 例题
>
> A company mandates that an Amazon S3 gateway endpoint must allow traffic to trusted buckets only.
> Which method should a solutions architect implement to meet this requirement?
>
> - A. Create a bucket policy for each of the company's trusted S3 buckets that allows traffic only from the company's trusted VPCs.
> - B. Create a bucket policy for each of the company's trusted S3 buckets that allows traffic only from the company's S3 gateway endpoint IDs.
> - C. Create an S3 endpoint policy for each of the company's S3 gateway endpoints that blocks access from any VPC other than the company's trusted VPCs.
> - D. Create an S3 endpoint policy for each of the company's S3 gateway endpoints that provides access to the Amazon Resource Name (ARN) of the trusted S3 buckets.
>
> 解析
>
> Ans: D Although B works, it is extremely tedious to create bucket policies if the company has 100's of buckets.
>
> （The difference between B and D is who should be restricted. B is to restrict endpoints while D is to restrict buckets. The question is to restrict buckets, not endpoints.）

VPC Endpoints(AWS PrivateLink):

Every AWS service is publicly exposed(public URL)

VPC Endpoints(powered by AWS PrivateLink) allows you to connect to AWS services using a private network instead of using the public internet.

举例说访问SNS，如果使用internet，首先网络状况没有私网好，另外NAT Gateway等配置也要费用

Types of Endpoints:

1. Interface Endpoints: 配置一个ENI，所以要设置SG，support most AWS Service => relatively not cost-effective,  Interface endpoints extend the functionality of gateway endpoints by using ...
2. **Gateway Endpoint**s:must be used as a target in a route table, only support S3 and DynamoDB  => Since DynamoDB tables are **public resources**, applications within a VPC rely on an Internet Gateway to route traffic to/from Amazon DynamoDB. You can use a **Gateway endpoint** if you want to keep the traffic between your VPC and Amazon DynamoDB within the Amazon network.

> 例题
>
> A company has an image processing workload running on Amazon Elastic Container Service (Amazon ECS) in two private subnets. Each private subnet uses a
> NAT instance for internet access. All images are stored in Amazon S3 buckets. The company is concerned about the data transfer costs between Amazon ECS and Amazon S3.
> What should a solutions architect do to reduce costs?
>
> - A. Configure a NAT gateway to replace the NAT instances.
> - B. Configure a gateway endpoint for traffic destined to Amazon S3.
> - C. Configure an interface endpoint for traffic destined to Amazon S3.
> - D. Configure Amazon CloudFront for the S3 bucket storing the images.

## 307 VPC Flow Logs 20220728

Capture information about IP trafiic going into your interfaces

Helps to monitor connectivity issues

收发IP端口以及是否被Firewall通过拒绝等信息，是在VPC层面上的，类似于tcpdump?

Query VPC logs using Athena on S3 or CloudWatch Logs Insights.



Athena如何去操作S3呢？Athena在某个S3路径下对其log进行表创建，以及之后的SQL Query操作。

## 309 Site to Site VPN Connections

Virtual Praivate Gateway (VGW): VPN concentrator on the AWS side of the VPN connection => compared to Internet Gateway 

Customer Gateway(CGW): Software application or physical device on customer side of the VPN connection

AWS VPN CloudHub: Provide sevure communication between multiple sites, if you have multiple VPN connections.

就是多个CGW跟这个VGW通信的话，这些CGW之间也可以通过这个VPN交流，此时VGW就相当于一个CloudHub了。

> 您一次能将一个VGW连接到 VPC。要将同一 Site-to-Site VPN 连接连接到多个 VPC，我们建议您改为探索使用中转网关。

> 要避免因您的CGW不可用而造成连接中断，您可使用CGW来为您的 VPC 和虚拟私有网关设置第二个站点到站点 VPN 连接。通过使用冗余站点到站点 VPN 连接和CGW，您可以在对其中一个设备进行维护时保证流量可以继续流经第二个CGW站点到站点 VPN 连接。

It's a VPN connection so it goes over the public internet.

注意的是CGW实体虽然在对端，**但AWS侧你还是要设置CGW IP等信息的**。

> 例题
>
> A company wants to use an AWS Region as a disaster recovery location for its on-premises infrastructure. The company has 10 TB of existing data, and the on- premise data center has a 1 Gbps internet connection. A solutions architect must find a solution so the company can have its existing data on AWS in 72 hours without transmitting it using an unencrypted channel.
> Which solution should the solutions architect select?
>
> - A. Send the initial 10 TB of data to AWS using FTP.
> - B. Send the initial 10 TB of data to AWS using AWS Snowball.
> - C. Establish a VPN connection between Amazon VPC and the company's data center.
> - D. Establish an AWS Direct Connect connection between Amazon VPC and the company's data center.
>
> 解析
>
> AWS prepares and ships the Snowball to you, and you receive it in approximately 4-6 days.

## 311 Direct Connect(DX)

Provides a dedicated private connection from a remote network to your VPC

相对于之前VPN通过公网通信，这可以通过私网通信，所以网络状况更好？

You need to setup a Virtual Private Gateway on your VPC

Access public resources S3 and private(EC2) on same connection

总的而言，似乎是Customer Network与VPC之间建立一个AWS Direct Connect location（其中有AWS Direct Connect Endpoint, Customer router等节点），然后通过Private virtual interface 去连接VPG. 而S3等可以用AWS Direct Connect Endpoint用Public virtual interface去连接.

=> 还可以在Customer Network 与 AWS Direct Connect location间加一个VPN来提供Encryption.

Direct Connect Gateway: If you want to setup a Direct Connect to one or more VPC in many different regions(same account), you must use a Direct Connect Gateway

这个Direct Connect Gateway就在AWS Direct Connect location和多个VPC的VPG之间。

Direct Connect - Resiliency：一个VPC配置多个AWS Direct Connect Location去连接客户data center（one connection at multiple locations），进一步在同一个Location配置多条线路

=>理解DX Location, 就是个网路区域

> 例题
>
> A solutions architect is designing a hybrid application using the AWS cloud. The network between the on-premises data center and AWS will use an AWS Direct
> Connect (DX) connection. The application connectivity between AWS and the on-premises data center must be highly resilient.
> Which DX configuration should be implemented to meet these requirements?
>
> - A. Configure a DX connection with a VPN on top of it.
> - B. Configure DX connections at multiple DX locations.
> - C. Configure a DX connection using the most reliable DX partner.
> - D. Configure multiple virtual interfaces on top of a DX connection.

## 312 AWS PrivateLink - VPC Endpoint Service

背景：Exposing services in your VPC to other VPC. 你可以通过Public Internet，不怎么安全，也可以通过VPC peering，但需要将VPC全部expose.

 Service VPC需要设置一个Network Load Balancer跟Application service连接, Customer VPC需要设置ENI与Consumer Application连接，然后两者组成了AWS Private Link.

比如ALB背后连接着许多ECS task，然后这个ALB跟NLB连接，就能通过AWS Private Link被另一个配置了ENI的VPC访问了.

注意305p所讲的VPC endpoint是指内部私网EC2 如何去访问S3, 这里是另一个VPC通过endpoint去访问，当然其构架基础肯定有共通之处。

> 例题
>
> A software vendor is deploying a new software-as-a-service (SaaS) solution that will be utilized by many AWS users. The service is hosted in a VPC behind a
> Network Load Balancer. The software vendor wants to provide access to this service to users with the least amount of administrative overhead and without exposing the service to the public internet.
> What should a solutions architect do to accomplish this goal?
>
> - A. Create a peering VPC connection from each user's VPC to the software vendor's VPC.
> - B. Deploy a transit VPC in the software vendor's AWS account. Create a VPN connection with each user account.
> - C. Connect the service in the VPC with an AWS Private Link endpoint. Have users subscribe to the endpoint.
> - D. Deploy a transit VPC in the software vendor's AWS account. Create an AWS Direct Connect connection with each user account.

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

> 例题
>
> A company is using a VPC peering strategy to connect its VPCs in a single Region to allow for cross-communication. A recent increase in account creations and
> VPCs has made it difficult to maintain the VPC peering strategy, and the company expects to grow to hundreds of VPCs. There are also new requests to create site-to-site VPNs with some of the VPCs. A solutions architect has been tasked with creating a centrally managed networking setup for multiple accounts, VPCs, and VPNs.
> Which networking solution meets these requirements?
>
> - A. Configure shared VPCs and VPNs and share to each other.
> - B. Configure a hub-and-spoke VPC and route all traffic through VPC peering.
> - C. Configure an AWS Direct Connect connection between all VPCs and VPNs.
> - D. Configure a transit gateway with AWS Transit Gateway and connect all VPCs and VPNs.

## 316 VPC Traffic Mirroring

Allows you to capture and inspect network traffic in your VPC

简而言之，复制一份到某个EC2的流浪route到一个分析架构上

Use cases: content inspection, threat monitoring, troubleshooting =>没有提filtering

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

AWS Schema Conversion Tool(SCT): 两个不同的database enginner之间迁移时所需要。

You need to implement a change data capture (CDC) replication to copy the recent changes after the migration. 

> 例题
>
> A company is moving its on-premises Oracle database to Amazon Aurora PostgreSQL. The database has several applications that write to the same tables. The applications need to be migrated one by one with a month in between each migration Management has expressed concerns that the database has a high number of reads and writes. The data must be kept in sync across both databases throughout tie migration.
> What should a solutions architect recommend?
>
> - A. Use AWS DataSync for the initial migration. Use AWS Database Migration Service (AWS DMS) to create a change data capture (CDC) replication task and a table mapping to select all cables.
> - B. Use AWS DataSync for the initial migration. Use AWS Database Migration Service (AWS DMS) to create a full load plus change data capture (CDC) replication task and a table mapping to select all tables.
> - C. Use the AWS Schema Conversion Tool with AWS DataBase Migration Service (AWS DMS) using a memory optimized replication instance. Create a full load plus change data capture (CDC) replication task and a table mapping to select all tables. **Most Voted**
> - D. Use the AWS Schema Conversion Tool with AWS Database Migration Service (AWS DMS) using a compute optimized replication instance. Create a full load plus change data capture (CDC) replication task and a table mapping to select the largest tables.

## 327 On-Premise strategy with AWS

Ability to download Amazon Linux 2 AMI as a VM(.iso format) => VMWare

说明EC2是个虚拟机

VM Import/Export: Migrate existing applications into EC2; Can export back the VMs from EC2 to on-premise

## 328 DataSync Overview

Move large amount of data from on-premise to AWS

Can synchronize to: S3, EFS, FSx

Move data from your NAS or file system via NFS or SMB

在本地设置一个AWS D**ataSync Agent**，与AWS DataSync **Service endpoint**用TLS连接，进行本地与云数据同步

With AWS DataSync, you can transfer data from on-premises directly to Amazon S3 Glacier Deep Archive. 

> 例题
>
> A company has an on-premises application that collects data and stores it to an on-premises NFS server. The company recently set up a 10 Gbps AWS Direct
> Connect connection. The company is running out of storage capacity on premises. The company needs to migrate the application data from on premises to the
> AWS Cloud while maintaining low-latency access to the data from the on-premises application.
> What should a solutions architect do to meet these requirements?
>
> - A. Deploy AWS Storage Gateway for the application data, and use the file gateway to store the data in Amazon S3. Connect the on-premises application servers to the file gateway using NFS.
> - B. Attach an Amazon Elastic File System (Amazon EFS) file system to the NFS server, and copy the application data to the EFS file system. Then connect the on-premises application to Amazon EFS.
> - C. Configure AWS Storage Gateway as a volume gateway. Make the application data available to the on-premises application from the NFS server and with Amazon Elastic Block Store (Amazon EBS) snapshots.
> - D. Create an AWS DataSync agent with the NFS server as the source location and an Amazon Elastic File System (Amazon EFS) file system as the destination for application data transfer. Connect the on-premises application to the EFS file system.

另一个用例- EFS to EFS: 在一个region的VPC搞一个EC2 instance with DataSync Agent与EFS相连，然后另一个region的VPC中搞一个AWS DataSync Service endpoint与EFS相连。

## 330 AWS Backup Overview

Fully managed service

No need to create custom scripts and manual processes

可以将EC2，EBS，**RDS**，DynamoDB ...各种Resources Automatacally backed up to Amazon S3

所以备份目的地除S3无它

To create backup copies **across AWS accounts and Regions** and for other advanced features, you should use AWS Backup.

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

如果ALB与Cient存在**CloudFront，后者可以用Geo Restriction屏蔽一个特定国家IP，另外也可以装WAF功能，指定复杂的IP address filtering的规则屏蔽特定IP**，WAF也可以加在ALB，作为补充。

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

## 340 CloudFormation Intro 20220802

 理念：Infrastructure as Code  

CloudFromation is a declarative way of outlining your AWS Infrastructure for any resources

类似于配置脚本？写个CloudFormation template，然后自动启动这些服务器...

然后所配置的服务设施也可以在Cloudformation中全部一次性删除

StackSets: Create,update,or delete stacks across multople accounts and regions with a single operation

> 将 `CreationPolicy` 属性与资源相关联，以防止在 AWS CloudFormation 收到指定数量的成功信号或超出超时期限之前进入“创建完成”状态。

## 343 Step Functions & SWF

Build serverless visual **workflow** to orchestrate your Lambda functions

Represent flow as a JSON **state machine**

用JSON组织Lambda？可以表示为流程图

AWS SWF - **Simple Workflow Service**: 感觉像Step Function还不是serverless的老版本，即将被淘汰 => It ensures that a task is never duplicated and is assigned only once. 

## 344 Amazon EMR

EMR stands for "**E**lastic **M**ap**R**educe" =>Big Data

The clusters can be made of hundreds of EC2 instances

=>It securely and reliably handles a broad set of big data use cases, including **log analysis**, web indexing, data transformations (ETL), machine learning, financial analysis, scientific simulation, and bioinformatics. 

Hadoop

> Hadoop起源：hadoop的创始者是Doug Cutting，起源于Nutch项目，该项目是作者尝试构建的一个开源的Web搜索引擎。起初该项目遇到了阻碍，因为始终无法将计算分配给多台计算机。谷歌发表的关于GFS和MapReduce相关的论文给了作者启发，最终让Nutch可以在多台计算机上稳定的运行;后来雅虎对这项技术产生了很大的兴趣，并组建了团队开发，从Nutch中剥离出分布式计算模块命名为“Hadoop”。最终Hadoop在雅虎的帮助下能够真正的处理海量的Web数据。
>
> ​    Hadoop集群是一种分布式的计算平台，用来处理海量数据，它的两大核心组件分别是HDSF文件系统和分布式计算处理框架mapreduce。HDFS是分布式存储系统，其下的两个子项目分别是namenode和datanode;namenode管理着文件系统的命名空间包括元数据和datanode上数据块的位置，datanode在本地保存着真实的数据。它们都分别运行在独立的节点上。Mapreduce的两大子项目分别是jobtracker和tasktracker，jobtracker负责管理资源和分配任务，tasktracker负责执行来自jobtracker的任务。

> 例题
>
> A company receives structured and semi-structured data from various sources once every day. A solutions architect needs to design a solution that leverages big data processing frameworks. The data should be accessible using SQL queries and business intelligence tools.
> What should the solutions architect recommend to build the MOST high-performing solution?
>
> - A. Use AWS Glue to process data and Amazon S3 to store data.
> - B. Use Amazon EMR to process data and Amazon Redshift to store data. **Most Voted**
> - C. Use Amazon EC2 to process data and Amazon Elastic Block Store (Amazon EBS) to store data.
> - D. Use Amazon Kinesis Data Analytics to process data and Amazon Elastic File System (Amazon EFS) to store data.

EMR + Redshift for big data.

## 345 AWS Opsworks

Chef & Puppet help you perform server configuration automatically, or repetitive actions    => configuration as code

They work great with EC2 & On premise VM

AWS Opsworks = Managed Chef & Puppet

Chef & Puppet have similarities with SSM/Beabstalk/Cloudformation, but ther're open-source tools that work cross-cloud

> DevOps（Development和Operations的组合词）是一种重视“软件开发人员（Dev）”和“IT运维技术人员（Ops）”之间沟通合作的文化、运动或惯例。透过自动化“软件交付”和“架构变更”的流程，来使得构建、测试、发布软件能够更加地快捷、频繁和可靠。

> Chef是用于配置管理的开源工具，其用户群侧重于开发人员。 Chef作为主客户端模型运行，需要一个单独的工作站来控制主服务器。 它基于Ruby，您编写的大多数元素都使用纯Ruby。 Chef的设计是透明的，并且要遵循给出的说明，这意味着您必须确保自己的说明清晰。
>
> Puppet是成熟的配置管理领域中长期存在的工具之一。 它是一个开源工具，但是考虑到它已经存在了多久，它已经过严格的审查，并已部署在某些最大和最苛刻的环境中。 Puppet基于Ruby，但是使用更接近JSON的自定义域脚本语言（DSL）来在其中工作。 它作为主客户端设置运行，并使用模型驱动的方法。 Puppet代码设计是一个依赖关系列表，根据您的设置，它可以使事情变得更容易或更混乱。

## 346 AWS WorkSpaces

Managed,Secure Cloud Desktop

Great to eliminate management of on-premise VDI(Virtual Desktop Infrastructure)

On demand, pay per by usage

Integrated with Microsoft Active Directory

User => Virtual Desktop => Corporate data center/ AWS Cloud

## 347 AppSync 20220803

Store ans sync data across mobile and web apps in real-time

Offline data synchronization(Replaces Cognito Sync)

Make use of GraphQL(mobile technology from Facebook)

AWS AppSync is a **serverless** GraphQL and Pub/Sub API service that simplifies building modern web and mobile applications. It provides a robust, scalable GraphQL interface for application developers to combine data from multiple sources, including Amazon DynamoDB, AWS Lambda, and HTTP APIs.

GraphQL is a data language to enable client apps to fetch, change and subscribe to data from servers. In a GraphQL query, the client specifies how the data is to be structured when it is returned by the server. This makes it possible for the client to query only for the data it needs, in the format that it needs it in.

## 348 Cost Explorer

Visualize, understand, and manage your AWS costs and usage over time.

Create custom reports that analyze cost and usage data.

> 例题
>
> As part of budget planning, management wants a report of AWS billed items listed by user. The data will be used to create department budgets. A solutions architect needs to determine the most efficient way to obtain this report information.
> Which solution meets these requirements?
>
> - A. Run a query with Amazon Athena to generate the report.
> - B. Create a report in Cost Explorer and download the report. **Most Voted**
> - C. Access the bill details from the billing dashboard and download the bill.
> - D. Modify a cost budget in AWS Budgets to alert with Amazon Simple Email Service (Amazon SES).

## 351 Well Architected Framework Overview

**Well-Architected Tool**

更像一个turiol，给你一份问卷，让你评估...

=>You can also use the Well-Architected Tool to automatically monitor the status of your workloads across your AWS account, conduct architectural reviews and check for AWS best practices.

### Operational Excellence

Perform operations as code

=> **CloudFormation**, Config, CloudTrail, CloudWatch,

### Security

CloudFront,VPC,Shield,WAF,Inspector

### Reliability

### Performance Efficiency

### Cost Optimization

Pay only for what you use : AWS Auto Scaling, Lambda

## 357 AWS Trusted Advisor Overview 20220809

Analyze your AWS accounts and providers reconmendation: 

1. Cost Optmization
2. Performance
3. Security
4. Fault Tolerance
5. Service Limits

前提是：Available for Business & Enterprise support plans

FAQ = Frequently asked questions



## 360 SAA-C03 topics 20220929

### Machine Learning

**Amazon Transcribe** 可以针对音频文件提供转录服务。它使用高级机器学习技术来识别语音并将其转换为文本。

**Amazon Translate** 是一种神经网络机器翻译服务，可将文本在各种支持的语言和英语之间进行互译。Amazon Translate 以深度学习技术为依托，可提供快速、高质量且经济实惠的语言翻译。该服务提供持续受训的托管解决方案，让您可以轻松翻译公司和用户撰写的内容，或构建需要多种语言支持的应用程序。机器翻译引擎已根据不同领域中的各种内容进行训练，以产生满足各个行业需求的高质量翻译。

**Amazon Comprehend** 使用自然语言处理 (NLP) 提取有关文档内容的见解，无需任何特殊处理。Amazon Comprehend 以 UTF-8 格式处理任何文本文件。它可以通过识别文档中的实体、关键短语、语言、情绪和其他常见元素生成见解。使用 Amazon Comprehend 基于对文档结构的理解创建新产品。借助 Amazon Comprehend，您可以搜索提及相关产品的社交网络信息流、扫描整个文档存储库的关键短语，或确定一组文档中包含的主题。

=>First, you'd have to create a transcription job using Amazon Transcribe to transform the recordings into text. Then, translate non-English calls to English using Amazon Translate. Finally, use Amazon Comprehend for sentiment analysis.



**Amazon Lex** 是一项 AWS 服务，可用于为使用语音和文本的应用程序构建对话接口。借助 Amazon Lex，为 Amazon Alexa 提供技术支持的同一对话引擎现可供任何开发人员使用，从而使您能够在新的和现有的应用程序中构建高级的自然语言聊天自动程序。Amazon Lex 具备自然语言理解 (NLU) 和自动语音识别 (ASR) 的深度功能性和灵活性。Amazon Lex 提供了与 AWS Lambda 的预构建集成=>With Amazon Lex, you can build conversational <u>chatbots</u> quickly. 

**Amazon Rekognition** 让您可以向应用程序轻松添加图像和视频分析功能。您只需向 Amazon Rekognition API 提供图像或视频，该服务即会识别物体、人员、文本、场景和活动。它还可以检测任何不合适的内容。Amazon Rekognition 还可以提供高度准确的面孔分析和面孔识别功能。使用 Amazon Rekognion 自定义标注，您可以创建一个机器学习模型，以查找特定于您的业务需求的物体、场景和概念。

### Security, Identity, & Compliance

**AWS Artifact** 是一种 Web 服务，让您能够下载 AWS 安全性与合规性文档，如 ISO 认证和 SOC 报告。AWS Artifact提供按需下载。AWS 会向您提供安全和合规性文档，例如 AWS ISO 认证、支付卡行业 (PCI) 和服务组织控制 (SOC) 报告等。您可以将安全性和合规性文档（也称为*审核项目*）提交给您的审计人员或监管人员，以证明您所使用的 AWS 基础设施和服务的安全性和合规性。您还可以使用这些文档作为准则，来评估您自己的云架构以及您公司的内部控制有效性。AWS Artifact 仅提供有关 AWS 的文档。AWS 客户负责制定或获取文档来证明自己公司的安全性和合规性。

**AWS Network Firewall** is a stateful, managed network firewall and intrusion detection and prevention service for your virtual private cloud (VPC) that you created in Amazon Virtual Private Cloud (Amazon VPC). With Network Firewall, you can filter traffic at the perimeter of your VPC. This includes filtering traffic going to and coming from an internet gateway, NAT gateway, or over VPN or AWS Direct Connect. Network Firewall uses the open source intrusion prevention system (IPS), Suricata, for stateful inspection. Network Firewall supports Suricata compatible rules.

> 例题
>
> A company recently migrated to AWS and wants to implement a solution to protect the traffic that flows in and out of the production VPC. The company had an inspection server in its on-premises data center. The inspection server performed specific operations such as traffic flow inspection and traffic filtering. The company wants to have the same functionalities in the AWS Cloud.
> Which solution will meet these requirements?
>
> - A. Use Amazon GuardDuty for traffic inspection and traffic filtering in the production VPC.
> - B. Use Traffic Mirroring to mirror traffic from the production VPC for traffic inspection and filtering.
> - C. Use AWS Network Firewall to create the required rules for traffic inspection and traffic filtering for the production VPC.
> - D. Use AWS Firewall Manager to create the required rules for traffic inspection and traffic filtering for the production VPC.

**AWS IAM Identity Center** (successor to AWS Single Sign-On) expands the capabilities of AWS Identity and Access Management (IAM) to provide a central place that brings together administration of users and their access to AWS accounts and cloud applications. Although the service name AWS Single Sign-On has been retired, the term *single sign-on* is still used throughout this guide to describe the authentication scheme that allows users to sign in one time to access multiple applications and websites.

### Database

**Amazon DocumentDB**（兼容 MongoDB）是一项快速、可靠的完全托管数据库服务，使您能够轻松设置、操作和扩展 MongoDB 兼容的数据库。

### Cryptography & PKI

**AWS Certificate Manager** (ACM) 处理创建、存储和续订公有及私有 SSL/TLS X.509 证书和密钥的复杂操作，这些证书和密钥可保护您的AWS网站和应用程序。您可以直接通过 ACM 签发证书，或者通过将第三方证书导入ACM 管理系统中，为集成AWS服务提供证书。ACM 证书可以保护单一域名、多个特定域名、通配符域或这些域的组合。ACM 通配符证书可以保护无限数量的子域。您还可以导出由 ACM Private CA 签名的 ACM 证书，以便在内部 PKI 中的任何位置使用。
=>If you got your certificate from a third-party CA, import the certificate into ACM(AWS Certificate Manager) or upload it to the IAM certificate store. 
ACM lets you import third-party certificates from the ACM console, as well as programmatically. If ACM is not available in your region, use AWS CLI to upload your third-party certificate to the IAM certificate store.

### Compute

**AWS Wavelength** combines the high bandwidth and ultralow latency of 5G networks with AWS compute and storage services so that developers can innovate and build a new class of applications.
Wavelength Zones are AWS infrastructure deployments that embed AWS compute and storage services within telecommunications providers’ data centers at the edge of the 5G network, so application traffic can reach application servers running in <u>Wavelength Zones</u> without leaving the mobile providers’ network. => Relative to Availibility Zone

### Management & Governance

**AWS Control Tower** 是一项服务，使您能够在 AWS Cloud 中的所有组织和账户中大规模实施和管理涉及安全性、操作和合规性的监管规则。

<u>AWS Control Tower orchestration extends the capabilities of AWS Organizations.</u> To help keep your organizations and accounts from *drift*, which is divergence from best practices, AWS Control Tower applies preventive and detective controls (guardrails). For example, you can use guardrails to help ensure that security logs and necessary cross-account access permissions are created, and not altered.

使用 AWS Control Tower，您的中央云管理员可以监控所有账户是否符合既定的全公司合规政策，您可以更轻松地遵守公司标准、满足监管要求和遵循最佳实践。

**Amazon Data Lifecycle Manager**: 您可以使用 Amazon Data Lifecycle Manager 来自动创建、保留和删除 <u>EBS 快照</u>和 EBS 支持的 <u>AMI</u>。当您执行自动快照和 AMI 管理时，它可以帮助您：

- 通过实施定期备份计划来保护重要数据。
- 创建可定期刷新的标准化 AMI。
- 按照审核员的要求或内部合规性保留备份。
- 通过删除过时的备份来降低存储成本。
- 创建将数据备份到隔离账户的灾难恢复备份策略。

**AWS Proton** allows you to deploy any <u>serverless or container-based application</u> with increased efficiency, consistency, and control. You can define infrastructure standards and effective continuous delivery pipelines for your organization. Proton breaks down the infrastructure into environment and service (“infrastructure as code” templates).  =>severless 和 container版本的Cloudformation？

1. Automated infrastructure as code provisioning and deployment of serverless and container-based applications
2. Standardized infrastructure
3. Deployments integrated with CI/CD

> CI/CD 是一种通过在应用开发阶段引入自动化来频繁向客户交付应用的方法。CI/CD 的核心概念是持续集成、持续交付和持续部署。作为一个面向开发和运营团队的解决方案，CI/CD 主要针对在集成新代码时所引发的问题。
>
> =>最初是**瀑布模型**，后来是**敏捷开发**，现在是**DevOps**，这是现代开发人员构建出色的产品的技术路线。随着DevOps的兴起，出现了**持续集成（Continuous Integration）**、**持续交付（Continuous Delivery）** 、**持续部署（Continuous Deployment）** 的新方法。传统的软件开发和交付方法正在迅速变得过时。从历史上看，在敏捷时代，大多数公司会每月，每季度，每两年甚至每年发布部署/发布软件。然而，现在，在DevOps时代，每周，每天，甚至每天多次是常态。当SaaS正在占领世界时，尤其如此，您可以轻松地动态更新应用程序，而无需强迫客户下载新组件。很多时候，他们甚至都不会意识到正在发生变化。开发团队通过软件交付流水线（Pipeline）实现自动化，以缩短交付周期，大多数团队都有自动化流程来检查代码并部署到新环境。

**AWS Health** 提供与可能影响 AWS 基础设施的活动相关的个性化信息，指导您逐步进行有计划的更改，并加快排查影响 AWS 资源和账户的问题。

=>AWS Certificate Manager automatically generates AWS Health events. 

### Developer Tools

**AWS X-Ray**是一项服务，收集您应用程序所服务的请求的相关数据，并提供用于查看、筛选和获取数据洞察力的工具，以确定您应用程序所服务的请求的相关数据，并发现优化的机会。对于任何被跟踪的向您应用程序发出的请求，您不仅可以查看请求和响应的详细信息，还可以查看您的应用程序对下游进行的调用的详细信息AWS资源、微服务、数据库和 Web API。

当用户请求通过 Amazon API Gateway API 传输到底层服务时，您可以使用 X-Ray 对用户请求进行跟踪和分析。API Gateway 支持所有 API Gateway 终端节点类型的 X-Ray 跟踪 区域、边缘优化的和私有的。您可以在提供 X-Ray 的所有AWS区域中将 X-Ray 与 Amazon API Gateway 结合使用。=>（Not only API Gateway, 几乎与所有服务都能集成，SNS，SQS，S3，EC2，Config... ）

### Analytics

**Amazon AppFlow** 是一项完全托管式 API 集成服务，您可利用它将<u>软件即服务 (SaaS)</u> 应用程序连接到 AWS 服务，并安全地传输数据。使用 Amazon AppFlow 流可以管理数据传输并实现传输的自动化，而不需要编写代码。=>Saas -> Redshift,S3

**AWS Lake Formation** 是一种完全托管服务，它让用户能够轻松地构建、保护和管理数据湖。Lake Formation 简化并自动化了创建数据湖通常所需的许多复杂的手动步骤。这些步骤包括收集、清理、移动和编目数据，以及安全地将这些数据用于分析和机器学习您可以使用 Lake Formation 来保护和提取 Amazon Simple Storage Service (Amazon S3) 数据湖中的数据。

Lake Formation 可以打破数据孤岛，将不同类型的结构化和非结构化数据合并到一个集中式存储库中。首先，找出存储在 Amazon S3 或关系数据库和 NoSQL 数据库中的现有数据，然后将数据移动到您的数据湖中。然后对数据进行抓取、编目和准备以供分析。接下来，通过用户选择的分析服务，为他们提供安全的自助数据访问权限。

**Amazon QuickSight**是一项云级商业智能 (BI) 服务，可用于交付easy-to-understand深入了解与你一起工作的人，无论他们身在何处。亚马逊QuickSight连接到云中的数据并组合来自许多不同来源的数据。在单个数据仪表板中，QuickSight可以包括 AWS 数据、第三方数据、大数据、电子表格数据、SaaS 数据、B2B 数据等。作为一项完全托管的云服务，亚马逊QuickSight提供企业级安全性、全球可用性和内置冗余。

组织中的人员每天都会做出影响业务的决策。当他们在正确的时间获得正确的信息时，他们可以做出选择，推动您的公司朝着正确的方向发展。

Here are some of the benefits of using Amazon QuickSight for <u>analytics, data visualization, and reporting</u>: ...

> 例题
>
> A company hosts a data lake on AWS. The data lake consists of data in Amazon S3 and Amazon RDS for PostgreSQL. The company needs a reporting solution that provides data visualization and includes all the data sources within the data lake. Only the company's management team should have full access to all the visualizations. The rest of the company should have only limited access.
> Which solution will meet these requirements?
>
> - A. Create an analysis in Amazon QuickSight. Connect all the data sources and create new datasets. Publish dashboards to visualize the data. Share the dashboards with the appropriate IAM roles.
> - B. Create an analysis in Amazon QuickSight. Connect all the data sources and create new datasets. Publish dashboards to visualize the data. Share the dashboards with the appropriate users and groups.
> - C. Create an AWS Glue table and crawler for the data in Amazon S3. Create an AWS Glue extract, transform, and load (ETL) job to produce reports. Publish the reports to Amazon S3. Use S3 bucket policies to limit access to the reports.
> - D. Create an AWS Glue table and crawler for the data in Amazon S3. Use Amazon Athena Federated Query to access data within Amazon RDS for PostgreSQL. Generate reports by using Amazon Athena. Publish the reports to Amazon S3. Use S3 bucket policies to limit access to the reports.

**Amazon OpenSearch Service** 是一项托管式服务，可用于轻松地部署、操作和扩展 OpenSearch（一个常用的开源搜索和分析引擎）。OpenSearch Service 还提供安全性选项、高可用性、数据持久性以及对 OpenSearch 的直接访问。

### Others

**RDS Proxy** helps you manage a large number of connections from Lambda to an RDS database by establishing a warm connection pool to the database. 

Amazon EC2 provides enhanced networking capabilities through the **Elastic Network Adapter (ENA)**. Enhanced networking provides higher bandwidth, higher packet per second (PPS) performance, and consistently lower inter-instance latencies.
An **Elastic Fabric Adapter (EFA)** is a network device that you can attach to your Amazon EC2 instance to accelerate High Performance Computing (HPC) and machine learning applications. It provides all of the functionality of an ENA, with additional OS-bypass functionality. But the OS-bypass capabilities of EFAs are not supported on Windows instances. 

**Amazon Pinpoint** 可帮助您通过发送电子邮件、SMS 和语音消息以及推送通知来与客户接洽。您可以使用 Amazon Pinpoint 发送针对性消息（如促销和客户保留活动），以及交易消息（如订单确认和密码重置消息）。
