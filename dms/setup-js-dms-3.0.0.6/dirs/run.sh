#!/bin/sh

nohup /usr/local/jdk/bin/java -jar -Xms2048m -Xmx2048m --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/sun.net.util=ALL-UNNAMED  /juson_file/dms-1.0.0-SNAPSHOT.jar > /dev/null 2>&1 &
