#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

##############
# Dockerfile #
##############

echo "FROM ubuntu:${parentBranch}
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.server.os=\"ubuntu ${branch}\"" > ${rootDir}/Dockerfile
echo '
# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive
# declare if by default we keep container running
ENV DWL_KEEP_RUNNING false
# declare local
ENV DWL_LOCAL en_US.UTF-8
ENV DWL_LOCAL_LANG en_US:en
RUN locale-gen ${DWL_LOCAL}
ENV LANG ${DWL_LOCAL}
ENV LANGUAGE ${DWL_LOCAL_LANG}
ENV LC_ALL ${DWL_LOCAL}
# declare main user
ENV DWL_USER_ID 1000
ENV DWL_USER_NAME username
ENV DWL_USER_PASSWD secret
# declare main user
ENV DWL_SSH_ACCESS false

# Update local
RUN locale-gen ${DWL_LOCAL}
# Update packages
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get update
RUN apt-get install -y ca-certificates
RUN apt-get install -y apt-transport-https
RUN apt-get install -y software-properties-common

# ubuntu 14.04 update
# RUN apt-add-repository "deb http://archive.ubuntu.com/ubuntu zesty main universe multiverse"
# RUN apt-get update
# RUN apt-cache policy openssh-server
# RUN apt-get install -y openssh-server=1:7.4p1-10
RUN apt-get install -y openssh-server

RUN apt-get install -y nano
RUN apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash admin
RUN echo "admin:admin" | chpasswd && adduser admin sudo

#configuration static
COPY ./build/dwl/envvar.sh /dwl/envvar.sh
COPY ./build/dwl/default/etc/ssh/sshd_config /etc/ssh/sshd_config
COPY ./build/dwl/user.sh /dwl/user.sh
COPY ./build/dwl/ssh.sh /dwl/ssh.sh
COPY ./build/dwl/permission.sh /dwl/permission.sh
COPY ./build/dwl/keeprunning.sh /dwl/keeprunning.sh
COPY ./build/dwl/init.sh /dwl/init.sh

EXPOSE 22

ENTRYPOINT ["/bin/bash"]
CMD ["/dwl/init.sh"]
USER admin
WORKDIR /home/admin
' >> ${rootDir}/Dockerfile

echo "Dockerfile generated with ubuntu:${branch}";
