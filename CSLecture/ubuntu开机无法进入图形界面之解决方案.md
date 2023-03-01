# ubuntu开机无法进入图形界面之解决方案

## 原因探究：

ubuntu上作业过程中收到磁盘空间不足的提醒，判断失误，第一反应直接重启OS了。

ubuntu启动时停留于黑屏，唯一的错误信息是：

```shell
piix4_smbus 0000:00:007.3: Host SMBus controller not enabled!
```

调查后发现：

> **piix4** 的一个次要功能是实现SMBus，而我们不能在I2C级别上访问SMbus。
> 错误原因VMware实际上并没有为CPU访问提供那个级别的接口，但是Ubuntu试图加载该内核模块（piix4）。所以会报错，**但是这个错误对系统没有影响**。

结论：上述错误信息并不是无法进入桌面的原因。

再次重新启动，出现Ubuntu图标时，按 CTRL + ALT + F3 试图进入 TTY 界面

> TTY概念略复杂，简单看成无需通过图形界面进入的交互式命令行终端

方才发现真正的错误信息：

```shell
[Failed] Started GONEM Dispaly Manager
```

推测是磁盘空间不足以至于无法进入图形界面

## 解决方案：

重新在Vmware上启动Ubuntu，在启动那一刹那，**鼠标点击界面，长按shift键**，进入GNU GRUB界面；

选择Advanced options for Ubuntu；

进入recover mode;

选择clean；（**为Ubuntu临时启动腾出点空间**）

然后resume；

顺利重启桌面后，启动终端，用下列命令查询磁盘空间占有情况，清除不必要的内存。

```shell
du -sh
du -lh --max-depth=1
```

在重新启动Ubuntu，顺利进入图形界面，问题解决。

2023.3.1