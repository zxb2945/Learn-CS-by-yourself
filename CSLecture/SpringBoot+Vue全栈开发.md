# SpringBoot+Vue

视频地址：https://www.bilibili.com/video/BV1nV4y1s7ZN?p=3&vd_source=cfea4a81af3552025602bbed3cecda4f

## P1 课程介绍及环境准备 20221221

课程内容：

Java EE企业级框架：SpringBoot+MyBatisPlus

Web前端核心框架：Vue+ElementUI

公共云部署：前后端项目集成打包与部署



目前市面上软件架构主要两种：

BS：(Browser/Server);  =>更适合Web，应用程序的逻辑和数据都存储在服务端

CS：(Client/Server); 比如QQ，客户端负责大多数业务逻辑和UI演示，被称为胖客户端



JDK+IntelliJ IDEA + Maven

Maven:

1. 项目构建：提供标准的，跨平台的自动化构建项目的方式
2. 依赖管理：方便快捷的管理项目依赖的资源（jar包）
3. 统一开发结构：提供标准的，统一的项目开发结构



## P2 SpringBoot快速上手

简化SSM应用的初始搭建和开放过程，尽可能降低开发门槛

SSM：Spring+SpringMVC+MyBatis

遵循“约定优于配置”的原则，只需要很少的配置或使用默认的配置

内嵌了Tomcat服务器，不需要为Tomcat部署war包，直接使用jar包

定制好Maven配置，开箱即用

纯Java配置，不需要XML配置

提供了生产级的服务监控方案



开发环境热部署：利用spring-boot-devtools组件实现CICD

修改target/pom.xml, src/main/resources/application.properties



## P3 SpringBoot Controller

SpringBoot 将传统web开发的mvc,json,tomcat等框架整合，提供了spring-boot-starter-web组件，简化了Web应用配置

webmvc为web开发的基础框架，json为JSON数据解析组件，tomcat为自带的容器依赖



SpringBoot提供了@Controller和@RestController两种注解来标识此类负责接受和处理HTTP请求

@Controller : 页面和数据 =>用了这个前后端不分离了

**@RestController**：只是请求数据（与前端框架配合使用）

就是MVC模式中的C

@RestController注解会将返回的对象数据转化为JSON格式



路由映射：

**@RequestMapping**注解主要负责URL的路由映射。可添加在Controller类或者具体的方法上

@RequestMapping注解包含很多属性参数来定义HTTP的请求映射规则

value: 请求URL路径 => @RequestMapping**("/user")**    支持通配符匹配URL

method: 请求方法 

```java
@RequestMapping(value="/getDate",method=RequestMethod.GET)
public String getData(){
    return  "hello";
}
```



参数传递：

@RequestParam

@RequestBody   =>接收json格式



浏览器只能发送一些简单的GET请求

要调试PUT等请求的话，下载Apipost或者postman的调试工具客户端



## P4 SpringBoot文件上传+拦截器 20230106

静态资源的访问：

SpringBoot默认创建出classpath:/static/目录，也可以自定义

在application.properties中可直接定义过滤规则和静态资源位置

> Spring Boot使用“习惯优于配置”（项目中存在大量的配置，此外还内置了一个习惯性的配置，让你无需手动进行配置）的理念让你的项目快速运行起来。所以，我们要想把Spring Boot玩的溜，就要懂得如何开启各个功能模块的默认配置，这就需要了解Spring Boot的配置文件application.properties。
>
> Spring Boot使用了一个全局的配置文件application.properties，放在src/main/resources目录下或者类路径的/config下。Sping Boot的全局配置文件的作用是对一些默认配置的配置值进行修改。

文件上传原理：

SpringBoot工程嵌入的tomcat安置了请求的文件大小，可在application.properties修改

拦截器：

SpringBoot定义了HandlerInterceptor接口来实现，接口中定义了preHandle,postHandle,afterCompletion三个方法

比如用preHandle先拦截一下用户请求，如果用户没有登录，拦截掉

@Configuration



## P5 RESTful服务+Swagger

POST,GET,PUT,DELETE

2XX：成功

3XX：重定向，表示客户端必须执行一些其它操作才能完成其请求

4XX:  客户端错误

5XX：服务器错误，服务器负责这些错误状态码

SpringBoot提供组件完全支持开发RESTful API

如@GetMapping, @PostMapping,@PutMapping,@DeleteMapping...



Swagger能够自动生成完善的RESTful API文档，根据后台代码动态更新，随时提供给前端调用

```java
@Configuration //告诉Spring容器，这个类是一个配置类
@EnableSwagger2 //启用Swagger2功能
```

在pom.xml加入依赖

> POM全程Project Object Model，又称项目对象模型。他是Maven工程的基本工作单元，是一个XML（可扩展标记语言）文件，包含了项目的基本信息，用于描述项目如何构建，声明项目依赖等等。执行任务或目标时，Maven会在当前目录中查找 POM并读取从而获取所需的配置信息执行目标，属于项目级别的配置文件。
>
> 总之pom最厉害的是提供一站式支持，可用于管理：源代码、配置文件、缺陷跟踪系统（defect tracking system）、组织和许可证（licenses）、项目所在的URL地址、开发者的信息和角色、项目依赖以及其他所有的和代码生命周期相关的方面。而在Maven中就只需要一个pom.xml文件，可以说pom.xml就是Maven的核心

前端人员就可以很方便查看后端开发了哪些接口，并可以直接调试



## P6 MybatisPlus快速上手 20230107

ORM: Object Relational Mapping 是为了解决面向对象与关系数据库不匹配的问题

MyBatis是一款优秀的数据持久层ORM框架

MyBatisPlus是加强版



在pom.xml加入MyBatisPlus与MySQL相关依赖

在application.properties加入各种属性配置，如密码用户名



创建controller=>网页访问接口, entity=>对应数据库表名的类, mapper=>增删改查 三个类



CRUD操作

@Insert, @Update, @Delete, @Select

```java
@Mapper
public interface UserMapper{
	@Select("select * from user")
	public List<User> find();
}
```

以上是MyBatis的作法，而MyBatisPlus连CRUD操作也可以全部隐藏



## P7 MyBatis多表查询及分页查询

实现复杂关系映射，多表查询可以使用@Results, @Result, @Many等注解来操作

MyBatisPlus只是对单表查询优化



分页查询需要定义一个配置类，在/src/main/java下增加Config类



## P8 Vue框架快速上手 20230108

前端环境准备：编码工具 VSCode，依赖管理 NPM，项目构建 VueCli

Vue.js提供了MVVM数据绑定和一个可组合的组件系统，具有灵活的API

MVVM：Model-View-ViewModel

完全屏蔽了DOM

首先Vue是js的框架

感觉就是在一个html文件中编写data+渲染

就是html中加CSS和Js，那么VUE框架体现在哪里呢？加了更多的关键字？比如`v-for`?

`v-model` 双向绑定  



## P9 Vue组件化开发

Vue提供了很多组件来加快开发频率

NPM的使用：(Node Package Manager)是一个NodeJS包管理和分发工具，相当于Java中的Maven，其中的package.json相当于pom.xml =>要使用NPM，首先得安装Node

Node.js是一个基于Chrom V8引擎的JavaScript运行环境



Vue CLI使用：用于快速搭建一个带有热重载及构建版本等的页面使用

（在windows下文件路径直接输入cmd，就可以打开窗口，powershell也一样）



Vue中规定组件的后缀名是.vue

每个.vue组件都是由三部分构成：

1. templete，组件的模板结构，可以包含HTML标签及其它的组件
2. script，组建的Javascript代码
3. style，组件的样式



## P10 第三方组件element-ui 20230110

Element是国内饿了么公司提供的一套开源前端框架，提供了Vue，React等版本

Website：https://element.eleme.io/#/zh-CN

由于Element UI提供的字体图符较少，一般会采用其他图标库，如著名的Font Awesome



## P11 Axios网络请求

在实际项目开发中，前端页面所需要的数据往往需要从服务器端获取，这必然涉及到与服务器的通信。

Axios是一个基于promise网络请求库，作用于node.js和浏览器中。

Axios在浏览器端使用XMLHttpRequest(Ajax)发送网络请求，并能自动完成JSON数据的转化。



前后端交互时有时需要解决CORS问题，在后端SpringBoot中添加@Configuration

然后前后端就可以通信了



## P12 前端路由VueRouter 20230111

Vue的单页面应用是基于路由和组件的，路由用于设定访问路径，并将路径和组件映射起来

对于单页面的应用而言（如网易云音乐），页面的刷新基于组件的切换

VueRouter就是Vue官方提供的插件



## P13 状态管理VueX

解决兄弟组件数据传递

VueX是一个专为Vue.js应用程序开发的状态管理库，采用集中式存储管理应用的所有组件的状态



Vue Component <= State <=  Mutation <=  Action <= Vue Component

Action <=> Backend API

State：用于维护所有应用层的状态，并确保应用只有唯一的数据源

Mutation：提供了修改State的方法

Action: 类似于Mutation，不同处在于前者不能直接修改状态，只能通过提交Mutation来修改，Action可以包含异步操作

Getter:维护由State派生的一些状态，这些状态随着State状态的变化而变化



一般VueX的逻辑放在store文件夹



## P14 前端数据模拟MockJS 20230223

> 拦截ajax请求，生成伪数据
> 应用场景:在工作中,后端已经出接口文档,还没有实现代码
> 由前端依照接口文档模拟伪数据,实现前端开发功能

## P15 vue-element-admin后台集成方案

> vue-element-admin 是一个后台前端解决方案，它基于 vue 和 element-ui实现，它使用了最新的前端技术栈，内置了动态路由，权限验证，提炼了典型的业务模型，提供了丰富的功能组件，它可以帮助你快速搭建企业级中后台产品原型；
> 集成方案: vue-element-admin
> 基础模板: vue-admin-template（功能少一些）
> 桌面终端: electron-vue-admin
> Github: https://github.com/PanJiaChen/vue-element-admin

=>vue-element-admin 后台管理系统

> vue-element-admin有一个成熟的集成方案，里面包含了所有的业务功能和场景,并不适合直接拿来进行二次开发, 但是可以通过该项目中的一个案例来进行学习和使用.

## P16 JWT跨域认证

Session认证

Token认证

> ## **session认证**
>
> 众所周知，http 协议本身是无状态的协议，那就意味着当有用户向系统使用账户名称和密码进行用户认证之后，下一次请求还要再一次用户认证才行。因为我们不能通过 http 协议知道是哪个用户发出的请求，所以如果要知道是哪个用户发出的请求，那就需要在服务器保存一份用户信息(保存至 session )，然后在认证成功后返回 cookie [值传递](https://so.csdn.net/so/search?q=值传递&spm=1001.2101.3001.7020)给浏览器，那么用户在下一次请求时就可以带上 cookie 值，服务器就可以识别是哪个用户发送的请求，是否已认证，是否登录过期等等。这就是传统的 session 认证方式。
>
> session 认证的缺点其实很明显，由于 session 是保存在服务器里，所以如果分布式部署应用的话，会出现session不能共享的问题，很难扩展。于是乎为了解决 session 共享的问题，又引入了 redis，接着往下看。
>
> ## **token认证**
>
> 这种方式跟 session 的方式流程差不多，不同的地方在于保存的是一个 token 值到 redis，token 一般是一串随机的字符(比如UUID)，value 一般是用户ID，并且设置一个过期时间。每次请求服务的时候带上 token 在请求头，后端接收到token 则根据 token 查一下 redis 是否存在，如果存在则表示用户已认证，如果 token 不存在则跳到登录界面让用户重新登录，登录成功后返回一个 token 值给客户端。
>
> 优点是多台服务器都是使用 redis 来存取 token，不存在不共享的问题，所以容易扩展。缺点是每次请求都需要查一下redis，会造成 redis 的压力，还有增加了请求的耗时，每个已登录的用户都要保存一个 token 在 redis，也会消耗 redis 的存储空间。

JWT

> JWT (全称：Json Web Token)是一个开放标准(RFC 7519)，它定义了一种紧凑的、自包含的方式，用于作为 JSON 对象在各方之间安全地传输信息。该信息可以被验证和信任，因为它是数字签名的。

=>用 JWT 来解决前后端分离项目中的跨域认证还是非常丝滑的，这主要得益于 JSON 的通用性，可以跨语言，JavaScript 和 Java 都支持；另外，JWT 的组成非常简单，非常便于传输；还有 JWT 不需要在服务器端保存会话信息（Session），非常易于扩展。

## P17 Springboot+vue-element-template

## P18 阿里云服务器使用

## P19 SpringBoot+Vue云端环境配置

## P20 SpringBoot+Vue项目云端部署
