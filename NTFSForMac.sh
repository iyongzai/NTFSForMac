echo "------您电脑上所有磁盘如下------"
#diskutil list
path="/Volumes/"
ls $path
echo "------------------"

echo "请输入您想要安装NTFS驱动的磁盘名称(名称上面已经全部罗列出来了，请复制粘贴后回车即可。注意：如果名称包含特殊字符，有可能会遇到问题，建议先修改磁盘名称后再操作)！"
read name
while([ -z $name ] || [ ! -d $path$name ])
do
    echo "请输入您正确的外接磁盘名称"
read name
done

file=/etc/fstab
if  [ ! -d $file ]; then
    sudo touch $file
fi

#追加的配置内容
addContent="LABEL="$name" none ntfs rw,auto,nobrowse"

if [ `grep -c "$addContent" $file` -ne '0' ]; then
    exit
fi

#原有权限-rw-r--r--，也就是644
sudo chmod 777 /etc/fstab
echo $addContent >> /etc/fstab

#创建快捷键
sudo ln -s /Volumes/$name ~/Desktop/$name

#最后还原权限
sudo chmod 644 /etc/fstab

#重启电脑
sudo reboot
