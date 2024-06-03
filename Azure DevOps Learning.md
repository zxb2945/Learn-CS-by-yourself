# Azure Learning

AZ900=>AZ104/**AZ204**=>AZ400

# Microsoft Azure Fundamentals (AZ-900)

视频资料：[Link](https://www.youtube.com/watch?v=NPEsD6n9A_I&list=PLGjZwEtPN7j-Q59JYso3L4_yoCjj2syrM)

微软文档：[Link2](https://learn.microsoft.com/zh-cn/certifications/azure-fundamentals/)



## 20230925

### 1 Cloud Computing and Vocalbulary

Scalability

Elasticity

Agility =>偏向于CICD？云计算更为反映迅捷

...

### 2 Principle of economies of scale

### 3 CapEx vs OpEx and their differences

> 资本支出 (CapEx) 和运营支出 (OpEx)

Capital Expenditure  => Buy your own infrastructure

Operational Expenditure => pay for what you use

### 4 Consumption-based Model

### 5 laas vs Paas vs Saas



## 20231002

### 6 Public, Private & Hybrid cloud

### 7 Geographies, Regions & Availability Zones

### 8 Resources, Resource Groups & Resource Managers

你可以把Resource Groups分配到具体的IAM

 Resource Managers可以让你通过PowerShell部署一组模板

> ## Azure 订阅
>
> 订阅是 Azure 中管理、计费和缩放的一个单位。 资源组是按逻辑组织资源的方法，订阅与之类似，利用订阅可以按逻辑组织资源组并方便计费。
>
> **计费边界**：
>
> **访问控制边界**： 例如在企业中，你可对不同的部门应用不同的 Azure 订阅策略。 通过这种计费模型，可以管理和控制对特定订阅中用户预配的资源的访问。
>
> ## Azure 管理组
>
> 最后一部分是管理组。 资源会被收集到资源组中，而资源组会被收集到订阅中。 如果你刚开始使用 Azure，这样的层次结构似乎足以让所有内容保持有序。 但想象一下，如果你要处理涉及多个应用程序、多个开发团队、多个地区的问题。
>
>  Azure 管理组提供订阅上的作用域级别。 可将订阅整理到名为“管理组”的容器中，并将治理条件应用到管理组。 管理组中的所有订阅都将自动继承应用于管理组的条件，就像资源组从订阅中继承设置、资源从资源组中继承一样。 不管使用什么类型的订阅，管理组都能提供大规模的企业级管理。 管理组可以嵌套。
>
> =>描述资源组、订阅和管理组的层次结构。

### 9 Computer Services

Virtual Machines

Vitual Machine Scale Sets => Autoscaling, 仍然是laas

Container Instances(ACI)

Kebernetes Service(AKS)  => Platform as service, Autosacling

App Services => Platform as service, 比如整个Web的构建

Functions => Based on App Services， Serverless

### 10 Networking Services

Virtual Network : Network Security Groups

Load Balancer 

VPN Gateway: On-premises to azure traffic over the public internet

Application Gateway : Web traffic Load Balancer and firewall

Content Delivery Network: CDN, 用于解决各大洲之间的延迟



## 20231004

### 11 Storage Services

Blob storage including sotage tiers =>Binary Large OBject, 可以存储任何类型的数据，估计类似AWS的S3

=> Three sotage tiers: Hot ,Cool, Archive 根据访问频率来区分

File storage =>与Blob的区别就是访问协议不同  

=>Blob Container,  File Shares  : 前者就是百度云盘，后者就是扩展硬盘

Table storage => for semi structured data, no scheme =>NoSQL Database

Queue storage => Storage for messages

Disk storage => 实体硬盘，灵活连接虚拟机

Azure Storage Account就是管理所有存储种类的账户

### 12 Database Services

Cosmos DB   => NoSQL, Globally distributed

SQL Database => PaaS

Database for MySQL

Database for PostgreSQL

SQL  Managed instance => Fully managed by cloud provider

SQL Data Warehouse => For DataBase

SQL on VM => IaaS

### 13  Azure Marketplace

 可以购买第三方提供的Azure解决方案模板

### 14 Azure IoT Services

IoT Hub => Paas, 用来连接末端的控制平台，双向通信

IoT  Central => SaaS, 可以用来给末端发送版本， IoT APP Platform

Azure Sphere => Sevure end-2-end IoT Solution, 到芯片level了

### 15 Azure Big Data & Analytic Services

Azure Synapse Analytics => Pipelines 对大数据进行分析，像ETL，PaaS

Azure HDInsight => 可以合成 Kafka，Spark,Hadoop第三方平台，PaaS

Azure Databricks => only for apach Spark, PaaS



## 20231006

### 16 Azure AI & ML services 20231006

PaaS

### 17  Azure Serverless Computing Services

Azure Functions => Functions as a Service, 用Python，PowerShell自动化部署

Logic Apps => 可以连接SAP, Salasforce, 各种App结合的一个WorkFlow模板？比如你上传一个文件到Blob，接着你就可以收到邮件，  PaaS，No-Code service

Event Grid => Rounting message, Fully managed serverless event routing service

### 18 Azure DevOps Solutions

Azure DevOps : Board, Repos,Pipelines...

Azure DevTest Labs

### 19 Azure Tools

Azure Portal : Public web-based interface for management of Azure platform

Azure PowerShell: 用Poweshell 来管理Azure资源

Azure CLI：for Linux Background people, designed for automation

Azure Cloud Shell: 不像前几种那样需要预装在本地PC，直接通过browser操作 Cloud-based scripting envirqonment

### 20  Azure Advisor



## 20231206

### 21 Security Groups

Network Security Groups : Filtering controlled by rules For virtual network

Application Security Groups

### 22 User-defined Routers(UDR) with Route Table

### 23 Azure Firewall

PaaS

### 24 Azure DDoS Protection

### 25 Azure Identity Service

Azure Active Directory : **Identity and Access Management service in Azure**. Used by multiple Microsoft cloud platforms:Azure, Microsoft 365, Office 365, Onedrive and etc.

Multi-Factor Authentication(MFA)



## 20231208

### 26 Azure Security Center

### 27 Azure Key Vault

Secret,Key and Certificate Management

PaaS

Highly intergrated with other Azure service

### 28 Azure Role-based Access Control

### 29 Azure Resource Locks

Designed to prevent accidental deletion and/or modification

### 30 Azure Resource Tags

Tags are simple Name(key)-Value pairs, designed to help with organization of Azure resources



## 20231214

### 31 Azure Policy

当地的合法合规

### 32 Azure Blueprints

A buleprint is a guide, pattern or design for making something.

A buleprint definition is a collection of Azure components... Allow you to deploy those with a single press of a button.

### 33 Cloud Adoption Framework for Azure

Cloud Adoption Framework for Azure is a set of tools, best practices, guidelines and documentation to help companies with this journey.

### 34 Core tenets of Security, Privacy, Compliance

Trust Center => It's a website

Online Service Terms  => a legal document, like privacy

Data Protection Addendum

### 35 Cost Affecting Factors

resource types,

services,

locations,

ingress and egress traffic



## 20240109

### 36 Cost Reduction Methods and etc.

Cost Reduction Methods, Reservations, Hybrid benefit, Spot VM, Pricing & TCO

Azure Pricing Calculator

TCO: Total Cost of Ownership Calculator => compare datacenter versus Azure work loads

### 37 Azure Cost Management

### 38 SLA and Composite SLA in Azure

Azure Service Level Agreement: a formal agreement between a sevice provider and customer

=>Azure 保证服务质量可靠性的约定？

### 39 Service Lifecycle in Azure

Development, Public Preview and General Availabliry

=>云计算架构的开发阶段？微软自己内部开发的阶段吧





# Azure Developer Associate (AZ-204) 

[Vedio Link](https://www.google.com/search?q=Azure+204&rlz=1C1CHZN_enJP1047JP1048&oq=Azure+204&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORiABDIHCAEQABiABDIHCAIQABiABDIHCAMQABiABDIHCAQQABiABDIJCAUQABgKGIAEMgcIBhAAGIAEMgcIBxAAGIAEMgkICBAAGAoYgAQyBwgJEAAYgATSAQk4MTAyajBqMTWoAgCwAgA&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:a5a1529e,vid:jZx8PMQjobk,st:0)

## Azure Functions 20240110

What is Serverless?

Function as a Service

Storage Considerations

VSCode Extension  => **Visual Studio Code**

Runtime Stack : C#,JAVA,Python,Powershell...

WIndows vs Linux Hosting

Templates

Function Configuration => function.jsonz: Binding and Trigger



Scenarios1: HTTP => Function APP => CosmoDB

Scenarios2: Queue=> Function APP => Queue



## Virtual Machines 20240115

Network Security Group, Public IP...

Azure Compute Unit





[Vedio Link](https://www.youtube.com/watch?v=tB_tBPfQJMI&list=PLhLKc18P9YODdrbyuA52Zn9-kwboIOz2W)

## EP 01: Developing Solutions for Microsoft Azure 20240115

Develop Azure compute solutions 

Develop for Azure storage

Implement Azure security

Monitor,troubleshoot, and optimize Azure solutions

Connect to and consume Azure and third-party services

##  EP 02: Azure App Service Overview

PaaS vs PaaS vs SaaS

App Service: http base servise for **hosting web applications** and mobile back-ends

Multiple languages and frameworks: ASP.NET, Java, Python...

DevOps optimization: CICD with Azure DevOps, GitHub ...

VS code and Visual Studio

Serverless code

## EP 03: App Service Plan

> App Service Plan定义了一组计算资源（compute resource），类似于Server Farm，可以运行多个App。
>
> 当我们在Azure Portal上创建一个App Service Plan的时候，会有一系列计算资源创建出来（在你选择的region里）。所以无论何种App扔到此Plan里，都会跑在这一系列资源里。
>
> Azure App Service Plan里包含哪些东西？
> OS(Windows或者Linux操作系统)
> Region(Resource在哪个region)
> VM实例的个数
> VM实例的Size(小、中、大)
> Pricing tier，哪种配置的（for dev, production等）
> 这个决定了我们有哪些功能可以使用和如何收费
> 多种收费
> Share Compute，分为Free和Shared两个，跟其他customer的app跑在同一台vm上，每个app分配CPU额度和时间片，所有app共享shared resources，不能scale out。这个一般只用于开发和测试。  
> 这层也只有一个deployment slot。  
> 根据CPU额度（每个app分到CPU的额度或时间）
> Dedicated Compute，Basic/Standard/Premium/PremiumV2/PremiumV3。单独VM，相同Azure Service Plan下的所有app share同一组计算资源，等级越高，scale out的时候可用VM越多。  
> 这个也是根据VM收费的，无论跑了多少个app。  
> Isolated，提供最大的隔离级别，单独虚拟网络 + 单独VM + 最强scale out能力。昂，类似王思聪的电脑配置级别。  
> 根据worker数量收费。
> 以上不同等级也提供了不同的功能，比如自定义域名和证书，自动伸缩，deployment slots(部署槽？真不好翻译)。  
> 同一个app多个slots，会share同一个VM。
> ————————————————
> 版权声明：本文为CSDN博主「paul_cheung」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/beastboy/article/details/119795667

## EP 04: Demo: App Service via CLI & Portal

## EP 05: Configure & Monitor App Service

## EP 06 Autoscale Concepts 20240122

## EP 07 App Services Staging Environments

=>Staging 是对 Production的备份，随时可以替换

Automatically swaps an application to the production slot.

## EP 08 Azure Functions Overview

 Function App: Trigger and Bindings

## EP 09 Developing Azure Functions

host.json, function.json...Binding configuration, Binding-based code

Azure Functions in Visual Studio and VSCode

## EP 10 Implement Durable Functions

Write stateful functions in a stateless enviroments

Durable Functions types:Orchestrator, Activity, Entity, Client

Durable Functions is an advanced feature of Functions

Durable Function scenario: Chaining, Fan-out/Fan-in(in parallel),Monitoring

=>相对于Functions 是纯函数，Durable Functions 可以根据不同的环境变量做出不同的反应

## EP11  Azure Blob Storage 20240125

Contains : Blob

File Shares : SMB and Rest access

Queues

Tables: NoSQL



Storage account : Media => Container : Images,Vedios => Blob: jpg,png,mp4

Types of Blob: Block blobs, Append blobs, Page blobs

## EP12 Blob Sorage Lifecycle

Access tiers: Hot ,Cool, Archive

## EP13 Azure Cosmos DB Overview

relation database

Global replication, Consistency level, Low Latancy,

APIs: MongoDB APIs, Table API, SQLAPI...

Cosmos DB provides NOSQL-as-a-service for MongoDB..

> MongoDB 是由C++语言编写的，是一个基于分布式文件存储的开源数据库系统。
>
> 在高负载的情况下，添加更多的节点，可以保证服务器性能。
>
> MongoDB 旨在为WEB应用提供可扩展的高性能数据存储解决方案。
>
> MongoDB 将数据存储为一个文档，数据结构由键值(key=>value)对组成。MongoDB 文档类似于 JSON 对象。字段值可以包含其他文档，数组及文档数组。

> *MySQL*与*MongoDB*都是开源的常用数据库，但是*MySQL*是传统的关系型数据库，*MongoDB*则是非关系型数据库，也叫文档型数据库，是一种NoSQL的数据库

## EP14 Create Cosmos DB & Data Structure

## EP15 Implement IaaS Solutions

create a VM : Naming, Pricing, Storage

## EP16 Azure Virtual Machine Deep Dive 20240129

VM categories: General purpose, HPC, Storage optimized... 

High availability and disaster recovery

Image in Azure Marketplace

## EP17 Azure Resource Manager Templates

Json file that defines one or more resources

## EP18 Azure Container Instances(ACI)

Docker

Container: An instance of a Docker image

Simplest wan to run a container in Azure => 就是CICD吧，中间还有上传Repository的步骤

## EP19 Micorosoft Identity Platforms(Azure AD)

**Azure Active Directory** is microsoft's cloud-based identify and access management service .

ADAL: AD Authentication Library,   the library work with AD from code, like C#

=>Micorosoft Identity Platforms 是 AD的升级版？除了用Microsoft account之外，还可以用LinkedIn，Facebook等第三方平台

Azure AD incldes two Objects:

1. Application registration
2. Security principal: User principal , Service principal

## EP20 Microsoft graph

> Microsoft Graph 是 Microsoft 365 中通往数据和智能的网关。 它提供统一的可编程模型，可用于访问 Microsoft 365、Windows 10 和企业移动性 + 安全性中的海量数据。 利用 Microsoft Graph 中的大量数据针对与数百万名用户交互的组织和客户构建应用。

> Microsoft 365 是我们的云支持生产力平台。 通过订阅 Microsoft 365 ，可以获得：
>
> - 最新的生产力应用，例如 Microsoft Teams、Word、Excel、PowerPoint、Outlook、OneDrive 等。
> - 在电脑、Mac、平板电脑和手机上安装这些应用的能力。
> - 1 TB 的 OneDrive 云存储空间。
> - 其他任何地方都不能提供的功能更新和升级。

Office 365: Outlook, sharepoint, OneDrive, Teams, Excel, OneNote...

=>利用 graph SDK，可以对365中的自行进行编程管理

=> Azure 204 是不是就是专注于这种编程去管理 Azure呢？

## EP21 Azure Key Vault 20240213

## EP22 Azure Managed Identities

Sysyem-assgined/User-assighned

## EP23 Implement API Management

Backend API: A HTTP service that you implement with your business logic

Frontend API: A HTTP service facade hosted by API Management to obfuscate your back-end API

## EP24 Azure Event Grid

Event-driven architecture:

Consists of event producers that generate a stream of events, and event consumers that listen for the events.

## EP25 Azure Event Hubs

> Event Grids与Event Hubs之间的区别
> Event Grids不保证事件的顺序，但Event Hubs使用带有有序序列的分区，因此它可以保证同一分区中的事件顺序。 Event Hubs仅接受用于数据采集的端点，它们不提供响应机制，相对Event Grids会发送HTTP 请求通知已发生的事件

Intergration with Kafka

> ### Kafka概述
>
> 在其官网Logo上有一句话“A distributed streaming platform”，即定位为一个分布式流式处理平台。Kafka起初是由LinkIn公司开发的一个多分区、多副本且基于Zookeeper协调的分布式消息系统，于2010年贡献给Apache基金会。它以高吞吐、可持久化、可水平扩展、支持流数据处理等多特性而被广泛使用，并且已经运行在数千家公司的生产环境。
>
> Kafka拥有三个非常重要的角色特性：
> 1.消息系统。与传统的消息队列或者消息系统类似。
> 2.存储系统。可以把消息持久化到磁盘，有较好的容错性。
> 3.流式处理平台。可以在流式记录产生时就进行处理。

## EP26 Azure Service Bus 20240215

> Azure 服务总线是一个完全托管的企业消息代理，其中包含消息队列和发布订阅主题（在命名空间中）。
>
> 数据可以是任何类型的信息，包括以常用格式编码的结构化数据，例如：JSON、XML、Apache Avro 和纯文本。
>
>  服务总线是一个平台即服务 (PaaS) 产品

## EP27 Azure Queue Storage

> Azure Queue Storage 是**一个存储大量消息的存储服务**，这些消息可以在任何地方通过HTTP/HTTPS 访问。 每条消息最大64K，消息的数据量几乎不受限制(除非超出了您的Storage Account 的总容量) 。队列通常用于创建要异步处理的积压工作 (backlog)

## EP28 Azure Monitor

## EP29 Azure CDN

Content delivery networks

> **Azure CDN**（内容分发网络）：**CDN 是**服务器的分布式网络，可以有效的将Web内容传递给我们，同时**CDN** 可以将缓存的内容存储在记录我们比较近的POP（入网点位置）位置的边缘服务器，以便最大成都降低网络延迟。 **Azure** 内容分发网络(**CDN**) 可帮助减少延迟并提升高带宽内容的性能。



# Jenkins

[Jenkins自动化部署入门详细教程](https://www.cnblogs.com/wfd360/p/11314697.html)



# Power BI 20230327

# AUTORSAR 20240403

# JIRA 20240424

# Terraform 20240510

# Kubernets 20240510

# Designing and Implementing Microsoft DevOps Solutions(AZ400)

[Link](https://learn.microsoft.com/zh-cn/credentials/certifications/exams/az-400/)

## 开启 DevOps 转换之旅 20230325

- 基础结构即代码 (IaC)：实现自动执行和验证环境的创建和清理，帮助提供安全可靠的应用程序托管平台。

## 

探索理想的 DevOps 团队成员

指导团队成员实现敏捷做法

协作工具: teams

项目管理工具: 作为一个完整的 CI/CD 系统，我们有 Azure DevOps 和 GitHub

屏幕录制工具



> Azure DevOps 是 Microsoft 提供的一种软件即服务 (SaaS) 平台，它能提供用于开发和部署软件的端到端 DevOps 工具链。它还与市场上最领先的工具集成，是用来协调 DevOps 工具链的绝佳选择。

GitHub 项目和项目版块简介 => 展示了GitHub如何用于团队协作开发， 像Azure Boards一样

> 代码不存在，除非代码已提交到源代码管理中。 源代码管理是持续交付的基本支持程序。

## 

> 你可能也能想到，Git 很适合用于持续集成和持续交付环境。

=>Git 在DevOps占有重要地位



Azure Repos 是一组版本控制工具，可以用来管理代码。=>既可以用分布式git，也可以用集中式版本控制

- 使用内置 CI/CD 实现自动化：设置持续集成/持续交付 (CI/CD) 自动触发生成、测试和部署。 使用 Azure Pipelines 或你的工具包括每个完成的拉取请求。



## 面向企业 DevOps 进行开发 20240329

> Internet 上全是 Git 的分支策略；虽然这些策略没有对错之分，但完美的分支策略才适用于你的团队！

=>gits上拉分支的策略也是CICD重要的步骤...

> 我们来介绍一下我们建议的原则：
>
> - 主分支：
>   - 主分支是将任何内容发布到生产的唯一方法。
>   - 主分支应始终处于随时可用状态。
>   - 使用分支策略保护主分支。
>   - 对主分支进行的任何更改都只通过拉取请求。
>   - 用 Git 标记来标记主分支中的所有发布。
> - 功能分支：
>   - 将功能分支用于所有新功能和 bug 修复。
>   - 使用功能标志管理长时间运行的功能分支。
>   - 从功能分支到主分支的更改只通过拉请求。
>   - 命名功能以反映其用途。

> 成功合并拉取请求后，无需保留远程分支。 可以删除分支，以防他人无意中使用了旧分支。

=>确定 Git 工作流 是项目管理重要工作

> 每个人都共享一个存储库，并且使用主题分支来开发功能和隔离更改。

> 通过在代码评审中使用各种审阅者，交叉传播专业知识并传播解决问题的策略

=> 代码评审的重要性，互相交流，维护项目一致性

=> 但一般的git工具有专门的评审平台吗？

> Azure DevOps Server 现在支持搜索已删除的分支。 你可以用它来了解删除它的人员和时间。 利用该接口还可以重新创建分支。

=>Azure DevOps也有仓库存储的功能！

> 可重用性衡量现有资产（例如代码）是否可以再次使用。
>
> 如果资产具有模块化或松散耦合等特性，则更容易重用。

=>代码质量的多重衡量标准

> 技术债务累积到一定程度后，开发人员将花费几乎所有的时间来解决问题并有计划或无计划地进行返工，而不是增加价值。

> 随着时间的推移，它的增长方式与财务债务的增长方式大致相同。 技术债务的常见来源包括：
>
> - 缺少编码风格和标准。
> - 缺少单元测试案例或其设计不佳。
> - 忽略或不了解面向对象的设计原则。
> - 单体类和代码库。
> - 对技术、体系结构和方法的使用设想不佳。 （忘记了需要考虑所有系统属性，以及对维护、用户体验、可扩展性等的影响）。
> - **过度设计代码**（添加或创建不需要的代码，在现有库足够时添加自定义代码，或创建不需要的层或组件）。
> - 注释和文档不足。
> - 不编写自文档化代码（包括描述性或指示意图的类、方法和变量名称）。
> - 走捷径以按时完成任务。
> - 将死代码留在原处。

> 这意味着开发人员很容易过度保护他们的代码。 组织文化必须让所有参与者都觉得代码评审更像是分享改进代码想法的指导会议，而不是旨在发现问题并责怪作者的审讯会议。

=>git hooks 通过预置的脚本check提交的代码是否合乎规范

> Scalar 是可用于 Windows 和 macOS 的 .NET Core 应用程序。 借助适用于 Git 的工具和扩展，可让非常大的存储库最大程度地提高 Git 命令性能。 Microsoft 将其用于 Windows 和 Office 存储库。



## 使用 Azure Pipelines 和 GitHub Actions 实现 CI 20240405

> Azure Pipelines 是一种云服务，可自动生成和测试代码项目并将其提供给其他用户。 它几乎适用于任何语言或项目类型。
>
> Azure Pipelines 将持续集成 (CI) 和持续交付 (CD) 相结合，以持续且一致地测试和生成代码并将其发送到任何目标。

> 在为应用程序使用持续集成和持续交付做法之前，必须在版本控制系统中包含源代码。 Azure Pipelines 与 GitHub、GitLab、Azure Repos、Bitbucket 和 Subversion 集成。

=>Azure Pipelines 代理和池的概念还是有点抽象的... 代理服务器就是用来生成CICD管道去其他服务器上部署的？然后池就是用来管理这些代理服务器，代理服务器可以是Microsoft提供的一次性的，也可以是自托管



Azure Pipelines:就像对基础结构即代码的兴趣增加一样，人们对将管道定义为代码也有相当大的兴趣。使用 YAML 时，你基本上可以在代码（YAML 文件）中定义管道以及应用的其余代码。 使用可视化设计器时，可定义一个生成管道，用于生成和测试代码以及发布工件。

=>Azure Pipelines 是不是 Azure DevOps实现CICD的核心？



=>用 YAML 写自动化脚本



> Actions 是用于在 GitHub 环境中提供工作流自动化的机制。它们通常用于构建持续集成 (CI) 和持续部署 (CD) 解决方案。
>
> 它们在 YAML 中定义，并位于 GitHub 存储库中。Actions 在“运行程序”上执行，由 GitHub 承载或自承载。

=>这部分的功能未在GitHub上开发过，也就是Github跟Repo一样有CICD触发机制，两个选项？YAML触发的也是许多shell脚本



## 设计和实现发布策略  20240415



> 若要分离技术发布和功能发布，需要从软件本身开始。
>
> 执行此操作的常用方法是使用“功能切换”。 功能切换的最简单形式是执行或不执行特定代码段的 if 语句。
>
> 通过使 if 语句可配置，可以实现功能切换。
>
> 如果系统稳定并如往常一样运行，我们可决定切换开关。 它可能会向最终用户显示一个或多个功能，或更改系统的一组例程。
>
> 将部署与发布分开（通过开关公开功能）的整个想法令人叹服，我们希望将其纳入持续交付实践中。=> **发布:Environment 部署:Release**
>
> 它可以帮助我们提供更稳定的版本，并在我们遇到问题或新功能产生问题时提供更好的回滚方法。

=>就是先把某一个框架交付给客户，然后后续增加功能再交付？那不是仍会产生停机时间吗？

=> Azure Pipelines 中可以用 Jenkins...

=>Azure Pipelines 基本上跟 Github Action实现同样的功能

> Selenium 支持所有现代浏览器和多种语言，包括 .NET (C#) 和 Java。可以作为Azure DevOps 发布管道的一部分。

> 通过使用服务挂钩，我们可以通知其他应用程序在 Azure DevOps 中已发生事件。 我们还可以在 Microsoft Teams 或 Slack 中向团队发送消息。 我们还可以在 Bamboo 或 Jenkins 中触发操作。

> ## Jenkins
>
> Jenkins 领先的开放源代码的自动化服务器提供数百个插件，用于支持生成、部署和自动化任何项目。
>
> - 本地系统。 它们由第三方以 SaaS 提供。
> - 不属于更大的套件。
> - 行业标准，尤其是在全堆栈空间中。
> - 与几乎每个源代码管理系统集成。
> - 丰富的插件生态系统。
> - 具有部署可能性的 CI/生成工具。
> - 无发布管理功能。

## 使用 Azure Pipelines 实现安全的持续部署 20240418

> 蓝绿部署是一种通过运行两个相同的环境来减少风险和故障时间的技术。 这些环境被称为蓝色环境和绿色环境。
>
> 准备软件的新版本时，部署和最终测试阶段将发生于非活动环境中：在本例中为绿色环境。 在绿色环境中部署并全面测试软件后，请切换路由器或负载均衡器，以便传入请求进入绿色环境而非蓝色环境。
>
> 此方法可以消除由于应用部署而停机的问题。 此外，蓝绿部署可降低风险：如果新版本在绿色环境上出现意外情况，可以通过切换回蓝色环境立即回滚到上一版本。

=>awesome!  但是主要用于服务器部署吧

> 可以结合使用功能切换、流量路由和部署槽来实现金丝雀版本。
>
> - 可以将一定比例的流量路由到启用了新功能的部署槽。
> - 可以通过使用功能切换，以特定的用户群为目标。

=> 就是以一小部分用户为小白鼠

## 使用 Azure 和 DSC 管理基础结构即代码 20240425

=>结构基础及代码，使用Json作模板

> Azure CLI 是一个命令行程序，可用于连接到 Azure 并对 Azure 资源执行管理命令。

> 借助 PowerShell 工作流，IT 专业人员和开发人员可以将 Windows Workflow Foundation 的优势与 Windows PowerShell 的自动化功能和易用性完美结合。
>
> 工作流可以：
>
> - 长时间运行。
> - 一遍又一遍地重复。
> - 并行运行任务。
> - 被中断 - 可以停止、重启、暂停和恢复。
> - 在意外中断（例如网络中断或计算机/服务器重启）后继续运行。

=>就是网络服务器中的脚本，所谓的RunBook就是这个脚本所在的服务器，用于管理其它资源，可以使用Powershell也可以使用Python

> [GitHub Actions](https://docs.github.com/actions) 本质上类似于 Azure Pipelines。 它们提供了自动化软件开发和部署的方法。

## 设计和实现依赖项管理策略 20240501

**高内聚和低耦合** => 开篇怎么像设计模式

> 介绍包源、常见的公共包来源，以及如何创建和发布包。

> 在过去的几年里，打包格式经历了各种发展变化。 现在，包有几种事实上的标准格式。
>
> - **NuGet** 包（读作“new get”）是用于 .NET 代码项目的标准包。 它包括 .NET 程序集和相关文件、工具，有时仅包括元数据。 NuGet 定义包的创建、存储和使用方式。 NuGet 包实质上是一个扩展名为 `.nupkg` 的压缩文件夹结构，其中的文件采用 ZIP 格式。 另请参阅 [NuGet 简介](https://learn.microsoft.com/zh-cn/nuget/what-is-nuget)。
> - npm 包用于 JavaScript 开发。 它起源于 node.js 开发，是 node.js 开发中默认的打包格式。 npm 包是一个文件或文件夹，包含 JavaScript 文件和描述包元数据的 `package.json` 文件。 对于 node.js，包通常包含一个或多个可在使用包后加载的模块。 另请参阅[关于包和模块](https://docs.npmjs.com/about-packages-and-modules)。
> - **Maven** 用于基于 Java 的项目。 每个包都有一个描述项目元数据的项目对象模型文件，是用于定义和使用包的基本单位。
> - **PyPi**：PyPI 是 Python 包索引的缩写，原名 Cheese Shop，是 Python 的官方第三方软件存储库。
> - **Docker** 包称为映像，包含完整的自包含组件部署。 Docker 映像通常表示可以自行托管和执行而无需依赖其他映像的软件组件。 Docker 映像是分层的，可能依赖其他映像作为基础。 此类映像称为基础映像。

> 项目管理称为 `Azure Artifacts`，原名 `Package management`。 它为各种类型的软件包提供公共源和私有源。
>
> Azure Artifacts 是属于 Azure DevOps 的服务之一。 使用它便不必管理文件共享或托管专用包服务
>
> Azure Artifacts 目前支持可以存储五种不同包类型的源：
>
> - NuGet 包
> - npm 包
> - Maven
> - 通用包
> - Python

=>Azure Artifacts也是用来包管理的

> 你创建的 Azure Artifacts 源始终是私有的，不可公开使用。
>
> 你需要通过以下方式来访问它：使用有权访问 Azure DevOps 和团队项目的帐户向 Azure Artifacts 进行身份验证。
>
> 默认情况下，Azure DevOps 中的所有注册用户都可以使用源。

> GitHub Packages 是一项软件包托管服务，可用于托管包、容器和其他依赖项。 它是为 GitHub 上的软件开发提供集成权限管理和计费的中心位置。
>
> GitHub Packages 可以托管：
>
> - npm。
> - RubyGems。
> - Apache Maven。
> - Gradle。
> - Docker。
> - NuGet。
> - GitHub 的容器注册表已针对容器进行了优化，并支持 Docker 和 OCI 映像。

=>GitHub 也有相应的包管理，感觉Github就跟Azure DevOps一样的功能集成，有机会进一步探索

## 实现持续反馈 20240507

=>AZ 400 运用得不仅限于 Azure DevOps，还涉及比如 Azure Monitor等多个Azure服务。

=> 往Visual Studio中增加Application Insights机能还能观测 比如搭建起来的网站的 访问信息，集成地有点牛逼

> 使用 Azure 仪表板开发监视、使用视图设计器和 Azure Monitor 以及创建 Azure Monitor 工作簿的步骤。 同时，探索支持使用 Power BI 进行监视的工具。
>
> [Power BI](https://powerbi.microsoft.com/documentation/powerbi-service-get-started/) 有利于创建以业务为中心的仪表板和分析长期 KPI 趋势的报表。
>
> 你可以[将日志查询结果导入 Power BI 数据集](https://learn.microsoft.com/zh-cn/azure/log-analytics/log-analytics-powerbi)，以便利用其各项功能，例如合并不同来源的数据和在 Web 和移动设备上共享报表。

=> PowerBI 也被引入进来了，作用就是 Visualize Data. 但似乎不是被集成到 Azure中了， 而是以另外一个工具去分析Azure产生的log.. 但“Azure Monitor 与 Power BI 集成，以实时提供日志可视化效果。”又有这种说法...



> 团队中发生人员流动时，很容易丢失组织知识。 请务必记录此知识，以免丢失。
>
> 一个简单的示例是团队是否制定了编码标准。 应捕获知识，而非仅仅以口述形式存在。=>在 Azure 项目中创建 Wiki。
>
> Azure DevOps Wiki 是采用 Markdown 编写的，还可以包括文件附件和视频。

=> Application Insights 有点类似AI，帮你分析log定位问题

> [Application Insights](https://learn.microsoft.com/zh-cn/azure/application-insights/app-insights-overview) 可自动分析 Web 应用程序的性能，并在出现潜在问题时发出警告。 你可能恰好看到了警告，因为你收到了我们的一条智能检测通知。不需要对此功能进行任何特殊设置，只需在应用中配置 Application Insights 即可

=>收发通知很简单的开关？

=>都是以网站产品来举例的

## 实现安全性并验证代码基是否符合要求 20240509

> SQL 注入攻击属于最早、最常见和最危险的 Web 应用程序漏洞。
>
> OWASP 组织 (Open Web Application Security Project) 在其 OWASP Top 10 2017 文档中将注入列为 Web 应用程序安全性的头号威胁。

> 安全型 DevOps（或者称为 DevSecOps）

> 负责公司内使用的组件中使用的源代码意味着必须接受其风险。 关注点是源代码组件：
>
> - **低质量。** 这会影响整个解决方案的可维护性、可靠性和性能。
> - **无主动维护。** 如果不复制源代码，代码不会演变或无法更改，从而有效地从源中分离出来。
> - **包含恶意代码。** 包含和使用该代码的整个系统将遭到入侵。 整个公司的 IT 和基础结构可能会受到影响。
> - **出现安全漏洞。** 软件系统的安全性与其最薄弱的部分一样好。 将源代码与漏洞结合使用会使整个系统容易受到黑客攻击和滥用。
> - **具有不利的许可限制。** 许可证的效果可能会影响使用开放源代码软件的整个解决方案。

> [Mend](https://www.mend.io/) 是持续开源软件安全性和合规性管理的领导者。
