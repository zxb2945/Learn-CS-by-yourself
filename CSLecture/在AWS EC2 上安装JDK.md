# 在AWS EC2 上安装JDK

1. Windows上用PowerShell远程登录EC2

   ```shell
   //下载EC2XXX.pem密钥到桌面,x.x.x.x为EC2公网ip
   PS C:\Users\XX\Desktop> ssh -i EC2XXX.pem ec2-user@x.x.x.x
   Last login: Fri Dec  2 00:43:32 2022 from softbank126121223068.bbtec.net
   
          __|  __|_  )
          _|  (     /   Amazon Linux 2 AMI
         ___|\___|___|
   
   https://aws.amazon.com/amazon-linux-2/
   1 package(s) needed for security, out of 1 available
   Run "sudo yum update" to apply all updates.
   [ec2-user@ip-172-31-8-147 ~]$
   ```

2. 安装JDK最新版本

   ```shell
   #查看yum上JDK版本
   yum -y list java*
   #切换到root权限
   sudo -i
   #注意安装尾缀为-devel，否则只安装让程序运行的动态库和配置文件，不安装javac等开发工具
   #如果安装1.8及以前的版本还需修改/etc/profile来配置环境变量
   yum install java-17-amazon-corretto-devel.x86_64
   #查看版本
   java -version
   #确认编译器安装成功
   which javac
   ```

3. 创建项目测试

   ```shell
   mkdir project
   cd project
   mkdir src bin
   mkdir -p src/com/company
   vi src/com/company/Test.java
   mkdir bin/project
   #编译
   javac ./src/com/company/Test.java -d ./bin/project/
   #运行
   java -cp ./bin/project/ com.company.Test
   ```

   ```java
   package com.company；//别忘了分号
   public class Test{ //唯一的public类名要与文件名相同
       public static void main(String[] args){
           System.out.println("Hello World");
       }
   }
   ```

   

