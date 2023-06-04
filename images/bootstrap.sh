#!/usr/bin/env sh


wait_for() {
	echo Waiting for $1 to listen on $2...
	while ! nc -z $1 $2; do echo waiting...; sleep 1s; done
}

start_hbase_master() {
	if [ -n "$1" -a -n "$2" ];then
		wait_for $1 $2
	fi
	
	${HBASE_HOME}/bin/hbase-daemon.sh start master

	tail -f ${HBASE_HOME}/logs/*master*.out
}

start_hbase_regionserver() {

	wait_for $1 $2
	
	${HBASE_HOME}/bin/hbase-daemon.sh start regionserver
	
	tail -f ${HBASE_HOME}/logs/*regionserver*.log
}


case $1 in
	hbase-master)
		start_hbase_master $2 $3
		;;
        hbase-regionserver)
		start_hbase_regionserver $2 $3
		;;
	*)
		echo "请输入正确的服务启动命令~"
	;;
esac
