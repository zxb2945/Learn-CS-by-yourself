# 在AWS EC2 上安装JDK

## 1.Windows上用PowerShell远程登录EC2

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

## 2.安装JDK最新版本

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

## 3.创建Hello项目测试

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

## 4.创建Socket项目测试

```shell
#编译客户端
vim ./src/websocket/client/GreetingClient.java
javac ./src/websocket/client/GreetingClient.java -d ./bin/project/
#编译服务端
vim ./src/websocket/server/GreetingServer.java
javac ./src/websocket/server/GreetingServer.java -d ./bin/project/
#启动服务端
java -cp ./bin/project/ GreetingServer 6066
#另开窗口启动客户端
java -cp ./bin/project/ GreetingClient localhost 6066
```

```java
// 文件名 GreetingServer.java
 
import java.net.*;
import java.io.*;
 
public class GreetingServer extends Thread
{
   private ServerSocket serverSocket;
   
   public GreetingServer(int port) throws IOException
   {
      serverSocket = new ServerSocket(port);
      serverSocket.setSoTimeout(10000);
   }
 
   public void run()
   {
      while(true)
      {
         try
         {
            System.out.println("等待远程连接，端口号为：" + serverSocket.getLocalPort() + "...");
            Socket server = serverSocket.accept();
            System.out.println("远程主机地址：" + server.getRemoteSocketAddress());
            DataInputStream in = new DataInputStream(server.getInputStream());
            System.out.println(in.readUTF());
            DataOutputStream out = new DataOutputStream(server.getOutputStream());
            out.writeUTF("谢谢连接我：" + server.getLocalSocketAddress() + "\nGoodbye!");
            server.close();
         }catch(SocketTimeoutException s)
         {
            System.out.println("Socket timed out!");
            break;
         }catch(IOException e)
         {
            e.printStackTrace();
            break;
         }
      }
   }
   public static void main(String [] args)
   {
      int port = Integer.parseInt(args[0]);
      try
      {
         Thread t = new GreetingServer(port);
         t.run();
      }catch(IOException e)
      {
         e.printStackTrace();
      }
   }
}
```

```java
// 文件名 GreetingClient.java
 
import java.net.*;
import java.io.*;
 
public class GreetingClient
{
   public static void main(String [] args)
   {
      String serverName = args[0];
      int port = Integer.parseInt(args[1]);
      try
      {
         System.out.println("连接到主机：" + serverName + " ，端口号：" + port);
         Socket client = new Socket(serverName, port);
         System.out.println("远程主机地址：" + client.getRemoteSocketAddress());
         OutputStream outToServer = client.getOutputStream();
         DataOutputStream out = new DataOutputStream(outToServer);
 
         out.writeUTF("Hello from " + client.getLocalSocketAddress());
         InputStream inFromServer = client.getInputStream();
         DataInputStream in = new DataInputStream(inFromServer);
         System.out.println("服务器响应： " + in.readUTF());
         client.close();
      }catch(IOException e)
      {
         e.printStackTrace();
      }
   }
}
```



## 5.安装Tomcat

```shell
#下载安装包
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz
#切换root
sudo -i
#解压
tar -zxvf apache-tomcat-10.0.27.tar.gz
#移动
mv apache-tomcat-10.0.27 /usr/local/tomcat10
cd /usr/local/tomcat10
#添加环境变量
vi /etc/profile
#配置Tomcat环境变量
export CATALINA_HOME=/usr/local/tomcat10
export PATH=$PATH:$CATALINA_HOME/bin
#使配置生效
source /etc/profile
#启动
./startup.sh
#查看8080端口是否监听
#浏览器可远程访问x.x.x.x:8080测试
netstat -tunlp
#关闭
./shutdown.sh
```

