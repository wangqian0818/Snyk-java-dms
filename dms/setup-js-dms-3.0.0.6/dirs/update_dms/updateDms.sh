#! /bin/bash

cd /juson_file/update_dms/update_files
logFile="/juson_file/update_dms/updateDms.log"
echo "开始解压更新包文件" > ${logFile}
unzip ./*.zip
echo "解压更新包文件成功,开始执行 setup.sh 脚本..." >> ${logFile}
sh ./setup.sh
