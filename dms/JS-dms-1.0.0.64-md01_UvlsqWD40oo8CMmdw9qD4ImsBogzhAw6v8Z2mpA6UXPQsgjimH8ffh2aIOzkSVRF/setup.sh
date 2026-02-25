#! /bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_PATH=/juson_file
UPDATE_DIR=${BASE_PATH}/update_dms
UPDATE_FILES_DIR=${UPDATE_DIR}/update_files
UPDATE_SQL_DIR=${UPDATE_DIR}/sql
logFile=${UPDATE_DIR}/updateDms.log


if [ ! -e "$SCRIPT_DIR/version.txt" ];then
    error "升级包内容缺失：版本信息文件version.txt缺失，请确认安装包完整性"
fi

chmod 777 ${SCRIPT_DIR}/*
rm -rf ${BASE_PATH}/dms-1.0.0-SNAPSHOT.jar
cp ${SCRIPT_DIR}/dms-1.0.0-SNAPSHOT.jar ${BASE_PATH}/
echo "复制dms-1.0.0-SNAPSHOT.jar" >> ${logFile}

mv ${UPDATE_DIR}/version.txt ${UPDATE_DIR}/version_old.txt
cp $SCRIPT_DIR/version.txt ${UPDATE_DIR}/

if [ -e $UPDATE_SQL_DIR ];then
    rm -rf $UPDATE_SQL_DIR
fi
cp -r ${SCRIPT_DIR}/sql  ${UPDATE_DIR}/

echo "更改版本信息成功" >> ${logFile}

rm -rf ${UPDATE_FILES_DIR}/*
service jusondms restart
echo "juson_dms重启命令执行完成" >> ${logFile}