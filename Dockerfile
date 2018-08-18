FROM centos:7

ENV container=docker

RUN yum -y install wget
RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.2.0/hdp.repo -O /etc/yum.repos.d/hdp.repo

# Creation user & group
RUN groupadd hadoop && useradd -m zookeeper -g hadoop

# Création répertoires
RUN mkdir -p /var/data/zookeeper \
  && mkdir -p /var/log/zookeeper

RUN chown -R zookeeper:hadoop /var/data/zookeeper \
 && chown -R zookeeper:hadoop /var/log/zookeeper

# Install Zookeeper
RUN yum -y install java-1.8.0-openjdk && yum -y install zookeeper-server

USER zookeeper
ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
ENV PATH=$PATH:$JAVA_HOME/bin
ENV CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar

# Config Zookeeper
COPY ./conf/zoo.cfg /etc/zookeeper/conf/zoo.cfg

COPY ./scripts/entrypoint.sh /opt/zookeeper/entrypoint.sh

USER root

#  client port, follower port, election port 
EXPOSE 2181 2888 3888

ENTRYPOINT ["bash", "-c", "/opt/zookeeper/entrypoint.sh"]