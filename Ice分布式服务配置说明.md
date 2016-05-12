# Registry的主从配置说明
## Registry说明
* 服务器A，服务器B
* 服务器A上部署主Registry、node1
* 服务器B上部署从Registry

## 应用部署
应用代码app部署到服务器A上

## 配置说明
1. 服务器A上的主Registry配置上添加Ice.ProgramName=Master，将Ice.Default.Locator指向服务器B和本机
2. 服务器B上的从Registry配置上添加Ice.ProgramName=Replica1、IceGrid.Registry.ReplicaName=Replica1，将Ice.Default.Locator指向服务器A和本机
3. 服务器A的node1上Ice.Default.Locator指服务器A和服务器B
4. 在服务器A的应用代码app的grid上配置node1
5. 客户端的Ice.Default.Locator指服务器A和服务器B，或Glaciter2的Ice.Default.Locator指服务器A和服务器B

## 启动操作
1. 启动顺序先启动服务器A的Registry、node
2. 启动服务器B的Registry
3. 服务器A上通过管理端添加application
4. 启动客户端访问


# node的分布式配置说明
## node说明
* 服务器A，服务器B
* 服务器A上部署node1
* 服务器B上部署node2

## 应用部署
应用代码app部署到服务器A和服务器B上

## 配置说明
1. node1的Registry指向服务器A
2. node2的Registry指向服务器A
3. 在服务器A的应用代码app的grid上配置node1和node2

## 启动操作
1. 启动顺序先启动服务器A的Registry、node
2. 启动服务器B的node
3. 服务器A上通过管理端添加application
4. 启动客户端访问


# IceGlacier2多服务器部署
## 说明
* 服务器A，服务器B
* 服务器A上部署主Registry、Glacier2_1
* 服务器B上部署从Registry、Glacier2_2

## 证书说明注意
* 生成证书时不指定server的ip，只指定域名
* 所有的部署Glacier2都使用一样的证书

## 配置说明
* Glacier2_1的Ice.Default.Locator指服务器A和服务器B
* Glacier2_1的配置证书，所有的部署Glacier2都使用一样的证书
* Glacier2_2的Ice.Default.Locator指服务器A和服务器B
* Glacier2_2的配置证书，所有的部署Glacier2都使用一样的证书
* 客户端的Glacier2指服务器A和服务器B的Glacier2

## 作用
配置多个Glacier2主要起到分流作用。


# IcePatch2和IceGrid集成
## 说明
* 服务器A，服务器B
* 服务器A上部署Registry、node1，创建node_patch2/data、patch2/server、patch2/client
* 服务器B上部署node2，创建node_patch2/data、patch2/client

## 配置说明
* IceGrid的配置

		<server-template id="IcePatch2ServerTemplate">
			<parameter name="instance-name" default="${application}.IcePatch2"/>
			<parameter name="endpoints" default="default"/>
			<parameter name="directory"/>
			<server id="${instance-name}.server" exe="icepatch2server" application-distrib="false" activation="on-demand">
				<adapter name="IcePatch2" endpoints="${endpoints}">
					<object identity="${instance-name}/server" type="::IcePatch2::FileServer"/>
				</adapter>
				<properties>
					<property name="IcePatch2.InstanceName" value="${instance-name}"/>
					<property name="IcePatch2.Directory" value="${directory}"/>
				</properties>
			</server>
		</server-template>
		<server-template id="IcePatch2ClientTemplate">
			<parameter name="instance-name" default="${application}.IcePatch2"/>
			<parameter name="directory"/>
			<parameter name="nodeName"/>
			<server id="${instance-name}.${nodeName}" exe="icepatch2client" application-distrib="false" activation="on-demand">
				<option>-t</option>
				<properties>
					<property name="IcePatch2.InstanceName" value="${instance-name}"/>
					<property name="IcePatch2Client.Directory" value="${directory}"/>
					<property name="IcePatch2Client.ChunkSize" value="10" />
					<property name="IcePatch2Client.Thorough" value="1" />
					<property name="IcePatch2Client.Remove" value="1" />          
					<property name="IcePatch2Client.Proxy" value="${instance-name}/server:tcp -h 10.175.206.101 -p 8000"/>
				</properties>
			</server>
		</server-template>
		<distrib/>
		<node name="node1">
			<server-instance template="IcePatch2ServerTemplate" directory="/home/Ice/patch2/server" endpoints="tcp -p 8000" />
			<server-instance template="IcePatch2ClientTemplate" directory="/home/Ice/patch2/client" nodeName="patch2Client_1" />
		</node>
		<node name="node2">
			<server-instance template="IcePatch2ClientTemplate" directory="/home/Ice/patch2/client" nodeName="patch2Client_2" />
		</node>

* node1的配置

		IceGrid.Node.Name=node1
		Ice.Default.Locator=IceGrid/Locator:tcp -p 4061
		IceGrid.Node.Data=/home/Ice/node_patch2/data
		Ice.StdErr=/home/Ice/node_patch2/node.stderr.log
		Ice.StdOut=/home/Ice/node_patch2/node.stdout.log
		IceGrid.Node.Endpoints=tcp -p 5061

* node2的配置

		IceGrid.Node.Name=node1
		Ice.Default.Locator=IceGrid/Locator:tcp -h 10.175.206.101 -p 4061
		IceGrid.Node.Data=/home/Ice/node_patch2/data
		Ice.StdErr=/home/Ice/node_patch2/node.stderr.log
		Ice.StdOut=/home/Ice/node_patch2/node.stdout.log
		IceGrid.Node.Endpoints=tcp -p 5061

## 启动操作
1. 先启动服务器A的Registry、node1
2. 再启动服务器B的node2
3. 将要部署的文件上传到服务器A的patch2/server里
4. 通过icepatch2calc在patch2/server生成校验码
5. 启动IcePatch2Server服务
6. 再启动IcePatch2Client服务，当IcePatch2Client停止后应该就可以在patch2/client上看到相应的文件