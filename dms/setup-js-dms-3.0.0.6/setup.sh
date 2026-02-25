#! /bin/sh
# 情况1，参数只有：ip 
# 情况2，参数：域名，IP
function do_init()
{
	echo "开始安装mysql！"
	mkdir /jsdata
	for i in `rpm -qa|grep -i -e mariadb`;do rpm -e $i --nodeps; done
	ps -ef|grep mysql| grep jsdata| awk '{print $2}'|xargs kill -9
	tar -zxvf ./mysql8.tar.gz -C /jsdata/
	sh /jsdata/mysql8/setup_mysql.sh
	echo "mysql数据库安装完成！"

	cp -r ./dirs/* /juson_file/
	chmod 755 /juson_file/*.sh
	cp -f ./jusondms.service /lib/systemd/system
	
	if [ "$2" -eq 2 ];then
		sed -i "s/address: jusonMgrIp/#address: jusonMgrIp/g" /juson_file/config/application.yml
	else
		sed -i "s/jusonMgrIp/$1/g" /juson_file/config/application.yml
	fi
	sed -i "s/jusonMgrType/$2/g" /juson_file/config/application.yml
	
	systemctl daemon-reload
	service jusondms start
	systemctl enable jusondms.service
	systemctl enable jsmysql.service
	echo "安装完成！"
}

# 安装参数：init，IP，安装类型
case "$1" in
    init)
        if [ ! -n "$2" ];then
           echo "请传入管理口IP地址"
        else
		    if [ ! -n "$3" ];then
			  do_init "$2"
			else
			   do_init "$2" "$3"
			fi
        fi
        ;;
    *)
		echo "Usage: ${0} { init }" >&2
esac
exit $REVAL

