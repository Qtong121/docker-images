# DESCRIPTION:    Filebeat
FROM centos:7.2.1511
MAINTAINER QT
# Ulimit
RUN echo "* soft nofile 65535" >> /etc/security/limits.conf & \
echo "* hard nofile 65535" >> /etc/security/limits.conf & \
echo "@root        soft    nproc           65535" >> /etc/security/limits.conf & \
echo "@root        hard    nproc           65535" >> /etc/security/limits.conf & \
echo "vm.max_map_count=262144" >> /etc/sysctl.conf & \
echo "ulimit -SH 65535" >> /etc/rc.local & \ 
mkdir /opt/EFK & \
adduser es  

# Install Filebeat
RUN cd /opt/EFK && \
    curl -L -O "https://mirrors.huaweicloud.com/filebeat/7.6.2/filebeat-7.6.2-linux-x86_64.tar.gz" && \
    tar xvf filebeat-7.6.2-linux-x86_64.tar.gz && \
    rm -f filebeat-7.6.2-linux-x86_64.tar.gz && \
    ln -s /opt/EFK/filebeat-7.6.2-linux-x86_64 /usr/local/filebeat && \
    chmod +x /usr/local/filebeat/filebeat && \
    mkdir -p /etc/filebeat

#ENV PATHS /var/log/yum.log
#ENV ES_SERVER 172.23.5.255:9200
#ENV INDEX filebeat-test
#ENV INPUT_TYPE log
#ENV ES_USERNAME elastic
#ENV ES_PASSWORD changeme

ADD ./filebeat.yml /etc/filebeat/
#ADD ./docker-entrypoint.sh /usr/bin/

#ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/local/filebeat/filebeat","-e","-c","/etc/filebeat/filebeat.yml"]
