### Centos  设置共享文件夹

1.挂载镜像文件： 虚拟机->设置->硬件->CD/DVD.右边“连接”下面选择“使用IOS镜像文件”，浏览选择虚拟机包目录下面linux.iso （注意是虚拟机VMware的安装目录）

2.挂载VMware Tools安装程序到/mnt/cdrom/

```
mkdir /mnt/cdrom
mount /dev/cdrom /mnt/cdrom
```

3.解压安装VMware Tools

```
cd /mnt/cdrom
tar -zxvf VMware Tools-9.6.tar.gz -C /tmp
```

4.安装，进去后一路回车

```
cd /tmp/vmware-tools-distrib/
./vmware-install.pl
```

5.在虚拟机界面设置设置共享目录： 虚拟机->设置->选项->共享文件



上述步骤结束之后，一般来说，在/mnt/hgfs有存在上面共享的文件夹。

没有的话参照以下步骤：



### VMware-tools安装好后找不到共享文件夹的解决办法

1.一般共享文件夹在 `/mnt/hgfs`下面, 如果没有，使用下面步骤，看是否有共享文件夹。

```
vmware-hgfsclient
```

2.`/mnt/hgfs`下面没有共享文件夹, 是因为没有挂在, 我们把它挂载上即可。使用下面步骤将所有共享装载到 /home/zxb/Share

```
/usr/bin/vmhgfs-fuse .host:/ /home/zxb/Share -o subtype=vmhgfs-fuse,allow_other
```

3.重启之后若出现以下问题

```
[root@localhost zxb]# ls
ls: cannot access 'Share': Transport endpoint is not connected
```

则可以用一下命令清除挂载，注意Share是文件名。再重复操作2.

```
fusermount -u Share
```



### 追记

上述问题的原因在于，每次重启或者切换用户，共享文件需要手动再次挂载，即用如下命令

```
vmhgfs-fuse .host:/ /mnt/hgfs
```

如果每次重启之后想让系统自动挂载

```
vi /etc/fstab: 
```

在最后添加一行： 

```
.host:/ /home/zxb/Share fuse.vmhgfs-fuse allow_other 0 0
```

