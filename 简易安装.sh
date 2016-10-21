# Includes: Runtime and SDK for Ice for C++, Java, PHP, and all Ice services.

# Red Hat Enterprise Linux 7
# Prerequisite: You may need to enable the RHEL 7 Server Optional repository for several dependencies.
#cd /etc/yum.repos.d
#sudo wget https://zeroc.com/download/rpm/zeroc-ice-el7.repo
#sudo yum -y install ice-all-runtime ice-all-devel

# Red Hat Enterprise Linux 6
cd /etc/yum.repos.d
sudo wget https://zeroc.com/download/rpm/zeroc-ice-el6.repo
sudo yum -y install ice-all-runtime ice-all-devel

# 以上操作仅安装了ice所有的服务和指令 并没有库，如需java的jar包，这需要自行上传

# jar包：
mkdir -p /usr/local/Ice-3.6.2/share/java
cd /usr/local/Ice-3.6.2/share/java
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/freeze/3.6.2/freeze-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/glacier2/3.6.2/glacier2-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/ice/3.6.2/ice-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/icebox/3.6.2/icebox-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/icediscovery/3.6.2/icediscovery-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/icegrid/3.6.2/icegrid-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/icegridgui/3.6.2/icegridgui-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/icelocatordiscovery/3.6.2/icelocatordiscovery-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/icepatch2/3.6.2/icepatch2-3.6.2.jar
wget https://repo.zeroc.com/nexus/content/repositories/releases/com/zeroc/icestorm/3.6.2/icestorm-3.6.2.jar
