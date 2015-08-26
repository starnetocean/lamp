# 简介 #

这是一个自动安装LAMP环境的脚本。


# 详情 #

<p>1、使用putty或类似的SSH工具登陆。</p>
<p>2、安装LAMP</p>

<p>运行一键安装包的脚本文件。</p>
```
cd /root #进入根目录
wget http://teddysun.googlecode.com/files/lamp2.2.tar.gz #下载2.2版
tar -zxvf lamp2.2.tar.gz #解压缩文件
cd /root/lamp2.2 #进入目录
chmod +x *.sh #赋予文件夹下所有文件执行权限
./lamp.sh 2>&1 | tee lamp.log #执行安装脚本```

<p>回车后出现如下界面：</p>
```
 Please input the root password of MySQL:（提示输入Mysql的root用户密码）
如果不输入直接回车，则设为默认密码：root
输入完成后，显示MySQL password:你输入的密码

Please input the mysql data location:
leave blank for /usr/local/mysql/data
（提示输入Mysql的data存放路径，如果不输入直接回车则存放在默认路径/usr/local/mysql/data）
直接回车或输入路径后显示mysql data location:默认路径或你输入的路径

Press any key to start...or Press Ctrl+c to cancel
（提示你输入任何键继续，或者按Ctrl+c取消安装）```

<p>如果你在之前的步骤输入了正确的选择，到了这一步你随便按下一个键，脚本就会自动完成剩下的事情了。整个安装过程根据机器配置不同，大约耗时40-60分钟。</p>

# 如何升级？ #
<p>新增了<code>update.sh</code>脚本，目的是为了自动检测和升级<code>PHP、phpMyAdmin</code>。这两种软件版本更新比较频繁，因此才会有此脚本，一劳永逸。<br>
安装完<code>lamp.sh</code>一段时间后，如果你发现<code>PHP</code>或<code>phpMyAdmin</code>官网已更新，那即可运行此脚本更新到最新版。</p>
```
./update.sh | tee update.log```