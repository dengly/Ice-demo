Ice在我们的服务器上跑了半年左右，发现有些日志文件是Ice内部生成的，而这些日志文件没有相关的设置可以按照我们的需求来切割。问了以前做运维的同事，他推荐我使用Linux系统自带的日志轮替 logrotate 工具，做日志轮替。刚刚好我们的服务器是CentOS6.5也有，所以就上网搜索相关资料了。

说明如果系统没有的话可以安装 logrotate，由于logrotate依赖crontab，所以也要安装crontab。如何安装这里就不说了，搜索有很多相关资料。

废话不多说，直接上相关配置文件。在/etc/logrotate.d/下创建了ice_grid_log和ice_glacier2_log，分别编辑以下内容。这样就能可以每日切割日志出来。如果想马上切割，可以输入以下指令，这样就能将/home/Ice/Ice_glacier2/Ice_glacier2.log日志切割出来，切出来的文件是/home/Ice/Ice_glacier2/Ice_glacier2.log-yyyymmdd，yyyy是年份，mm是月份，dd是日期。

	logrotate -vf /etc/logrotate.d/ice_glacier2_log

#### ice_grid_log内容
	/home/Ice/grid/*.log {
   		daily
   		rotate 7
   		dateext
   		create
   		missingok
   		notifempty
   		copytruncate
   		nocompress
   		noolddir
   	}

#### ice_glacier2_log内容
	/home/Ice/Ice_glacier2/Ice_glacier2.log {
   		daily
   		rotate 7
   		dateext
   		create
   		missingok
   		notifempty
   		copytruncate
   		nocompress
   		noolddir
   	}
   	
#### 结语
看了logrotate，功能很强大，能自动清理过时的文件，能将切割出来的日志进行压缩，也能通过邮件发送给指定的邮箱。
