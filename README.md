# Ice
尊重作者研究，转载请注明出处。

========

创建时间 | 2015-12-28 | |
--- | --- | ---
创建人 | 邓燎燕
版本号 | 1.0
修改时间 | 修改人 | 修改内容

###### 说明
* 本文的所有研究是基于[Ice 3.6.1](https://github.com/zeroc-ice/ice/tree/3.6.1)
* iOS端的开发依赖包[icetouch](https://github.com/zeroc-ice/icetouch)
* 在Ice 3.6.1里不再有iceca这个证书生成工具，已经迁移到[icecertutils](https://github.com/zeroc-ice/icecertutils)
* 服务器：CentOS 6.5 64位
* JDK：[jdk1.7.0_79](http://download.oracle.com/otn/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz)
* 个人的例子是参考[《ZeroC Ice权威指南》](http://item.jd.com/10026458225.html)和[ice-demo](https://github.com/zeroc-ice/ice-demos)

========

# 编译安装
## c++的编译安装请参考ice/cpp/BuildInstructionsLinux.md
依赖的第三方库有expat 2.0、OpenSSL 0.9.8 or later、bzip 1.0、Berkeley DB 5.3、mcpp 2.7.2 (with patches)，建议能收到编译安装的就收到编译安装，尽量不要使用yum这类工具，免得有奇葩的错误。这个我在CentOS和Mac OS X都安装了。

## Java的编译安装请参考ice/java/BuildInstructions.md
在CentOS上安装，我是没有成功过，但是在Mac OS X上成功了，所有我就直接将Mac OS X上编译好的jar包都上传到CentOS上了。

## Objective-C的编译安装请参考ice/objective-c/BuildInstructions.md

## JS库
Ice的js库可以到该连接下载[http://cdnjs.com/libraries/ice](#http://cdnjs.com/libraries/ice)

========

# 案例
## IceGrid+IceBox+Spring
我参考了[《ZeroC Ice权威指南》](http://item.jd.com/10026458225.html)中的第6章在线订票系统写了例子。
## IceGrid+Glacier2使用SSL和WSS通讯
我参考了[ice-demo](https://github.com/zeroc-ice/ice-demos)编写了客户端的代码。但是在使用SSL和WSS通讯时要生成相关证书，证书的生成请参考mymakecert.sh。

## 请求说明
客户端（Android和iOS）通过SSL和WSS向Glacier2发送请求，Glacier2在通过TCP向IceGrid获取相关结果后返回给客户端。

到目前为止，经测试纯Java客户端、Android、iOS使用加密或非加密都成功，而提供的网页前端使用WS成功，使用WSS没能成功，希望有人能完善或提供网页前端使用WSS的说明。

## 部署
* 路径/home/Ice
* 创建Ice_gridregistry、Ice_gridnode、registry、node、node/data、Ice_glacier2、grid、logs、Ice_glacier2/sslstore
* 将生成的证书放在Ice_glacier2/sslstore下
* 将IceGrid配置写入Ice_gridregistry/icegridregistry.cfg
* 将IceNode配置写入Ice_gridnode/icegridnode1.cfg
* 将Glacier2配置写入Ice_glacier2/iceglacier2.cfg
* 将iceTicketProject应用的服务端放在/home/Ice下
* 运行IceApp.sh脚本
* 在运行IceAdmin.sh加载应用的ticketgrid.xml配置文件，启动服务

========

# 附件
## mymakecert.sh
	#!/bin/bash
	#
	# 作者：邓燎燕
	# 2015-12-25
	# 
	# 要配置好iceca的ICE_CA_HOME环境变量
	# 我的ca、server和client密码都是123456

	echo "------------ iceca init --------------"
	iceca init

	echo "------------ iceca create server and client --------------"
	iceca create --ip=192.168.0.112 --dns=192.168.0.112 server

	iceca create client

	echo "------------ iceca export cert --------------"
	iceca export --password 123456 --alias ca ./ca/ca.cer
	iceca export --password 123456 --alias client ./ca/client.cer
	iceca export --password 123456 --alias server ./ca/server.cer

	echo "------------ iceca export jks --------------"
	iceca export --password 123456 --alias ca ./ca/ca.jks
	iceca export --password 123456 --alias client ./ca/client.jks
	iceca export --password 123456 --alias server ./ca/server.jks

	echo "------------ iceca export bks --------------"
	iceca export --password 123456 --alias ca ./ca/ca.bks
	iceca export --password 123456 --alias client ./ca/client.bks
	iceca export --password 123456 --alias server ./ca/server.bks

	echo "------------ iceca export p12 --------------"
	iceca export --password 123456 --alias ca ./ca/ca.p12
	iceca export --password 123456 --alias client ./ca/client.p12
	iceca export --password 123456 --alias server ./ca/server.p12

	echo "------------ keytool -import --------------"
	keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/server.jks
	keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/client.jks

	keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/server.bks -storetype bks -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar
	keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/client.bks -storetype bks -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar

	echo "--------------------------"
	keytool -list -keystore ./ca/ca.p12 -storetype pkcs12 -v -storepass 123456
	echo "--------------------------"
	keytool -list -keystore ./ca/ca.jks -storepass 123456 -v
	echo "--------------------------"
	keytool -list -keystore ./ca/ca.bks -storetype bks -storepass 123456 -v -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar
	echo "--------------------------"
	keytool -list -keystore ./ca/server.p12 -storetype pkcs12 -v -storepass 123456
	echo "--------------------------"
	keytool -list -keystore ./ca/server.jks -storepass 123456 -v
	echo "--------------------------"
	keytool -list -keystore ./ca/server.bks -storetype bks -storepass 123456 -v -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar
	echo "--------------------------"
	keytool -list -keystore ./ca/client.p12 -storetype pkcs12 -v -storepass 123456
	echo "--------------------------"
	keytool -list -keystore ./ca/client.jks -storepass 123456 -v
	echo "--------------------------"
	keytool -list -keystore ./ca/client.bks -storepass 123456 -v -storetype bks -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar

	echo ""
	echo ""
	echo "--------------------------"
	echo "配置说明"
	echo "Glacier2的配置IceSSL.CAs=ca.pem，IceSSL.CertFile=server.p12"
	echo "纯Java客户端使用client.jks"
	echo "Android客户端使用client.bks"
	echo "iOS客户端使用ca.cer和client.p12，配置IceSSL.CAs=ca.cer，IceSSL.CertFile=client.p12"
	echo ""

## Glacier2配置
	#
	# Set the instance name
	#
	Glacier2.InstanceName=DemoGlacier2

	#
	# The client-visible endpoint of Glacier2. This should be an endpoint
	# visible from the public Internet, and it should be secure.
	#
	Glacier2.Client.Endpoints=wss -p 4064:ssl -p 4063

	# IceGrid+Glacier2的关键
	Ice.Default.Locator=IceGrid/Locator:tcp -h localhost -p 4061	
	Glacier2.Server.Endpoints=tcp -h localhost
	Glacier2.PermissionsVerifier=DemoGlacier2/NullPermissionsVerifier
	Glacier2.SessionTimeout=30
	Glacier2.Client.ForwardContext=1
	Glacier2.Server.ForwardContext=1
	Glacier2.Client.SleepTime=500
	Glacier2.Server.SleepTime=500
	Glacier2.Client.Trace.Request=1
	Glacier2.Server.Trace.Request=1
	Glacier2.Client.Trace.Override=1
	Glacier2.Server.Trace.Override=1
	Glacier2.Client.Trace.Reject=1
	Glacier2.Trace.Session=1
	Glacier2.Trace.RoutingTable=1
	Ice.Warn.Connections=1
	Ice.Trace.Network=1
	Ice.Trace.Protocol=1
	IceSSL.Trace.Security=1

	#
	# SSL Configuration
	#
	Ice.Plugin.IceSSL=IceSSL:createIceSSL
	IceSSL.Protocols=SSL3, TLS1_0, TLS1_1, TLS1_2
	IceSSL.DefaultDir=/home/Ice/Ice_glacier2/sslstore
	IceSSL.CAs=ca.pem
	IceSSL.CertFile=server.p12
	IceSSL.Password=123456
	IceSSL.Keychain=glacier2.keychain
	IceSSL.KeychainPassword=123456

## IceGrid配置
	IceGrid.Registry.Client.Endpoints=tcp -p 4061:ws -p 4062
	IceGrid.Registry.Server.Endpoints=tcp
	IceGrid.Registry.Internal.Endpoints=tcp
	IceGrid.Registry.AdminPermissionsVerifier=IceGrid/NullPermissionsVerifier
	IceGrid.Registry.Data=./registry
	IceGrid.Registry.DynamicRegistration=1
	Ice.Admin.InstanceName=AdminInstance
	Ice.Admin.ServerId=Admin

## IceNode配置
	#ice node config for ticketnode1
	#指定主注册节点的位置
	Ice.Default.Locator=IceGrid/Locator:tcp -h 127.0.0.1 -p 4061:ws -h 127.0.0.1 -p 4062
	#设置节点1相关数据的存储目录
	IceGrid.Node.Data=/home/Ice/node/data
	#指定节点1用于监听客户端连接的端口
	IceGrid.Node.Endpoints=tcp -p 5062
	#指定节点1的名称
	IceGrid.Node.Name=node1
	#指定错误日志文件
	Ice.StdErr=/home/Ice/node/node.stderr.log
	Ice.StdOut=/home/Ice/node/node.stdout.log

## 应用的服务端配置
	<?xml version="1.0" encoding="UTF-8"?>
	<icegrid>
        <application name="MyTicketBookSystem">
            <properties id="MultiThreaded">
                <property name="Ice.PrintStackTraces" value="1" />
                <property name="Ice.ThreadPool.Client.Size" value="2" />
                <property name="Ice.ThreadPool.Client.SizeMax" value="50" />
                <property name="Ice.ThreadPool.Server.Size" value="10" />
                <property name="Ice.ThreadPool.Server.SizeMax" value="100" />
                <property name="IceBox.InheritProperties" value="1" />
                <property name="Ice.Override.ConnectTimeout" value="5000" />
                <property name="Ice.Override.Timeout" value="10000" />
                <property name="IceBox.Trace.ServiceObserver" value="1" />
                <property name="Ice.Default.LocatorCacheTimeout" value="300" />
                <property name="Ice.BackgroundLocatorCacheUpdates" value="1" />

                <property name="Ice.Trace.Retry" value="2" />
                <property name="Ice.Trace.Network" value="1" />
                <property name="Ice.Trace.ThreadPool" value="1" />
                <property name="Ice.Trace.Locator" value="1" />
                <property name="Ice.StdErr" value="/home/Ice/grid/stderr.log" />
                <property name="Ice.StdOut" value="/home/Ice/grid/stdout.log" />
            </properties>
            <server-template id="TicketOrderServerTemplate"><!-- 定义服务器模板 -->
                <parameter name="id" />
                <icebox id="TicketOrderServer${id}" exe="java" activation="on-demand">
                    <properties>
                        <properties refid="MultiThreaded" />
                    </properties>
                    <option>-Xmx512M</option>
                    <option>-DAppHome=/home/Ice</option>
                    <option>-DAppId=TicketOrderServer${id}</option>
                    <!-- 指定启动类，使用Sl4jIceBoxServer替代IceBox.Server作为IceBox的启动类 -->
                    <option>com.zzwtec.iceTicketProject.ice.Sl4jIceBoxServer</option>
                    <env>CLASSPATH=.:/opt/Ice-3.6.1/lib/*:/home/libs/*:/home/Ice/iceTicketProject</env>
                    <service name="TicketService" entry="com.zzwtec.iceTicketProject.ice.service.MyTicketService">
                        <adapter name="TicketService" id="TicketService${id}" endpoints="tcp:ws" replica-group="TicketServiceRep"></adapter>
                    </service>
                </icebox>
            </server-template>
            <replica-group id="TicketServiceRep"><!-- 定义适配器复制组 -->
                <load-balancing type="round-robin" n-replicas="0" />
                <object identity="TicketService" type="::ticket::TicketService" /><!-- identity将在客户 -->
            </replica-group>
            <node name="node1">
                <server-instance template="TicketOrderServerTemplate" id="1" />
                <server-instance template="TicketOrderServerTemplate" id="2" />
            </node>
        </application>
	</icegrid>

## 纯Java客户端配置
	Ice.Default.Router=DemoGlacier2/router:ssl -p 4063 -h 192.168.0.112 -t 10000:wss -p 4064 -h 192.168.0.112 -t 10000
	Ice.RetryIntervals=-1
	Ice.Trace.Network=0
	Ice.Plugin.IceSSL=IceSSL.PluginFactory
	IceSSL.DefaultDir=/certs/path
	IceSSL.VerifyPeer=0
	IceSSL.Trace.Security=1
	IceSSL.KeystoreType=JKS
	IceSSL.Keystore=client.jks
	IceSSL.Password=123456

## Android客户端配置
	Ice.Default.Router=DemoGlacier2/router:ssl -p 4063 -h 192.168.0.112 -t 10000:wss -p 4064 -h 192.168.0.112 -t 10000
	Ice.RetryIntervals=-1
	Ice.Trace.Network=0
	Ice.Plugin.IceSSL=IceSSL.PluginFactory
	Ice.InitPlugins=0
	IceSSL.VerifyPeer=0
	IceSSL.Trace.Security=1
	IceSSL.KeystoreType=BKS
	IceSSL.Password=123456
	IceSSL.UsePlatformCAs=0

## iOS客户端配置
	Ice.Default.Router=DemoGlacier2/router:ssl -p 4063 -h 192.168.0.112 -t 10000:wss -p 4064 -h 192.168.0.112 -t 10000
	Ice.Trace.Locator=1
	Ice.ACM.Client.Timeout=0
	Ice.RetryIntervals=-1
	Ice.Plugin.IceSSL=IceSSL:createIceSSL
	IceSSL.DefaultDir=./
	IceSSL.CAs=ca.cer
	IceSSL.CertFile=client.p12
	IceSSL.Password=123456
	#IceSSL.Keychain=client.keychain
	#IceSSL.KeychainPassword=123456
