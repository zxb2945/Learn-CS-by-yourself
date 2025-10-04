# Azure Learning 2025

# Skillsoft (Percipio) AZ-204: Developing Solutions for Microsoft Azure

[Link](https://degreed.com/view/Course/43572885)

## 1.Develop Azure compute solutions

### Azure Virtual Machines 20250606

**Creating a Linux with Azure CLI, Azure Portal, Azure Powershell**

| 场景                              | 推荐方式         |
| --------------------------------- | ---------------- |
| 快速实验/新手                     | Azure Portal     |
| 脚本化部署/跨平台                 | Azure CLI        |
| Windows 环境自动化 + 管理多个资源 | Azure PowerShell |
| DevOps Pipeline / GitHub Actions  | Azure CLI        |

=>无论是Azure CLI还是 Azure Portal都需要通过Azure AD来验证身份.

> Azure AD 是微软构建在云上的企业级身份服务，核心在于“谁可以访问什么资源，用什么条件”，它是现代企业安全与访问控制的基石。
>
> Azure AD 是一个全球分布式、云原生设计的身份认证服务，不依赖单一物理服务器，即使部分区域宕机也能保证整体可用性。

=>CLI 和 PowerShell 是客户端，它们访问的是微软云的“服务集群”，没有固定单一 IP，服务通过 DNS 动态解析和负载均衡。Portal 是微软的 Web 服务，背后有相对固定的入口 IP 和 Web 服务器集群。

**Generating SSH Keys**

=>SSH 是专门为安全远程登录设计的协议，包含自己的密钥交换和认证机制，不依赖 TLS

=>我感觉TLS的公钥私钥都是服务器产生，服务器把公钥交给CA，然后私钥自己保存，客户端啥都没有。而SSH则是客户端把公钥放到服务端，私钥自己留着。SSH 是客户端“解锁”服务器给的加密挑战, TLS 是服务器“解锁”客户端发送的加密信息。

```
az sshkey create --name <key-name> --resource-group <rg-name> --public-key "@<file-path>"
```



#### Azure CLI 常用命令速查表

| 分类                | 操作                       | 命令                                                         |
| ------------------- | -------------------------- | ------------------------------------------------------------ |
| **基础认证**        | 登录 Azure                 | `az login`                                                   |
|                     | 设置默认订阅               | `az account set --subscription "<subscription-name-or-id>"`  |
|                     | 查看当前订阅信息           | `az account show`                                            |
| **资源组**          | 创建资源组                 | `az group create --name myResourceGroup --location eastus`   |
|                     | 查看资源组列表             | `az group list`                                              |
|                     | 删除资源组                 | `az group delete --name myResourceGroup`                     |
| **虚拟机**          | 创建虚拟机                 | `az vm create --resource-group myResourceGroup --name myVM --image UbuntuLTS --admin-username azureuser --generate-ssh-keys` |
|                     | 启动虚拟机                 | `az vm start --name myVM --resource-group myResourceGroup`   |
|                     | 停止虚拟机                 | `az vm stop --name myVM --resource-group myResourceGroup`    |
|                     | 删除虚拟机                 | `az vm delete --name myVM --resource-group myResourceGroup --yes` |
| **存储账户**        | 创建存储账户               | `az storage account create --name mystorageacct --resource-group myResourceGroup --location eastus --sku Standard_LRS` |
|                     | 列出存储账户               | `az storage account list`                                    |
| **App Service**     | 快速创建并部署 Web App     | `az webapp up --name <app-name> --resource-group <rg> --location <location>` |
|                     | **创建 App Service 计划**  | `az appservice plan create --name myPlan --resource-group myResourceGroup --sku FREE` |
|                     | **创建 Web App**           | `az webapp create --name mywebapp123 --resource-group myResourceGroup --plan myPlan` |
|                     | 部署 zip 包到 Web App      | `az webapp deployment source config-zip --resource-group myResourceGroup --name mywebapp123 --src myapp.zip` |
|                     | 启用本地 Git 部署          | `az webapp deployment source config-local-git --name <app-name> --resource-group <rg>` |
|                     | **配置 GitHub 自动部署**   | `az webapp deployment source config --name <app-name> --resource-group <rg> --repo-url <repo-url> --branch <branch> --manual-integration` |
| **网络服务**        | 创建虚拟网络               | `az network vnet create --resource-group myResourceGroup --name myVnet --subnet-name mySubnet` |
|                     | 创建公共 IP                | `az network public-ip create --name myPublicIP --resource-group myResourceGroup` |
| **容器服务（ACR）** | 创建容器注册表             | `az acr create --resource-group myResourceGroup --name myContainerRegistry --sku Basic` |
|                     | 登录 ACR                   | `az acr login --name myContainerRegistry`                    |
|                     | 启用 Admin 模式            | `az acr update --name myContainerRegistry --admin-enabled true` |
|                     | 查看 ACR 登录信息          | `az acr credential show --name myContainerRegistry`          |
|                     | 获取 login server          | `az acr show --name myContainerRegistry --query loginServer --output tsv` |
|                     | 列出 ACR                   | `az acr list --resource-group myResourceGroup --output table` |
|                     | 删除 ACR                   | `az acr delete --name myContainerRegistry`                   |
| **容器服务（ACI）** | 创建容器实例（来自 ACR）   | `az container create --resource-group myResourceGroup --name myContainer --image <acr-name>.azurecr.io/myimage:latest --registry-login-server <acr-name>.azurecr.io --registry-username <username> --registry-password <password> --dns-name-label mycontainerdns --ports 80` |
|                     | 创建容器实例（Docker Hub） | `az container create --resource-group myResourceGroup --name myContainer --image nginx --dns-name-label mycontainerdns --ports 80` |
|                     | 通过 YAML 文件创建容器实例 | `az container create --resource-group myResourceGroup --file container.yaml` |
|                     | 查看容器状态               | `az container show --resource-group myResourceGroup --name myContainer --output table` |
|                     | 查看容器日志               | `az container logs --resource-group myResourceGroup --name myContainer` |
|                     | 删除容器实例               | `az container delete --resource-group myResourceGroup --name myContainer --yes` |
| **通用操作**        | 查看所有资源               | `az resource list`                                           |
|                     | 查看帮助信息               | `az --help` 或 `az vm --help`                                |
|                     | 表格方式输出结果           | `--output table`                                             |

```
//在名为 myVM 的虚拟机上开放 80端口，前提是它属于 myResourceGroup 资源组。
az vm open-port --resource-group myResourceGroup --name myVM --port 80

```

#### Azure PowerShell 常用命令速查表

| 分类              | 命令                                     | 用途                     |
| ----------------- | ---------------------------------------- | ------------------------ |
| 登录认证          | `Connect-AzAccount`                      | 登录到 Azure 账号        |
| 查看订阅          | `Get-AzSubscription`                     | 获取当前账户下的订阅信息 |
| 设置订阅          | `Set-AzContext -Subscription "订阅名称"` | 设置当前会话使用的订阅   |
| 资源组            | `New-AzResourceGroup`                    | 创建资源组               |
|                   | `Get-AzResourceGroup`                    | 查看资源组               |
|                   | `Remove-AzResourceGroup`                 | 删除资源组               |
| 虚拟机            | `New-AzVM`                               | 创建虚拟机               |
|                   | `Get-AzVM`                               | 查看虚拟机信息           |
|                   | `Start-AzVM`                             | 启动虚拟机               |
|                   | `Stop-AzVM`                              | 停止虚拟机               |
|                   | `Remove-AzVM`                            | 删除虚拟机               |
|                   | `Restart-AzVM`                           | 重启虚拟机               |
| 存储账户          | `New-AzStorageAccount`                   | 创建存储账户             |
|                   | `Get-AzStorageAccount`                   | 获取存储账户信息         |
|                   | `Remove-AzStorageAccount`                | 删除存储账户             |
| 虚拟网络          | `New-AzVirtualNetwork`                   | 创建虚拟网络             |
|                   | `Get-AzVirtualNetwork`                   | 获取虚拟网络信息         |
| 公共 IP           | `New-AzPublicIpAddress`                  | 创建公共 IP 地址         |
| 网络接口          | `New-AzNetworkInterface`                 | 创建网络接口卡 (NIC)     |
| NSG（网络安全组） | `New-AzNetworkSecurityGroup`             | 创建 NSG                 |
|                   | `Get-AzNetworkSecurityGroup`             | 查看 NSG                 |
|                   | `New-AzNetworkSecurityRuleConfig`        | 添加 NSG 规则            |



### Azure Resource Manager Templates 20250608

> Azure Resource Manager（ARM）不是用来存储 template 的云资源，而是 Azure 的**资源管理和部署平台**，它的作用更广泛，下面详细解释：
>
> ------
>
> 什么是 Azure Resource Manager (ARM)？
>
> - ARM 是 Azure 的**管理层**，负责管理和控制 Azure 上所有资源的生命周期。
> - 它提供统一的 API、命令行工具和门户界面，用于创建、更新、删除和管理 Azure 资源（虚拟机、存储账户、网络资源、数据库、Web 应用等）。
>
> ------
>
> ARM 与 Template（模板）的关系
>
> - **ARM Template（ARM 模板）** 是一种基于 JSON 的声明式模板，用来描述和定义 Azure 资源的部署架构。
> - ARM Template 可以定义一组资源（比如 VM、存储、网络等）及它们的配置和依赖关系。
> - 你通过 ARM 来部署和管理这些模板，但 ARM 本身是管理和调度的服务，不是“存储模板的资源”。
>
> ------
>
> 简单比喻
>
> - ARM 就像 Azure 的“操作系统”或“大脑”，控制着所有资源如何创建和管理。
> - ARM Template 是“蓝图”或“说明书”，告诉 ARM 应该怎么创建资源。

=>Azure Resource Manager（ARM）本身不是一个独立的门户（portal），但Azure Portal（就是通过 ARM 来管理所有 Azure 资源的图形界面。换句话说，**你在 Azure Portal 上看到和做的任何资源管理操作，背后都是 ARM 来执行的**。



Azure Resource Manager Templates == ARM Templates 

Declarative syntax

> **ARM Template**：Azure 原生的基础设施即代码（IaC）工具，使用 **JSON**（或 Bicep）描述资源，专为 Azure 服务设计。
>
> **Terraform**：由 HashiCorp 开发的跨云平台 IaC 工具，使用 HCL（HashiCorp Configuration Language），可以管理多种云平台（Azure、AWS、GCP 等）。
>
> ### ARM Template vs Terraform 主要区别表格
>
> | 对比维度              | ARM Template / Bicep                     | Terraform                                     |
> | --------------------- | ---------------------------------------- | --------------------------------------------- |
> | **开发者**            | Microsoft（微软官方）                    | HashiCorp（第三方）                           |
> | **支持平台**          | 仅支持 Azure                             | 支持多云（Azure、AWS、GCP、本地等）           |
> | **语言语法**          | JSON（或 Bicep：简化语言）               | HCL（结构清晰、可读性强）                     |
> | **模块化支持**        | 有限（Bicep 模块较好，但 JSON 写法繁琐） | 原生强大的模块系统                            |
> | **状态管理**          | 无状态，由 Azure Resource Manager 管理   | 有状态（terraform.tfstate），需手动存储与保护 |
> | **部署方式**          | 直接部署模板到 Azure（`az deployment`）  | `terraform init / plan / apply`               |
> | **生态系统**          | Azure 官方模板或手写为主                 | 丰富的社区模块（Terraform Registry）          |
> | **错误提示/调试体验** | 报错信息相对模糊                         | 报错清晰，支持 `plan` 查看预期变更            |
> | **可读性与简洁性**    | JSON 冗长；Bicep 提升了可读性            | HCL 简洁、易读                                |
> | **适用场景**          | Azure-only，官方强集成                   | 多云部署、复杂环境管理、更高的团队协作需求    |

=>可以用VS Code编辑json，你也可以用Azure portal来编辑json

> 你可以在 Bicep / ARM Template 中嵌入“deploy scripts”，让它在资源部署过程中自动执行 CLI 或 PowerShell 脚本，完成一些标准模板无法涵盖的自定义操作。
>
> ```json
> resource deployScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
>   name: 'runCustomAzScript'
>   location: resourceGroup().location
>   kind: 'AzureCLI'
>   properties: {
>     azCliVersion: '2.30.0'
>     scriptContent: '''
>       az group list --output table
>     '''
>     timeout: 'PT10M'
>     cleanupPreference: 'OnSuccess'
>     retentionInterval: 'P1D'
>     supportingScriptUris: []
>   }
> }
> ```

=> **Bicep / ARM Template 中的 `deploymentScripts` 与 Terraform 中的 `provisioner` 非常类似**，都用于在基础设施部署过程中执行自定义命令或脚本。

> **Bicep** 是微软推出的一种**声明式基础设施即代码（IaC）语言**，专门用于简化 Azure 资源的定义和部署。
>
> 它是 **ARM Template（Azure Resource Manager 模板）** 的**抽象层和简化语言**，用更易读、易写的语法，代替 ARM JSON 模板的繁琐和冗长。
>
> 编写的 Bicep 文件可以编译成标准 ARM JSON 模板，能无缝用于所有 Azure 部署场景。

=>你可以编译bicep文件，vsscode会产生一个json文件，然后deployment这个json文件(用 --template-file 参数)

=>你可以使用 Azure Portal、CLI、PowerShell 或 REST API 将现有资源导出为 ARM Template，甚至进一步转为 Bicep，从而实现“基础设施即代码”的管理。

> ARM-TTK 是专门为 ARM Template 提供的静态代码检查工具，能帮助你自动化发现模板中的结构问题与违反最佳实践的代码，是提升模板质量的利器。

=>你用VScodeCode编辑bicep文件，然后以下命令部署这个bicep文件

```
az deployment group create \
  --resource-group <your-resource-group-name> \
  --template-file <your-bicep-file-path>
```



####  Bicep 核心语法速查表

| 语法项         | 示例                                                         | 说明                      |
| -------------- | ------------------------------------------------------------ | ------------------------- |
| **参数定义**   | `param location string = resourceGroup().location`           | 定义参数                  |
| **变量定义**   | `var storageSku = 'Standard_LRS'`                            | 定义变量                  |
| **资源定义**   | `resource stg 'Microsoft.Storage/storageAccounts@2022-09-01' = { ... }` | 定义 Azure 资源           |
| **模块引用**   | `module vnetMod './vnet.bicep' = { ... }`                    | 引用其他 bicep 模块       |
| **输出值**     | `output storageName string = stg.name`                       | 输出部署结果              |
| **条件表达式** | `if (enableMonitoring)`                                      | 条件部署资源或模块        |
| **循环语法**   | `for i in range(0, 3): { ... }`                              | 用于数组或多实例部署      |
| **函数调用**   | `resourceGroup().location`                                   | 调用 ARM 内建函数         |
| **引用资源**   | `existing rg 'Microsoft.Resources/resourceGroups@2021-04-01' = { name: 'myRg' }` | 引用已有资源              |
| **字符串插值** | `name: 'stg${uniqueString(resourceGroup().id)}'`             | 使用 `${}` 表达式嵌入变量 |



### Azure Container Registry 20250609

> Azure Container Registry 是在 Azure 中用于安全、可靠地存储和管理容器镜像的私有仓库，广泛用于与 AKS 和 DevOps 管道集成。它类似于 Docker Hub，但部署在你自己的 Azure 环境中，支持更高的控制性、安全性和集成能力。

=>PowerShell 和 Azure CLI 操作的是同一个 Azure 资源管理 API，根本区别在于语法风格和使用工具的生态环境不同。

| 项目             | **Azure PowerShell**                                         | **Azure CLI**                                     |
| ---------------- | ------------------------------------------------------------ | ------------------------------------------------- |
| **语言风格**     | PowerShell 命令风格（基于 Verb-Noun） 例：`New-AzContainerRegistry` | 类 UNIX 命令风格（类似 Bash） 例：`az acr create` |
| **平台特性**     | 更适合 Windows 和 PowerShell 脚本环境 如 CI/CD 中用 `.ps1` 文件 | 跨平台，适合 Linux/macOS 用户和 Bash 脚本         |
| **输出格式**     | 输出对象，适合后续 PowerShell 流水线处理                     | 默认输出 JSON，也支持表格、YAML 等格式            |
| **语法复杂度**   | 更为冗长和结构化，但强大（适合复杂场景）                     | 简洁直观，上手更快                                |
| **依赖模块**     | 需要安装 `Az` 模块（例如 `Az.ContainerRegistry`）            | 需要安装 `Azure CLI` 工具                         |
| **错误处理机制** | 使用 PowerShell 的 `try/catch`                               | 使用 Shell 的错误码机制（`$?`, `&&`, `            |

创建一个 ACR

✅ 使用 PowerShell：

```shell
New-AzContainerRegistry `
  -ResourceGroupName "myResourceGroup" `
  -Name "myRegistry" `
  -Sku Basic `
  -Location "EastUS" `
  -AdminUserEnabled $true
```

✅ 使用 Azure CLI：

```shell
az acr create \
  --resource-group myResourceGroup \
  --name myRegistry \
  --sku Basic \
  --location eastus \
  --admin-enabled true
```

Working with OCI Artifact Using ACR

> 在软件开发和 DevOps 中，**artifact（构件、产物）** 指的是在构建、编译、打包等过程中生成的**可交付文件**，这些文件会用于部署、测试、发布等环节。
>
> **OCI（Open Container Initiative）Artifact** 是符合 [OCI 规范](https://opencontainers.org/) 的构件 —— 它不仅包括容器镜像，还可以是任意格式的构件。

=>虽然它名字叫 "Container Registry"，但它已经进化为一个支持 **OCI 规范** 的通用 Artifact 仓库。换句话说：**ACR 不只是“Docker 镜像仓库”，它是一个支持多种构件格式的 OCI Registry。**

Using ACR Client Libraries

> 使用 **Azure Container Registry (ACR) Client Libraries** 可以让你在代码中直接操作 ACR，例如：上传、下载、列出、删除镜像或 artifact（比如 Helm charts、OCI blobs）。
>
> 示例：使用 .NET / C# 操作 ACR
>
> ```c#
> using Azure;
> using Azure.Containers.ContainerRegistry;
> using Azure.Identity;
> 
> var client = new ContainerRegistryClient(
>     new Uri("https://<your-acr-name>.azurecr.io"),
>     new DefaultAzureCredential()
> );
> 
> // List Repositories
> await foreach (string repository in client.GetRepositoryNamesAsync())
> {
>     Console.WriteLine($"Repository: {repository}");
> }
> 
> // List tags in a repo
> var repository = client.GetRepository("myimage");
> await foreach (ArtifactTagProperties tag in repository.GetTagsAsync())
> {
>     Console.WriteLine($"Tag: {tag.Name}");
> }
> ```

=>直接在C#中操作Azure云资源，这正是Developing所在嘛



> `az ts create` 是 Azure CLI 中用于 **创建 Azure Template Spec**（模板规范）的命令。
>
> Template Spec 是 Azure 中一种用来**存储和版本化 ARM 模板**（Azure Resource Manager 模板）的方式。它让你可以：
>
> - 在 Azure 中 **集中存储模板**（比如 ARM templates）。
> - **版本化模板**，方便多人共享、回滚、更新。
> - **通过权限控制谁可以使用模板**。
> - 在多个订阅或资源组中重用。
>
> ```
> az ts create \
>   --name myTemplateSpec \
>   --version 1.0.0 \
>   --resource-group myResourceGroup \
>   --location eastus \
>   --template-file ./azuredeploy.json \
>   --description "My first template spec"
> ```
>
> 这个命令会将 `azuredeploy.json` 文件上传为名为 `myTemplateSpec` 的 Template Spec，版本号为 `1.0.0`，放在 `myResourceGroup` 中。
>
> **使用模板创建资源**：
>
> ```
> az deployment group create \
>   --resource-group myRG \
>   --template-spec "/subscriptions/<sub-id>/resourceGroups/myResourceGroup/providers/Microsoft.Resources/templateSpecs/myTemplateSpec/versions/1.0.0"
> ```





### Azure  Container Instances 20250611

> | 特性             | **ACI (Azure Container Instances)**  | **AKS (Azure Kubernetes Service)**                        |
> | ---------------- | ------------------------------------ | --------------------------------------------------------- |
> | **用途定位**     | 轻量级容器运行，无需管理基础设施     | 完整容器编排平台（Kubernetes）                            |
> | **复杂度**       | 非常简单，几分钟上线                 | 更复杂，需要配置集群和资源管理                            |
> | **运行方式**     | Serverless（无服务器）               | Managed Kubernetes（有节点/控制面）                       |
> | **启动速度**     | 几秒                                 | 几分钟到十几分钟（集群初始化较慢）                        |
> | **容器编排能力** | 不支持编排，仅支持容器组（共享资源） | 支持完整 Kubernetes 生态，如Pod、Service、Ingress、Helm等 |
> | **水平扩展**     | 不支持自动扩展，只能手动运行多个实例 | 支持自动扩缩容（HPA、Cluster Autoscaler）                 |
> | **成本模型**     | 按秒计费（CPU/内存用多少付多少）     | 需要为节点付费，即使空闲也要付钱（除非用虚拟节点）        |
> | **持久存储支持** | 支持 Azure Files 和 Azure Disks      | 同样支持，并支持动态 PV                                   |
> | **VNet 集成**    | 支持（可选）                         | 支持                                                      |
> | **日志和监控**   | 基础日志（可接入 Log Analytics）     | 支持 Prometheus/Grafana、Azure Monitor 等                 |
> | **适合的用户**   | Dev/Test、CI/CD 中的任务、轻量服务   | 生产环境、大规模微服务架构                                |
>
> 选择 **ACI** 的典型场景包括：
>
> - 跑一个临时脚本 / 批处理任务 / 短期服务
> - CI/CD 流程中跑测试容器或构建容器
> - 小型 web 服务，不需要复杂编排
> - 想省去 VM 和集群维护成本

=>就像你本地用 `docker run` 起一个容器，只不过它是在 Azure 上跑。ACI 更适合“云上跑一次”，而本地 Docker 更适合“本地试一次”。ACI 的优势主要在：**可共享、可远程访问、可接云资源、可进 CI/CD 流水线**。

=>ACI 更推荐使用 Linux 容器，因为它更轻量、启动快、功能强、费用低。而 Windows 容器只在你必须依赖 Windows 技术栈时才考虑。

> **Container Group 是 ACI 中的“容器调度单元”，一组容器共享以下资源：**
>
> - **一个 IP 地址**
> - **同一个主机网络空间**
> - **相同的生命周期（启动/停止在一起）**
> - **同一文件系统挂载（如 Azure File）**
>
> 就像 Kubernetes 中的一个 Pod，也像 Docker Compose 中多个容器组合运行。
>
> 你想部署一个简单的 Web 系统：
>
> - 前端容器：React Nginx server
> - 后端容器：Python Flask API
> - 两者都需要访问一个共享的 Azure 文件卷
>
> 你可以用 ACI 的 **Container Group** 把它们打包在一起运行，它们会：
>
> - **共享一个公网 IP**（通过端口区分，如 80/5000）
> - 可以用 `localhost` 相互通信
> - 一起启动，一起销毁

你可以部署容器用Bicep =>感觉AZ204是不是特别注意 IaC

> ```
> param location string = resourceGroup().location
> param containerName string = 'mycontainer'
> param image string = 'nginx'
> 
> resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
>   name: containerName
>   location: location
>   properties: {
>     osType: 'Linux'
>     containers: [
>       {
>         name: containerName
>         properties: {
>           image: image
>           resources: {
>             requests: {
>               cpu: 1.0
>               memoryInGb: 1.5
>             }
>           }
>           ports: [
>             {
>               port: 80
>             }
>           ]
>         }
>       }
>     ]
>     ipAddress: {
>       type: 'Public'
>       ports: [
>         {
>           protocol: 'Tcp'
>           port: 80
>         }
>       ]
>     }
>   }
> }
> ```
>
> ## Bicep 核心语法回顾（本例用到的）
>
> | 类型     | 关键词或语法                                   | 含义                     |
> | -------- | ---------------------------------------------- | ------------------------ |
> | 参数     | `param`                                        | 定义可传入值             |
> | 变量     | `var`                                          | 定义中间变量（本例没用） |
> | 资源     | `resource`                                     | 声明 Azure 要部署的对象  |
> | 类型     | `string` / `int` / `bool` / `array` / `object` | 强类型                   |
> | 函数     | `resourceGroup().location`                     | 获取资源组属性           |
> | 数据结构 | `{}`（对象），`[]`（数组）                     | 常用于资源嵌套配置       |
> | 引用     | 使用 `param` / `resource symbolic name`        | 变量与资源复用           |

=>**你可以使用本地的 Docker CLI 去创建和操作 Azure Container Instances（ACI）**，但前提是你要通过 `docker context` 创建一个 Azure 的远程“遥控器”接口。

> 在 Azure Container Instances（ACI）中部署 **多个容器组成的一个容器组（Multi-container group）**，可以使用 **YAML 文件** 进行描述部署。
>
> 在 ACI 中，一个 container group 类似 Kubernetes Pod
>
> **可以使用 ARM 模板部署 Azure Container Instances (ACI) 的 Multi-container Group**。事实上，Azure CLI 的 YAML 和 ARM 是两个等价的 Infrastructure as Code（IaC）方式，都支持定义多个容器。
>
> YAML for ACI 是快捷方式，适合简单轻量部署；而 ARM Template 是面向专业自动化部署的标准方式，支持更强的组合和可扩展性。

> | 维度/方式                | YAML（Azure CLI 用）                            | ARM 模板                             | Docker Compose                                |
> | ------------------------ | ----------------------------------------------- | ------------------------------------ | --------------------------------------------- |
> | **定义格式**             | YAML 文件                                       | JSON（也有 Bicep 作为更简洁的替代）  | YAML 文件                                     |
> | **Azure 官方支持**       | 官方支持，主要用于 `az container create --file` | 官方 IaC 标准，支持全 Azure 资源管理 | 通过 Docker CLI 集成支持（需 Docker Context） |
> | **多容器支持**           | 支持，定义多个容器在一个容器组                  | 支持，多容器数组定义                 | 支持，多服务定义                              |
> | **资源范围**             | 仅限 ACI 容器组部署                             | 全 Azure 资源，容器只是其中一部分    | 仅管理容器和网络，无法直接管理 Azure 资源     |
> | **复杂性和灵活性**       | 结构简单，易用但功能有限                        | 高灵活度，支持参数化、条件、复杂逻辑 | 专注容器配置，复杂 Azure 功能不支持           |
> | **容器配置细节**         | 支持容器镜像、端口、命令、资源限制等            | 支持更全面的资源定义和扩展配置       | 支持容器镜像、端口映射、环境变量等            |
> | **认证支持（私有 ACR）** | 支持，但配置相对简单                            | 支持完整的认证配置                   | 支持但需额外配置 Docker Context               |
> | **网络配置**             | 仅支持 ACI 公共或私有 IP                        | 支持虚拟网络、子网等高级网络配置     | 只管理 Docker 网络，不管理 Azure 网络         |
> | **存储卷支持**           | 支持 Azure File 挂载                            | 支持 Azure File 等多种卷挂载         | 支持 Docker 卷，无法直接挂载 Azure 存储       |
> | **部署方式**             | 命令行部署（az CLI）                            | CLI、Portal、自动化流水线等多种方式  | 通过 Docker CLI `docker compose up`           |

=>**Docker Compose YAML** 和 **ACI YAML** 都是用 YAML 格式写的，但它们的**结构和元素（关键字）是完全不同的**，因为它们针对的目标和用途不同:  Docker Compose 是容器编排工具的标准文件格式，专注于容器服务和依赖管理；ACI YAML 是 Azure 资源定义文件，更偏向云资源管理，结构更复杂且功能有限。



> **Azure Container Apps** 是 Microsoft Azure 提供的一种**无服务器（serverless）容器服务**，它介于 Azure Container Instances（ACI）和 Azure Kubernetes Service（AKS）之间，专为构建和运行 **微服务**、**后台处理任务**、**事件驱动应用**、**API** 等现代云原生应用而设计。

=>**Azure Container Apps（ACA）相当于一个“简化版”或“抽象封装版”的 AKS（Azure Kubernetes Service）**，它保留了 Kubernetes 的强大扩展能力，但**隐藏了复杂的集群管理和容器编排细节**，对开发者更友好，特别适合做现代微服务或事件驱动架构的 Serverless 应用。



=>在 **Azure Container Instances (ACI)** 中，官方支持的 **4 种 storage volume 类型** 是：

| Volume 类型      | 持久性 | 支持跨容器共享 | 使用场景                           |
| ---------------- | ------ | -------------- | ---------------------------------- |
| Azure File Share | ✅      | ✅              | 持久化存储，日志、用户文件、缓存等 |
| Empty Directory  | ❌      | ✅              | 容器组内临时缓存、中间数据处理等   |
| Secret           | ❌      | ❌              | 密钥、Token、证书等敏感信息注入    |
| Git Repo         | ❌      | ✅              | 拉取初始化脚本、配置文件，只读挂载 |





ExampTopics:

以下是一个简单的 Dockerfile 示例，用于构建一个运行 Python 应用的镜像：

```dockerfile
# 使用官方 Python 镜像作为基础镜像
FROM python:3.8-slim

# 设置工作目录，终端默认进入的落脚点
WORKDIR /app

# 复制当前目录内容到容器的 /app 目录
COPY . /app

# 安装依赖
# RUN 等同于，在终端操作的shell命令
RUN pip install --no-cache-dir -r requirements.txt

# 暴露端口
EXPOSE 80

# 设置环境变量
ENV NAME World

# 运行应用
CMD ["python", "app.py"]
```





### Azure App Service 20250612

> **Azure App Service** 是 Microsoft Azure 提供的一种**平台即服务（PaaS）**，用于部署和托管**Web 应用、API、后台服务**等，无需管理底层的服务器基础设施。
>
> 你只需要关注代码，Azure 帮你管理环境。

=>**App Service 实际运行在 Azure 内部托管的一组 VM 上**，但这些 VM 你无法直接访问或管理

> **App Service Environment（ASE）** 是在你的 **虚拟网络（VNet）** 中托管的 Azure App Service 实例，提供了**完全隔离的托管服务环境**。简而言之：ASE = "**运行在你专属 VNet 内的 App Service**"
>
> ## ASE 使用场景举例：
>
> - 金融、政府、医疗等行业的**高合规性**需求
> - 企业希望将 App Service 应用部署在内网中，不暴露公网
> - App Service 需要访问某些 VNet 内部资源（如数据库、存储）
> - 企业需要集中托管大量 Web 应用/服务

=>你需要先开发一个 Web 应用（比如 ASP.NET、Node.js、Python 等），然后再部署到 Azure App Service 上运行。Azure App Service 会为你自动创建运行时环境（.NET, Node, Python 等）,托管 HTTP 服务,监控运行状态、日志、扩展等

> ，**Azure App Service 的部署（Deployment）功能**中，**支持使用 GitHub Actions** 来实现持续集成和部署（CI/CD），并且可以直接连接到你的 GitHub 账户。

=>Azure App Service 与 Github Actions完美集成

> App Service Plan 就是你网站运行的“主机配置套餐” —— 性能、价格、功能都由它决定。

=>在 **Azure App Service** 中，你有 **两种主要的部署方式** 来托管和运行你的 Web 应用：我们不仅可以往 Azure App Service上传源码或应用包来部署Web，也可以把封装好的Docker容器镜像部署上去

> **Application Insights** 是 Azure 提供的一种 **应用程序性能管理（APM）服务**，它在 Azure App Service 中的作用非常重要，核心功能是：✅ **监控你的 Web 应用运行状况、性能、可用性、错误信息和用户行为。**
>
> 在 App Service 的“监视”菜单中直接启用 Application Insights， 实时看到当前活跃连接数、失败率、响应时间等数据，适合故障排查

=>**Azure App Service** 是一个用于运行 **Web 应用（如 .NET、Node.js、Python、Java）或容器镜像** 的 **PaaS（平台即服务）**，它**不是数据库服务**，所以你无法在里面安装或运行 SQL Server。即 Web应用 != 数据库

#### Azure App Service 管理门户导航菜单整理

| 分类       | 菜单项名称                        | 功能简述                                                     |
| ---------- | --------------------------------- | ------------------------------------------------------------ |
| **概览类** | Overview                          | 显示 App Service 的状态、URL、订阅、资源组等基本信息         |
|            | Activity Log                      | 查看活动日志                                                 |
| **部署类** | Deployment Center                 | 配置 CI/CD，如 GitHub、Azure DevOps、Bitbucket 等            |
|            | Deployment Slots                  | 设置部署槽（标准或以上计划可用）                             |
| **设置类** | Configuration                     | 设置应用程序设置（App Settings）、连接字符串、路径映射等     |
|            | Authentication                    | 配置身份验证（如 Azure AD、Facebook 登录等）                 |
|            | TLS/SSL settings (`Certificates`) | 管理证书（上传 PFX、绑定域名证书、使用 Managed Certificate） |
|            | Custom domains                    | 绑定自定义域名                                               |
|            | Identity                          | 配置系统分配或用户分配的托管身份                             |
|            | Scale up (App Service plan)       | 提升定价层（从 Free 升级到 B1/B2/S1 等）                     |
|            | Scale out (App Service plan)      | 设置横向扩展规则（基于计划）                                 |
|            | Properties                        | 查看 App ID、主机名、位置、订阅等                            |
| **诊断类** | Diagnose and solve problems       | 使用自动检测工具诊断运行、部署等问题                         |
|            | Log stream                        | 实时查看应用日志输出                                         |
|            | App Service logs                  | 设置和下载日志（包括应用日志和 Web 服务器日志）              |
|            | Metrics                           | 查看关键指标图表（CPU、内存、请求数量等）                    |
|            | Alerts                            | 设置性能或错误率的警报                                       |
| **工具类** | Console                           | 提供 Kudu 控制台接口，可执行命令                             |
|            | Advanced Tools (Kudu)             | 打开高级工具界面（Kudu）                                     |
|            | App Service Editor                | 编辑器（预览版）直接在线编辑代码                             |
| **网络类** | Networking                        | 配置 VNet 集成、访问限制、混合连接等                         |
|            | Access restrictions               | 设置 IP 白名单、限制访问来源                                 |
| **安全类** | Backups                           | 配置自动备份（标准及以上计划）                               |
|            | SSL certificates (见 TLS/SSL)     | 管理 HTTPS/SSL 证书                                          |



=>App Service tier plan

| 层级                       | 自动扩展能力（含实例上限）        | 部署槽支持         | 备份   | VNet 集成支持                   | 关键特性补充说明                         |
| -------------------------- | --------------------------------- | ------------------ | ------ | ------------------------------- | ---------------------------------------- |
| **Free (F1)**              | ❌ 不支持（每天 60 分钟 CPU 限制） | ❌ 不支持           | ❌ 无   | ❌ 无                            | 无法绑定自定义域名，仅用于学习测试       |
| **Shared (D1)**            | ❌ 不支持（固定资源，低优先）      | ❌ 不支持           | ❌ 无   | ❌ 无                            | 与他人共享资源，功能受限                 |
| **Basic (B1~B3)**          | ✅ 支持（最多 3 实例）             | ❌ 不支持           | ✅ 支持 | ❌ 无                            | 支持自定义域名与 SSL                     |
| **Standard (S1~S3)**       | ✅ 支持（最多 10 实例）            | ✅ 支持最多 5 个槽  | ✅ 支持 | ✅ 支持基础集成                  | 适合中等流量应用，性价比高               |
| **Premium v2 (P1v2~P3v2)** | ✅ 支持（最多 20 实例）            | ✅ 支持最多 20 个槽 | ✅ 支持 | ✅ 强化集成                      | 更高性能、更大内存、SSD 存储             |
| **Premium v3 (P1v3~P3v3)** | ✅ 支持（最多 30+ 实例）           | ✅ 支持最多 30 个槽 | ✅ 支持 | ✅ 支持 Zone 冗余                | 高性能与企业级功能，推荐生产使用         |
| **Isolated (I1~I3)**       | ✅ 支持（最多 100 实例）           | ✅ 支持最多 100 槽  | ✅ 支持 | ✅ App Service Environment (ASE) | 网络完全隔离，适合高合规需求             |
| **Isolated v2**            | ✅ 支持（最多 100 实例，按需扩展） | ✅ 支持最多 100 槽  | ✅ 支持 | ✅ ASEv3，支持私有 IP            | 最强隔离性与性能，适合大型企业或政府项目 |



### Azure Web Apps 20250613

> Azure Web Apps 是 Azure App Service 的一个“子服务”或“功能类别”。
>
> ## Azure App Service 包括哪些“App 类型”？
>
> Azure App Service 提供以下四种“App”类型（也叫 App Service 类型）：
>
> | 类型           | 用途                                                  |
> | -------------- | ----------------------------------------------------- |
> | **Web App**    | 用于托管标准的 Web 应用（如 ASP.NET、Flask、Node.js） |
> | **API App**    | 用于托管 REST API 服务                                |
> | **Mobile App** | 用于后端移动服务（老服务，已整合）                    |
> | **WebJobs**    | 用于运行后台任务（如定时脚本）                        |

=>**你完全可以使用一个 `.zip` 文件来部署 Azure Web App**，这种方式叫做：Zip 部署（Zip Deployment）也叫做 **Zip Push Deployment**，是 Azure App Service 支持的一种简便部署方式。（**压缩内容是网站代码本身，不要包含最外层目录**。）

> 部署方式（3种常用）：
>
> 方法 1：使用 `az webapp deployment source config-zip`
>
> ```
> az webapp deployment source config-zip \
>   --resource-group myResourceGroup \
>   --name mywebapp123 \
>   --src ./myapp.zip
> ```
>
> 方法 2：通过 Kudu（App Service 的内建工具）上传 zip =>可以有个网页界面手动操作
>
> 方法 3：使用 GitHub Actions 自动打包并 zip 部署

=>方法1与2 本质一致,底层都是调用Kudu 的Rest API

=> 这里提到了不仅可以用 Github Action，还可以用Azure DevOps中Pipeline！在Repo里编辑Bicep文件，然后再Pipelines定义YAML文件 来执行Powershell的各种命令

示例 Pipeline YAML 文件

```yaml
trigger:
  branches:
    include:
      - main

pool:
  vmImage: 'windows-latest'

variables:
  resourceGroupName: 'myResourceGroup'
  location: 'eastus'
  bicepFilePath: 'main.bicep'

steps:
- task: AzureCLI@2
  inputs:
    azureSubscription: 'MyAzureConnection'  # 需要在Project Settings中配置
    scriptType: 'ps'
    scriptLocation: 'inlineScript'
    inlineScript: |
      az deployment group create \
        --resource-group $(resourceGroupName) \
        --template-file $(bicepFilePath) \
        --parameters location=$(location)
    displayName: 'Deploy Bicep Template'

```

=>可以在github上用json(ARM Template)定义一组微服务资源，直接部署到Azure上去

> **Azure Key Vault 是一个集中管理和保护敏感配置的保险箱**，它帮助你避免将密码、证书等写在代码或配置文件中，提升系统的安全性与合规性。

> Managed Identity 就是 Azure 给资源分配的“身份”，用于安全访问 Key Vault、Storage、Database 等资源，避免手动管理密钥。
>

> 在 Azure 中为 **App Service 添加 Authentication（身份验证）** 可以让你的 Web 应用安全地控制用户访问，例如通过 Azure AD、Microsoft、Google、GitHub 等身份登录。

> 在 Azure 中，**App Service 的 Configuration（配置）** 是指你可以**集中管理和控制 Web 应用的运行时行为**的一组设置。这些设置不会改动代码，但会影响应用的运行环境，非常关键。
>
> App Service 的配置页分为几个主要部分：
>
> | 类别                               | 说明                                                         |
> | ---------------------------------- | ------------------------------------------------------------ |
> | **Application settings**           | 类似于环境变量，可用于连接字符串、API 密钥、运行标志等       |
> | **General settings**               | .NET / Node.js / Python / Java 等运行时版本，平台架构（x64/x86），web socket 开关等 |
> | **Default documents**              | 默认首页文件（如 `index.html`, `default.aspx`）              |
> | **Path mappings**                  | 虚拟路径映射（可将某个路径映射到物理路径或共享存储）         |
> | **Connection strings**             | 用于数据库连接（也会作为环境变量注入）                       |
> | **Authentication / Authorization** | 身份验证设置（如 Azure AD 登录）                             |

=>可以给你的App service绑定 custom domains  =>Azure 会默认帮你启用免费的 SSL 证书（来自 DigiCert），你可以启用 HTTPS（强烈推荐）

> **Scale Up** 是换更强的机器，**Scale Out** 是加更多的机器

=>给以给 Scale Out 设置 Auto Scaling



Examtopics:

> 为确保在 **Azure App Service 的部署槽（deployment slots）自动交换（auto swap）之前**执行脚本并确保资源准备就绪，你需要使用 **deployment slot settings** 中的 **预热（warm-up）机制**，特别是：
>
> 要确保 auto swap 之前脚本执行、资源可用，应通过设置 **`applicationInitialization`** 在**web.config**中配置 warm-up endpoint，Azure 会在正式交换前调用它，确保 app 已准备好。
>
>  Auto Swap 的工作机制：将代码部署到一个Testing Slot, 部署成功后，去确保 `Production` 槽上启用了 Auto Swap，然后进行自动从 Testing 接收代码 =>也就是说 auto swap 不应该部署到Testing Slot

=>另一个方案

> 你想要确保在开启了自动交换（Auto Swap）功能的情况下，**在交换操作发生之前先运行一些脚本，并确保资源就绪**。
>
> Azure App Service 提供了一个机制，允许在实际完成交换前，先对目标槽位进行**预热（warm-up）**，即：
>
> > **自动交换过程中，Azure 会先对目标槽位进行 Ping（探测），只有当返回指定的状态码时，才会继续完成交换。**
>
> **配置两个重要的应用设置（App Settings）**：
>
> - `WEBSITE_SWAP_WARMUP_PING_PATH`：设置要在交换前 Ping 的路径，比如 `/statuscheck`。
> - `WEBSITE_SWAP_WARMUP_PING_STATUSES`：设置哪些 HTTP 状态码表示“准备就绪”，比如 `200`。

在 **Azure Web App** 中启用并验证客户端证书（TLS Mutual Authentication），你需要进行以下配置，

> 1️⃣ **Client certificate location（客户端证书位置）**
>
> 客户端证书被解码后作为一个 **请求头（HTTP header）`X-ARR-ClientCert`** 传递。
>
> ```
> GET /api/photo HTTP/1.1
> Host: myapp.azurewebsites.net
> User-Agent: Mozilla/5.0
> Accept: application/json
> X-ARR-ClientCert: MIIDXTCCAkWgAwIBAgIJANzY82+H5CeqMA0GCSqGSIb3DQEBCwUAMEUxCzAJBgNVBAYTAkFVMRMwEQYDVQQIDAq3YJkYbXB0MRcwFQYDVQQKDA5NeSBDb21wYW55IEx0ZDAeFw0xOTA3MjcxMzQyMjRaFw0yOTA3MjQxMzQyMjRaMEUxCzAJBgNVBAYTAkFVMRMwEQYDVQQIDAq3YJkYbXB0MRcwFQYDVQQKDA5NeSBDb21wYW55IEx0ZDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAsU9lg==
> ```
>
> ### 2️⃣ **Encoding type（编码类型）**
>
> > 客户端证书是以 **Base64 编码的 X.509 格式字符串** 传递的。

=>因为Azure Web App **不会自动拒绝未通过验证的客户端证书**，你必须**在代码中处理验证逻辑**。这个代码指的是你Azure Web Application的代码！Azure向客户端请求CA证书，然后把它标为X-ARR-ClientCert转给Web App代码去处理

将一个ASP.NET Core Web 应用（基于 Docker）迁移到 Azure，并通过自定义域名（如 `www.fourthcoffee.com`）访问，你可以写一个shell脚本

> ```shell
> #!/bin/bash
> 
> # 1. 创建 Web App（已存在可以略过）
> az webapp create \
>   --resource-group FourthCoffeePublicWebResourceGroup \
>   --plan AppServiceLinuxDockerPlan \
>   --name fourthcoffee-webapp \
>   --deployment-container-image-name fourthcoffee/webapp:latest
> 
> # 2. 配置 Docker Hub 镜像（等价于 dockerHubContainerPath）
> az webapp config container set \
>   --name fourthcoffee-webapp \
>   --resource-group FourthCoffeePublicWebResourceGroup \
>   --docker-custom-image-name fourthcoffee/webapp:latest \
>   --docker-registry-server-url https://index.docker.io
> 
> # 3. 添加自定义域名
> az webapp config hostname add \
>   --webapp-name fourthcoffee-webapp \
>   --resource-group FourthCoffeePublicWebResourceGroup \
>   --hostname www.fourthcoffee.com
> 
> ```

创建一个从 github repro上拉一个仓库部署到Azure App Service， 从CLI命令的角度**3～4 个命令** 完成部署：

> 1. 创建资源组（如果需要）
>
>    ```
>    az group create --name myResourceGroup --location japaneast
>    ```
>
> 2. 创建 App Service Plan
>
>    ```
>    az appservice plan create --name myAppServicePlan --resource-group myResourceGroup --sku B1 --is-linux
>    ```
>
> 3. 创建 Web App（附带部署源）
>
>    ```
>    az webapp create --resource-group myResourceGroup --plan myAppServicePlan \
>      --name my-webapp-name --runtime "NODE|18-lts" \
>      --deployment-source-url https://github.com/your-username/your-repo.git
>    ```
>
> 4. （可选）设置 GitHub Actions 自动部署
>
>    ```
>    az webapp deployment source config \
>      --name my-webapp-name \
>      --resource-group myResourceGroup \
>      --repo-url https://github.com/your-username/your-repo.git \
>      --branch main \
>      --manual-integration
>    ```
>
>    =>也可设置`--manual-integration` 参数，**不启用自动同步 / CI（Continuous Integration）**。
>
>    =>`az webapp deployment slot` 是 Azure CLI 里用于管理 **Azure App Service 部署槽（Deployment Slots）** 的命令组。如
>
>    ```
>    az webapp deployment slot create \
>      --name mywebapp \
>      --resource-group myResourceGroup \
>      --slot staging
>    ```
>







### Azure Functions 20250617

> Azure Functions 与 AWS Lambda 都是典型的 **FaaS（Function as a Service）** 产品，是 Serverless 架构的代表服务。它们都让你可以**无需管理服务器基础架构**，只需编写代码逻辑来处理事件。

=> 一般来说Azure Funtions 的Serveless架构是 stateless的，如果需要stateful的话就需要Durable Functions

=> 普通 Azure Function 是“立即执行并返回结果”的模型，而 Durable Function 提供“异步执行并支持状态追踪”的能力，适用于需要编排、多步骤或长时间运行的场景。

> ## ✅ 普通 Azure Function 的响应模型
>
> - 是**同步执行模型**（synchronous execution）。
> - 函数被触发（如 HTTP 调用）后，**必须立即返回响应**。
> - 如果处理时间较长（> 5 分钟，消费计划限制），容易失败。
> - 适合轻量级、快速响应的 API 任务，例如：
>   - 查询数据库
>   - 返回静态内容
>   - 简单的数据处理
>
> ------
>
> ## ✅ Azure Durable Function 的响应模型
>
> - 是**异步编排模型**（asynchronous orchestration）。
> - 被 HTTP 触发时，返回的是一个「**202 Accepted**」响应，**不代表任务完成**。
> - 返回的 JSON 中包含：
>   - `statusQueryGetUri`: 查询状态的地址
>   - `sendEventPostUri`: 触发外部事件的地址
>   - `terminatePostUri`: 终止流程的地址
> - 客户端可以**轮询状态地址**，等流程真正完成时再获取最终结果。
> - 特别适合：
>   - 多步骤异步流程（如审批流程）
>   - 耗时操作（如图像处理、文档转换等）
>   - 自动化任务编排

=>编写Azure Durable Function就要用到C#中的async/await关键词了哈

=>Durable Function 的 “stateful” 是指它自动记录并维护函数执行的完整状态，允许客户端在执行过程中或结束后，随时查询状态和结果。

> ### 为什么它能做到 stateful？
>
> 因为 Durable Function 背后依赖的是：
>
> - **Azure Storage（队列 + 表 + blob）**作为持久化后端
> - 它会将所有事件、状态更新记录下来，并在函数恢复/重启后可以“**重放历史**”继续执行
> - 这也被称为 "**event sourcing + replay**" 模式



> Durable Functions 是 **Azure Functions 的扩展**，支持你在 Serverless 架构中编写 **有状态（stateful）工作流**。

> 在 Azure Durable Functions（或更广义的分布式系统）中，**Fan-out/Fan-in** 是一种常见的并发执行模式，用来**并行执行多个任务**，然后再**汇总结果**。
>
> ##  Fan-out/Fan-in 的意思是什么？
>
> | 阶段                | 含义                                               |
> | ------------------- | -------------------------------------------------- |
> | **Fan-out（发散）** | 将一个任务**拆分成多个子任务**，并行执行           |
> | **Fan-in（收敛）**  | 等所有子任务完成后，**聚合处理结果**，继续后续操作 |
>
> ### 举个简单例子（图片处理）：
>
> 你有 100 张图片，要进行处理：
>
> - **Fan-out**：你可以同时触发 100 个 Azure Function 实例来分别处理每张图片。
> - **Fan-in**：当全部处理完成后，把处理结果合并、生成报告或发通知。

=>Azure Function + HTTP trigger ≈ 云上的轻量级 REST API 服务

=>Azure Functions 本质上运行在一个为你准备好 C#（或其他语言）运行环境的容器中

> Azure Functions 是一个托管的、事件驱动的**容器化运行环境**
>
> 它在后台使用容器来：
>
> - **封装语言运行时环境**（例如 .NET 6、.NET Isolated、Node.js、Python 等）
> - **加载和执行你上传的函数代码**
> - **按需自动调度、扩容和回收容器**

> **Azure Service Bus** 是一个支持可靠传递、顺序控制、事务性和高吞吐量的云消息平台，适合企业级的系统集成场景。

=>**Function App 是 Azure 中用于承载 Azure Functions 的“容器”**。你可以把 **Function App 理解为“函数的宿主环境”**，里面可以包含 **一个或多个 Azure Function（函数）**。

=>可以用 Azure Service Bus 来trigger Function App， 在Function App的configuration中配置来自 Azure Service Bus的endpoint

=>可以用Azure Insight来监视 Function

> | Azure Insight如果你想…   | 去这个菜单               |
> | ------------------------ | ------------------------ |
> | 查看请求或依赖失败       | ✅ **Failures**（主要）   |
> | 查看应用抛出的异常       | ✅ **Exceptions**         |
> | 按时间或条件搜索具体事务 | ✅ **Transaction Search** |
> | 实时监控错误和失败       | ✅ **Live Metrics**       |

=>Function App 可以跟 Github Action集成，在Deployment Center中设置Github为源

> | 概念                  | 功能定位                            | 类比                        |
> | --------------------- | ----------------------------------- | --------------------------- |
> | **Deployment Center** | 设置**代码来源**和持续部署方式      | “从哪儿拉代码并部署”        |
> | **Deployment Slots**  | 支持**多版本/环境**并实现无中断切换 | “预发布环境 / 蓝绿部署通道” |

> Azure Functions 默认支持 C#/JavaScript/Python 等语言，但如果你用的是不支持的语言，就可以写一个 **Custom Handler**。它通过标准的 HTTP 协议与 Azure Functions Host 通信。

=>当你在local.settings.json中设置dotnet-isolated，那你就要为你的Function写Main入口函数了

> **`host.json` 是配置 Function App 行为的全局设置，影响函数的运行时行为。**
>  **`local.settings.json` 是本地开发环境用的配置文件，包含环境变量和连接字符串，不会部署到 Azure。**=>是本地用来模拟 Azure 环境的配置行为，比如Azure发个Queue能被本地vscode感知到，因为本地也跟Azure Functions所在的容器一样配置了相关信息



 





### Azure Functions Triggers 20250620

> 在 Azure Functions 中，**Triggers（触发器）** 和 **Bindings（绑定）** 是函数运行模型的核心概念
>
> ## 一、Trigger（触发器）
>
> > **定义**：触发器是函数的“入口点”，也就是说，一个函数必须也只能有一个 Trigger，用于定义“什么时候”函数会被执行。
>
> ### 常见的 Trigger 类型：
>
> | Trigger 类型            | 说明                                           |
> | ----------------------- | ---------------------------------------------- |
> | **HTTP Trigger**        | 当接收到 HTTP 请求时执行函数（用于构建 API）。 |
> | **Timer Trigger**       | 按计划定时触发（比如每天中午12点执行一次）。   |
> | **Blob Trigger**        | 当某个 Blob（例如上传的文件）发生变化时触发。  |
> | **Queue Trigger**       | 当 Azure Storage Queue 有新消息时触发。        |
> | **Event Hub Trigger**   | 用于处理大规模的事件流（如 IoT 数据）。        |
> | **Service Bus Trigger** | 来自 Service Bus 队列或主题的消息触发。        |
>
> ## 二、Bindings（绑定）
>
> > **定义**：Bindings 是函数和其他 Azure 资源之间的桥梁。它可以是输入绑定（input）或输出绑定（output），允许你轻松读写外部资源。
>
> ### 输入绑定（Input Binding）
>
> - 提供函数运行时所需要的外部数据。
> - 比如：读取 Blob 文件、从 Cosmos DB 取数据、从队列中读取内容等。
>
> ### 输出绑定（Output Binding）
>
> - 将函数处理结果写到外部系统中。
> - 比如：把数据写到 Storage Blob、Queue、Cosmos DB、Service Bus、SendGrid（发邮件）等。
>
> ## 三、结合示例（C#）
>
> ### 示例：HTTP Trigger + Queue Output Binding
>
> ```c#
> csharpCopyEdit[FunctionName("HttpToQueueFunction")]
> [return: Queue("myqueue-items", Connection = "AzureWebJobsStorage")]
> public static string Run(
>     [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
>     ILogger log)
> {
>     log.LogInformation("HTTP trigger function received a request.");
> 
>     string name = req.Query["name"];
>     return $"Hello {name}, your data is queued!";
> }
> ```
>
> - `HttpTrigger`：当 HTTP 请求到来时触发函数。
> - `Queue`（输出绑定）：函数运行后会将字符串写入名为 `myqueue-items` 的队列中。
>
> =>C#会自动产生function.json (python等其他非.NET有可能要手写)
>
> ```json
> {
>   "bindings": [
>     {
>       "authLevel": "function",
>       "type": "httpTrigger",
>       "direction": "in",
>       "name": "req",
>       "methods": [ "post" ]
>     },
>     {
>       "type": "http",
>       "direction": "out",
>       "name": "res"
>     }
>   ]
> }
> 
> ```

> 在 Azure Functions 中，`host.json` 和 `function.json` 是两个非常关键的配置文件，它们分别用于控制：
>
> - **整个 Function App 层面的设置（`host.json`）**
>
> ```json
> {
>   "version": "2.0",
>   "customHandler": {
>     "description": {
>       "defaultExecutablePath": "process.exe",
>       "workingDirectory": "",
>       "arguments": []
>     },
>     "enableForwardingHttpRequest": true
>   }
> }
> 
> ```
>
> - **每个具体 Function 的触发器绑定配置（`function.json`）**
>
> ```json
> {
>   "bindings": [
>     {
>       "authLevel": "function",
>       "type": "httpTrigger",
>       "direction": "in",
>       "name": "req",
>       "methods": [ "get", "post" ]
>     },
>     {
>       "type": "http",
>       "direction": "out",
>       "name": "res"
>     }
>   ]
> }
> ```
>
> 





Azure Fucntion的hosting的种类

> Azure Function 的托管方式分为 **Consumption Plan（按用量付费）**、**Premium Plan（性能可控）**、和 **Dedicated (App Service) Plan（运行在自己的虚机上）**。
>
> ```
>               +---------------------+
>               |  Azure Functions    |
>               +---------------------+
>                        |
>      +-----------------+------------------+
>      |                 |                  |
> Consumption       Premium            Dedicated (App Service)
> (Serverless)   (No cold start)       (Always On VM)
> 
> ```



> Azure Web PubSub 是微软提供的一个 **实时消息传递服务**，专门用来简化开发基于 WebSocket 的实时双向通信应用，比如聊天、实时仪表盘、协作工具等。
>
> ## 使用 Azure Web PubSub **事件触发** Azure Functions
>
> - **场景**：Azure Web PubSub 支持事件回调（如连接打开、关闭、消息接收），可以把这些事件推送到 Azure Functions 进行处理。
>
> - 在最新的 Azure Functions 扩展里，微软提供了一个专门的 **Web PubSub Trigger**，用来直接触发 Azure Functions（和传统的 HTTP Trigger 不同）。
> - 这个 Trigger 绑定需要你在 `function.json` 里指定一个 `eventType`，用来区分触发函数的事件消息类型。
> - `eventType` 的值只能是下面两种之一：
>
> | eventType 值 | 说明                                                         |
> | ------------ | ------------------------------------------------------------ |
> | `user`       | 表示来自客户端的“用户事件”，比如客户端发来的自定义消息。     |
> | `system`     | 表示系统事件，比如连接（connect）、断开（disconnect）等系统级事件。 |



=>随手补充一下Azure的一些服务区别：

> | 如果你需要...          | 使用            |
> | ---------------------- | --------------- |
> | 简单队列、成本敏感     | ✅ Queue Storage |
> | 支持事务/死信/高级路由 | ✅ Service Bus   |
> | 高吞吐量事件摄取       | ✅ Event Hub     |

Azure Cosmos DB

> **Azure Cosmos DB** 是 **Microsoft Azure 提供的全球分布式、可扩展、多模型的 NoSQL 数据库服务**。它专为高可用性、低延迟和全球分布的应用场景而设计。

=>Azure Cosmos DB 可以作为 Azure Function 的 Trigger。当 **Cosmos DB 中的数据发生变化（写入或更新）**时，Azure Function 会被自动触发执行。

=>说Azure Function如何Handle抛出的异常，其实就是C#的try catch...

=>还可以给Azure Function进行依赖注入，可以用传统的In-Process 模式，使用 `Startup.cs`来注册类型-实例对应关系，感觉更偏向于C#语法层面的东西哈 



Exam topic:

Azure Functions 各种托管计划:

| 托管计划         | 计费方式                     | 弹性伸缩     | 冷启动 | VNET 支持 | 适用场景                                                    |
| ---------------- | ---------------------------- | ------------ | ------ | --------- | ----------------------------------------------------------- |
| Consumption Plan | 按执行量付费                 | 自动按需扩缩 | 有     | 不支持    | 事件驱动、低频调用、无服务器                                |
| Premium Plan     | 按预留实例计费               | 自动按需扩缩 | 无     | 支持      | 低延迟、高性能、**VNET 集成**                               |
| App Service Plan | 固定资源规格计费             | 手动扩缩     | 无     | 支持      | 复用现有资源、负载稳定，**仅部分 SKU 支持VNET，且性能很差** |
| Dedicated Plan   | App Service Environment 计费 | 手动扩缩     | 无     | 支持      | 高安全隔离、企业级环境                                      |

=>Premium Plan 是 **专门为 Azure Function 优化** 的运行环境，有自动 scale-out、高性能、**冷启动优化**。App Service Plan 虽然能跑 Function，但并**不建议**用它做高负载函数运行平台，**缺乏自动扩展能力**（不是真正 Serverless，因为资源是预先分配的，不按调用量计费。）。除非你已经有 App Service Plan，想复用资源。Plan 可以保持几乎热启动，需设置**Always On**，确保无冷启动

=>Consumption Plan 没有冷启动优化，搞不好得10min才能启动起来

=>Azure Functions 在 App Service Plan 上运行时，本质上就是在 **标准的 Azure App Service 环境** 里启动函数应用（Function App），跟普通的 Web App、API App 共享同一组计算资源（VM 或实例）。

> ### **SKU（Stock Keeping Unit，库存单位）**
>
> - 是托管计划下面的具体资源规格，用来定义**虚拟机的大小、性能等级和价格**。
> - 比如在 **App Service Plan** 里，你可以选择不同的 SKU：
>   - Free
>   - Shared
>   - Basic (B1, B2, B3)
>   - Standard (S1, S2, S3)
>   - Premium (P1v2, P2v2...)
>
> SKU 影响 CPU、内存、存储配额和价格。

=>Plan与SKU两个层级



> **Extension Bundle** 是 Azure Functions 中用于集中管理扩展（如 Blob、Queue、Cosmos DB 等触发器和绑定）的机制。
>  通过启用 Extension Bundle，无需单独安装每个扩展包，Azure 会根据 bundle 配置自动加载对应的功能。
>  这简化了函数应用的依赖管理，尤其适用于使用 Azure Functions 的非 .NET 项目（如 JavaScript、Python 等）。

=>比如使用Rust来写Azure Functions 





## 2.Develop for Azure storage

### Azure Cosmos DB 20250621

> **Azure Cosmos DB** 是 Microsoft Azure 提供的一种**全托管的全球分布式 NoSQL 数据库服务**，适合构建**高可用、可扩展、低延迟**的现代应用。
>
> 你可以把它看成是一个支持多种数据模型、全球同步复制的超强版数据库，**用于替代 MongoDB、Cassandra、DynamoDB、Table Storage 等方案**。

=>什么是NoSQL？

> **NoSQL 数据库**（**Not Only** SQL）是一类非关系型数据库，它不像传统的关系数据库（如 MySQL、PostgreSQL）那样使用表格（table）结构来存储数据，而是使用更灵活的方式，如文档、键值、图或列族来组织数据。
>  它的设计目标是为了解决 **大规模、高并发、非结构化数据处理** 的问题，特别适合 **云计算、移动、IoT、社交网络等现代应用场景**。
>
> ##  NoSQL 的四大类型
>
> | 类型                      | 数据模型            | 代表产品                              | 场景                         |
> | ------------------------- | ------------------- | ------------------------------------- | ---------------------------- |
> | **键值型（Key-Value）**   | 类似字典结构        | Redis, DynamoDB, Riak                 | 缓存、会话数据、配置管理     |
> | **文档型（Document）**    | JSON、BSON 文档     | MongoDB, CouchDB, Cosmos DB (SQL API) | Web应用、内容管理、用户档案  |
> | **列族型（Wide-Column）** | 类似 Excel 的大列表 | Cassandra, HBase                      | 日志、时间序列、物联网       |
> | **图数据库（Graph）**     | 顶点 + 边 + 属性    | Neo4j, Cosmos DB (Gremlin), ArangoDB  | 社交关系、推荐系统、图谱分析 |

=>你发现在portal上不仅有 Azure Cosmos DB For NoSQL，还有Azure Cosmos DB For PostgreSQL,可不可以这样理解Azure Cosmos DB 就是 分布式+NoSQL,后来微软发现这个分布式还可以配合SQL,所以Azure Cosmos DB的内涵就增加了

> ##  Cosmos DB 的“概念”发生了进化
>
> | 阶段            | Cosmos DB 的含义                                             |
> | --------------- | ------------------------------------------------------------ |
> | ✅ 初期（2017）  | 分布式的 **多模型 NoSQL 数据库**（核心是 JSON 文档 + 多种 API） |
> | ✅ 中期（2022~） | 引入 Synapse Link、大数据集成、Gremlin 图查询等，定位为 **NoSQL + 实时分析平台** |
> | ✅ 当前（2023~） | 增加了 **Cosmos DB for PostgreSQL**，成为一个统一品牌，囊括 **NoSQL + 分布式 SQL** 能力 |
>
> ## 一个总结类比
>
> 你可以这样理解这个演进过程：
>
> > Cosmos DB 最开始是 "分布式 NoSQL 工具箱"，后来微软发现 “分布式” 是真正的核心竞争力，于是引入了“分布式 SQL”（PostgreSQL + Citus），并把它也纳入 Cosmos 家族中，形成统一的“分布式数据平台”。

=>Azure Cosmos DB for PostgreSQL相对于一般的Azure Database for PostgreSQL最大的区别就是 分布式，适合需要**水平扩展、高并发、大数据量处理**的应用。

=>回到NoSQL，其实Azure Cosmos DB里面有很多种类API，比如Azure Cosmos DB for NoSQL与Azure Cosmos DB for MongoDB

> ### Cosmos DB for NoSQL vs MongoDB API 对比表
>
> | 项目         | **Cosmos DB for NoSQL**            | **Cosmos DB for MongoDB**           |
> | ------------ | ---------------------------------- | ----------------------------------- |
> | **数据模型** | JSON 文档                          | BSON 文档（MongoDB 格式）           |
> | **查询语言** | Cosmos SQL（类似 SQL 的语法）      | MongoDB 查询语法（JSON 风格）       |
> | **适合场景** | 新项目开发，想充分使用 Cosmos 特性 | 迁移现有 MongoDB 项目，保留工具生态 |

=>**Cosmos DB for NoSQL**虽然是NoSQL数据库，但是采用类似 SQL 的语法

> 在 **Azure Cosmos DB for NoSQL** 中，**`container`（容器）是数据存储的核心单位**，它的概念大致相当于：
>
> - 关系型数据库中的一个 **表（table）**
> - MongoDB 中的一个 **collection（集合）**
>
> Azure Cosmos DB（以 Core SQL API 为例）中结构大致如下：
>
> ```
> Cosmos DB Account
>  └── Database
>       └── Container
>             └── Items（JSON 文档）
> ```



> **Azure Synapse** 是一个用于大规模数据分析的现代化平台，结合了数据仓库、数据湖、大数据处理、AI 和 BI 报表功能，适合从中小型企业到大型企业的数据分析需求。
>
> 使用 **Synapse Link for Cosmos DB**,Synapse Link是一种**实时无缝连接**，让你可以**在 Synapse 中分析 Cosmos DB 数据**，而**不会影响 Cosmos DB 的事务性能**

### Azure Cosmos DB Containers 20250622

=>什么是 Schema（模式）？

> **Schema**（读音：/ˈskiːmə/）是指**数据的结构定义**，即你告诉数据库：
>
> > “我这张表/这类数据，包含哪些字段（属性）、每个字段是什么类型、是否可以为空等等。
>
> ## 一个类比理解 schema
>
> 你可以把 schema 想象成「数据的模板」：
>
> - **有 schema**：像 Excel 表格，第一行就是字段名，第二行必须按顺序填数据。
> - **无 schema**：像你记事本中写的 JSON 数据，字段随意写，但你还是希望有一致性，否则你写的程序可能无法处理。

=>注意！ `schema（模式）`和 PostgreSQL 中的schema是**两个不同的概念**，但**名字相同**

> 在数据库理论里，**schema（模式）= 数据结构的定义**
>
> ## 但在 PostgreSQL 中，**schema 是命名空间（namespace）**
>
> 在 PostgreSQL 中，`schema` 这个词又被用来代表一种**逻辑分组机制**，是数据库中的“子空间”或“目录”概念。
>
> 你可以这样理解：
>
> | 类比概念       | PostgreSQL 中的实体 |
> | -------------- | ------------------- |
> | 文件系统       | 数据库              |
> | 文件夹（目录） | schema              |
> | 文件           | table               |
>
> 为什么会有这个名字重复的现象？
>
> 这个是历史遗留问题。术语“schema”最早在关系模型理论中用于描述数据结构，但后来**PostgreSQL** 采用“schema”作为命名空间概念，借用了这个词。

=>schema在不同的数据库中意义不同！

> | 数据库         | `schema` 是否是命名空间？    | 备注                                                         |
> | -------------- | ---------------------------- | ------------------------------------------------------------ |
> | **PostgreSQL** | ✅ 是命名空间                 | 同一个数据库中可以有多个 schema，比如 `public`, `sales`, `hr` 等 |
> | **MySQL**      | ❌ 不是命名空间               | 在 MySQL 中，`schema` 和 `database` 是同义词，**等价**       |
> | **Oracle**     | ✅ 是命名空间，但等价于“用户” | 每个用户拥有一个 schema，schema 名 = 用户名                  |
>
> ### 🔵 **MySQL**: `schema` = `database`
>
> - 在 MySQL 中，没有“schema 里面再建 table”的概念。
> - 你用 `CREATE DATABASE` 或 `CREATE SCHEMA` 都是一样的。
>
> ### **Oracle**: schema = 用户的命名空间
>
> Oracle 的逻辑非常独特：
>
> - 每个 **用户（User）** 自动拥有一个同名的 schema。
> - schema 中存放的是该用户创建的所有表、视图、过程等。



=>回头说数据库理论中的scheme

> Cosmos DB 不强制 schema，但你仍应**主动维护 schema 一致性**，否则会影响查询性能、稳定性、以及未来的维护成本。
>
> ###  示例
>
> 假设你往一个 Cosmos DB 的 container 插入如下两个文档：
>
> ```json
> // 文档 A
> {
>   "id": "1",
>   "name": "Alice",
>   "age": 30
> }
> 
> // 文档 B
> {
>   "id": "2",
>   "fullName": "Bob Smith",
>   "joined": "2024-01-01"
> }
> ```
>
> 两者字段完全不同，Cosmos DB 都可以存下去，也不会报错。但这就意味着：
>
> - 你写 SQL 查询 `SELECT c.name FROM c WHERE c.age > 25` 时，只有 A 会命中。
> - 如果你设置了 `name` 字段的索引，但某些文档没有 `name` 字段，查询性能或准确性可能受影响。

=>From Items to tree 与 From trees to property paths

> 研究 **Cosmos DB 查询引擎的内部执行流程（Query Execution Plan）**时会遇到的术语:From Items to tree 与 From trees to property paths
>
> 它们出现在 `EXPLAIN` 查询输出的逻辑计划（Logical Plan）中，属于 Cosmos DB 查询语义分析阶段的术语。是 Cosmos DB 查询语义处理中的**两个内部转换步骤**，用于将 SQL 查询结构变成可以执行的逻辑树结构。
>
> 1. **From Items to Tree**
>
> #### 举例：
>
> ```sql
> SELECT c.name FROM c WHERE c.age > 30
> ```
>
> - 这里 `FROM c` 是从 container 里的文档 `c` 中读取数据。
> - Cosmos 会把这个 `c` 作为一个 **迭代器节点（iterator node）**。
> - 所以 `From Items to Tree` 表示 Cosmos 把你的 `FROM` 子句转成了内部的树状结构。
>
> 🔧 本质上是：**把 SQL 中的“来源”变成程序可以执行的逻辑读取结构。**
>
> 2. **From Trees to Property Paths**
>
>    会提取出两个 **property path**：
>
>    - `/name`
>    - `/age`
>
>    这些路径用于：
>
>    - **字段解析**
>    - **索引匹配**
>    - **投影优化**
>
>    🔧 本质上是：**找出你访问了 JSON 文档的哪些字段路径，以便索引引擎和投影引擎使用。**
>
> ## 类比解释
>
> 你可以想象：
>
> | 阶段                         | 类比                                                         |
> | ---------------------------- | ------------------------------------------------------------ |
> | From Items to Tree           | 把 SQL 的结构转成一棵“操作执行树”                            |
> | From Trees to Property Paths | 从执行树中提取“你要访问的 JSON 字段”路径（如 `/age`, `/name`） |

=> **Azure Cosmos DB 的 Indexing Policy（索引策略）**

> **Indexing Policy（索引策略）** 是 Cosmos DB 中定义文档如何被索引的配置。
>
> 你可以控制：
>
> - 是否自动索引所有文档（自动/手动）
> - 哪些字段包含在索引中
> - 哪些字段排除在索引之外
> - 索引类型（Range / Hash / Spatial）
> - 排序需求（通过 composite indexes）
>
> | 索引类型            | 支持数据类型                                                | 支持的操作                                       | 是否默认启用 | 优点                     | 适用场景                          |
> | ------------------- | ----------------------------------------------------------- | ------------------------------------------------ | ------------ | ------------------------ | --------------------------------- |
> | **Range Index**     | `String`, `Number`, `Boolean`, `DateTime`                   | `=`, `<`, `>`, `<=`, `>=`, `BETWEEN`, `ORDER BY` | ✅ 默认启用   | 支持范围查询和排序       | 按字段排序、筛选、分页            |
> | **Hash Index**      | `String`, `Number`, `Boolean`                               | `=`（等值匹配）                                  | ❌ 默认不是   | 写入性能更优，占用空间少 | 只做等值匹配的主键或标识查询      |
> | **Spatial Index**   | `Point`, `LineString`, `Polygon`, `MultiPolygon`（GeoJSON） | `ST_DISTANCE`, `ST_WITHIN`, `ST_INTERSECTS` 等   | ❌ 默认不启用 | 支持地理空间查询         | 地图、定位、地理围栏等            |
> | **Composite Index** | 多个字段（组合）                                            | 多字段联合 `WHERE + ORDER BY`                    | ❌ 需手动配置 | 提高联合过滤+排序性能    | 例如：`WHERE a=1 ORDER BY b DESC` |
> | **No Index**        | -                                                           | -                                                | ❌ 需手动设置 | 写入极快，节省存储       | 写多查少、日志类、冷数据容器      |
>
> 常见索引使用和扫描类型详解
>
> | 术语                                        | 说明                                                         | 备注 / 适用场景                                |
> | ------------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------- |
> | **Index Seek**                              | 通过索引直接定位满足查询条件的具体条目。类似“索引查找”，效率最高。 | 精准查询，等值匹配（`=`）或范围查询的起点。    |
> | **Precise Index Scan**                      | 在索引中扫描满足条件的精确范围条目。适用于范围查询。         | 范围查询（`>`, `<`, `BETWEEN`）时使用。        |
> | **Full Index Scan**                         | 扫描索引中的所有条目。没有过滤条件时或用于排序、聚合时发生。 | 索引全遍历，性能比全表扫描好，但仍较重。       |
> | **Full Scan**                               | 不走索引，直接扫描数据表（或数据容器）所有数据。性能最差。   | 无索引、索引失效或复杂查询时出现。             |
> | **Expanded Index Scan**                     | 对索引中的复杂表达式或多字段索引进行展开扫描。可能是对复杂字段或多值字段的索引扫描。 | 复杂过滤条件，多字段、数组或嵌套字段索引扫描。 |
> | **Queries with Complex Filter Expressions** | 查询条件包含多重逻辑运算、函数、嵌套字段、数组过滤等，导致索引不能完全命中或使用效率低。 | 可能触发 Full Scan 或 Expanded Index Scan。    |
>
> 举例说明
>
> ```sql
> -- Index Seek 示例
> SELECT * FROM c WHERE c.id = '123';
> 
> -- Precise Index Scan 示例
> SELECT * FROM c WHERE c.age BETWEEN 20 AND 40;
> 
> -- Full Index Scan 示例
> SELECT * FROM c ORDER BY c.name;
> 
> -- Full Scan 示例（无索引字段）
> SELECT * FROM c WHERE CONTAINS(c.description, 'keyword');
> 
> -- Expanded Index Scan 示例（数组字段）
> SELECT * FROM c WHERE ARRAY_CONTAINS(c.tags, 'urgent');
> 
> -- 复杂过滤示例
> SELECT * FROM c WHERE (c.status = 'active' AND c.score > 80) OR CONTAINS(c.notes, 'review');
> 
> ```

=>Cosmos DB 的 Resource Model 

> Azure Cosmos DB 的资源模型是一个 **分层的、逻辑化的数据组织结构**，大致如下图所示：
>
> ```
> Azure Cosmos DB Account
> ├── Database (容器组)
> │   ├── Container (容器 / 表)
> │   │   ├── Item (文档 / 记录)
> │   │   ├── Stored Procedure
> │   │   ├── Trigger
> │   │   └── UDF (User-Defined Function)
> ```

=>数据库级别可以设置 **吞吐量（RU/s）**（可选）,每个容器可以：单独配置 **吞吐量（RU/s）**;指定 **分区键（Partition Key）;**定义 **索引策略（Indexing Policy）**   RU指 Request Unit

> 在 **Azure Cosmos DB** 中，**Stored Procedures（存储过程）** 是一类运行在 Cosmos 容器内部、由用户自定义的 **JavaScript 函数**，用于执行一组 **原子性操作（事务）**，特别适用于 **单分区范围内的批量更新、插入、校验等操作**。
>
> ## 使用 Stored Procedure 的好处
>
> | 好处                     | 说明                                     |
> | ------------------------ | ---------------------------------------- |
> | ✔ 原子操作               | 多个写入或更新操作可以**一起提交或回滚** |
> | ✔ 减少网络调用           | 把多个操作封装在一次 RPC 中，提高效率    |
> | ✔ 执行复杂业务逻辑       | 可在数据库内编写逻辑控制、校验、处理流程 |
> | ✔ 使用前后触发器（可选） | 可搭配 Triggers 使用，提高灵活性         |

> Trigger 是一种绑定在文档操作（如插入、更新）上的 JavaScript 脚本，自动在操作之前或之后执行，可用于校验、补充字段、日志等逻辑处理。  =>**执行时必须在请求中显式声明。**
>
> ## 两种类型的 Trigger
>
> | 类型           | 执行时机       | 典型用途                         |
> | -------------- | -------------- | -------------------------------- |
> | `Pre-Trigger`  | 在操作**之前** | 输入校验、字段补充、拦截非法请求 |
> | `Post-Trigger` | 在操作**之后** | 日志记录、通知、写入审计表等     |
>
> =>Cosmos DB 还提供了一个基于 HTTP 的 **REST API**，你可以通过它来管理数据库、容器、文档等资源，支持 SQL API 的所有基本操作，包括 **增删改查、创建容器、配置索引、设置 RU、查询文档** 等。

=>具体场景举例：

> 你有一个支付外卖的 **Web Service**，数据存在 **Azure Cosmos DB**。
>
> 新功能要求：每个 Cosmos DB 文档必须有一个名为 `tip` 的属性，且值是数字。
>
> 但是：现有的客户端（网站、移动端）暂时不会更新来设置这个 `tip` 属性，意味着旧文档可能没有 `tip` 字段。
>
> =>使用 Pre-trigger比较好，伪代码
>
> ```
> function preTrigger() {
>   var context = getContext();
>   var request = context.getRequest();
>   var documentToCreate = request.getBody();
> 
>   if (!documentToCreate.hasOwnProperty('tip') || typeof documentToCreate.tip !== 'number') {
>     documentToCreate.tip = 0;  // 默认值
>   }
> 
>   request.setBody(documentToCreate);
> }
> ```





=>Partitioning（分区）和 Horizontal Scaling（水平扩展)

> 在 Azure Cosmos DB 中，**Partitioning（分区）和 Horizontal Scaling（水平扩展）** 是实现**弹性、高性能、高可用性**存储和查询的核心机制。
>
> **Partitioning** 是将数据自动分布到多个物理分区中；**Horizontal Scaling** 是通过增加更多分区，实现存储和吞吐能力的线性扩展。
>
> Cosmos DB 是为全球分布式、大规模应用设计的。当你的数据量或请求量超出单个节点的处理能力时，**需要自动拆分**并分布式存储 —— 这就是 **Partitioning** 的意义。
>
> ## Partition Key（分区键）
>
> - 是你在创建容器时必须指定的字段。
> - Cosmos 会根据该字段的值将数据散列到不同的逻辑分区。
> - 所有相同 Partition Key 的数据：
>   - 会存在同一个逻辑分区中。
>   - 可实现**单分区事务**（比如 Stored Procedure）。
>
> Cosmos DB 用分区键将数据**逻辑划分**，由系统自动管理物理分区来实现**水平扩展**，你只需选择好分区键，系统就能无限扩展你的数据和吞吐能力。
>
> =>**Logical Partition 与 Physical Partition 是一对多的映射关系：**多个 Logical Partition 会被系统自动映射到某一个 Physical Partition 上。

> Cosmos DB Change Feed 是事件驱动应用的核心工具，支持你以流式方式监听文档的创建与更新，并通过 SDK 或 Azure Function 自动处理这些变更。

=>你可以写一个Azure Function 来监视Cosmos DB 有什么文件创建更新  =>Azure Function连接绑定是针对 Cosmos DB 中的具体 Container（容器）

> **Global Distribution** 是 Cosmos DB 的原生功能，你只需选择区域，系统就自动完成数据复制、路由、故障转移等一切配置，无需改代码
>
> 🌍 靠近用户的数据访问（低延迟）
>
> ✅ 高可用性（99.999% SLA）
>
> ⚙️ 多主写或单主写选项 =>Multi-region writes 应用连接最近的区域写入，避免跨洲网络延迟

=>在 Azure Portal 中设置: 左侧导航栏选择：**“Replicate data globally（全球数据复制）”**

> **Consistency Level 是你读取数据时对一致性、延迟、吞吐之间的权衡策略**，Cosmos DB 提供 5 个级别可选，按强到弱排序。
>
> ## 5 种一致性级别对比表
>
> | 一致性级别（从强到弱）              | 延迟 | 吞吐 | 可用性 | 保证（Guarantee）说明                            |
> | ----------------------------------- | ---- | ---- | ------ | ------------------------------------------------ |
> | **Strong**（强一致性）              | 高   | 低   | 低     | 所有副本读到的都是最新写入的数据（线性化一致性） |
> | **Bounded Staleness**（有界过时）   | 中   | 中   | 中     | 数据最多落后 N 秒 或 N 次写入操作（可控旧数据）  |
> | **Session**（会话一致性）           | 低   | 高   | 高     | 当前客户端读写强一致，跨客户端可能看到旧数据     |
> | **Consistent Prefix**（前缀一致性） | 低   | 高   | 高     | 保证读到的数据是按写入顺序排列的前缀             |
> | **Eventual**（最终一致性）          | 最低 | 最高 | 最高   | 不保证顺序，最终你**可能**读到一致的数据         |



=>Azure Cosmos DB 的 Change Feed Processor 主要由以下四个核心组件组成：

```
[Monitored Container]  <-- 监听变更
        ↓
[Change Feed Processor in Compute Instance]
        ↓
[Delegate (用户代码处理变更)]
        ↑
[Lease Container]  <-- 存储进度，协调多个 Compute Instance
```



### Azure Blob Storage 20250623

> **Azure Blob Storage** 是 Azure 提供的**对象存储服务**，用于**存储大量非结构化数据**，如图片、视频、备份文件、日志、模型文件、静态网页等。

=>Azure Blob Storage 与 AWS S3 功能高度相似

> ```
> //结构层级
> Storage Account
>  └── Container（容器）
>        └── Blob（对象文件）
> ```
>
> | 层级                | 说明                                |
> | ------------------- | ----------------------------------- |
> | **Storage Account** | 存储账户，Blob 的最高级别容器       |
> | **Container**       | 类似于文件夹，用于组织 Blob         |
> | **Blob**            | 存储的实际文件（图片、音频、zip等） |

=>所以服务你要去找Storage Account

> ## Blob 的类型
>
> | 类型            | 用途示例                         |
> | --------------- | -------------------------------- |
> | **Block Blob**  | 最常用类型，适合文本、图像、视频 |
> | **Append Blob** | 适合追加型写入（日志文件）       |
> | **Page Blob**   | 适合随机读写（如虚拟磁盘 VHD）   |

> ## 冷热存储分层（Access Tier）
>
> | 层级        | 特点                           | 用途示例               |
> | ----------- | ------------------------------ | ---------------------- |
> | **Hot**     | 访问频繁，价格高，读便宜       | 日常文件、活跃应用数据 |
> | **Cool**    | 偶尔访问，存储便宜，读略贵     | 备份、归档前数据       |
> | **Archive** | 几乎不访问，最便宜，需手动还原 |                        |
>
> **Blob Lifecycle Management（生命周期管理）** 是 Azure Blob Storage 提供的一种**自动化规则系统**，用于在**满足条件时自动执行 Blob 操作**，比如：
>
> - 移动到冷存储（Cool / Archive）
> - 删除旧数据
> - 仅清理特定前缀或标签的数据
>
> 通过生命周期策略，**你可以让旧数据自动迁移到成本更低的层，从而省钱**。



> **Azure Data Lake Storage (ADLS)** 是专为**大数据分析**而设计的、支持 **Hadoop 兼容文件系统** 的**云原生分布式存储服务**，可处理 PB 级数据，适用于机器学习、BI、ETL 等场景。

=>实际上，**ADLS Gen2 是 Blob Storage 的超集**，你创建 Blob Storage 时开启“Hierarchical namespace”即可获得 ADLS 功能。

> **Azure Storage Explorer** 是微软提供的一款免费桌面工具，用于**可视化管理 Azure 存储资源**，如：
>
> - **Blob Storage（对象存储）**
> - **File Storage（文件共享）**
> - **Queue Storage（队列）**
> - **Table Storage（表格）**
> - **Azure Data Lake Storage Gen1 / Gen2（大数据存储）**

=>你可以像操作资源管理器一样拖拽上传下载、右键重命名、预览 JSON 文件等。

> AzCopy 是一款专为 Azure 存储服务优化的数据传输工具，支持高性能、并发、安全地批量复制数据。
>
> | 工具                 | 最适合的场景                               |
> | -------------------- | ------------------------------------------ |
> | **Storage Explorer** | 图形化管理、日常手动操作、浏览、调试       |
> | **AzCopy**           | 批量传输、大文件、高性能、自动化、脚本部署 |

=>Storage Explorer中的Copy/Paste其背后实质也是调用AzCopy命令行

=>Managing Blob Containers with .NET 可以用C#来操作Blob

=>Azure PostgreSQL 在 C# 中通常仍使用 PostgreSQL 标准驱动（如 Npgsql），但 Azure 提供了额外的服务整合功能、管理 API 和性能优化方案，区别于本地 PostgreSQL。

> **Immutable Blob Storage** 是一种为法规合规（如金融、医疗、审计等行业）设计的机制，用于保存“只读、不可篡改”的数据。
>
> ## 两种保护策略（Policy）
>
> ### 1. **Time-based Retention（基于时间）**
>
> - 定义一个“保留时间（比如 7 年）”
> - 这段时间内无法修改、删除 blob
> - 到期后才可更改或删除
>
> ### 2. **Legal Hold（法律保全）**
>
> - 没有固定保留时间
> - 设置一个“标签”锁定 blob
> - 必须手动解除才能修改或删除



ExampTopics:

**如何以合规、安全、顺序一致的方式异步处理 Azure Blob Storage 中的变更日志（Transaction Logs）**，主要用于 **审计用途**。

> 什么是 Azure Blob Storage 的 Change Feed？
>
> **Change Feed** 是一种 **事件日志记录机制**，用于记录对 Blob（包括 block blob 和 append blob）进行的 **创建、修改和删除等操作**。它为开发者提供了类似数据库事务日志的功能，可以 **有序追踪和读取变更历史**。
>
> Change Feed 的数据存储在特殊容器 `$blobchangefeed` 中
>
> =>非常适合 审计合规
>
> =>另外， **Azure Cosmos DB** 也提供了 **Change Feed** 功能，而且非常强大，广泛用于**实时数据处理、事件驱动架构、审计日志、增量ETL等场景**。





## 3.Implement Azure security

### Microsoft Identity Platform 20250624

> Microsoft Identity Platform 是微软提供的一套统一的身份与访问管理平台，主要用于帮助开发者构建安全、现代的应用程序，支持用户登录、访问控制、令牌获取等功能。它是 Azure Active Directory（Azure AD）的一部分，并支持行业标准的身份认证协议。

=>可以大致认为：🟦 Microsoft Identity Platform ≈ 🟨 Amazon Cognito + AWS IAM + 一部分 API Gateway 的权限控制功能。

> Authentication（身份验证） vs Authorization（授权）
>
> | 问题                        | 所属类别           |
> | --------------------------- | ------------------ |
> | "你是谁？" → Login          | **Authentication** |
> | "你能做什么？" → Permission | **Authorization**  |
>
> OAuth 2.0 和 OpenID Connect 是现代身份验证与授权中两个最重要的标准，它们经常一起出现，但**用途不同**。
>
> **OAuth 2.0 是一个授权框架**，它允许一个应用安全地访问用户在另一个服务上的资源，**不需要知道用户的密码**。
>
> **OpenID Connect 是一个基于 OAuth2 的身份认证协议**，它扩展了 OAuth2，添加了 **“你是谁” 的信息**。
>
> | 协议                      | 用途                                                        |
> | ------------------------- | ----------------------------------------------------------- |
> | **OAuth 2.0**             | 授权（Authorization）：**让应用可以代表用户访问资源**       |
> | **OpenID Connect (OIDC)** | 身份认证（Authentication）：**确认用户是谁**（基于 OAuth2） |
>
> 在实际开发中，**OpenID Connect 几乎总是和 OAuth2 一起使用**。

> **App registrations**” 是 **Microsoft Identity Platform** 中的一个核心概念，指的是你在 **Azure Active Directory (Azure AD)** 中注册一个**应用程序的身份**，以便它能与 Azure 的身份系统进行交互，比如用户登录、访问 API 等操作
>
> App registrations 就是你告诉 Azure：“这是我的应用，我希望它能让用户登录、或调用某些 API”，Azure 再为它发一个身份卡 + 门禁权限。
>
> | 配置项                          | 含义                                                         |
> | ------------------------------- | ------------------------------------------------------------ |
> | **Application (client) ID**     | 应用在 Azure 中的唯一标识                                    |
> | **Directory (tenant) ID**       | 当前 Azure AD 租户的唯一标识                                 |
> | **Redirect URI**                | 登录成功后跳转地址（Web app / Mobile app）                   |
> | **Client secret / certificate** | 用于证明应用身份（特别是后端或守护程序）                     |
> | **API permissions**             | 应用请求访问 Microsoft Graph 或其他 API 的权限               |
> | **Supported account types**     | 应用支持哪些用户登录（只支持本组织 / 所有 Azure AD / 所有 Microsoft 账户） |

=>这个所谓的应用可以是你本地的 桌面应用程序 或者 Web Application

=>**Redirect URI**是身份认证后的“回程地址”，系统登录后把用户和 Token 带回你应用的安全入口。

=>Azure **App registration 里的“Certificates & Secrets”** 跟TLS没关系

>  OAuth2 / OpenID Connect 流程
>
> ```
> 用户 → 你的 Web 应用（localhost:3000）
>    ↓
> 跳转至 Microsoft Identity Platform 登录页面(https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize?...)
>    ↓
> 用户输入账户密码 → Microsoft 验证身份
>    ↓
> 成功后，身份平台重定向回你的应用（Redirect URI）,并带上： - OAuth2: `?code=abc123` - OIDC: `?id_token=...` 
>    ↓
> 你的应用接收 token，确认用户身份
>    ↓
> 用户获得登录状态，使用 Access Token 调用 API,比如调用 Microsoft Graph API 获取用户邮箱等
> ```

Security Token:

> 常见的 Security Token 类型
>
> | Token 类型        | 作用                                        | 常见格式                      |
> | ----------------- | ------------------------------------------- | ----------------------------- |
> | **Access Token**  | 授权访问受保护资源（如 API）                | 通常是 JWT                    |
> | **ID Token**      | 描述用户身份，主要用于认证流程              | JWT（OpenID Connect）         |
> | **Refresh Token** | 用来获取新的 Access Token（长时间保持登录） | 通常是 opaque（不可读）字符串 |
> | **SAML Token**    | 用于 SAML 协议的身份验证                    | XML 格式                      |
>
> Security Token 是你登录成功后，系统发给你的“数字身份证 + 门禁卡”，用来证明你是谁，和你能干什么。

> ## Microsoft Identity Platform 的作用与流程
>
> ### 1. **身份验证（Authentication）**
>
> - **身份平台负责验证用户的身份**：当用户点击“登录”时，Web 应用会把用户重定向到 Microsoft Identity Platform 提供的登录页面（托管在 `login.microsoftonline.com`）。
> - 用户输入账号密码，完成身份验证。
> - Microsoft Identity Platform 验证成功后，会生成**身份令牌（ID Token）**，并把用户重定向回你本地的 Web 应用（Redirect URI）。
>
> ### 2. **授权（Authorization）**
>
> - 如果你的应用需要访问用户的 Microsoft 365 资源（比如邮箱、日历、OneDrive），身份平台还会发放 **访问令牌（Access Token）**，允许你的应用代表用户调用 Microsoft Graph API。
> - 你本地应用根据 Access Token 调用受保护 API，获取资源。

> Microsoft Graph API 是微软提供的一个统一 RESTful 接口，用来访问 **Microsoft 365 各种服务和数据**，例如：
>
> - 用户信息（名字、邮箱、头像）
> - 邮件、日历、联系人
> - Teams 聊天与会议

=>你用 Microsoft Teams、SharePoint、Office365，其实已经在用 Azure（只是你未必意识到）——它们运行在 Azure 上，身份依赖 Azure AD，API 用 Graph，开发/扩展需要 Azure App registration。

=>Microsoft Teams、SharePoint、Office 365（现在统称为 Microsoft 365）本质上就是基于 Azure 构建和托管的 SaaS 产品。

> **Microsoft Identity Platform 的 Permissions and Consent（权限与同意）** 是整个身份与授权系统的核心部分，关系到：
>
> - App 能访问哪些用户数据（如邮件、文件、日历等）
> - 是谁授权的（用户本人，还是管理员）
> - 用户或管理员是否已“同意”这些权限请求
>
> Microsoft Identity Platform 支持两种权限模型：
>
> | 权限类型                                  | 描述                                               | 常见用途                         |
> | ----------------------------------------- | -------------------------------------------------- | -------------------------------- |
> | ✅ **Delegated permissions**（委托权限）   | 用户登录后，App 代表用户访问资源。必须有用户在场。 | 用于 Web 应用 / 移动端 / SPA     |
> | ✅ **Application permissions**（应用权限） | App 不需要用户在场，直接以 App 身份访问数据。      | 后端服务 / 守护程序 / 批处理任务 |
>
> ## 三种 Consent 类型总结
>
> | 类型                                               | 授权人   | 适用场景                                         | 是否能代表组织所有人 |
> | -------------------------------------------------- | -------- | ------------------------------------------------ | -------------------- |
> | 1️⃣ 用户同意（**User Consent**）                     | 用户本人 | 请求普通委托权限（如读取自己邮箱、文件）         | ❌ 仅限该用户         |
> | 2️⃣ 管理员代表自己同意（**Admin Consent for self**） | 管理员   | 登录后仅允许该管理员使用 App，但不扩展到其他用户 | ❌ 仅该管理员         |
> | 3️⃣ 管理员全局同意（**Admin Consent for tenant**）   | 管理员   | 授权整个租户中**所有用户**使用该 App             | ✅ 是，全租户授权     |

Azure AD 是身份系统的“后端”，而 Microsoft Identity Platform 是开发者用来接入 Azure AD 的“平台和入口”

想让用户使用 Google（或其他第三方平台）的账号来登录 Azure AD 中的应用,这在 Azure AD 中是完全支持的，属于 **联合身份（Federated Identity）** 的一种场景

**SCIM 是用来让两个系统之间自动同步“用户账号”的标准协议**。它解决了：“在 A 系统创建了用户，要不要再手动去 B 系统创建？”的问题。Azure AD 是 SCIM 的强大支持者。它可以作为： SCIM 客户端（发送方）,Azure AD 把用户同步（创建/删除/更新）到 Zoom、Slack、Workday 等 SaaS

> | 没有 SCIM 的情况                               | 使用 SCIM 后                                       |
> | ---------------------------------------------- | -------------------------------------------------- |
> | 用户入职后要在多个系统重复建账号               | 在 HR 系统或 AD 中建一次，自动同步到所有连接的系统 |
> | 离职时忘记在某些 SaaS 系统删账号，造成安全隐患 | 离职后账号自动从所有系统中删除                     |
> | 用户部门/职位更新需手动修改多个地方            | 自动更新所有系统中用户的属性信息                   |

> “**CAE APIs**” 指的是与 **Continuous Access Evaluation（CAE，持续访问评估）** 相关的 **API 接口或机制**，它是 Microsoft Identity Platform 和 Azure AD 提供的一种 **增强的安全访问控制机制**。
>
> 传统的 OAuth 2.0 / OpenID 认证流程中，Access Token 一旦签发，就**在有效期内始终可用**，即使用户在这段时间内：
>
> - 被管理员禁用了账号
> - 改了密码
> - 发生了高风险行为（如异地登录）
>
> 这些变化**不会立刻影响 Access Token 的有效性**，安全存在滞后性。
>
> CAE 就是为了解决这个问题。
>
> CAE 是一种新一代的访问控制机制，它让 Azure AD 能够在**用户状态变化时，立即通知资源服务端，使其能主动撤销 Access Token 或重新认证**。



> **用户分配的托管身份（User-assigned managed identities）** 是一种可以在多个应用之间复用权限的方式。
> 用户分配的托管身份将托管身份与新应用关联起来，不需要使用密钥或密码。
>
> **系统分配的托管身份（System-assigned managed identities）** 是为每个应用创建一个新的身份，
> 这不符合常见的配置需求（因为不能复用）。
>
> | 特性 / 维度        | 用户分配的托管身份（UAMI）                                   | 系统分配的托管身份（SAMI）                             |
> | ------------------ | ------------------------------------------------------------ | ------------------------------------------------------ |
> | **创建和生命周期** | 独立于任何具体资源创建，可以被多个资源共享。                 | 随资源创建，同时创建；资源删除时身份自动删除。         |
> | **作用域**         | 可以在多个 Azure 资源（VM、App Service、Function 等）间复用。 | 绑定到单个资源，不可跨资源共享。                       |
> | **管理复杂度**     | 需要单独管理身份资源，权限授予在身份级别管理。               | 身份随资源自动管理，无需额外维护。                     |
> | **权限复用**       | ✅ 支持，多个应用可使用同一个托管身份访问相同资源。           | ❌ 不支持，每个应用有独立身份。                         |
> | **资源删除影响**   | 身份独立，删除某个应用不影响身份存在。                       | **资源删除即删除身份，身份随资源生命周期结束。**       |
> | **典型使用场景**   | - 多个服务需要用同一身份访问同一资源- 需要集中管理权限       | - 简单应用或场景- 身份只绑定一个资源- 不需要跨应用复用 |
> | **身份更改影响**   | 独立更改身份配置，不影响已绑定的资源（需要重新绑定）         | 身份随资源变更，自动同步。                             |
> | **角色分配管理**   | 针对身份进行角色分配。                                       | 针对身份进行角色分配，但身份只能用于单一资源。         |



### Azure Active Directory 20250626

=>Azure Active Directory（Azure AD）现在已经正式更名为 Microsoft Entra ID。

> Azure AD（Azure Active Directory）是 Microsoft 提供的**云端身份和访问管理（IAM）服务**，是企业在 Azure 云上进行**用户身份验证、单点登录（SSO）、权限控制**等操作的核心服务。

=>Azure AD 最核心的 功能 第一条 就是 **身份验证（Authentication）**

=>在这里，“**目录（Directory）**”的意思是一个**用户身份信息的数据库**，就像电话簿（Directory）一样，里面记录着每个用户的信息

> ##  类比关系（更贴切的比喻）
>
> | Azure 产品                           | AWS 对应                     |
> | ------------------------------------ | ---------------------------- |
> | **Azure AD（企业内部用户身份管理）** | AWS IAM（更类似）            |
> | **Azure AD B2C（面向外部用户）**     | **AWS Cognito（User Pool）** |
>
> ### 公司内部使用
>
> > 目标：员工用公司账号访问 SharePoint、Teams、Salesforce 等
> >  ✅ 用 **Azure AD**
>
> ### 客户访问你的电商网站
>
> > 目标：让用户用 Google / Facebook 登录你的网站
> >  ✅ Azure 用 **Azure AD B2C**
> >  ✅ AWS 用 **Cognito**

=>Azure AD 是为组织内部员工身份管理设计的，Azure AD B2C 是为客户/消费者身份管理设计的。

=>Azure AD不仅管users，而且还可以管 Apps, Mobile device



```
+------------------------------------------------------------+
|                         用户身份管理                        |
+------------------------------------------------------------+

          +----------------+             +----------------+
          |  本地 Active   |             |  Azure Active  |
          | Directory (AD) |             | Directory (Azure AD) |
          +----------------+             +----------------+
                  |                               |
                  |                               |
        Azure AD Connect 同步                      |
                  |                               |
                  v                               v
          +---------------------------------------------+
          |           Azure Active Directory             |
          |  (云端身份管理，OAuth/OpenID Connect 协议)    |
          +---------------------------------------------+
                                  |
                                  | 同步用户、组及密码哈希
                                  v
          +---------------------------------------------+
          |       Azure AD Domain Services (Azure AD DS)|
          |  （托管的传统域服务，提供 LDAP/Kerberos/GPO）|
          +---------------------------------------------+
                                  |
            +------------------------------------------+
            |         Azure 虚拟机/应用/传统程序        |
            | （可加入 Azure AD DS 域，实现组策略等）  |
            +------------------------------------------+

```

=>Azure AD DS 是微软提供的托管传统 Active Directory 域服务，帮助企业在 Azure 云环境中无缝支持依赖传统域功能(提供 LDAP、Kerberos、NTLM、域加域登录、GPO 等传统 AD 功能)的应用和资源，减少运维负担。

> **Azure AD DS 是专门为 Azure 云上的资源设计的托管域服务**，它帮助虚拟机等云资源“加入域”、使用传统认证协议和组策略，但它不直接管理本地 AD 的用户或设备。
>
> **本地 AD 仍然负责本地用户和设备的身份管理**。如果企业同时使用本地 AD 和 Azure AD（通过 Azure AD Connect 同步），那么云上的用户身份会同步到 Azure AD，Azure AD DS 再基于 Azure AD 提供传统域服务。

> 域控制器（Domain Controller, DC）是一个服务器，用来存储和管理组织内部的身份信息，并控制用户和计算机如何登录、访问资源。
>
> 你公司有个叫 `corp.local` 的内部域，DC 可能是一个 Windows Server
>
> Azure AD Domain Services（Azure AD DS） 提供 DC 功能



> Azure AD SSO 是一种机制，允许用户登录一次，就可以无缝访问多个企业应用和服务，而无需重复输入账号密码。
>
> Azure AD SSO 是一种“身份联邦”机制，让所有第三方应用统一通过 Azure AD 登录，从而实现单点登录和集中化身份管理——而不是把这些应用本身“托管”到 Azure 上。

=>**这些第三方应用虽然不部署在 Azure 上，但可以**通过 Azure AD 实现 SSO 登录，就像它们‘接入了 Azure 身份体系’一样

=>Multi-Factor Authentication也是Azure AD里设置的，可以针对Azure上某些具体的应用

> 配置 **Azure AD Identity Protection** 是提升 Azure 身份安全的关键一环，它能够智能地识别和响应用户、登录行为中的风险。

=>MFA 和 Azure AD Identity Protection 都需要给Azure AD 加钱上套餐



> **Tenant（租户）** 是 Azure Active Directory 中的一个 **独立实例**，表示一个组织在 Azure AD 中的“身份边界”。
>
> 每个租户拥有自己独立的用户、组、应用和策略，彼此隔离，不共享数据。

=>一个用户**不能**直接属于两个 Azure AD 租户（Tenant）

| 项目                       | Azure Account                                                | Azure AD User                                                |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **本质**                   | 用于订阅和计费的“账户”，通常是一个 Microsoft 账户或工作/学校账户 | 是 Azure Active Directory 中的对象，代表一个人或服务         |
| **控制范围**               | 管理 Azure 订阅、资源组、计费等                              | 用于访问 Azure AD 中的资源，如登录应用、加入组等             |
| **账号例子**               | `you@hotmail.com`、`you@company.com`                         | 在某个租户中的 `user@yourtenant.onmicrosoft.com`             |
| **可登录门户？**           | ✔️ 可以登录 Azure Portal                                      | ✔️ 可以登录 Portal（如果分配权限）                            |
| **是否可以属于多个租户？** | ✔️ 是，可以管理多个租户                                       | ❌ 默认“属于”一个租户，但可以被“邀请”访问其他租户（B2B guest） |

> ```
> 公司 Azure 账户（admin@contoso.com）
>      │
>      ├─ Azure AD Tenant：contoso.onmicrosoft.com
>      │    ├─ 用户：alice, bob, charlie
>      │    ├─ 组：工程部、人事部
>      │    └─ 安全策略、SSO、MFA
>      │
>      └─ Azure Subscription：Contoso-Prod-Sub
>            ├─ 资源组1：WebApp-Group
>            │     └─ Azure App Service
>            ├─ 资源组2：Database-Group
>            │     └─ Azure SQL
>            └─ 资源组3：VMs
>                  └─ Azure Virtual Machine
> 
> ```

=>某家公司在开始使用 Azure 服务时，通常由 IT 部门的一名员工使用公司邮箱（例如 `admin@contoso.com`）注册 Azure 账号。注册完成后，系统会自动为其创建一个 **Azure Active Directory（Azure AD）租户**，如 `ericsson.onmicrosoft.com`（当然，也可以手动额外创建其他租户）。

在这个租户中，管理员可以添加其他员工的账号（如 `user1@ericsson.onmicrosoft.com`），将他们组织进不同的 **安全组（Security Group）**，并分配相应的权限。=>AWS 安全组 ≠ Azure 安全组 ≠ Azure AD 安全组

随后，该租户下可以创建多个 **Azure 订阅（Subscription）**，例如：

- `BuskKDDIAutomationTest`
- `Production-Apps`
- `DevOps-Pipeline`

这些订阅可以用于隔离资源（如测试/生产环境），并进行独立的计费和访问控制。

**每个用户可以被分配到一个或多个订阅中，并拥有不同的访问角色（如 Reader、Contributor、Owner）。**



> ##  一句话总结
>
> - **Tenant（租户）** = 身份/组织的容器（Azure Active Directory）
> - **Subscription（订阅）** = 资源/服务的容器（你部署 VM、数据库的地方）

=>Subscription下面有多个Resource Group

| 方面       | Subscription（订阅）                       | Resource Group（资源组）                   |
| ---------- | ------------------------------------------ | ------------------------------------------ |
| 作用       | 管理计费、配额、访问权限的顶层单位         | 组织和管理资源的逻辑容器                   |
| 范围       | 包含多个资源组和资源                       | 包含同一资源组下的多个资源                 |
| 生命周期   | 影响所有订阅内资源的计费和配额             | 控制资源组内资源的批量创建、更新、删除     |
| 访问控制   | 通过角色分配控制对订阅及其资源组的访问权限 | 通过角色分配控制对资源组及其资源的访问权限 |
| 跨区域支持 | 一个订阅可包含不同区域的资源               | 资源组内资源可以分布在不同区域             |





### Azure Microsoft Graph 20250630

> Microsoft Graph 是微软提供的一个 API 网关，开发者可以通过它用一套标准接口整合和访问 Microsoft 365（如 Outlook、Teams、OneDrive、SharePoint）和 Azure AD 的数据。

=>比如可以控制在SharePoint上创建删除文件... 同样可以操作 OneDrive和Teams

> Microsoft 365 是微软提供的一个集办公、协作、安全与云服务于一体的 SaaS（软件即服务）平台，包含 Office 应用、Exchange 邮件、Teams、SharePoint 等。

> **Microsoft Graph Connectors** 是 Microsoft 365 提供的一种机制，允许你将 **外部数据源**（如数据库、文件系统、第三方 SaaS 系统）中的内容引入到 **Microsoft 365 的搜索体验** 中，比如：
>
> - **Microsoft Search**（SharePoint、Office.com、Bing for Work 中的搜索）
> - **Microsoft 365 Copilot**（可引用这些数据）
> - **Microsoft Graph API**（通过 `/external/connections` 使用）

> Microsoft Intune 是微软提供的移动设备管理（MDM）与移动应用管理（MAM）服务，属于 Microsoft Endpoint Manager 的一部分。
>
> Intune 就像企业 IT 的“远程管控平台”，让管理员可以统一管理所有员工设备，确保数据安全、合规可控。

## 4.Monitor,troubleshoot and optimize Azure solutions

### Azure Application Configuration 20250701

> **Azure App Configuration** 是 Azure 提供的一项服务，用于集中管理应用程序的配置设置和 feature flags（功能开关），支持多个环境、微服务或部署实例共享同一份配置。

> 在现代云原生架构中，一个应用可能包含多个环境（Dev/Test/Prod）、多个微服务，每个组件都可能有自己的配置项，例如：
>
> - 数据库连接字符串
> - API 密钥
> - 第三方服务 URL
> - 是否开启某个功能
>
> 传统做法是把这些配置写在 appsettings.json、环境变量中。但这样不易统一管理、不方便动态更新、不安全。
>
> 👉 **Azure App Configuration 解决了这些问题：集中化、统一、版本化、支持热更新。**

> 所有配置项都以 `key:value` 形式存储
>
> 支持基于角色的访问控制（RBAC）

=>还可以践行 Configuration as a code， 导入Github进行版本管理，与Azure DevOps集成得也很好

> 在 **Azure App Configuration** 中，**Feature Flags** 是一种控制“是否启用某个功能”的配置项，可以在不中断服务、不重新部署代码的情况下打开或关闭功能。。它是实现 **灰度发布、A/B 测试、逐步部署、按用户启用功能** 等现代软件开发模式的重要手段。
>
> | 场景         | 说明                               |
> | ------------ | ---------------------------------- |
> | 灰度发布     | 先对小部分用户开放某功能           |
> | A/B 测试     | 同时启用 A/B 版本，观察用户行为    |
> | 快速回滚     | 新功能异常时，关闭开关而非回滚部署 |
> | 动态配置开关 | 无需重启服务即可启用/禁用功能      |
>
> =>每个 Feature Flag 存储为特殊的 key, 其值为 JSON 格式，例如：
>
> ```json
> {
>   "id": "BetaFeature",
>   "enabled": true,
>   "conditions": {
>     "client_filters": []
>   }
> }
> ```

> **Refresh Policies** 控制 Azure App Configuration 的客户端（如 .NET 应用）多久、如何自动检测配置更新，从而实现“动态配置、无需重启”。

=>在C#代码端进行设置Refresh Policies，定时去读取配置

> 在 Azure 中，**Key Vault** 和 **App Configuration** 虽然是两个独立的服务，但它们可以协同工作，各自负责不同类型的配置和安全信息。
>
> 你可以在 **App Configuration 中引用 Key Vault 的值**，达到集中配置与集中机密管理相结合的效果。

> **Azure App Configuration 的 Geo-replication（地理复制）** 是为了提升应用配置在多区域的可用性、容错性和性能而设计的一项特性

### Caching in Azure 20250704

> **Azure Front Door** 是微软 Azure 提供的一个 **全局分布式的应用交付网络平台**，主要用于提升网站或应用的**性能、安全性与高可用性**。
>
> 简单来说，它是一个高性能、智能的“门面”系统，站在你的网站或应用前端，帮你做：
>
> - 加速内容传输（CDN功能）
> - 智能流量分发（负载均衡）
> - 自动故障转移（提高可用性）
> - Web应用防火墙（WAF）保护
>
> ```
>                 ┌────────────┐
> User Request →  │ Front Door │
>                 └────┬───────┘
>                      ↓
>         ┌────────────┴────────────┐
>         │  路由 & 负载均衡 & 缓存  │
>         └────────────┬────────────┘
>                      ↓
>     ┌────────────┬────────────┬────────────┐
>     │ App Region1│ App Region2│ App Region3│
>     └────────────┴────────────┴────────────┘
> ```

=>做了个试验，创建了两个region的web app，然后创建了个Front Door去连接这两个web app，发现只有两个web app都停止的时候，Front Door那边显示的网页才变成403  （用户访问的 URL 应该指向 Front Door 的域名，而不是后端的 Web App。）

> | Front Door 配置项     | 功能说明                                         |
> | --------------------- | ------------------------------------------------ |
> | **Frontend Endpoint** | 用户访问的网址，比如 `www.contoso.com`           |
> | **Routing Rules**     | 定义 URL 路由方式（路径匹配、转发规则）          |
> | **Backend Pool**      | 后端服务的列表，如 Azure App Service、VM、API 等 |
> | **Health Probes**     | 检测每个后端的健康状况，决定是否切换             |
> | **WAF Policies**      | 防火墙规则（可选）                               |
> | **SSL Certificates**  | TLS 证书管理（可配置）                           |

=>千万不要拘泥于名字类似认为Front Door 局限于**Frontend Endpoint**！

=>Front Door 可以理解为是“**带 CDN 和智能路由的 L7 全球级loader balancer**”。



> Azure Content Delivery Network（**Azure CDN**）是微软提供的**全球分布式内容加速服务**，用于提高网站、应用程序和 API 的性能、可靠性和可扩展性，尤其适合静态内容（如图片、视频、JS、CSS）的加速分发。
>
> Azure CDN 会将你的内容缓存（复制）到全球的 CDN 边缘节点（POP），用户访问时从**离他们最近的节点获取内容**，从而减少延迟、提高加载速度。
>
> ```
> 用户 → 最近的CDN边缘节点（POP） → 缓存中有 → 直接返回  
>                                      ↓  
>                               没有缓存 → 向源站（Web App、Blob等）请求 → 缓存 → 返回用户
> 
> ```

> **CDN Endpoint** 是用户访问 CDN 内容的公共域名地址，
>  它会将请求转发给你设置的源站，并**缓存内容以实现加速和负载缓解**。

=>**Azure 把新一代 Azure CDN 和 Front Door 集成到了同一个平台中**，叫做：Azure Front Door + CDN Profile

> 现在你在创建加速服务时，不再分开创建“CDN”和“Front Door”，而是在一个统一入口中完成：
>
> ```
> Front Door and CDN Profile → Endpoint → 路由规则、缓存策略、WAF等
> ```
>
> 新结构下，你创建 Endpoint 实际上是：创建一个 **Front Door + CDN Endpoint**
>
> 它支持：
>
> - 静态资源缓存
> - 动态内容路由
> - WAF（Web Application Firewall）
> - 自定义缓存策略
> - 自定义规则引擎

> **Redis**（**Re**mote **Di**ctionary **S**erver）是一个开源的、**基于内存**、**高性能**、**支持多种数据结构**的**键值型（Key-Value）NoSQL数据库**，广泛用于缓存、消息队列、实时排行榜、会话存储等场景。

> **Azure Cache for Redis** 是在 Azure 云平台上运行的 **高性能、分布式、内存缓存服务**，基于开源 Redis，适用于加速应用程序的读写性能，减轻数据库负载，构建实时应用

### Application Troubleshooting 20250707

> Azure Monitor 是 Microsoft 提供的一项**综合性监控服务**，用于收集、分析和响应来自 Azure 和本地环境中的**应用程序、基础设施和网络资源**的遥测数据。它是实现**可观测性（Observability）**的核心工具之一。
>
> ## Azure Monitor 能监控哪些内容？
>
> | 类型           | 示例                                      |
> | -------------- | ----------------------------------------- |
> | **应用层**     | Web App 性能（如响应时间、失败率）        |
> | **基础设施层** | VM、容器、Kubernetes、数据库运行状态      |
> | **网络层**     | 网络延迟、带宽利用率、连接错误等          |
> | **平台资源**   | Azure 服务（如 Storage、Key Vault）的性能 |
> | **自定义数据** | 应用程序日志、用户行为数据、自定义指标等  |
>
> ##  核心功能模块
>
> ### 1. **数据收集（Data Collection）**
>
> - 包括：
>   - **Metrics（指标）**：数值型数据，如CPU使用率、内存占用、响应时间等。
>   - **Logs（日志）**：如应用日志、诊断日志、活动日志等。
>
> > 数据来源包括 Azure 资源、本地系统、用户定义的自定义数据等。
>
> ### 2. **分析（Analyze）**
>
> - 使用 **Log Analytics（Kusto 查询语言 - KQL）** 查询和分析日志。
> - 支持 **工作簿（Workbooks）** 展示自定义仪表盘。
> - 可以与 **Azure Data Explorer** 进行深度分析集成。
>
> ### 3. **可视化（Visualize）**
>
> - 提供图表、表格、地图等方式展示数据。
> - 可将数据集成到 Power BI、Grafana 等工具中。
>
> ------
>
> ### 4. **告警（Alerts）**
>
> - 设置监控阈值自动触发告警。
> - 支持邮件、短信、Webhook、Logic Apps、Azure Functions 等方式通知或自动响应。
>
> ### 5. **自动化响应（Autoscale & Action Groups）**
>
> - 自动根据负载调整资源（如自动扩展 VM 实例数）。
> - 告警触发后可以执行自动化操作，如重启服务、调用函数等。

=>Azure Monitor 是一个大平台，Application Insights 是它的一个子组件。

> | 项目         | Azure Monitor                         | Application Insights                         |
> | ------------ | ------------------------------------- | -------------------------------------------- |
> | **本质**     | 一个全栈监控平台                      | Azure Monitor 的子服务，用于**应用程序监控** |
> | **监控层级** | 全栈（应用、虚拟机、数据库、网络等）  | 应用层（代码、请求、依赖、异常等）           |
> | **适用对象** | 所有 Azure 资源、本地资源、自定义资源 | Web 应用（.NET、Java、Node.js 等）           |

**Log Analytics** 是 **Azure Monitor 的核心组件之一**，用于：

> 🔍 **收集、分析和查询日志数据（Logs）** 的强大工具。它基于 **Kusto Query Language (KQL)**，支持对 Azure 各类资源和自定义数据进行深入分析、排查故障、做报表与告警。
>
> Kusto Query Language（KQL）
>
> 使用 KQL 来像写 SQL 一样查询日志数据。
>
> 示例 1：查看过去 1 小时内失败的 HTTP 请求
>
> ```
> requests
> | where timestamp > ago(1h)
> | where resultCode startswith "5"
> | summarize count() by bin(timestamp, 5m)
> ```

> 你可以把 **Metric** 想象成资源的**“健康体征监测数据”**，比如：
>
> - CPU 使用率（%）
> - 内存使用量（MB）
> - 请求数量（count）
> - 响应时间（ms）
> - 磁盘读写速率（IOPS）
>
> 它们是**定时采样**的数据，通常以图表的形式展示，可以用来设置告警或触发自动扩缩容。
>
> ##  与 Log 的区别
>
> | 项目     | Metric（指标）                   | Log（日志）                      |
> | -------- | -------------------------------- | -------------------------------- |
> | 结构     | 简单数值 + 时间戳                | 结构化或非结构化文本             |
> | 格式     | 定时采样的数值                   | 多种格式（JSON、文本等）         |
> | 用途     | 实时监控、自动扩展、告警         | 故障排查、审计记录、深度分析     |
> | 查询语言 | 直接在“指标”界面或 REST API 查询 | 使用 KQL（Kusto Query Language） |

> Azure Event Hubs 是一个为“高吞吐量事件摄取”设计的实时数据流平台，常用于日志聚合、IoT 数据收集、实时分析等场景。
>
> 在 Azure Monitor 中，Event Hubs 是“日志数据的出口”，用于把诊断数据实时流式地发送到外部分析平台。
>
> ## 如何在 Azure Monitor 中配置 Event Hubs？
>
> 1. 进入资源（如 NSG、Key Vault、App Service）
> 2. 打开：**“监视（Monitor）→ 诊断设置（Diagnostic Settings）”**
> 3. 点击：**“添加诊断设置”**
> 4. 勾选日志类型（如：审计日志、安全日志、流日志等）
> 5. 选择导出目标为：**Event Hub**
> 6. 选择 Event Hub 命名空间与名称

> Azure Log 是“原始数据”本身，而 Log Analytics 是“集中存储 + 查询 + 可视化”这些日志的工具。

> **Azure Monitor 是 Azure 原生自带的服务**，在你创建 Azure 资源（如 VM、App Service、AKS、SQL 等）时，**监控功能就已经默认集成**在里面了。
>  你**不需要额外“创建 Azure Monitor 本身”这个资源**，但你可以**选择开启一些扩展功能**（比如诊断设置、告警规则、Log Analytics 工作区等）

=>Azure 中的 **Monitor（监视）** 既有一个**“全局统一入口”**，也**嵌入在每个资源的左侧导航栏中**。它其实是一整套服务的界面集成表现。

> > **Diagnostic setting（诊断设置）** 是 Azure 中一个关键功能，用于将 **资源的日志（Logs）和指标（Metrics）** 发送到你指定的目标位置进行**集中化存储、分析和告警**。
>
> 换句话说：它是你**打开监控“出口”的地方**，不设置就看不到详细日志！
>
> 你可以将日志/指标发送到以下 **最多三个** 目标之一或多个：
>
> | 目标                        | 说明                                     |
> | --------------------------- | ---------------------------------------- |
> | **Log Analytics workspace** | 推荐！用于查询、分析、告警（Kusto 查询） |
> | **Storage Account**         | 用于长期归档保存                         |
> | **Event Hub**               | 用于实时流转到 SIEM、第三方工具等        |



Azure Automation

> **Azure Automation 是一个强大的“云端脚本调度 + 系统管理平台”，适合自动执行各种日常运维与资源控制任务。**
>
> ##  Azure Automation 能做什么？
>
> | 功能                                | 描述                                        | 示例                                         |
> | ----------------------------------- | ------------------------------------------- | -------------------------------------------- |
> | ✅ **Runbooks（运行手册）**          | 自动执行的脚本（支持 PowerShell 和 Python） | 自动启动 VM、关闭 VM、重启服务、定期清理资源 |
> | ✅ **Scheduled jobs（定时任务）**    | 设置定时器，定期运行脚本                    | 每天 18:00 自动关闭开发环境 VM               |
> | ✅ **Update Management（更新管理）** | 自动打补丁、更新 Windows/Linux VM           | 每月第二个周二为 VM 安全打补丁               |
>
> ## 它与 Logic Apps / Function 有什么区别？
>
> | 项目     | Azure Automation          | Azure Functions        | Logic Apps               |
> | -------- | ------------------------- | ---------------------- | ------------------------ |
> | 类型     | 运维任务平台              | 事件驱动函数           | 可视化工作流             |
> | 语言     | PowerShell、Python        | C#、JavaScript、Python | 无代码，拖拽式           |
> | 优势     | 脚本强大、适合运维任务    | 快速开发、函数即服务   | 低代码、易集成           |
> | 使用场景 | 重启 VM、打补丁、定时脚本 | API 封装、数据转换     | 集成 SaaS 系统、审批流程 |

=>**Azure Automation 就像是一个 Azure 官方提供的“轻量级 Ansible + 定时任务服务器”**，你可以用它从云端远程控制**Azure VM、本地服务器、甚至 AWS EC2 实例**。

Azure Network Watcher

> **Azure Network Watcher** 是 Azure 提供的一个**网络诊断与监控服务**，专门用于：
>
> > ✅ **监控、诊断、查看和排查 Azure 虚拟网络中的通信问题与网络性能瓶颈。**
>
> 你可以把它看作是：
>
> > 🛠️ **Azure 虚拟网络（VNet）的“抓包工具箱 + 网络医生 + 拓扑查看器”。**

Microsoft Defender for Cloud

> **Microsoft Defender for Cloud（以前叫 Azure Security Center）** 是 Azure 的一项**云安全防护平台服务（CSPM + CWPP）**，专门用于：
>
> > ✅ **发现风险、强化配置、检测威胁、自动修复，保护你在 Azure、其他云（如 AWS/GCP）、甚至本地的数据和资源安全。**

=>Defender for Cloud 需要底层的 VM 支持深入的分析和集成（如漏洞扫描、依赖项分析、吊起 DNS 检查）,所以跟 SKU息息相关，是的，只有在特定 SKU（如 Standard / Premium）以上，你才能启用 Defender for Cloud 的完整功能，包括 DNS 吊起监控。Consumption Plan 是 serverless 架构，资源极度弹性和临时，**无法持续追踪域名配置等状态**



=>设置报警

```
az monitor metrics alert create \
  --name high-cpu-alert \
  --resource-group my-rg \
  --scopes /subscriptions/.../resourceGroups/my-rg/providers/Microsoft.Compute/virtualMachines/myVM \
  --condition "avg Percentage CPU > 80" \
  --severity 2 \
  --evaluation-frequency 1m \
  --window-size 5m \
  --auto-mitigate true \
  --description "High CPU usage alert for VM" \
  --action my-action-group
```

> | 参数                                 | 说明                                                         |
> | ------------------------------------ | ------------------------------------------------------------ |
> | `--action`                           | 当警报被触发时要执行的动作，例如发送邮件、调用 webhook、触发自动化等。通常是 Action Group 的资源 ID 或名称，例如：`--action /subscriptions/.../actionGroups/my-action-group` |
> | `--auto-mitigate`                    | 是否在问题解决后自动将警报重置为已解决（默认 `true`）。设置为 `false` 会保留告警状态直到手动清除。 |
> | `--description`                      | 为此告警规则添加说明文字。                                   |
> | `--disabled`                         | 是否在创建后立即禁用警报。`true` 表示创建后不会自动启用；默认 `false`。 |
> | `--evaluation-frequency`             | **多久评估一次指标数据**（默认值通常为 1 分钟或 5 分钟）。支持单位：`m`（分钟）、`h`（小时）例如：`1m`, `5m`, `15m` |
> | `--region`                           | 警报规则本身的部署区域（不是监控资源的区域）。例如：`eastus`, `japaneast` |
> | `--severity`                         | 告警严重等级，数值范围 0 到 4：`0` = 严重，`4` = 信息性告警。例如：`--severity 2` |
> | `--tags`                             | 为告警规则添加标签（Key=Value 格式），如：`--tags team=dev env=prod` |
> | `--target-resource-type` 或 `--type` | 指定要监控的资源类型，如 `Microsoft.Compute/virtualMachines`。 |
> | `--target-resource-region`           | 被监控资源的部署区域，例如 `eastus`。有助于在资源类型不唯一时精确匹配。 |
> | **`--window-size`**                  | **每次评估时使用的时间窗口长度**，用于聚合指标数据（非常重要）。例如：`5m`, `10m`, `1h`表示“在过去多少时间内的数据是否超过阈值”。 |







## 5.Connect to and consume Azure services and third-part services

### Azure API Management 20250708

> Azure API Management 是一个帮助你把后端服务（REST、SOAP 等）包装成 API，安全地发布给内部或外部用户访问的工具。
>
> 你公司有一套后端服务（.NET、Java 或数据库），你想要把这些服务发布为安全的 API 给外部合作伙伴用，同时不希望暴露原始服务地址：
>
> ✅ 用 Azure API Management，你可以：
>
> - 给 API 加认证（比如必须有订阅密钥）
> - 限制每秒访问次数（防止滥用）
> - 自动生成 Swagger 文档和测试界面
> - 查看调用量和失败统计
>
> ```
> [客户端/调用方] → [Azure API Management] → [你的后端服务（Web App, Function, VM 等）]
> ```

> > **Policies（策略）** 是 Azure API Management 中的一种配置机制，允许你**在 API 请求或响应的过程中，插入一系列规则或逻辑**
>
> 你可以把它理解为：**“API 的中间件逻辑”，无需修改后端服务代码。**
>
> 这些策略是以 **XML 格式编写的**，在 API 的不同阶段（inbound、backend、outbound、on-error）进行执行。
>
> | 策略类型           | 功能举例                              |
> | ------------------ | ------------------------------------- |
> | **认证**           | 检查 JWT Token、有无订阅密钥          |
> | **重写请求内容**   | 修改 URL、Headers、Body 等            |
> | **格式转换**       | 将 XML 转为 JSON，或反之              |
> | **流量控制**       | 限流（rate-limit）、配额（quota）     |
> | **缓存**           | 响应缓存，提高性能                    |
> | **重试与超时控制** | 请求失败自动重试、设置超时时间        |
> | **条件分支处理**   | 根据用户或请求参数走不同逻辑          |
> | **调用链日志记录** | 调用 Application Insights、Trace、Log |
>
>  示例：检查 JWT Token 并提取信息
>
> ```xml
> <inbound>
>     <validate-jwt header-name="Authorization" require-scheme="Bearer">
>         <openid-config url="https://login.microsoftonline.com/xxx/.well-known/openid-configuration" />
>         <required-claims>
>             <claim name="roles">
>                 <value>admin</value>
>             </claim>
>         </required-claims>
>     </validate-jwt>
> </inbound>
> ```

> API Versioning 是在接口路径、参数或头信息中加入“版本信息”，从而允许同时维护多个版本的 API。

> **Developer Portal** 是 Azure API Management 提供的一个自带的网站，供开发者查阅、测试和订阅 API，用于构建 **开发者友好的 API 体验平台**。

=>Azure API Management 的 Developer Portal 是基于 Swagger（OpenAPI）规范生成文档，但远比 Swagger UI 强大，提供完整的开发者体验平台。

> 你可以通过在 APIM 中设置缓存策略（policy）来缓存某些 API 响应，从而避免每次都请求后端。

=>想起上次JIRA公司的 提问，如何缩短页面响应时间

> **Quotas（配额）** 和 **Throttling（限流）** 是 API 管理中两个非常重要的流量控制机制，特别是在 Azure API Management（APIM）中，它们经常被结合使用，但**含义不同、作用不同**。
>
> ------
>
> ## ✅ 一句话区分：
>
> | 名称           | 含义                                                         |
> | -------------- | ------------------------------------------------------------ |
> | **Quota**      | 限定用户 **在一定时间内最多能使用多少次资源**（如每天 1000 次） |
> | **Throttling** | 限制用户 **短时间内的访问速率**，避免突发流量（如每分钟最多 60 次） |

=>可以在Inbound policies上设置Quota 和 Throttling



RestAPI与soap的异同:

> | 维度         | REST API                             | SOAP                                   |
> | ------------ | ------------------------------------ | -------------------------------------- |
> | **协议类型** | 架构风格（更灵活）                   | 协议标准（更规范）                     |
> | **数据格式** | 支持 JSON、XML、YAML 等（常用 JSON） | 只能使用 XML                           |
> | **消息结构** | 无固定结构，简洁明了                 | 严格的 Envelope/Header/Body 结构       |
> | **易用性**   | 简单，开发方便                       | 学习成本高，开发复杂                   |
> | **传输性能** | 轻量，效率高                         | 重，传输开销大                         |
> | **功能支持** | 只做基本请求（GET、POST 等）         | 支持复杂功能（如事务、安全、消息保证） |
> | **标准规范** | 无统一标准，自由灵活                 | 拥有 WSDL、XSD 等标准，接口严格描述    |
> | **状态管理** | 通常无状态（stateless）              | 可以是有状态（stateful）               |
>
> SOAP 请求（XML）：
>
> ```xml
> <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
>   <soap:Body>
>     <GetUser xmlns="http://example.com/user">
>       <UserId>123</UserId>
>     </GetUser>
>   </soap:Body>
> </soap:Envelope>
> ```
>
> **REST API** 更轻量、灵活、适合现代 Web & 移动开发；
>  **SOAP** 更正式、规范、适用于企业级、强安全性的系统对接。

=>**SOAP 本身不定义 GET、PUT、POST 等方法，它是基于 XML 的通信协议**，通常通过 HTTP 的 POST 方法传输数据。**不是 RESTful 风格**所有请求走 POST，但根据请求内容和 WSDL 来决定具体业务操作

JWT是什么：

> JWT（JSON Web Token）是一种轻量、安全、跨平台的认证令牌，广泛用于 Web 和移动端身份验证与授权。
>
> | 项目           | JWT                | mTLS                    |
> | -------------- | ------------------ | ----------------------- |
> | 被盗用风险     | 高（Token 泄露）   | 低（私钥+证书双重保护） |
> | 中间人攻击抵御 | 依赖 HTTPS         | 强（TLS 层自动保护）    |
> | 强认证         | 一般               | 强                      |
> | 动态撤销       | 难（需维护黑名单） | 易（吊销证书）          |



> 你可以把 Azure Function 导入进 API Management 的一个 API 中，这样用户通过 APIM 访问 Function，而不是直接访问 Function URL。
>
> ```
> Client
>   ↓
> [API Management]
>   ↓  执行策略、认证、限流、监控
> [Azure Functions]
>   ↓
> 响应处理后返回给客户端
> ```

=>Function 必须是 **HTTP trigger** 类型

> 你可以通过 Azure AD 对 API 进行保护，让调用方必须先通过 Azure AD 获取 Token，再带着这个 Token 来调用你的 API。
>
> ```
> [Client App] 
>    ↓  (get token from Azure AD)
> [Azure AD]  ←—— 应用注册
>    ↓  (token)
> [APIM] 
>    ↓  (验证 JWT token via validate-jwt policy)
> [Backend API / Azure Function]
> ```

=>API Management可以设置Multi-region和scaling



右侧菜单栏：APIs,Product,Subscription

> ```
> [API1]         [API2]
>    \             /
>    ---> [Product A]  --->  [Subscription] (Key1/Key2)  --->  [Developer/User]
> ```
>
> 多个 API 放进 Product
>
> 用户订阅 Product
>
> 获得一个 Subscription Key
>
> 用 Key 访问 Product 中的所有 API





### Azure Event Grid 20250710

> **Azure Event Grid** 是 Azure 提供的 **事件驱动架构服务（Eventing Service）**，它可以在 **服务之间高效、安全地传递事件通知**。
>
> Event Grid = “**事件发布 → 路由 → 通知订阅者**” 的服务，支持 Serverless、解耦、高吞吐。
>
> ```
> [事件源] ——> [Event Grid] ——> [事件处理者（订阅者）]
>    Blob、VM、Event Hub         Function, Logic App, Webhook, Queue
> ```
>
> ## 举个例子：
>
> > “你在 Blob Storage 上传了一张图片，Event Grid 自动触发 Azure Function，对图片进行缩放、加水印、入库。
>
> Azure Event Grid 的 **Event Schema（事件架构）** 定义了事件的格式结构。Event Grid 发送的每个事件都是一个 JSON 对象，包含了一些**标准字段（common properties）** 和 **事件数据（data）**。
>
> ```json
> [
>   {
>     "id": "1234abcd",
>     "eventType": "Microsoft.Storage.BlobCreated",
>     "subject": "/blobServices/default/containers/images/blobs/cat.jpg",
>     "eventTime": "2024-07-09T09:30:00Z",
>     "data": {
>       "api": "PutBlob",
>       "clientRequestId": "abc123",
>       "requestId": "xyz789",
>       "eTag": "0x8DXXXXXXXXXXXX",
>       "contentType": "image/jpeg",
>       "contentLength": 34567,
>       "blobType": "BlockBlob",
>       "url": "https://mystorage.blob.core.windows.net/images/cat.jpg"
>     },
>     "dataVersion": "1.0",
>     "metadataVersion": "1",
>     "topic": "/subscriptions/xxxxx/resourceGroups/my-rg/providers/Microsoft.Storage/storageAccounts/mystorage"
>   }
> ]
> ```

=>Event Grid 与Event Hub名字相似但**用途完全不同**, 前者是 事件路由（事件驱动），后者是 数据流管道（日志/遥测流）

> | 服务           | 一句话说明                                                   |
> | -------------- | ------------------------------------------------------------ |
> | **Event Grid** | 用于**事件通知**，告诉你“**发生了某事**”，推送通知，适合**Serverless 工作流** |
> | **Event Hub**  | 用于**事件摄取（ingestion）和流处理**，收集**大量实时数据流**，适合**大数据和 IoT 场景** |

Azure Service Bus：

> **Azure Service Bus** 是微软提供的 **企业级消息传递服务**，用于在**分布式应用之间可靠、安全地交换消息**。它支持异步通信、事务、顺序保证、死信队列等高级功能。
>
> 适用于对消息交付有强一致性、顺序、事务处理需求的系统，比如：**订单系统、支付系统、工作流处理**等。
>
> | 概念                                    | 说明                                             |
> | --------------------------------------- | ------------------------------------------------ |
> | **Queue（队列）**                       | 点对点消息模型，消息按顺序存储，消费者逐条处理   |
> | **Topic + Subscription（主题 + 订阅）** | 发布/订阅模型，多个订阅者可以接收同一条消息      |
> | **Message**                             | 一条消息，可以包含文本、JSON、二进制、属性       |
> | **Dead-letter Queue（死信队列）**       | 处理失败、拒绝或过期的消息被移动到这里，方便排查 |
> | **Session**                             | 保证同一组消息按顺序处理（FIFO）                 |
> | **Duplicate Detection**                 | 自动识别并丢弃重复消息                           |
> | **Transaction**                         | 可以将发送和接收操作绑定在一个事务中             |

=>Azure Service Bus 与 Event Grid**可以结合起来使用**，实现 **事件驱动 + 异步可靠处理** 的强大架构. 和 **AWS 的 SNS + SQS** 的模式非常类似，本质上都是：**事件通知系统 + 消息队列系统** 的强强联手，兼顾事件驱动 + 可靠异步处理。

> ```
> Azure:                       AWS:
> Blob 上传                    S3 上传
>    ↓                            ↓
> Event Grid 通知             SNS 通知
>    ↓                            ↓
> Service Bus Queue           SQS 消息队列
>    ↓                            ↓
> 函数/服务处理                 Lambda / 服务处理
> ```

=>Azure Blob Storage Trigger  +  Event Grid + Azure Functions, Event Grid 的触发延迟通常在 1 秒以内

>  Topic 是事件的“投递地址”:你要发送（发布）事件到 Event Grid，就必须指定一个 Topic，相当于“门口的信箱”。
>
> Azure Event Grid 中有两种类型的 Topic：
>
> | 类型                           | 说明                                                | 举例                                            |
> | ------------------------------ | --------------------------------------------------- | ----------------------------------------------- |
> | **系统主题（System Topic）**   | 由 Azure 自动创建和管理，用于 Azure 资源触发事件    | 如：Blob Storage 文件上传、资源创建             |
> | **自定义主题（Custom Topic）** | 你手动创建，用于非 Azure 服务或你自己的应用发送事件 | 如：你写的应用、Webhook、IoT 设备等发送业务事件 |

> 
>
> **Event Subscription（事件订阅）** 是 **接收和处理事件的逻辑桥梁**，它定义了：“谁”来接收事件，接收“哪些”事件，以及“怎么”接收。
>
> ```
>         ┌────────────┐
>         │   Event    │  ← 来自 Azure 服务或自定义应用
>         │   Topic    │
>         └────┬───────┘
>              ↓
>       ┌─────────────┐
>       │ Event       │   ← 订阅1：接收特定事件类型
>       │ Subscription│──→ Azure Function / Webhook / etc
>       └─────────────┘
> ```

=>创建 Topic 和 Event Subscription 是使用 Azure Event Grid 的两个核心步骤

=>**Azure Event Grid 的 Event Subscription 支持设置 Filter（过滤器）**，也就是说，**你订阅了一个 Topic，但可以选择只接收符合某些条件的事件**，比如Event Type、Subject、Data等。

> Routing 是 Event Grid 的核心职责：你只需要发布事件，Event Grid 会根据你设置的规则把它“路由”到正确的订阅接收方。

=>举例说你可以 一个 topic 关联两个Event  Subscription，不同的事件发送到不同的 Subscription中去

> Dead lettering 是当事件无法投递给订阅的目标时，Event Grid 自动把这些“失败事件”存到一个备份位置（**Blob Storage**）中，供后续排查和恢复。

=>在 **Azure Event Grid** 中，**Managed Identity（托管身份）** 的运用主要用于：**让 Event Grid 安全、无密钥地将事件投递到支持 AAD 身份认证的目标服务（endpoint）**。

> 举例：你想把事件从 Event Grid 投递到一个 **Azure Service Bus Topic**。
>
> 你可以：
>
> 1. 给 Event Grid 分配一个 **托管身份（Managed Identity）**
> 2. 给 Service Bus 设置访问权限（RBAC）：
>    - 分配 `Azure Service Bus Data Sender` 角色给 Event Grid 的托管身份
> 3. 创建 Event Subscription，设置 Managed Identity 为 System Assigned

> Event Grid 在将事件投递给订阅的目标（如 Webhook、Function、Service Bus）时，如果失败，会根据你配置的 **Retry Policy（重试策略）** 自动重试，直到成功或超过最大尝试次数。

=> 以上全是在 Create Event Subscription 的Additional Feature界面上

=>基本上就是 你创建一个 Event  Topic,点进去这个资源中创建Event Subscription，界面中设置endpoint 为Azure Function, Event hub等

> Logic App 就像是云端的自动化“流程引擎”，**你设定触发条件（Trigger）和步骤（Action），它自动帮你串起来做事情**，不需要写很多代码。
>
> 整个流程你可以通过**可视化拖拽式界面**配置完成。

### Message-based Solutions 20250715

> Azure Storage Queue 是一种用于在系统组件之间可靠传递消息的轻量型队列服务，适合**简单、可扩展、持久化的异步消息传递机制**，主要用于在云服务之间传递消息，实现**松耦合、削峰填谷、后台处理等模式**。

=>Azure Storage Queue属于 Azure Storage 服务的一部分, 所以你要创建一个 storage account，在其中寻找queue服务

> ## Azure Storage Account 内的核心资源类型对应功能：
>
> | Azure 存储类型  | 类比技术                      | 功能类比             |
> | --------------- | ----------------------------- | -------------------- |
> | Blob Containers | AWS S3 / Google Cloud Storage | 文件存储（对象存储） |
> | Queue           | RabbitMQ / Kafka（简化）      | 轻量消息队列         |
> | Table           | DynamoDB / MongoDB（简化）    | NoSQL 表格数据库     |
> | File Shares     | NFS / SMB                     | 共享文件系统         |

> ## 具体 Storage Account 类型（在 CLI 中用 `--sku` 指定）
>
> | 类型名                         | 说明                               | 支持的服务               | 用途                         |
> | ------------------------------ | ---------------------------------- | ------------------------ | ---------------------------- |
> | **Storage (GPv1)**             | 旧版通用账户，已不推荐使用         | Blob, File, Queue, Table | 向后兼容场景                 |
> | **StorageV2 (GPv2)**           | 推荐的通用账户类型                 | Blob, File, Queue, Table | Web应用、备份、归档等        |
> | **BlobStorage**                | 专用于 Blob 服务                   | Blob                     | 适合冷数据访问分层管理       |
> | **BlockBlobStorage**           | 高性能 Blob                        | Blob                     | 数据湖、媒体处理、高性能场景 |
> | **FileStorage**                | 高性能文件共享                     | File                     | 替代 NAS 的场景              |
> | **Premium_ZRS**                | Zone-redundant 高可用 Premium 存储 | Blob, File（部分支持）   | 高可用与性能并存场景         |
> | **BlockBlobStorage + Premium** | SSD 支持的高性能 Blob 存储         | Blob                     | 延迟敏感的大文件上传等       |

=>exam topic: StorageV2 是通用型存储账户，基于 HDD，支持 Block Blob、Append Blob、Page Blob、Queue、Table 和 File 等多种服务及冷热归档层，而 **BlockBlobStorage** 是基于 SSD 的高级账户，仅支持块 Blob，专为高吞吐低延迟场景设计。



=>Azure Service Bus 是功能更强大、专为企业场景设计的“高级队列服务”，与 Azure Storage Queue 都提供消息排队功能，它有**单独的服务门户入口**，**不属于 Storage Account** 的一部分

> | 用途                  | 说明                                                         |
> | --------------------- | ------------------------------------------------------------ |
> | **系统解耦**          | 不同服务或应用之间不直接调用，通过消息传递松耦合。           |
> | **异步通信**          | 发送方不需等待接收方处理完，提升性能。                       |
> | **削峰填谷**          | 吸收高并发请求，缓慢投递，保护后端系统。                     |
> | **高可靠性**          | 消息支持持久化、重复检测（duplicate detection）、死信队列（DLQ）等机制。 |
> | **支持顺序性 & FIFO** | 支持 Session 和 Message Ordering，保证处理顺序。             |
> | **多协议/平台支持**   | 可以通过 AMQP、HTTPS 等协议与各种平台通信。                  |
>
> ## 核心组件对比：
>
> | 模块                     | 功能                                         | 类似于                 |
> | ------------------------ | -------------------------------------------- | ---------------------- |
> | **Queue**                | 收到包裹后，排队送一个人；                   | Kafka、RabbitMQ 的队列 |
> | **Topic + Subscription** | 收到包裹后，按订阅人群发；                   | Kafka 的 Topic         |
> | **Dead Letter Queue**    | 地址错/收件人拒收 → 转入死信区等待人工处理； | Kafka 的 DLQ           |
> | **Session**              | 同一订单的所有包裹按顺序投递。               | Kafka 的 partition+key |

=>**Service Bus Topic + Subscription** 适合**可靠、顺序性强、带状态的企业级消息通信**； **Event Grid** 则更适合**高吞吐、轻量、近实时的事件通知系统**。

> | 对比维度 | **Service Bus Topic + Subscription**     | **Event Grid**                         |
> | -------- | ---------------------------------------- | -------------------------------------- |
> | 消息语义 | **Reliable Messaging（可靠消息）**       | **Event Notification（事件通知）**     |
> | 可靠性   | ✅ 高（有 DLQ、重试、确认机制）           | ⚠️ 中（至少一次，失败后自动重试）       |
> | 顺序性   | ✅ 支持 Session 顺序保证                  | ❌ 无顺序保证                           |
> | 订阅模型 | 每个 Subscription 是一个独立消息队列     | 广播式订阅，不存储事件状态             |
> | 典型用途 | 企业任务处理，需保证每个订阅独立可靠执行 | 通知型、触发型系统（轻量快速）         |
> | 消费模式 | 明确 ACK、失败自动进入 DLQ、可重放       | 自动 retry，失败记录有限，不能手动重放 |
>
> ##  类比总结：就像邮局 vs 新闻社
>
> | 类比角色 | Service Bus Topic                              | Event Grid     |
> | -------- | ---------------------------------------------- | -------------- |
> | 📦 像邮局 | 有收件人、地址、要签收、可以退回，适合任务交办 | 📢 像新闻社广播 |
> | 📮 消息   | 需要追踪、确保被送达、可重复送、重要事务       | 📰 事件         |
>
> | 项目       | **Service Bus Topic + Subscription**                         | **Event Grid**                                               |
> | ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
> | 🎯 设计目标 | **企业级、可靠、有状态的消息通信**（Message-based Integration） | **事件驱动架构、快速传播状态变化**（Event-based Notification） |
> | ⏳ 响应模式 | 消息必须处理，有消费确认；强调**准确性和控制**               | 通知类型事件广播，不关心是否被处理；强调**轻量级和速度**     |
> | ⚙️ 本质差异 | 多个服务 **消费一个消息，各自管理状态**                      | 多个服务 **响应同一个事件，通常是无状态、只做通知用途**      |

=>Event Grid严格意义上更偏向 事件驱动

> 在 **Azure Service Bus** 中，**AMQP**（Advanced Message Queuing Protocol，高级消息队列协议）是一种核心通信协议，用于在客户端（如应用程序）与 Azure Service Bus 之间进行**高效、安全、可靠的消息传输**。
>
> 通常推荐：
>
> - **后台服务、微服务通信** → 使用 AMQP
> - **简单测试、低频调用** → 可用 HTTP/REST

 Azure Service Bus架构核心组件:

> ```
>     [Sender App]
>          │
>          ▼
>    ┌────────────┐
>    │  Namespace │
>    └────────────┘
>          │
>  ┌───────┴────────┐
>  │                │
>  ▼                ▼
> Queue           Topic ──────► Subscription A ───► [Consumer A]
>                     │
>                     └──────► Subscription B ───► [Consumer B]
> 
> ```

> Service Tag 是 Azure 预定义的一组 IP 地址范围的标签，代表某个 Azure 服务的网络终结点。
>
> ##  举例说明：
>
> | Service Tag         | 代表什么                                                     |
> | ------------------- | ------------------------------------------------------------ |
> | `AzureCloud`        | 所有 Azure 数据中心的出入口 IP 范围（包含大多数公共 Azure 服务） |
> | `Storage.<region>`  | 该 region 的 Azure Storage 服务（Blob、Queue、Table）        |
> | `Sql`               | Azure SQL Database 的出口地址范围                            |
> | `ServiceBus`        | Azure Service Bus 的 IP 范围                                 |
> | `AppGateway`        | Azure Application Gateway 的 IP 范围                         |
> | `VirtualNetwork`    | 当前虚拟网络内的资源                                         |
> | `Internet`          | Azure 外部互联网地址                                         |
> | `AzureLoadBalancer` | Azure 自带的 Load Balancer（用于健康探测）                   |
>
> 示例：比如把发往 `AzureFirewall` 的流量引导到某个网络虚拟设备（NVA）：
>
> ```
> "destination": "VirtualNetwork",
> "nextHopType": "VirtualAppliance",
> "nextHopIpAddress": "10.1.0.4"
> ```

> **Azure Virtual Network（VNet）** 是 Azure 上的逻辑隔离网络，功能等价于本地数据中心的网络。
>
> 你可以在 VNet 内部部署和连接：
>
> - 虚拟机（VM）
> - 容器服务（AKS）
> - App Service（通过 VNet 集成）
> - PaaS 服务（Storage、SQL 等）

=>**Azure 的 VNet（Virtual Network）** 和 **AWS 的 VPC（Virtual Private Cloud）** 是非常类似的概念，**都属于云中的虚拟隔离网络**，是构建云上安全网络架构的基础。

> ## 对比总结：VNet vs. VPC
>
> | 项目             | Azure VNet                              | AWS VPC                             |
> | ---------------- | --------------------------------------- | ----------------------------------- |
> | 名称             | Virtual Network（虚拟网络）             | Virtual Private Cloud（虚拟私有云） |
> | 功能本质         | 虚拟网络容器，托管 VM 等资源            | 虚拟网络容器，托管 EC2、RDS 等资源  |
> | 子网（Subnet）   | 支持多个子网，必须指定 IP 范围          | 支持多个子网，必须指定 IP 范围      |
> | 路由表           | 自定义路由表（User Defined Routes）支持 | 自定义 Route Table                  |
> | 网络ACL          | 不支持 NACL，使用 NSG（网络安全组）     | 支持 NACL（网络访问控制列表）       |
> | 安全组           | NSG（Network Security Group）           | SG（Security Group）                |
> | 跨VNet/VPC通信   | VNet Peering / VNet Gateway             | VPC Peering / Transit Gateway       |
> | DNS              | 内建 Azure DNS，也可使用自定义 DNS      | 默认 AWS DNS，也可绑定自定义 DNS    |
> | 私有连接（PaaS） | Private Endpoint / Private Link         | Interface Endpoint / PrivateLink    |
> | Internet Access  | 通过 Internet Gateway / NAT Gateway     |                                     |

=>生产者如何发送message到Azure Service bus: 最常用的是通过官方 SDK（如 .NET、Java、Python）、REST API 或 Azure Portal。

> Power Automate 是 Microsoft 提供的一项 **低代码自动化平台**，主要用于帮助用户**跨多个应用和服务实现工作流程自动化**，以前也叫 Microsoft Flow。
>
> 比如：「**当** 有人提交 Microsoft Forms 表单，**就** 把内容写入 Excel 并发送邮件通知。」

> Azure Stream Analytics 是 Microsoft 提供的一种 **实时流数据分析服务**，可用于从多种来源接收数据流，并在几乎实时的情况下进行 **查询、过滤、聚合和分析**，最终输出到各种目标系统，如数据库、Power BI、Blob 等。
>
> **Azure Stream Analytics 可以与 Azure Service Bus 联动**，但主要是作为 **输出（Output）** 使用，即：
>
> > **Stream Analytics 处理完实时流数据后，可以将结果发送到 Azure Service Bus 的 Queue 或 Topic，供其他系统进一步处理。**
>
> =>与Azure Service Bus作为 Azure Function的trigger的顺序相反





# Azure Learning 2024

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
> Azure 管理组提供订阅上的作用域级别。 可将订阅整理到名为“管理组”的容器中，并将治理条件应用到管理组。 管理组中的所有订阅都将自动继承应用于管理组的条件，就像资源组从订阅中继承设置、资源从资源组中继承一样。 不管使用什么类型的订阅，管理组都能提供大规模的企业级管理。 管理组可以嵌套。
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
> 服务总线是一个平台即服务 (PaaS) 产品

## EP27 Azure Queue Storage

> Azure Queue Storage 是**一个存储大量消息的存储服务**，这些消息可以在任何地方通过HTTP/HTTPS 访问。 每条消息最大64K，消息的数据量几乎不受限制(除非超出了您的Storage Account 的总容量) 。队列通常用于创建要异步处理的积压工作 (backlog)

## EP28 Azure Monitor

## EP29 Azure CDN

Content delivery networks

> **Azure CDN**（内容分发网络）：**CDN 是**服务器的分布式网络，可以有效的将Web内容传递给我们，同时**CDN** 可以将缓存的内容存储在记录我们比较近的POP（入网点位置）位置的边缘服务器，以便最大成都降低网络延迟。 **Azure** 内容分发网络(**CDN**) 可帮助减少延迟并提升高带宽内容的性能。

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
>
> 
