FROM maven:3.6.0-jdk-8-alpine

# ARG NODE_ENV
# RUN echo "NODE_ENV:" $NODE_ENV

ARG JENKINS_USER_ID
ARG JENKINS_GROUP_ID
ARG DOCKER_GROUP_ID
RUN echo "JENKINS_GROUP_ID:" $JENKINS_GROUP_ID, "JENKINS_USER_ID:" $JENKINS_USER_ID

# 実行するJenkinsユーザIDおよびグループIDと一致させること
RUN apk --no-cache add shadow
RUN groupmod -g $JENKINS_GROUP_ID jenkins
RUN adduser -u $JENKINS_USER_ID --disabled-password jenkins
# RUN addgroup jenkins docker
RUN adduser jenkins jenkins
USER jenkins
