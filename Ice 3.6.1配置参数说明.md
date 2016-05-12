如果翻译有误请指出
#[Ice 3.6.1配置参数说明](https://doc.zeroc.com/display/Ice36/Property+Reference)

---

# <span id="目录">目录</span>
* [Ice](#Ice)
* [Freeze](#Freeze)
* [Glacier2](#Glacier2)
* [Ice.ACM](#Ice.ACM)
* [Ice.Admin](#Ice.Admin)
* [Ice.Default](#Ice.Default)
* [Ice.InitPlugins](#Ice.InitPlugins)
* [Ice.IPv4](#Ice.IPv4)
* [Ice.IPv6](#Ice.IPv6)
* [Ice.Override](#Ice.Override)
* [Ice.Plugin](#Ice.Plugin)
* [Ice.PluginLoadOrder](#Ice.PluginLoadOrder)
* [Ice.PreferIPv6Address](#Ice.PreferIPv6Address)
* [Ice.TCP](#Ice.TCP)
* [Ice.ThreadPool](#Ice.ThreadPool)
* [Ice.Trace](#Ice.Trace)
* [Ice.UDP](#Ice.UDP)
* [Ice.Warn](#Ice.Warn)
* [IceBox](#IceBox)
* [IceBoxAdmin](#IceBoxAdmin)
* [IceDiscovery](#IceDiscovery)
* [IceGrid](#IceGrid)
* [IceGridAdmin](#IceGridAdmin)
* [IceLocatorDiscovery](#IceLocatorDiscovery)
* [IceMX.Metrics](#IceMX.Metrics)
* [IcePatch2](#IcePatch2)
* [IcePatch2Client](#IcePatch2Client)
* [IceSSL](#IceSSL)
* [IceStorm Properties](#IceStorm Properties)
* [IceStormAdmin](#IceStormAdmin)

---
[返回目录](#目录)
## <span id="Ice">Ice</span>
###### <span id="Ice.BackgroundLocatorCacheUpdates">Ice.BackgroundLocatorCacheUpdates</span>，格式：
	Ice.BackgroundLocatorCacheUpdates=num
如果设置是0（默认），一种间接代理的调用，其端点比配置的定位器缓存超时触发一个定位器缓存更新；运行时间延迟了调用，直到新的端点返回到定位器。
如果设置大于0，在与过期端点的间接代理调用时，仍会触发一个定位器缓存更新，但在后台执行更新，并且运行时间使用过期的终结点进行调用。这样就避免了在缓存条目过期之后的第一次调用的延迟。

###### <span id="Ice.BatchAutoFlushSize">Ice.BatchAutoFlushSize</span>，格式：
	Ice.BatchAutoFlushSize=num
此属性控制如何在Ice运行时间处理批处理消息的冲洗。如果num大于0，当新信息添加到批处理和信息会导致批量超过num千字节时，运行时自动强制刷新当前批处理。如果num设置为0或负数，批次必须按应用程序显式刷新。默认是1024。
当刷新，批处理请求被发送为一个单一的Ice信息。接收器中的Ice运行时间限制到[Ice.MessageSizeMax](#Ice.MessageSizeMax)指定的传入消息的最大大小。因此，发送者必须定期冲洗批处理请求（无论是手动或自动），以确保他们不超过接收器的配置限制。

###### <span id="Ice.CacheMessageBuffers">Ice.CacheMessageBuffers</span>，格式：
	Ice.CacheMessageBuffers=num (Java, .NET)
如果num大于0，Ice运行时缓存消息缓冲区，用于将来重用。这可以提高性能和降低Ice的内部垃圾收集器去回收垃圾所花时间。然而，对于交换非常大的消息的应用程序，这个高速缓存可能消耗过多的内存，因此应该被禁用，通过设置此属性为零。
此属性影响缓存同步调用消息缓冲区。ICE运行时不会缓存异步调用消息缓冲区。
###### 平台提醒
###### Java
当设置为1，Ice分配非直接消息缓存；设置为2，Ice分配直接消息缓存。使用直接消息缓冲区可以最大限度地减少复制，通常会导致提高吞吐量的结果。默认是2。
###### .NET
默认是1。

###### <span id="Ice.ChangeUser">Ice.ChangeUser</span>，格式：
	Ice.ChangeUser=user (C++ & Unix only)
如果设置，Ice将用户和组id更改为相应的在/etc/passwd里user的身份。这只有当超级用户执行的Ice应用程序才有效。

###### <span id="Ice.CollectObjects">Ice.CollectObjects</span>，格式：
	Ice.CollectObjects=num (C++)
Ice的C++包括回收片类的实例，恢复由Ice运行时间循环图的垃圾收集设施。将此属性设置为1个导致Ice运行时间来假设一个程序接收的所有循环对象图都有资格获得默认的集合。默认是0。

###### <span id="Ice.Compression.Level">Ice.Compression.Level</span>，格式：
	Ice.Compression.Level=num
指定用于压缩协议消息的bzip2压缩级别。合法值是1到9，其中1个代表最快的压缩和9个代表最好的压缩。值得注意的是，高水平导致bzip2算法投入更多的资源来压缩的努力，可能不会导致较低水平的显著提高。默认是1。

###### <span id="Ice.ConsoleListener">Ice.ConsoleListener</span>，格式：
	Ice.ConsoleListener=num (.NET)
如果num非0，Ice运行时安装一个ConsoleTraceListener写信息到stderr。如果num是0，日志禁用。设置[Ice.LogFile](#Ice.LogFile)可重写该属性：如果[Ice.LogFile](#Ice.LogFile)设置，消息被写到日志文件中，不理会[Ice.ConsoleListener](#Ice.ConsoleListener)设置。

###### <span id="Ice.EventLog.Source">Ice.EventLog.Source</span>，格式：
	Ice.EventLog.Source=name (C++ & Windows only)
指定一个事件日志源的名称，该名称是Ice::Service的子类将被用于Windows服务。该name相当于在Eventlog的subkey注册一个key。应用程序（或管理员）通常在安装服务时准备注册表项。如果没有找到匹配的注册key，则Windows在应用日志中记录事件。在名称的任何反斜杠默转化为正斜杠。如果没有定义，Ice::Service通过--service选项指定使用服务名称。

###### <span id="Ice.HTTPProxyHost">Ice.HTTPProxyHost</span>，格式：
	Ice.HTTPProxyHost=addr
指定HTTP代理服务端的主机名或IP地址。如果addr非空，Ice为所有的输出（客户端）连接使用指定的HTTP代理服务端。

###### <span id="Ice.HTTPProxyPort">Ice.HTTPProxyPort</span>，格式：
	Ice.HTTPProxyPort=num
指定HTTP代理服务端的端口。默认是1080。

###### <span id="Ice.ImplicitContext">Ice.ImplicitContext</span>，格式：
	Ice.ImplicitContext=type
指定一个通信者是否有一个隐含的请求上下文，如果是这样的话，在什么范围内适用。合法值：None（相当于空字符串）、PerThread和Shared。默认值是None。

###### <span id="Ice.LogFile">Ice.LogFile</span>，格式：
	Ice.LogFile=file
一个基于记录仪实现简单的文件取代了通信器的默认日志。这个属性不影响每个进程记录器。记录器创建指定的文件，如果有必要，否则添加文件。如果记录器无法打开文件，在通信器初始化中应用程序收到一个InitializationException。如果在通信器初始化中为一个记录器对象提供InitializationData参数，它比这个属性优先。日志器不提供日志文件维护任何内置的支持（如日志旋转），但它可以和系统工具如logrotate并存。

###### <span id="Ice.LogStdErr.Convert">Ice.LogStdErr.Convert</span>，格式：
	Ice.LogStdErr.Convert=num (C++)
如果num大于0，在Windows上，通信器的默认日志器将日志消息从应用的窄字符串编码（定义所安装的窄字符串转换器，如果有的话）的Windows控制台代码页。如果[Ice.StdErr](#Ice.StdErr)没有设置，默认是1，否则是0。这个属性是由第一个在一个过程中创建的通信程序读取的，它被其他的通信者忽略了。

###### <span id="Ice.MessageSizeMax">Ice.MessageSizeMax</span>，格式：
	Ice.MessageSizeMax=num
该属性控制的最大大小（KB）无压缩协议的消息是由Ice运行时间接受。大小包括冰协议头的大小。默认是1024。此属性的唯一目的是为了防止恶意或有缺陷的发件人从触发一个大容量的内存分配的接收器。如果这不是一个值得关注的问题，你可以设置[Ice.MessageSizeMax](#Ice.MessageSizeMax)为0；截至Ice3.6，设置此属性为零（或负数）禁用消息大小限制。
如果在接收Ice运行时遇到的传入消息的大小超过[Ice.MessageSizeMax](#Ice.MessageSizeMax)接收机的设置，运行时间报出了一个MemoryLimitException和关闭连接。如，当客户端收到一个超大的回复信息，其结果是一个MemoryLimitException调用。当一个服务端接收到一个超大的请求消息时，客户端接收到一个ConnectionLostException（因为服务端关闭连接）并且如果[Ice.Warn.Connections](#Ice.Warn.Connections)设置服务端会记录一条消息。

###### <span id="Ice.Nohup">Ice.Nohup</span>，格式：
	Ice.Nohup=num
如果num大于0，应用程序方便类（以及在C++的Ice::Service类）在Unix 忽略SIGHUP和在Windows忽略CTRL_LOGOFF_EVENT。作为结果，如果用户开始申请注销，这套使用Ice.Nohup应用继续运行。应用程序的默认值为0，Ice::Service默认是1。

###### <span id="Ice.NullHandleAbort">Ice.NullHandleAbort</span>，格式：
	Ice.NullHandleAbort=num
如果num大于0，调用操作使用一个空的智能指针导致程序终止，而不是报IceUtil::NullHandleException。

###### <span id="Ice.Package.module">Ice.Package.module</span>，格式：
	Ice.Package.module=package (Java)
Ice为Java允许自定义生成的代码的包装。如果您使用此功能，Ice运行时需要额外的配置成功解包异常和混合类。此属性将一个顶层的切片模块与一个Java的package关联。如果所有的顶层模块生成相同的用户定义的包，这比[Ice.Default.Package](#Ice.Default.Package)更容易使用。

###### <span id="Ice.PrintAdapterReady">Ice.PrintAdapterReady</span>，格式：
	Ice.PrintAdapterReady=num
如果num大于0，一个对象适配器在激活完成后在标准输出打印“adapter_name ready”。这是非常有用的脚本，需要等待，直到一个对象适配器是准备使用。

###### <span id="Ice.PrintProcessId">Ice.PrintProcessId</span>，格式：
	Ice.PrintProcessId=num
如果num大于0，在启动时，在标准输出上打印处理标识。

###### <span id="Ice.PrintStackTraces">Ice.PrintStackTraces</span>，格式：
	Ice.PrintStackTraces=num (JavaScript, C++)
如果num大于0，插入一个来自IceUtil::Exception的异常在记录器的辅助类（如Ice::Warning）也显示出异常的堆栈跟踪。同样的，在基础异常类的ice_stackTrace方法，IceUtil::Exception，将返回堆栈或空字符串取决于num的值。如果没有设置，默认值取决于如何编译的Ice运行时间：0对于一个优化的构建和1对于调试版本。堆栈跟踪是当前不可用在Ice的C++和Python在Linux/ARM，不管这个属性的值。
在Windows上，堆栈跟踪，可在调试版本和发布版本建立的环境变量RELEASEPDBS=yes。发布的DLL纳入标准Ice二进制分配是建立在这个设置启用。.PDB文件用于调试和发布分发版本在一个单独的Ice PDB Windows安装程序。
当生产一个堆栈，Windows在定位存储中关联DLLs尝试定位.PDB文件；如果.PDB文件在这个定位存储找不到，Windows会使用搜索一下路径尝试定位这个文件，当前工作目录路径，然后是IceUtil DLL路径，最后是_NT_SYMBOL_PATH环境变量指定的路径。因此，如果.PDB文件不是你创建的，你需要拷贝他们放在IceUtil DLL之后或在_NT_SYMBOL_PATH环境变量的里添加它们所在目录的路径。
该属性只支持JavaScript、C++和使用C++运行时的脚本语言（Python, Ruby, PHP）。注意，此属性使Python，Ruby和PHP将只显示的C/C + +的堆栈跟踪。

###### <span id="Ice.ProgramName">Ice.ProgramName</span>，格式：
	Ice.ProgramName=name
name是程序的名称，在初始化是，从argv[0] (C++)和AppDomain.CurrentDomain.FriendlyName (.NET) 自动设置的。对于Java，Ice.ProgramName初始化为空字符串。默认的名称可以通过设置这个属性重写。

###### <span id="Ice.RetryIntervals">Ice.RetryIntervals</span>，格式：
	Ice.RetryIntervals=num [num ...]
这个属性定义操作次数自动重试和彼此之间的延迟重试。例如，如果该属性设置为0 100 500，操作重试3次：第一次失败后立即重试，在第二次失败后等待100ms再试，在第三次失败后等待500ms再试。默认值（0）意味着Ice立即重试一次。如果设置为-1，不重试。

###### <span id="Ice.ServerIdleTime">Ice.ServerIdleTime</span>，格式：
	Ice.ServerIdleTime=num
如果num大于0，通信器已闲置num秒，Ice自动调用Communicator::shutdown一次。这种关闭通讯的服务端，导致所有线程等待Communicator::waitForShutdown返回。在那之后，一个服务端通常在退出前做一些清理工作。默认是0，即服务端不会自动关闭。此属性通常用于服务器通过IceGrid自动激活。

###### <span id="Ice.SOCKSProxyHost">Ice.SOCKSProxyHost</span>，格式：
	Ice.SOCKSProxyHost=addr
为SOCKS代理服务端指定主机名和IP地址。如果addr不为空，Ice为所有的输出连接（客户端）使用指定的SOCKS代理服务端。
Ice当前只支持SOCKS4协议，即只运行IPv4连接。

###### <span id="Ice.SOCKSProxyPort">Ice.SOCKSProxyPort</span>，格式：
	Ice.SOCKSProxyPort=num
SOCKS代理服务端的端口。默认是1080。

###### <span id="Ice.StdErr">Ice.StdErr</span>，格式：
	Ice.StdErr=filename
如果filename不为空，程序的标准错误流指向该文件，用追加放送。此属性仅检查在进程中创建的第一个通信。

###### <span id="Ice.StdOut">Ice.StdOut</span>，格式：
	Ice.StdOut=filename
如果filename不为空，程序的标准输出流指向该文件，用追加放送。此属性仅检查在进程中创建的第一个通信。

###### <span id="Ice.SyslogFacility">Ice.SyslogFacility</span>，格式：
	Ice.SyslogFacility=string (Unix only)
这个属性设置syslog的特色为string。如果[Ice.UseSyslog](#Ice.UseSyslog)没有设置该属性没有效。
string可以设置syslog的特色为LOG_AUTH, LOG_AUTHPRIV, LOG_CRON, LOG_DAEMON, LOG_FTP, LOG_KERN, LOG_LOCAL0, LOG_LOCAL1, LOG_LOCAL2, LOG_LOCAL3, LOG_LOCAL4, LOG_LOCAL5, LOG_LOCAL6, LOG_LOCAL7, LOG_LPR, LOG_MAIL, LOG_NEWS, LOG_SYSLOG, LOG_USER, LOG_UUCP。
默认是LOG_USER。

###### <span id="Ice.ThreadInterruptSafe">Ice.ThreadInterruptSafe</span>，格式：
	Ice.ThreadInterruptSafe=num (Java)
如果num大于0，Ice的Java禁用消息缓存通过[Ice.CacheMessageBuffers](#Ice.CacheMessageBuffers)设置为0，并采取必要的措施，以确保正确的Java中断工作。默认值为零。

###### <span id="Ice.UseSyslog">Ice.UseSyslog</span>，格式：
	Ice.UseSyslog=num (Unix only)
如果num大于0，一个特殊的记录器安装，而不是标准错误日志syslog服务。syslog标识符是[Ice.ProgramName](#Ice.ProgramName)。使用[Ice.SyslogFacility](#Ice.SyslogFacility)选择syslog特色。

###### <span id="Ice.Voip">Ice.Voip</span>，格式：
	Ice.Voip=num (Ice Touch only)
如果num大于0，Ice运行时为所有通过Ice交流器创建的套接字设置kCFStreamNetworkServiceType属性为kCFStreamNetworkServiceTypeVoIP。允许使用此设置的语音应用程序的语音。它保证了套接字不会关闭，当应用程序处于后台时，可以接收数据。有关此设置的信息来自VoIP使用时配置套接字说明，以及适用时。默认是0。

---
[返回目录](#目录)
## <span id="Freeze">Freeze</span>
###### <span id="Freeze.DbEnv.env-name.CheckpointPeriod">Freeze.DbEnv.env-name.CheckpointPeriod</span>，格式：
	Freeze.DbEnv.env-name.CheckpointPeriod=num
Freeze 创建的每一个 Berkeley DB 环境都有一个与其相关联的线程,每隔 num 秒检查一次该环境。缺省值是 120 秒。

###### <span id="Freeze.DbEnv.env-name.DbHome">Freeze.DbEnv.env-name.DbHome</span>，格式：
	Freeze.DbEnv.env-name.DbHome=db-home
定义这个 Freeze 数据库环境的主目录。缺省是 env-name。

###### <span id="Freeze.DbEnv.env-name.DbPrivate">Freeze.DbEnv.env-name.DbPrivate</span>，格式：
	Freeze.DbEnv.env-name.DbPrivate=num
如果 num 被设成大于零的值, Freeze 会让 Berkeley DB 适用进程私有的内存,而不是共享内存。缺省值是 1。要针对正在使用的环境运行 db_archive (或其他 Berkeley DB 实用程序),把这个属性设成零。

###### <span id="Freeze.DbEnv.env-name.DbRecoverFatal">Freeze.DbEnv.env-name.DbRecoverFatal</span>，格式：
	Freeze.DbEnv.env-name.DbRecoverFatal=num
如果 num 被设成大于零的值,当环境被打开时,将进行 “fatal”恢复。缺 省值是 0。

###### <span id="Freeze.DbEnv.env-name.EncodingVersion">Freeze.DbEnv.env-name.EncodingVersion</span>，格式：
	Freeze.DbEnv.env-name.EncodingVersion=encoding
定义key和value的编码和解码的encoding。默认值是[Ice.Default.EncodingVersion](#Ice.Default.EncodingVersion)。

###### <span id="Freeze.DbEnv.env-name.LockFile">Freeze.DbEnv.env-name.LockFile</span>，格式：
	Freeze.DbEnv.env-name.LockFile=num
如果mun大于0，Freeze在数据库环境中创建锁文件以防止其他进程的打开环境。默认值是1。请注意，应用程序不应该禁用锁定文件，因为同时访问同一个环境的多个进程可以导致数据损坏。Freeze.DbEnv.env-name.DbPrivate设置为0，FreezeScript工具会禁用锁文件。

###### <span id="Freeze.DbEnv.env-name.OldLogsAutoDelete">Freeze.DbEnv.env-name.OldLogsAutoDelete</span>，格式：
	Freeze.DbEnv.env-name.OldLogsAutoDelete=num
如果 num 被设成大于零的值,在每次遇到周期性的检查点时 ( 参见 Freeze.DbEnv.env-name.DbCheckpointPeriod),不再使用的老事务日志将 会被删除。缺省值是 1。

###### <span id="Freeze.DbEnv.env-name.PeriodicCheckpointMinSize">Freeze.DbEnv.env-name.PeriodicCheckpointMinSize</span>，格式：
	Freeze.DbEnv.env-name.PeriodicCheckpointMinSize=num
num 是周期性的检查点的最小尺寸 ( 参见 Freeze.DbEnv.env-name.DbCheckpointPeriod),以 kb 为单位。这个值将传给 Berkeley DB 的检 查点函数。缺省值是 0( 也就是说,没有最小尺寸 )。

###### <span id="Freeze.Evictor.env-name.filename.MaxTxSize">Freeze.Evictor.env-name.filename.MaxTxSize</span>，格式：
	Freeze.DbEnv.env-name.PeriodicCheckpointMinSize=num
Freeze 使用了一个后台线程来保存对数据库的更新。在把许多 facet 合起来 保存时使用了事务。 num 定义的是在每个事务中所保存的 facet 的最大数 目。缺省值是 10 * SaveSizeTrigger ( 参见 Freeze.Evictor.env-name.db-name.SaveSizeTrigger) ;如果这个值为负,实际的值将被设成 100。

###### <span id="Freeze.Evictor.env-name.filename.name.BtreeMinKey">Freeze.Evictor.env-name.filename.name.BtreeMinKey</span>，格式：
	Freeze.Evictor.env-name.filename.name.BtreeMinKey=num
name代表一个数据库名称或索引。该属性设置相当于Berkeley DB数据库设置B-tree minkey。num小于2会被忽略。请查看Berkeley DB的文档描述。

###### <span id="Freeze.Evictor.env-name.filename.name.Checksum">Freeze.Evictor.env-name.filename.name.Checksum</span>，格式：
	Freeze.Evictor.env-name.filename.Checksum=num
如果num大于0，相当于Berkeley DB数据库启用checksums。请查看Berkeley DB的文档描述。

###### <span id="Freeze.Evictor.env-name.filename.PageSize">Freeze.Evictor.env-name.filename.PageSize</span>，格式：
	Freeze.Evictor.env-name.filename.PageSize=num
如果num大于0，该属性设置相当于Berkeley DB数据库设置页大小。请查看Berkeley DB的文档描述。

###### <span id="Freeze.Evictor.env-name.filename.PopulateEmptyIndices">Freeze.Evictor.env-name.filename.PopulateEmptyIndices</span>，格式：
	Freeze.Evictor.env-name.filename.PopulateEmptyIndices=num
当num不是0，并且你创建一个逐出器，该逐出器有一个或多个空索引，createBackgroundSaveEvictor或createTransactionalEvictor会调用，将填充这些索引所对应的facet。当FreezeScript不能改变索引，这是特别有用的在一个FreezeScript的Freeze逐出器改变之后。但是这可以显著减缓的逐出器创造的，如果你有一个空的索引，因为目前在数据库方面没有匹配该索引的类型。默认是0。

###### <span id="Freeze.Evictor.env-name.filename.RollbackOnUserException">Freeze.Evictor.env-name.filename.RollbackOnUserException</span>，格式：
	Freeze.Evictor.env-name.filename.RollbackOnUserException=num
如果num大于0，如果分发出路是一个用户异常，一个事务逐出器回滚该事务。如果num是0（默认），事务逐出器提交事务。

###### <span id="Freeze.Evictor.env-name.filename.SavePeriod">Freeze.Evictor.env-name.filename.SavePeriod</span>，格式：
	Freeze.Evictor.env-name.filename.SavePeriod=num
Freeze 使用了一个后台线程来保存对数据库的更新。在上一次保存的 num 毫秒之后,如果有任何 facet 被创建、修改或销毁,这个后台线程就会醒来 保存这些 facet。如果 num是0,就不进行周期性地保存。缺省值是 60000。

###### <span id="Freeze.Evictor.env-name.filename.SaveSizeTrigger">Freeze.Evictor.env-name.filename.SaveSizeTrigger</span>，格式：
	Freeze.Evictor.env-name.filename.SaveSizeTrigger=num
Freeze 使用了一个后台线程来保存对数据库的更新。如果 num 是 0 或正 数,只要有 num 个或更多的 facet 被创建、修改或销毁,后台线程就会醒来 保存它们。如果 num 为负,后台线程就不会因上述变化而被唤醒。缺省值 是 10。

###### <span id="Freeze.Evictor.env-name.filename.StreamTimeout">Freeze.Evictor.env-name.filename.StreamTimeout</span>，格式：
	Freeze.Evictor.env-name.filename.StreamTimeout=num
当保存线程保存一个对象时，它需要锁定该对象以获得对象的状态的一致的副本。如果锁不能获得在数秒，产生一个致命的错误。如果应用程序注册了一个致命的错误回调，这个回调将被调用，否则程序将立即终止。 当数是0或负数，没有超时。默认是0

###### <span id="Freeze.Map.name.BtreeMinKey">Freeze.Map.name.BtreeMinKey</span>，格式：
	Freeze.Map.name.BtreeMinKey=num
名称可以表示数据库名称或索引名称。该属性设置相当于Berkeley DB数据库设置B-tree minkey。num小于2会被忽略。请查看Berkeley DB的文档描述。

###### <span id="Freeze.Map.name.Checksum">Freeze.Map.name.Checksum</span>，格式：
	Freeze.Map.name.Checksum=num
名称可以表示数据库名称或索引名称。如果num大于0，相当于Berkeley DB数据库启用checksums。请查看Berkeley DB的文档描述。

###### <span id="Freeze.Map.name.PageSize">Freeze.Map.name.PageSize</span>，格式：
	Freeze.Map.name.PageSize=num
名称可以表示数据库名称或索引名称。如果num大于0，该属性设置相当于Berkeley DB数据库设置页大小。请查看Berkeley DB的文档描述。

###### <span id="Freeze.Trace.DbEnv">Freeze.Trace.DbEnv</span>，格式：
	Freeze.Trace.DbEnv=num
Freeze 数据库环境活动的跟踪级别:
* 0 不跟踪数据库环境的活动 ( 缺省 )。
* 1 跟踪数据库的打开和关闭。
* 2 还要跟踪检查点,以及老日志文件的移除。

###### <span id="Freeze.Trace.Evictor">Freeze.Trace.Evictor</span>，格式：
	Freeze.Trace.Evictor=num
Freeze 逐出器活动的跟踪级别:
* 0 不跟踪逐出器的活动 ( 缺省 )。
* 1 跟踪 Ice 对象和 facet 的创建和析构、 facet 的流动时间、 facet 的 保存时间、对象逐出 (每 50 个对象)和逐出器的解除激活。
* 2 还要跟踪对象查找,以及所有对象的逐出。
* 3 还要跟踪从数据库取回对象的活动。

###### <span id="Freeze.Trace.Map">Freeze.Trace.Map</span>，格式：
	Freeze.Trace.Map=num
Freeze 映射表活动的跟踪级别:
* 0 不跟踪映射表的活动 ( 缺省 )。
* 1 跟踪数据库的打开和关闭。
* 2 还要跟踪迭代器和事务操作,以及底层数据库的引用计数。

---
[返回目录](#目录)
## <span id="Glacier2">Glacier2</span>
###### <span id="Glacier2.AddConnectionContext">Glacier2.AddConnectionContext</span>，格式：
	Glacier2.AddConnectionContext=num
如果num设置为1或2，Glacier2增添了一些键值对的请求上下文，它发出的每个请求。如果num的值设置为1，这些条目添加到所有转发请求的上下文。如果num的值设置为2，环境不仅要求checkpermissions授权权限验证，并调用创建会话管理器。

如果num是非0，glacier2添加以下条目：

* _con.type 返回的连接类型Connection::type。
* _con.localAddress 本地地址（只限TCL和SSL）。
* _con.localPort 本地端口（只限TCL和SSL）。
* _con.remoteAddress 远程地址（只限TCL和SSL）。
* _con.remotePort 远程端口（只限TCL和SSL）。
* _con.cipher 密码（只限SSL）。
* _con.peerCert 首先验证客户端的证书链（只限SSL）。

默认值是0，这意味着不添加任何上下文。

###### <span id="Glacier2.AddUserToAllowCategories">Glacier2.AddUserToAllowCategories</span>，格式：
	Glacier2.AddUserToAllowCategories=num
创建新会话的时候指定是否要添加一个验证用户身份的Glacier2.AllowCategories属性。合法取值如下：

* 0 不添加用户身份（默认）。
* 1 添加用户身份。
* 2 添加以下划线开头的用户身份。

这个属性是不推荐，只支持向后兼容。新应用应使用Glacier2.Filter.Category.AcceptUser。

###### <span id="Glacier2.Admin.AdapterProperty">Glacier2.Admin.AdapterProperty</span>，格式：
	Glacier2.Admin.AdapterProperty=value
Glacier2使用名称为Glacier2.Admin的适配器管理对象适配器。因此，适配器属性可用于配置该适配器。 Glacier2.Admin.Endpoints属性必须定义为启用管理对象适配器。Glacier2点管理界面允许远程客户端关闭路由器；我们一般建议端点，只能从防火墙后面使用。

###### <span id="Glacier2.AllowCategories">Glacier2.AllowCategories</span>，格式：
	Glacier2.AllowCategories=list
指定一个空格分隔的身份类别列表。如果这个属性的定义，然后Glacier2路由器只允许请求来自这个list的身份匹配的Ice objects。如果Glacier2.AddUserToAllowCategories定义为非0，路由器会为每个会话自动增加用户标识到这个list。
这个属性是不推荐，只支持向后兼容。新应用应使用Glacier2.Filter.Category.Accept。因此，适配器属性可用于配置该适配器。 

###### <span id="Glacier2.Client.AdapterProperty">Glacier2.Client.AdapterProperty</span>，格式：
	Glacier2.Client.AdapterProperty=value
Glacier2使用名为Glacier2.Client适配器为客户提供对象适配器。该适配器必须可以被Glacier2的客户端访问。使用安全传输，此适配器是高度推荐的。
注意，Glacier2.Registry.Client.Endpoints为Glacier2控制客户端。端口4063（TCP）和4064（SSL）为Glacier2通过[Internet Assigned Numbers Authority (IANA)](http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)保留。

###### <span id="Glacier2.Client.AlwaysBatch">Glacier2.Client.AlwaysBatch</span>，格式：
	Glacier2.Client.AlwaysBatch=num
如果num大于0，glacier2路由器总是批排队单向客户请求服务器，不管他们的_fwd上下文的价值。此属性仅与[Glacier2.Client.Buffered](#Glacier2.Client.Buffered)启用相关。默认是0。

###### <span id="Glacier2.Client.Buffered">Glacier2.Client.Buffered</span>，格式：
	Glacier2.Client.Buffered=num
如果num大于0，Glacier2路由器在缓冲模式下运行，来自客户端的输入请求会在一个单独的线程中被排队和处理。如果num是0，路由器在非缓冲模式下运行，请求相同的线程下被转发和接收。默认是1。

###### <span id="Glacier2.Client.ForwardContext">Glacier2.Client.ForwardContext</span>，格式：
	Glacier2.Client.ForwardContext=num
如果num大于0，Glacier2路由器包括请求上下文，当从客户端发送请求到服务器。默认是0。

###### <span id="Glacier2.Client.SleepTime">Glacier2.Client.SleepTime</span>，格式：
	Glacier2.Client.SleepTime=num
如果num大于0，Glacier2路由器在转发所有来自客户端的排队请求后，以毫秒为单位的时间睡觉。对于批处理该延时是非常有用的，因为这使得它更容易在一个单一的批次中积累。同样的，如果重写，延迟使得它更可能为覆盖实际生效。此属性仅与[Glacier2.Client.Buffered](#Glacier2.Client.Buffered)启用相关。默认是0。

###### <span id="Glacier2.Client.Trace.Override">Glacier2.Client.Trace.Override</span>，格式：
	Glacier2.Client.Trace.Override=num
如果num大于0，每当请求失效时Glacier2路由器记录一条跟踪消息。默认是0。

###### <span id="Glacier2.Client.Trace.Reject">Glacier2.Client.Trace.Reject</span>，格式：
	Glacier2.Client.Trace.Reject=num
如果num大于0，每当路由器的配置过滤器拒绝客户端的请求时Glacier2路由器记录一条跟踪消息。默认是0。

###### <span id="Glacier2.Client.Trace.Request">Glacier2.Client.Trace.Request</span>，格式：
	Glacier2.Client.Trace.Request=num
如果num大于0，每个来自客户端的请求被转发时Glacier2路由器记录一条跟踪消息。默认是0。

###### <span id="Glacier2.CryptPasswords">Glacier2.CryptPasswords</span>，格式：
	Glacier2.CryptPasswords=file
指定Glacier2访问控制列表的文件名。文件中的每一行必须包含一个用户名和一个加密的密码，用空格隔开，如写一个密码文件。如果[Glacier2.PermissionsVerifier](#Glacier2.PermissionsVerifier)定义，该属性会被忽略。

###### <span id="Glacier2.Filter.AdapterId.Accept">Glacier2.Filter.AdapterId.Accept</span>，格式：
	Glacier2.Filter.AdapterId.Accept=list
指定一个空格分隔的适配器标识符列表。如果定义，Glacier2路由器的过滤请求，以便它只允许请求在这个list匹配标识符的Ice Object的适配器。包含空格的标识符必须用单引号或双引号括起来。单或双引号，出现在一个标识符必须用一个反斜杠转义。

###### <span id="Glacier2.Filter.Address.Accept">Glacier2.Filter.Address.Accept</span>，格式：
	Glacier2.Filter.Address.Accept=list
指定地址端口对的空格分隔列表。当定义了，Glacier2路由器的过滤请求，以便它只允许请求通过代理，包含网络端点信息匹配的地址端口对在这个属性中列出的对象。如果没有定义，默认值是\*，即允许任何网络地址。该属性接受请求，也许会被[Glacier2.Filter.Address.Reject](#Glacier2.Filter.Address.Reject)拒绝。
每一对的形式都是address:port。address和port部分可以包含通配符（\*）或值范围或组。范围或组的格式是[value1, value2, value3, ...]或[value1-value2]。通配符、范围和团体可能出现在地址端口对字符串的任何地方。

###### <span id="Glacier2.Filter.Address.Reject">Glacier2.Filter.Address.Reject</span>，格式：
	Glacier2.Filter.Address.Reject=list
指定地址端口对的空格分隔列表。当定义了，Glacier2路由器拒绝通过代理的Ice Objects请求，包含网络端点信息匹配的地址端口对在这个属性中列出的对象。如果没有定义，路由器总是允许请求任何网络地址，直到[Glacier2.Filter.Address.Accept](#Glacier2.Filter.Address.Accept)被设置，因为[Glacier2.Filter.Address.Accept](#Glacier2.Filter.Address.Accept)属性，请求会被拒绝或允许。如果同时设置[Glacier2.Filter.Address.Accept](#Glacier2.Filter.Address.Accept)和[Glacier2.Filter.Address.Reject](#Glacier2.Filter.Address.Reject)，[Glacier2.Filter.Address.Reject](#Glacier2.Filter.Address.Reject)属性优先。
每一对的形式都是address:port。address和port部分可以包含通配符（\*）或值范围或组。范围或组的格式是[value1, value2, value3, ...]或[value1-value2]。通配符、范围和团体可能出现在地址端口对字符串的任何地方。

###### <span id="Glacier2.Filter.Category.Accept">Glacier2.Filter.Category.Accept</span>，格式：
	Glacier2.Filter.Category.Accept=list
指定地址端口对的空格分隔列表。当定义了，Glacier2路由器的过滤请求，它只允许匹配在这个属性中列出的类别的Ice Objects的请求。如果[Glacier2.Filter.Category.AcceptUser](#Glacier2.Filter.Category.AcceptUser)定义为非0，路由器会自动添加每个会话的用户名到该列表中。
包含空格的类别必须用单引号或双引号括起来。单或双引号出现在类别必须用一个反斜杠转义。

###### <span id="Glacier2.Filter.Category.AcceptUser">Glacier2.Filter.Category.AcceptUser</span>，格式：
	Glacier2.Filter.Category.AcceptUser=num
当创建一个新会话时为[Glacier2.Filter.Category.Accept](#Glacier2.Filter.Category.Accept)属性指定是否添加一个认证的用户ID。合法值有：

* 0 不添加用户ID（默认）
* 1 添加用户ID
* 2 添加一个以下划线开头的用户ID

###### <span id="Glacier2.Filter.Identity.Accept">Glacier2.Filter.Identity.Accept</span>，格式：
	Glacier2.Filter.Identity.Accept=list
指定一个空格分隔的身份列表。如果定义了，Glacier2路由器过滤请求，它只允许与列表中匹配的Ice Objects的请求。
包含空格的类别必须用单引号或双引号括起来。单或双引号出现在类别必须用一个反斜杠转义。

###### <span id="Glacier2.Filter.ProxySizeMax">Glacier2.Filter.ProxySizeMax</span>，格式：
	Glacier2.Filter.ProxySizeMax=num
当设置了，Glacier2路由器拒绝大于num的字符串化的代理请求。这有助于保护系统免受攻击。Glacier2会接收任意长度的请求。

###### <span id="Glacier2.InstanceName">Glacier2.InstanceName</span>，格式：
	Glacier2.InstanceName=name
指定一个默认的Glacier2对象身份类别。如果定义，Glacier2管理接口身份变为name/admin，Glacier2路由接口身份变为name/router。默认是Glacier2。

###### <span id="Glacier2.PermissionsVerifier">Glacier2.PermissionsVerifier</span>，格式：
	Glacier2.PermissionsVerifier=proxy
指定实现为控制访问Glacier2会话的Glacier2::PermissionsVerifier接口的对象的代理。路由器调用此代理来验证每个新会话的用户名和密码。从一个安全的连接创建会话中指定对象的[Glacier2.SSLPermissionsVerifier](#Glacier2.SSLPermissionsVerifier)验证。对于简单的配置，您可以指定使用Glacier2.CryptPasswords密码文件的名称。
Glacier2提供了一个“null”的权限验证对象，接受任何的用户名和密码组合的情况下，在没有认证是必要的。为了可以验证，设置值为instance/NullPermissionsVerifier，instance是[Glacier2.InstanceName](#Glacier2.InstanceName)的值。作为代理的价值，你可以为代理配置附加的使用属性。

###### <span id="Glacier2.ReturnClientProxy">Glacier2.ReturnClientProxy</span>，格式：
	Glacier2.ReturnClientProxy=num
如果num大于0，Glacier2为使用Ice 3.2.0版本之前的客户提供维护向后兼容性。在这种情况下，你也应该定义[Glacier2.Client.PublishedEndpoints](#Glacier2.Client.PublishedEndpoints)指定客户应该使用与路由器的终点。默认是0。例如，如果glacier2路由器所在的网络在防火墙的后面，[Glacier2.Client.PublishedEndpoints](#Glacier2.Client.PublishedEndpoints)应指定防火墙外部端点。

###### <span id="Glacier2.RoutingTable.MaxSize">Glacier2.RoutingTable.MaxSize</span>，格式：
	Glacier2.RoutingTable.MaxSize=num
此属性设置的路由器的路由表大小为num项。如果更多的代理添加到表比这个值大，会根据最近最少使用的方式将代理逐出表。
基于ICE 3.1及之后的版本，客户端自动重试操作要求驱逐代理和透明地重新添加这样的代理表。
基于ICE 3.1之前的版本，客户端会接收到ObjectNotExistException，在驱逐代理时。对于这样的老客户，num必须设置一个足够大的值防止这些客户端失败。默认是1000。

###### <span id="Glacier2.Server.AdapterProperty">Glacier2.Server.AdapterProperty</span>，格式：
	Glacier2.Server.AdapterProperty=value
Glacier2为提供给服务器的对象适配器使用名为Glacier2.Server的适配器。因此，适配器属性可用于配置该适配器。该适配器提供访问SessionControl接口和必须可以访问到回调路由器客户端的服务端。

###### <span id="Glacier2.Server.AlwaysBatch">Glacier2.Server.AlwaysBatch</span>，格式：
	Glacier2.Server.AlwaysBatch=num
如果num大于0，glacier2路由器总是批排队从服务端请求客户端，不管他们的_fwd上下文的价值。此属性仅与[Glacier2.Server.Buffered](#Glacier2.Server.Buffered)启用相关。默认是0。

###### <span id="Glacier2.Server.Buffered">Glacier2.Server.Buffered</span>，格式：
	Glacier2.Server.Buffered=num
如果num大于0，Glacier2路由器在缓冲模式下运行，来自服务端的输入请求会在一个单独的线程中被排队和处理。如果num是0，路由器在非缓冲模式下运行，请求相同的线程下被转发和接收。默认是1。

###### <span id="Glacier2.Server.ForwardContext">Glacier2.Server.ForwardContext</span>，格式：
	Glacier2.Server.ForwardContext=num
如果num大于0，Glacier2路由器包括请求上下文，当从服务器发送请求到客户端。默认是0。

###### <span id="Glacier2.Server.SleepTime">Glacier2.Server.SleepTime</span>，格式：
	Glacier2.Server.SleepTime=num
如果num大于0，Glacier2路由器在转发所有来自服务端的排队请求后，以毫秒为单位的时间睡觉。对于批处理该延时是非常有用的，因为这使得它更容易在一个单一的批次中积累。同样的，如果重写，延迟使得它更可能为覆盖实际生效。此属性仅与[Glacier2.Server.Buffered](#Glacier2.Server.Buffered)启用相关。默认是0。

###### <span id="Glacier2.Server.Trace.Override">Glacier2.Server.Trace.Override</span>，格式：
	Glacier2.Server.Trace.Override=num
如果num大于0，每当请求失效时Glacier2路由器记录一条跟踪消息。默认是0。

###### <span id="Glacier2.Server.Trace.Request">Glacier2.Server.Trace.Request</span>，格式：
	Glacier2.Server.Trace.Request=num
如果num大于0，每当路由器的配置过滤器拒绝服务端的请求时Glacier2路由器记录一条跟踪消息。默认是0。

###### <span id="Glacier2.SessionManager">Glacier2.SessionManager</span>，格式：
	Glacier2.SessionManager=proxy
指定实现Glacier2::SessionManager接口的对象的代理。路由器调用该代理为客户端创建一个新会话，但仅在路由器验证该客户的用户名和密码后才可以创建一个新会话。
作为代理属性，您可以使用属性配置代理的其他方面。

###### <span id="Glacier2.SessionTimeout">Glacier2.SessionTimeout</span>，格式：
	Glacier2.SessionTimeout=num
如果num大于0，一个客户端会话在Glacier2路由器里num秒后过期不能用。默认是0，即永不过期。设置num非常重要这对于客户端会话不过早过期。Active Connection Management (ACM)对客户端连接（连接名为Glacier2.Client的路由器的对象适配器）的会话超时也有效。如果你没有设置为路由器[Glacier2.Client.ACM.Timeout](#Glacier2.Client.ACM.Timeout)，路由器使用该属性来控制会话超时。如果没有设置，路由器输入客户端连接使用默认的ACM。

###### <span id="Glacier2.SSLPermissionsVerifier">Glacier2.SSLPermissionsVerifier</span>，格式：
	Glacier2.SSLPermissionsVerifier=proxy
为实现Glacier2::SSLPermissionsVerifier接口的对象指定代理，用来控制访问Glacier2会话。路由器调用此代理来验证客户端的凭据，试图从安全连接创建会话。使用用户名称和密码创建会话来验证[Glacier2.PermissionsVerifier](#Glacier2.PermissionsVerifier)定义的对象。
Glacier2供应一个“null”权限验证器对象,接受任何客户端证书的情况下,不需要身份验证。为了可以验证，设置值为instance/NullPermissionsVerifier，instance是[Glacier2.InstanceName](#Glacier2.InstanceName)的值。
作为代理的价值，你可以为代理配置附加的使用属性。

###### <span id="Glacier2.Trace.RoutingTable">Glacier2.Trace.RoutingTable</span>，格式：
	Glacier2.Trace.RoutingTable=num
路由表跟踪等级：

* 0 没有路由表跟踪（默认）
* 1 每一个代理添加到路由表记录一条信息
* 2 每一个代理被驱逐出路由表记录一条信息（查看Glacier2.RoutingTable.MaxSize）
* 3 结合1、2

###### <span id="Glacier2.Trace.Session">Glacier2.Trace.Session</span>，格式：
	Glacier2.Trace.Session=num
如果num大于0，Glacier2路由器日志跟踪消息会话相关的活动。默认是0。

---
[返回目录](#目录)
## <span id="Ice.ACM">Ice.ACM</span>
###### <span id="Ice.ACM.Close">Ice.ACM.Close</span>，格式：
	Ice.ACM.Close=num
连接关闭的方式。num值为0、1、2、3、4

* 0 当communicator销毁，网络连接失败或连接端被关闭时直接关闭
* 1 当连接在一定时间内空闲，没有任何输入输出请求时优雅关闭
* 2 当连接在一定时间内空闲强制关闭，但有输出请求除外。这个必须配置[Ice.ACM.Client.Heartbeat](#Ice.ACM.Client.Heartbeat)
* 3 结合了1、2的情况
* 4 当连接在一定时间内空闲时强制关闭，不管是否有输出或输入请求。

###### <span id="Ice.ACM.Heartbeat">Ice.ACM.Heartbeat</span>，格式：
	Ice.ACM.Heartbeat=num
连接心跳。num值为0、1、2、3

* 0 关闭客户端（client）心跳
* 1 有输入请求时每隔一段时间发送心跳
* 2 连接空闲时每隔一段时间发送心跳
* 3 每隔一段时间发送心跳直到连接关闭为止

###### <span id="Ice.ACM.Timeout">Ice.ACM.Timeout</span>，格式：
	Ice.ACM.Timeout=num
连接超时，该属性结合[Ice.ACM.Close](#Ice.ACM.Close)和[Ice.ACM.Heartbeat](#Ice.ACM.Heartbeat)使用，默认60，单位秒。

###### <span id="Ice.ACM.Client.Close">Ice.ACM.Client.Close</span>，格式：
	Ice.ACM.Client.Close=num
输出端连接关闭的方式，重载[Ice.ACM.Close](#Ice.ACM.Close)

###### <span id="Ice.ACM.Client.Heartbeat">Ice.ACM.Client.Heartbeat</span>，格式：
	Ice.ACM.Client.Heartbeat=num
输出端连接心跳，重载[Ice.ACM.Heartbeat](#Ice.ACM.Heartbeat)

###### <span id="Ice.ACM.Client.Timeout">Ice.ACM.Client.Timeout</span>，格式：
	Ice.ACM.Client.Timeout=num
输出端连接超时该属性结合[Ice.ACM.Close](#Ice.ACM.Close)和[Ice.ACM.Heartbeat](#Ice.ACM.Heartbeat)使用，重载[Ice.ACM.Timeout](#Ice.ACM.Timeout)

###### <span id="Ice.ACM.Server.Close">Ice.ACM.Server.Close</span>，格式：
	Ice.ACM.Server.Close=num
输入端连接关闭的方式，重载[Ice.ACM.Close](#Ice.ACM.Close)

###### <span id="Ice.ACM.Server.Heartbeat">Ice.ACM.Server.Heartbeat</span>，格式：
	Ice.ACM.Server.Heartbeat=num
输入端连接心跳，重载[Ice.ACM.Heartbeat](#Ice.ACM.Heartbeat)

###### <span id="Ice.ACM.Server.Timeout">Ice.ACM.Server.Timeout</span>，格式：
	Ice.ACM.Server.Timeout=num
输入端连接超时该属性结合[Ice.ACM.Close](#Ice.ACM.Close)和[Ice.ACM.Heartbeat](#Ice.ACM.Heartbeat)使用，重载[Ice.ACM.Timeout](#Ice.ACM.Timeout)

---
[返回目录](#目录)
## <span id="Ice.Admin">Ice.Admin</span>
###### <span id="Ice.Admin.AdapterProperty">Ice.Admin.AdapterProperty</span>，格式：
	Ice.Admin.AdapterProperty=value
如果Administrative Facility开启，Ice运行时创建并激活一个名为Ice.Admin的administrative object adapter，[Ice.Admin.Endpoints](#Ice.Admin.Endpoints)是默认的，以下三选一，[Ice.Admin.DelayCreation](#Ice.Admin.DelayCreation)不启动；[Ice.Admin.DelayCreation](#Ice.Admin.DelayCreation)启动并且应用在communicator初始化后调用getAdmin；应用使用一个null作为adminAdapter的参数值来调用createAdmin。

###### <span id="Ice.Admin.DelayCreation">Ice.Admin.DelayCreation</span>，格式：
	Ice.Admin.DelayCreation=num
如果num大于0，Ice运行时延后创建Ice.Admin administrative object adapter，直到getAdmin在communicator中调用。默认值是0，即当所有插件（plug-in）s初始化后Ice.Admin object adapter会创建，提供给[Ice.Admin.Endpoints](#Ice.Admin.Endpoints)定义。

###### <span id="Ice.Admin.Enabled">Ice.Admin.Enabled</span>，格式：
	Ice.Admin.Enabled=num
num如果大于0，Administrative Facility开启；如果num是0或负数，Administrative Facility关闭。如果没有设置，[Ice.Admin.Endpoints](#Ice.Admin.Endpoints)定义不为空，并且在其他情况下是关闭，Administrative Facility就会开启

###### <span id="Ice.Admin.Facets">Ice.Admin.Facets</span>，格式：
	Ice.Admin.Facets=name [name ...]

###### <span id="Ice.Admin.InstanceName">Ice.Admin.InstanceName</span>，格式：
	Ice.Admin.InstanceName=name
为administrative object定义一个标志。如果定义了，对象的标志是name/admin，如果没有定义默认是一个UUID。

###### <span id="Ice.Admin.Logger.KeepLogs">Ice.Admin.Logger.KeepLogs</span>，格式：
	Ice.Admin.Logger.KeepLogs=num
使用非Ice::TraceMessage类型，缓存num多之前的日志信息，默认值是100，如果小于等于0，不缓存任何日志信息。

###### <span id="Ice.Admin.Logger.KeepTraces">Ice.Admin.Logger.KeepTraces</span>，格式：
	Ice.Admin.Logger.KeepTraces=num
使用Ice::TraceMessage类型，缓存num多之前的日志信息，默认值是100，如果小于等于0，不缓存任何日志信息。

###### <span id="Ice.Admin.Logger.Properties">Ice.Admin.Logger.Properties</span>，格式：
	Ice.Admin.Logger.Properties=propertyList
如果开启，创建自己拥有的communicator发送日志信息到远程日志文件中。

###### <span id="Ice.Admin.ServerId">Ice.Admin.ServerId</span>，格式：
	Ice.Admin.ServerId=id
定义一个进程的唯一标志，当Ice运行时到定位器（locator）注册时，用于注册admin对象。

---
[返回目录](#目录)
## <span id="Ice.Default">Ice.Default</span>
###### <span id="Ice.Default.CollocationOptimized">Ice.Default.CollocationOptimized</span>，格式：
	Ice.Default.CollocationOptimized=num
搭配优化，有效避免网络拥堵。默认是1，设为0则关闭搭配优化。

###### <span id="Ice.Default.EncodingVersion">Ice.Default.EncodingVersion</span>，格式：
	Ice.Default.EncodingVersion=ver
如果没有定义，在Ice 3.5使用编码版本是1.1。

###### <span id="Ice.Default.EndpointSelection">Ice.Default.EndpointSelection</span>，格式：
	Ice.Default.EndpointSelection=policy
多个端点（endpoint）的选择策略，值为Ordered或Random，默认是Random。

###### <span id="Ice.Default.Host">Ice.Default.Host</span>，格式：
	Ice.Default.Host=host
如果端点（endpoint）没有使用指定的host name，那么将使用该值。

###### <span id="Ice.Default.InvocationTimeout">Ice.Default.InvocationTimeout</span>，格式：
	Ice.Default.InvocationTimeout=num
调用超时设置，单位毫秒，默认是-1，即从不超时。

###### <span id="Ice.Default.Locator">Ice.Default.Locator</span>，格式：
	Ice.Default.Locator=locator
为所有代理（proxy）和对象适配器（adapter）定义一个定位器，默认没有。

###### <span id="Ice.Default.LocatorCacheTimeout">Ice.Default.LocatorCacheTimeout</span>，格式：
	Ice.Default.LocatorCacheTimeout=num
代理（proxy）的定位缓存超时，单位秒。设为0，不使用缓存。设为-1，缓存有不过期。

###### <span id="Ice.Default.Package">Ice.Default.Package</span>，格式：
	Ice.Default.Package=package
Ice为Java提供定制报名生成代码。

###### <span id="Ice.Default.PreferSecure">Ice.Default.PreferSecure</span>，格式：
	Ice.Default.PreferSecure=num
指定安全端点（endpoint），默认值为0，意味着不可靠的端点（endpoint）优先。

###### <span id="Ice.Default.Protocol">Ice.Default.Protocol</span>，格式：
	Ice.Default.Protocol=protocol
指定端点（endpoint）的传输协议，默认tcp。

###### <span id="Ice.Default.Router">Ice.Default.Router</span>，格式：
	Ice.Default.Router=router
指定所有代理的默认路由器。值为Glacier2路由器的控制界面的字符化代理。默认的路由器会重写代理的ice_router代理方法。默认值是没有路由器。

###### <span id="Ice.Default.SlicedFormat">Ice.Default.SlicedFormat</span>，格式：
	Ice.Default.SlicedFormat=num
指定slice和异常的编码格式。默认是0，即使用简洁格式。

###### <span id="Ice.Default.SourceAddress">Ice.Default.SourceAddress</span>，格式：
	Ice.Default.SourceAddress=addr
将输出套接字绑定到该地址的网卡上，允许ip地址。

###### <span id="Ice.Default.Timeout">Ice.Default.Timeout</span>，格式：
	Ice.Default.Timeout=num
端点（endpoint）的超时，单位毫秒，默认60000，设为-1，表示无穷大的超时时间，即没有超时。

---
[返回目录](#目录)
###### <span id="Ice.InitPlugins">Ice.InitPlugins</span>，格式：
	Ice.InitPlugins=num
如果num大于0，Ice运行时自动初始化并加载插件（plug-in），插件（plug-in）加载和初始化顺序通过[Ice.PluginLoadOrder](#Ice.PluginLoadOrder)定义，默认值是1。

---
[返回目录](#目录)
###### <span id="Ice.IPv4">Ice.IPv4</span>，格式：
	Ice.IPv4=num
Ice是否使用IPv4，大于0，表示使用，默认值是1。

---
[返回目录](#目录)
###### <span id="Ice.IPv6">Ice.IPv6</span>，格式：
	Ice.IPv6=num
Ice是否使用IPv6，大于0，表示使用。如果系统支持IPv6，默认值是1，如果不支持，默认值是0。

---
[返回目录](#目录)
## <span id="Ice.Override">Ice.Override</span>
###### <span id="Ice.Override.CloseTimeout">Ice.Override.CloseTimeout</span>，格式：
	Ice.Override.CloseTimeout=num
重写关闭连接的超时设置。单位毫秒。-1表示没有超时。如果没有定义，则使用[Ice.Override.Timeout](#Ice.Override.Timeout)，如果[Ice.Override.Timeout](#Ice.Override.Timeout)也没有定义，则使用端点（endpoint）的超时。

###### <span id="Ice.Override.Compress">Ice.Override.Compress</span>，格式：
	Ice.Override.Compress=num
如果设定，将重写所有代理（proxy）的压缩设置。num大于0，压缩启用。num为0，压缩不使用。该设置在服务角色忽略。
提示：如果客户端（client）设置Ice.Override.Compress=1并发送一个压缩请求到一个不支持压缩的服务端（server），服务端（server）将会关闭连接，并且客户端（client）收到ConnectionLostException。
如果一个客户端（client）不支持压缩并设置Ice.Override.Compress=1，设置会被忽略并通过stderr打印警告信息。
请求小于100字节不会压缩。

###### <span id="Ice.Override.ConnectTimeout">Ice.Override.ConnectTimeout</span>，格式：
	Ice.Override.ConnectTimeout=num
重写建立连接的超时设置。单位毫秒。-1表示没有超时。如果没有设置，会使用[Ice.Override.Timeout](#Ice.Override.Timeout)，如果[Ice.Override.Timeout](#Ice.Override.Timeout)也没有定义，则使用端点（endpoint）的超时。

###### <span id="Ice.Override.Secure">Ice.Override.Secure</span>，格式：
	Ice.Override.Secure=num
重写所有代理（proxy）的安全设置，只允许安全的端点（endpoint）。该属性等价于每个代理（proxy）都调用ice_secure(true)方法。

###### <span id="Ice.Override.Timeout">Ice.Override.Timeout</span>，格式：
	Ice.Override.Timeout=num
重写所有端点（endpoint）超时设置。单位毫秒。-1表示没有超时。

---
[返回目录](#目录)
## <span id="Ice.Plugin">Ice.Plugin</span>
###### <span id="Ice.Plugin.name">Ice.Plugin.name</span>，格式：
	Ice.Plugin.name=entry_point [args]
定义插件（plug-in）在communicator初始化时安装。

###### <span id="Ice.Plugin.name.clr">Ice.Plugin.name.clr</span>，格式：
	Ice.Plugin.name.clr=assembly:class [args]
定义一个.NET插件（plug-in）在communicator初始化时安装。

###### <span id="Ice.Plugin.name.cpp">Ice.Plugin.name.cpp</span>，格式：
	Ice.Plugin.name.cpp=path[,version]:function [args]
定义一个C++插件（plug-in）在communicator初始化时安装。

###### <span id="Ice.Plugin.name.java">Ice.Plugin.name.java</span>，格式：
	Ice.Plugin.name.java=[path:]class [args]
定义一个Java插件（plug-in）在communicator初始化时安装。

---
[返回目录](#目录)
###### <span id="Ice.PluginLoadOrder">Ice.PluginLoadOrder</span>，格式：
	Ice.PluginLoadOrder=names
定义插件（plug-in）的加载顺序。

---
[返回目录](#目录)
###### <span id="Ice.PreferIPv6Address">Ice.PreferIPv6Address</span>，格式：
	Ice.PreferIPv6Address=num
如果IPv4和IPv6同时使用（默认是），当确定hostname时，Ice优先使用IPv6地址。默认为0，如果大于0，优先使用IPv6。

---
[返回目录](#目录)
## <span id="Ice.TCP">Ice.TCP</span>
###### <span id="Ice.TCP.Backlog">Ice.TCP.Backlog</span>，格式：
	Ice.TCP.Backlog=num
设置TCP或SSL服务端（server）的端点（endpoint）的监听队列大小。如果没有定义，在C++中如果存在SOMAXCONN就是SOMAXCONN，不存在则是511。在Java和.NET是511。

###### <span id="Ice.TCP.RcvSize">Ice.TCP.RcvSize</span>，格式：
	Ice.TCP.RcvSize=num
设置TCP接收缓存大小，单位字节。默认值依赖于本地TCP栈的配置（通常是65535个字节）。

###### <span id="Ice.TCP.SndSize">Ice.TCP.SndSize</span>，格式：
	Ice.TCP.SndSize=num
设置TCP发送缓存大小，单位字节。默认值依赖于本地TCP栈的配置（通常是65535个字节）。

--
[返回目录](#目录)
## <span id="Ice.ThreadPool">Ice.ThreadPool</span>
###### <span id="Ice.ThreadPool.name.Serialize">Ice.ThreadPool.name.Serialize</span>，格式：
	Ice.ThreadPool.name.Serialize=num
如果大于0，客户端（client）或服务端（server）的线程池序列化每一个连接的所有信息。在最大大小为1的线程池中是不需要的。在多线程池中，启用序列化允许请求从不同的连接同时发送，同时保护每个连接上的消息的顺序。注意序列化对延迟和吞吐量的重要影响。默认是0。

###### <span id="Ice.ThreadPool.name.Size">Ice.ThreadPool.name.Size</span>，格式：
	Ice.ThreadPool.name.Size=num
在Ice中线程池基于平均负载因子会动态扩大或缩小。一个线程池总是至少有1个线程，可以随着负载的增加而扩大，最大到[Ice.ThreadPool.name.SizeMax](#Ice.ThreadPool.name.SizeMax)指定的大小。如果最大没有设定，Ice使用num作为最大值。客户端（client）或服务端（server）的线程池初始化大小是num，当在[Ice.ThreadPool.name.ThreadIdleTime](#Ice.ThreadPool.name.ThreadIdleTime)指定的空闲周期，会缩小到1。默认值是1。

###### <span id="Ice.ThreadPool.name.SizeMax">Ice.ThreadPool.name.SizeMax</span>，格式：
	Ice.ThreadPool.name.SizeMax=num
客户端（client）或服务端（server）的线程池最大大小。

###### <span id="Ice.ThreadPool.name.SizeWarn">Ice.ThreadPool.name.SizeWarn</span>，格式：
	Ice.ThreadPool.name.SizeWarn=num
每当有num条线程在客户端（client）或服务端（server）的线程池中活动，会打印"low on threads"的警告，默认是0，禁止警告。

###### <span id="Ice.ThreadPool.name.StackSize">Ice.ThreadPool.name.StackSize</span>，格式：
	Ice.ThreadPool.name.StackSize=num
在客户端（client）或服务端（server）的线程池中有num字节大小的栈。默认值是0，即使用操作系统的默认值。

###### <span id="Ice.ThreadPool.name.ThreadIdleTime">Ice.ThreadPool.name.ThreadIdleTime</span>，格式：
	Ice.ThreadPool.name.ThreadIdleTime=num
在客户端（client）或服务端（server）的线程池中，Ice会自动回收空闲的线程以节省资源。当线程达到该空闲时间会被回收。单位秒，默认是60。设为0表示从不回收空闲线程。

###### <span id="Ice.ThreadPool.name.ThreadPriority">Ice.ThreadPool.name.ThreadPriority</span>，格式：
	Ice.ThreadPool.name.ThreadPriority=num
在客户端（client）或服务端（server）的线程池中指定num优先级的线程。没有设置，Ice会创建Ice.ThreadPriority指定优先级的线程。默认没有设置。
你可以使用adapter.ThreadPool.ThreadPriority为object adapter重写该属性。

###### <span id="Ice.ThreadPriority">Ice.ThreadPriority</span>，格式：
	Ice.ThreadPriority=num
指定num优先级的线程。Ice运行时默认创建指定优先级的线程。没有设置，则按系统默认的优先级创建线程。默认没有设置。

---
[返回目录](#目录)
## <span id="Ice.Trace">Ice.Trace</span>
###### <span id="Ice.Trace.Admin.Logger">Ice.Trace.Admin.Logger</span>，格式：
	Ice.Trace.Admin.Logger=num
后台跟踪的等级。

* 0 默认，不跟踪
* 1 当远程端日志安装或拆卸，跟踪
* 2 像1，当总是跟踪并发送日志信息给远程端

###### <span id="Ice.Trace.Admin.Properties">Ice.Trace.Admin.Properties</span>，格式：
	Ice.Trace.Admin.Properties=num
后台跟踪的属性更新模式

* 0 默认，没有属性
* 1 添加、修改和移除跟踪属性。

###### <span id="Ice.Trace.Locator">Ice.Trace.Locator</span>，格式：
	Ice.Trace.Locator=num
Ice运行时创建定位请求来解决端点（endpoint）的对象适配器和已知对象。使用定位器注册表的请求来更新对象适配器端点（endpoint），并设置服务端（server）进程代理。此属性控制的跟踪级别为Ice运行时与定位器的相互作用：

* 0 默认，无定位跟踪
* 1 跟踪Ice定位器和定位器注册请求。
* 2 像1，但也从缓存中跟踪删除端点（endpoint）。

###### <span id="Ice.Trace.Network">Ice.Trace.Network</span>，格式：
	Ice.Trace.Network=num
控制低级别的网络活动，例如连接建立和读/写操作的跟踪级别：

* 0 默认，无网络跟踪
* 1 跟踪成功连接的建立和关闭。
* 2 像1，但也跟踪尝试绑定，连接和断开的套接字。
* 3 像2，还有跟踪数据传输，发布端点（endpoint）的对象适配器，和当前为端点（endpoint）使用通配符地址的本地地址列表。

###### <span id="Ice.Trace.Protocol">Ice.Trace.Protocol</span>，格式：
	Ice.Trace.Protocol=num
Ice协议信息的跟踪等级：

* 0 默认，无协议跟踪
* 1 跟踪Ice协议信息。

###### <span id="Ice.Trace.Retry">Ice.Trace.Retry</span>，格式：
	Ice.Trace.Retry=num
Ice支持在请求失败的情况下自动重试。此属性控制重试的跟踪级别：

* 0 默认，不重试
* 1 跟踪Ice操作调用重试
* 2 还跟踪I端点（endpoint）的使用。

###### <span id="Ice.Trace.Slicing">Ice.Trace.Slicing</span>，格式：
	Ice.Trace.Slicing=num
用于异常和允许接收器将未知的异常或类切分为已知类的Ice数据编码。此属性控制用于切片活动的跟踪级别：

* 0 默认，不跟踪切片活动
* 1 跟踪所有未知的异常和类的切片活动。

###### <span id="Ice.Trace.ThreadPool">Ice.Trace.ThreadPool</span>，格式：
	Ice.Trace.ThreadPool=num
控制Ice线程池的跟踪等级：

* 0 默认，不跟踪线程池活动
* 1 跟踪线程池的创建、扩大和缩小。

---
[返回目录](#目录)
## <span id="Ice.UDP">Ice.UDP</span>
###### <span id="Ice.UDP.RcvSize">Ice.UDP.RcvSize</span>，格式：
	Ice.UDP.RcvSize=num
设置UDP接收缓存大小，单位字节。Ice大于28字节的消息数造成DatagramLimitException。默认大小依赖于本地UDP栈的配置，通常是65535和8192字节。值小于28会被忽略。
小于65535限制的Ice数据包会调整为内核的缓存大小。

###### <span id="Ice.UDP.SndSize">Ice.UDP.SndSize</span>，格式：
	Ice.UDP.SndSize=num
设置UDP发送缓存大小，单位字节。Ice大于28字节的消息数造成DatagramLimitException。默认大小依赖于本地UDP栈的配置，通常是65535和8192字节。值小于28会被忽略。
小于65535限制的Ice数据包会调整为内核的缓存大小。

---
[返回目录](#目录)
## <span id="Ice.Warn">Ice.Warn</span>
###### <span id="Ice.Warn.AMICallback">Ice.Warn.AMICallback</span>，格式：
	Ice.Warn.AMICallback=num
如果num的值被设置为大于0，如果AMI回调返回一个异常，会打印一个警告。默认是1。

###### <span id="Ice.Warn.Connections">Ice.Warn.Connections</span>，格式：
	Ice.Warn.Connections=num
如果num的值被设置为大于0，在连接中的某些异常情况下的Ice应用打印警告消息。默认是0。

###### <span id="Ice.Warn.Datagrams">Ice.Warn.Datagrams</span>，格式：
	Ice.Warn.Datagrams=num
如果num的值被设置为大于0，如果接收一个超出服务端（server）接收缓存大小的数据包，服务端（server）打印警告消息。默认是0。

###### <span id="Ice.Warn.Dispatch">Ice.Warn.Dispatch</span>，格式：
	Ice.Warn.Dispatch=num
如果num的值被设置为大于0，当一个输入请求被分发发生某个异常时，Ice应用打印警告消息。
警告等级：

* 0 没有警告
* 1 默认。打印Ice::LocalException，Ice::UserException，C++ exceptions，和Java运行时的异常警告
* 2 像1，但也发出Ice::ObjectNotExistException，Ice::FacetNotExistException，和 Ice::OperationNotExistException警告

###### <span id="Ice.Warn.Endpoints">Ice.Warn.Endpoints</span>，格式：
	Ice.Warn.Endpoints=num
如果num的值被设置为大于0，如果一个包含一个端点（endpoint）的序列不代理，无法分析，打印警告。默认是1。

###### <span id="Ice.Warn.UnknownProperties">Ice.Warn.UnknownProperties</span>，格式：
	Ice.Warn.UnknownProperties=num
如果num的值被设置为大于0，对未知的对象适配器（object adapter）和代理（proxy），Ice运行时打印警告。默认是1。

###### <span id="Ice.Warn.UnusedProperties">Ice.Warn.UnusedProperties</span>，格式：
	Ice.Warn.UnusedProperties=num
如果num的值被设置为大于0，在communicator销毁一些不能读的属性时，Ice运行时打印警告。此警告是有效地检测拼写错误的属性。默认是0。

---
[返回目录](#目录)
## <span id="IceBox">IceBox</span>
###### <span id="IceBox.InheritProperties">IceBox.InheritProperties</span>，格式：
	IceBox.InheritProperties=num
从IceBox Server继承配置，必须大于0，没有定义，默认是0。

###### <span id="IceBox.LoadOrder">IceBox.LoadOrder</span>，格式：
	IceBox.LoadOrder=names
设置服务启动先后顺序。

###### <span id="IceBox.PrintServicesReady">IceBox.PrintServicesReady</span>，格式：
	IceBox.PrintServicesReady=token
当初始化完所有的service就会输出“token ready”。

###### <span id="IceBox.Service.name">IceBox.Service.name</span>，格式：
	IceBox.Service.name=entry_point [--key=value] [args]
定义一个service在IceBox初始化期间加载。name定义service的名称，作为start方法的name参数，必须唯一的。[--key=value]将会被作为property属性，用于构造该服务的communicator，用来更加精确地控制每个Ice服务的性能调优。[args]作为参数传入start方法的参数String[] args中，作为服务的启动初始化参数。

###### <span id="IceBox.UseSharedCommunicator.name">IceBox.UseSharedCommunicator.name</span>，格式：
	IceBox.UseSharedCommunicator.name=num
num必须大于0，如果没有定义，默认值为0，为其他service共享communicator。

---
[返回目录](#目录)
## <span id="IceBoxAdmin">IceBoxAdmin</span>
###### <span id="IceBoxAdmin.ServiceManager.Proxy">IceBoxAdmin.ServiceManager.Proxy</span>，格式：
	IceBoxAdmin.ServiceManager.Proxy=proxy
此属性配置代理，由iceboxadmin效用用于定位服务管理。

---
[返回目录](#目录)
## <span id="IceDiscovery">IceDiscovery</span>
###### <span id="IceDiscovery.Address">IceDiscovery.Address</span>，格式：
	IceDiscovery.Address=addr
指定用于发送或接收组播请求的组播地址。如果没有定义，默认值取决于其他属性设置：

* 如果[Ice.PreferIPv6Address](#Ice.PreferIPv6Address)启动或Ice.IPv4关闭， IceDiscovery使用ff15::1的IPv6地址
* 其他情况则IceDiscovery使用239.255.0.1

###### <span id="IceDiscovery.DomainId">IceDiscovery.DomainId</span>，格式：
	IceDiscovery.DomainId=id
指定用于定位对象和对象适配器的域标识。IceDiscovery插件只响应来自具有相同域ID的客户端（client）请求和忽略来自有不同域ID的客户端（client）请求。如果没有定义，默认的域ID是一个空字符串。

###### <span id="IceDiscovery.Interface">IceDiscovery.Interface</span>，格式：
	IceDiscovery.Interface=intf
指定用于发送和接收组播请求的IP地址接口。如果没有定义，操作系统将选择一个默认接口发送和接收组播UDP数据报。

###### <span id="IceDiscovery.Locator.AdapterProperty">IceDiscovery.Locator.AdapterProperty</span>，格式：
	IceDiscovery.Locator.AdapterProperty=value
IceDiscovery创建了一个名为IceDiscovery.Locator对象适配器。
通常不需要为该对象适配器设置其他属性。

###### <span id="IceDiscovery.Lookup">IceDiscovery.Lookup</span>，格式：
	IceDiscovery.Lookup=endpoint
指定客户端（client）用于发送发现请求的组播端点（endpoint）。如果没有定义，端点（endpoint）是由如下组成：

	udp -h addr -p port --interface intf
addr就是IceDiscovery.Address的值，port就是IceDiscovery.Port的值，intf就是IceDiscovery.Interface的值。

###### <span id="IceDiscovery.Multicast.AdapterProperty">IceDiscovery.Multicast.AdapterProperty</span>，格式：
	IceDiscovery.Multicast.AdapterProperty=value
IceDiscovery为接收来自客户端（client）的发现请求，创建名为IceDiscovery.Multicast的对象适配器。如果IceDiscovery.Multicast.Endpoints没有其他的定义，对象适配器的端点（endpoint）是由如下组成：

	udp -h addr -p port --interface intf
addr就是IceDiscovery.Address的值，port就是IceDiscovery.Port的值，intf就是IceDiscovery.Interface的值。
通常不需要为该对象适配器设置其他属性。

###### <span id="IceDiscovery.Port">IceDiscovery.Port</span>，格式：
	IceDiscovery.Port=port
指定用于发送或接收组播请求的组播端口。如果没有设置，默认值是4061。

###### <span id="IceDiscovery.Reply.AdapterProperty">IceDiscovery.Reply.AdapterProperty</span>，格式：
	IceDiscovery.Reply.AdapterProperty=value
IceDiscovery为接收应答组播请求，创建名为IceDiscovery.Reply的对象适配器。如果[IceDiscovery.Reply.Endpoints](#IceDiscovery.Reply.Endpoints)没有其他的定义，对象适配器的端点（endpoint）是由如下组成：

	udp --interface intf
intf就是IceDiscovery.Interface的值。此端点（endpoint）不需要一个固定端口。
通常不需要为该对象适配器设置其他属性。

###### <span id="IceDiscovery.RetryCount">IceDiscovery.RetryCount</span>，格式：
	IceDiscovery.RetryCount=num
指定该插件（plug-in）重新发送UDP组播请求的最大次数。[IceDiscovery.Timeout](#IceDiscovery.Timeout)属性表明插件（plug-in）等待多久重发。默认重试次数为3。

###### <span id="IceDiscovery.Timeout">IceDiscovery.Timeout</span>，格式：
	IceDiscovery.Timeout=num
指定等待UDP组播请求的时间间隔，单位毫秒。如果这个时间间隔内，没有服务端（server）回答，客户端（client）将重试[IceDiscovery.RetryCount](#IceDiscovery.RetryCount)指定次数的请求。默认的超时时间为300。

---
[返回目录](#目录)
## <span id="IceGrid">IceGrid</span>
###### <span id="IceGrid.InstanceName">IceGrid.InstanceName</span>，格式：
	IceGrid.InstanceName=name
为IceGrid对象指定的另一个身份类别。值有：

* name/AdminSessionManager
* name/AdminSessionManager-replica
* name/AdminSSLSessionManager
* name/AdminSSLSessionManager-replica
* name/NullPermissionsVerifier
* name/NullSSLPermissionsVerifier
* name/Locator
* name/Query
* name/Registry
* name/Registry-replica
* name/RegistryUserAccountMapper
* name/RegistryUserAccountMapper-replica
* name/SessionManager
* name/SSLSessionManager
默认为IceGrid。

###### <span id="IceGrid.Node.AdapterProperty">IceGrid.Node.AdapterProperty</span>，格式：
	IceGrid.Node.AdapterProperty=value
一个IceGrid节点使用名为IceGrid.Node的注册表联系人与节点通信对象适配器。因此，适配器属性可用于配置该适配器。

###### <span id="IceGrid.Node.AllowEndpointsOverride">IceGrid.Node.AllowEndpointsOverride</span>，格式：
	IceGrid.Node.AllowEndpointsOverride=num
如果设置为非0，一个IceGrid节点允许服务端（server）重写预先的设置，即使服务端（server）是活动的。如果由节点使用对象适配器运行refreshPublishedEndpoints来管理服务端（server），将此设置为一个非零的值是必要的。默认是0。

###### <span id="IceGrid.Node.AllowRunningServersAsRoot">IceGrid.Node.AllowRunningServersAsRoot</span>，格式：
	IceGrid.Node.AllowRunningServersAsRoot=num
如果设置为非0，一个IceGrid节点允许服务端（server）开始由节点以超级用户权限运行。请注意，除非节点使用安全端点（endpoint），否则不得设置此属性；其他情况下，客户端（client）可以在节点的机器上启动超级用户特权的任意进程。默认是0。

###### <span id="IceGrid.Node.CollocateRegistry">IceGrid.Node.CollocateRegistry</span>，格式：
	IceGrid.Node.CollocateRegistry=num
如果num的值被设置为大于0，节点配置IceGrid注册表。配置注册表与IceGrid注册表相同的属性，并独立于IceGrid注册表。

###### <span id="IceGrid.Node.Data">IceGrid.Node.Data</span>，格式：
	IceGrid.Node.Data=path
定义IceGrid节点的数据目录路径。如果在该目录下没有distrib，servers和tmp subdirectories，节点会创建它们。distrib目录包含从IcePatch2服务端（server）下载的分布文件。servers目录保护每一台部署服务端（server）的配置数据。tmp subdirectories目录存放临时文件。

###### <span id="IceGrid.Node.DisableOnFailure">IceGrid.Node.DisableOnFailure</span>，格式：
	IceGrid.Node.DisableOnFailure=num
节点考虑到服务端（server）非正常终止，如非0退出或因为SIGABRT，SIGBUS，SIGILL，SIGFPE或SIGSEGV信号的退出。如果num非0，节点标志这样的服务端（server）为禁用；禁用的服务端（server）无法启动需求。num大于0，服务端（server）在num秒内禁用；num小于0，服务端（server）将一直禁用，或指导确定可用或通过管理启动。默认值为0，在这种情况下的节点不禁用服务端（server）。

###### <span id="IceGrid.Node.Name">IceGrid.Node.Name</span>，格式：
	IceGrid.Node.Name=name
定义IceGrid节点的名称。使用相同的注册表的所有节点必须有唯一的名称；如果有一个节点以相同的名称运行，则拒绝启动节点。此属性必须为每个节点定义。

###### <span id="IceGrid.Node.Output">IceGrid.Node.Output</span>，格式：
	IceGrid.Node.Output=path
定义IceGrid节点的输出目录路径。如果设置，节点重定向启动的服务端（server）的stdout和stderr的输出，名为server.out和server.err 的文件会在该目录下。否则，启动服务端（server）时，所有节点进程共享的stdout和stderr。

###### <span id="IceGrid.Node.PrintServersReady">IceGrid.Node.PrintServersReady</span>，格式：
	IceGrid.Node.PrintServersReady=token
节点管理的所有服务端（server）准备后，IceGrid节点在标准输出打印"token ready"。这是非常有用的脚本，希望等到所有的服务端（server）已经开始，并准备使用。

###### <span id="IceGrid.Node.ProcessorSocketCount">IceGrid.Node.ProcessorSocketCount</span>，格式：
	IceGrid.Node.ProcessorSocketCount=num
这个属性设置了套接字处理器的数量。该值会通过套接字命令向icegridadmin节点报告。在Windows Vista（或后续版本），Windows Server 2008（或后续版本）和Linux系统上，Ice运行时会自动设置套接字处理器的数量。在其他系统上，Ice运行时不能从系统获取套接字处理器的数量，你可以使用该属性设置。

###### <span id="IceGrid.Node.PropertiesOverride">IceGrid.Node.PropertiesOverride</span>，格式：
	IceGrid.Node.PropertiesOverride=overrides
定义重写在服务端（server）部署描述符中定义的属性的属性列表。多个用空格来分开。

###### <span id="IceGrid.Node.RedirectErrToOut">IceGrid.Node.RedirectErrToOut</span>，格式：
	IceGrid.Node.RedirectErrToOut=num
如果num的值被设置为大于0，每个启动的服务端（server）的stderr重定向到服务端（server）的stdout。

###### <span id="IceGrid.Node.Trace.Activator">IceGrid.Node.Trace.Activator</span>，格式：
	IceGrid.Node.Trace.Activator=num
活动器跟踪等级：

* 0 默认，没有活动器跟踪
* 1 跟踪进程的激活、终止
* 2 像1，但更复杂，在进程激活下，跟踪进程信令和更多的诊断信息
* 3 像2，但更复杂，在进程激活下，跟踪进程更多的诊断信息

###### <span id="IceGrid.Node.Trace.Adapter">IceGrid.Node.Trace.Adapter</span>，格式：
	IceGrid.Node.Trace.Adapter=num
对象适配器跟踪等级：

* 0 默认，没有对象适配器跟踪
* 1 跟踪对象适配器的添加、移除
* 2 像1，但更复杂，包括对象适配器的激活、非激活和更多的诊断信息
* 3 像2，但更复杂，包括对象适配器过渡状态改变

###### <span id="IceGrid.Node.Trace.Patch">IceGrid.Node.Trace.Patch</span>，格式：
	IceGrid.Node.Trace.Patch=num
碎片跟踪等级：

* 0 默认，没有碎片跟踪
* 1 显示碎片进程的概要
* 2 像1，但更复杂，包括下载统计数据
* 3 像2，但更复杂，包括校验信息

###### <span id="IceGrid.Node.Trace.Replica">IceGrid.Node.Trace.Replica</span>，格式：
	IceGrid.Node.Trace.Replica=num
副本跟踪等级：

* 0 默认，没有副本跟踪
* 1 节点和副本建会话生命周期的跟踪
* 2 像1，但更复杂，包括会话建立尝试和失败
* 3 像2，但更复杂，包括将活着的消息发送到副本

###### <span id="IceGrid.Node.Trace.Server">IceGrid.Node.Trace.Server</span>，格式：
	IceGrid.Node.Trace.Server=num
服务端（server）跟踪等级：

* 0 默认，没有服务端（server）跟踪
* 1 跟踪服务端（server）的添加、移除
* 2 像1，但更复杂，包括服务端（server）的激活和非激活，属性更新，和更多的诊断信息
* 3 像2，但更复杂，包括服务端（server）过渡状态改变

###### <span id="IceGrid.Node.UserAccountMapper">IceGrid.Node.UserAccountMapper</span>，格式：
	IceGrid.Node.UserAccountMapper=proxy
定义一个实现IceGrid::UserAccountMapper接口的对象的代理（proxy），用于指定用户帐号在服务端（server）下启动。IceGrid节点唤起该代理来映射会话标志和用户帐号。
作为代理属性，您可以使用属性配置代理的其他方面。

###### <span id="IceGrid.Node.UserAccounts">IceGrid.Node.UserAccounts</span>，格式：
	IceGrid.Node.UserAccounts=file
指定IceGrid节点用户帐户映射文件的文件名。每行必须包含文件的标识符和一个用户帐户，由空格分隔。该标识符将与客户端（client）会话标识符匹配。此用户帐户映射文件是使用该节点将会话标识符映射到用户帐户。如果IceGrid.Node.UserAccountMapper定义，则该属性会被忽略。

###### <span id="IceGrid.Node.WaitTime">IceGrid.Node.WaitTime</span>，格式：
	IceGrid.Node.WaitTime=num
定义IceGrid等待服务端（server）激活和失活的周期，单位秒。如果一个服务端（server）被自动激活，并没有在这个时间间隔内注册它的对象适配器端点（endpoint），节点假定服务端（server）存在问题并返回一个空的端点（endpoint）给客户端（client）。如果在这一时间间隔内，服务端（server）正在优雅地关闭，且IceGrid没有发现服务端（server）失活，IceGrid会杀掉服务端（server）。默认值是60秒。

###### <span id="IceGrid.Registry.AdminCryptPasswords">IceGrid.Registry.AdminCryptPasswords</span>，格式：
	IceGrid.Registry.AdminCryptPasswords=file
指定管理客户端（client）的IceGrid注册表访问控制列表的文件名。文件中的每一行必须包含一个用户名和一个密码，用空格隔开。密码必须是MCF编码的字符串。如果没有定义，默认是admin-passwords。如果[IceGrid.Registry.AdminPermissionsVerifier](#IceGrid.Registry.AdminPermissionsVerifier)定义，该属性会被忽略。

###### <span id="IceGrid.Registry.AdminPermissionsVerifier">IceGrid.Registry.AdminPermissionsVerifier</span>，格式：
	IceGrid.Registry.AdminPermissionsVerifier=proxy
定义一个实现Glacier2::PermissionsVerifier接口的对象的代理（proxy），用于访问IceGrid的管理会话。IceGrid注册表调用此代理以验证每一个新的客户端（client）通过IceGrid::Registry接口创建的管理会话。
作为代理属性，您可以使用属性配置代理的其他方面。

###### <span id="IceGrid.Registry.AdminSessionFilters">IceGrid.Registry.AdminSessionFilters</span>，格式：
	IceGrid.Registry.AdminSessionFilters=num
此属性控制IceGrid是否为IceGrid会话管理器创建会话时建立过滤器。如果num大于0，IceGrid建立它们的过滤器，所以Glacier2限制访问通过getAdmin操作返回的IceGrid::AdminSession对象和IceGrid::Admin对象。如果num为0，IceGrid不建立过滤器，所以访问这些对象是由glacier2配置独立控制。默认是1。

###### <span id="IceGrid.Registry.AdminSessionManager.AdapterProperty">IceGrid.Registry.AdminSessionManager.AdapterProperty</span>，格式：
	IceGrid.Registry.AdminSessionManager.AdapterProperty=value
IceGrid注册表使用名为IceGrid.Registry.AdminSessionManager的是适配器，用于对象适配器处理来自IceGrid管理会话的输入请求。因此，适配器属性可用于配置该适配器。出于安全原因，该对象适配器的定义端点（endpoint）是可选的。如果你定义的端点（endpoint），他们只能访问Glacier2路由器用于创建IceGrid管理会议。

###### <span id="IceGrid.Registry.AdminSSLPermissionsVerifier">IceGrid.Registry.AdminSSLPermissionsVerifier</span>，格式：
	IceGrid.Registry.AdminSSLPermissionsVerifier=proxy
定义一个实现Glacier2::SSLPermissionsVerifier接口的对象的代理（proxy），用于访问IceGrid的管理会话。IceGrid注册表调用此代理以验证客户端通过IceGrid::Registry接口创建安全连接中创建的每一个新的管理会话。
作为代理属性，您可以使用属性配置代理的其他方面。

###### <span id="IceGrid.Registry.Client.AdapterProperty">IceGrid.Registry.Client.AdapterProperty</span>，格式：
	IceGrid.Registry.Client.AdapterProperty=value
IceGrid使用名为IceGrid.Registry.Client的适配器，用于对象适配器处理来自客户端（client）的输入请求。因此，适配器属性可用于配置该适配器。注意，IceGrid.Registry.Client.Endpoints控制注册表的客户端端点（endpoint）。端口4061（TCP）和4062（SSL）是专为通过互联网数字分配机构（IANA）注册表。

###### <span id="IceGrid.Registry.CryptPasswords">IceGrid.Registry.CryptPasswords</span>，格式：
	IceGrid.Registry.CryptPasswords=file
指定IceGrid注册表访问控制列表的文件。文件中的每一行必须包含一个用户名和一个密码，用空格隔开。密码必须是使用MCF编码的字符串。默认是passwords。如果[IceGrid.Registry.PermissionsVerifier](#IceGrid.Registry.PermissionsVerifier)定义，该属性将会被忽略。

###### <span id="IceGrid.Registry.Data">IceGrid.Registry.Data</span>，格式：
	IceGrid.Registry.Data=path
定义IceGrid注册表数据目录路径。路径中指定的目录必须已存在。

###### <span id="IceGrid.Registry.DefaultTemplates">IceGrid.Registry.DefaultTemplates</span>，格式：
	IceGrid.Registry.DefaultTemplates=path
定义包含默认模板描述符的XML路径名。在Ice分布里，一个样本文件命名为config/templates.xml包含服务端模板，方便为Ice提供服务。

###### <span id="IceGrid.Registry.Discovery.AdapterProperty">IceGrid.Registry.Discovery.AdapterProperty</span>，格式：
	IceGrid.Registry.Discovery.AdapterProperty=value
IceGrid注册表创建一个名为IceGrid.Registry.Discovery的对象适配器，用于接收来自客户端（client）的组播发现请求。如果[IceGrid.Registry.Discovery.Endpoints](#IceGrid.Registry.Discovery.Endpoints)没有其他的定义，此对象适配器的端点（endpoint）构成如下：

	udp -h addr -p port [--interface intf]
addr是IceGrid.Registry.Discovery.Address的值，port是IceGrid.Registry.Discovery.Port的值，intf是IceGrid.Registry.Discovery.Interface的值。
通常不需要为该对象适配器设置其他属性。

###### <span id="IceGrid.Registry.Discovery.Address">IceGrid.Registry.Discovery.Address</span>，格式：
	IceGrid.Registry.Discovery.Address=addr
指定用于接收组播发现查询的组播IP地址。如果没有定义，依赖于Ice.IPv4的设定。如果启动（默认），IceDiscovery使用239.255.0.1地址，其他情况下，IceDiscovery假定应用想使用IPv6并用ff15::1地址替代。此属性是用来撰写的IceGrid.Registry.Discovery对象适配器的端点（endpoint）。

###### <span id="IceGrid.Registry.Discovery.Enabled">IceGrid.Registry.Discovery.Enabled</span>，格式：
	IceDiscovery.Enabled=num
如果num大于0，注册表创建IceGrid.Registry.Discovery对象适配器并监听组播发现查询。默认是1，设为0则关闭组播发现。

###### <span id="IceGrid.Registry.Discovery.Interface">IceGrid.Registry.Discovery.Interface</span>，格式：
	IceGrid.Registry.Discovery.Interface=intf
指定IP地址接口，用于接收组播发现查询。如果没有指定，操作系统会选择默认接口来发送和接收UDP组播数据包。此属性是用来撰写的IceGrid.Registry.Discovery对象适配器的端点（endpoint）。

###### <span id="IceGrid.Registry.Discovery.Port">IceGrid.Registry.Discovery.Port</span>，格式：
	IceGrid.Registry.Discovery.Port=port
指定组播端口，用于接收组播发现查询。默认是4061。此属性是用来撰写的IceGrid.Registry.Discovery对象适配器的端点（endpoint）。

###### <span id="IceGrid.Registry.DynamicRegistration">IceGrid.Registry.DynamicRegistration</span>，格式：
	IceGrid.Registry.DynamicRegistration=num
如果num大于0，定位注册表不请求Ice服务端（server）预先注册对象适配器和副本群，但如果他们不存在，反而会自动创建它们。如果没有定义或num是0，试图注册一个未知对象适配器或副本群适配器激活会因Ice.NotRegisteredException而失败。当adapter.AdapterId属性定义时，对象适配器注册它自己。adapter.ReplicaGroupId属性标识的副本群。

###### <span id="IceGrid.Registry.Internal.AdapterProperty">IceGrid.Registry.Internal.AdapterProperty</span>，格式：
	IceGrid.Registry.Internal.AdapterProperty=value
IceGrid注册表使用名为IceGrid.Registry.Internal的适配器，用于对象适配器处理来自节点和从副本输入请求。因此，适配器属性可用于配置该适配器。

###### <span id="IceGrid.Registry.NodeSessionTimeout">IceGrid.Registry.NodeSessionTimeout</span>，格式：
	IceGrid.Registry.NodeSessionTimeout=num
每一个IceGrid节点建立一个与注册表必须定期更新的会话。如果一个节点在num秒内没有刷新会话，节点的会话会被销毁和部署在该节点上的服务端对新的客户端不可用。默认是30秒。

###### <span id="IceGrid.Registry.PermissionsVerifier">IceGrid.Registry.PermissionsVerifier</span>，格式：
	IceGrid.Registry.PermissionsVerifier=proxy
定义一个实现Glacier2::PermissionsVerifier接口的对象的代理（proxy），用于控制访问IceGrid会话。IceGrid注册表调用此代理以验证客户端通过IceGrid::Registry接口创建的每个新客户会话。
作为代理属性，您可以使用属性配置代理的其他方面。

###### <span id="IceGrid.Registry.ReplicaName">IceGrid.Registry.ReplicaName</span>，格式：
	IceGrid.Registry.ReplicaName=name
注册表副本名称。如果没有定义，默认值是Master，这是主副本保留的名称。每个注册表副本必须有一个唯一的名称。

###### <span id="IceGrid.Registry.ReplicaSessionTimeout">IceGrid.Registry.ReplicaSessionTimeout</span>，格式：
	IceGrid.Registry.ReplicaSessionTimeout=num
每一个IceGrid注册表副本建立一个与主注册表必须定期更新的会话。如果一个副本在num秒内不刷新会话，副本的会话被摧毁，副本不再从主注册表接收复制信息。如果没有指定，默认值是30秒。

###### <span id="IceGrid.Registry.Server.AdapterProperty">IceGrid.Registry.Server.AdapterProperty</span>，格式：
	IceGrid.Registry.Server.AdapterProperty=value
IceGrid注册表使用名为IceGrid.Registry.Server的适配器，用于对象适配器处理来自服务端的输入请求。因此，适配器属性可用于配置该适配器。

###### <span id="IceGrid.Registry.SessionFilters">IceGrid.Registry.SessionFilters</span>，格式：
	IceGrid.Registry.SessionFilters=num
该属性控制IceGrid是否为创建与IceGrid会话管理器的会话建立过滤器。如果num大于0，IceGrid建立它们的过滤器，所以Glacier2限制访问IceGrid::Query和IceGrid::Session对象，和对象适配器的会话分配。如果num是0，IceGrid不创建过滤器，所以，对象的访问是通过Glacier2配置独立控制。默认是0。

###### <span id="IceGrid.Registry.SessionManager.AdapterProperty">IceGrid.Registry.SessionManager.AdapterProperty</span>，格式：
	IceGrid.Registry.SessionManager.AdapterProperty=value
IceGrid注册表使用名为IceGrid.Registry.SessionManager的适配器，用于对象适配器处理来自客户端（client）会话的输入请求。因此，适配器属性可用于配置该适配器。
出于安全原因，该对象适配器的定义端点（endpoint）是可选的。如果你定义的端点（endpoint），他们只能访问Glacier2路由器用于创建IceGrid客户端会话。

###### <span id="IceGrid.Registry.SessionTimeout">IceGrid.Registry.SessionTimeout</span>，格式：
	IceGrid.Registry.SessionTimeout=num
IceGrid客户端或管理客户端也许通过注册表建立会话。该会话必须定期刷新。如果客户端在num秒内没有刷新会话，会话会被销毁。默认是30秒。

###### <span id="IceGrid.Registry.SSLPermissionsVerifier">IceGrid.Registry.SSLPermissionsVerifier</span>，格式：
	IceGrid.Registry.SSLPermissionsVerifier=proxy
定义一个实现Glacier2::SSLPermissionsVerifier接口的对象的代理（proxy），用于控制访问IceGrid会话。IceGrid注册表调用此代理以验证客户端通过IceGrid::Registry接口创建安全连接中创建的每个新客户会话。
作为代理属性，您可以使用属性配置代理的其他方面。

###### <span id="IceGrid.Registry.Trace.Adapter">IceGrid.Registry.Trace.Adapter</span>，格式：
	IceGrid.Registry.Trace.Adapter=num
对象适配器跟踪等级：

* 0 默认，没有对象适配器跟踪
* 1 对象适配器注册、移除和自我复制

###### <span id="IceGrid.Registry.Trace.Application">IceGrid.Registry.Trace.Application</span>，格式：
	IceGrid.Registry.Trace.Application=num
应用跟踪等级：

* 0 默认，没有应用跟踪
* 1 对象适配器添加、更新和移除

###### <span id="IceGrid.Registry.Trace.Locator">IceGrid.Registry.Trace.Locator</span>，格式：
	IceGrid.Registry.Trace.Locator=num
定位和定位注册表跟踪等级：

* 0 默认，没有定位跟踪
* 1 跟踪定位失败的适配器和对象，和失败的注册去、适配器、端点（endpoint）
* 2 像1，当更详细，包括注册失败的适配器端点（endpoint）

###### <span id="IceGrid.Registry.Trace.Node">IceGrid.Registry.Trace.Node</span>，格式：
	IceGrid.Registry.Trace.Node=num
节点跟踪等级：

* 0 默认，没有节点跟踪
* 1 跟踪节点的注册、移除
* 2 像1，当更详细，包括加载统计数据
 
###### <span id="IceGrid.Registry.Trace.Object">IceGrid.Registry.Trace.Object</span>，格式：
	IceGrid.Registry.Trace.Object=num
对象跟踪等级：

* 0 默认，没有对象跟踪
* 1 跟踪节点的注册、移除
 
###### <span id="IceGrid.Registry.Trace.Patch">IceGrid.Registry.Trace.Patch</span>，格式：
	IceGrid.Registry.Trace.Patch=num
碎片跟踪等级：

* 0 默认，没有碎片跟踪
* 1 显示碎片进展的概要

###### <span id="IceGrid.Registry.Trace.Server">IceGrid.Registry.Trace.Server</span>，格式：
	IceGrid.Registry.Trace.Server=num
服务端跟踪等级：

* 0 默认，没有服务端跟踪
* 1 跟踪在注册表数据库里添加和移除的服务端

###### <span id="IceGrid.Registry.Trace.Session">IceGrid.Registry.Trace.Session</span>，格式：
	IceGrid.Registry.Trace.Session=num
会话跟踪等级：

* 0 默认，没有客户端或服务端会话跟踪
* 1 跟踪客户端或服务端会话的添加、移除
* 2 像1，但更详细，包括保持活着的消息

###### <span id="IceGrid.Registry.UserAccounts">IceGrid.Registry.UserAccounts</span>，格式：
	IceGrid.Registry.UserAccounts=file
指定一个IceGrid注册用户帐户映射文件的文件名。文件中的每一行必须包含一个标识符和一个用户帐户，由空格分隔。该标识符将与客户端会话标识符匹配。如果节点的[IceGrid.Node.UserAccountMapper](#IceGrid.Node.UserAccountMapper)属性设置为IceGrid/RegistryUserAccountMapper代理，此用户帐户映射文件使用IceGrid节点将会话标识符映射到用户帐户。

---
[返回目录](#目录)
## <span id="IceGridAdmin">IceGridAdmin</span>
###### <span id="IceGridAdmin.AuthenticateUsingSSL">IceGridAdmin.AuthenticateUsingSSL</span>，格式：
	IceGridAdmin.AuthenticateUsingSSL=num
如果num大于0，当建立与IceGrid注册表会话时，icegridadmin使用SSL认证。如果没有设定或为0时，icegridadmin使用用户名和密码认证。

###### <span id="IceGridAdmin.Discovery.Address">IceGridAdmin.Discovery.Address</span>，格式：
	IceGridAdmin.Discovery.Address=addr
指定组播IP地址用于发送组播发现查询。如果没有定义，默认依赖于Ice.IPv4点设置，如果启动（默认），客户端使用239.255.0.1地址，其他情况下，客户端假定使用IPv6并且使用ff15::1地址替代。这个属性是用来构成IceGridAdmin.Discovery.Lookup价值。

###### <span id="IceGridAdmin.Discovery.Interface">IceGridAdmin.Discovery.Interface</span>，格式：
	IceGridAdmin.Discovery.Interface=intf
指定IP地址接口用于发送组播发现查询。如果没有定义，系统会选择一个默认的接口发送UDP数据包。这个属性是用来构成IceGridAdmin.Discovery.Lookup价值。

###### <span id="IceGridAdmin.Discovery.Lookup">IceGridAdmin.Discovery.Lookup</span>，格式：
	IceGridAdmin.Discovery.Lookup=endpoint
指定客户端发送组播发现查询的端点（endpoint）。如果没有设定，端点（endpoint）由以下组成：

	udp -h addr -p port [--interface intf]
addr是IceGridAdmin.Discovery.Address的值，port是IceGridAdmin.Port的值，intf是IceGridAdmin.Discovery.Interface的值。

###### <span id="IceGridAdmin.Discovery.Reply.AdapterProperty">IceGridAdmin.Discovery.Reply.AdapterProperty</span>，格式：
	IceGridAdmin.Discovery.Reply.AdapterProperty=value
客户端创建一个名为IceGridAdmin.Discovery.Reply对象适配器，用于接收回复的组播发现查询。如果没有定义的[IceGridAdmin.Discovery.Reply.Endpoints](#IceGridAdmin.Discovery.Reply.Endpoints)，此对象适配器的端点构成如下：

	udp [--interface intf]
intf是IceGridAdmin.Discovery.Interface的值。此端点不需要一个固定端口。
通常不需要为该对象适配器设置其他属性。

###### <span id="IceGridAdmin.Host">IceGridAdmin.Host</span>，格式：
	IceGridAdmin.Host=host
当同时使用IceGridAdmin.Port，icegridadmin直接连接到指定主机和端口的目标注册表。

###### <span id="IceGridAdmin.InstanceName">IceGridAdmin.InstanceName</span>，格式：
	IceGridAdmin.InstanceName=name
当icegridadmin将要连接时，指定一个IceGrid实例的名称。

###### <span id="IceGridAdmin.Password">IceGridAdmin.Password</span>，格式：
	IceGridAdmin.Password=password
当与IceGrid注册的会话需要认证时，指定icegridadmin的认证密码。安全的原因，你可能不喜欢在一个纯文本的配置属性定义一个密码，在这种情况下你应该忽略此属性允许icegridadmin提示交互。当IceGridAdmin.AuthenticateUsingSSL来启动使用SSL认证时，该属性会被忽略。

###### <span id="IceGridAdmin.Port">IceGridAdmin.Port</span>，格式：
	IceGridAdmin.Port=port
当同时使用IceGridAdmin.Host，icegridadmin直接连接到指定主机和端口的目标注册表。当使用多播发现时，此属性指定用于发送多播发现查询的端口。这个属性是用来构成IceGridAdmin.Discovery.Lookup价值。默认是4061。

###### <span id="IceGridAdmin.Replica">IceGridAdmin.Replica</span>，格式：
	IceGridAdmin.Replica=name
指定icegridadmin应该接触的注册表副本的名称。默认是Master。

###### <span id="IceGridAdmin.Trace.Observers">IceGridAdmin.Trace.Observers</span>，格式：
	IceGridAdmin.Trace.Observers=num
如果num大于0，IceGrid图形管理客户端显示观察回调它接收从注册表跟踪信息。默认是0。

###### <span id="IceGridAdmin.Trace.SaveToRegistry">IceGridAdmin.Trace.SaveToRegistry</span>，格式：
	IceGridAdmin.Trace.SaveToRegistry=num
如果num大于0，IceGrid图形管理客户端显示跟踪信息的修改提交到注册表。默认是0。

###### <span id="IceGridAdmin.Username">IceGridAdmin.Username</span>，格式：
	IceGridAdmin.Username=name
当与IceGrid注册表会话认真时，icegridadmin应该使用指定名称。当[IceGridAdmin.AuthenticateUsingSSL](#IceGridAdmin.AuthenticateUsingSSL)来启动使用SSL认证时，该属性会被忽略。

---
[返回目录](#目录)
## <span id="IceLocatorDiscovery">IceLocatorDiscovery</span>
###### <span id="IceLocatorDiscovery.Address">IceLocatorDiscovery.Address</span>，格式：
	IceLocatorDiscovery.Address=addr
指定组播IP地址，用于发送组播查询。如果没有设定，默认值依赖于其他属性设置：

* 如果Ice.PreferIPv6Address开启，或Ice.IPv4关闭，IceLocatorDiscovery使用IPv6的ff15::1地址
* 其他情况IceLocatorDiscovery使用239.255.0.1

###### <span id="IceLocatorDiscovery.InstanceName">IceLocatorDiscovery.InstanceName</span>，格式：
	IceLocatorDiscovery.InstanceName=name
指定定位器实例名称。如果你已部署有多个不相关的使用一样的组播地址和端口的定位器，你可以定义该属性来限制你的搜索那些给定已部署的定位器实例结果范围。如果未定义，该插件通过第一个定位器的实例名称来响应查询；如果随后的查询发现具有不同实例名称的定位器，该插件会记录一个消息并忽略该结果。

###### <span id="IceLocatorDiscovery.Interface">IceLocatorDiscovery.Interface</span>，格式：
	IceLocatorDiscovery.Interface=intf
指定接口的IP地址，用于发送组播查询。如果没有定义，系统会选用一个默认的接口发送UDP数据包。

###### <span id="IceLocatorDiscovery.Locator.AdapterProperty">IceLocatorDiscovery.Locator.AdapterProperty</span>，格式：
	IceLocatorDiscovery.Locator.AdapterProperty=value
IceLocatorDiscovery创建一个名为IceLocatorDiscovery.Locator的对象适配器，因此，所有的对象适配器属性可以被设置。
通常不需要为该对象适配器设置属性。

###### <span id="IceLocatorDiscovery.Lookup">IceLocatorDiscovery.Lookup</span>，格式：
	IceLocatorDiscovery.Lookup=endpoint
指定组播端点（endpoint），客户端用来发送发现查询。如果没有定义，端点是由如下：

	udp -h addr -p port --interface intf
addr是IceLocatorDiscovery.Address的值，port是IceLocatorDiscovery.Port的值，intf是IceLocatorDiscovery.Interface的值。

###### <span id="IceLocatorDiscovery.Port">IceLocatorDiscovery.Port</span>，格式：
	IceLocatorDiscovery.Port=port
指定组播端口，用来发送组播查询。如果没有定义，默认是4061。

###### <span id="IceLocatorDiscovery.Reply.AdapterProperty">IceLocatorDiscovery.Reply.AdapterProperty</span>，格式：
	IceLocatorDiscovery.Reply.AdapterProperty=value
IceLocatorDiscovery创建名为IceLocatorDiscovery.Reply的对象适配器，用于接收回复的组播发现查询。如果[IceLocatorDiscovery.Reply.Endpoints](#IceLocatorDiscovery.Reply.Endpoints)没有定义，此对象适配器的端点构成如下：

	udp --interface intf
intf是IceLocatorDiscovery.Interface的值。
此端点不需要一个固定端口。
通常不需要为该对象适配器设置其他属性。

###### <span id="IceLocatorDiscovery.RetryCount">IceLocatorDiscovery.RetryCount</span>，格式：
	IceLocatorDiscovery.RetryCount=num
指定插件重新发送UDP组播查询的最大次数。如果没有定义，默认是4061。IceLocatorDiscovery.Timeout属性指明插件等待多久重发。默认值是3。

###### <span id="IceLocatorDiscovery.RetryDelay">IceLocatorDiscovery.RetryDelay</span>，格式：
	IceLocatorDiscovery.RetryDelay=num
如果插件没有收到任何回应后重新发送IceLocatorDiscovery.RetryCount指定的次数，在开始新一轮的查询之前插件至少等num毫秒。如果没有定义，默认值是2000。

###### <span id="IceLocatorDiscovery.Timeout">IceLocatorDiscovery.Timeout</span>，格式：
	IceLocatorDiscovery.Timeout=num
指定的时间间隔，以毫秒为单位等待UDP组播查询回复。如果服务端在这个周期内没有回复，客户端会根据IceLocatorDiscovery.RetryCount指定的次数重新发送请求。默认值是300。

---
[返回目录](#目录)
## <span id="IceMX.Metrics">IceMX.Metrics</span>
###### <span id="IceMX.Metrics.view.Accept.attribute">IceMX.Metrics.view.Accept.attribute</span>，格式：
	IceMX.Metrics.view.Accept.attribute=regexp
这个属性定义了一个规则，接受一个检测对象或基于它的一个属性值的操作的监控。如果属性符合指定的正则表达式，并且如果它满足其他接受（Accept）和拒绝（Reject）的过滤器检测对象或操作将被监控。
例如，接受监测仪表的操作对象或从名为"MyAdapter"的对象适配器，你可以设置以下接受权限：

	IceMX.Metrics.MyView.Accept.parent=MyAdapter

###### <span id="IceMX.Metrics.view.Disabled">IceMX.Metrics.view.Disabled</span>，格式：
	IceMX.Metrics.view.Disabled=num
如果num大于0，标准视图或映射被禁用。此属性对于预设视图或映射是非常有用的。视图最初可以被禁止，不会引起开销并且当需要运行时可以启动。

###### <span id="IceMX.Metrics.view.GroupBy">IceMX.Metrics.view.GroupBy</span>，格式：
	IceMX.Metrics.view.GroupBy=delimited attributes
该属性定义了如何分组，以及如何创建每个度量对象的ID。分组是基于特定的属性的仪表对象或操作。例如，您可以通过操作名称或代理身份来调用度量组。所有具有相同的操作名称或代理身份的调用会使用相同的度量对象记录度量。您可以在多个属性的基础上指定几个属性。当指定GroupBy属性的值时你必须划定属性定界符。一个分隔符字符不是一个数字或字符。可用于指定此属性的值的属性在Ice手册的相关节中被定义。这里有一些例子GroupBy属性。

* IceMX.Metrics.MyView.GroupBy=operation
* IceMX.Metrics.MyView.GroupBy=identity [operation]
* IceMX.Metrics.MyView.GroupBy=remoteHost:remotePort

###### <span id="IceMX.Metrics.view.Reject.attribute">IceMX.Metrics.view.Reject.attribute</span>，格式：
	IceMX.Metrics.view.Reject.attribute=regexp
这个属性定义了一个规则，接受一个检测对象或基于它的一个属性的值操作的监控。如果属性符合指定的正则表达式，并且如果它满足其他接受（Accept）和拒绝（Reject）的过滤器检测对象或操作将被监控。例如，拒绝监视仪表或操作命名为"Ice.Admin"的对象适配器，您可以设置下列拒绝属性：

* IceMX.Metrics.MyView.Reject.parent=Ice\.Admin

###### <span id="IceMX.Metrics.view.RetainDetached">IceMX.Metrics.view.RetainDetached</span>，格式：
	IceMX.Metrics.view.RetainedDetached=num
如果num大于0，将num个当前值为0的度量对象通过度量映射保存在内存中。如果一个固定物体或操作创建一个唯一的度量对象，最后只有num个度量对象被保存在内存中，这有效地防止不明确的内存增长。默认值是10，这意味着最多10个当前值为0的度量对象通过度量映射被保留。

---
[返回目录](#目录)
## <span id="IcePatch2">IcePatch2</span>
###### <span id="IcePatch2.AdapterProperty">IcePatch2.AdapterProperty</span>，格式：
	IcePatch2.AdapterProperty=value
IcePatch2为服务端使用名为IcePatch2的适配器。因此，适配器属性可用于配置该适配器。

###### <span id="IcePatch2.Directory">IcePatch2.Directory</span>，格式：
	IcePatch2.Directory=dir
如果没有数据目录在命令行中指定，IcePatch2服务端使用这属性确定数据。在属性也被用于IcePatch2客户端指定本地数据目录。

###### <span id="IcePatch2.InstanceName">IcePatch2.InstanceName</span>，格式：
	IcePatch2.InstanceName=name
为已知的IcePatch2对象指定身份种类。如果定义，IcePatch2::Admin接口的身份变为name/admin和IcePatch2::FileServer接口的身份变为name/server。默认值是IcePatch2。

---
[返回目录](#目录)
## <span id="IcePatch2Client">IcePatch2Client</span>
###### <span id="IcePatch2Client.ChunkSize">IcePatch2Client.ChunkSize</span>，格式：
	IcePatch2Client.ChunkSize=kilobytes
IcePatch2客户端使用该属性确定每次调用getFileCompressed取回多少KB。默认是100。

###### <span id="IcePatch2Client.Directory">IcePatch2Client.Directory</span>，格式：
	IcePatch2Client.Directory=dir
IcePatch2客户端使用这个属性确定本地数据目录。

###### <span id="IcePatch2Client.Proxy">IcePatch2Client.Proxy</span>，格式：
	IcePatch2Client.Proxy=proxy
IcePatch2客户端使用该属性来定位IcePatch2服务端。

###### <span id="IcePatch2Client.Remove">IcePatch2Client.Remove</span>，格式：
	IcePatch2Client.Remove=num
这个属性确定IcePatch2客户端是否删除本地存在而服务端没有的文件。num是0或负数不删除文件。num是1，删除文件并且报出如果删除一个文件失败而导致客户端停止的原因。num是2或更大也开启删除文件，但使客户端在删除过程中忽略错误。默认是1。

###### <span id="IcePatch2Client.Thorough">IcePatch2Client.Thorough</span>，格式：
	IcePatch2Client.Thorough=num
该属性指定IcePatch2客户端是否重新计算校验和。任何大于0的都当是true。默认是0（false）。

---
[返回目录](#目录)
## <span id="IceSSL">IceSSL</span>
#### IceSSL Property Overview
IceSSL使用许多相同的配置属性实现我们支持的平台。然而，有一些特定的平台或语言的属性。一些属性的象征，如果必要我们列出了支持的平台或底层SSL库的简介和提供额外的特定于平台的笔记。你会看到下面的平台，语言和SSL库的性能参考表：

* SChannel (C++ on Windows)
* SecureTransport (C++ on OS X)
* OpenSSL (C++ on Linux)
* Java
* .NET
* iOS

如果没有任何限制，则所有平台都支持一个属性。
最后，请注意，Objective-C、Python、Ruby、PHP、C++使用IceSSL，因此他们为目标平台选择合适的IceSSL的SChannel，SecureTransport或OpenSSL属性。

###### <span id="IceSSL.Alias">IceSSL.Alias</span>，格式：
	IceSSL.Alias=alias (Java)
从[IceSSL.Keystore](#IceSSL.Keystore)指定的密匙存储中选择一个特别的证书。在认证过程中，由alias标识的证书被提交到对等请求中。

###### <span id="IceSSL.CAs">IceSSL.CAs</span>，格式：
	IceSSL.CAs=path (SChannel, SecureTransport, OpenSSL, .NET, iOS)
指定含有可信任证书颁发机构证书(CAs)的文件或目录的路径名。如果您希望使用与您的平台捆绑的认证证书，不设置该属性并启动[IceSSL.UsePlatformCAs](#IceSSL.UsePlatformCAs)。
###### 平台提醒
###### SChannel, SecureTransport, .NET
证书可以使用DER或PEM格式的编码。
IceSSL试图定位到上述的path。如果给定的相对路径不存在，IceSSL也试图定位到path相对的通过[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录。
###### OpenSSL
文件必须使用PEM格式编码。如果path是一个目录，该目录必须使用OpenSSL的c_rehash工具预先准备好。
IceSSL试图定位到上述的path。如果给定的相对路径不存在，IceSSL也试图定位到path相对的通过[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录。
###### iOS
证书必须使用DER格式的编码。
如果[IceSSL.DefaultDir](#IceSSL.DefaultDir)也定义，在应用程序资源bundle和在文件系统为DefaultDir/path，IceSSL试图打开指定的Resources/DefaultDir/path的CA证书文件。
如果[IceSSL.DefaultDir](#IceSSL.DefaultDir)未定义，在应用程序资源bundle和在文件系统为path，IceSSL试图打开指定的Resources/path的CA证书文件。
如果该属性没有定义，IceSSL在用户的钥匙链和系统的钥匙链查找合适的CA证书。
###### Java
查看[IceSSL.Truststore](#IceSSL.Truststore)

###### <span id="IceSSL.CertFile">IceSSL.CertFile</span>，格式：
	IceSSL.CertFile=file (SecureTransport, .NET, iOS)
	IceSSL.CertFile=file[;file] (SChannel)
	IceSSL.CertFile=file[:file] (OpenSSL)
指定包含程序的证书和相应的私钥的文件。文件名可以指定相对于定义的[IceSSL.DefaultDir](#IceSSL.DefaultDir)默认目录。
###### 平台提醒
###### SChannel
文件必须使用PFX(PKCS#12)格式并且包含私钥的证书。如果需要一个密码来加载该文件，应用程序必须安装一个密码处理程序或使用[IceSSL.Password](#IceSSL.Password)提供密码，否则IceSSL将拒绝证书。
这个属性接受RSA和DSA证书。要指定两个证书，使用平台的路径字符分隔器分隔文件名。
IceSSL试图找到指定的文件。如果给定的路径是相对的且不存在，IceSSL也试图定位到path相对的通过[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录。
###### SecureTransport
文件必须使用PFX(PKCS#12)格式并且包含私钥的证书。如果需要一个密码来加载该文件，OS X将使用其默认的图形密码的提示，除非应用程序安装了一个密码处理程序或使用[IceSSL.Password](#IceSSL.Password)提供密码。
###### OpenSSL
文件必须使用PFX(PKCS#12)格式并且包含私钥的证书。如果需要一个密码来加载该文件，OpenSSL会提示在终端用户除非应用安装了一个密码处理程序或使用[IceSSL.Password](#IceSSL.Password)提供密码。
这个属性接受RSA和DSA证书。要指定两个证书，使用平台的路径字符分隔器分隔文件名。
IceSSL试图找到指定的文件。如果给定的路径是相对的且不存在，IceSSL也试图定位到path相对的通过[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录。
###### .NET
文件必须使用PFX(PKCS#12)格式并且包含私钥的证书。必须使用[IceSSL.Password](#IceSSL.Password)提供密码来加载文件。
IceSSL试图找到指定的文件。如果给定的路径是相对的且不存在，IceSSL也试图定位到path相对的通过[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录。
###### iOS
文件必须使用PFX(PKCS#12)格式并且包含私钥的证书。必须使用[IceSSL.Password](#IceSSL.Password)提供密码来加载文件。证书通过[IceSSL.Keychain](#IceSSL.Keychain)属性导入到钥匙链识别。
如果[IceSSL.DefaultDir](#IceSSL.DefaultDir)未定义，在应用程序资源bundle和在文件系统为path，IceSSL试图打开指定的Resources/path的CA证书文件。
如果该属性没有定义，IceSSL在用户的钥匙链和系统的钥匙链查找合适的CA证书。
###### Java
查看[IceSSL.Keystore](#IceSSL.Keystore)。

###### <span id="IceSSL.CertStore">IceSSL.CertStore</span>，格式：
	IceSSL.CertStore=name (SChannel, .NET)
指定证书存储区的名称，用于当经过IceSSL.FindCert时定位证书。name的合法值包含有AddressBook，AuthRoot，CertificateAuthority，Disallowed，My，Root，TrustedPeople和TrustedPublisher。你还可以使用任意值来命名。默认是My。

###### <span id="IceSSL.CertStoreLocation">IceSSL.CertStoreLocation</span>，格式：
	IceSSL.CertStoreLocation=CurrentUser|LocalMachine (SChannel, .NET)
指定书存储区的位置，用于当经过[IceSSL.FindCert](#IceSSL.FindCert)时定位证书。默认是CurrentUser。Ice程序运行为Windows服务通常需要将此属性设置为LocalMachine。

###### <span id="IceSSL.CertVerifier">IceSSL.CertVerifier</span>，格式：
	IceSSL.CertVerifier=classname (Java, .NET)
指定实现IceSSL.CertificateVerifier接口的Java或.NET的类名称来执行应用程序定义的证书验证。
###### 平台提醒
###### SChannel, SecureTransport, OpenSSL
C++应用程序可以安装证书验证程序。

###### <span id="IceSSL.CheckCertName">IceSSL.CheckCertName</span>，格式：
	IceSSL.CheckCertName=num
如果num大于0，IceSSL试图匹配服务器的主机名作为代理端点（endpoint）对服务器证书的主题名称通用名称指定的组件。如果没有匹配，IceSSL试图匹配主机名来反对DNS和IP地址域的服务器证书的主题备用名称。搜索不发出任何DNS查询，但简单地执行一个不区分大小写的字符串匹配。如果在代理端点（endpoint）中它的通用名称或其任何DNS或IP地址匹配主机名，服务端的证书是接受的。IceSSL 跳过这个验证步骤，如果服务器不提供证书，或者如果代理端点（endpoint）不包括主机名和[Ice.Default.Host](#Ice.Default.Host)未定义。此属性对客户证书的服务器验证无影响。如果没有发现匹配，IceSSL中止尝试连接并引发一个异常。默认值是0。

###### <span id="IceSSL.CheckCRL">IceSSL.CheckCRL</span>，格式：
	IceSSL.CheckCRL=num (.NET)
如果num大于0，如果对等端的证书已被吊销，IceSSL通过检查证书吊销列表（CRL）来确定。num决定价值产生的行为：

* 0 关闭CRL检测
* 1 如果证书被吊销，IceSSL终止连接，记录信息并引发异常。如果证书的吊销状态是未知的，IceSSL记录信息但采用证书。
* 2 如果证书被吊销或吊销状态未知的，IceSSL终止连接，记录信息并引发异常。

[IceSSL.Trace.Security](#IceSSL.Trace.Security)属性必须设置为非0，来看到CRL相关日志消息的。[IceSSL.CheckCRL](#IceSSL.CheckCRL)的默认值是0。

###### <span id="IceSSL.Ciphers">IceSSL.Ciphers</span>，格式：
	IceSSL.Ciphers=ciphers (SChannel, SecureTransport, OpenSSL, Java)
指定的密码套件来IceSSL允许谈判。密码套件是一套算法，满足四个要求建立一个安全的连接：签名和认证，密钥交换，安全散列，和加密。一些算法满足多个要求，并且有很多可能的组合。
如果未指定，该插件使用安全供应商的默认密码套件。开启[IceSSL.Trace.Security](#IceSSL.Trace.Security)和仔细审查应用程序的日志输出，以确定默认情况下启用的加密套件，或验证您的密码套件配置。
###### 平台提醒
###### SChannel
此属性的值是一个空格分隔的列表可以包括下列任何：

* 3DES
* AES_128
* AES_256
* DES
* RC2
* RC4

例如，下面的设置使AES密码套件：IceSSL.Ciphers=AES_128 AES_256
###### SecureTransport
属性值被解释为空格分隔的标记列表。该插件在出现的顺序执行的顺序，以汇编的启用密码套件列表。下面的表格描述了标记：

* ALL 保留关键字，使所有支持的密码套件。如果指定了，它必须是列表中的第一个标记。使用谨慎，因为它可能使低安全性的密码套件。
* NONE 保留关键字，禁用所有的密码套件。如果指定了，它必须是列表中的第一个标记。使用没有一个开始与一个空的密码套件的设置，然后添加你想要的那些套房。
* NAME 包括其名称匹配NAME的密码套件。
* !NAME 不包括其名称匹配NAME的密码套件。
* (EXP) 包括所有的密码套件的名称包含给定的正则表达式的EXP
* !(EXP) 不包括所有的密码套件的名称包含给定的正则表达式的EXP

例如，下面的设置禁用所有密码套件除了支持256位AES加密：

	IceSSL.Ciphers=NONE (AES_256.*SHA256)
请注意，没有给出一个警告，如果一个未被识别的密码被指定。
###### OpenSSL
此属性的值是通过直接的OpenSSL库，支持密码列表取决于您的安装OpenSSL编译。你可以得到一个完整的支持的密码套件使用命令OpenSSL密码列表。这个命令很可能会产生一个长长的列表。为了简化选择过程，OpenSSL支持密码几类。类和密码可以通过前缀与一个感叹号除外。特殊关键词@STRENGTH分类他们的实力，以密码列表，使SSL优先选择更安全的密码进行谈判时的密码套件。@STRENGTH关键字必须是列表中的最后一个元素。类型是：

* ALL 启用所有支持的加密套件。这个类应该谨慎使用，因为它可能使低安全性的密码套件。
* ADH 匿名密码。
* LOW 低强度密码。
* EXP 出口限制密码。

这里是一个合理设置的例子：

	IceSSL.Ciphers=ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH
此值不包括密码低比特强度和已知问题，并命令其余密码根据自己的实力。请注意，没有给出一个警告，如果一个未被识别的密码被指定。
###### Java
属性值被解释为空格分隔的标记列表。该插件在出现的顺序执行的顺序，以汇编的启用密码套件列表。下面的表格描述了标记：

* ALL 保留关键字，使所有支持的密码套件。如果指定了，它必须是列表中的第一个标记。使用谨慎，因为它可能使低安全性的密码套件。
* NONE 保留关键字，禁用所有的密码套件。如果指定了，它必须是列表中的第一个标记。使用NONE一个开始与一个空的密码套件的设置，然后添加你想要的那些套房。
* NAME 启用密码套件匹配给定的名称。
* !NAME 禁用密码套件匹配给定的名称。
* (EXP) 使密码套件的名称包含正则表达式的EXP。例如，NONE (.*DH_anon.*AES.*)只选择的密码套件，使用匿名Diffie-Hellman认证与加密。
* !(EXP) 禁用密码套件的名称包含正则表达式的EXP。例如，ALL !(.*DH_anon.*AES.*)使除了那些使用匿名Diffie-Hellman认证与加密所有的密码套件。

###### <span id="IceSSL.DefaultDir">IceSSL.DefaultDir</span>，格式：
	IceSSL.DefaultDir=path
指定要查找证书、密钥存储和其他文件的默认目录。有关更多信息的相关属性的描述。

###### <span id="IceSSL.DH.bits">IceSSL.DH.bits</span>，格式：
	IceSSL.DH.bits=file (OpenSSL)
指定包含Diffie-Hellman密钥长度为位参数的文件，如下面的示例所示：

	IceSSL.DH.1024=dhparams1024.pem
如果没有指定用户定义的参数所需的密钥长度，IceSSL提供默认参数的密匙长度有512、1024、2048和4096位。参数必须使用PEM格式编码。
IceSSL试图定位指定的文件；如果给定的路径是相对的且不存在，IceSSL也试图相对于[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录找。
###### 平台提醒
###### SChannel
匿名Diffie-Hellman密码不支持Windows。
###### SecureTransport
查看IceSSL.DHParams。

###### <span id="IceSSL.DHParams">IceSSL.DHParams</span>，格式：
	IceSSL.DHParams=file (SecureTransport)
指定包含Diffie-Hellman参数文件。参数必须使用DER格式进行编码。此属性只影响服务端（输入）连接。当通过SSL/TLS与服务端商定时，客户获得DH参数。
IceSSL试图定位指定的文件；如果给定的路径是相对的且不存在，IceSSL也试图相对于[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录找。
如果不指定此属性，OS X的过程中产生自己的Diffie-Hellman参数。在运行时计算这些参数可以占用30秒，所以我们建议提前生成和定义这个属性。
你可以使用OpenSSL命令生成dhparam Diffie-Hellman参数。
###### 平台提醒
###### SChannel
匿名Diffie-Hellman密码不支持Windows。
###### SecureTransport
使用IceSSL.DH.bits。

###### <span id="IceSSL.EntropyDaemon">IceSSL.EntropyDaemon</span>，格式：
	IceSSL.EntropyDaemon=file (OpenSSL)
指定一个UNIX域套接字的熵收集精灵，从OpenSSL的聚熵数据初始化随机数发生器。

###### <span id="IceSSL.FindCert">IceSSL.FindCert</span>，格式：
	IceSSL.FindCert=criteria (SChannel, SecureTransport, .NET)
建立将用于身份验证的证书集合。服务端要求身份验证的证书，因此IceSSL选取累计收集第一证书。这通常是通过[IceSSL.CertFile](#IceSSL.CertFile)证书加载，如果定义该属性。否则，IceSSL会通过[IceSSL.FindCert](#IceSSL.FindCert)选择一个确定的证书。
###### 平台提醒
###### SChannel, .NET
IceSSL查询证书存储匹配的证书并将其添加到应用程序的证书集合。[IceSSL.CertStore](#IceSSL.CertStore)和[IceSSL.CertStoreLocation](#IceSSL.CertStoreLocation)的设置确定目标证书存储查询。标准的值可能是*，在该情况下，存储中的所有证书都被选中。否则，标准必须是空白分隔的一个或多个field:value对。下面是有效的字段名：

* Issuer 匹配一个字符串的发行人名称。
* IssuerDN 匹配发行人的整个区分名称。
* Serial 匹配证书的序列号。
* Subject 匹配一个字符串对象的名称。
* SubjectDN 匹配主体的整个区分名称。
* SubjectKeyId 匹配证书的主题密钥标识符。
* Thumbprint 匹配证书的指纹。

字段名称是区分大小写的。如果指定多个标准，则选择符合所有标准的证书。必须用单引号或双引号括起来以保持空格。
###### SecureTransport
IceSSL查询匹配的证书链并将其添加到应用程序的证书集合。IceSSL使用密匙链确定[IceSSL.Keychain](#IceSSL.Keychain)，或用户的默认钥匙扣如果[IceSSL.Keychain](#IceSSL.Keychain)没有定义。标准的值必须是一个或多个由空格分隔的field:value对。下面是有效的字段名：

* Label 匹配用户可见标签。
* Serial 匹配证书的序列号。
* Subject 匹配一个字符串对象的名称。
* SubjectKeyId 匹配证书的主题密钥标识符。

字段名称是区分大小写的。如果指定多个标准，则选择符合所有标准的证书。必须用单引号或双引号括起来以保持空格。
###### Java
使用IceSSL.Alias

###### <span id="IceSSL.InitOpenSSL">IceSSL.InitOpenSSL</span>，格式：
	IceSSL.InitOpenSSL=num (OpenSSL)
指示是否应icessl OpenSSL库执行全局初始化任务。默认值是1，意思是IceSSL将初始化OpenSSL。应用程序可以设置为零，如果它希望自己执行OpenSSL初始化，当应用程序使用多个组件依赖于OpenSSL这可能是有用的。

###### <span id="IceSSL.Keychain">IceSSL.Keychain</span>，格式：
	IceSSL.Keychain=name (SecureTransport, iOS)
指定要导入的证书来确定[IceSSL.CertFile](#IceSSL.CertFile)的密匙链的名字。如果指定了一个密码密匙链，设定[IceSSL.KeychainPassword](#IceSSL.KeychainPassword)。
###### 平台提醒
###### SecureTransport
相对于当前工作目录的相对路径名称。如果指定的钥匙串文件不存在，则会创建一个新文件。如果没有定义，IceSSL使用用户的默认钥匙扣。
###### iOS
如果没有定义，钥匙串，命名为登录时默认使用的。请注意，此属性是唯一相关的苹果模拟器和OS X的目标。

###### <span id="IceSSL.KeychainPassword">IceSSL.KeychainPassword</span>，格式：
	IceSSL.KeychainPassword=password (SecureTransport, iOS)
为通过[IceSSL.Keychain](#IceSSL.Keychain)辨认的密匙链指定密码。如果没有定义，IceSSL试图不用密码打开密匙链。
###### 平台提醒
###### SecureTransport
如果没有定义和需要密码的密匙链，OS X系统会在一个图形化的提示用户。
###### iOS
此属性是唯一相关的苹果模拟器和OS X的目标。

###### <span id="IceSSL.Keystore">IceSSL.Keystore</span>，格式：
	IceSSL.Keystore=file (Java)
指定包含证书和私钥的密钥存储文件。如果密钥存储区包含多个证书，您应该指定一个特定的用于验证身份的证书用于[IceSSL.Alias](#IceSSL.Alias)。IceSSL首先尝试打开文件作为一个类装载器资源，然后作为一个普通的文件。如果给定的路径是相对的而不存在，IceSSL也试图找到它相对于[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的默认目录。通过[IceSSL.KeystoreType](#IceSSL.KeystoreType)确定文件格式。
如果这个属性没有定义，应用程序将无法在SSL握手中提供证书。其结果是，该应用程序可能无法协商安全的连接，或可能需要使用一个匿名密码套件。

###### <span id="IceSSL.KeystorePassword">IceSSL.KeystorePassword</span>，格式：
	IceSSL.KeystorePassword=password (Java)
指定[IceSSL.Keystore](#IceSSL.Keystore)定义的密钥存储用于完整验证的密码。如果没有定义此属性，会跳过完整验证。
在配置文件中使用纯文本密码是存在安全风险。

###### <span id="IceSSL.KeystoreType">IceSSL.KeystoreType</span>，格式：
	IceSSL.KeystoreType=type (Java)
指定通过[IceSSL.Keystore](#IceSSL.Keystore)定义的密钥存储文件格式。合法的值是JKS和PKCS12。如果没有定义，JVM默认是使用（通常的JKS）。

###### <span id="IceSSL.Password">IceSSL.Password</span>，格式：
	IceSSL.Password=password
指定要解密私钥需要的密码。
在配置文件中使用纯文本密码是存在安全风险。
###### 平台提醒
###### SChannel, SecureTransport, OpenSSL
此属性提供密码，用来保护私钥的，包含在[IceSSL.CertFile](#IceSSL.CertFile)定义的文件里。
###### Java
此属性提供密码，用来保护私钥的，包含在[IceSSL.Keystore](#IceSSL.Keystore)定义的密钥存储里。密钥库中的所有密钥必须使用相同的密码。
###### .NET
此属性提供密码，用来保护[IceSSL.CertFile](#IceSSL.CertFile)定义的文件。
###### iOS
此属性提供密码，用来保护[IceSSL.CertFile](#IceSSL.CertFile)定义的文件。

###### <span id="IceSSL.PasswordCallback">IceSSL.PasswordCallback</span>，格式：
	IceSSL.PasswordCallback=classname (Java, .NET)
指定实现IceSSL.PasswordCallback接口的Java或.NET类名。使用一个密码回调比在一个普通的文本配置文件中指定一个密码一种更安全的选择。
###### 平台提醒
###### SChannel, SecureTransport, OpenSSL
在插件里使用setPasswordPrompt方法来安装一个密码回调。

###### <span id="IceSSL.PasswordRetryMax">IceSSL.PasswordRetryMax</span>，格式：
	IceSSL.PasswordRetryMax=num (SChannel, SecureTransport, OpenSSL)
指定输入密码时，允许用户尝试创建num个IceSSL。如果没有定义，默认值是3。

###### <span id="IceSSL.Protocols">IceSSL.Protocols</span>，格式：
	IceSSL.Protocols=list (SChannel, SecureTransport, OpenSSL, Java, .NET)
SSL握手时指定允许的协议。合法值有SSL3，TLS1，TLS1_0(别名时TLS1)，TLS1_1和TLS1_2。您还可以指定多个值，用逗号或空格分隔。如果未定义此属性，则默认设置如下：

	IceSSL.Protocols=TLS1_0, TLS1_1, TLS1_2
在C#里，TLS1_1和TLS1_2选项是必须的，.NET4.5或更高版本。
在Ice3.6，默认禁止SSLv3。
###### 平台提醒
###### SecureTransport
使用[IceSSL.ProtocolVersionMin](#IceSSL.ProtocolVersionMin)和[IceSSL.ProtocolVersionMax](#IceSSL.ProtocolVersionMax)。

###### <span id="IceSSL.ProtocolVersionMax">IceSSL.ProtocolVersionMax</span>，格式：
	IceSSL.ProtocolVersionMax=prot (SecureTransport)
SSL握手时指定允许最大的协议。合法值有SSL3，TLS1，TLS1_0(别名时TLS1)，TLS1_1和TLS1_2。默认是TLS1_0。
###### 平台提醒
###### SChannel, OpenSSL, Java, .NET
使用[IceSSL.Protocols](#IceSSL.Protocols)。

###### <span id="IceSSL.ProtocolVersionMin">IceSSL.ProtocolVersionMin</span>，格式：
	IceSSL.ProtocolVersionMin=prot (SecureTransport)
SSL握手时指定允许最小的协议。合法值有SSL3，TLS1，TLS1_0(别名时TLS1)，TLS1_1和TLS1_2。如果没有定义，平台默认使用。
###### 平台提醒
###### SChannel, OpenSSL, Java, .NET
使用[IceSSL.Protocols](#IceSSL.Protocols)。

###### <span id="IceSSL.Random">IceSSL.Random</span>，格式：
	IceSSL.Random=filelist (OpenSSL, Java)
指定在播种随机数生成器时使用的数据的一个或多个文件。文件名应该使用该平台的路径分隔符分隔。
###### 平台提醒
###### OpenSSL
IceSSL试图找到每个文件指定；如果给定的路径是相对的且不存在，IceSSL也试图相对于[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录找。
###### Java
IceSSL首先尝试每个文件作为一个类装载器资源，然后作为一个普通的文件打开。如果给定的路径是相对的且不存在，IceSSL也试图相对于[IceSSL.DefaultDir](#IceSSL.DefaultDir)定义的目录找。

###### <span id="IceSSL.Trace.Security">IceSSL.Trace.Security</span>，格式：
	IceSSL.Trace.Security=num (SChannel, SecureTransport, OpenSSL, Java, .NET)
SSL插件跟踪等级：

* 0 默认，没有安全跟踪
* 1 显示SSL连接的诊断信息。 

###### <span id="IceSSL.TrustOnly">IceSSL.TrustOnly</span>，格式：
	IceSSL.TrustOnly=ENTRY[;ENTRY;...] (SChannel, SecureTransport, OpenSSL, Java, .NET)
标识的信任和不信任的同伴。这一系列的属性提供了一个额外的身份验证级别，使用证书的专有名称（DN）来决定是否接受或拒绝连接。
根据RFC 2253规定的格式，在每个属性值的ENTRY由相对可分辨名称（RDN）组成。具体来说，该部件必须用逗号隔开，并包含逗号的任何组件必须在引号中被省略或括在引号中。例如，以下2个属性定义是等价的：

	IceSSL.TrustOnly=O="Acme, Inc.",OU=Sales
	IceSSL.TrustOnly=O=Acme\, Inc.,OU="Sales"
使用分号分隔多个条目中的属性：
	
	IceSSL.TrustOnly=O=Acme\, Inc.,OU=Sales;O=Acme\, Inc.,OU=Marketing
默认情况下，每个条目都代表一个接受条目。一个!字符在条目的前面出现表示拒绝。属性中的项的顺序不重要。
在SSL引擎已成功完成认证过程，IceSSL评估在试图找到入口相匹配的证书的DN相关IceSSL.TrustOnly性质。为了匹配成功，对等的DN必须包含精确匹配，在一个条目中所有的RDN元件中。一个条目可能包含许多RDN成分如你期待，这取决于你需要限制访问的严格程度。在入口的RDN组件的顺序并不重要。
下面描述的连接语义：

* IceSSL中止连接如果任何拒绝或接受项被定义和对对等端不提供证书。
* IceSSL中止连接如果如果对等端的DN匹配任何拒绝进入条件。（即使对等端的DN也符合接受条件。这是真的）
* IceSSL接受连接如果对等端的DN匹配任何接受进入条件，或者如果没有接受项定义。

我们最初的例子限制在销售和营销部门的人：
	
	IceSSL.TrustOnly=O=Acme\, Inc.,OU=Sales;O=Acme\, Inc.,OU=Marketing
如果在这些部门中拒绝访问某些个人的访问，如果它是必要的，你可以添加一个拒绝输入和重新启动程序：

	IceSSL.TrustOnly=O=Acme\, Inc.,OU=Sales; O=Acme\, Inc.,OU=Marketing; !O=Acme\, Inc.,CN=John Smith
当测试您的信任配置，你也许会发现设置IceSSL.Trace.Security为0非常有效，因为IceSSL显示DN在每个对等端建立连接时。
这个属性影响输入和输出连接。IceSSL也支持类似的只影响输入连接或输出连接的属性。

###### <span id="IceSSL.TrustOnly.Client">IceSSL.TrustOnly.Client</span>，格式：
	IceSSL.TrustOnly.Client=ENTRY[;ENTRY;...] (SChannel, SecureTransport, OpenSSL, Java, .NET)
	IceSSL.TrustOnly.Client=ID (iOS)
定义信任和不信任的对等端（客户端）连接的身份。这些条目的该属性要结合[IceSSL.TrustOnly](#IceSSL.TrustOnly)。
###### 平台提醒
###### iOS
一个输出连接成功，对等端证书的主题密匙身份必须匹配确定的属性值。属性值的格式必须是一串由冒号或空格分割的十六进制，如下面的示例所示：

	C2:E8:D3:33:D7:83:99:6E:08:F7:C2:34:31:F7:1E:8E:44:87:38:57
这仅当结合[IceSSL.CertAuthFile](#IceSSL.CertAuthFile)使用，因此这个值是特定于一个证书颁发机构。

###### <span id="IceSSL.TrustOnly.Server">IceSSL.TrustOnly.Server</span>，格式：
	IceSSL.TrustOnly.Server=ENTRY[;ENTRY;...] (SChannel, SecureTransport, OpenSSL, Java, .NET)
定义信任和不信任的对等端（服务端）连接的身份。这些条目的该属性要结合[IceSSL.TrustOnly](#IceSSL.TrustOnly)。使用[IceSSL.TrustOnly.Server.AdapterName](#IceSSL.TrustOnly.Server.AdapterName)为一个特定的对象适配器配置信任和不信任的对等端。

###### <span id="IceSSL.TrustOnly.Server.AdapterName">IceSSL.TrustOnly.Server.AdapterName</span>，格式：
	IceSSL.TrustOnly.Server.AdapterName=ENTRY[;ENTRY;...] (SChannel, SecureTransport, OpenSSL, Java, .NET)
定义信任和不信任的对等端（服务端）来连接AdapterName对象适配器。这些条目的该属性要结合[IceSSL.TrustOnly](#IceSSL.TrustOnly)和[IceSSL.TrustOnly.Server](#IceSSL.TrustOnly.Server)。

###### <span id="IceSSL.Truststore">IceSSL.Truststore</span>，格式：
	IceSSL.Truststore=file (Java)
指定包含证书颁发机构的证书的密钥存储区文件。IceSSL首先尝试打开文件作为一个类装载器资源，然后作为一个普通的文件。如果给定的路径是相对的而不存在，IceSSL也试图找到它的位置相对于[IceSSL.DefaultDir](#IceSSL.DefaultDir)所定义的默认目录。由[IceSSL.TruststoreType](#IceSSL.TruststoreType)确定文件格式。
如果该属性没有定义，IceSSL默认使用[IceSSL.Keystore](#IceSSL.Keystore)值。如果没有信任库指定和密钥库不包含一个有效的证书链，在SSL握手时应用程序将无法进行身份验证的证书。其结果是，应用程序可能无法协商安全的连接，或可能需要使用一个匿名密码套件。
###### 平台提醒
###### SChannel, SecureTransport, OpenSSL, .NET
使用[IceSSL.CAs](#IceSSL.CAs)。

###### <span id="IceSSL.TruststorePassword">IceSSL.TruststorePassword</span>，格式：
	IceSSL.TruststorePassword=password (Java)
指定密码用于验证完整的[IceSSL.Truststore](#IceSSL.Truststore)定义的密匙存储。如果没有定义该属性，会跳过完整检测。
在配置文件中使用纯文本密码是存在安全风险。
###### 平台提醒
###### SChannel, SecureTransport, OpenSSL, .NET
使用[IceSSL.Password](#IceSSL.Password)。

###### <span id="IceSSL.TruststoreType">IceSSL.TruststoreType</span>，格式：
	IceSSL.TruststoreType=type (Java)
指定[IceSSL.Truststore](#IceSSL.Truststore)定义的密钥存储文件的格式。合法的值有JKS和PKCS12。默认值是JKS。

###### <span id="IceSSL.UsePlatformCAs">IceSSL.UsePlatformCAs</span>，格式：
	IceSSL.UsePlatformCAs=num
如果num大于0，IceSSL使用平台捆绑的根证书颁发机构。如果[IceSSL.CAs](#IceSSL.CAs)定义，该属性会被忽略。默认是0。

###### <span id="IceSSL.VerifyDepthMax">IceSSL.VerifyDepthMax</span>，格式：
	IceSSL.VerifyDepthMax=num (SChannel, SecureTransport, OpenSSL, Java, .NET)
指定一个可信任的对等端证书链的最大深度，包括对等端的证书。任何长度的链接受0值。默认值是3。

###### <span id="IceSSL.VerifyPeer">IceSSL.VerifyPeer</span>，格式：
	IceSSL.VerifyPeer=num (SChannel, SecureTransport, OpenSSL, Java, .NET)
指定在SSL握手时使用验证要求。合法值如下所示。如果未定义此属性，则默认值为2。

* 0 对于一个输出连接，客户端验证服务端的证书（如果不使用匿名密码），如果验证失败，则不中止连接。对于传入的连接，服务端不请求来自客户端的证书。
* 1 一个输出的连接，客户端验证服务端的证书并中止连接如果验证失败。对于输入的连接，服务端请求客户端的证书和验证如果提供，如果验证失败中止连接。
* 2 对于一个输出连接，语义是相同的值1。对于输入的连接，服务端要求客户端证书并中止连接如果验证失败。

###### 平台提醒
###### .NET
在输出连接中该属性没有影响，由于.NET总是使用的值2。对于输入的连接，值0和值1具有相同的语义。

---
[返回目录](#目录)
## <span id="IceStorm Properties">IceStorm Properties</span>
###### <span id="service.Discard.Interval">service.Discard.Interval</span>，格式：
	service.Discard.Interval=num
一个IceStorm服务端检测到转发事件给一个订阅者不起作用时，在这点上，在尝试再转发事件之前num秒试图停止投递给订阅者。默认值是60秒。

###### <span id="service.Election.ElectionTimeout">service.Election.ElectionTimeout</span>，格式：
	service.Election.ElectionTimeout=num
该属性用于IceStorm副本的部署。它指定了一个协调器试图形成较大的复制组的以秒为单位的时间间隔。默认值是10。

###### <span id="service.Election.MasterTimeout">service.Election.MasterTimeout</span>，格式：
	service.Election.MasterTimeout=num
该属性用于IceStorm副本的部署。它指定以秒为单位的时间间隔，一个奴隶检查协调器的状态。默认值是10。

###### <span id="service.Election.ResponseTimeout">service.Election.ResponseTimeout</span>，格式：
	service.Election.ResponseTimeout=num
该属性用于IceStorm副本的部署。它指定以秒为单位的时间间隔，一个副本等待回复的邀请，形成一个较大的组。较低优先级的副本等待时间间隔成反比的最大优先级：

	ResponseTimeout + ResponseTimeout * (max - pri)
默认值是10。

###### <span id="service.Flush.Timeout">service.Flush.Timeout</span>，格式：
	service.Flush.Timeout=num
定义事件被发送到批处理用户的以毫秒为单位的时间间隔。默认值是1000ms。

###### <span id="service.InstanceName">service.InstanceName</span>，格式：
	service.InstanceName=name
为所有通过IceStorm对象适配器主持的对象定义一个交替的身份分类。默认识别分类是IceStorm。

###### <span id="service.Node.AdapterProperty">service.Node.AdapterProperty</span>，格式：
	service.Node.AdapterProperty=value
在一个副本部署中，IceStorm为副本节点对象使用名为service.Node的适配器。因此，适配器属性可以用来配置本适配器。

###### <span id="service.NodeId">service.NodeId</span>，格式：
	service.NodeId=value
定义IceStorm副本的节点ID，vaule是一个非负整数。节点ID也用作副本的优先权，一个更大的值分配更高优先级的副本。具有最高优先级的副本成为其组的协调器。此属性必须定义为每个副本。

###### <span id="service.Nodes.id">service.Nodes.id</span>，格式：
	service.Nodes.id=value
此属性用于高可用IceStorm手动部署，每个副本必须被显式地配置为所有其他副本的代理。该值是一个给定的节点标识的副本的代理。副本对象标识的形式是实例名称/节点ID（instance-name/nodeid），如demoicestorm/NODE2。

###### <span id="service.Publish.AdapterProperty">service.Publish.AdapterProperty</span>，格式：
	service.Publish.AdapterProperty=value
IceStorm为处理来自发布者的输入请求的对象适配器使用名为service.Publish的适配器。因此，适配器属性可用于配置该适配器。

###### <span id="service.ReplicatedPublishEndpoints">service.ReplicatedPublishEndpoints</span>，格式：
	service.ReplicatedPublishEndpoints=value
此属性用于高可用IceStorm手动部署。它指定为发布服务器返回的终结点的集合，从IceStorm::Topic::getPublisher返回。如果该属性没有定义，发布者代理通过主题实例点直接返回给副本，副本变成不可用时，发布者不会透传给其他副本。

###### <span id="service.ReplicatedTopicManagerEndpoints">service.ReplicatedTopicManagerEndpoints</span>，格式：
	service.ReplicatedTopicManagerEndpoints=value
此属性用于高可用IceStorm手动部署。它指定用于引用副本主题的代理的一组端点。这套指标应该包含每个IceStorm副本的终点。
如，运行IceStorm::TopicManager::create返回一个包含该组端点的代理。

###### <span id="service.Send.Timeout">service.Send.Timeout</span>，格式：
	service.Send.Timeout=num
当IceStorm转发事件给订阅者，申请一个发送超时。此属性的值决定了IceStorm将等待一个事件完成转发。如果一个事件在num毫秒内不能被转发，订阅者被认为是死亡，其订阅被取消。默认是60秒。设置为一个负值会禁用超时。

###### <span id="service.TopicManager.AdapterProperty">service.TopicManager.AdapterProperty</span>，格式：
	service.TopicManager.AdapterProperty=value
IceStorm为主体管理对象适配器使用名为service.TopicManager的适配器。因此，适配器属性可用于配置该适配器。

###### <span id="service.Trace.Election">service.Trace.Election</span>，格式：
	service.Trace.Election=num
与选举有关的追踪活动：

* 0 默认，没有选项跟踪。
* 1 跟踪选举活动。

###### <span id="service.Trace.Replication">service.Trace.Replication</span>，格式：
	service.Trace.Replication=num
跟踪与副本相关的活动：

* 0 默认，没有副本跟踪。
* 1 跟踪副本活动。

###### <span id="service.Trace.Subscriber">service.Trace.Subscriber</span>，格式：
	service.Trace.Subscriber=num
订阅跟踪级别：

* 0 默认，没有订阅跟踪。
* 1 在订阅和取消订阅跟踪话题的诊断信息。
* 2 像1，当丰富，包括一个订阅状态的转换（如在一个临时网络故障后脱机，以及在成功的重试等之后再进行在线）。

###### <span id="service.Trace.Topic">service.Trace.Topic</span>，格式：
	service.Trace.Topic=num
主题跟踪级别：

* 0 默认，没有主题跟踪。
* 1 微量主题链接，订阅和退订。
* 2 像1，当丰富，包括服务质量信息，和其他诊断信息。

###### <span id="service.Trace.TopicManager">service.Trace.TopicManager</span>，格式：
	service.Trace.TopicManager=num
主题管理器跟踪级别：

* 0 默认，没有主题管理器跟踪。
* 1 主题创建跟踪。

###### <span id="service.Transient">service.Transient</span>，格式：
	service.Transient=num
如果num大于0，在无需数据库下IceStorm运行在完全过渡模式。在这种模式下不支持副本。默认是0。

--）-
[返回目录](#目录)
## <span id="IceStormAdmin">IceStormAdmin</span>
###### <span id="IceStormAdmin.Host">IceStormAdmin.Host</span>，格式：
	IceStormAdmin.Host=host
当IceStormAdmin.Port一起使用时，icestormadmin使用查找器接口在指定主机和端口发现话题管理器。
如果你定义一个或多个IceStormAdmin.TopicManager属性，icestormadmin会忽略该属性。

###### <span id="IceStormAdmin.Port">IceStormAdmin.Port</span>，格式：
	IceStormAdmin.Port=port
当IceStormAdmin.Host一起使用，icestormadmin使用查找器接口在指定主机和端口发现话题管理器。
如果你定义一个或多个IceStormAdmin.TopicManager属性，icestormadmin会忽略该属性。

###### <span id="IceStormAdmin.TopicManager.Default">IceStormAdmin.TopicManager.Default</span>，格式：
	IceStormAdmin.TopicManager.Default=proxy
为IceStorm话题管理器定义代理。该属性用于icestormadmin。IceStorm应用也许使用这个属性为其配置。

###### <span id="IceStormAdmin.TopicManager.name">IceStormAdmin.TopicManager.name</span>，格式：
	IceStormAdmin.TopicManager.name=proxy
为icestormadmin的话题管理器定义代理。如果多个主题管理者正在使用，被icestormadmin所用。例如：
	
	IceStormAdmin.TopicManager.A=A/TopicManager:tcp -h x -p 9995
	IceStormAdmin.TopicManager.B=Foo/TopicManager:tcp -h x -p 9995
	IceStormAdmin.TopicManager.C=Bar/TopicManager:tcp -h x -p 9987
这为三个主题管理者设置代理。请注意，name不匹配对应的主题管理器的实例名称，name只是用作标记。有了这些属性设置，icestormadmin命令接受的话题现在可以指定主题的经理不是IceStormAdmin.TopicManager.Default配置的默认话题管理器。如：

	current Foo
	create myTopic
	create Bar/myOtherTopic
为当前话题管理器设置其中一个实例名称为foo；第一个create命令在话题管理器里面创建话题，而第二个create命令使用名为Bar的话题管理器实例。