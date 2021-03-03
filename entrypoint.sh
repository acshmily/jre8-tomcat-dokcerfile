#!/bin/bash
M_OPTS="-Duser.timezone=Asia/Shanghai"
C_OPTS=${C_OPTS}
MIN_HEAP=${MIN_HEAP:-"128m"}
MAX_HEAP=${MAX_HEAP:-"128m"}
JAVA_OPTS=${JAVA_OPTS:-"-Xmn384m -Xss256k -Duser.timezone=GMT+08  -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=0 -XX:+CMSClassUnloadingEnabled -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=80 -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+PrintClassHistogram  -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8"}
CATALINA_OPTS="${CATALINA_OPTS}"
JAVA_OPTS="${M_OPTS} ${C_OPTS} -Xms${MIN_HEAP} -Xmx${MAX_HEAP} ${JAVA_OPTS}"
sed -i -e "1a\JAVA_OPTS=\"$JAVA_OPTS\"" -e "1a\CATALINA_OPTS=\"$CATALINA_OPTS\"" /opt/tomcat/bin/catalina.sh

cd /opt/tomcat && /opt/tomcat/bin/catalina.sh run 2>&1 >> /opt/tomcat/logs/stdout.log

