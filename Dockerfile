FROM acshmily/jre:8u281_20210207
MAINTAINER acshmily <github.com/acshmily>

ENV TOMCAT_MAJOR_VERSION 10
ENV TOMCAT_MINOR_VERSION 10.0.2
ENV CATALINA_HOME /opt/tomcat
# Install tomcat
RUN \
    wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.sha512 | sha512sum  -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* ${CATALINA_HOME}
	



# Add tomcat context.xml file which allows symlinks (allowLinking = true)
ADD logging.properties ${CATALINA_HOME}/conf/

# Remove unneeded apps
RUN rm -rf ${CATALINA_HOME}/webapps/examples ${CATALINA_HOME}/webapps/docs 

WORKDIR /opt/tomcat

ADD entrypoint.sh /entrypoint.sh

CMD ["/bin/bash","/entrypoint.sh"]
