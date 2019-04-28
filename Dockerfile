FROM maven:3.6.0-jdk-8-alpine

# ARG NODE_ENV
# RUN echo "NODE_ENV:" $NODE_ENV

ARG JENKINS_USER_ID
ARG JENKINS_GROUP_ID
ARG DOCKER_GROUP_ID
RUN echo "JENKINS_GROUP_ID:" $JENKINS_GROUP_ID ", DOCKER_GROUP_ID:" $DOCKER_GROUP_ID, JENKINS_USER_ID:" $JENKINS_USER_ID

# 実行するJenkinsユーザIDおよびグループIDと一致させること
RUN yum install shadow-utils.x86_64 -y
RUN sudo groupadd -g $JENKINS_GROUP_ID jenkins
RUN sudo groupadd -g $DOCKER_GROUP_ID docker
RUN useradd -u $JENKINS_USER_ID -g $JENKINS_GROUP_ID jenkins
RUN usermod -aG wheel jenkins
USER jenkins