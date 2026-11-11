# OCI AI Foundations Associate



[OCI Architect Associate](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-architect-associate-2026-/164999)

[OCI Architect Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-architect-professional-2026-/163169)

[OCI AI Foundations Associate](https://mylearn.oracle.com/ou/learning-path/become-an-oci-ai-foundations-associate/163544) Completed

[Oracle Agentic AI Foundations Associate](https://mylearn.oracle.com/ou/learning-path/become-an-oracle-agentic-ai-foundations-associate-2026/163239) Completed

[OCI Enterprise AI Professional](https://mylearn.oracle.com/ou/learning-path/become-an-oci-enterprise-ai-professional-2026/163234) 

[OCI Data Science Professional](https://mylearn.oracle.com/ou/learning-path/become-an-oci-data-science-professional/162289)

[Oracle AI Agent Studio for Fusion Applications Foundations Associate](https://mylearn.oracle.com/ou/learning-path/oracle-ai-agent-studio-for-fusion-applications-foundations-associate-training-and-certification/151552)



[Codex Foundations](https://mylearn.oracle.com/ou/learning-path/codex-foundations/166599)

[Agentic Engineering with Codex](https://mylearn.oracle.com/ou/learning-path/agentic-engineering-with-codex/166692)

# [OCI Generative AI Professional](https://mylearn.oracle.com/ou/learning-path/japanese-become-an-oci-generative-ai-professional-2025-/153868) 

=>说需要三方面的基础知识 1.深度学习与机器学习；2.Python；3.OCI.

范围从大到小： Artificial Intelligence => Machine Learning => Deep Learning => Generative AI => LLM

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
      │      ├── CNN   Convolutional Neural Network=> 从单点像素开始分析图像
      │      ├── RNN   Recurrent Neural Network=> 预测序列数据
      │      ├── LSTM
      │      ├── Transformer
      │      ├── Siamese Network
      │      └── Autoencoder / VAE
      │
      ├── 生成模型（Generative Models）
      │      ├── GAN   Generative Adversarial Network=>让两个神经网络互卷，你制造假图片，我判断
      │      ├── VAE   Variational Autoencoder=> 把复杂人脸解析成各种维度然后重新生成心脸脸
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



## Machine Learning Foundations 20260723

Supervised Learning - Linear Regression

Supervised Learning - Classification  => Logistic Regression

Unsupervised Learning - Clustering Algorithm

Reinforcement Learning

| 学习类型                                                     | 定义                                                    | 目标                     | 应用示例                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------- | ------------------------ | ------------------------------------------------------------ |
| 监督学习（Supervised Learning）— 线性回归（Linear Regression） | 使用带有标签的数据进行训练，预测连续数值。              | 预测一个数值。           | 房价预测、销售预测、气温预测                                 |
| 监督学习（Supervised Learning）— 分类（Classification）      | 使用带有标签的数据进行训练，预测数据所属的类别。        | 预测类别。               | 垃圾邮件识别、疾病诊断、情感分析                             |
| 无监督学习（Unsupervised Learning）                          | 使用没有标签的数据，自动发现数据中的规律和结构。        | 找出数据中的模式或分组。 | 客户分群 Market Segmentation、异常检测 Outlier Analysis、商品推荐 Recommendation Systems |
| 强化学习（Reinforcement Learning）                           | 智能体（Agent）通过与环境交互，根据奖励和惩罚不断学习。 | 获得最大累计奖励。       | 自动驾驶、机器人控制、围棋 AI（AlphaGo）                     |

=>机器学习三大范式的内部机理，本质上都是数学函数、概率模型和优化算法的组合；这些组合在高维空间里运行，所以能表示远超我们三维直觉的复杂结构。

=> Linear Regression  用来拟合数据线性关系，而Logistic Regression名字里Regression，但实际上是一种分类算法。

> Linear Regression 和 Logistic Regression 都是典型的监督学习（Supervised Learning）方法，因为它们都需要带标签的数据来训练。因为“回归”这个词本身就暗示了有一个目标值 y 要学习。
>
> 无监督学习常见的任务是聚类（Clustering），降维（Dimensionality Reduction），异常检测（Anomaly Detection），关联规则学习（Association Rule Learning

**Logistic Regression可以看成是“没有隐藏层的Neural Networks”，或者说是一个最简单的神经元模型。**

=> 神经网络可以理解成 把上一层Logistic Regression的输出作为下一层Logistic Regression的输入，一层层叠起来

=> 常用Anaconda 和 Jupyter Notebook 来进行机器学习训练

> Anaconda = Python + 常用数据科学库 + 包管理工具 + 开发工具
>
> Jupyter Notebook 是一个基于浏览器的交互式开发工具。 是 Anaconda 自带的一个工具

> **Reinforcement Learning**（强化学习，RL） 是机器学习三大范式（监督学习、无监督学习、强化学习）之一。
>
> 强化学习就是让智能体（Agent）通过不断尝试，从奖励（Reward）和惩罚（Penalty）中学习如何做出最优决策。

=>强化学习有既定目标（Reward Objective），但没有既定答案或既定路径；Agent 可以通过探索，发现甚至超越人类已有策略的更优策略。如阿尔法狗。





## Deep Learning Foundations 20260725

Neural Network 核心概念一览

| 概念                | 中文     | 作用                                                         |
| ------------------- | -------- | ------------------------------------------------------------ |
| Layer               | 层       | 对数据进行逐层处理                                           |
| Neuron              | 神经元   | 一个计算单元: 输入=>加权求和=>激活函数=>输出                 |
| Weight (W)          | 权重     | 决定输入的重要程度                                           |
| Bias (b)            | 偏置     | 调整输出，使模型更灵活                                       |
| Activation Function | 激活函数 | 给神经网络加入非线性能力，使网络能够学习复杂关系。比如ReLU: f(x)=max(0,x);Sigmoid等函数 |

=>训练神经网络，本质就是不断调整 Weight和Bias，使网络的预测结果越来越接近真实答案。

```
输入(Input)
      │
      ▼
Weight（权重）
      │
      ▼
加权求和
      │
      ▼
+ Bias（偏置）
      │
      ▼
Activation Function（激活函数）
      │
      ▼
Neuron 输出
      │
      ▼
传递到下一 Layer
```



> **Backpropagation Algorithm**（反向传播算法，简称 BP） 是深度学习中最核心的训练算法之一。作用是：根据预测误差，反向计算每个神经元的责任，并更新每个权重（Weight）和偏置（Bias），使神经网络越来越准确。可以把它理解成神经网络的"纠错机制"。

神经网络训练全过程实际上不断重复以下步骤：

```
           输入数据
               │
               ▼
      Forward Propagation
               │
               ▼
        Prediction（预测）
               │
               ▼
      Loss Function（计算误差）
               │
               ▼
      Backpropagation（反向传播）
               │
               ▼
   计算每个 Weight、Bias 的 Gradient
               │
               ▼
 Gradient Descent（梯度下降）
               │
               ▼
 更新 Weight 和 Bias
               │
               ▼
      下一轮训练（重复）
```



=>Transformer 是一种神经网络架构思想，通常用 PyTorch 这样的深度学习框架实现。PyTorch 的底层很多底层高性能计算是用 C++ / CUDA 写的，以支持高效的GPU 计算；而训练时，很多时候只需要用几行 Python 代码就能启动模型训练。

=>PyTorch是Meta的开源，有数百万行代码（包括 C++、Python、CUDA 等），十几万次提交（Commit），取代谷歌的TensorFlow成为目前各家大模型的主流框架

=>简单启动模型训练虽然几行Python代码，但是正真训练GPT这种几千亿参数的大模型正真的代码可能有几十万行，要解决数据流水线编排， GPU 编排，数据并行...   

=> Python => PyTorch => LLM 可以类比为 C语言 => C语言标准库 => Linux Kernel, 当然不严谨的地方是Linux Kernel底层也还是用C语言，但LLM最底层不是Python而是C++/CUDA

=>DeepSeek的开源主要是指 模型权重和运行代码，至于完整训练代码以及训练数据是拿不到的



## Generative AI and LLM Foundations 20260730

Generative AI（生成式 AI） 是建立在Deep Learning基础上的一类应用，它利用深度学习模型（如 Transformer、Diffusion）来生成文本、图片、音频、视频和代码等新内容。

LLM（Large Language Model） 是一种专门处理自然语言NLP(Natural Language Processing)的大型生成模型。是 Generative AI 的一个重要分支（或一种实现）。



**Transformer** 是现代大语言模型（LLM）的核心架构，2017 年，Google 发表论文：Attention Is All You Need. Transformer 使用 Self-Attention让模型在处理一个词时，同时关注（Attention）句子中的其他所有词，从而更好地理解上下文。

Transformer 可以看作一个由许多重复模块组成的网络，每个模块都通过 Self-Attention 让每个词都能关注句子中的其他所有词，再结合Position Encoding、Feed Forward Network、Residual Connection和Layer Normalization不断提炼信息，最终学会理解上下文并预测下一个 Token。这种能够并行计算且有效建模长距离依赖的能力，是它成为现代大语言模型（GPT、Claude、Gemini、Llama 等）基础架构的关键原因。

一个 Transformer Block：

```
输入 Embedding
      │
      ▼
Position Encoding
      │
      ▼
Multi-Head Attention
      │
Residual + LayerNorm
      │
      ▼
Feed Forward
      │
Residual + LayerNorm
      │
      ▼
输出
```

一个 GPT 模型会堆叠很多这样的 Block，例如几十层甚至上百层。随着模型规模增大（更多层、更大参数量、更多训练数据），它学到的语言规律越来越丰富，因此能完成聊天、翻译、写作、代码生成等任务。



Embeddings 可以理解成：把文本、图片、声音等内容，转换成计算机能理解的“数字向量表示”。让“意思相近”的内容在数学空间里更接近,方便模型做比较、检索、分类、推荐、相似度计算

=>在RAG 语境下，最常见的不是一个token或者一整个文件，而是文件中一段文本（chunk）对应一个 embedding vector。（这个不是绝对的，像Transformer 内部确实会给每个 token 产生向量表示）

Embedding 与 vector database是 RAG（Retrieval-Augmented Generation）的核心。Embedding 负责"把文本变成向量"，Vector Database 负责"存储和快速查找这些向量"。



主流的大模型定制（Customization）有三大类:

- **Prompt**：通过写好指令来引导模型，快速、灵活。
- **Fine-tuning**：通过继续训练模型来改变其能力和风格，成本较高但效果更稳定。
- **RAG**（Retrieval-Augmented Generation）：通过实时检索最新知识来增强回答，无需重新训练模型，适合知识经常变化的场景。

RAG 本质上是检索 + 大模型: 用户问题=>Embedding=>向量数据库=>找到最相关文档=>Prompt=>LLM生成答案

=>之前在Ericsson AI Hackthon 就是RAG的应用。



=>LLM 的一切外显行为，在微观层面都落实为“预测下一个 token”；但每次预测并非局部反应，而是对整个上下文经由高维 Transformer 计算后的概率分布。宏观上的理解、推理、规划、风格控制与工具使用，最终都会投射为下一个 token 概率的变化。

> 在 decoding 阶段，**temperature** 是最关键的随机性控制参数之一：temperature 越高，候选 token 的概率分布越平坦，低概率 token 越可能被采样；temperature 越低，分布越尖锐，输出越稳定。
>
> 当 temperature 接近 0 时，模型近似总选择概率最高的 token，即 **greedy decoding**。它稳定、可复现，但容易保守、模板化，并可能陷入局部最优。
>
> 在 **non-deterministic decoding** 中，模型通常以非零 temperature 配合 top-p 或 top-k 等采样策略，从候选 token 中随机采样，因此相同输入可以产生不同输出。
>
> 对代码、JSON、分类、信息抽取等正确性和格式一致性优先的任务，通常选择低 temperature 或近似确定性的解码；对创作、头脑风暴、开放式写作，则可提高 temperature 以获得更多样性。



**Hallucination（幻觉）** 是 Generative AI 和 LLM 中一个非常重要的概念。因为训练目标决定了它的行为。GPT 的目标不是：判断真假。而是：预测最合理的下一个 Token。现代模型已经通过对齐训练（Alignment）有所改进，更倾向于在不确定时说明不知道或表达不确定性，但并不能完全避免幻觉。

> Groundedness（有据性 / 基于证据）和 Attributability（可归因性 / 可追溯性）都是减少幻觉、提升 LLM 可信度的关键概念。
>
> Groundedness: 模型回答必须“落在”可信来源上，而不是仅依赖参数记忆或语言上的合理猜测。
>
> Attributability: 即使答案看起来有依据，还需要让用户或系统能检查其依据。



Soft Prompting :

Soft Prompting 是一种属于 PEFT（Parameter-Efficient Fine-Tuning）的模型专门化方法：它不直接训练或选择 vocabulary 中的离散 token，而是在 embedding 空间中训练一组连续的可学习向量（virtual tokens），将其与用户输入的 token embeddings 一起送入冻结的 LLM，从而以极少的可训练参数为模型注入特定的任务意图、上下文或行为模式。







## OCI AI Portfolio 20260801

=>OCI 的基础由 Compute、Storage、Networking 和 IAM 等核心云服务构成；Oracle 长期以来最大的差异化优势是其数据库产品（Oracle Database、Exadata、Autonomous Database）。随着生成式 AI 的快速发展，OCI AI Infrastructure 已成为 Oracle 当前重点投入和发展的战略方向，通过 GPU、RDMA Supercluster、高性能网络和存储，为大模型训练和推理提供企业级 AI 基础设施。



Oracle AI Stack: AI Service => ML Service => AI infrastrucure

```
                 Oracle AI Stack
────────────────────────────────────────────

Layer 3
AI Services（AI应用服务）   =>类似百度平台的各种AI服务，感觉只是AI服务的边角料
--------------------------------------------
• OCI Generative AI   
• OCI AI Language  =>简单的自然语言处理（NLP），如Language detextion, Text classification等
• OCI Vision    =>图片识别一类的，如Image classfication,  Object detection等
• OCI Document Understanding  =>比如识别一张发票信息，会用到但不仅限于OCR，还要通过识别的文字判断这是发票
• OCI Speech   =>语音翻译...

        ▲

Layer 2
ML Services（机器学习平台）    => 帮助数据科学家完成模型开发生命周期
--------------------------------------------
• OCI Data Science

        ▲

Layer 1
AI Infrastructure（AI基础设施）   => 这是 Oracle 最强调的一层，也是 OCI 的竞争优势。
--------------------------------------------
• NVIDIA GPU (H100, B200 等)
• OCI Compute
• RDMA Cluster Network
• OCI Supercluster
• Block Volume
• Object Storage
• Kubernetes (OKE)
```

机器学习平台的核心产品OCI Data Science：

```
          数据(Data)
               │
               ▼
      Feature Engineering
      （数据清洗/特征构造）
               │
               ▼
         Notebook 开发   => 相当于云端 JupyterLab,整个 AI 开发的入口。
               │
      ┌────────┴────────┐
      ▼                 ▼
 PyTorch 代码训练   AutoML 自动训练
      └────────┬────────┘
               ▼
        Model Catalog
     （模型版本与管理）
               │
               ▼
        Pipeline 自动化
 （训练→评估→注册→部署）
               │
               ▼
      Model Deployment
      （REST API 服务）
               │
               ▼
     Web / App / 企业系统调用
```

创建一个 Notebook Session 时，OCI 会为你启动一台计算实例。你可以选择GPU，内存，Python 环境（Conda Environment）。



 CPU 像一群经验丰富的专家，适合处理各种复杂问题；GPU 更像一支规模庞大的流水线工人队伍，每个人做同样的计算，因此面对 AI 中海量重复的矩阵运算时，GPU 能发挥压倒性的性能优势。

```
2020        2022          2024          2025+
 ───────────┬─────────────┬─────────────┬──────────►

 A100       H100          H200         B200
 Ampere     Hopper        Hopper       Blackwell
```

比喻：GPU = 工厂 ，HBM = 工厂旁边的超大原料仓库，普通显存/内存 = 远一点的仓库

=>最近GPU的迭代主要是提升对 HBM 更大容量和更高带宽的适配。

过去几年 AI 的瓶颈已经从 GPU 芯片本身，逐渐转移到了 HBM （High Bandwidth Memory，高带宽内存）的供应。

（HBM 是为“喂饱 GPU 算力”设计的，DDR 是为“通用主机内存”设计的）

```
1. GPU 制造（TSMC Fab）
        │
        ▼
   GPU Die（裸芯片）

2. HBM 制造（SK hynix / Samsung / Micron）
        │
        ▼
   HBM 堆栈（Stack）

3. TSMC 先进封装（CoWoS）
        │
        ▼
+--------------------------------------+
|        CoWoS Package                 |
|                                      |
|   HBM      GPU Die       HBM         |
|                                      |
|   HBM                  HBM           |
+--------------------------------------+
            │
            ▼
GB200 / B200
            │
            ▼
OCI / AWS / Azure AI Cluster
```

**RDMA**（Remote Direct Memory Access，远程直接内存访问） 是 AI 基础设施中最关键的技术之一。如果说 GPU 决定计算速度，那么 RDMA 决定多台服务器之间的数据交换速度。对于 OCI AI Infrastructure 来说，RDMA 是支撑大规模 GPU 集群（Supercluster）的核心能力。

=>RDMA是服务器之间的数据交换技术，跟GPU/HBM这个主机自身层面的不同层次

=> Oracle Database 运行在 Exadata 上时，也会大量利用 RDMA 来提升性能。



## OCI Generative AI Service 20260804

=>OCI Generative AI 定位于企业级 AI 开发平台（Enterprise AI Platform），提供包括 Meta Llama、Cohere Embed等在内的多种模型能力(Pretrained Foundational Models)。平台并不局限于LLM，还提供 Embedding Model 等不同类型的模型；同时支持 Dedicated AI Clusters，帮助企业进行模型 Fine-tuning，满足定制化的 AI 应用需求。

=>OCI Generative AI 核心能力可以分成三层：先选择预训练模型(Pretrained Foundational Models) → 根据业务数据定制模型(Fine-tunning) → 在Dedicated  AI Cluster 上运行和服务模型。

Embedding Model 的作用是将文本转换成一串数字（向量），使语义相近的文本在向量空间中距离更近。Embedding 是为了 Find（找），LLM 是为了 Read（读）和 Think（思考）。

=>Dedicated AI Cluster 是为单一租户（Tenant）独占分配的一组 GPU 计算资源，用于部署和运行生成式 AI 模型。作为 PaaS 服务，用户无需自行管理底层 GPU VM，也无需负责 CUDA、PyTorch 等软件栈的安装，以及模型部署、升级和日常维护。同时，Dedicated AI Cluster 支持导入兼容的开源模型（Imported Models），并将其部署到专属集群上，对外提供模型推理服务。

典型的企业知识库（RAG）架构如下：

```
PDF
    │
Object Storage
    │
OCR / Parser
    │
Cohere Embed
    │
Oracle Database 23ai
(AI Vector Search)
    │
Top K Documents
    │
Meta Llama（生成最终答案）
    │
Answer
```

=>**LangChain** 就是把上面PDF → Chunking → Embedding → Vector DB → Retrieval → LLM 这些组件串起来的orchestration框架。但进入 AI Agent 时代后，相比固定的 Chain，有状态的 Agent Workflow 更重要，需要处理状态管理、Workflow、Human Approval 和 Tool Orchestration 等，因此 LangChain 生态发展出了 **LangGraph**。LangGraph 适合构建 Coding Agent，但它主要负责 Agent Orchestration 和状态管理。一个类似 Codex 的完整 Agent，还需要代码执行环境、文件系统、Sandbox、工具系统、上下文管理和安全策略等。可以简单理解：Agent Harness = 完整的 Agent Runtime 系统，LangGraph = 其中 Agent 编排与状态机这一层的框架。



OCI Generative AI Console 内置 **Playground**，本质上是一个 API 调试工具。开发者可以测试预训练模型和自定义模型、调整 Prompt 和参数、查看 Sample Code，实现从“试效果”到“代码集成”的快速过渡。

需要特别区分 Playground 和 Fine-tuning：Playground 用来测试和调试模型效果，Fine-tuning 用来训练和定制模型，两者属于模型开发流程中的不同阶段。

Chat Playground 常用参数：

- Temperature： LLM 生成阶段用于调节 token 概率分布随机性的参数——温度越低，概率分布越尖锐、输出越确定稳定；温度越高，概率分布越平坦、输出越随机多样。
- Max Tokens：控制回答长度
- Top P：控制候选 Token 范围，通常保持默认即可

> Top-k 固定“候选 token 的数量”；Top-p 固定“候选 token 的累计概率”。所以 Top-p 的优势是候选集合大小会根据模型的确定程度动态变化

> - Frequency penalty（频率惩罚）：某个 token 已出现越多次，就越降低它再次出现的概率，用来减少反复用同样的词或句式。
> - Presence penalty（出现惩罚）：某个 token 只要已经出现过，就降低它再次出现的概率，用来鼓励模型引入新词、新话题。
>
> 一句话：frequency 看“重复了多少次”，presence 只看“是否已经出现过”



Oracle 将 **AI Vector Search** 集成到 Oracle Database 23ai 中，可以直接存储 Embedding Vector，并通过 Similarity Search 找到语义最相关的数据，使语义搜索和传统关系型查询可以在同一个数据库中完成。

Vector Search 并不是一套新的查询语言，而是 Oracle SQL 对 Vector 能力的扩展。SQL 本身有国际标准，但 Oracle、PostgreSQL、MySQL、SQL Server 等数据库都会在标准 SQL 基础上扩展自己的功能。

Embedding Model 负责把文本转换成 Vector；Vector Database 负责存储 Vector，并通过相似度搜索找到最相关的数据。每个 Vector 通常会和对应的原文 Chunk、文档 ID、页码等 Metadata 一起保存。数据库可以存储不同维数的 Vector，但具体输出多少维，通常由 Embedding Model 决定。

=>Oracle Database 23ai 可以加载训练好的 Embedding Model。对于需要检索的数据，可以预先生成 Embedding 并存储在 VECTOR 列中；当用户进行自然语言查询时，再用同一个或兼容的 Embedding Model把 Query 转换成 Query Vector，然后 Oracle Database 执行 Vector Similarity Search，计算 Query Vector 与已有数据 Vector 之间的距离，找出最相似的结果。也就是说Oracle Database 23ai 可以当作 Vector Database 使用。



ADB（Autonomous AI Database）里的 **Select AI**，最容易理解的功能是：你说自然语言，Select AI 帮你生成并执行 SQL。选用外部Model作为AI provider，然后 Select AI 帮你处理数据库和 LLM 之间的交互。



 =>OCI上还有一个独立的Generative AI Agent Service，但估计发布即淘汰？Generative AI Service目前也只有Softbank在用，NTT与Fujitsu都没订阅...

```
[用户 / 业务应用]
        ↓
[Agent Endpoint：Agent 的 API 访问入口]
        ↓
[Session：保存对话历史、任务状态与上下文]
        ↓
[AI Agent：任务拆解、决策、编排与执行]
        ├──→ [Generative AI Model / LLM：理解、推理、生成答案]
        │
        ├──→ [Knowledge Base / RAG：检索企业知识]
        │          ├──→ [Oracle Database 23ai：Chunks、Metadata、ACL、Embeddings、Vector Index]
        │          └──→ [Object Storage：PDF、Word、PPT、图片等原始文件]
        │
        ├──→ [Tools / APIs：调用数据库、CRM/ERP、工单、邮件等业务操作]
        │
        ├──→ [Content Moderation：输入/输出安全与合规检查]
        │
        └──→ [Trace / Monitoring：记录模型、检索、工具调用、耗时与错误]
        ↓
[Response：答案 + Citation / 来源引用]
        ↓
[用户 / 业务应用]
```

=>其实也就是用database当RAG稍微有点卖点，API调用视频根本没深入，Agent还完全停留在2024年LangChain时代的思维...



# [Oracle Agentic AI Foundations Associate](https://mylearn.oracle.com/ou/learning-path/become-an-oracle-agentic-ai-foundations-associate-2026/163239) 

# [OCI Enterprise AI Professional](https://mylearn.oracle.com/ou/learning-path/become-an-oci-enterprise-ai-professional-2026/163234) 

## Introduction to AI Agents 20260906

Al Agent(LLM-based) = LLM + Tools + Loop

> An LLM never executes tools directly. It emits a structured tool-call request, and the agent application validates and executes it.
>
> MCP provides a standardized way for AI applications to connect with the tools, data, and context they need.

=>Loop 就像程序中的while(1)， Like an OS for the AI Agent

```python
while not task_completed:
    decision = llm(context, user_goal, available_tools)

    if decision.is_tool_call:
        result = validate_and_execute(decision)
        context.append(result)
    else:
        return decision.final_answer
```



 Reasoning Patterns 推理模式

> - CoT（Chain of Thought）：单一路径、逐步推理。适合分析、计算和任务拆解，但不直接获取外部信息或执行操作。
> - ReAct（Reason + Act）：在循环中交替进行“推理 → 调工具 → 观察结果 → 再推理”。适合需要搜索、查数据库、调用 API 或执行代码的 Agent。
> - ToT（Tree of Thoughts）：同时探索多条推理分支，比较后保留较优方案。适合复杂决策、方案设计和难题求解，但成本和延迟更高。
>
> 一句话：
>
> CoT=一条思路逐步想    ReAct=边想边做     ToT=多条思路择优



=> Agent Frameworks很多，最传统的LangChain/LangGraph, 还有OpenAI原生的OpenAI Agents SDK，AWS等云平台也有，又比如CrewAI，Hugging Face smolagents

=>Safety 与 Guardrails（安全护栏）也是Agent系统中需要重视的地方

> 常形成攻击链：
>
> ```
> 恶意网页 / 邮件 / 文档
> → Prompt Injection
> → 诱导 Agent 调用工具
> → Tool Misuse 或越权访问
> → 写入恶意长期记忆（Memory Poisoning）
> → 通过邮件 / HTTP / 云盘泄露数据（Data Exfiltration）
> ```

> **Prompt Injection**（提示词注入）是 LLM 应用里非常核心的一类安全问题。它和传统的 SQL Injection 有一点类似：攻击者通过构造特殊输入，让系统把本来应该作为“数据”的内容，当成了“指令”执行。

=> Agent Runtime 就是 Agent 的“控制程序”，通常需要你自己编写；它正是 Loop 所在的位置。你也可以使用 LangChain、LangGraph、OpenAI Agents SDK 等框架减少代码量，但它们本质上是在替你实现或托管这部分 Runtime。

```
用户请求
→ Agent Runtime 组织上下文并调用 LLM
→ LLM 输出 JSON 形式的 tool call
→ Runtime 解析并校验 JSON
→ Runtime 调用真实 Tool / API
→ Runtime 将工具结果回传 LLM
→ Loop 继续，直到完成或触及限制
```

最简伪代码：

```python
messages = [user_message]

while within_limits():
    reply = llm.generate(messages, tools=tool_schemas)

    if reply.has_tool_call:
        call = reply.tool_call
        args = validate(call.arguments)       # JSON Schema + 业务校验
        check_permission(user, call, args)    # 外部安全控制
        result = execute_tool(call.name, args)

        messages.append(tool_result(call.id, result))
    else:
        return reply.text
```

 

## LangChain for AI Agents 20260908

LangChain Ecosystem: LangChain, LangGraph, LangSmith, Integrations

```
业务应用
├─ LangChain：组装 LLM、提示词、RAG、Tools
├─ LangGraph：控制 Agent 的状态、流程和 Loop  =>LangGraph≈Agent Runtime / Workflow Orchestrator
├─ Integrations：连接外部模型与系统
└─ LangSmith：观察、调试、评估与监控
```

=>2026年的课程还是演示 LangChain 来创建 AI Agents, 是不是有些落后了...

> =>使用 Codex 时，你已经拥有了 Agent Runtime，可以通过 Markdown 很方便地用自然语言甚至伪代码定义和组织 Agent 工作流。因此，在这种架构下，再使用 LangGraph 搭建一层 Agent Harness 的必要性就没有那么高了。
>
> 关键区别在于，Markdown 中的自然语言或伪代码，本质上仍然是由 Agent 解释和遵循的语义约束（soft constraints），而不是由 CPU 强制执行的确定性控制流（hard guarantees）。
>
> 因此，对于必须具备 hard guarantees 的部分——例如权限与 Policy enforcement、严格的状态转换、事务、一致性约束、审批门禁等——仍然需要使用 Python 或其他传统编程语言进行显式控制和定制化实现。
>
> 与其使用 LangGraph 再建立一层与 Codex 职责有所重叠的 Agent orchestration，不如将这些需要确定性和显式控制的逻辑下沉到 Tool 层，再通过 MCP 以标准化的工具接口暴露给 Codex。
>
> 这样可以形成一个比较清晰的职责分工：
>
> **Markdown 定义意图和 soft orchestration；Codex 负责推理、规划和动态 orchestration；MCP 定义标准化的 tool boundary；Tool implementation 负责 deterministic logic 和 hard guarantees。**
>
> 只有当应用本身需要一个复杂且独立于 Agent 的 deterministic workflow——例如需要持久化状态、严格的状态转换、checkpoint、长期暂停与恢复、人工审批、失败重试和可审计执行——才有必要进一步引入 LangGraph 或其他 workflow engine。
>
> 换句话说：
>
> **Let the agent decide what to do; let the tools enforce what it is allowed to do.**

```
                AI Agent
                   │
          ┌────────┴────────┐
          │                 │
   Agent-controlled    App-controlled
   orchestration       orchestration
          │                 │
        Codex            LangGraph
          │                 │
     AGENTS.md          Graph / State
     + Tools            + Agent Nodes
```





## Introduction to MCP 20260909

Model Context Protocol

MCP 的底层通信核心之一就是 JSON-RPC 2.0。它是一种非常简单的 RPC（Remote Procedure Call，远程过程调用）协议。

```json
{
  "jsonrpc": "2.0",
  "method": "add",
  "params": {
    "a": 1,
    "b": 2
  },
  "id": 1 #用来标记request <=> response
}
```

=>MCP就是用来规定jsonrpc，method等字段含义的协议



```
┌─────────────────────────────────┐
│  User                           │
│                                 │
│  "帮我查一下 ABC-123"           │
└──────────────┬──────────────────┘
               │ Natural Language
               ▼
┌─────────────────────────────────┐
│  LLM                            │
│                                 │
│  Tool Call:                     │
│  get_issue("ABC-123")           │
└──────────────┬──────────────────┘
               │ Structured Tool Call
               ▼
┌─────────────────────────────────┐
│  Agent Runtime                  │
│                                 │
│  Tool Manager                   │
│       ↓                         │
│  MCP Client                     │
└──────────────┬──────────────────┘
               │
               │ MCP Protocol
               │
               │ JSON-RPC 2.0
               │
               │ Transport
               │ ├── stdio
               │ └── Streamable HTTP
               ▼
┌─────────────────────────────────┐
│  MCP Server                     │
│                                 │
│  tools/list                     │
│  tools/call                     │
│                                 │
│  get_issue()                    │
└──────────────┬──────────────────┘
               │
               │ Jira Native API
               ▼
┌─────────────────────────────────┐
│  Jira                           │
└─────────────────────────────────┘
```

=>可以把MCP Client 理解成是 Agent Runtime 里的“外部 MCP 工具适配器/通信模块”，负责把 Agent 的工具调用转换成 MCP/JSON-RPC 请求，并把结果送回 Agent Runtime。



MCP Server = 工具/数据源这一侧的 MCP 适配层adapter。

一个最小 MCP Server

```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("demo-server") #FastMCP：用 Python 快速开发 MCP Server 的高级框架

@mcp.tool()     # 装饰器decorator可以在不修改原函数代码的情况下增加功能。
def add(a: int, b: int) -> int:
    """Add two numbers."""
    return a + b

if __name__ == "__main__":
    mcp.run()
```

=>复杂来说的话Authentication，business logic可以扩展开去许多模块，而把函数注册成 Tool其实只是一个交互接口而已。

=>MCP 有多种 Transport Mechanism。stdio 通常用于同机的本地 MCP Server，通过进程 stdin/stdout 通信；Streamable HTTP 通常用于远程 MCP Server，通过 HTTP 网络连接。







## OpenAI Agent Stack 20260921

> 主要介绍了 OpenAI Responses API 和 OpenAI Agents SDK。
>
> 可以将 OpenAI Agents SDK 类比为一个 OpenAI-native 的 Agent Framework，与 LangChain 处于相近的抽象层。它提供 Agent、Runner、Tools、Handoffs、Guardrails、Sessions 等更高层的 Agent 开发与编排能力。
>
> Responses API 则位于更底层，是 Agents SDK 调用 OpenAI 模型和相关能力的重要 API 基础。不过 Responses API 本身已经具备 Tool Calling、Function Calling、Built-in Tools 等 Agentic 能力，因此不能简单理解为传统的 Model API，而可以理解为 Model + Tool Calling + Agentic Primitives 的统一底座。
>
> 两者的关系可以概括为：
>
> Responses API 提供底层的 Model 与 Tool primitives；Agents SDK 在其之上提供更高层的 Agent Runtime / Framework abstraction。

Agent 开发正在从“Prompt + Function Calling”升级成“Model + Runtime + Skills + Tools/MCP + Sandbox + Memory + Multi-Agent”

=>Agent 编排分为两个层次：单个 Agent 内部由 LLM 动态编排 Tools；Agent 外部则通过 SDK 编排多个 Agent 及整体 Workflow。

=>构建Agent系统时，Agent 定义“谁来做”，Skill 定义“这类任务怎么做”，Tool 定义“具体能做什么”。建议先把重复工作 Skill 化，需要独立职责、上下文或权限时，再 Agent 化。

Function Calling = 模型请求调用某个函数型 Tool 的机制。  => 最早最典型的 Tool 就是开发者定义的 function，所以叫Function Calling ，所以 Function Calling 是 Tool Calling 的一种

 OpenAI 的工具体系可以概念化成：

```
                         Tools
                           │
        ┌──────────────────┼─────────────────┐
        │                  │                 │
        ▼                  ▼                 ▼
 Function Tools       Built-in Tools      MCP Tools
        │                  │                 │
        ▼                  ▼                 ▼
your Python/API        Web Search         Jira
functions              File Search        GitHub
                       Computer           Database
                       Code etc.          Enterprise API
```

=>guardrail 与 safety 也是重要的课题。

Codex 更像是 Agent Stack 上“软件工程 Agent”的产品化实现，同时 Codex 的 agent harness 又正在反过来成为 OpenAI 通用 Agent Stack 的核心基础设施。



## Agentic AI for OCI Enterprise AI 20261002

OCI Enterprise AI Agents 是 OCI Enterprise AI 中面向“生产级 Agentic AI 应用”的 Agent 平台能力。OCI Enterprise AI 于 2026 年 3 月 GA。

OCI Enterprise AI ≈ Model Gateway + Responses API + Agent Runtime + Tools/MCP + Memory + Vector Store/RAG + Sandbox + Hosted Deployment + Enterprise Governance

=>OCI Enterprise AI 的核心战略更偏向“Agent Infrastructure / Agent Platform”，而不是做一个面向终端用户、像 Codex 那样的完整 Agent 产品。



OCI OpenAI-compatible Responses API 基本沿用了 Native OpenAI Responses API 的“API contract / programming model”，但把后端实现替换成 OCI 的模型、认证、资源管理、网络和执行环境。OCI 没有重新发明 Agent northbound API，而是采用 OpenAI Responses API 作为兼容层；OCI 真正做差异化的是这个 API 后面的 model serving、IAM、Project、networking、data residency、tools、memory、containers 和 enterprise integration。

=>Oracle还是想跟OpenAI深度绑定兼容的



Deploying Agents - From Local Dev to Production: 本地开发 Agent → 容器化 → 推送 OCIR → OCI Generative AI Hosted Application → Deployment → Production Endpoint

> 1. 编写 `agent.py`：实现 FastAPI 服务和模型调用逻辑。
>
> 2. 编写 `Dockerfile`：定义 Python 环境、安装依赖、复制 `agent.py`，并规定容器启动时如何运行它，例如：
>
>    ```
>    CMD ["uvicorn", "agent:app", "--host", "0.0.0.0", "--port", "8080"]
>    ```
>
> 3. 执行 `build.sh`：先用 `docker build` 按 Dockerfile 构建镜像，再用 `docker run` 从镜像启动容器，检查 `/health` 和 `/ready`，最后停止并删除测试容器。

=>提前在 OCI Identity Domain 中注册 Integrated Application，取得应用凭据并配置权限。运行 Python 调用脚本，用应用凭据获取 Token。携带 Token 请求部署好的 Hosted Application。这个过程叫 **OAuth 2.0 Client Credentials Flow**.

File Search, Code Interpreter, Function Calling, MCP Calling

=>OCI Enterprise AI很新，大概From Local Dev to Production都没多少人用过吧...



=>2026年11月的时间点，OCI已经提供各种大模型的选项，包括Meta, Cohere, xAI Grok, Gemini, GPT

> **Context Length** 可以简单理解为：大模型一次能够处理多少信息，单位是 Token。
>
> 通常看到的 32K、128K、256K、1M，表示模型一次能够处理的 Token 数量。其中，K 表示千（1K ≈ 1,000 Tokens），M 表示百万（1M ≈ 1,000,000 Tokens），而不是 KB（千字节）或 MB（兆字节）。
>
> 需要注意，一个汉字不一定对应一个 Token，具体取决于模型使用的 Tokenizer（分词器）。粗略估算，1 个汉字可能对应 0.5–2 个 Tokens，不同模型和文本类型存在差异。
>
> | Context Length | 约能容纳的中文字数 | 直观理解             |
> | -------------- | ------------------ | -------------------- |
> | 32K            | 1.6–6.4 万字       | 一篇长文章或短篇小说 |
> | 128K           | 6.4–25.6 万字      | 一本小说             |
> | 256K           | 12.8–51.2 万字     | 多本书籍或大量文档   |
> | 1M             | 50–200 万字        | 大型文档集合         |
> | 2M             | 100–400 万字       | 大规模知识资料集合   |
>
> 注意： 以上为理论估算，实际可容纳的文字数量取决于 Tokenizer、文本内容及上下文预留空间。
>
> Context Length 越大，模型一次能处理的信息越多，但不代表理解能力一定越强。





## Agentic AI for Oracle AI Database 20261006

Agentic AI for Database = AI Vector Search +  Agent Factory + Select AI Agent + Autonomous MCP Server + More...

Oracle AI Database 想成为 AI Agent 的数据、知识、分析和工具执行底座。

Oracle AI Vector Search: Brings semantic search capability directly into Oracle DB

Oracle AI Database Private Agent Factory: a no-code platform that lets business users and AI engineers rapidly built, teat, and deploy intelligent AI agents - without writhing any code

Select AI Agent: a framework for creating and managing interactive, autonomous agents that live inside the Oracle AI Database

Oracle Autonomous AI Database MCP Server: a multi-tenant, built-in feature of Autonomous AI Database that exposed MCP endpoints, letting AI agents invoke tools

=>Private Agent Factory 跟 OCI Enterprise AI产品定位上有重复处，因为AI发展太迅速了，估计都还在探索阶段



## Fundamentals of Agentic AI 20261020

Lilian Weng，她曾在 OpenAI 从事 AI 研究，2023年撰写了著名文章 《[LLM Powered Autonomous Agents](https://lilianweng.github.io/posts/2023-06-23-agent/?utm_source=chatgpt.com)》。

AI Agent = LLM + Memory + Planning + Tools

=>了解到Codex有自己的Native Memory来记载分析过的内容(尽管也许会经过内容压缩)，可以通过不同thread即窗口切换不同上下文，所以如果特别本地存储一个database留存分析过的内容更大的作用是偏向于知识检索总结用。



Andrew Ng: Reflection, Tool use, Planning and Multi-agent collaboration

Andrew Ng 的系列文章：

- [Agentic Design Patterns — Reflection](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection?utm_source=chatgpt.com)
- [The Batch — Andrew Ng 关于 Agentic Workflows 的讨论](https://www.deeplearning.ai/the-batch/issue-242?utm_source=chatgpt.com)
- [Agentic AI — DeepLearning.AI 系统课程](https://www.deeplearning.ai/courses/agentic-ai?utm_source=chatgpt.com)

=>Reflection、Planning、Tool Use 这些 Agentic Design Patterns，实际上已经在很大程度上融合进 Codex 的工作机制中了



Anthropic's Principle: Start Simple. Add tools, loops, and multiagent layers only when they demonstrably improve outcomes.



With Tools: Web search, Code execution, Database queries, API calls, Custom function

Built-in Tools vs Custom Function Tools

Tool Schemas: Defining Tools the LLM can understand

=> Agent 的能力应该由开发者预先定义，还是应该允许 Agent 在执行任务时动态扩展自己的能力？



Tool Discovery: How Agents Find Tools at Run Time

Schemas hardcoded at build time

MCP-- Tool discovery at runtime

The Agent loop needs only two changes for MCP -- list_tool() replaces the hardcoded tools array, mcp.call_tool() replaces the local function call.

MCP and custom function calling are not mutually exclusive

=>OpenAI Codex, Claude Code均支持MCP

> Codex CLI 和 Codex 桌面版（Codex App）本质上使用同一套 Codex Agent 引擎（Harness），但提供不同的交互界面和任务管理能力。
>
> OpenAI Codex CLI 是开源的，而且开源的不只是命令行界面，还包括相当重要的 Agent 核心实现（Codex Harness）
>
> https://github.com/openai/codex?utm_source=chatgpt.com
>
> 使用rust，上百万行代码

=>Codex CLI源码(使用rust)中就明确有 codex-rs/codex-mcp，此就是MCP Client模块

> MCP Client 分为两层：`codex-mcp` 管理集成、连接和工具目录，`codex-rmcp-client` 实现底层协议客户端。

=>Codex 通常是**提前配置**Tool服务器，在运行过程中发现工具并建立绑定。



The Four Memory Types: In-Context, Episodic, Semantic, Procedural  =>Codex的memory就不见得按这个分类来设计的

A taxonomy borrowed from cognitive science: each type stores different information and is accessed differently.

Retrieval-Augmented Generation--embed the query, search the store, inject the results

At scale, passing all tools schemas on every call wastes token and confused the model --  retrieve only what fits the task.

=>ChatGPT 会维护与用户相关的长期记忆，用于概括用户的偏好、习惯和持续性背景。用户可以开启、关闭、纠正或删除记忆，但无法精确控制系统如何从对话中筛选、归纳和更新这些信息。

=>ChatGPT 主要依据当前会话中可用的上下文生成回答；当记忆功能启用且相关信息有助于回答时，也可能结合长期记忆或其他历史背景。当前可用上下文不一定包含本窗口的全部历史消息。

=>即使 Codex 具备上下文管理和长期记忆机制，自建本地票据快照仍有价值。它为每个票提供明确、可核查的恢复依据。就Codex源码看来，他并未采取基于Vector的RAG搜索保存的长期记忆，而是用纯文本搜索...



## OCI Enterprise AI Agents 20261109

**Responses API** 是面向 AI Agent 场景设计的 API，通过统一的输入输出模型、**内置工具调用循环**、服务端多轮状态管理和 Prompt Caching 支持，简化 Agent 开发，并为长对话和复杂任务提供更方便的管理方式。

Built-in Tools: Web search, File Search, Code Interpreter, Remote MCP Servers

=>使用 Codex + Skills 编排固定工程工作流的情况下，基本接触不到  Responses API 这一底层。但Codex CLI 本身就使用 Responses API 进行模型推理。

Chat Completions 是 OpenAI 提供的一种模型调用 API，用于让开发者把对话消息发送给大模型，并获得模型生成的回复。它可以理解为 Responses API 之前最主要的对话式模型接口。

=>Chat Completions就是之前Langchain框架里调用的OpenAI API吧，Chat VS Agent的感觉。

Use the Response API when you need built-in tools or simple multiturn flow. Use Chat Completions when you need full control over every step of the loop.

=> 从 AI 应用开发者视角看，目前Responses API 可以算是 OCI Enterprise AI 最重要的统一入口



OCI Response API Four Tool Types: File Search, Code Interpreter, Remote MCP Calling, Function Tools

=>Codex代码和终端命令会在你的电脑上执行,这里调用的是本机终端和 Python 等工具，不一定是一个独立内置的Code Interpreter； 

=>File Search在Agent开发语境中 通常指“搜索已上传的文件知识库（通常转化为向量）”，而不是直接扫描本地电脑。像我用Codex搜索Oracle官方文档用的其实是用网页搜索／读取工具 `web.run`, 读内部文档是通过 Confluence MCP 连接器，都跟File Search无关。



> OCI Generative AI 的 Remote MCP Calling，核心就是：把 MCP Server 地址放进 Responses API 请求，OCI 服务端负责调用远程工具，再把结果交给模型继续生成回答。 客户端不用自己执行工具、回传结果。
>
> 接入代码大致这样：
>
> ```python
> import os
> from openai import OpenAI
> 
> client = OpenAI(
>  base_url=(
>      "https://inference.generativeai.us-chicago-1"
>      ".oci.oraclecloud.com/openai/v1"
>  ),
>  api_key=os.environ["OCI_GENAI_API_KEY"],
>  project=os.environ["OCI_GENAI_PROJECT_OCID"],
> )
> 
> response = client.responses.create(
>  model=os.environ["OCI_MODEL_ID"],
>  input="查询 INC-123 的当前状态",
>  tools=[{
>      "type": "mcp",
>      "server_label": "incident_tools",
>      "server_url": "https://your-server.example.com/mcp",
>      "authorization": os.environ["MCP_ACCESS_TOKEN"],
>      "allowed_tools": ["get_incident"],
>      "require_approval": "never",  # 示例：允许该查询工具直接执行
>  }],
> )
> 
> print(response.output_text)
> ```
>
> Oracle 的 MCP Calling与Codex MCP的共同逻辑都是：发现工具 → 模型选择工具并生成参数 → client 调用 MCP Server → 结果交回模型。模型本身不负责建立 MCP 网络连接。
>
> 所以，可以把 OCI Remote MCP Calling 理解为：把 MCP client 和相关调用编排托管到了 OCI 推理服务侧。

部署流程是：开发 MCP Server（如 FastMCP） → 打包 Docker 镜像 → 推送 OCIR → 部署为 OCI Hosted App → 获得 HTTPS Endpoint。

开发 MCP Server： Implement your MCP server using a framework that supports Streamable HTTP transport. Python FastMCP is a popular choice. Define your tools as @mcp.tool decorated functions.

=>如果想要开发OTS MCP Server, 估计可以使用Python FastMCP框架。



=>**大模型与 ChatGPT 是两个不同层次的概念**：大模型在单次推理时，可以近似理解为“接收一份上下文，再生成输出”，不会自动追溯此前的聊天记录；ChatGPT 则是围绕大模型构建的完整应用，由外围系统管理历史对话、用户记忆和工具，并将相关信息纳入模型本次可见的上下文。OpenAI 的 Responses API 和 Conversations API 向开发者提供模型调用、工具使用及会话状态管理等能力(虽不能据此认定 ChatGPT 内部完全通过这些公开接口实现)。OCI Responses API提供的正是类似的平台能力：在模型调用之外，通过短期记忆延续当前对话(**Short-Term Memory**)、通过上下文压缩控制长对话的开销(**Short-Term Memory Compaction**)、通过长期记忆保存成可检索的向量并召回跨会话信息(**Long-Term Memory**)，帮助开发者构建具有连续交互和任务执行能力的 Agent。因此，这些记忆机制主要位于模型之外，负责决定“保存什么信息，以及每次让模型看到什么”，通常不会与模型本身的能力重复。

=> ChatGPT 和 Codex 可以使用相同或相关的模型，但各自的外围系统可能采用不同的逻辑，决定保存哪些信息、如何检索历史、怎样压缩上下文，以及每次向模型提供哪些内容，因此两者表现出的记忆能力和任务连续性也可能不同。

OCI Vector Stores 可以理解为 Agent 的“可检索知识库”：把企业文档处理成可按语义搜索的数据，回答问题时找出相关段落，再提供给大模型。它是 Responses API 配套的基础资源，主要用于 RAG（检索增强生成）。

=>不知道OCI Vector Store底层索引引擎是啥

=>OCI 正从通过 LangChain 集成模型、由开发者自行组合 Agent 能力，逐步扩展为直接提供托管的 Agent 构建服务：2026 年 3 月 31 日，包含 OCI Responses API 的 Enterprise AI Agents 正式可用，将工具调用、会话管理、记忆和知识检索等能力整合进云平台。