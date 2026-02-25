#!/bin/bash
# 客户端升级脚本。每次打包都要把这个脚本放进升级zip包里。
#客户端升级时会调用这个脚本，这个脚本完成升级文件分发、系统重启等功能。



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
  echo "[$timestamp] [ERROR] Update failed at $(date '+%Y-%m-%d %H:%M:%S')"  2>&1 | tee -a "$LOG_FILE"
  echo "[$timestamp] [ERROR] ========================="  2>&1 | tee -a "$LOG_FILE"
  exit 1
}





checkEnvironment(){
	log "安装文件检查"
	if [ ! -e "$SCRIPT_DIR/version.txt" ];then
		error "升级包内容缺失：版本信息文件version.txt缺失，请确认安装包完整性"
	fi
	last_line=$(awk 'NF {last=$0} END {print last}' "$SCRIPT_DIR/version.txt")
	log "本次更新版本信息：$last_line"
}

readConfig(){
	local INTERNAL_CONFIG_FILE=$CLIENT_CONFIG_PATH/internal.config
	
	if [[ ! -f "$INTERNAL_CONFIG_FILE" ]]; then
		error "应用内部配置文件不存在: $INTERNAL_CONFIG_FILE"
	fi
	# 读取并解析配置文件
	while IFS= read -r line || [[ -n "$line" ]]; do
	  line="${line#"${line%%[! ]*}"}"   # 去除行首的空格
	  # 忽略空行和注释行
	  if [[ -z "$line" ]] || [[ $line == "#"* ]]; then
		continue
	  fi
	  
	  IFS='=' read -r key value <<< "$line"
	  value="${value%%[#]*}"    # 去除值两边的空格和可能的注释
	  value="${value#"${value%%[! ]*}"}"   # 去除行首的空格
	  value="${value%"${value##*[^ ]}"}"   # 去除行尾的空格
	  
	  if [ -z "$value" ];then
          error "${INTERNAL_CONFIG_FILE}中配置项[$key]为空"
	  fi
	  log "读取到配置：[$key=${value}]"
	  export "$key=${value}"
	done < "$INTERNAL_CONFIG_FILE"
}


updateBaselineClientJar(){
	if [ -e "$UPDATE_CLIENT_JAR" ];then
		cp $UPDATE_CLIENT_JAR  $CLIENT_APP_PATH/
		log "更新包中发现blsec_client-1.0.0-SNAPSHOT.jar，复制到$CLIENT_APP_PATH"
	fi
}
 
updateAppConfig(){
	if [ -d "$UPDATE_CONFIG_PATH" ] && [ "$(ls -A "$UPDATE_CONFIG_PATH")" ]; then
		cp  -r $UPDATE_CONFIG_PATH/* $CLIENT_CONFIG_PATH/
		log "更新包中发现配置更新，复制到$CLIENT_CONFIG_PATH"
	fi
}

#lib java运行依赖的第三方jar包
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

updateBin(){
	if [ -d "$UPDATE_BIN_PATH" ] && [ "$(ls -A "$UPDATE_BIN_PATH")" ]; then
		cp -r  $UPDATE_BIN_PATH/*  $CLIENT_BIN_PATH/
		log "更新包中可执行命令更新，无需生成，直接复制到$CLIENT_BIN_PATH"
	fi
}

updateTemplate(){
	if [ -d "$UPDATE_TEMPLATE_PATH" ] && [ "$(ls -A "$UPDATE_TEMPLATE_PATH")" ]; then
		#1、application.yml
		if [ -e "$UPDATE_TEMPLATE_PATH"/application.yml ];then
			appKey=${setup_version%_*}    
	        appVersion=${setup_version##*_}
            
	        sed -e "s/%%%appKey%%%/${appKey}/g" \
	        	-e "s/%%%appVersion%%%/${appVersion}/g" \
	        	-e "s/%%%datadir%%%/${CLIENT_DATA_PATH//\//\\/}/g" \
	        	-e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g" \
	        	$UPDATE_TEMPLATE_PATH/application.yml  > $CLIENT_CONFIG_PATH/application.yml
			log "更新包中发现application.yml，读取配置重新生成配置文件$CLIENT_CONFIG_PATH/application.yml"
		fi
		
		#2、run.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/run.sh ];then
		    sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g" \
		        -e "s/%%%javadir%%%/${JDK_HOME//\//\\/}/g" \
		        $UPDATE_TEMPLATE_PATH/run.sh  > $CLIENT_BIN_PATH/run.sh
			log "更新包中发现run.sh，读取配置重新生成配置文件$CLIENT_BIN_PATH/run.sh"
		fi
		
		#3、updateClient.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/updateClient.sh ];then
		    sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g"  $UPDATE_TEMPLATE_PATH/updateClient.sh  > $CLIENT_BIN_PATH/updateClient.sh
			log "更新包中发现updateClient.sh，读取配置重新生成配置文件$CLIENT_BIN_PATH/updateClient.sh"
		fi
		
		#4、uninstall.sh
		if [ -e "$UPDATE_TEMPLATE_PATH"/uninstall.sh ];then
		    sed -e "s/%%%basedir%%%/${CLIENT_BASE_PATH//\//\\/}/g" \
		        -e "s/%%%datadir%%%/${CLIENT_DATA_PATH//\//\\/}/g" \
		        -e "s/%%%logdir%%%/${CLIENT_LOG_PATH//\//\\/}/g" \
		        $UPDATE_TEMPLATE_PATH/uninstall.sh  > $CLIENT_BASE_PATH/install/uninstall.sh
			
			cp $CLIENT_BASE_PATH/install/uninstall.sh $CLIENT_BIN_PATH/
			log "更新包中发现uninstall.sh，读取配置重新生成配置文件$CLIENT_BASE_PATH/install/uninstall.sh"
		fi
		
		#5、log4j2.yml
		if [ -e "$UPDATE_TEMPLATE_PATH"/log4j2.yml ];then
		    sed -e "s/%%%logdir%%%/${CLIENT_LOG_PATH//\//\\/}/g" \
		        $UPDATE_TEMPLATE_PATH/log4j2.yml  > $CLIENT_CONFIG_PATH/log4j2.yml
			log "更新包中发现log4j2.yml，读取配置重新生成配置文件$CLIENT_CONFIG_PATH/log4j2.yml"
		fi
	fi
}

updateCheck(){
    local osNmae=$(grep '^NAME=' /etc/os-release | cut -d '"' -f2)
	local version=$(grep '^VERSION=' /etc/os-release | cut -d '"' -f2)
	local checkDirName=
	log "查询/etc/os-release获得NAME=${osNmae}, VERSION=${version}"
	if [ "$osNmae" == "CentOS Linux" ];then
	    checkDirName="centos"
		log "当前系统为CENTOS系统，使用${checkDirName}下的检测命令"
	elif [ "$osNmae" == "Kylin Linux Advanced Server" ];then
        checkDirName="KylinServer"
		log "当前系统为麒麟服务系统，使用${checkDirName}下的检测命令"
	elif [ "$osNmae" == "Ubuntu" ];then
        checkDirName="Ubuntu"
		log "当前系统为乌班图系统，使用${checkDirName}下的检测命令"
	elif [ "$osNmae" = "Kylin" ] && (echo "$version" | grep -i "桌面" > /dev/null || echo "$version" | grep -i "Desktop" > /dev/null); then
        checkDirName="KylinDesktop"
		log "当前系统为麒麟桌面系统，使用${checkDirName}下的检测命令"
	elif [ "$osName" = "KylinSec OS Linux" ];then
	    checkDirName="KylinSec"
		log "当前系统为麒麟信安服务版本，使用${checkDirName}下的检测命令"
	fi
	
	if [ -e "${UPDATE_CHECK_PATH}/${checkDirName}/baselineCheck.sh" ];then
	    log "发现更新命令文件[${UPDATE_CHECK_PATH}/${checkDirName}/baselineCheck.sh]"
		cp "${UPDATE_CHECK_PATH}/${checkDirName}/baselineCheck.sh"  ${CLIENT_BIN_PATH}/
	fi

}

restartService(){
	chmod 755 $CLIENT_BIN_PATH/*.sh
	chmod 755 $CLIENT_BASE_PATH/install/*.sh
	systemctl restart $SERVICE_NAME
	log "已执行重启命令，客户端服务重启中..."
}


##主方法。部署过程拆分成一个个方法，都在main方法中调用。
main(){
    # 获取当前日期和时间作为日志的前缀
	CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
	log "========================="
    log "更新开始 at $CURRENT_TIME"
	log "---step1：读取更新配置---"
	#readConfig;
	
	log "---step2：检查app/config目录---"
	updateAppConfig;
	
	log "---step3：检查app/lib目录---"
	updateLib;
	
	log "---step4：检查app/license目录---"
	updateAppLicense;
	
	log "---step5：检查app目录下客户端主程序---"
	updateBaselineClientJar;
	
	log "---step6：检查bin目录---"
	updateBin;
	
	log "---step7：检查install/template目录---"
	updateTemplate;
	
	log "---step8：检查install/check目录---"
	updateCheck;
	
	log "---step8：各项都检查、更新完毕，更新版本文件---"
	mv  $CLIENT_BASE_PATH/version.txt  $CLIENT_UPDATE_PATH/version_old.txt
	cp  $SCRIPT_DIR/version.txt  $CLIENT_BASE_PATH/version.txt
	
	log "---step9：重启客户端服务---"
	restartService;
	log "======$CURRENT_TIME 更新结束============="
}


#=====================================================================
if [ $# -ne 1 ]; then
    error "错误：脚本需要一个参数（客户端安装基础路径）。"
fi
#安装包路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UPDATE_APP_PATH=$SCRIPT_DIR/app
UPDATE_CONFIG_PATH=$UPDATE_APP_PATH/config
UPDATE_LIB_PATH=$UPDATE_APP_PATH/lib
UPDATE_LICENSE_PATH=$UPDATE_APP_PATH/license
UPDATE_CLIENT_JAR=$UPDATE_APP_PATH/blsec_client-1.0.0-SNAPSHOT.jar
UPDATE_BIN_PATH=$SCRIPT_DIR/bin
UPDATE_INSTALL_PATH=$SCRIPT_DIR/install
UPDATE_CHECK_PATH=$UPDATE_INSTALL_PATH/check
UPDATE_TEMPLATE_PATH=$UPDATE_INSTALL_PATH/template

# 客户端部署路径
CLIENT_BASE_PATH=$1
CLIENT_DATA_PATH=/jsdata/baseline
log "客户端调用，传来参数：[$1]"
#客户端安装目录
CLIENT_APP_PATH=${CLIENT_BASE_PATH}/app
CLIENT_BIN_PATH=${CLIENT_BASE_PATH}/bin
CLIENT_CONFIG_PATH=${CLIENT_APP_PATH}/config
CLIENT_LICENSE_PATH=${CLIENT_APP_PATH}/license
CLIENT_LOG_PATH=/var/log/zx_blsec
#更新程序日常目录
CLIENT_UPDATE_PATH=${CLIENT_BASE_PATH}/update_client
LOG_FILE="${CLIENT_UPDATE_PATH}/update.log"
SERVICE_NAME=baselineclient
JAVA_HOME=/usr/local/jdk
setup_version=''


## 正式调用方法
checkEnvironment;
main;