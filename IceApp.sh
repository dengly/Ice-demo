#!/bin/bash
source /etc/profile
SELF=$(cd $(dirname $0); pwd -P)/$(basename $0)
SELF_PATH=`dirname $SELF`

action="$1"

Ice_Version="3.6.1"

Ice_gridregistry_config="./Ice_gridregistry/icegridregistry.cfg"
Ice_gridregistry_log="${SELF_PATH}/Ice_gridregistry/Ice_gridregistry.log"
Ice_gridregistry_pid_file="${SELF_PATH}/Ice_gridregistry/IceGridRegistry.pid"

Ice_gridnode_config="./Ice_gridnode/icegridnode1.cfg"
Ice_gridnode_log="${SELF_PATH}/Ice_gridnode/Ice_gridnode.log"
Ice_gridnode_pid_file="${SELF_PATH}/Ice_gridnode/Ice_gridnode.pid"

Ice_glacier2_config="./Ice_glacier2/iceglacier2.cfg"
Ice_glacier2_log="${SELF_PATH}/Ice_glacier2/Ice_glacier2.log"
Ice_glacier2_pid_file="${SELF_PATH}/Ice_glacier2/Ice_glacier2.pid"

#ice grid registry
start_gridregistry(){
        icegridregistry --Ice.Config=${Ice_gridregistry_config} >>${Ice_gridregistry_log} 2>&1 &
        echo $!>${Ice_gridregistry_pid_file}
    echo "启动Ice ${Ice_Version} Grid Registry,PID=`cat ${Ice_gridregistry_pid_file}`"
}
stop_gridregistry(){
    if [ -f ${Ice_gridregistry_pid_file} ] ;then
        kill -term `cat ${Ice_gridregistry_pid_file}`
        rm -f ${Ice_gridregistry_pid_file}
        echo "关闭Ice ${Ice_Version} Grid Registry"
    else
        echo "Ice ${Ice_Version} Grid Registry未启动"
    fi
}
restart_gridregistry(){
    stop_gridregistry
    sleep 2
    start_gridregistry
}

#ice grid node
start_gridnode(){
        icegridnode --Ice.Config=${Ice_gridnode_config} >>${Ice_gridnode_log} 2>&1 &
        echo $!>${Ice_gridnode_pid_file}
    echo "启动Ice ${Ice_Version} Grid Node,PID=`cat ${Ice_gridnode_pid_file}`"
}
stop_gridnode(){
    if [ -f ${Ice_gridnode_pid_file} ] ;then
        kill -term `cat ${Ice_gridnode_pid_file}`
        rm -f ${Ice_gridnode_pid_file}
        echo "关闭Ice ${Ice_Version} Grid Node"
    else
        echo "Ice ${Ice_Version} Grid Node未启动"
    fi
}
restart_gridnode(){
    stop_gridnode
    sleep 2
    start_gridnode
}

#glacier2
start_glacier2(){
    glacier2router --Ice.Config=${Ice_glacier2_config} >>${Ice_glacier2_log} 2>&1 &
    echo $!>${Ice_glacier2_pid_file}
    echo "启动Ice ${Ice_Version} Glacier2,PID=`cat ${Ice_glacier2_pid_file}`"
}

stop_glacier2(){
    if [ -f ${Ice_glacier2_pid_file} ] ;then
        kill -term `cat ${Ice_glacier2_pid_file}`
        rm -f ${Ice_glacier2_pid_file}
        echo "关闭Ice ${Ice_Version} Glacier2"
    else
        echo "Ice ${Ice_Version} Glacier2未启动"
    fi
}

restart_glacier2(){
    stop_glacier2
    sleep 2
    start_glacier2
}

start(){
        start_gridregistry
    sleep 2
        start_gridnode
    sleep 2
    start_glacier2
}
stop(){
    stop_glacier2
    sleep 2
        stop_gridnode
    sleep 2
        stop_gridregistry
}
restart(){
        stop
    sleep 2
        start
}

case "${action:-''}" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        restart
    ;;
    restartGlaicer2)
        restart_glacier2
    ;;
    *)         
        echo "Usage:$0 start|stop|restart|restartGlaicer2" 
        exit 1
    ;;
esac