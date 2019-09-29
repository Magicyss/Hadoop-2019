# Hadoop-2019
大数据班学习Hadoop中的某些文的记录
***
由于前期安装Hadoop、JDK以及配置某些文件比较麻烦，所以手写了一个 [Hadoop.sh](https://github.com/Magicyss/Hadoop-2019/blob/master/Hadoop.sh) 脚本来方便自己的操作。  
脚本的使用命令是
```
wget -N --no-check-certificate https://raw.githubusercontent.com/Magicyss/Hadoop-2019/master/Hadoop.sh && chmod +x Hadoop.sh && . Hadoop.sh
```
接下来按照提示就可以完成安装了。
***
## 版本更新
***
V 1.1.1 Beta  
增加显示秘钥的功能，同时修复了之前因为两个防火墙操作放置在if语句中，导致第二条关闭自启的语句失效的问题。
***