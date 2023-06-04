FROM registry.cn-hangzhou.aliyuncs.com/bigdata_cloudnative/centos:7.7.1908

RUN rm -f /etc/localtime && ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

RUN export LANG=zh_CN.UTF-8

# 创建用户和用户组，跟yaml编排里的user: 10000:10000
RUN groupadd --system --gid=10000 hadoop && useradd --system --home-dir /home/hadoop --uid=10000 --gid=hadoop hadoop -m

# 安装sudo
RUN yum -y install sudo ; chmod 640 /etc/sudoers

# 给hadoop添加sudo权限
RUN echo "hadoop ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN yum -y install install net-tools telnet wget nc less tree

RUN mkdir /opt/apache/

# 添加配置 JDK
ADD jdk-8u212-linux-x64.tar.gz /opt/apache/
ENV JAVA_HOME /opt/apache/jdk
ENV PATH $JAVA_HOME/bin:$PATH
RUN ln -s /opt/apache/jdk1.8.0_212 $JAVA_HOME

# HBase
ENV HBASE_VERSION 2.5.4
ADD hbase-${HBASE_VERSION}-bin.tar.gz /opt/apache/
ENV HBASE_HOME /opt/apache/hbase
ENV PATH $HBASE_HOME/bin:$PATH
RUN ln -s /opt/apache/hbase-${HBASE_VERSION} $HBASE_HOME

# copy bootstrap.sh
COPY bootstrap.sh /opt/apache/
RUN chmod +x /opt/apache/bootstrap.sh

RUN chown -R hadoop:hadoop /opt/apache

WORKDIR $HBASE_HOME

