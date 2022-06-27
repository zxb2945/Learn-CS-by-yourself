# 鸟哥的Linux私房菜-服务器架设篇

## 1.架设服务器前的准备工作

架站需要很强的 Linux 基础概念以及基础网络知识

对于网络服务器来说最重要的基础档案权限、程序之启动关闭与管 理、 Bash shell 之操作与 script 、使用者账号的管理等等，您都必须要具备最基础 的认知才行

> Linux/Unix 的文件调用权限分为三级 : 文件所有者（Owner）、用户组（Group）、其它用户（Other Users）。
>
> | r    | 读       | 设置为可读权限   |
> | ---- | -------- | ---------------- |
> | w    | 写       | 设置为可写权限   |
> | x    | 执行权限 | 设置为可执行权限 |

## 2.基础网络概念

一组合理的网络设定需

 IP  Netmask  Network  Broadcast  Gateway  DNS

Network 与 Broadcast 可以经由 IP/Netmask 的计算而得到，因此需 要设定于你 PC 端的网络参数， 主要就是 IP, Netmask, Default Gateway, DNS 这四 个就是了！

## 3.局域网络架构简介

