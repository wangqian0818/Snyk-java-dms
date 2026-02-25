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
  exit 1
}

needRestart=$1
uuid=$2


CLIENT_BASE_PATH=%%%basedir%%%
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLIENT_APP_PATH=${CLIENT_BASE_PATH}/app
CLIENT_BIN_PATH=${CLIENT_BASE_PATH}/bin
CLIENT_CONFIG_PATH=${CLIENT_APP_PATH}/config
UPDATE_CLIENT_DIR=$CLIENT_BASE_DIR/update_client
LOG_FILE=/var/log/zx_client/recover.log
JSP_COMMAND_PATH=/usr/local/jsp/jspd_server.sh
CLIENT_UPGRADE_PATH=$CLIENT_CONFIG_PATH/upgrade


# 杀掉所有JSP进程
ps -ef | grep 'jspd.*jspd_config_' | grep -v grep | awk '{print $2}' | \
while read -r PID; do
    log "Killing jsp process: $PID"
    kill -9 "$PID"
done

# 如果有业务用户文件，遍历、删除本地用户及工作目录
if [ -f "$CLIENT_CONFIG_PATH/passwd" ]; then
	log "发现业务用户文件$CLIENT_CONFIG_PATH/passwd，开始遍历"
    # 使用 cut 提取字段
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
	
	log "业务用户遍历处理结束，删除用户文件"
	rm -rf $CLIENT_CONFIG_PATH/passwd
fi


if [ -n "$uuid" ]; then
	log "传参数uuid=${uuid}"
    log "清理完成后留下一个标记文件"
	current_time=$(date +"%Y-%m-%d %H:%M:%S")
	if [ ! -d ${CLIENT_UPGRADE_PATH} ];then
	    mkdir -p ${CLIENT_UPGRADE_PATH}
	fi
	echo $current_time > "$CLIENT_UPGRADE_PATH/recovermark_${uuid}"
fi


if [ "$needRestart" = "true" ]; then
    log "重启jsonclient服务"
    systemctl restart jusonclient
fi