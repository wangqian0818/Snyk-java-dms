#!/bin/bash
#@Auth：zx
readLoginDefs(){
    local fieldName=$1
	local line=`cat /etc/login.defs | grep ${fieldName} | grep -v ^#`
	local fieldValue
	if [ -n "$line" ];then
		fieldValue=`echo $line | awk '{print $2}' | xargs`
	fi
	echo $fieldValue
}

checkItem_2_1(){
	#check_point="账号口令-2.1：检查是否设置口令生存周期"
	#2.1	检查是否以设置口令生存周期	严重	长期不修改密码会增加密码暴露风险，除入域服务器或服务器超管账号分段管理无需配置外，应对服务器密码最长使用期限进行限制。此检查项建议调整	<=30
	#在文件etc/login.defs中搜索pass_max_days的值，并且去掉#自开头的值
	#grep -v ^#    ------>  不匹配以#开头的行
	local value=$(readLoginDefs PASS_MAX_DAYS)

	if [ -n "$value" ]; then
		if [ "$value" -gt 30 ]; then
			check_value=$value
			check_result="未通过"
		else
			check_value=$value
			check_result="通过"
		fi
	else
		check_value="无此配置"
		check_result="未通过"
	fi
}



checkItem_2_3(){
	#check_point="账号口令-2.3:检查是否设置口令过期警告天数 "
	#2.3	检查是否设置口令过期警告天数	低	除入域服务器超管账号分段管理无需配置外，应配置密码过期提醒策略防止密码过期无法登陆。此检查项建议调整	>=5
	local value=$(readLoginDefs PASS_WARN_AGE)

	if [ -n "$value" ]; then
		if [ "$value" -lt 5 ]; then
			check_value=$value
			check_result="未通过"
		else
			check_value=$value
			check_result="通过"
		fi
	else
		check_value="无此配置"
		check_result="未通过"
	fi
}



checkItem_2_4(){
	#check_point="账号口令-2.4:检查是否设置设备密码复杂度策略"
	local SYSTEM_AUTH_CONFIG_FILE="/etc/pam.d/system-auth"
	local PASSWORD_AUTH_CONFIG_FILE="/etc/pam.d/password-auth"
	local errorMsg=""
	# system-auth中pam_pwquality.so模块
	local system_error_msg=''
	
	local system_minlen=$(parse_pwquality_config ${SYSTEM_AUTH_CONFIG_FILE} "minlen")
	local system_ucredit=$(parse_pwquality_config ${SYSTEM_AUTH_CONFIG_FILE} "ucredit")
	local system_lcredit=$(parse_pwquality_config ${SYSTEM_AUTH_CONFIG_FILE} "lcredit")
	local system_dcredit=$(parse_pwquality_config ${SYSTEM_AUTH_CONFIG_FILE} "dcredit")
	local system_ocredit=$(parse_pwquality_config ${SYSTEM_AUTH_CONFIG_FILE} "ocredit")
	
	if [[ -z "$system_minlen" ]]; then
	    system_error_msg+="最小长度minlen应至少为10，当前未配置;"
	elif [[ "$system_minlen" -lt 10 ]]; then
        system_error_msg+="最小长度minlen应至少为10，当前值为${system_minlen};"
    fi

    if [[ -z "$system_ucredit" ]]; then
	    system_error_msg+="大写字母要求ucredit应至少为1，当前未配置;"
	elif [[ "$system_ucredit" -lt 1 ]]; then
        system_error_msg+="大写字母要求ucredit应至少为1，当前值为${system_ucredit};"
    fi

    if [[ -z "$system_lcredit" ]]; then
	    system_error_msg+="小写字母要求lcredit应至少为1，当前未配置;"
	elif [[ "$system_lcredit" -lt 1 ]]; then
        system_error_msg+="小写字母要求lcredit应至少为1，当前值为${system_lcredit};"
    fi

    if [[ -z "$system_dcredit" ]]; then
	    system_error_msg+="数字要求dcredit应至少为1，当前未配置;"
	elif [[ "$system_dcredit" -lt 1 ]]; then
        system_error_msg+="数字要求dcredit应至少为1，当前值为${system_dcredit};"
    fi

    if [[ -z "$system_ocredit" ]]; then
	    system_error_msg+="特殊字符要求ocredit应至少为1，当前未配置;"
	elif [[ "$system_ocredit" -lt 1 ]]; then
        system_error_msg+="特殊字符要求ocredit应至少为1,当前值为${system_ocredit};"
    fi
	
	# password-auth中pam_pwquality.so模块
	local password_error_msg=''
	
	local password_minlen=$(parse_pwquality_config ${PASSWORD_AUTH_CONFIG_FILE} "minlen")
	local password_ucredit=$(parse_pwquality_config ${PASSWORD_AUTH_CONFIG_FILE} "ucredit")
	local password_lcredit=$(parse_pwquality_config ${PASSWORD_AUTH_CONFIG_FILE} "lcredit")
	local password_dcredit=$(parse_pwquality_config ${PASSWORD_AUTH_CONFIG_FILE} "dcredit")
	local password_ocredit=$(parse_pwquality_config ${PASSWORD_AUTH_CONFIG_FILE} "ocredit")
	
	if [[ -z "$password_minlen" ]]; then
	    password_error_msg+="最小长度minlen应至少为10，当前未配置;"
	elif [[ "$password_minlen" -lt 10 ]]; then
        password_error_msg+="最小长度minlen应至少为10，当前值为${password_minlen};"
    fi

    if [[ -z "$password_ucredit" ]]; then
	    password_error_msg+="大写字母要求ucredit应至少为1，当前未配置;"
	elif [[ "$password_ucredit" -lt 1 ]]; then
        password_error_msg+="大写字母要求ucredit应至少为1，当前值为${password_ucredit};"
    fi

    if [[ -z "$password_lcredit" ]]; then
	    password_error_msg+="小写字母要求lcredit应至少为1，当前未配置;"
	elif [[ "$password_lcredit" -lt 1 ]]; then
        password_error_msg+="小写字母要求lcredit应至少为1，当前值为${password_lcredit};"
    fi

    if [[ -z "$password_dcredit" ]]; then
	    password_error_msg+="数字要求dcredit应至少为1，当前未配置;"
	elif [[ "$password_dcredit" -lt 1 ]]; then
        password_error_msg+="数字要求dcredit应至少为1，当前值为${password_dcredit};"
    fi

    if [[ -z "$password_ocredit" ]]; then
	    password_error_msg+="特殊字符要求ocredit应至少为1，当前未配置;"
	elif [[ "$password_ocredit" -lt 1 ]]; then
        password_error_msg+="特殊字符要求ocredit应至少为1,当前值为${password_ocredit};"
    fi
	
	if [ -n ${system_error_msg} ];then
	    errorMsg+="system-auth配置缺失：[${system_error_msg}]|"
	fi
	if [ -n ${password_error_msg} ];then
	    errorMsg+="password-auth配置缺失：[${password_error_msg}]"
	fi
	
	if [[ -n "$errorMsg" ]]; then
		check_value="${errorMsg}"
	    check_result="未通过"
	else
		check_value="配置符合要求"
	    check_result="通过"
	fi
}

# 查询指定的字段
parse_pwquality_config() {
	local CONFIG_FILE="$1";
    local fieldName="$2"    #minlen ucredit lcredit dcredit ocredit

	# pam配置文件中模块配置优先
	local result=$(grep -v '^#' "${CONFIG_FILE}" | grep "password.*pam_pwquality.so" | grep -oP "${fieldName}=\K\d+")

	
	if [[ -z "$result" ]]; then
	    result=$(grep -v '^#' /etc/security/pwquality.conf | grep "${fieldName}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | awk -F'=' '{print $2}' | xargs)
	fi
    
	echo $result
}
 

checkItem_2_5(){
	#echo "2.5	检查是否存在空口令账户	重要	建议调整	由于空口令会让攻击者不需要口令进入系统，存在较大风险。此检查项建议调整	不存在空口令账户

	readarray -t users < <(
		awk -F: '$3>=1000 && $3!=65534 {print $1}' /etc/passwd |
		while read -r u; do
			p=$(awk -F: -v u="$u" '$1==u {print $2}' /etc/shadow)
			case "$p" in ''|!|!!) echo "$u";; esac
		done
	)

	# 2. 统计数量
	empty_password_count=${#users[@]}

	# 3. 拼逗号分隔的账号名
	IFS=,; empty_password_users="${users[*]}"
	
	if (( empty_password_count == 0 )); then
		check_value="不存在空口令账户"
	    check_result="通过"
	else
		check_value="发现[$empty_password_users]等$empty_password_count个空口令账号"
	    check_result="未通过"
	fi
}

checkItem_2_7(){
	#check_point="账号口令-2.7：检查密码修改最小间隔时间"
	#2.7	检查密码修改最小间隔时间	中	为防止用户短时间反复改密码，检查是否设置密码修改最小间隔时间 此检查项建议调整 推荐值>=1
	local value=$(readLoginDefs PASS_MIN_DAYS)

	if [ -n "$value" ]; then
		if [ "$value" -lt 1 ]; then
			check_value=$value
			check_result="未通过"
		else
			check_value=$value
			check_result="通过"
		fi
	else
		check_value="无此配置"
		check_result="未通过"
	fi
}

checkItem_3_4(){
	#echo "3.4	检查用户目录缺省访问权限设置	重要	建议调整	控制用户缺省访问权限，当在创建新文件或目录时应屏蔽掉新文件或目录不应有的访问允许权限，防止同属于改组的其他用户及别的组的用户修改用户的文件或更高限制。此检查项建议调整	027
	local errorMsg=""
	local FOUND_VAL=""
	local PROFILE_D_OK=0
	for f in /etc/profile.d/*.sh; do
		[[ -f $f ]] || continue
		# 取最后一个有效 umask 行（避免注释）
		val=$(sed 's/#.*//' "$f" | awk '$1=="umask" {print $2}' | tail -n1)
		[[ -n $val ]] && FOUND_VAL="$val"   # 记录最后一次出现的值
	done

	if [[ -z $FOUND_VAL ]]; then
		errorMsg+="没发现umask全局配置"
	else
		if [[ $FOUND_VAL == "027" ]]; then
			PROFILE_D_OK=1
		else
		    errorMsg+="发现umask全局配置，值为$FOUND_VAL（不合规，期望027）"
		fi
	fi

	if [[ $PROFILE_D_OK -eq 1 ]]; then
	    UID_MIN=$(awk '/^UID_MIN/{print $2}' /etc/login.defs)
		UID_MAX=$(awk '/^UID_MAX/{print $2}' /etc/login.defs)
		SHELL_RE='bash$|zsh$|sh$|csh$|tcsh$|ksh$|fish$'
		BAD_USERS=""       # 用逗号拼接的不合规用户名

		while IFS=: read -r login _ uid _ _ home shell; do
			# 只扫普通用户且家目录存在、shell 合法
			(( uid >= UID_MIN && uid <= UID_MAX )) || continue
			[[ -d $home && -x $shell ]] || continue
			[[ $shell =~ $SHELL_RE ]] || continue

			umask_out=$(sudo -iu "$login" "$shell" -lc 'umask' 2>/dev/null)			
			if [[ -z "$umask_out" ]]; then
				[[ -n $BAD_USERS ]] && BAD_USERS+=","
				BAD_USERS+="用户$login获取umask为空"
			else
				if [[ "$umask_out" != "0027" ]];then
					[[ -n $BAD_USERS ]] && BAD_USERS+=","
					BAD_USERS+="用户$login获取到umask=${umask_out}"
				fi
			fi	
		done < /etc/passwd
		
		if [ -n "${BAD_USERS}" ];then
			errorMsg="全局设置了umask=${FOUND_VAL}，但发现个别用户生效配置不合规：[${BAD_USERS}]。检查这些用户局部配置"
		fi
	fi
	
	
	if [[ -n "$errorMsg" ]]; then
		check_value="${errorMsg}"
	    check_result="未通过"
	else
		check_value="已设置为umask=027"
	    check_result="通过"
	fi
}


checkItem_4_4(){
	#check_point="日志审计-4.4:检查是否对登录进行日志记录"
	#4.4	检查是否对登录进行日志记录	严重	建议调整	应对登录时间日志文件进行配置，保证日志的完整性。此检查项建议调整	参考《Linux系统安全配置基线》对应章节
	# 检查 /var/log/wtmp 或 /var/run/wtmp 文件是否存在
	local error_msg=''
	if [ ! -f "/var/log/wtmp" ] && [ ! -f "/var/run/wtmp" ];then
	    error_msg+='wtmp文件不存在'
	fi
	
    if [ ! -f "/var/log/utmp" ] && [ ! -f "/var/run/utmp" ];then
	    error_msg+='utmp文件不存在'
	fi

     

    # 检查 last 命令是否能正常工作
    last_output=$(last 2>&1)
    if echo "$last_output" | grep -q "wtmp begins"; then
        :
    else
        error_msg+="last命令异常;"
    fi

    # 检查 who 命令是否能正常工作
    who_output=$(who 2>&1)
    if echo "$who_output" | grep -q "no utmp"; then
        error_msg+="who命令异常;"
    fi

    if [[ -n $error_msg ]]; then
		check_value="登录日志相关功能异常：${error_msg}"
	    check_result="未通过"
	else
		check_value="登录日志相关功能正常"
	    check_result="通过"
	fi
}

checkItem_5_5(){
	#check_point="协议安全-5.5:检查是否禁止匿名用户登录FTP"
	#5.5	检查是否禁止匿名用户登录FTP	高	由于匿名用户对被黑客用来进入ftp，导致系统文件的保密性和完整性遭到破坏。此检查项建议调整	参考《Linux系统安全配置基线》对应章节
    ftp_work='false'
	FTP_SERVICE="vsftpd"  
    # 检查服务是否存在
    if systemctl list-units --full -all | grep -q "${FTP_SERVICE}.service"; then
        # 检查服务是否正在运行
        if systemctl is-active --quiet $FTP_SERVICE; then
            ftp_work='true'
        fi
    fi
	
	if [ "$ftp_work" = "false" ]; then
		check_value="ftp服务未启动"
	    check_result="通过"
	else
		anonymous_enable_config=`cat /etc/vsftpd/vsftpd.conf | grep anonymous_enable | grep -v ^#`
		if [ -n "$anonymous_enable_config" ]; then
			anonymous_enable_value=$(echo "$anonymous_enable_config" | awk -F'=' '{print $2}' | xargs)
			if [ "$anonymous_enable_value" == "NO" ]; then
				check_value="ftp服务已配置anonymous_enable=NO"
				check_result="通过"
			else
				check_value="ftp服务启动但未禁止匿名用户登陆：配置anonymous_enable=$anonymous_enable_value"
				check_result="未通过"
			fi
		else
			check_value="ftp服务启动但未禁止匿名用户登陆：未配置anonymous_enable=NO"
			check_result="未通过"
	    fi	    
	fi
}


checkItem_6_1(){
	#check_point="其他配置-6.1:检查是否设置命令行界面超时退出"
	#6.1	检查是否设置命令行界面超时退出	高	根据等保要求，建议设置超时时间不大于5分钟，此检查项建议系统管理员根据系统情况自行判断	<=300
	local MAX_TMOUT=300
	########################################
	# 1. 在 /etc/profile.d 里找 TMOUT 赋值
	########################################
	local errorMsg=""
	local FOUND_VAL=""
	local PROFILE_D_OK=0
	for f in /etc/profile.d/*.sh; do
		[[ -f $f ]] || continue
		# 去掉注释后取最后一个 TMOUT=数字
		val=$(sed 's/#.*//' "$f" | grep -E '^\s*(export\s+)?TMOUT\s*=' | sed -E 's/.*TMOUT\s*=\s*([0-9]+).*/\1/' | tail -n1)
		[[ -n $val ]] && FOUND_VAL="$val"
	done

	if [[ -z "$FOUND_VAL" ]]; then
		errorMsg+="没发现全局TMOUT配置"
	else
		if (( FOUND_VAL > MAX_TMOUT )); then
			errorMsg+="发现全局TMOUT配置，值为$FOUND_VAL（不合规，期望<=${MAX_TMOUT}）"
		else
		    PROFILE_D_OK=1
		fi
	fi

	########################################
	# 3. 遍历所有本地用户，模拟登录测 TMOUT
	########################################
	if [[ $PROFILE_D_OK -eq 1 ]]; then
		UID_MIN=$(awk '/^UID_MIN/{print $2}' /etc/login.defs)
		UID_MAX=$(awk '/^UID_MAX/{print $2}' /etc/login.defs)
		SHELL_RE='bash$|zsh$|sh$|csh$|tcsh$|ksh$|fish$'
		local BAD_USERS=""

		while IFS=: read -r login _ uid _ _ home shell; do
			(( uid >= UID_MIN && uid <= UID_MAX )) || continue
			[[ -d $home && -x $shell ]] || continue
			[[ $shell =~ $SHELL_RE ]] || continue

			# 模拟登录后读 TMOUT（未设置为空）
			tmout_out=$(sudo -iu "$login" "$shell" -lc 'echo ${TMOUT}' 2>/dev/null)
			
			if [[ -z "$tmout_out" ]]; then
				[[ -n $BAD_USERS ]] && BAD_USERS+=","
				BAD_USERS+="用户$login获取TMOUT为空"
			else
				if (( tmout_out > MAX_TMOUT )); then
					[[ -n $BAD_USERS ]] && BAD_USERS+=","
					BAD_USERS+="用户$login获取到TMOUT=${tmout_out}"
				fi
			fi			
		done < /etc/passwd

		if [ -n "${BAD_USERS}" ];then
			errorMsg="全局设置了TMOUT=${FOUND_VAL}，但发现个别用户生效配置不合规：[${BAD_USERS}]。检查这些用户局部配置"
		fi
	fi
	
	if [[ -n "$errorMsg" ]]; then
		check_value="${errorMsg}"
	    check_result="未通过"
	else
		check_value="TMOUT配置符合要求"
	    check_result="通过"
	fi
}


checkItem_6_5(){
	#check_point="其他配置-6.5:检查是否使用PAM认证模块禁止wheel组之外的用户su为root"
	local error_msg=''
    local PAM_SU_FILE="/etc/pam.d/su"
    

	# 初始化标志变量

	wheel_found=false
	while IFS= read -r line; do
		# 忽略空行和以 # 开头的注释行
		if [[ -z "$line" || "$line" =~ ^\ *# ]]; then
			continue
		fi
	
		if echo "$line" | grep -qE "^auth\s+required\s+pam_wheel.so\s+use_uid"; then
			wheel_found=true
		fi
	done < "$PAM_SU_FILE"

	# 检查配置是否存在
	if [ "$wheel_found" = false ]; then
		error_msg+="pam_wheel.so模块未正确配置;"
	fi	
	
	if [[ -n $error_msg ]]; then
		check_value="${error_msg}"
	    check_result="未通过"
	else
		check_value="已正确配置"
	    check_result="通过"
	fi
}

checkItem_6_13(){
    #检查超时锁屏的空闲等待时间
	# 桌面系统可以安装多个。只要检测到安装了，就要配置锁屏时间
	# 检测逻辑
	local error_msg=''
	if check_desktop_environment "GNOME" "gnome-shell"; then
	    idle_enable=$(gsettings get org.gnome.desktop.screensaver lock-enabled | tr -d '[:space:]')
        idle_delay=$(gsettings get org.gnome.desktop.session idle-delay | awk '{print $2}'| tr -d '[:space:]')
		
		if [ -n "$idle_enable" ] && [ "$idle_enable" = 'true' ];then
		    if [[ -n $idle_delay ]]; then
				if [[ "$idle_delay" =~ ^[0-9]+$ ]]; then
					if [ "$idle_delay" -gt 300 ]; then
						error_msg+="GNOME开启了锁屏但超时锁屏时间小于5分钟；"
					fi
				else
					error_msg+="GNOME开启了锁屏但超时锁屏时间配置异常；"
				fi
			else
			    error_msg+="GNOME开启了锁屏但超时锁屏时间未配置；"
			fi
		fi
    fi
	
	if check_desktop_environment "KDE" "plasma-desktop"; then
        idle_delay=$(qdbus org.freedesktop.ScreenSaver /ScreenSaver org.freedesktop.ScreenSaver.GetSessionIdleTimeout)
        if [[ "$idle_delay" =~ ^[0-9]+$ ]]; then
            if [ "$idle_delay" -gt 300000 ]; then
                error_msg+="安装了KDE但未配置超时锁屏时间大于5分钟；"
            fi
        else
            error_msg+="安装了KDE但未配置超时锁屏时间；"
        fi
    fi
	
	
	if [[ -n $error_msg ]]; then
		# 删除最后一个字符（如果它是逗号）
		if [[ ${error_msg: -1} == "," ]]; then
			error_msg=${error_msg%,}
		fi
		check_value="${error_msg}"
	    check_result="未通过"
	else
		check_value="配置正确"
	    check_result="通过"
	fi
 
}
# 检查桌面环境是否完整安装
check_desktop_environment() {
    local desktop_name=$1
    local package_name=$2

    if rpm -q "$package_name" > /dev/null 2>&1; then
        #echo "$desktop_name 桌面环境已完整安装。"
        return 0
    else
        #echo "$desktop_name 桌面环境未完整安装。"
        return 1
    fi
}




checkItem_6_19(){
	#check_point="其他配置-6.19:检查系统是否关闭系统信任机制"
	#6.19	检查系统是否关闭系统信任机制	中	如不关闭系统信任机制，在信任地址列表中的来访用户可不用提供口令就在本地计算机上执行远程命令。此检查项建议调整	=0
	SSH_CONFIG_FILE="/etc/ssh/sshd_config"

	# 检查 RhostsRSAAuthentication 配置   设置为yes就不通过
	RHOSTS_RSA=`cat $SSH_CONFIG_FILE |grep  RhostsRSAAuthentication | egrep -v ^\# | awk  '{print $2}' | xargs`
	# 检查 HostbasedAuthentication 配置  设置为yes就不通过
	HOST_BASE=`cat $SSH_CONFIG_FILE |grep  HostbasedAuthentication | egrep -v ^\# | awk  '{print $2}' | xargs`
	# 检查 PermitEmptyPasswords 配置   设置为yes就不通过
	PERMIT_ERMPTY_PWD=`cat $SSH_CONFIG_FILE |grep  PermitEmptyPasswords | egrep -v ^\# | awk  '{print $2}' | xargs`

	local error_msg='';
	# 判断配置情况
	if [ -n "$RHOSTS_RSA" ] && [ "$RHOSTS_RSA" == "yes" ]; then
	  error_msg='RhostsRSAAuthentication,'
	fi
	if [ -n "$HOST_BASE" ] && [ "$HOST_BASE" == "yes" ]; then
	  error_msg+='HostbasedAuthentication,'
	fi
	if [ -n "$PERMIT_ERMPTY_PWD" ] && [ "$PERMIT_ERMPTY_PWD" == "yes" ]; then
	  error_msg+='PermitEmptyPasswords,'
	fi
	if [[ -n $error_msg ]]; then
		# 删除最后一个字符（如果它是逗号）
		if [[ ${error_msg: -1} == "," ]]; then
			error_msg=${error_msg%,}
		fi
				check_value="${error_msg}当前配置为yes"
	    check_result="未通过"
	else
		check_value="配置正确"
	    check_result="通过"
	fi
}


checkItem_6_21(){
	#check_point="其他配置-6.21:检查是否删除了潜在危险文件"
	#6.21	检查是否删除了潜在危险文件	高	危险文件为删除可能导致用户无口令登录系统，存在较大风险。此检查项建议调整	参考《Linux系统安全配置基线》对应章节
	rhost=`find / -type f -name  .rhost 2>/dev/null`
	netrc=`find / -type f -name  .netrc 2>/dev/null`
	equiv=`find / -type f -name  hosts.equiv 2>/dev/null`

	if [ -z "$rhost" ] && [ -z "$netrc" ] && [ -z "$equiv" ]; then
		check_value="未找到潜在危险文件"
	    check_result="通过"
	else
		errorMsg_6_21='';
		if [ ! -z $rhost ];then
			errorMsg_6_21='rhost,'
		fi
		if [ ! -z $netrc ];then
			errorMsg_6_21+='netrc,'
		fi
		if [ ! -z $equiv ];then
			errorMsg_6_21+='hosts.equiv,'
		fi
		if [[ -n $errorMsg_6_21 ]]; then
			# 删除最后一个字符（如果它是逗号）
			if [[ ${errorMsg_6_21: -1} == "," ]]; then
				errorMsg_6_21=${errorMsg_6_21%,}
			fi
		fi
		check_value="查找到[$errorMsg_6_21]文件"
	    check_result="未通过"
	fi
}


checkItem_6_35(){
	#check_point="其他配置-6.35:检查是否开启高危服务"
	#6.35	检查是否关闭不必要的服务和端口	高	自行判断	不必要的服务会扩大系统的被攻击面，此检查项建议调整	建议关闭
	services=(kshell time ntalk lpd cups sendmail postfix printer klogin nfslock echo discard chargen bootps tftp nfs ypbind ident daytime)

	local error_msg=''
	for service_name in "${services[@]}"; do
        if systemctl list-units --type=service --all | grep -q "$service_name.service"; then
            service_status=$(systemctl is-active "$service_name.service")
            if [[ "$service_status" == "active" ]]; then
			    error_msg+="$service_name,"
            fi
		fi
    done
	
	if [[ -n $error_msg ]]; then
		# 删除最后一个字符（如果它是逗号）
		if [[ ${error_msg: -1} == "," ]]; then
			error_msg=${error_msg%,}
		fi
		check_value="${error_msg}等服务在运行"
	    check_result="未通过"
	else
		check_value="限制内服务均已关闭"
	    check_result="通过"
	fi
}


checkItem_6_36(){
	#check_point="其他配置-6.36:检查是否开启高危端口"
	#6.36	检查是否开启高危端口	高	不必要的端口会扩大系统的被攻击面，此检查项建议调整	建议关闭

	declare -A tcp_ports=(
        [20]="FTP服务端口" [21]="FTP服务端口" [873]="RSYNC服务端口" [22]="SSH服务端口（安全外壳协议）" \
		[23]="Telnet服务端口（远程终端协议）" [3389]="WindowsRDP服务端口（远程桌面协议）" [1723]="PPTP服务端口（点对点隧道协议）" \
		[1194]="OpenVPN服务端口（虚拟专用通道）" [25]="SMTP服务端口（简单邮件传输协议）" [110]="POP3服务端口（邮件协议版本3）" [587]="SMTP（安全）服务端口" \
		[1433]="SQLServer服务端口（数据库管理系统）" [3306]="MySQL服务端口（数据库）" [5432]="PostgreSQL服务端口（数据库）" [1521]="Oracle数据库的监听端口" \
		[80]="HTTP默认服务端口" [443]="HTTPS默认服务端口" [8080]="常用Web服务相关端口" [8081]="常用Web服务相关端口" \
		[8082]="常用Web服务相关端口" [8083]="常用Web服务相关端口" [8084]="常用Web服务相关端口" [8085]="常用Web服务相关端口" \
		[8086]="常用Web服务相关端口" [8087]="常用Web服务相关端口" [8088]="常用Web服务相关端口" [8089]="常用Web服务相关端口" \
		[8440]="常用Web服务相关端口" [8441]="常用Web服务相关端口" [8442]="常用Web服务相关端口" [8443]="常用Web服务相关端口" \
		[8444]="常用Web服务相关端口" [8445]="常用Web服务相关端口" [8446]="常用Web服务相关端口" [8447]="常用Web服务相关端口" \
		[8448]="常用Web服务相关端口" [8449]="常用Web服务相关端口" [8450]="常用Web服务相关端口" [3128]="Squid服务端口（代理缓存服务器）" \
		[53]="DNS服务端口（域名系统）" [67]="DHCP服务端口（服务器）" [68]="DHCP服务端口（客户端）" [135]="WindowsNT漏洞端口" \
		[137]="SMB服务端口（NetBIOS协议）" [139]="SMB服务端口（NetBIOS协议）" [445]="SMB服务端口（NetBIOS协议）" [389]="LDAP服务端口（轻量目录访问协议）" \
		[5000]="可能被用于Flask、Sybase/DB2等服务" [3690]="SVN服务端口（开放源代码的版本控制系统）" [2082]="Cpanel服务端口（虚拟机控制系统）" [2083]="Cpanel服务端口（虚拟机控制系统）" \
		[2181]="Zookeeper服务端口（分布式系统的可靠协调系统）" [2601]="Zebra服务端口（Zebra路由）" [2604]="Zebra服务端口（Zebra路由）" [5554]="容易被蠕虫病毒入侵" \
		[5900]="VNC服务端口（虚拟网络控制台，远程控制）" [5901]="VNC服务端口（虚拟网络控制台，远程控制）" [5902]="VNC服务端口（虚拟网络控制台，远程控制）" [5984]="CouchDB数据库端口" \
		[6379]="Redis数据库端口" [9200]="Elasticsearch服务端口" [9300]="Elasticsearch服务端口" [11211]="Memcached服务端口（缓存系统）" \
		[27017]="MongoDB服务端口（数据库）" [27018]="MongoDB服务端口（数据库）" [161]="SNMP服务端口（简单网络管理协议及其陷阱）" [162]="SNMP服务端口（简单网络管理协议及其陷阱）" \
		[194]="IRC服务端口（互联网中继聊天）" [143]="IMAP服务端口（互联网邮件访问协议）" [6666]="某些恶意软件或服务可能使用的端口" [8180]="HTTP代理服务端口" \
		[8443]="HTTPS代理服务端口" [9000]="PHP-FPM服务端口" [50070]="Hadoop服务端口" [50075]="Hadoop服务端口" [65535]="TCP协议的最大端口号" \
		[539]="Apertus Technologies Load Determination" [593]="DCOM分布式组件对象模型协议" [5800]="VNC服务的Web端口"
    )

    # 定义需要检查的端口和服务名称（UDP）
    declare -A udp_ports=(
        [137]="NetBIOS相关的UDP端口" [138]="NetBIOS相关的UDP端口" [69]="TFTP服务端口" \
		[539]="Apertus Technologies Load Determination" [1434]="SQLServer的UDP端口"
    )
	 
	local error_msg=''
	# 遍历 TCP 端口并检查状态
    for port in "${!tcp_ports[@]}"; do
        # 使用 netstat 检测端口
        if netstat -tuln | grep tcp | grep -q ":$port "; then
			error_msg+="$port,"
        fi
    done
	
	# 遍历 UDP 端口并检查状态
    for port in "${!udp_ports[@]}"; do
        # 使用 netstat 检测端口
        if netstat -tuln | grep udp | grep -q ":$port "; then
		    error_msg+="$port,"
        fi
    done
	
	 
	if [[ -n $error_msg ]]; then
		# 删除最后一个字符（如果它是逗号）
		if [[ ${error_msg: -1} == "," ]]; then
			error_msg=${error_msg%,}
		fi
		check_value="${error_msg}等端口仍在监听"
	    check_result="未通过"
	else
		check_value="限制内端口均已关闭"
	    check_result="通过"
	fi
}



checkItem_6_37(){
    #echo "6.37	检查SSH是否使用默认端口22	重要	自行判断	默认情况下，SSH服务运行在22端口，为减少被恶意攻击的风险，检查是否将SSH端口改为非默认端口	Port参数值不是默认值(22)且该行没有被注释

    DEFAULT_PORT=22
    SSH_CONFIG_FILE="/etc/ssh/sshd_config"

    # 获取配置文件中的所有端口
    CONFIG_PORTS=$(grep -v '^#' $SSH_CONFIG_FILE | grep 'Port'  | grep -v 'GatewayPorts'| awk '{print $2}' | xargs)

    # 初始化变量
    check_value=""
    check_result="未通过"
    all_non_default=true

    # 检查每个端口配置
    for port in $CONFIG_PORTS; do
        if [ "$port" -eq "$DEFAULT_PORT" ]; then
            all_non_default=false
            check_value="使用默认端口$DEFAULT_PORT"
            break
        else
            check_value="使用非默认端口$port"
        fi
    done

    # 如果所有端口都不是默认端口
    if [ "$all_non_default" = true ]; then
        check_result="通过"
    fi

    # 如果没有找到任何端口配置
    if [ -z "$CONFIG_PORTS" ]; then
        check_value="未配置或配置被注释"
        check_result="未通过"
    fi
}


checkItem_6_38(){
	#check_point="其他配置-6.38:检查是否限制root用户远程登录"
    SSH_CONFIG_FILE="/etc/ssh/sshd_config"

	# 检查 PermitRootLogin 配置	
	PermitRootLogin_LINES=$(grep -v '^#' $SSH_CONFIG_FILE | grep 'PermitRootLogin')

	# 判断配置情况
	if [ -z "$PermitRootLogin_LINES" ]; then
	    check_value="未配置PermitRootLogin"
	    check_result="未通过"
	else
        value=$(echo "$PermitRootLogin_LINES" | awk '{print $2}')
		if [ $value == "no" ];then
		    check_value="PermitRootLogin配置为no"
	        check_result="通过"
		else
		    check_value="PermitRootLogin配置不是no"
	        check_result="未通过"
		fi
	fi
}

checkItem_6_39(){
	#check_point="其他配置-6.39:检查是否配置IP伪装检查策略"
	
	masquerade_rules=$(iptables -t nat -L -v -n | grep MASQUERADE)
	masquerade_status=-1
	ip_forward_status=-1
    if [[ -n "$masquerade_rules" ]]; then
        masquerade_status=0
    fi
 
	ip_forward=$(sysctl net.ipv4.ip_forward | awk '{print $3}')
	if [[ "$ip_forward" -eq 1 ]]; then
        ip_forward_status=0
    fi

	if [[ "$masquerade_status" -eq 0 && "$ip_forward_status" -eq 0 ]]; then
		#echo "6.39	检查是否配置IP伪装检查策略	重要	自行判断	为保护网络安全和隐私，不暴露真实IP地址，应检查是否配置IP伪装检查策略	找到iptables的MASQUERADE规则且IP转发启用	找到iptables的MASQUERADE规则并且IP转发已启用	通过" >> "$temp_file"
		check_value="找到iptables的MASQUERADE规则并且IP转发已启用"
	    check_result="通过"
    else
		#echo "6.39	检查是否配置IP伪装检查策略	重要	自行判断	为保护网络安全和隐私，不暴露真实IP地址，应检查是否配置IP伪装检查策略	找到iptables的MASQUERADE规则且IP转发启用	未找到iptables的MASQUERADE规则或IP转发未启用	未通过" >> "$temp_file"
		check_value="未找到iptables的MASQUERADE规则或IP转发未启用"
	    check_result="未通过"
	fi
}
 

 checkItem_6_40(){
	#check_point="其他配置-6.40:检查是否限定不同权限用户对日志文件的操作策略"
	#6.40	检查是否限定不同权限用户对日志文件的操作策略	中	自行判断	为防止未授权用户能够读取或修改日志文件，保护系统的敏感信息不被泄露，应检查是否限定不同权限用户对日志文件的操作策略。	按要求调整

    local error_msg=''
	declare -A log_files=(
	    ["/var/log/wtmp"]="600"
		["/var/log/messages"]="600"
		["/var/log/syslog"]="600"
		["/var/log/maillog"]="600"
		["/var/log/mail.log"]="600"
		["/var/log/dmesg"]="600"
		["/var/log/kern.log"]="600"
		["/var/log/cron"]="600"
		["/var/log/secure"]="600"
		["/var/log/auth.log"]="600"	
	)
	
	declare -A log_dirs=(
        ["/var/log/audit/"]="600"
    )
	 
	for path in "${!log_files[@]}"; do
		if [ ! -e $path ];then
		    continue;
		fi
        local current_permissions=$(stat -c "%a" "$path" 2>/dev/null)
		if [[ -z "$current_permissions" ]]; then
			error_msg+="$path权限获取异常，"
		else
			if [[ "$current_permissions" != "600" && "$current_permissions" != "400" ]]; then
				error_msg+="$path权限$current_permissions不符合要求，"
			fi
		fi
    done
	
	# 检查目录下所有文件的权限
    for dir in "${!log_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            continue
        fi
        local files=$(find "$dir" -type f)
        for file in $files; do
            local current_permissions=$(stat -c "%a" "$file" 2>/dev/null)
            if [[ -z "$current_permissions" ]]; then
                error_msg+="$file权限获取异常，"
            else
                if [[ "$current_permissions" != "600" && "$current_permissions" != "400" ]]; then
                    error_msg+="$file权限$current_permissions不符合要求，"
                fi
            fi
        done
    done
	
	if [[ -n $error_msg ]]; then
		# 删除最后一个字符（如果它是逗号）
		if [[ ${error_msg: -1} == "," ]]; then
			error_msg=${error_msg%,}
		fi
		check_value="${error_msg}"
	    check_result="未通过"
	else
		check_value="权限均符合要求"
	    check_result="通过"
	fi
}
 checkItem_6_41(){
	#echo "6.41	检查是否开启防火墙	重要	自行判断	防火墙是网络安全的第一道防线，通过监控和过滤进出内部网络的数据流，防止未经授权的访问和潜在的网络攻击。	iptables规则已配置
	# 检查iptables
	if command -v iptables &> /dev/null; then
		local ruleCount=$(iptables -L -v -n | grep -v "Chain" | grep -v "target" | grep -v "^$" | wc -l)
		if [[ $ruleCount -gt 0 ]]; then
			#iptables规则已配置。"
			check_value="iptables规则已配置"
	        check_result="通过"
		else
			#iptables规则未配置。"
			check_value="iptables规则未配置"
	        check_result="未通过"
		fi
	else
		#iptables命令未安装或不可用。"
		check_value="iptables命令未安装或不可用"
	    check_result="未通过"
	fi
}


 checkItem_6_42(){
	#check_point="其他配置-6.42:检查是否开启日志审核"
	#echo "6.42	检查是否开启日志审核	重要	自行判断	为了解系统调用、文件访问等详细信息，跟踪系统的使用情况、检测潜在的安全问题，应检查是否开启日志审核。	auditd服务开启
	
	if systemctl list-unit-files --full --type=service | grep -q "auditd.service"; then
		if systemctl is-active --quiet auditd; then
			check_value="auditd服务开启"
	        check_result="通过"
		else
			check_value="auditd服务未开启"
	        check_result="未通过"
		fi
	else
		check_value="找不到auditd服务"
	    check_result="未通过"
	fi
}

 checkItem_6_43(){
	#check_point="检查是否安装国产病毒库以及病毒库是否为最新"
	local safeServiceName="360safed"
	if systemctl list-unit-files --full --type=service | grep -q "${safeServiceName}.service"; then
		if systemctl is-active --quiet ${safeServiceName}; then
			FILE_PATH="/opt/360safe/vlibs/ver.ini"

			# 检查文件是否存在
			if [ ! -f "$FILE_PATH" ]; then
				check_value="360safed服务开启但未找到最近更新时间"
	            check_result="未通过"
			fi

			# 读取文件中的 date 字段
			date_line=$(grep '^date=' "$FILE_PATH")
			if [ -z "$date_line" ]; then
				check_value="360safed服务开启但未找到最近更新时间"
	            check_result="未通过"
			fi

			# 提取日期
			update_date=$(echo "$date_line" | cut -d'=' -f2)
			if [ -z "$update_date" ]; then
				check_value="360safed服务开启但更新时间格式错误"
	            check_result="未通过"
			fi

			# 转换为时间戳
			update_timestamp=$(date -d "$update_date" +%s)
			current_timestamp=$(date +%s)

			# 计算一个月前的时间戳
			one_month_ago_timestamp=$((current_timestamp - 30 * 86400))

			# 检查是否在过去一个月内更新
			if [ "$update_timestamp" -ge "$one_month_ago_timestamp" ]; then
				check_value="360safed服务开启且最近一个月有更新"
	            check_result="通过"
			else
				check_value="360safed服务开启但最近一个月没有更新"
	            check_result="未通过"
			fi
		else
			check_value="360safed服务未开启"
	        check_result="未通过"
		fi
	else
		check_value="找不到360safed服务"
	    check_result="未通过"
	fi
}

checkItem_6_44(){
	#check_point="其他配置-6.44:检查使用ip协议远程维护的设备是否配置ssh协议，禁用telnet协议"

	SSH_STATUS="TRUE"
	TELNET_STATUS="FALSE"
	 
	if systemctl list-units --type=service | grep -q "sshd.service"; then
		# 检查sshd服务是否正在运行
		if ! systemctl is-active --quiet sshd.service; then
			#echo "sshd.service 未启动。"
			SSH_STATUS="FALSE"
		fi
		
		if ! systemctl is-enabled --quiet sshd.service; then
			#echo "sshd.service 未设置为开机自启。"
			SSH_STATUS="FALSE"
		fi
	else
		SSH_STATUS="FALSE"
	fi
	
	if systemctl list-units --type=service | grep -q "telnet.socket"; then
		# 检查 Telnet 服务是否正在运行
		if systemctl is-active --quiet telnet.socket; then
			#echo "Telnet 协议未禁用。"
			TELNET_STATUS="TRUE"
		else
			# 检查 Telnet 服务是否设置为开机自启
			if systemctl is-enabled --quiet telnet.socket; then
				#echo "Telnet 协议未禁用。"
				TELNET_STATUS="TRUE"
			fi
		fi
	fi
	
	if [[ "$SSH_STATUS" == "TRUE" && "$TELNET_STATUS" == "FALSE" ]]; then
		#echo "6.44	检查使用ip协议远程维护的设备是否配置ssh协议且禁用telnet协议	重要	自行判断	对于使用IP协议进行远程维护的设备,应配置使用SSH协议并且禁止使用telnet协议	sshd服务设置成后台服务且启用，telnet.socket服务停止且关闭后台服务	sshd服务设置成后台服务且启用，telnet.socket服务停止且关闭后台服务	通过" >> "$temp_file"
		check_value="sshd服务设置成后台服务且启用，telnet.socket服务停止且关闭后台服务"
	    check_result="通过"
	else
		error_msg="";
		if [[ "$SSH_STATUS" == "TRUE" ]]; then
		    if [[ "$TELNET_STATUS" == "TRUE" ]];then
			    error_msg="telnet.socket服务未停用或未关闭后台服务"
			fi
		else
			if [[ "$TELNET_STATUS" == "FALSE" ]];then
			    error_msg="sshd服务未设置成后台服务或未正常启用启用"
			else
				error_msg="sshd服务未设置成后台服务或未正常启用启用,telnet也未停用或未关闭后台服务"
			fi
		fi
		#echo "6.44	检查使用ip协议远程维护的设备是否配置ssh协议且禁用telnet协议	重要	自行判断	对于使用IP协议进行远程维护的设备,应配置使用SSH协议并且禁止使用telnet协议	sshd服务设置成后台服务且启用，telnet.socket服务停止且关闭后台服务	$error_msg	未通过" >> "$temp_file"
		check_value=$error_msg
	    check_result="未通过"
	fi
}

checkItem_6_45(){
    #check_point="其他配置-6.45:检查是否限制用户登录失败次数和锁定时长"
    #6.45	检查是否限制用户登录失败次数和锁定时长	高	为了保证信息安全的可靠性、保密性，需要检查用户认证失败次数限制。不限制存在爆破的风险	/etc/pam.d/login和/etc/pam.d/sshd文件中需要添加pam_tally2.so模块的配置并且要求:登陆失败最多5次，锁定时长至少30分钟
	have_faillock=false
	have_tally=false
	local LOGIN_CONFIG_FILE="/etc/pam.d/login"
	local SSH_CONFIG_FILE="/etc/pam.d/sshd"
	local PASSWORDAUTH_CONFIG_FILE="/etc/pam.d/password-auth"
	local SYSTEMAUTH_CONFIG_FILE="/etc/pam.d/system-auth"
	
	if find /lib* /usr/lib* -name pam_faillock.so 2>/dev/null | grep -q .; then
		have_faillock=true
	fi
	if find /lib* /usr/lib* -name pam_tally2.so 2>/dev/null | grep -q .; then
		have_tally=true
	fi
	
	local error_msg=''
    if [[ $have_faillock == true ]]; then
		if [ -e ${PASSWORDAUTH_CONFIG_FILE} ] || [ -e ${SYSTEMAUTH_CONFIG_FILE} ];then
			if [ -e ${PASSWORDAUTH_CONFIG_FILE} ];then
				mapfile -t passwordAuthLines < <(grep -h pam_faillock ${PASSWORDAUTH_CONFIG_FILE} 2>/dev/null)
				password_pre=$(printf '%s\n' "${passwordAuthLines[@]}" | grep -E 'auth.*preauth')
				password_fal=$(printf '%s\n' "${passwordAuthLines[@]}" | grep -E 'auth.*authfail')
				password_succ=$(printf '%s\n' "${passwordAuthLines[@]}" | grep -E 'auth.*authsucc')
				
				if [ -z "$password_pre" ] || [ -z "$password_fal" ] || [ -z "$password_succ" ];then
					error_msg+="${PASSWORDAUTH_CONFIG_FILE}中faillock模块配置缺失;"
				else
				    # preauth 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$password_pre")
					if [[ "$?" -ne 0 ]]; then
						outputError="${PASSWORDAUTH_CONFIG_FILE}中pam_faillock.so模块配置preauth阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authfail 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$password_fal")
					if [[ "$?" -ne 0 ]]; then
						outputError="${PASSWORDAUTH_CONFIG_FILE}中pam_faillock.so模块配置authfail阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authsucc 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$password_succ")
					if [[ "$?" -ne 0 ]]; then
						outputError="${PASSWORDAUTH_CONFIG_FILE}中pam_faillock.so模块配置authsucc阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
				fi
			fi
			if [ -e ${SYSTEMAUTH_CONFIG_FILE} ];then
				mapfile -t systemAuthLines < <(grep -h pam_faillock ${SYSTEMAUTH_CONFIG_FILE} 2>/dev/null)
				system_pre=$(printf '%s\n' "${systemAuthLines[@]}" | grep -E 'auth.*preauth')
				system_fal=$(printf '%s\n' "${systemAuthLines[@]}" | grep -E 'auth.*authfail')
				system_succ=$(printf '%s\n' "${systemAuthLines[@]}" | grep -E 'auth.*authsucc')
				
				if [ -z "$system_pre" ] || [ -z "$system_fal" ] || [ -z "$system_succ" ];then
					error_msg+="${SYSTEMAUTH_CONFIG_FILE}中faillock模块配置缺失;"
				else
				    # preauth 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$system_pre")
					if [[ "$?" -ne 0 ]]; then
						outputError="${SYSTEMAUTH_CONFIG_FILE}中pam_faillock.so模块配置preauth阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authfail 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$system_fal")
					if [[ "$?" -ne 0 ]]; then
						outputError="${SYSTEMAUTH_CONFIG_FILE}中pam_faillock.so模块配置authfail阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authsucc 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$system_succ")
					if [[ "$?" -ne 0 ]]; then
						outputError="${SYSTEMAUTH_CONFIG_FILE}中pam_faillock.so模块配置authsucc阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
				fi
			fi
		else
			if [ -e ${LOGIN_CONFIG_FILE} ];then
				mapfile -t loginLines < <(grep -h pam_faillock ${LOGIN_CONFIG_FILE} 2>/dev/null)
				login_pre=$(printf '%s\n' "${loginLines[@]}" | grep -E 'auth.*preauth')
				login_fal=$(printf '%s\n' "${loginLines[@]}" | grep -E 'auth.*authfail')
				login_succ=$(printf '%s\n' "${loginLines[@]}" | grep -E 'auth.*authsucc')
				
				if [ -z "$login_pre" ] || [ -z "$login_fal" ] || [ -z "$login_succ" ];then
					error_msg+="${LOGIN_CONFIG_FILE}中faillock模块配置缺失;"
				else
				    # preauth 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$login_pre")
					if [[ "$?" -ne 0 ]]; then
						outputError="${LOGIN_CONFIG_FILE}中pam_faillock.so模块配置preauth阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authfail 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$login_fal")
					if [[ "$?" -ne 0 ]]; then
						outputError="${LOGIN_CONFIG_FILE}中pam_faillock.so模块配置authfail阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authsucc 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$login_succ")
					if [[ "$?" -ne 0 ]]; then
						outputError="${LOGIN_CONFIG_FILE}中pam_faillock.so模块配置authsucc阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
				fi
			fi
			if [ -e ${SSH_CONFIG_FILE} ];then
				mapfile -t sshdLines < <(grep -h pam_faillock ${SSH_CONFIG_FILE} 2>/dev/null)
				sshd_pre=$(printf '%s\n' "${sshdLines[@]}" | grep -E 'auth.*preauth')
				sshd_fal=$(printf '%s\n' "${sshdLines[@]}" | grep -E 'auth.*authfail')
				sshd_succ=$(printf '%s\n' "${sshdLines[@]}" | grep -E 'auth.*authsucc')
				
				if [ -z "$sshd_pre" ] || [ -z "$sshd_fal" ] || [ -z "$sshd_succ" ];then
					error_msg+="${SSH_CONFIG_FILE}中faillock模块配置缺失;"
				else
				    # preauth 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$sshd_pre")
					if [[ "$?" -ne 0 ]]; then
						outputError="${SSH_CONFIG_FILE}中pam_faillock.so模块配置preauth阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authfail 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$sshd_fal")
					if [[ "$?" -ne 0 ]]; then
						outputError="${SSH_CONFIG_FILE}中pam_faillock.so模块配置authfail阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
					# authsucc 阶段 参数值检验
					output=$(validate_pam_faillock_config  "$sshd_succ")
					if [[ "$?" -ne 0 ]]; then
						outputError="${SSH_CONFIG_FILE}中pam_faillock.so模块配置authsucc阶段不符合要求：["${output}"]-----"
						error_msg+=${outputError}
					fi
				fi
			fi
		fi
	elif [[ $have_tally == true ]];then
		local LOGIN_CONFIG=`grep "pam_tally2.so" ${LOGIN_CONFIG_FILE}`
		local SSH_CONFIG=`grep "pam_tally2.so" ${SSH_CONFIG_FILE}`	
		if [ -z "$LOGIN_CONFIG" ] || [ -z "$SSH_CONFIG" ]; then 
			if [ -z "$LOGIN_CONFIG" ]; then
				if [ -z "$SSH_CONFIG" ];then
					error_msg="/etc/pam.d/login和/etc/pam.d/sshd都未添加pam_tally2.so模块的配置"
				else
					error_msg="/etc/pam.d/login未添加pam_tally2.so模块的配置"
				fi
			else
				if [ -z "$SSH_CONFIG" ]];then
					error_msg="/etc/pam.d/sshd未添加pam_tally2.so模块的配置"
				fi
			fi
		else	
			output=$(validate_pam_tally2_config  "$LOGIN_CONFIG")
			if [[ "$?" -ne 0 ]]; then
				loginConfigError="${LOGIN_CONFIG_FILE}中pam_tally2.so模块配置不符合要求：["${output}"]-----"
				error_msg+=${loginConfigError}
			fi
			
			output=$(validate_pam_tally2_config "$SSH_CONFIG")
			if [[ "$?" -ne 0 ]]; then                                                                                                   
				sshConfigError="${SSH_CONFIG_FILE}中pam_tally2.so模块配置不符合要求：["${output}"]-----"
				error_msg+=${sshConfigError}
			fi
		fi
	else
	    error_msg+="系统未发现pam_faillock.so和pam_tally2.so模块"
	fi
	
	if [[ -n $error_msg ]]; then
		#错误信息非空，则说明有问题
		check_value="$error_msg"
		check_result="未通过"
	else
		check_value="均已配置并且符合要求:登陆失败最多5次，锁定时长至少30分钟"
		check_result="通过"
	fi
}
#checkItem_6_45需要的方法
validate_pam_tally2_config() {
    local line="$1"
    
    # 提取 pam_tally2.so 之后的部分
    local params=$(echo "$line" | awk -F 'pam_tally2.so' '{print $2}' | xargs)

    # 初始化变量
    local DENY=""
    local UNLOCK_TIME=""
    local ROOT_UNLOCK_TIME=""
    local EVEN_DENY_ROOT="false"  # 默认值为 false
    local error_msg=''
    # 逐个解析参数
    for param in $params; do
        case $param in
            deny*)
                DENY=$(echo "$param" | cut -d'=' -f2 | xargs)
                ;;
            unlock_time*)
                UNLOCK_TIME=$(echo "$param" | cut -d'=' -f2 | xargs)
                ;;
            root_unlock_time*)
                ROOT_UNLOCK_TIME=$(echo "$param" | cut -d'=' -f2 | xargs)
                ;;
            even_deny_root)
                EVEN_DENY_ROOT="true"  # 如果存在 even_deny_root 参数，设置为 true
                ;;
        esac
    done

    # 验证配置是否符合要求
    if [ "$EVEN_DENY_ROOT" != "true" ]; then
        #错误：配置不符合要求。even_deny_root 参数未启用。"
        error_msg+="even_deny_root未设置;"
    fi

    if [ -z "$DENY" ];then
	    error_msg+="deny参数未设置;"
	elif [ "$DENY" -gt 5 ]; then
        #错误：配置不符合要求。deny 参数值应最多为 5
        error_msg+="deny参数设置为$DENY;"
    fi	
	# 30分钟  1800秒	
    if [ -z "$UNLOCK_TIME" ];then
	    error_msg+="unlock_time参数未设置;"
    elif [ "$UNLOCK_TIME" -lt 1800 ]; then
        #错误：配置不符合要求。unlock_time 参数值应至少为 1800 秒
        error_msg+="unlock_time参数设置为$UNLOCK_TIME;"
    fi

    if [ -z "$ROOT_UNLOCK_TIME" ];then
        error_msg+="root_unlock_time参数未设置;"
    elif [ "$ROOT_UNLOCK_TIME" -lt 1800 ]; then
        #错误：配置不符合要求。root_unlock_time 参数值应至少为 1800 秒
        error_msg+="ROOT_UNLOCK_TIME参数设置为$ROOT_UNLOCK_TIME;"
    fi

    if [[ -n $error_msg ]]; then
	    #错误信息非空，则说明有问题
		echo $error_msg
		return 1
	else
		return 0
	fi
}

validate_pam_faillock_config() {
    local line="$1"
    
    # 提取 pam_tally2.so 之后的部分
    local params=$(echo "$line" | awk -F 'pam_faillock.so' '{print $2}' | xargs)

    # 初始化变量
    local DENY=""
    local UNLOCK_TIME=""
    local ROOT_UNLOCK_TIME=""
    local EVEN_DENY_ROOT="false"  # 默认值为 false
    local error_msg=''
    # 逐个解析参数
    for param in $params; do
        case $param in
            deny*)
                DENY=$(echo "$param" | cut -d'=' -f2 | xargs)
                ;;
            unlock_time*)
                UNLOCK_TIME=$(echo "$param" | cut -d'=' -f2 | xargs)
                ;;
            root_unlock_time*)
                ROOT_UNLOCK_TIME=$(echo "$param" | cut -d'=' -f2 | xargs)
                ;;
            even_deny_root)
                EVEN_DENY_ROOT="true"  # 如果存在 even_deny_root 参数，设置为 true
                ;;
        esac
    done

    # 验证配置是否符合要求
    if [ "$EVEN_DENY_ROOT" != "true" ]; then
        #错误：配置不符合要求。even_deny_root 参数未启用。"
        error_msg+="even_deny_root未设置;"
    fi

    if [ -z "$DENY" ];then
	    error_msg+="deny参数未设置;"
	elif [ "$DENY" -gt 5 ]; then
        #错误：配置不符合要求。deny 参数值应最多为 5
        error_msg+="deny参数设置为$DENY;"
    fi	
	# 30分钟  1800秒	
    if [ -z "$UNLOCK_TIME" ];then
	    error_msg+="unlock_time参数未设置;"
    elif [ "$UNLOCK_TIME" -lt 1800 ]; then
        #错误：配置不符合要求。unlock_time 参数值应至少为 1800 秒
        error_msg+="unlock_time参数设置为$UNLOCK_TIME;"
    fi

    if [ -z "$ROOT_UNLOCK_TIME" ];then
        error_msg+="root_unlock_time参数未设置;"
    elif [ "$ROOT_UNLOCK_TIME" -lt 1800 ]; then
        #错误：配置不符合要求。root_unlock_time 参数值应至少为 1800 秒
        error_msg+="ROOT_UNLOCK_TIME参数设置为$ROOT_UNLOCK_TIME;"
    fi

    if [[ -n $error_msg ]]; then
	    #错误信息非空，则说明有问题
		echo $error_msg
		return 1
	else
		return 0
	fi
}


checkItem_6_46(){
    #echo "6.46	检查是否配置rootkit恶意代码检查策略	重要	自行判断	为防止rootkit恶意软件对系统的控制，应检查是否配置rootkit恶意代码检查策略。	chkrootkit、rkhunter、tripwire、auditd、ausearch、ClamAV或Fail2Ban工具至少有一个在运行
     CHKROOTKIT_RUNNING=$(pgrep chkrootkit)
	RKHUNTER_RUNNING=$(pgrep rkhunter)
	TRIPWIRE_RUNNING=$(pgrep tripwire)
	AUDITD_RUNNING=$(pgrep auditd)
	AUSEARCH_RUNNING=$(pgrep ausearch)
	CLAMAV_RUNNING=$(pgrep clamd)
	FAIL2BAN_RUNNING=$(pgrep fail2ban-server)

	# 检查是否有任何一个工具正在运行
	if [ -n "$CHKROOTKIT_RUNNING" ] || \
	   [ -n "$RKHUNTER_RUNNING" ] || \
	   [ -n "$TRIPWIRE_RUNNING" ] || \
	   [ -n "$AUDITD_RUNNING" ] || \
	   [ -n "$AUSEARCH_RUNNING" ] || \
	   [ -n "$CLAMAV_RUNNING" ] || \
	   [ -n "$FAIL2BAN_RUNNING" ]; then
		#通过：至少有一个安全工具正在运行。"
		check_value="找到在运行的安全工具"
	        check_result="通过"
	else
		#不通过：没有检测到任何安全工具正在运行。"
		check_value="未找到在运行的安全工具"
	    check_result="未通过"
	fi
}

checkItem_6_49(){
    #检查是否开启系统日志
	local systemd_journald_ok='FALSE';
	if systemctl is-active --quiet systemd-journald; then
        #echo "systemd-journald 服务正在运行。"
        # 检查日志存储位置
        if [ -d "/var/log/journal" ]; then
            #echo "systemd-journald 日志存储在 /var/log/journal/，持久化正常。"
            systemd_journald_ok='TRUE';
        fi
    fi
	
	local rsyslog_ok='FALSE';
	if systemctl is-active --quiet rsyslog; then
        # 检查日志文件是否存在
        if [ -f "/var/log/messages" ]; then
            rsyslog_ok='TRUE';
        fi
    fi
	
	if [ "$systemd_journald_ok" = "FALSE" ] && [ "$rsyslog_ok" = "FALSE" ]; then
		check_value="systemd_journald和rsyslog服务都未正常运行并将系统日志持久化"
		check_result="未通过"
	else
		if [ "$systemd_journald_ok" = "TRUE" ] && [ "$rsyslog_ok" = "TRUE" ]; then
			check_value="systemd_journald和rsyslog服务都正常运行并将系统日志持久化"
			check_result="通过"
		else
			if [ "$systemd_journald_ok" = "TRUE" ];then
			    check_value="systemd_journald服务正常运行并将系统日志持久化"
			    check_result="通过"
			else
			    check_value="rsyslog服务正常运行并将系统日志持久化"
			    check_result="通过"
			fi
		fi
	fi
}






executeCheck(){
    local param=$1
	local checkItem=${CHECK_ITEM_PREFIX}${param//./_}
	# 检查函数是否存在
	if declare -f "$checkItem" > /dev/null; then
		# 调用函数
		echo "调用检查项：$checkItem"
		$checkItem
	else
	    check_result="不存在"
		echo "未知的检查项：$checkItem"
	fi
 
}


if [ -z "$7" ]; then
    echo "ERROR: 参数不够。Usage: $0 <1-报告临时文件绝对路径 2-检测项编号 3-检测项名称 4-检测项等级 5-检测项描述 6-检测项建议值 7-检测项通过的话能得到的分数>"
    exit -1
fi
temp_file=$1   # 2.1这种格式，直接拿来拼接就行了
item_no=$2
item_name=$3
item_level=$4
item_description=$5
item_standardValue=$6
item_passScore=$7    # 如果通过的话，该项能得到的分数。未通过就是0分

CHECK_ITEM_PREFIX=checkItem_

check_value=""   # 实际检测值
check_result=""  # 检测结果 通过/未通过

main(){
	#step-1
	if [ ! -f ${temp_file} ];then
	    timestamp=$(date +%Y%m%d%H%M%S)
        temp_file_prefix=baseline_${timestamp}
        temp_file=$(mktemp /tmp/${temp_file_prefix}.XXXXXX)
		echo "创建临时文件${temp_file}"
	fi
	
	#step-2  执行检查项（结果先存在临时文件）
	executeCheck ${item_no}
	echo "检测项${item_no}完成，检测结果=${check_result}， 检测实际值=${check_value}"

	#step-3  根据结果，输出结果到临时文件：每行按照： 检测项序号 检测项名称 检测项等级 检测项描述 检测项建议值 检测项实际值 检测项是否通过 检测项实际得分
	if [ "$check_result" == "通过" ]; then	
		echo "${item_no} ${item_name} ${item_level} ${item_description} ${item_standardValue} ${check_value} 通过 ${item_passScore}"  >> "$temp_file"
		exit 0  # 退出状态码为0，表示成功
	elif [ "$check_result" == "未通过" ]; then 
		echo "${item_no} ${item_name} ${item_level} ${item_description} ${item_standardValue} ${check_value} 未通过 0"  >> "$temp_file"
		exit 1  # 退出状态码为1，表示失败  
	else
	    exit -1  # 表示检查项不存在
	fi
}

main;





