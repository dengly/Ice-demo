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

