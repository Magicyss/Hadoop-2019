#!/bin/bash
echo -e " NEU 2017级大数据班 前期Hadoop、JDK以及ssh免秘登录操作脚本
开发人员：Magicy
版本 V 1.0.0 Beta"
if ! wget -N --no-check-certificate ftp://172.16.29.252/Hadoop%C0%EB%CF%DF%BC%C6%CB%E3/%B5%DA1%BF%CE%20%B3%F5%CA%B6Hadoop/hadoop-2.7.7.tar.gz;
then echo -e "Hadoop文件下载失败" && exit 1
else
	echo -e "Hadoop文件下载完成!"
fi
if ! wget -N --no-check-certificate ftp://172.16.29.252/Hadoop%C0%EB%CF%DF%BC%C6%CB%E3/%B5%DA1%BF%CE%20%B3%F5%CA%B6Hadoop/jdk-8u151-linux-x64.tar.gz;
then echo -e "JDK文件下载失败" && exit 1
else
	echo -e "JDK文件下载完成!"
fi
echo "接下来将移除CentOS中自带的Open JDK"
JDK1=`rpm -qa | grep java | head -1`
if ! yum -y remove $JDK1
then echo -e "移除 $JDK1 失败" && exit 1
else
	echo -e "移除 $JDK1 完成!"
fi
JDK2=`rpm -qa | grep java | head -1`
if ! yum -y remove $JDK2
then echo -e "移除 $JDK2 失败" && exit 1
else
	echo -e "移除 $JDK2 完成!"
fi
echo "接下来安装老师要求的JDK"
if ! mkdir /usr/local/java
then echo -e "创建路径失败" && exit 1
else
	echo -e "创建路径完成!"
fi

if ! tar -C /usr/local/java/ -zxvf jdk-8u151-linux-x64.tar.gz
then echo -e "解压JDK失败" && exit 1
else
	echo -e "解压JDK完成!"
fi
echo "# set java environment">>/etc/profile
echo "export JAVA_HOME=/usr/local/java/jdk1.8.0_151">>/etc/profile
echo "export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar">>/etc/profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin">>/etc/profile
source /etc/profile #source *.sh才能生效此语句
echo -e "修改Path完成!"

echo "接下来安装老师要求的Hadoop"
if ! mkdir /hadoop
then echo -e "创建路径失败" && exit 1
else
	echo -e "创建路径完成!"
fi

if ! tar -C /hadoop/ -zxvf hadoop-2.7.7.tar.gz
then echo -e "解压Hadoop失败" && exit 1
else
	echo -e "解压Hadoop完成!"
fi
echo "接下来处理防火墙、hostname等"
if ! systemctl stop firewalld && ! systemctl disable firewalld
then echo -e "防火墙关闭失败" && exit 1
else
	echo -e "防火墙关闭完成!"
fi
if ! sed -i 's|SELINUX=enforcing|SELINUX=disabled|' /etc/sysconfig/selinux
then echo -e "关闭Selinux失败" && exit 1
else
	echo -e "关闭Selinux完成!"
fi
echo "请输入你需要修改的hostname:"
read hostname
if ! hostnamectl set-hostname $hostname
then echo -e "修改的hostname失败" && exit 1
else
	echo -e "修改的hostname完成!"
fi
echo "接下来将修改hosts文件"
echo "请输入你需要添加的第1个IP地址"
read ip1
echo "请输入你需要添加的第1个hostname:"
read hostname1

echo "请输入你需要添加的第2个IP地址"
read ip2
echo "请输入你需要添加的第2个hostname:"
read hostname2

echo "请输入你需要添加的第3个IP地址"
read ip3
echo "请输入你需要添加的第3个hostname:"
read hostname3
echo "$ip2 $hostname2">>/etc/hosts
echo "$ip2 $hostname2">>/etc/hosts
echo "$ip3 $hostname3">>/etc/hosts
echo -e "修改hosts完成!"
cd ~
echo "接下来设置ssh无密码登录"
if ! mkdir ~/.ssh
then echo -e "创建路径失败" 
else
	echo -e "创建路径完成!"
fi
if ! ssh-keygen -t rsa -N '' -f ./.ssh/id_rsa -q
then echo -e "生成秘钥失败" && exit 1
else
	echo -e "生成秘钥完成!"
fi
cd .ssh
if ! cat id_rsa.pub>> authorized_keys
then echo -e "authorized_keys生成失败" && exit 1
else
	echo -e "authorized_keys生成完成!"
fi
echo "接下来需要输入另外两台机器的秘钥"
echo "请输入你需要添加的第1个秘钥"
read key1
echo "请输入你需要添加的第2个秘钥"
read key2
echo $key1>> authorized_keys
echo $key2>> authorized_keys
echo "本程序运行完毕。"