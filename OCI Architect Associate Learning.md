# OCI Architect Associate Learning

1. Compute: Bare Metal, Dedicated Virtual Hosts, VM, Container Engine, Functions

2. Storage: Block Volume(SSD), Local NVMe(SSD based temporary storage), File Storage(NFS, SMB), Object Storage(Unstructured), Archive Storage

3. Networking: Virtual Cloud Network(VCN), DRG(A virtual router，用于VCN与其他端点的直连), IPSec VPN和FastConnect(Private, dedicated connectivity)用于连接on-premises network，通过Service Gateway去访问OCI的公共服务如Object Storage，也有Network Security Group, Load Balancer

4. IAM: 用Policies定义Groups去访问Compartment的规则，Instance Principals, Authentication

5. Database Services: VM DB Systems, Bare Metal DB Systems, RAC(Managed High Availability), Exadata DB Systems, Autonomous Shared, Autonomous Dedicated.

=>OCI以上五大部分是最核心的服务，可见Database对于OCI的特殊



[OCI Foundations Associate](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-foundations-associate-2025-/150679)

[OCI Architect Associate](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-architect-associate-2025-/152367)  必考

[OCI Networking Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-networking-professional-2025-/153027)  

[OCI Architect Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-architect-professional-2025-/151802) 进阶补全

[OCI Developer Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-developer-professional-2025-/153341) 

[Oracle Data Platform Foundations Associate](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oracle-data-platform-foundations-associate-2025-/154414) 

[Oracle Cloud Database Service Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oracle-cloud-database-service-professional-2025-/153955)  想要挑战

[Oracle Autonomous Database Cloud Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oracle-autonomous-database-cloud-professional-2025-/153823)

[OCI Migration Architect Professional](https://mylearn.oracle.com/ou/learning-path/become-an-oci-migration-architect-professional-2025/148010)

[OCI AI Foundations Associate](https://mylearn.oracle.com/ou/learning-path/japanese-become-a-oci-ai-foundations-associate-2025-/153174) 随便看看

[OCI Generative AI Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-generative-ai-professional-2025-/153868) 随便看看

# [OCI Architect Associate](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-architect-associate-2025-/152367) 



## IAM 20260308

アーキテクチャ 20260307

**物理的側面**：Region => AD => Fault Domains

​	在一个AD有3个Fault Domains，各自有独立的机架，交换机

​	日本有 东京大阪两个Region，均是单一AD的Region

**論理的側面**：Tenancy=>Root Compartment=>Compartment

​	Compartment 隔离控制对一个资源群的访问



IAM：認証（Authentication）と認可（Authorization）

> Tenancy与Users可以理解为 “公司/账户” 和 “员工账号” 的关系

=>Microsoft Active Directory 可以成为OCI 的 IdP，但在使用 AD Bridge 时，AD 本身并不是 IdP，而只是作为用户目录源被同步到 OCI。即AD Bridge 的作用是同步用户，而不是认证。

**Defaultドメイン**の管理ユーザーは、テナンシの最初のIAMユーザーであり、自動的にAdministrators Groupに属します。

```
Tenancy
   ├─ Compartments
   │     ├─ Dev
   │     └─ Prod
   │
   ├─ Policies
   │
   └─ Identity Domains
         ├─ Users
         ├─ Groups
         └─ IdP
```

> Identity Domain可以理解为 OCI IAM 的一个逻辑隔离区域，每个 Domain 都有自己的用户、组、应用和登录策略。

=>比如，Group层级不好去控制类似MFA设置什么的，需要Identity Domains等级去控制

=>OCI中Identity Domains负责 Authentication，而Policies负责Authorization，因此Policies是属于Tenancy层级的。Policy 引用 Identity Domain 里的 Group，但不属于 Domain，去控制Compartments中的资源

=>在 OCI 中，Compartment 可以最多嵌套六层(包括 root，也就是 Tenancy）)。Policy 可以在 Tenancy 或某个特定的 Compartment 中创建，并用于授予访问该 Compartment 及其子 Compartment 中资源的权限。

```shell
#OCI Policy基本结构
Allow group <group-name> to <verb> <resource-type> in <location>
#例1
Allow group NetworkAdmins to manage virtual-network-family in compartment Network
#例2：添加条件限制 => 只允许从特定 IP 访问
Allow group Admins to manage all-resources in tenancy where request.networkSource.name = 'CorpNetwork'
```



**ネットワーク・ソース**

> Network Source 是 OCI IAM 中用于限制请求来源网络（IP / CIDR / VCN）的安全对象，通常配合 Policy 的 `where` 条件使用。如：
>
> 1. 创建一个：Network Source: OfficeNetwork，包含特定IP：203.0.113.10，203.0.113.0/24
>
> 2. 然后Policy：
>
>    ```
>    Allow group Administrators to manage all-resources in tenancy
>    where request.networkSource.name='OfficeNetwork'
>    ```



**動的グループ**

> Dynamic Group = 给“机器 / 实例”用的 Group。而普通 Group 是给 用户（User） 用的。

=>OCI Dynamic Group + Policy 的组合，在功能上相当于 AWS IAM Role。

> ```
>             OCI IAM
>                   │
>         ┌─────────┼─────────┐
>         │         │         │
>        User     Instance   Service
>      （用户）   （实例）    （云服务）
>         │         │         │
>       Group   Dynamic Group Service Principal
>         │         │         │
>         └─────────┴─────────┘
>                  │
>                Policy
>                  │
>               Resource
> ```

=>还不知道Service Principal怎么搞

> 1. 创建 Dynamic Group，取名为WebServers
>
>    ```
>    ALL {instance.compartment.id='ocid1.compartment.oc1..aaaa'}
>    ```
>
> 2. 写Policy
>
>    ```
>    Allow dynamic-group WebServers to read buckets in compartment Storage
>    ```
>
> WebServers 里的 实例 可以读取 Storage compartment 的 Object Storage。





## ネットワーキング 20260309

仮想クラウド・ネットワーク：Virtual Cloud Network



CIDRブロック・プレフィックス

サブネット

ルート表

インターネット・ゲートウェイ

> 让 VCN 中的实例 直接与互联网双向通信。

=>Internet Gateway可以理解为一个VCN的“边界路由器”。公网里的instance不是光有一个Public IP就能被外部网络访问到的，必须配这个边界路由器。

NATゲートウェイ

> 允许 Private Subnet 的实例访问互联网，但互联网无法访问它们。

サービス・ゲートウェイ



トラフィックを制御する二つの仮想ファイアウォール機能：

SL：セキュリティ・リスト（サブネットに関連付ける）

NSG：ネットワーク・セキュリティ・グループ（VNICに関連付ける）

SLとNSGの両方を同時に使用した場合、いずれかのルールがトラフィックを許可していれば、許可されます。

SL中写Ingress Rule时有选项：

​	Stateful：允许请求就自动允许返回流量  
​	Stateless：请求和返回流量都必须单独写规则

>  SL 控子网，NSG 控资源；一个管“网络”，一个管“业务”
>
>  NSG = Stateful（有状态）， Security List（SL）= Stateless（无状态）



IP管理：VNIC,Private/Public IPアドレス

各VNICはサブネットに常駐します。

Bring Your Own IP Address(BYOIP)

予約済パブリックIP：インスタンスの存続期間を超えて存在します。

パブリックIPプール

> BYOIP：把你自己公司的公网IP带到OCI使用
>
> Public IP Pool：用于管理和分配公网IP的地址池，可以是OCI提供的，也可以是BYOIP导入的。
>
> Reserved Public IP：从IP池里拿出来固定分配给资源的IP

=>DHCP 只负责分配 Private IP，与 Public IP Pool 没有关系



接続：ローカルピアリング、リモートVCNヒアリング、トランジット・ルーティング

> Transit Routing：让一个VCN充当中转路由，连接多个网络。

> DRG（Dynamic Routing Gateway）：连接 VCN 和 外部网络  
> LPG（Local Peering Gateway）：连接同一个 Region 里的两个 VCN

VCN接続性：Site-to-Site VPN, FastConnect

動的ルーティング・ゲートウェイ（DRG）の機能拡張：トランジット・ハブ(Transit Hub), ECMPサポート

BGPの基本



**ロード・バランサ**：Load Balancer

OCIフレキシブル・ロード・バランサ：Flex Load Balancer

FLB: TCP/HTTP/HTTPS  OCIリリースからある機能

NLB:TCP/UDP/ICMP　2021/3リリースの新サービス

=>FLB历史要比NLB老啊，一般说LB还是指FLB

=>LB还可以分给Public和Private

ポリシーとヘルス・チェック：Health Check

ロード・バランシング・ポリシー：ラウンドロビン、IPハッシュ、最小接続

> FLB（Flexible Load Balancer）：支持 L4 / L7，支持多种负载均衡策略，功能丰富（L7应用层）
> NLB（Network Load Balancer）：主要是 L3 / L4 转发，策略更简单，性能优先（L3/L4网络层）



DNSサービス



## コンピューター 20260310

Bare Metal, VM, Dedicated VM Hosts(DVH)

シェイプ => VM.Standard.E4.Flex 一类的

イメージ =>  Bring Your Own Image

> Shape → 硬件规格，Image → 操作系统 / 软件模板

> プリエンプティブル・インスタンス（Preemptible Instance） 是云计算中的一种 低价格但可随时被回收（中断）的计算实例。
>
> 容量予約（Capacity Reservation） 是一种机制，用来 提前预留计算资源容量，确保在需要创建实例时一定有资源可用。
>
> 専用仮想マシン・ホスト（Dedicated VM Host） 指的是一种 专用物理服务器，该服务器只供 一个租户（tenant）使用，不会与其他客户共享。

=>**OCI OCPU / vCPU 总结**

> 1. OCPU 定义
>    - 1 OCPU = 1 个物理核心（physical core）
>    - 原始物理核心本来一次只能执行 1 个线程，但利用 Intel/AMD 超线程技术 (Hyper-Threading)，每个核心可以同时处理 2 个线程
> 2. vCPU 定义
>    - vCPU = OS 可调度的 CPU
>    - 每个 vCPU 对应物理核心的一个线程
>    - OS 调度 vCPU 时，就像调度普通 CPU 一样
> 3. OCPU 与 vCPU 关系
>    - **1 OCPU → 1 核 → 2 线程 → 2 vCPU**
>    - 例如：4 OCPU VM → 4 核 → 8 vCPU
> 4. 在 OCI 选 Shape 时
>    - 显示的是 OCPU 数量
>    - OS 和应用看到的是 vCPU 数量
> 5. 应用角度理解
>    - 数据库 / 多线程应用可以利用多个 vCPU 并行执行
>    - 单线程应用最多占用 1 个 vCPU

=>均在创建instance的扩张机能选项里

> バースト可能インスタンス（Burstable Instance） 指的是一种 平时使用较低 CPU，但在短时间内可以“突发”使用更多 CPU 的虚拟机实例类型。它的设计目标是：降低成本，同时在需要时提供额外性能。
>

> インスタンス構成（Instance Configuration） / インスタンス・プール（Instance Pool） / 自動スケーリング（Autoscaling） 是一组经常一起使用的 Compute 自动扩展机制。可以理解为 模板 → 实例集合 → 自动扩容/缩容 的关系。
>
> 具体流程：
>
> 1. 创建 Instance Configuration（模板）：保存 创建 VM 的模板配置，当你需要批量创建实例时，就可以使用这个模板。
>
> 2. 创建 Instance Pool（实例组）：Instance Pool 会根据 Instance Configuration 创建多个 VM
>
> 3. 配置 Autoscaling（自动扩容）：Autoscaling 可以根据 监控指标 自动调整 Instance Pool 的实例数量。

> 垂直スケーリング是云计算中一种扩展方式，意思是：提升单个实例（VM）的资源能力，例如增加 CPU 或内存，而不是增加机器数量。在 OCI中，垂直扩展通常通过 修改实例的 Shape 或资源配置 来实现。

> Oracleクラウド・エージェント（Oracle Cloud Agent） 是运行在 VM 内部的一个 轻量级管理代理程序（agent），用于让OCI能够 管理、监控和自动化操作 Compute 实例。
>
> OS管理ハブ（OS Management Hub） 是 OCI中的一个服务，用于 集中管理云中实例的操作系统更新、补丁和软件包。它通过实例中的 Oracle Cloud Agent 插件来执行操作。

=>**tenant** 指的是 使用云服务的组织或客户, **tenancy** 指的是 该 tenant 在云平台中的逻辑隔离环境。

> Agent 的 Plugin「実行コマンド（Run Command）」 是 Oracle Cloud Agent 提供的一个功能插件，用来 远程在实例内部执行脚本或 Linux 命令，而不需要 SSH 登录。
>
> インスタンス・コンソール接続（Instance Console Connection） 是一种 直接访问 VM 控制台的方式，类似于物理服务器的 Serial Console。

=>Console Connection不依赖实例自己的网络（VCN / IP / SSH）, 但它 仍然通过 OCI 的基础设施网络访问。

=>所以Console Connection一般用来trouble shooting，一般登录仍旧是使用SSH

在 OCI 里确实有一种 安全防护增强的实例，目的是 防止篡改、恶意访问和底层固件攻击，通常称作 Shielded VM / Shielded Instance。

機密コンピューティング（Confidential Computing） 是 OCI 提供的一类 针对数据安全和隐私的增强型实例，它属于 Shielded / Confidential VM 的进阶版本，普通 VM 保护数据在 静态状态（存储卷） 和 传输中，Confidential Computing 还保护 内存中运行的数据，防止被云内部管理员或攻击者读取。

インフラストラクチャ・メンテナンス（Infrastructure Maintenance） 指的是 OCI 官方对底层硬件、网络、存储、Hypervisor 等进行定期或紧急维护的操作，目的是保证云环境稳定、安全和性能。Live Migration（实时迁移）对于支持实时迁移的 VM（大部分标准 VM），OCI 会把实例从维护中的宿主机迁移到健康宿主机。实例几乎无停机，用户感受不到。

=>还有 reboot Migration，Mannual Migration，共3种

## ストレージ 20260318

**オブジェクト・ストレージ 20260312**

=> OCI Object Storage ≈ AWS S3

```
Namespace    每个 Tenancy 只能有一个 Namespace，Namespace = 租户的 Object Storage 总空间
   └─ Bucket   Bucket 是存放 Object 的容器，类似 文件夹
        └─ Object   Object 就是实际存储的文件
```

> OCI Object Storage 的3种 Tier：OCI Object Storage 的 Tier，Infrequent Access，Archive
>
> マルチパート・アップロード（Multipart Upload） 是一种 把大文件分成多个部分并行上传的机制。
>
> 自動階層化(Auto-tiering) = 根据使用频率自动调整存储层级，节约成本
>
> ライフサイクル管理（Lifecycle Management）= 自动管理对象的存储和删除策略
>
> プリケーション（Replication）= 把对象自动复制到其他Region/Availability Domain，防止数据丢失
>
> バージョニング = 同一个对象保留多个历史版本
>
> 保持（Retention）ルール 是指 为对象设置最短保留期限，在此期间对象不能被删除或覆盖 的策略。
>
> オブジェクトのコピー（Object Copy） 是指 将一个对象复制到同一 Bucket、另一个 Bucket，甚至跨 Region 的目标 Bucket，用于 备份、迁移或数据共享。
>
> ロギング（Logging） 是指 对 Bucket 中的对象访问操作（PUT、GET、DELETE 等）进行记录和跟踪 的功能，用于安全审计、访问分析或合规管理。
>
> アクセス認証の管理（Access Authentication Management） 是指 管理谁可以访问对象、以什么方式访问，以及如何验证身份。它是 安全控制的第一道防线。



**ブロック・ストレージ 20260312**

> ブロック・ストレージ（Block Storage） 是一种 基于块（block）的持久化存储服务，类似传统服务器的硬盘（HDD/SSD），可挂载到 OCI 的 Compute 实例（虚拟机） 使用。
>
> - Block Storage = 块存储这个概念（硬盘存储类型）
> - Block Volume Service = OCI 提供的具体服务，你通过它创建和管理块存储卷
>
> 所以 你要用块存储，一定要通过 Block Volume Service 来实现。
>
> ブート・ボリューム（Boot Volume） 是指 用于启动 Compute 实例的块存储卷，类似虚拟机的系统盘（OS Disk）。它包含操作系统以及实例启动所需的系统文件。
>
> =>Boot Volume 并不是你手动单独创建的，而是 在创建实例（Compute Instance）时自动生成的块存储卷。
>
> 動的パフォーマンス・スケーリング（Dynamic Performance Scaling） 是 OCI Block Volume（块存储） 的一个性能功能，用来 根据负载自动调整存储性能（IOPS / Throughput）
>
>  OCI Block Volume 的一个成本优化功能：デタッチ済ボリューム自動チューニング（Detached Volume Auto-tuning）。它的作用是 当卷没有挂载到实例时自动降低性能等级，从而减少费用。

20260317:

> OCI 通过 Backup Policy 为 Block Volume 设置自动备份计划，可以定义备份频率、保留时间以及跨 Region 复制，实现自动化数据保护
>
> Volume のクローン（Volume Clone） 指的是：把一个现有的 Block Volume 复制成一个新的 Volume，并且数据完全相同。
>
> Backup 和 Clone 的区别：
>
> |                | Backup         | Clone         |
> | -------------- | -------------- | ------------- |
> | 速度           | 慢             | 很快          |
> | 存储位置       | Object Storage | Block Storage |
> | 是否可直接使用 | 不可以         | 可以          |
> | 是否跨 Region  | 可以           | 不可以        |
> | 主要用途       | 灾备           | 快速复制      |
>
> クロス・リージョン・ボリューム・レプリケーション 是在OCI 中 持续将 Volume 数据复制到另一个 Region 用于快速灾备，而 Backup 是 定期把 Volume 数据保存到 OCI Object Storage 用于长期数据保护，需要 restore 才能使用。
>
> ボリューム・グループ（Volume Group） 指的是：把多个 Block Volume 组合成一个逻辑组，以便对它们进行统一的备份或恢复。
>
> Cross-AD Replication = 同一 Region 内，不同 AD 之间的 Volume 复制，用于提高高可用性。
>
> =>Block Volume 在 Availability Domain 内部默认已经做了多副本冗余（跨 Fault Domain 的复制），因此用户不需要配置 Cross-AD replication；而 Cross-Region Replication 是用户可以在 Console 中 主动开启的复制功能。

**ファイル・ストレージ 20260318**

> ファイル・ストレージ是一个基于 NFS 的托管共享文件系统，支持多个计算实例同时访问同一数据。
>
> ```
>             Mount Target（一个就够）
>                  10.0.0.6
>                      │
>      ┌───────────────┼───────────────┐
>      │               │               │
> Export A        Export B        Export C
>      │               │               │
> FS1              FS2              FS3
> ```
>
> Mount Target 是位于 VCN 子网中的 NFS 访问入口，可以被多个文件系统共享，每个文件系统通过创建 Export 来暴露访问路径。Mount Target 是“门”，**Export 是“门禁规则”，决定谁能进、怎么进。**=>算是在IAM，SL/NSG之外加了层Security
>
> Snapshot 是某一时间点的数据只读备份，用于数据保护和恢复；而 Clone 是基于现有数据创建的可读写副本，可以直接用于业务或测试环境。Clone 通常基于 Snapshot 实现，并采用写时复制机制以提高创建速度。
>
> ファイルシステム・レプリケーション（File System Replication）是一种异步跨 Region 数据复制机制，用于将源文件系统的数据持续复制到目标文件系统，以实现灾难恢复。目标文件系统通常为只读，需要在故障切换时才能提供写入能力。



# [OCI Architect Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-architect-professional-2025-/151802) 

## ソリューション設計 20260323

セキュリティ

OCIマルチクラウド：

在Azure Region中使用的Oracle Database@Azure 可以利用 OCI Region中的Object Storage来做Automatic backup, 也可以利用OCI Vault服务管理密钥，Data Guard的 做灾备（主备复制），这就是所谓的マルチクラウド?

> Oracle Database@Azure 本质是：Oracle把OCI的数据库服务“部署到Azure数据中心里”

DR：災害復旧　　＝＞目標復旧時点RPOと目標復旧時間

> OCI Full Stack Disaster Recovery（全栈灾难恢复）可以帮你把“整个系统（应用 + 数据库 + 网络 +计算资源）”在另一个Region或AD中一键切换恢复，而不仅仅是单个资源。

HA：高可用性

## クラウド・ネイティブ・ソリューション 20260324

マイクロサービス

コンテナ化

**Oracle Cloud Infrastructure Registry**

> OCIR 就是 OCI 里的私有 Docker 镜像仓库，用于存储、管理、分发容器镜像，并和 Kubernetes / CICD 深度集成。
>
> OCIR = OCI里的 Docker Hub（但更安全、企业级）
>
> Repository（仓库）= 放镜像的“文件夹”
> Image（镜像）= 实际的“内容（版本）”

**OCI Container Instance**

>  OCI Container Instance 是一种无需管理服务器或 Kubernetes，就可以直接运行容器的托管服务。
>
> =>内部使用 container runtime（比如 containerd）来直接创建运行容器

=>可以把OCI Container Instance当成你没法直接控制用于专门创建container的VM

> Container Instance 的真正定位更接近Serverless Container（无服务器容器），类似AWS Fargate, Azure Container Instances
>
> 一个成熟云架构通常是这样的：
>
> ```
> 核心微服务        → Kubernetes（OKE）
> 批处理 / 临时任务 → Container Instance
> 函数逻辑          → Functions
> ```
>
> Container Instance 不适合复杂云原生系统，但在“简单、临时、无需集群”的场景中非常有价值。比如 批处理 / 一次性任务，CI/CD 临时执行

**OKE** 20260329

Container Engine for Kubernetes

Cluster = 一整套 Kubernetes 运行环境

Virtual Kubelet 是一个让 Kubernetes 可以把 Pod 调度到外部（如 serverless的OCI Container Instance 或其他平台）运行的“虚拟节点适配器”。

kubeconfig 是一个用于连接和认证 Kubernetes 集群的配置文件。文件默认位置 `~/.kube/config`, kubectl 默认读这个文件

**OCI DevOps**

CICD

**Oracle Function**

OCI Functions = OCI 上的 AWS Lambda

service

**API Gateway** 20260330

 API Gateway = 把后端服务统一对外暴露，并负责安全、路由和流量控制的入口服务

```
客户端（用户 / 前端 / 系统）
          ↓
     API Gateway
          ↓
 后端服务（Functions / OKE / VM / LB）
```

API Gateway的认证授权体系： OAuth + JWT

```
用户登录（OAuth）=> OAuth 2.0 = 让你通过“第三方授权服务器”获取 token，从而访问资源
      ↓
获取 JWT Token  =>OAuth 获取的 Access Token 通常就是 JWT:  Json Web Token
      ↓
调用 API Gateway（带 token）
      ↓
① 验证 token（认证）
② 检查权限（授权）
      ↓
转发到后端服务
```

```
你 → 网站 → Google（登录授权） => OAuth 是授权框架，JWT 是令牌格式（既可用于认证信息，也可用于授权信息）
                 ↓
            返回 Access Token
                 ↓
        网站用这个 token 获取你的信息
```

OAuth 负责“发 token”，JWT 负责“装信息”，认证和授权是系统用它们实现的功能

OAuth 是规则，不是工具；是流程规范，不是代码框架

API Gateway 可以用 NSG 控制访问

API Gateway 支持mTLS

**ストリーミング（Streaming）** OSS

Streaming = 实时数据管道（持续流动的数据，而不是一次性数据）

 普通 API：一次请求 → 一次响应， Streaming：数据不断产生 → 不断处理

```
数据源（日志 / 事件 / IoT）
        ↓（持续不断）
   Streaming 服务
        ↓
消费者（应用 / 分析系统 / Function）
```

OCI Streaming ≈ AWS Kinesis， 类似于 Apache **Kafka** 的托管服务

```
Logging → Service Connector Hub → Streaming → Function
```

**Service Connector Hub**是OCI提供的无代码 / 低代码的数据集成与流转服务，在 OCI 内自动把数据从一个服务传到另一个服务的“数据管道”，类似AWS Kinesis Data Firehose

**Events Service**

 Events Service是一个 事件驱动（Event-driven）服务，用于监听资源变化并触发后续处理

```
OCI资源变化（事件发生）
        ↓
Events Service 捕获
        ↓
匹配规则（Rule）
        ↓
触发 Action（目标服务）
```

类似 Amazon EventBridge 

## Infrastucture as Code(IaC) 20260624

核心就是用**Terraform**

| 项目              | 说明                                                         |
| ----------------- | ------------------------------------------------------------ |
| Terraform Command | 用于操作 Terraform 的 CLI 命令，例如 `terraform init`、`terraform plan`、`terraform apply`、`terraform destroy` 等。 |
| Provider          | Terraform 与外部平台交互的插件。例如 OCI Provider、AWS Provider、Azure Provider。Provider 定义 Terraform 如何调用对应云服务的 API。 |
| Resources         | Terraform 管理的实际基础设施对象，例如 OCI Compute Instance、VCN、Load Balancer、OKE Cluster 等。 |
| Variables         | 用于参数化 Terraform 配置，使代码更灵活、可复用。例如定义实例形状、CIDR、区域等。 |
| Outputs           | Terraform 执行完成后输出的结果，例如实例 IP 地址、OCID、负载均衡器地址等。 |
| Modules           | Terraform 配置的可复用组件。可以将一组资源封装成模块，在多个项目中重复使用。 |
| State             | Terraform 用来记录当前基础设施状态的文件（通常是 `terraform.tfstate`）。Terraform 通过 State 对比实际环境与配置文件的差异，并决定需要创建、修改或删除哪些资源。 |

1.Terraform Command

用于操作 Terraform 的 CLI 命令，例如 `terraform init`、`terraform plan`、`terraform apply`、`terraform destroy` 等。

=>进入 Terraform 配置所在目录后执行 `terraform plan/apply/destroy` 即可, Terraform 会先读取所有 `.tf` 文件，构建一个资源依赖图，然后根据依赖关系执行。

实际工作中，最常见的命令顺序如下：

```
编写 main.tf
      │
      ▼
terraform fmt   =>整理格式
      │
      ▼
terraform init（首次或依赖变化时）  =>下载 Provider，创建 .terraform/ 目录...
      │
      ▼
terraform validate   =>检查配置是否正确
      │
      ▼
terraform plan  => 查看 Terraform 将做什么, 例如：Plan: 2 to add, 1 to change, 0 to destroy.
      │
      ▼
确认变更
      │
      ▼
terraform apply
      │
      ▼
terraform output（查看输出）
      │
      ▼
完成部署
```

=>进入Oracle Cloud Shell, 直接可以使用Terraform命令，比如用以下main.tf创建vcn

```
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  auth = "InstancePrincipal"
}

resource "oci_core_vcn" "test_vcn" {
  compartment_id = "ocid1.tenancy.xxx"
  display_name   = "terraform-test-vcn"
  cidr_blocks    = ["10.0.0.0/16"]
}
```

2.Provider 

Terraform 通过 Provider 与 OCI 进行交互。Provider 相当于 Terraform 与 OCI 之间的适配层，负责将 Terraform 配置转换为 OCI API 调用。

=>Provider 负责定义 Terraform Resource 的类型（Resource Type）和 Schema（例如哪些字段必填、哪些字段可选、哪些字段只读）。当 Terraform 执行时，Provider 会接收用户在 Resource 中配置的数据，对其进行校验和解析，然后组装成对应的 SDK 请求对象，通过 OCI SDK 调用后端 REST API，最终由 OCI Service 执行实际操作。执行结果返回后，Provider 再将资源状态和属性返回给 Terraform，并写入 State。

```
resource "oci_xxx" {
    ...
}
        │
        ▼
Terraform Core
        │
        ▼
OCI Provider
  ├─ Resource Type 定义
  ├─ Schema 校验
  ├─ CRUD 实现
  └─ 请求参数组装
        │
        ▼
OCI SDK
        │
        ▼
REST API
        │
        ▼
OCI Service
        │
        ▼
Result
        │
        ▼
OCI Provider
        │
        ▼
Terraform State
```

3.Resources

HCL语言：

```hcl
resource "oci_core_instance" "vm" {

  compartment_id = var.compartment_ocid

  availability_domain = "Uocm:PHX-AD-1"

  display_name = "demo-vm"

  shape = "VM.Standard.E4.Flex"

}
```

| 部分                  | 含义                                  |
| --------------------- | ------------------------------------- |
| `resource`            | Terraform Resource                    |
| `oci_core_instance`   | Resource Type（OCI Compute Instance） |
| `vm`                  | Terraform 内部名称（Logical Name）    |
| `compartment_id`      | Resource 属性                         |
| `availability_domain` | Resource 属性                         |
| `display_name`        | Resource 属性                         |
| `shape`               | Resource 属性                         |

=>Resource Type与Resource 属性需要Provider 提前定义

4.Variables 

=>Variables 用于定义输入参数。通常在 `.tf` 文件（如 `variables.tf`）中声明，在 `.tfvars` 文件中赋值，并通过 `var.xxx` 的方式在 Resource 中引用，从而使同一套 Terraform 代码能够适用于不同客户、不同环境以及不同配置场景，提高代码的复用性和可维护性。

```
variables.tf
    ↓
定义变量

terraform.tfvars
    ↓
赋值

main.tf
    ↓
resource 使用 var.xxx
```

5.Outputs

=>Terraform 的 Outputs（`output`）主要作用是将 Terraform 配置中的某些值暴露出来，供外部或其他模块使用.

```
=>暴露instance_id,像"aws_instance.web.id"中最后的id这个attribute是由provider定义的
output "instance_id" {
  value = aws_instance.web.id
}


=>供外部或其他模块使用
resource "aws_eip" "web_ip" {
  instance = module.web.instance_id
}
```





**Resource Manager**是OCI提供的一个托管 Terraform 服务。把 Terraform 执行环境 + state 管理 + 凭证 全部托管在 OCI 里，你就不要安装 Terraform，理 state 文件，配 API key

```
Stack        = Terraform代码
Job          = 执行（plan/apply）
Template     = 模板库
CSP          = Git连接
Private EP   = 内网访问能力
```

## データベースの設計実装運用 20260402

Oracle Base Database Service

Exadata Database Service

Autonomous Database



OCI Console Menu:

```
Oracle AI Database → Oracle DB（核心数据库）
│
├── Autonomous（自动化）
│   ├── Serverless
│   ├── Dedicated(专属硬件版)
│   └── Global Distributed(全球分布式)
│
├── Exadata（高性能）
│   ├── Dedicated
│   ├── Exascale（弹性更强）
│   └── Cloud@Customer(Exadata 放在客户机房)
│
├── Base DB（传统）
│   └── VM / Bare Metal / RAC : 
│
└── 扩展能力
    ├── External DB : 管理“非 OCI 上的数据库”,统一监控
    └── Multicloud : 多云集成,跨云访问数据库
    
Databases → 开源 + 数据生态服务
│
├── MySQL HeatWave（增强MySQL）: 基于MySQL,Oracle 自研HeatWave
│   ├── DB Systems
│   ├── Backups / Channels
│
├── PostgreSQL（开源DB）
│
├── NoSQL（键值/文档）: 类似 DynamoDB
│
├── OpenSearch（搜索/日志）
│
└── Cache（Redis）    
    
```



**Oracle Base Database Service** 20260402

Base Database是一整套数据库运行环境, 因此创建时要选择像instance那样的Shape和Storage

```
Base Database Service
│
├── VM / Bare Metal（计算）
├── Storage（磁盘/ASM）
├── OS（Oracle Linux）
└── Oracle Database（数据库软件）
```

=> Base Database最普通的Shape是4OCPU 64GB RAM，即四核八线程，但我的HP笔记本是16核22线程 16GB RAM，可见处理性能上Base Database用的Shape也没见得很强，倒是RAM管够，加上高网络带宽适合跑大规模缓存

Storage中要选择 如何管理数据库存储

1. Oracle Grid Infrastructure： Oracle 自家的存储管理方案，主要组件是 **Oracle ASM (Automatic Storage Management)**，它可以自动管理磁盘、做条带化 (striping)、冗余 (mirroring) 等，对于 RAC / 高可用数据库 必须使用 ASM

   ```
   ASM Disk Group
        │
    ┌───┼────┐
    Disk1 Disk2 Disk3  <-- 每个 Disk 对应一个 OCI Block Storage Volume，底层物理存储硬件以SSD为主
   ```

2.  Logical Volume Manager ：LVM 是 Linux 系统自带的逻辑卷管理工具，部署简单，适合快速搭建数据库实验环境



RAC(**Oracle Real Application Clusters**) = 多台服务器共同运行同一个数据库（共享数据），实现高可用 + 高性能

```
Client
  │
  ▼
+------------------+
| SCAN / Listener  | <-- 单一访问入口
+------------------+
     │    │
     ▼    ▼
  Node1    Node2     => 最少需要2 个节点，理论上可以到几十个节点，节点可以是物理机或虚拟机
  (DB Instance)      => 高可用 + 并发 + 扩展性
     │    │
     ▼    ▼
+------------------+
|  Shared Storage  |  => 所有节点共享 同一套存储（通常是 ASM 或共享存储）
|   (ASM / LVM)    |
+------------------+
```

单节点数据库叫 单实例 (Single Instance Database)，不是 RAC

但别误以为：选了 Grid Infrastructure = 一定是 RAC，再选择Node=2 → 才是 RAC





Backup Destination:

1. Object Storage 模式:  DB → RMAN → Object Storage（你来管理策略）
2. Autonomous Recovery Service: DB → Recovery Service → 自动优化 + 存储(Oracle 帮你管一切）

> Autonomous Recovery Service解决了传统痛点：
>
> - backup policy 要自己设
> - retention 要自己管
> - restore 流程复杂
> - backup 可能失败你都不知道



**Autonomous Database** 20260404

Autonomous AI Database – Workload Type 对比表

| Workload Type | Workload Type                     | 类型           | 核心用途        | 典型操作                 | 性能特点                  | 典型场景                 |
| ------------- | --------------------------------- | -------------- | --------------- | ------------------------ | ------------------------- | ------------------------ |
| ADW           | Autonomous Data Warehouse         | OLAP           | 数据分析 / 数仓 | 大量 SELECT              | 并行查询、列存优化        | BI报表、数据分析、ETL    |
| ATP           | Autonomous Transaction Processing | OLTP           | 事务处理        | INSERT / UPDATE / DELETE | 低延迟、高并发            | 电商、订单系统、电信业务 |
| JSON          | JSON Database                     | NoSQL / 文档型 | JSON 数据处理   | JSON 查询 / API          | 灵活 schema、文档存储优化 | 微服务、API 后端         |
| APEX          | Application Development           | 低代码平台     | 快速开发应用    | Web App 开发             | 内置开发框架              | 内部系统、管理工具       |

 OLTP(Online Transaction Processing) 用于高并发、低延迟的日常事务处理（以增删改为主），而 OLAP(Online Analytical Processing) 用于对海量历史数据进行复杂查询和分析（以读取和聚合为主）

Shared 是多租户、类似 serverless 的共享环境；Dedicated 是单租户、资源独占的高性能环境；**Exadata Cloud@Customer 是部署在本地机房但由 Oracle Corporation 托管的云数据库环境**

=> Oracle Autonomous AI Database 底层统一运行在 Oracle Exadata 上（不论 Shared 还是 Dedicated）

> Base Database = 普通云数据库（VM级）
> Exadata Database Service = 高端专用数据库平台
> Autonomous Database = 在 Exadata 上的全自动数据库服务
>
> ```
>                 Autonomous Database
>                         ↑
>         （自动化数据库服务，跑在 Exadata 上）
>                         ↑
>         Exadata Database Service
>         （高性能基础设施 + 你自己管 DB）
>                         ↑
>         Base Database Service
>         （普通 VM 数据库）
> ```
>
>  区别本质只有两个：1. 跑在哪里？2.谁来管数据库？









スケーリング

クローニング

> ADB 三种克隆
>
> 1. Full Clone  完整复制数据库（结构 + 数据），独立且可读写。后续和源库没有关系
> 2. Metadata Clone 只复制结构（schema），不包含数据。 生成一个“空壳数据库”，用于快速建环境（特别适合 CI/CD）
> 3. Refreshable Clone 只读副本，可以从源库同步更新。 常用于报表/分析

バックアップとリカバリ、リストア

パッチ適用および更新

　　RU　＝＞　リリース・アップデート



**ADBのAutonomous Data Guard**  => AuDG  20260408

Autonomous Data Guard = 自动化的主备数据库 + 自动切换 + 零运维。系统会自动帮你：创建 Primary（主库） + Standby（备库），实时同步数据（Redo Apply），在故障时自动切换（Failover），和普通 Data Guard 的区别就是 全部自动化（无需 DBA(Database Administrator) 操作）

=> Standby 可读, 可以用来：报表查询,BI分析, 减轻 Primary 压力

=>Physical Standby 可以转化为  Snapshot Standby，Snapshot Standby 是一个临时可读写的 Standby，在此期间暂停与 Primary 的同步且无法用于故障切换，但可随时恢复为同步状态。**本质是拿 DR 资源临时做测试**

**RTO 和 RPO** 是灾难恢复（DR）里两个最核心的指标：

```
RTO（Recovery Time Objective）=> 多久能恢复服务
RPO（Recovery Point Objective） => 最多能丢多少数据

时间轴：
09:50 ---- 09:55 ---- 10:00(故障) ---- 10:30(恢复)

RPO = 5分钟 → 回到 09:55
RTO = 30分钟 → 10:30恢复
```

> Autonomous Exadata Infrastructure = 物理 Exadata 资源（底层硬件）
> Autonomous Exadata VM Cluster = 在上面创建的数据库运行环境
>
> ```
> Autonomous Exadata Infrastructure（硬件）
>    └── Autonomous Exadata VM Cluster （虚拟集群）
>          └── Autonomous Database（ADB）
> ```



Autonomous Database - バックアップ・ベースのディザスタ・リカバリ（**Backup-based DR**）是OCI中基于备份实现灾难恢复的一种方案，通常作为 Autonomous Data Guard（ADG）的低成本替代方案。

```
Primary ADB（东京）
   ↓（自动备份）
Object Storage（备份）
   ↓（跨Region复制）
Object Storage（大阪/新加坡）

   ↓（需要时）
新建 ADB（恢复）
```

=>在 ADB 控制台的 DR 选项卡中，有一个“添加 Peer Database”的按钮，点击后可以选择 Autonomous Data Guard（ADG）或 Backup-based DR 两种方式。

=>ADB console中 Backup 里的备份默认只在本 Region 使用（恢复)，DR（Backup-based DR）里的 backup= 同样的备份 + 跨 Region 复制机制，即同一份 backup，在 DR 中被“扩展使用”（跨 Region）

Autonomous Recovery Service（**ARS**） 是 Oracle 提供的全自动备份与恢复服务，通过持续接收 redo 日志，实现接近零数据丢失，并支持快速时间点恢复。。在 ADB 里：ARS 是默认启用、自动工作的

Data Guard 防“宕机”(高可用)，ARS 防“数据丢失”(做数据恢复)

=>ADB console中 Backup就是ARS的可视化入口，Backups 页面展示的所有备份，其实都是 ARS 创建和管理的。但除了这些Backup上可看见的Full Backup与Incremental Backup， ARS背后还持续接收 redo，支持Point-in-Time Recovery



**Globally Distributed ADB** 20260409

```
Globally Distributed ADB
│
├── Shard A（部分数据）
│     ├── Raft Replication（Region 内，多副本强一致 HA）
│     └── Data Guard（跨 Region 的 Standby，用于 DR）
│
├── Shard B（另一部分数据）
│     ├── Raft Replication
│     └── Data Guard
```

Globally Distributed ADB = 把一个数据库拆分到多个地区（Region），实现全球低延迟 + 高可用

依赖两大核心技术：Shard（分片）+ Raft Replication（一致性复制）

Shard = 数据分片（横向拆分数据库）,  把一个数据库拆成多个“小数据库”：比如 Shard 1 → 日本用户，Shard 2 → 美国用户。每个 Shard：是一个独立的数据库（通常一个ADB实例），存储一部分数据（按 key 分布），数据通过 Sharding Key 决定去哪一个 shard。**Shard 是把数据横向拆分到多个数据库节点，实现扩展性和低延迟。**

Raft Replication是基于 Raft Consensus Algorithm 的复制机制。 每个 Shard 有多个node，这些node通过 Raft 保持一致。**Raft Replication 是保证每个 shard 内部数据一致和高可用的复制机制。**

Data Guard（Shard-level replication）整个数据库（一个 shard），用于灾难恢复（DR），而Raft（Chunk / Replica Set level）复制对象：更细粒度的数据块 / 日志，用于高可用 + 一致性（HA）



OCI Cache 就是 Oracle 云上的 Redis，用来缓存热点数据，提高性能、减少数据库压力。

OpenSearch 是一个分布式搜索和日志分析引擎，用于实现全文搜索、日志分析和实时监控，不用于替代数据库。

```
用户请求
   ↓
OCI Cache（Redis）→ 加速
   ↓
ADB（结构化数据）
   ↓
OpenSearch（搜索 / 日志分析）
```





## セキュリティ・ソリューションの設計 20260410

**OCI要塞(Bastion)サービス**

云上的“跳板机（Jump Server）”，但更加安全、托管化。

=>SSH 公钥就像公司门禁系统里登记的“指纹模板”，而私钥就像你本人独一无二的真实指纹，用来验证身份并实现无密码登录。

=>本地生成 公钥与私钥，公钥就上传到服务器，本地用私钥去SSH连接



**OCI Zero Trust Packet Routing** (ZPR)是一种基于身份和策略的网络控制机制，用来替代传统“基于 IP/端口”的访问控制。=> 其设计理念与 IAM Policy 类似。

=>在考虑某个应用是否可以访问某个数据库时，通常会先想到使用 OCI 的 Dynamic Group + IAM Policy 进行控制。确实，可以通过 Dynamic Group 来定义应用实例，并通过 Policy 控制其调用创建或管理数据库等 API 的权限，但这些都属于 Control Plane 层面的操作。然而，对于 Data Plane 中应用到数据库的实际网络流量是否能够通信，IAM 是无法控制的，仍然需要依赖 NSG 或 Security List 等传统网络访问控制机制。此时，ZPR 的优势就体现出来了，它可以在数据平面基于身份对访问进行精细化控制。



**OCI Network Firewall** 基于 Palo Alto Networks 的下一代防火墙（NGFW）技术构建，由 Oracle 提供全托管的云原生安全服务，实现应用层和内容级别的流量检测与控制。

OCI Network Firewall = 云原生平台（Oracle）\+ NGFW安全能力（Palo Alto）

> NGFW（下一代防火墙）相比传统防火墙，从“只看 IP/端口”升级为“识别应用 + 分析内容 + 防御攻击”。传统防火墙（L3/L4）基于：IP + Port + Protocol，看不出 443 是：正常 HTTPS，还是恶意流量，无法检测攻击（SQL 注入、漏洞利用等。而NGFW 的核心优势： 应用层识别（Application Awareness）

> IPS / IDS（入侵检测/防护）:  IDS 用于检测和告警潜在攻击行为（比如SQL 注入攻击，恶意扫描，异常流量），而 IPS 在此基础上进一步对恶意流量进行实时拦截和防护，两者分别对应“可见性”和“主动防御”。
>
> IDS = 摄像头（看到问题）, IPS = 保安（直接拦人）



**OCI証明書サービス**（OCI Certificates Service） 是OCI中提供的一项托管证书管理服务，主要用于安全地创建、存储、部署和自动轮换 TLS/SSL 证书。

```
场景1：Load Balancer HTTPS
Client → HTTPS → OCI Load Balancer → Backend
                ↑
        Certificate Service 提供证书
        
场景2：mTLS（微服务安全）
Service A ←→ Service B
   ↑             ↑
   证书         证书
     \         /
   Private CA (OCI)
```

TLS介绍：

> TLS 用“**非对称加密**”完成握手和密钥交换，用“**对称加密**”完成后续的数据传输。
>
> 🔹 1. Handshake（握手阶段）
>
> - 协商加密算法
> - 验证身份
> - 生成会话密钥
>
> 简化流程：
>
> 1. Client Hello
> 2. Server Hello
> 3. Server 返回证书
> 4. Client 验证证书
> 5. 生成共享密钥（Key Exchange）  => 共享密钥从不在网络中以明文传输，而是由双方根据各自的私有随机数 + 对方的公开参数独立计算出来的。
> 6. 建立安全连接
>
> ------
>
> 🔹 2. Data Transfer（数据传输）
>
> 👉 用握手生成的对称密钥加密通信
>
> 原因：对称加密更快

SSH 也是“非对称 + 对称”的组合，但它不依赖 CA 证书体系，而是使用主机密钥（Host Key）和密钥交换算法来建立信任。



**OCI Webアプリケーション・ファイアウォール**(WAF) 

> OCI WAF（Web Application Firewall） 是运行在 Layer 7（应用层） 的安全服务，主要用于：
>
> - 保护 HTTP / HTTPS 流量
> - 防御 Web 攻击（如 SQL 注入、XSS）
> - 控制访问策略（IP、地理位置等）
> - 提供可视化监控与日志

核心功能: 攻击防护，Access Control（访问控制）， Rate Limiting（限流），基础 Bot 防护(检测异常流量模式)，TLS / SSL 终止， Logging & Monitoring

WAF 通常绑定在：Load Balancer，Public endpoint（公网入口）

=> Console创建Load Balancer，接着创建WAF Policy，其中选项去绑定某个Load Balancer

=>NGFW 虽然具备一定的 Application Awareness，但在未开启 SSL inspection 的情况下无法直接解密 HTTPS 流量，因此通常只能基于流量特征（如 IP、端口、SNI 等）对应用类型进行推测；而 WAF 通常作为反向代理部署，在 TLS 终止后可以获取明文 HTTP 内容，从而对应用层请求进行更精确的安全检测。

WAF Policy = 一组规则集合（防攻击 + 控访问 + 限流 + 定源站）

```
WAF Policy
 ├── Protection Rules（防攻击）
 ├── Access Rules（放行/阻断）
 ├── Rate Limiting（防刷）
 ├── Caching（性能优化）
 ├── Origin（后端定义）
 └── Logging（审计）
```

WAF = 默认有一套“开箱即用的安全能力”，同时允许用户按业务再做定制化规则。



「ボールト（Vault）」

**OCI Vault** 是“密钥和秘密的管理服务”，而 KMS（Key Management）是 Vault 里面负责“加密密钥管理与加密操作”的核心能力。 => 一个是保险柜，一个是保险柜里的锁和钥匙系统

```
OCI Vault（服务层）
   │
   ├── Secrets（密码、Token等）
   └── Keys（加密密钥）
          │
          ▼
        KMS（能力层）
          │
          ▼
        HSM（硬件安全模块）
```

 OCI Vault（你直接使用的服务）: 存储API Key，DB Password，TLS 私钥

 KMS（Key Management）：创建和管理加密密钥（Key），执行Encrypt / Decrypt，Key rotation



创建一个Vault，这个其实是用来存储 MEK（Master Encryption Key，主密钥）的，而MEK是用来加密DEK（Data Encryption Key，数据加密密钥），DEK 用于加密实际数据。也就是说MEK是一个专门用来“加密其他密钥”的密钥，是一个Wrapping Key

> 🗄️ 数据 = 你要存的钱
>
> 🔑 DEK = 保险箱的钥匙（直接开箱）
>
> 🔐 MEK = 管钥匙的总钥匙（锁着钥匙）

Vault中创建MEK时有两个mode

1. software, 存储在软件层，成本较低
2. HSM, 存储在硬件安全模块（HSM），更高安全性

key算法种类主要就是

1. AES（Advanced Encryption Standard），一种对称加密算法
2. RSA（Rivest–Adleman），一种非对称加密算法，公钥（Public Key）→ 加密，私钥（Private Key）→ 解密

（DEK一般使用AES，MEK多数情况下也是使用AES进行wrapping，RSA多用于密钥传输或导入场景）

比如说你创建一个Block Volume，它会要求你选一个Encryption Key，这个key就是MEK。这时候有两个选项：

1. Oracle-managed key（默认）
2. Customer-managed key（选择你的MEK）

=> Oracle管理Key和Customer管理Key本质上是同一类“MEK”，区别在于是否由客户控制

然后创建过程中系统会自动生成一个DEK给Block Volume，这个DEK会使用MEK加密后存储在metadata里。

通常来说，Block Volume运行过程中，DEK会以明文形式存在于受保护的内存中（因为加密算法在执行时需要使用明文key），用于高速的数据加密和解密。

因此：
- 日常读写不会调用MEK（保证性能）
- 在以下情况才会重新使用MEK解密DEK：
  - attach / detach
  - reboot
  - key rotation
  - DEK失效或被清除

因为MEK（尤其在HSM中）操作成本较高，所以不会参与高频IO路径。

```
    MEK（Vault / HSM）
        ↓（初始化时解密）
 加密的 DEK（存储在Volume metadata）
        ↓
     DEK（内存中缓存）
        ↓
       数据加密/解密
```

HSM（Hardware Security Module，硬件安全模块）可以理解为“带防篡改机制的安全设备”。

- MEK在HSM内生成并使用
- 明文形式不会离开HSM
- 提供受控接口（如 encrypt / decrypt）
- 具备防物理攻击能力（如检测异常时清除或保护密钥）

本质上，HSM通过硬件设计 + 固件控制 + 接口限制，确保密钥安全。

Key Backup本质是把Vault中的Key（MEK）导出为一个加密后的数据（Backup Blob），而不是明文密钥。

Virtual Private Vault可以理解为在HSM集群中为单一租户隔离出来的专属安全域（或资源分区）。其Key Backup会以加密形式存储在OCI控制平面的内部存储中（底层类似Object Storage，但对用户不可见、不可直接访问）。发生灾害时，可以通过restore操作将Key恢复到Vault中。



Secret（シークレット）是用来安全存储“敏感信息”的功能。例如：数据库密码等。用 Vault 中的 Key（密钥）来加密。



## マルチクラウドとハイブリッド・ソリューションの設計 20260419

OCI-Azure Interconnectの概要

OCI-Azure Interconnect 是一种将 Oracle Cloud 与 Microsoft Azure 通过专用网络直接连接的服务，无需经过公网。

连接方式：OCI：FastConnect  <=>  Azure：ExpressRoute 

典型使用场景: 数据库部署在 OCI，应用运行在 Azure



Oracle Interconnect for Google Cloud(GCP) 



Oracle Database@Azureの概要

Oracle Database@Azure 将 Oracle Exadata 数据库服务 **原生部署**在 Azure 数据中心中，使用户可以在 Azure 上运行应用时同时使用企业级 Oracle 数据库（如 Exadata、Autonomous Database），实现低延迟的应用与数据库连接。并通过 Azure 控制台进行统一管理。



注意 VM Cluster与RAC的关系：VM Cluster 是 基础设施，RAC 是 运行在上面的数据库形态

Exadata VM Cluster （虚拟机集群）：在 Exadata 专用硬件上划分出来的一组数据库虚拟机环境，用来运行 Oracle 数据库（通常是 RAC）

=> Exadata VM Cluster 提供多个数据库节点（VM），每个节点运行一个 Instance，这些 Instance 可以组成 RAC，共享同一个数据库，实现高可用和扩展性。

```
Exadata Infrastructure（物理硬件）
    ↓
Exadata VM Cluster（虚拟机集群） 👈 提供计算资源
    ↓
多个 VM（节点）
    ↓
每个 VM 上运行一个 DB Instance
    ↓
多个 Instance 组成 RAC（一个数据库）
```

=>多个 Instance 同时打开同一个CDB，CDB去管理各个PDB，所以Instance与PDB不是一对一关系

> CDB = 一栋大楼 🏢，PDB = 楼里的各个公司 🏬
>
> Instance = 大楼的“运营系统 + 工作人员” 

=>Azure Console 中创建Exadata VM Cluster， OCI Console中管理CDB



Oracle Database@Google Cloudの概要

Oracle Cloud VMware Solutionの概要 =>OCI 有原生方案，而且更“云”；OCVS 只是为了兼容 VMware 的过渡/特定需求方案.         VMware 的核心是：把一台物理服务器虚拟成很多台虚拟机（VM）来运行,还包括一整套管理和网络/存储能力.



## OCIへのワークロードの移行 20260422

Oracle Cloud Migrationsの概要 ： Oracle 提供的一套用于将本地数据中心或其他云平台的工作负载迁移到 Oracle Cloud Infrastructure（OCI） 的一体化迁移服务。

データベース移行概要

OCIデータベース・ターゲット：Exadata Database, ADB， Base Database，Exadata Cloud@Customer

Oracle Home = Oracle 软件安装目录（运行数据库所需的程序环境）, 举例,在 Linux 上常见路径：

```
/u01/app/oracle/product/19.0.0/dbhome_1
```

移行のタイプと方法

移行プロセス



RMANによる移行

​	Recovery Manager(RMAN)

Data Pumpによる移行

> Data Pump 是 Oracle Database 的一种 逻辑导出/导入工具
>
> 它的作用是把数据库里的对象和数据导出来，再导入到另一个数据库。可以理解成“把数据库内容打包搬家”，但它搬的是 逻辑对象，比如表、索引、视图、存储过程、schema、权限等，而不是像 RMAN 那样搬数据库的数据文件。

> RMAN 像“整栋房子搬迁”，你不是只搬桌子椅子，而是把房子的砖、墙、水管、电线、地板都按原样搬过去。Data Pump 像“把家具、文件、装修清单搬到新房子”。
>
> RMAN 像克隆一台电脑的硬盘。
> Data Pump 像把电脑里的文件、软件配置、用户资料导出，再装到另一台电脑上。
>
> 所以：
>
> - RMAN：硬盘镜像级复制
> - Data Pump：文件/资料级搬迁

リモート　クローニングによる移行

> 通过网络，从源数据库直接在OCI 目标 CDB上复制出一个新的PDB。

アンプラグ＆プラグによる移行

> | 方法          | 比喻                               | 迁移对象               |
> | :------------ | :--------------------------------- | :--------------------- |
> | RMAN          | 搬整栋房子的地基和墙               | 物理数据库/数据文件    |
> | Data Pump     | 搬家具和文件                       | schema、表、数据、对象 |
> | Remote Clone  | 照着旧房间远程复制一个房间         | PDB                    |
> | Unplug & Plug | 把一个可移动房间拔下来再插到新楼里 | PDB                    |

Enterprise Manager Database Migration Workbench

> Oracle Enterprise Manager 里的一个数据库迁移向导/工作台，用图形界面帮助你规划、执行和监控数据库迁移。它不是一种底层迁移技术本身，而是一个 管理平台。底层可能会调用或编排其他迁移方式，比如：Data Pump, RMAN...

Data Guardによる移行

> Data Guard 迁移就是先在 OCI 建一个实时同步的“备用数据库”，等它追上源库后，再切换角色，让 OCI 数据库接管业务。
>
> RMAN 先造出 OCI 备用库, Data Guard 负责之后持续同步.
>
> Data Guard 是物理级同步，传的是 redo 日志，备用库会持续恢复这些变化。

Oracle GoldenGateによる移行

> Data Guard 是把数据库底层产生的 redo 原样传过去并恢复；GoldenGate 是从日志里解析出业务级变更，再在目标库重新执行。
>
> Data Guard 是 redo 级的物理恢复同步；GoldenGate 是基于日志解析的逻辑事务复制。
>
> Data Guard 的优势是简单、稳定、物理一致性强；GoldenGate 的优势是灵活、可选择、可转换、适合复杂低停机迁移。

Zero-Downtime Migrationによる移行

> ZDM 是 Oracle 官方的迁移自动化工具，会根据场景编排 RMAN、Data Guard、GoldenGate 等技术，把数据库迁移到 OCI。
>
> 它的目标是低停机或接近零停机，不是所有场景都绝对 0 秒停机。

OCI DataBase Migrationサービス

> 在 OCI 控制台里配置迁移任务，由 OCI 托管服务帮你把数据库迁到 OCI。
>
> 它和 ZDM 很像，都是“迁移编排工具”，不是单纯的底层复制技术。但区别是：
>
> - ZDM：你自己部署和运行的迁移工具
> - OCI Database Migration Service：OCI 提供的云上托管服务



## 監視ソリューションの設計 20260526

モニタリングサービスの概要

アラーム

通知サービス Notifications



ロギング　サービスの概要

> OCI Logging 是 Oracle Cloud Infrastructure 提供的全托管、可扩展的集中式日志管理服务。它用于收集、管理、搜索和查看 OCI 资源产生的日志，帮助运维、安全和开发团队快速诊断问题、审计访问行为、分析系统运行状态。
>
> OCI Logging 通常包括三类日志：
>
> 1. Audit Logs
>    记录 OCI Audit 服务产生的事件，例如谁在什么时候对哪个资源执行了什么操作。
> 2. Service Logs
>    由 OCI 原生服务产生，例如 Load Balancer、Object Storage、API Gateway、Functions、VCN Flow Logs 等。
> 3. Custom Logs
>    用户自己的应用或主机产生的日志，可以通过 agent 或 API 发送到 OCI Logging。
>
> 核心概念
>
> - Log Group：日志组，用于组织和管理多个日志。
> - Log：具体日志对象，例如某个负载均衡器的访问日志。
> - Search：可以在 OCI Console 中查询日志内容。
> - Service Connector Hub：可把日志转发到 Object Storage、Streaming、Functions、Logging Analytics 等目标。



# Oracle Cloud Database Service Professional

## Base Database Service - VM(BaseDB) 20260602

介绍了 License，Shapes

Provision Oracle Base Database Service

> BaseDB 数据库运行在 Virtual Machine, 而不是：Bare Metal, Exadata

> 在 OCI Base Database Service（BaseDB）或者 Exadata DB System 中，Oracle 预配置了几个重要的 OS 账户
> ```
> root
>  └── opc
>        ├── oracle
>        │      └── Oracle Database
>        └── grid
>               ├── ASM
>               └── Clusterware
> ```
>
> 一句话总结：
>
> - opc：OCI 默认 SSH 登录账户（相当于云上的运维入口）。
> - root：Linux 超级管理员，负责系统层面。
> - oracle：Oracle Database 软件拥有者，负责数据库实例。
> - grid：Oracle Grid Infrastructure 软件拥有者，负责 ASM、RAC、Clusterware。
>
> 在 BaseDB 单机环境中，你最常打交道的是 opc → oracle；在 RAC/Data Guard 环境中，则会经常用到 grid。

=>可以把 CDB/PDB 看成：Linux OS + Docker Container



Manage Oracle Base Database Service

Scale Storage Up, Scale OCPU   =>即使是Base Database，也拥有Scale的基本能力，否则干嘛上云呢

Create Database from Backup从一个已有的备份恢复出一个数据库。Clone a Base Database直接复制一个现有运行中的数据库。 =>前者技术难度更复杂，后者其实很多基础设施都是共享的，变化时才切出来分支嘛

Enable Data Guard

Data Guard 的目标是“灾备和高可用”；Active Data Guard 的目标是在灾备基础上，让 Standby 数据库保持实时同步的同时还能对外提供只读查询服务，并提供自动块修复等高级功能。=>花几百万买个备份待机太浪费了，于是增强功能



Patch and Upgrade : OS => Gird Infrastructure => Database home

Run precheck => Apply

>  自底向上、先检查后执行
>
> OS：Linux 本身，内核、库、安全补丁
>
> Grid Infrastructure：Clusterware、ASM、RAC 相关组件
>
> Database Home：Oracle 数据库二进制文件和补丁

=> 对一个Base Database的操作其实也就是 扩展CPU，备份，打补丁版本升级这么几个而已，客户询问主要也就这三个场景



## Exadata Database Service(ExaDB) 20260615

Database Home => Grid Infrastructure Home => Virtual Machines in Exadata VM Cluster =>Exadata Infrastructure 

> Exadata Database Machine（简称 Exadata） 是 Oracle 推出的一体化数据库平台（Engineered System，软硬件协同设计系统），专门针对 Oracle Database 优化设计，集成了计算、存储、网络和软件栈，主要用于运行高性能、高可用性的企业级数据库。
>

=>硬件层面上，Exadata 的 Storage Cell 不仅是存储设备，而是带有 CPU、内存和 NVMe 的独立存储服务器，可以在存储层执行 Smart Scan 等计算逻辑；DB Server 与 Storage Cell 之间通过支持 RDMA 的高速网络通信，由 RDMA (Remote Direct Memory Access)网卡直接完成内存间的数据搬运(DMA)，减少 CPU 和协议栈开销；Storage Cell 内部使用大量 NVMe Flash 作为 Smart Flash Cache，对热点数据提供远高于传统磁盘的访问速度。



 Exadata Database Machine

> 传统的 Exadata Database Machine（客户机房里的 Exadata）本质上就是运行在 Bare Metal 上的。
>
> ```
> Oracle Database
>       ↓
> Oracle Linux   =>OS为Oracle Linux
>       ↓
> Physical CPU / Memory / NIC
>       ↓
> Exadata Hardware   =>不同于Dell这类通用计算机，专为DB设计的
> ```
>
> 没有VMware ESXi, Hyper-V这种 Hypervisor 层。
>
> =>对于传统的 Exadata 来说，通常可以这么理解：一个物理服务器（Node）对应一个 Linux 操作系统实例。

 Exadata VM Cluster

> OCI 上的 Exadata VM Cluster **底层存在 Hypervisor/虚拟化层**，这是云服务实现资源隔离、弹性扩缩容和多租户共享的基础。与传统 Exadata Database Machine 的 Bare Metal 架构不同，数据库运行在 VM 中。
>
> 不过，这种虚拟化并不是传统 VMware ESXi 那种通用虚拟化模式。Oracle 针对数据库场景进行了专门优化，通过 SR-IOV、RDMA Virtualization、设备直通（Passthrough） 等技术，使 VM 能够近乎直接访问 Exadata 硬件资源。
>
> 因此，虽然 Exadata VM Cluster 运行在虚拟化环境中，但数据库仍然能够充分利用 Exadata 的核心能力：
>
> - Storage Cell：存储节点拥有独立 CPU 和内存，可执行 Smart Scan 等存储层计算；
> - RDMA 网络：支持内存到内存的高速数据传输，显著降低 CPU 和协议栈开销；
> - NVMe Flash Cache：为热点数据提供超低延迟、高 IOPS 的访问能力。
>
> 正因为关键的数据路径仍然建立在 Exadata 专用硬件之上，所以 Exadata VM Cluster 的性能通常非常接近 Bare Metal Exadata，而明显优于普通云 VM + Block Volume 的架构。
>
> 可以简单概括为：
>
> ```
> Exadata Database Machine
> = Oracle DB + Bare Metal Exadata
> 
> Exadata VM Cluster
> = Oracle DB + Lightweight Virtualization + Bare Metal Exadata
> ```
>
> 两者最大的区别在于是否引入虚拟化层，而 Exadata 的核心硬件能力（Storage Cell、RDMA、NVMe Flash）在两种架构中都得到了保留。

=>VM Cluster 是 Exadata 专有的资源抽象层（也可以理解为同一套 Exadata 中的资源隔离单元），用于承载 Oracle RAC、Grid Infrastructure、ASM 和多个数据库；而 Base Database Service 没有 VM Cluster 这一层，数据库直接运行在 DB System 上。

Exadata Hardware Rack

> Exadata Hardware 不是一台机器，而是一整套机柜级系统（Rack）
>
> ```
> +--------------------------------+
> | Database Server 1             |
> | Oracle Linux                  |
> +--------------------------------+
> 
> +--------------------------------+
> | Database Server 2             |
> | Oracle Linux                  |
> +--------------------------------+
> 
> +--------------------------------+
> | Storage Cell 1                |
> | Oracle Linux + Cell Software  |
> +--------------------------------+
> 
> +--------------------------------+
> | Storage Cell 2                |
> | Oracle Linux + Cell Software  |
> +--------------------------------+
> 
> +--------------------------------+
> | Storage Cell 3                |
> | Oracle Linux + Cell Software  |
> +--------------------------------+
> 
> +--------------------------------+
> | RDMA Switch                   |
> +--------------------------------+
> ```
>
> =>每个物理节点对应一个 Linux
>
> 一个 Exadata Rack = 多个运行 Oracle Linux 的 Database Server + 多个运行 Oracle Linux 和 Cell Software 的 Storage Cell + 高速 RDMA 网络组成的数据库专用集群。

Exadata Infrastructure Maintenance 

> OCI 中的 Exadata Infrastructure Maintenance 是对 Exadata 底层硬件平台进行滚动维护和升级的过程，主要包括 Database Server、Storage Cell、RDMA/RoCE 网络交换机、ILOM 及相关 Firmware 和 Exadata System Software 的更新，不涉及数据库软件本身。OCI 通过 Rolling Maintenance 方式逐节点升级，在 RAC 和 ASM 的支持下通常无需业务停机。用户可以配置 Maintenance Window（维护窗口），指定 Oracle 执行维护的时间段，例如每周固定时段或自定义时间，以尽量降低维护对业务的影响。

Multi-VM 

> Multi-VM 是 OCI Exadata 的多租户架构能力，允许在同一套 Exadata Infrastructure（Exadata Rack）上创建多个相互隔离的 VM Cluster。各 VM Cluster 共享底层的 Storage Cell、RDMA 网络和 NVMe Flash 等 Exadata 硬件资源，但拥有独立的 Grid Infrastructure、RAC、Database Home、OS 环境和网络配置，实现软件栈和计算资源的逻辑隔离。
>
> 引入 Multi-VM 的主要目的是提高 Exadata 资源利用率并满足多租户需求。例如生产、测试和开发环境可以部署在不同的 VM Cluster 中，多个业务团队也可以共享同一套 Exadata 硬件而互不影响，同时支持不同数据库版本的独立维护和升级。

Exadata Cloud@Customer

> Exadata Cloud@Customer（ExaCC）是在客户数据中心部署 Exadata Rack，但由 Oracle 以云服务方式提供和管理的解决方案。客户获得与 OCI Exadata 类似的云化体验和 Exadata 性能，同时满足数据本地驻留和合规要求。
>
> ```
> 客户机房
> │
> ├── Exadata Rack
> │      ├── DB Server
> │      ├── Storage Cell
> │      └── RDMA Network
> │
> └── OCI Control Plane
>         (Oracle Cloud)
> ```

=>Oracle的其他服务通过FastConnect与客户本地机房连接



Oracle Grid Infrastructure

> Oracle Grid Infrastructure（GI） 是 Oracle 提供的一套基础设施软件，用于管理数据库服务器集群、高可用性和共享存储。它是 Oracle Real Application Clusters（RAC）和 Oracle Restart 的基础组件。
>
> Grid Infrastructure 主要由两个核心部分组成：
>
> | 组件                                      | 作用                                              |
> | ----------------------------------------- | ------------------------------------------------- |
> | Oracle Clusterware                        | 管理整个集群，节点通信、故障切换、资源管理        |
> | Oracle Automatic Storage Management (ASM) | Oracle 自带的卷管理和文件系统，负责管理数据库存储 |
>
> Oracle Database 负责数据处理，ASM 负责存储管理，Clusterware 负责高可用与集群管理，而 Grid Infrastructure 则将这些能力整合成一个统一的平台，为单机和 RAC 环境提供可靠的运行基础。

Patch & Upgrade

> Patch 是在同一版本内修复 Bug、漏洞和性能问题；Upgrade 是升级到新的数据库版本，引入新功能并升级数据字典。



## Heat Wave MySQL Technical Overview 20260709

=>MySQL HeatWave基本可以理解为Oracle为了吸引原本使用 MySQL的用户，在保证MySQL本来的事务处理（OLTP）的基本功能基础上通过加了HeatWave Cluster这一层新的组件，使它具有了实时分析（OLAP）能力，原本客户需要MySQL上存储数据，通过ETL清洗数据到专门实时分析（OLAP）能力的平台如Snowflake，进行BI，现在MySQL HeatWave将这个一体化了。

```
                 Application
                       │
                MySQL Protocol
                       │
             +-------------------+
             |    MySQL Server   |
             |-------------------|
             | SQL Optimizer     |
             | InnoDB (OLTP)     |
             +-------------------+
                │            │
      OLTP SQL  │            │ OLAP SQL
                │            ▼
                │    +----------------------+
                │    |   HeatWave Cluster   |
                │    | 内存列式分析引擎        |
                │    | Massive Parallel     |
                │    +----------------------+
                │
        Transaction Data
```

> MySQL Server 仍然是数据库的"大脑"，负责接收所有 SQL、优化和调度。InnoDB 负责事务处理（OLTP）。HeatWave Cluster 是外挂的高性能分析计算引擎，保存从 InnoDB 加载的数据副本到内存中，专门执行分析型查询（OLAP）。SQL 是否交给 HeatWave 执行，由 MySQL Optimizer 自动决定，应用程序通常无需修改。这样才能真正做到“一套 MySQL，同时支持 OLTP 和 OLAP”。

=>相对于 MySQL，Oracle Database 原本就具有非常强的 OLAP 能力

=>Heat Wave MySQL修改了MySQL的源码，但不是完全重写

HeatWave  MySQL = MySQL Enterprise Edition + HeatWave 分布式内存分析引擎 + 云服务能力。

```
MySQL HeatWave
│
├── 组件（Components）
│     ├── MySQL DB System
│     └── HeatWave Cluster
│
└── 功能（Features）
      ├── Query Accelerator
      ├── Lakehouse
      ├── AutoML
      ├── Vector Store
      ├── GenAI
      └── Autopilot
```

**MySQL HeatWave Lakehouse**

> Oracle 发现很多客户的数据并不全在 MySQL 里，而是大量存放在 OCI Object Storage、AWS S3、Azure Blob 等对象存储中。如果还要求客户先做 ETL，再导入数据库，成本和复杂度都会增加。
>
> MySQL HeatWave Lakehouse = 让 MySQL 能直接分析存放在对象存储（Object Storage）里的海量数据，而不用先导入数据库。

=>数据虽然没有经过 MySQL Server 的存储层（InnoDB），但还是需要MySQL来调度到HeatWave Engine，然后去读取Object Storage进行分析

=>MySQL HeatWave Lakehouse 的目标之一，就是进入原本由 Snowflake、Databricks、BigQuery 等 Lakehouse/Data Warehouse 占据的市场，与它们竞争。

```
客户端
    │
    ▼
MySQL（项目经理）
    │
    ├── 普通表 → InnoDB
    │
    └── External Table
            │
            ▼
      HeatWave（施工队）
```

**MySQL HeatWave Autopilot**

=>MySQL HeatWave Autopilot 的目标就是把许多原本依赖经验丰富 DBA 的性能调优工作自动化(判断 SQL 是否适合并行,优化 JOIN 顺序...)，利用机器学习和统计分析替代人工决策，其设计理念与 Oracle Autonomous Database 的 "Self-Driving Database" 非常相似，但两者自动化的对象和范围有所不同。

=>DBA是不是也没有前途了啊，至少就业市场缩小？

=>创建一个MySQL HeatWave instance，通常在private subnet，同时要创建一个compute instance作为跳板机去连接它



## NoSQL Database Service Technical Overview 20260712

Oracle 对标 DynamoDB 等云原生 NoSQL 服务的解决方案，用于承载需要高并发、低延迟且数据模型灵活的业务。

> 关系型数据库（RDBMS）以数据关系（Relation）为中心，采用规范化（Normalization）的数据模型，**先定义数据之间的关系，再存储数据**。它强调数据一致性（ACID）、完整性约束和复杂查询能力（**如 JOIN**、聚合、多表事务），适合核心业务系统，如订单、支付、ERP、CRM 等。

> NoSQL 数据库以水平扩展（Scalability）和高性能（High Performance）为中心，数据模型围绕应用的访问模式设计，**每条记录尽量独立**，避免跨节点关联操作。它通过数据分片（Sharding）、复制（Replication）等机制实现海量数据存储和高并发访问，适合互联网场景下的用户画像、Session、缓存、日志、IoT、实时推荐等业务。

> 现代大型系统通常采用多数据库架构，根据不同业务场景选择最合适的数据存储：
>
> - 关系型数据库：核心交易、订单、支付、库存、财务等需要强一致性的业务。
> - NoSQL 数据库：用户画像、缓存、会话、日志、消息、实时分析等需要高并发、低延迟和大规模扩展的业务。

=>NoSQL Database Service 某些简单的SQL语句还是能够实现的。所以NoSQL 理解为Not Only SQL更合适。另外NoSQL Database的Data Model有很多类型，其中Oracle采用了Table这种形式，更方便从关系型数据库过来的人理解，但底层仍然是一个分布式 Key-Value 存储。

=>关系数据库是"关系优先"（Relation-first），围绕JOIN，ACID来设计，而NoSQL 是"键优先"（Key-first）,聚焦于如何最快找到这条数据（Key）.

=>至于NoSQL Language SDKs, Oracle肯定优先JAVA的嘛

## OCI Database Management Service 20260714

=>OCI界面上 Observability & Management => Database Management, 在具体某个Database上还需要enable Database Management，可以选择Full Management （收费）和Basic Management（免费）, 然后你就可以在Database 界面看Performance Hub了。在Database Management可以可以统一管理整个数据库集群Fleet Management。

> **OCI Database Management Service（OCI 数据库管理服务，简称 DMS）** 是 Oracle Cloud Infrastructure (OCI) 提供的一项托管数据库管理服务，用于统一监控、管理、诊断和优化 Oracle 数据库。它为 DBA（数据库管理员）提供一个集中式控制台，无需部署和维护额外的管理服务器即可管理整个数据库集群。

=>Database Management Service 是 Oracle 托管的区域级（Regional）服务，运行在 Oracle 管理的服务基础设施中，而不是部署在客户自己的 VCN 中。对于部署在 OCI 私有 VCN 中的数据库，由于 Database Management Service 无法直接访问客户 VCN，因此需要在客户的 VCN 中创建 **Database Management Private Endpoint**。该 Private Endpoint 在客户 VCN 中提供一个私有 IP，作为 Database Management Service 访问数据库的入口，使所有通信都通过 OCI 内部私有网络（Oracle Backbone） 完成，而无需经过公网。对于部署在 On-Premises（本地数据中心） 或 其他云环境 的 Oracle 数据库，由于不存在 OCI VCN 中的 Private Endpoint，因此通常需要安装 Oracle Cloud Agent + **Oracle Management Agent**（根据部署方式，也可能仅安装 Management Agent）。Management Agent 会主动与 OCI 服务建立安全连接，将数据库的监控和管理数据上传到 Database Management Service。

> OCI Database Management 可以看作是 **Oracle Enterprise Manager** 在 OCI 云上的轻量级托管版本，保留了核心数据库管理能力，同时免去了部署和维护管理平台的复杂性，特别适合以 OCI 为主或采用混合云架构的企业。
>
> 主要区别就是Oracle Enterprise Manager (OEM)需要用户行部署和维护，用于大规模本地数据中心或高度定制化环境

启用了 OCI Database Management Full Management，无需登录数据库服务器即可查看 AWR 报告；在 Performance Hub 中结合 AWR、ASH、Top Activity 和 SQL Monitoring 进行综合分析；导出 AWR 报告用于性能诊断和问题排查。这使得 DBA 可以直接在 OCI 控制台完成大部分性能分析工作。



> AWR Report（Automatic Workload Repository）：AWR 是 Oracle 自动生成的数据库性能报告。反映数据库整体负载。
>
> Active Session History（ASH）：Oracle 数据库的活动会话历史记录。它会每秒钟采样一次（默认），记录数据库中所有正在工作的 Session（Active Session）。
>
> SQL Tuning Advisor：Oracle 自带的SQL 自动优化专家。输入一条 SQL输出如何优化这条 SQL。
>
> 可以用一个简单的比喻来理解：
>
> - **AWR Report**：看整个城市一天的交通统计（宏观分析）
> - **ASH**：看每一辆正在行驶的汽车（微观分析）
> - **SQL Tuning Advisor**：根据拥堵情况给出优化建议（解决方案）
>
> **在日常 DBA 工作中，这三者通常是连续使用的：AWR 发现问题 → ASH 定位问题 → SQL Tuning Advisor 提供优化方案。这种组合也是 OCI Database Management 的 Performance Hub 中最核心的性能诊断流程。**

```
数据库变慢
      │
      ▼
AWR Report
（发现整体变慢）
      │
      ▼
ASH
（定位是哪几个 Session、SQL 出问题）
      │
      ▼
SQL Tuning Advisor
（分析具体 SQL 并给出优化建议）
      │
      ▼
创建索引 / 更新统计信息 / 调整执行计划
      │
      ▼
数据库恢复正常
```

> SQL Plan Management（SPM，SQL 执行计划管理） 是 Oracle Database 的一项功能，用于保证 SQL 执行计划的稳定性，避免因为优化器（Optimizer）选择了新的执行计划而导致 SQL 性能突然下降。SPM 的核心概念就是 SQL Plan Baseline（执行计划基线）。可以把它理解为：一份经过验证、允许使用的执行计划白名单。

=>SQL Plan Management 相当于给 SQL Tuning Advisor（或者更准确地说给 Optimizer）画了一条红线：新的优化方案不能直接在生产环境生效，必须经过验证，证明性能确实更好，才能加入 SQL Plan Baseline 并被正式采用。



# OCI AI Foundations Associate

范围从大到小： Artificial Intelligence => Machine Learning => Deep Learning => Generative AI

## AI Foundations 20260716

Commonly Used AI Domains: Language, Audio and Speech, Vision



Language AI Model: 

Recurrent Neural Networks

Long Short-Term Memory

Transformers：已成为现代自然语言处理和大语言模型（如 GPT、BERT 等）的基础架构，也是当前最主流的序列建模方法

```
RNN（循环神经网络）1980年代
        │
        ▼
LSTM（解决长期记忆问题）1997年
        │
        ▼
Transformer（注意力机制 + 并行计算）2017年
        │
        ▼
现代大语言模型（LLM）
GPT、BERT、Gemini、Claude、LLaMA 等
```

Audio and Speech Al Models: Audio and Speech as Data

Variational Autoencoders 

Waveform Models：直接对原始音频波形（Raw Audio Waveform）进行建模的深度学习模型。

Siamese Networks



Vision AI Models： Image as Data

Convolutional Neural Network： 卷积神经网络（CNN） 是一种专门用于处理具有网格结构数据（Grid-like Data）的深度学习模型，最常用于图像处理和计算机视觉（Computer Vision）任务，也可应用于视频、语音和文本等领域。

YOLO

Generative Adversarial Network：生成对抗网络。GAN 的核心思想是让两个神经网络相互对抗（Adversarial）、共同学习，从而生成与真实数据非常相似的新数据。

```
人工智能（AI）
│
├── 机器学习（Machine Learning）
│
└── 深度学习（Deep Learning）
      │
      ├── 神经网络架构（Architecture）
      │      ├── CNN
      │      ├── RNN
      │      ├── LSTM
      │      ├── Transformer
      │      ├── Siamese Network
      │      └── Autoencoder / VAE
      │
      ├── 生成模型（Generative Models）
      │      ├── GAN
      │      ├── VAE
      │      └── Diffusion Model
      │
      ├── 检测/应用模型（Task Models）
      │      ├── YOLO
      │      ├── Faster R-CNN
      │      └── SSD
      │
      └── 语音模型（Speech Models）
             ├── WaveNet
             ├── WaveRNN
             └── WaveGlow
```

CNN、RNN、Transformer这类基础网络架构相当于发动机，而Waveform Models这种模型相当于汽车

GPT 的全称：Generative Pre-trained Transformer.  GPT 就是基于 Transformer 架构训练出来的一系列模型。ChatGPT 是运行在 GPT 模型上的聊天产品。

=>就神经网络架构，Transformer是当仁不让的主流选择，其他要么淘汰要么退居边角，即便是所谓的视觉领域，CNN也是配角

```
CNN 时代（视觉革命）2012-， 让机器看懂图片（Computer Vision）
        │
        ▼
Transformer 时代（架构革命）
        │
        ├── NLP Revolution（BERT、GPT-2、GPT-3）
            2017-， 让机器理解语言（Natural Language）
        │
        └── Foundation Model Revolution
            （GPT-4、Claude、Gemini、Sora、DeepSeek……）
            2022-，让一个模型理解世界（文本、图像、视频、音频……）
```

=>AI 最初主要沿着两条技术路线发展：自然语言处理（NLP）和计算机视觉（CV）。随着深度学习和 Transformer 的发展，又催生了图像/视频生成(Generative AI)、机器人自动驾驶(具身 AI)等能力。如今的发展趋势是将这些能力统一到一个 Multimodal（多模态）基础模型中。

```
传统AI
│
├── 自然语言处理（NLP）
│      └── 大语言模型（LLM） => LLM是 NLP 发展到 Transformer 时代的产物。
│             ├── 对话
│             ├── 推理
│             ├── 编程
│             └── Agent
│
├── 计算机视觉（CV） =>1990~2015： NLP 和 CV 各自发展，方法完全不同
│      ├── 图像分类
│      ├── 目标检测
│      ├── OCR
│      └── 图像理解
│
├── 生成式AI（AIGC）
│      ├── 文本生成（LLM）
│      ├── 图像生成（Diffusion）
│      ├── 视频生成
│      ├── 音乐生成
│      └── 语音生成
│
└── 决策与控制
       ├── 强化学习（RL）
       ├── 自动驾驶
       ├── 机器人
       └── 智能体（Agent）
                     │
                     ▼
        Multimodal Foundation Model
        （统一文本、图像、语音、视频、动作）
```











# [OCI Generative AI Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-generative-ai-professional-2025-/153868) 

=>说需要三方面的基础知识 1.深度学习与机器学习；2.Python；3.OCI.

