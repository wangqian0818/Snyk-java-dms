#!/bin/bash

log() {
  message=$1
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [LOG] $message" 2>&1 | tee -a "$LOG_FILE"
}

warn() {
  message=$1
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [WARN] $message" 2>&1 | tee -a "$LOG_FILE"
}

error() {
  message=$1
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [ERROR] $message"  2>&1 | tee -a "$LOG_FILE"
  echo "[$timestamp] [ERROR] Uninstallation failed at $(date '+%Y-%m-%d %H:%M:%S')"  2>&1 | tee -a "$LOG_FILE"
  echo "[$timestamp] [ERROR] ========================="  2>&1 | tee -a "$LOG_FILE"
  exit 1
}


uninstall_jsp(){
	JSP_INSTALL_PATH=/usr/local/jsp
	JSP_SERVER_PREFIX="jspd_config_"
	
	# 停止所有JSP服务
	PIDs=$(ps aux | grep "${JSP_SERVER_PREFIX}" | grep -v grep | awk '{print $2}')
	if [ -z "$PIDs" ]; then
		log "No JSP server process found."
	else
		log "Found processes with PIDs: $PIDs"
		log "Terminating processes..."
		
		# 检查是否成功终止
		for PID in $PIDs; do
			kill -9 $PID
		done
	fi

    #删除JSP工具
    if [ -d "${JSP_INSTALL_PATH}" ];then
        rm -rf ${JSP_INSTALL_PATH}
		log "${JSP_INSTALL_PATH}已删除"
    fi 
    
    log "jsp卸载完成"
}




uninstall_zxclient(){
    if systemctl list-units --full -all | grep -wq "$SERVICE_NAME.service"; then
		log "服务 $SERVICE_NAME 存在，开始卸载服务"
		if systemctl is-enabled --quiet "$SERVICE_NAME"; then
			log "$SERVICE_NAME is enabled. Disabling service..."
			sudo systemctl disable "$SERVICE_NAME"
		else
			log "$SERVICE_NAME is already disabled."
		fi
		
		#如果当前有jusonclient服务在运行，停掉
		if systemctl is-active --quiet "$SERVICE_NAME"; then
			log "$SERVICE_NAME is running. Stopping service..."
			sudo systemctl stop "$SERVICE_NAME"
		else
			log "$SERVICE_NAME is not running."
		fi
	else
		log "本地没有传输客户端服务，无需卸载"
	fi
	
	if [ -e /lib/systemd/system/${SERVICE_NAME}.service ];then
		rm -rf /lib/systemd/system/${SERVICE_NAME}.service
		sudo systemctl daemon-reload
		log "移除客户端服务文件$SERVICE_NAME.service"
	fi
	
	
	#删除zxclient部署文件
	if [ -e $CLIENT_CONFIG_PATH/dmsServer.config ];then
		rm -rf $CLIENT_CONFIG_PATH/dmsServer.config
	fi
	
	if [ -e $CLIENT_CONFIG_PATH/application.yml ];then
		rm -rf $CLIENT_CONFIG_PATH/application.yml
	fi
	
	if [ -e $SCRIPT_DIR/jusonclient.service ];then
		rm -rf $SCRIPT_DIR/jusonclient.service
	fi
	
	if [ -e $CLIENT_BIN_PATH/run.sh ];then
		rm -rf $CLIENT_BIN_PATH/run.sh
	fi
	
	if [ -e $CLIENT_BIN_PATH/updateClient.sh ];then
		rm -rf $CLIENT_BIN_PATH/updateClient.sh
	fi
	if [ -e $CLIENT_BIN_PATH/recoverClient.sh ];then
		rm -rf $CLIENT_BIN_PATH/recoverClient.sh
	fi
	if [ -e $CLIENT_BIN_PATH/restoreClient.sh ];then
		rm -rf $CLIENT_BIN_PATH/restoreClient.sh
	fi
	if [ -e $CLIENT_BIN_PATH/backupClient.sh ];then
		rm -rf $CLIENT_BIN_PATH/backupClient.sh
	fi
	
	if [ -e $CLIENT_LOG_PATH ];then
		rm -rf $CLIENT_LOG_PATH
	fi
	
	if [ -e $CLIENT_BASE_PATH/certFiles ];then
		rm -rf $CLIENT_BASE_PATH/certFiles
	fi
	
	if [ -e $CLIENT_CONFIG_PATH/BusiFile ];then
		rm -rf $CLIENT_CONFIG_PATH/BusiFile
	fi
	
	if [ -e $CLIENT_UPDATE_PATH ];then
		rm -rf $CLIENT_UPDATE_PATH
	fi
}

deleteUser(){
	if [ -f $CLIENT_CONFIG_PATH/passwd ];then
		# 遍历文件中的每一行
		while IFS=: read -r line; do
		    if [ -z "$line" ]; then
				log "跳过空行或无效行：$line"
				continue
			fi
			# 提取用户名（第一个字段）
			username=$(echo $line | grep -o '"userName":"[^"]*' | sed 's/"userName":"//')
			log "读取到用户数据文件行：${line}, 解析出用户名：${userName}"
			# 检查用户名是否为空
			if [ -z "$username" ]; then
				log "解析出用户名为空"
				continue
			fi

            
			# 检查用户是否存在
			if id "$username" &>/dev/null; then
				log "正在删除用户：$username"
				userdel "$username"  # 删除用户
				if [ $? -eq 0 ]; then
					log "用户 $username 已成功删除。"
				else
					warn "删除用户 $username 时出错，请检查权限或用户是否正在使用。"
				fi
			else
				warn "用户 $username 不存在，跳过删除。"
			fi
				
		done < $CLIENT_CONFIG_PATH/passwd
	fi
}




##以上都是封装的函数。下面是主体流程
SERVICE_NAME=jusonclient
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_FILE="$SCRIPT_DIR/uninstall.log"

CLIENT_BASE_PATH=%%%basedir%%%
CLIENT_APP_PATH=${CLIENT_BASE_PATH}/app
CLIENT_BIN_PATH=${CLIENT_BASE_PATH}/bin
CLIENT_CONFIG_PATH=${CLIENT_APP_PATH}/config
CLIENT_UPDATE_PATH=${CLIENT_BASE_PATH}/update_client
CLIENT_LOG_PATH=/var/log/zx_client


##主方法。部署过程拆分成一个个方法，都在main方法中调用。
main(){
    # 获取当前日期和时间作为日志的前缀
	CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
	log "========================="
    log "Uninstallation started at $CURRENT_TIME"
	log "---step1：卸载zxclient---"
    uninstall_zxclient;
	log "---step2：删除客户端创建的用户---"
    deleteUser;
	log "---step3：卸载JSP---"
	uninstall_jsp;

		
	log "Uninstallation completed at $(date '+%Y-%m-%d %H:%M:%S')"
    log "========================="
}

#安装前提示
echo "提示：该安装程序会卸载服务器上现有的zx_client"
read -p "是否继续？(y/n) " -n 1 -r
echo    # 移动到新的一行
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "开始卸载..."
    main;
else
    echo "取消卸载。"
    exit 0;
fi

exit 0;