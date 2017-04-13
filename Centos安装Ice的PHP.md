# Centos安装Ice的PHP
本文档来自[陈志新](http://weibo.com/czhixin)，感谢陈志新。

<span style="color:#f00">在CentOS系统，以下过程在/opt目录下完成，/opt是Ice依赖和Ice默认目录，减少配置修改。</span>

## 安装
1. 编译安装第三方库（依赖）

* 编译安装Berkeley DB 5.3.28
```
wget http://zeroc.com/download/berkeley-db/db-5.3.28.NC.tar.gz
tar xzf db-5.3.28.NC.tar.gz
cd db-5.3.28.NC
wget http://zeroc.com/download/berkeley-db/berkeley-db.5.3.28.patch
patch -p0 < ./berkeley-db.5.3.28.patch
cd db-5.3.28.NC/build_unix
../dist/configure --enable-cxx --enable-java --prefix=/opt/db53  根据需要—enable=java可以不要，如果要支持java则需要
make && make install
cd /opt/db53
ln -s lib lib64
```

* 编译安装Ice的依赖库
```
git clone https://github.com/zeroc-ice/mcpp.git
cd mcpp
make && make install
cp lib64/libmcpp.a /usr/lib64
```

2. 编译安装Ice For cpp
```
wget http://github.com/zeroc-ice/ice/archive/v3.6.3.tar.gz
tar -xvf v3.6.3.tar.gz
cd ice-3.6.3/cpp
vi config/Make.rules.Linux
找到BASELIBS = -lIceUtil 在后台添加-liconv，修改后BASELIBS = -lIceUtil -liconv
make && make install
```

3. 编译安装Ice For php
```
回到/opt/ice-3.6.3
cd /opt/ice-3.6.3/php
修改config/Make.rules.php
cd config/Make.rules.php
LP64            := yes      注释去掉
USE_NAMESPACES          ?= yes           注释去掉
PHP_CONFIG      ?=  php-config对应位置
make && make install
在/opt/ice-3.6.3/php/lib下得到IcePHP.so
```

4. 将IcePHP.so放入PHP扩展目录，并修改php.ini（参考其他扩展的修改方式，过程通用），重启php服务器