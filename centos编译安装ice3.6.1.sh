#!/bin/bash
#
# 作者：邓燎燕
# 2016-01-05
# 
# 这个是在阿里云的Centos 6.5 64位的安装脚本
#

mkdir -p {downloads/ice,downloads/jdk}
scp root@10.168.125.178:/root/downloads/jdk/jdk-7u80-linux-x64.tar.gz /root/downloads/jdk/
scp root@10.168.125.178:/root/downloads/ice/bcprov-jdk15on-153.jar /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/berkeley-db53-5.3.28.NC.brew.tar.gz /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/bzip2-1.0.6.tar.gz /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/expat-2.1.0.tar.gz /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/icecertutils.zip /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/libiconv-1.14.tar.gz /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/mcpp-2.7.2.tar.gz /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/openssl-1.0.1g.tar.gz /root/downloads/ice/
scp root@10.168.125.178:/root/downloads/ice/ice-3.6.1.tar.gz /root/downloads/ice/

yum -y install unzip zip bzip2 bzip2-devel tar gcc g++ automake autoconf libtool make expat openssl openssl-devel libffi-devel libiconv python-devel mcpp

#cd /root/downloads/ice
#wget https://git.oschina.net/dengly/Ice-demo/raw/master/iceFiles/bcprov-jdk15on-153.rename
#mv bcprov-jdk15on-153.rename bcprov-jdk15on-153.jar

# 安装jdk
cd /root/downloads/jdk
#wget http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz
tar zxvf jdk-7u80-linux-x64.tar.gz
mv jdk1.7.0_80 /usr/local/jdk7
cp /root/downloads/ice/bcprov-jdk15on-153.jar /usr/local/jdk7/jre/lib/ext/
echo 'security.provider.x=org.bouncycastle.jce.provider.BouncyCastleProvider' >> /usr/local/jdk7/jre/lib/security/java.security
## 添加环境变量
echo 'JAVA_HOME=/usr/local/jdk7' >> /etc/profile
echo 'JRE_HOME=$JAVA_HOME/jre' >> /etc/profile
echo 'CLASSPATH=.:$JRE_HOME/lib/jsse.jar:$JRE_HOME/lib/jfxrt.jar:$JAVA_HOME/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib/ext/bcprov-jdk15on-153.jar:$JRE_HOME/lib' >> /etc/profile
echo 'PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >> /etc/profile
echo 'export JAVA_HOME JRE_HOME CLASSPATH PATH' >> /etc/profile
source /etc/profile


# 安装expat 2.0
cd /root/downloads/ice
#wget http://nchc.dl.sourceforge.net/project/expat/expat/2.1.0/expat-2.1.0.tar.gz
#wget https://raw.githubusercontent.com/dengly/Ice-demo/master/iceFiles/expat-2.1.0.tar.gz
#wget https://git.oschina.net/dengly/Ice-demo/raw/master/iceFiles/expat-2.1.0.tar.gz
tar zxvf expat-2.1.0.tar.gz
cd expat-2.1.0
./configure
make && make install
## 添加环境变量
echo 'LD_LIBRARY_PATH=/usr/local/lib' >> /etc/profile
echo 'LD_RUN_PATH=/usr/local/lib' >> /etc/profile


# 安装openssl
cd /root/downloads/ice
#wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz
#wget https://raw.githubusercontent.com/dengly/Ice-demo/master/iceFiles/openssl-1.0.1g.tar.gz
#wget https://git.oschina.net/dengly/Ice-demo/raw/master/iceFiles/openssl-1.0.1g.tar.gz
tar zxvf openssl-1.0.1g.tar.gz
cd openssl-1.0.1g
./config --prefix=/usr/local/openssl
make && make install


# 安装bzip2
cd /root/downloads/ice
#wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
#wget https://raw.githubusercontent.com/dengly/Ice-demo/master/iceFiles/bzip2-1.0.6.tar.gz
#wget https://git.oschina.net/dengly/Ice-demo/raw/master/iceFiles/bzip2-1.0.6.tar.gz
tar zxvf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
make && make install


# 安装mcpp
cd /root/downloads/ice
#wget http://jaist.dl.sourceforge.net/project/mcpp/mcpp/V.2.7.2/mcpp-2.7.2.tar.gz
#wget https://raw.githubusercontent.com/dengly/Ice-demo/master/iceFiles/mcpp-2.7.2.tar.gz
#wget https://git.oschina.net/dengly/Ice-demo/raw/master/iceFiles/mcpp-2.7.2.tar.gz
tar zxvf mcpp-2.7.2.tar.gz
cd mcpp-2.7.2
./configure CFLAGS=-fPIC --enable-mcpplib --disable-shared 
make && make install


# 安装Berkeley DB
cd /root/downloads/ice
#wget http://download.oracle.com/otn/berkeley-db/db-5.3.28.tar.gz
#wget https://raw.githubusercontent.com/dengly/Ice-demo/master/iceFiles/berkeley-db53-5.3.28.NC.brew.tar.gz
#wget https://git.oschina.net/dengly/Ice-demo/raw/master/iceFiles/berkeley-db53-5.3.28.NC.brew.tar.gz
tar zxvf berkeley-db53-5.3.28.NC.brew.tar.gz
cd db-5.3.28.NC/build_unix/
../dist/configure --prefix=/usr/local/berkeleydb --enable-cxx --enable-java
make && make install
cp -rf /usr/local/berkeleydb/lib /usr/local/berkeleydb/lib64
#echo '/usr/local/berkeleydb/lib/' >> /etc/ld.so.conf
#ldconfig
#cd ../..
## 添加环境变量
echo 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/berkeleydb:/usr/lib64' >> /etc/profile
echo 'LD_RUN_PATH=$LD_RUN_PATH:/usr/local/berkeleydb/bin' >> /etc/profile
echo 'CLASSPATH=$CLASSPATH:/usr/local/berkeleydb/lib64/db.jar' >> /etc/profile
echo 'export LD_LIBRARY_PATH LD_RUN_PATH CLASSPATH' >> /etc/profile
source /etc/profile

ldconfig

# 安装ice
#编译c++
cd /root/downloads/ice
#wget https://github.com/zeroc-ice/ice/archive/ice-3.6.1.tar.gz
#wget https://raw.githubusercontent.com/dengly/Ice-demo/master/iceFiles/ice-3.6.1.tar.gz
#wget https://git.oschina.net/dengly/Ice-demo/raw/master/iceFiles/ice-3.6.1.tar.gz
tar zxvf ice-3.6.1.tar.gz
cd ice-3.6.1/cpp
make
make install
#编译java
cd ../java
echo 'ICE_HOME=/usr/local/Ice-3.6.1' >> /etc/profile
echo 'PATH=$PATH:$ICE_HOME/bin' >> /etc/profile
echo 'export PATH ICE_HOME' >> /etc/profile
source /etc/profile
./gradlew build
./gradlew install
echo 'CLASSPATH=$CLASSPATH:/usr/local/Ice-3.6.1/share/java/' >> /etc/profile
echo 'export CLASSPATH' >> /etc/profile
source /etc/profile


# 安装iceca
cd /root/downloads/ice
wget https://bootstrap.pypa.io/ez_setup.py -O - | python
easy_install pycrypto
easy_install zeroc-icecertutils
#将bcprov-jdk15on-153.jar复制到/usr/local/jdk7/jre/lib/ext下
#配置环境变量ICE_CA_HOME
mkdir -p /home/Ice/ca
echo 'ICE_CA_HOME=/home/Ice/ca' >> /etc/ld.so.conf
echo 'export ICE_CA_HOME' >> /etc/profile
source /etc/profile


