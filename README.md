# 如何打开Mac OSX原生的读写NTFS功能

步骤如下，没有耐心的，可以直接看脚本处理

## 一、手动处理

### 1、打开终端

实用工具 --> 终端

可以这样：Launch（启动台）--> Other（其他）--> Terminal（终端）

### 2、查看到磁盘

#### 方式一：

执行命令：**diskutil list**    例如：

```
/dev/disk0 (internal):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                         251.0 GB   disk0
   1:                        EFI EFI                     314.6 MB   disk0s1
   2:                 Apple_APFS Container disk1         250.7 GB   disk0s2

/dev/disk1 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +250.7 GB   disk1
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            235.0 GB   disk1s1
   2:                APFS Volume Preboot                 45.0 MB    disk1s2
   3:                APFS Volume Recovery                522.7 MB   disk1s3
   4:                APFS Volume VM                      1.1 GB     disk1s4

/dev/disk2 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *2.0 TB     disk2
   1:               Windows_NTFS ayongsDisk             2.0 TB     disk2s1

```

找到外接磁盘，例如我的盘：ayongsDisk

#### 方式二：

执行命令：**ls /Volumes/**



### 3、更新 /etc/fstab文件

执行命令：**sudo nano /etc/fstab**

输入电脑密码

出现编辑的界面，

输入命令：**LABEL=ayongsDisk none ntfs rw,auto,nobrowse**，注意，如果名字有空格，请用"/040"替代空格

注释：rw标识读写权限，nobrowse非常重要，因为这个代表了在finder里不显示这个分区，这个选项非常重要，如果不打开的话挂载是不会成功的。

按 Ctrl + X退出， 按 Y 保存并退出

### 4、重启电脑

这个就不说了，重启电脑即可

### 5、找到外接磁盘

这里有几种方法：

**方法一：**

打开磁盘工具，在外置磁盘中找到你的磁盘，右击，在Finder（访达）中显示

**方法二：**

Macintosh HD --> Volumes，找到外接磁盘

**方法三：**

创建快捷键

执行命令：**sudo ln -s /Volumes/ayongsDisk ~/Desktop/ayongsDisk**，此时桌面上就有一个ayongsDisk磁盘的快捷键了

### 6、显示到Finder边栏

通过上面某种方法找到外界磁盘，然后拖拽到Finder边栏





## 二、脚本处理

脚本可以实现一部分自动化，简化工作，没有那么繁琐，下面提供一下脚本下载地址：https://github.com/iyongzai/NTFSForMac/blob/master/NTFSForMac.sh

此脚本实现了上面的前4步。

后面的步骤参照上面的第5、6步