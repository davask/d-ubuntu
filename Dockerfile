FROM ubuntu:14.04
MAINTAINER davask <admin@davaskweblimited.com>

LABEL dwl.server.os="ubuntu 14.04"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive
# declare local
ENV DWL_LOCAL en_US.UTF-8
RUN locale-gen $DWL_LOCAL
ENV LANG $DWL_LOCAL
ENV LC_ALL $DWL_LOCAL

# Update packages
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y nano
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y git
RUN apt-get install -y acl
RUN apt-get install -y openssh-server
RUN rm -rf /var/lib/apt/lists/*

# declare container type
ENV DWL_INIT server
# declare if by default we keep container running
ENV DWL_KEEP_RUNNING false

# declare main user
ENV DWL_USER_NAME dwl
ENV DWL_USER_PASSWD dwl
ENV DWL_USER_HOME /home/$DWL_USER_NAME
# init user
RUN groupadd -r $DWL_USER_NAME
RUN useradd -m -r -g $DWL_USER_NAME -d $DWL_USER_HOME -s /sbin/nologin -c "Docker image user" $DWL_USER_NAME
RUN chown $DWL_USER_NAME:$DWL_USER_NAME -R $DWL_USER_HOME

#configuration static
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config

COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh
RUN chmod 700 -R /tmp/dwl
RUN chown $DWL_USER_NAME:$DWL_USER_NAME -R /tmp/dwl

USER $DWL_USER_NAME
WORKDIR $DWL_USER_HOME

EXPOSE 22

ENTRYPOINT ["/bin/bash"]
CMD ["/tmp/dwl/init.sh"]
