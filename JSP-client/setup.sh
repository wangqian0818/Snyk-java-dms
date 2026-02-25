#!/bin/bash
log() {
  message=$1
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [LOG] $message" 2>&1 | tee -a "$UPDATE_LOG_FILE"
}

warn() {
  message=$1
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [WARN] $message" 2>&1 | tee -a "$UPDATE_LOG_FILE"
}

error() {
  message=$1
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [ERROR] $message"  2>&1 | tee -a "$UPDATE_LOG_FILE"
  echo "[$timestamp] [ERROR] update failed at $(date '+%Y-%m-%d %H:%M:%S')"  2>&1 | tee -a "$UPDATE_LOG_FILE"
  echo "[$timestamp] [ERROR] ========================="  2>&1 | tee -a "$UPDATE_LOG_FILE"
  exit 1
}

checkEnvironment(){
    log "环境检查：当前系统架构"
	ARCH=$(uname -m)
	log "当前系统架构是 $ARCH"
	if [ "$ARCH" = "x86_64" ]; then
		log "环境检查：当前系统架构为x86_64：该更新包支持"
	elif [ "$ARCH" = "aarch64" ]; then
		log "环境检查：当前系统架构为aarch64：该更新包支持"
	else
		error "环境检查：当前系统架构为$ARCH：该更新包只支持aarch64或x86_64架构，无法更新！"
	fi
	
	log "环境检查：当前操作系统"
	if [ -f /etc/os-release ]; then
        # 读取操作系统名称
        osName=$(grep '^NAME=' /etc/os-release | cut -d '"' -f2)
        # 读取操作系统版本
        osVersion=$(grep '^VERSION_ID=' /etc/os-release | cut -d '"' -f2)
    else
        # 如果没有 /etc/os-release 文件，尝试其他方法
        osName=$(uname -s)
        osVersion=$(uname -r)
    fi
	log "当前操作系统名称：$osName, 版本:$osVersion"
	
	log "安装文件检查"
	if [ ! -e "$SCRIPT_DIR/version.txt" ];then
		error "升级包内容缺失：版本信息文件version.txt缺失，请确认安装包完整性"
	fi
	last_line=$(awk 'NF {last=$0} END {print last}' "$SCRIPT_DIR/version.txt")
	log "本次更新版本信息：$last_line"
}

uninstall_jsp(){
	log "卸载当前已有JSP工具......"
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

install_jsp(){
	NEW_JSP_INSTALLER=$1
	log "开始安装更新包中最新JSP工具......"
	if [ ! -d "${JSP_INSTALL_PATH}" ];then
        mkdir -p ${JSP_INSTALL_PATH}
    fi 

    tar -zxvf $NEW_JSP_INSTALLER -C ${JSP_INSTALL_PATH}
    log "解压${NEW_JSP_INSTALLER}到${JSP_INSTALL_PATH}"
    
    chmod  755  ${JSP_INSTALL_PATH}/*.sh
    log "执行jsp安装脚本${JSP_INSTALL_PATH}/setup.sh"
    sh  ${JSP_INSTALL_PATH}/setup.sh
    log "新版本jsp安装完成"
	
	echo ${NEW_JSP_INSTALLER} > ${JSP_INSTALL_PATH}/version.txt
	log "生成JSP版本信息文件${JSP_INSTALL_PATH}/version.txt， 写入安装包名称${NEW_JSP_INSTALLER}"
}


readConfig(){	
	DMS_CONFIG_FILE=$CLIENT_CONFIG_PATH/dmsServer.config
	if [  ! -f "$DMS_CONFIG_FILE" ]; then
		error "当前服务上报管控配置文件[$DMS_CONFIG_FILE]不存在，请检查。缺失该文件系统无法正常运行"
	fi
	log "读取当前客户端上报配置文件$DMS_CONFIG_FILE"
	dmsConfigContent=$(cat "$DMS_CONFIG_FILE")
	# 提取各个字段
	dmsIp=$(echo "$dmsConfigContent" | grep -o '"dmsIp":"[^"]*' | cut -d '"' -f 4)
	log "读取到配置：[dmsIp=${dmsIp}]"
	dmsPort=$(echo "$dmsConfigContent" | grep -o '"dmsPort":"[^"]*' | cut -d '"' -f 4)
	log "读取到配置：[dmsPort=${dmsPort}]"
	clientId=$(echo "$dmsConfigContent" | grep -o '"clientId":"[^"]*' | cut -d '"' -f 4)
	log "读取到配置：[clientId=${clientId}]"
	manageIp=$(echo "$dmsConfigContent" | grep -o '"manageIp":"[^"]*' | cut -d '"' -f 4)
	log "读取到配置：[manageIp=${manageIp}]"
	businessIp=$(echo "$dmsConfigContent" | grep -o '"businessIp":"[^"]*' | cut -d '"' -f 4)
	log "读取到配置：[businessIp=${businessIp}]"
	clientPort=$(echo "$dmsConfigContent" | grep -o '"clientPort":"[^"]*' | cut -d '"' -f 4)
	log "读取到配置：[clientPort=${clientPort}]"
}


updateAppConfig(){
	if [ -d "$UPDATE_CONFIG_PATH" ] && [ "$(ls -A "$UPDATE_CONFIG_PATH")" ]; then
		cp  -r $UPDATE_CONFIG_PATH/* $CLIENT_CONFIG_PATH/
		log "更新包中发现配置更新，复制到$CLIENT_CONFIG_PATH"
	fi
}

updateLib(){
	if [ -d "$UPDATE_LIB_PATH" ] && [ "$(ls -A "$UPDATE_LIB_PATH")" ]; then
		if [ -d "$UPDATE_LIB_PATH/total" ] && [ "$(ls -A "$UPDATE_LIB_PATH/total")" ]; then
			rm -rf $CLIENT_APP_PATH/lib/*
			cp -r  $UPDATE_LIB_PATH/total/*  $CLIENT_APP_PATH/lib/
			log "更新包中lib/total中有文件，全量更新第三方jar包到$CLIENT_APP_PATH/lib/"
		else
			cp -r  $UPDATE_LIB_PATH/*.jar  $CLIENT_APP_PATH/lib/
			log "更新包中发现第三方jar包更新，增量复制到$CLIENT_APP_PATH/lib/"
		fi	
	fi
}

updateAppLicense(){
    if [ -d "$UPDATE_LICENSE_PATH" ] && [ "$(ls -A "$UPDATE_LICENSE_PATH")" ]; then
		if [ ! -d "$CLIENT_LICENSE_PATH" ]; then
			mkdir -p $CLIENT_LICENSE_PATH
			log "更新包中发现证书更新，创建证书存放目录$CLIENT_LICENSE_PATH"
		fi
		cp -r $UPDATE_LICENSE_PATH/* $CLIENT_LICENSE_PATH
		log "更新包中发现证书更新，复制到$CLIENT_LICENSE_PATH"
	fi
}


updateZxclientJar(){
	if [ -e "$UPDATE_ZXCLIENT_JAR" ];then
		cp $UPDATE_ZXCLIENT_JAR  $CLIENT_APP_PATH/
		log "更新包中发现zx_client-1.0.0-SNAPSHOT.jar，复制到$CLIENT_APP_PATH"
	fi
}

# 如果bin下有total文件夹且有内容，就全量更新。否则增量更新
updateBin(){
	if [ -d "$UPDATE_BIN_PATH" ] && [ "$(ls -A "$UPDATE_BIN_PATH")" ]; then
		cp -r  $UPDATE_BIN_PATH/*  $CLIENT_BIN_PATH/
		log "更新包中可执行命令更新，无需生成，直接复制到$CLIENT_BIN_PATH"
	fi
}

updateTemplate(){
	if [ -d "$UPDATE_TEMPLATE_PATH" ] && [ "$(ls -A "$UPDATE_TEMPLATE_PATH")" ]; then
		#1、生成application.yml
		if [ -e "$UPDATE_TEMPLATE_PATH"/application.yml ];then
			sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g" \
				-e "s/%%%clientPort%%%/${clientPort}/g" \
				-e "s/%%%osName%%%/${osName}/g" \
				-e "s/%%%osVersion%%%/${osVersion}/g" \
				$UPDATE_TEMPLATE_PATH/application.yml  > $CLIENT_CONFIG_PATH/application.yml
			log "更新包中发现application.yml，读取配置重新生成配置文件$CLIENT_CONFIG_PATH/application.yml"
		fi
		
		#2、生成run.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/run.sh ];then
			sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g"  \
				-e "s/%%%jdkdir%%%/${JDK_HOME//\//\\/}/g"  \
				$UPDATE_TEMPLATE_PATH/run.sh  > $CLIENT_BIN_PATH/run.sh
			log "更新包中发现run.sh，读取配置重新生成脚本文件$CLIENT_BIN_PATH/run.sh"
		fi
		
		
		
		#3、生成updateClient.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/updateClient.sh ];then
			sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g"  $UPDATE_TEMPLATE_PATH/updateClient.sh  > $CLIENT_BIN_PATH/updateClient.sh
			log "更新包中发现updateClient.sh，读取配置重新生成脚本文件$CLIENT_BIN_PATH/updateClient.sh"
		fi
		
		#4、生成uninstall.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/uninstall.sh ];then
			sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g"  $UPDATE_TEMPLATE_PATH/uninstall.sh  > $CLIENT_BASE_PATH/install/uninstall.sh
			cp $CLIENT_BASE_PATH/install/uninstall.sh $CLIENT_BIN_PATH/
			log "更新包中发现uninstall.sh，读取配置重新生成脚本文件$CLIENT_BASE_PATH/install/uninstall.sh"
		fi
		
		#5、生成恢复出厂recoverClient.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/recoverClient.sh ];then
			sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g" \
					$UPDATE_TEMPLATE_PATH/recoverClient.sh  > $CLIENT_BIN_PATH/recoverClient.sh
			log "更新包中发现recoverClient.sh，读取配置重新生成脚本文件$CLIENT_BIN_PATH/recoverClient.sh"
		fi
		
		#6、生成备份backupClient.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/backupClient.sh ];then
			sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g" \
					$UPDATE_TEMPLATE_PATH/backupClient.sh  > $CLIENT_BIN_PATH/backupClient.sh
			log "更新包中发现backupClient.sh，读取配置重新生成脚本文件$CLIENT_BIN_PATH/backupClient.sh"
		fi
		
		#7、生成还原restoreClient.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/restoreClient.sh ];then
			sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g" \
					$UPDATE_TEMPLATE_PATH/restoreClient.sh  > $CLIENT_BIN_PATH/restoreClient.sh
			log "更新包中发现restoreClient.sh，读取配置重新生成脚本文件$CLIENT_BIN_PATH/restoreClient.sh"
		fi
	fi
}

updateJsp(){
	JSP_CONFIG_FILE=$UPDATE_JSP_PATH/jsp.config
	if [ -d "$UPDATE_JSP_PATH" ] && [ "$(ls -A "$UPDATE_JSP_PATH")" ]; then
		if [ -f $JSP_CONFIG_FILE ];then
			ARCH=$(uname -m)
			jsp_install_name=""
			if [ "$ARCH" = "x86_64" ]; then
				jsp_install_name=$(grep "^jsp_x86=" "$JSP_CONFIG_FILE" | cut -d '=' -f 2)
				log "当前系统架构是 x86_64,读取配置文件$INTERNAL_CONFIG_FILE字段jsp_x86"
			elif [ "$ARCH" = "aarch64" ]; then
				jsp_install_name=$(grep "^jsp_aarch64=" "$JSP_CONFIG_FILE" | cut -d '=' -f 2)
				log "当前系统架构是 aarch64, 读取配置文件$INTERNAL_CONFIG_FILE字段jsp_aarch64"
			fi
			
			if [ -z $jsp_install_name ];then
				log "读取JSP安装文件名为空，JSP工具不做更新"
			else
				if [ -e $UPDATE_JSP_PATH/$jsp_install_name ];then
					log "读取JSP安装文件名$jsp_install_name，发现JSP工具安装文件$UPDATE_JSP_PATH/$jsp_install_name，开始更新JSP工具..."
					uninstall_jsp
					install_jsp $UPDATE_JSP_PATH/$jsp_install_name
				else
					warn "读取JSP安装文件名$jsp_install_name，但$UPDATE_JSP_PATH/$jsp_install_name文件不存在。JSP工具不做更新"
				fi
			fi
		fi
	fi
}

restartService(){
	chmod 755 $CLIENT_BIN_PATH/*.sh
	chmod 755 $CLIENT_BASE_PATH/install/*.sh
	systemctl restart $SERVICE_NAME
	log "已执行重启命令，客户端服务重启中..."
	log "可在目录$CLIENT_LOG_PATH下查找日志，查看启动情况"
}

##=======================================================



##主方法。部署过程拆分成一个个方法，都在main方法中调用。
main(){
    # 获取当前日期和时间作为日志的前缀
	CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
	log "========================="
    log "更新开始 at $CURRENT_TIME"
	log "---step1：读取更新配置---"
	readConfig;
	
	log "---step2：检查app/config目录---"
	updateAppConfig;
	
	log "---step3：检查app/lib目录---"
	updateLib;
	
	log "---step4：检查app/license目录---"
	updateAppLicense;
	
	log "---step5：检查app目录下客户端主程序---"
	updateZxclientJar;
	
	log "---step6：检查bin目录---"
	updateBin;
	
	log "---step7：检查install/template目录---"
	updateTemplate;
	
	log "---step8：检查JSP工具是否要更新---"
	updateJsp;
	
	log "---step9：各项都检查、更新完毕，更新版本文件---"
	mv  $CLIENT_BASE_PATH/version.txt  $CLIENT_UPDATE_PATH/version_old.txt
	cp  $SCRIPT_DIR/version.txt  $CLIENT_BASE_PATH/version.txt
	
	log "---step10：重启客户端服务---"
	restartService;
	log "======$CURRENT_TIME 更新结束============="
}

#=====================================================================
if [ $# -ne 1 ]; then
    error "错误：脚本需要一个参数（客户端安装基础路径）。"
fi
#变量：安装包路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UPDATE_APP_PATH=$SCRIPT_DIR/app
UPDATE_CONFIG_PATH=$UPDATE_APP_PATH/config
UPDATE_LIB_PATH=$UPDATE_APP_PATH/lib
UPDATE_LICENSE_PATH=$UPDATE_APP_PATH/license
UPDATE_ZXCLIENT_JAR=$UPDATE_APP_PATH/zx_client-1.0.0-SNAPSHOT.jar
UPDATE_BIN_PATH=$SCRIPT_DIR/bin
UPDATE_INSTALL_PATH=$SCRIPT_DIR/install
UPDATE_JSP_PATH=$UPDATE_INSTALL_PATH/jsp
UPDATE_TEMPLATE_PATH=$UPDATE_INSTALL_PATH/template

#变量：当前部署客户端路径
CLIENT_BASE_PATH=$1
CLIENT_APP_PATH=${CLIENT_BASE_PATH}/app
CLIENT_BIN_PATH=${CLIENT_BASE_PATH}/bin
CLIENT_CONFIG_PATH=${CLIENT_APP_PATH}/config
CLIENT_LICENSE_PATH=${CLIENT_APP_PATH}/license
CLIENT_UPDATE_PATH=${CLIENT_BASE_PATH}/update_client
CLIENT_LOG_PATH=/var/log/zx_client
UPDATE_LOG_FILE="${CLIENT_LOG_PATH}/client_update.log"
SERVICE_NAME=jusonclient
JDK_HOME=/usr/local/jdk
JSP_INSTALL_PATH=/usr/local/jsp


#变量：读取到的配置
dmsIp=NULL
dmsPort=NULL
clientId=NULL
manageIp=NULL
businessIp=NULL
clientPort=NULL
osName=NULL
osVersion=NULL

## 正式调用方法
checkEnvironment;
main;
