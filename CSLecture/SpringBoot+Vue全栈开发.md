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



## P8 Vue框架快速上手

前端环境准备：编码工具 VSCode，依赖管理 NPM，项目构建 VueCli

Vue.js提供了MVVM数据绑定和一个可组合的组件系统，具有灵活的API

MVVM：Model-View-ViewModel

