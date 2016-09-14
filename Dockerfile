FROM ubuntu:14.04
MAINTAINER davask <admin@davaskweblimited.com>
USER root
LABEL dwl.server.os="ubuntu 14.04"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive
# declare container type
ENV DWL_INIT server
# declare if by default we keep container running
ENV DWL_KEEP_RUNNING false
# declare local
ENV DWL_LOCAL en_US.UTF-8
ENV LANG $DWL_LOCAL
ENV LC_ALL $DWL_LOCAL
# declare main user
ENV DWL_USER_NAME dwl
ENV DWL_USER_PASSWD dwl
ENV DWL_USER_HOME /home/$DWL_USER_NAME

#configuration static
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config
COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh

# Update local
RUN /bin/bash -c 'locale-gen $DWL_LOCAL'
# Update packages
RUN /bin/bash -c 'apt-get update'
RUN /bin/bash -c 'apt-get install -y apt-utils'
RUN /bin/bash -c 'apt-get install -y build-essential'
RUN /bin/bash -c 'apt-get install -y nano'
RUN /bin/bash -c 'apt-get install -y curl'
RUN /bin/bash -c 'apt-get install -y wget'
RUN /bin/bash -c 'apt-get install -y unzip'
RUN /bin/bash -c 'apt-get install -y git'
RUN /bin/bash -c 'apt-get install -y acl'
RUN /bin/bash -c 'apt-get install -y openssh-server'
RUN /bin/bash -c 'rm -rf /var/lib/apt/lists/*'
# init user
RUN /bin/bash -c 'groupadd -r $DWL_USER_NAME'
RUN /bin/bash -c 'useradd -m -r -g $DWL_USER_NAME -d $DWL_USER_HOME -s /sbin/nologin -c "Docker image user" $DWL_USER_NAME'
RUN /bin/bash -c 'chown $DWL_USER_NAME:$DWL_USER_NAME -R $DWL_USER_HOME'
RUN /bin/bash -c 'chmod 700 -R /tmp/dwl'
RUN /bin/bash -c 'chown $DWL_USER_NAME:$DWL_USER_NAME -R /tmp/dwl'

# USER $DWL_USER_NAME
# WORKDIR $DWL_USER_HOME

EXPOSE 22

ENTRYPOINT ["/bin/bash"]
CMD ["/tmp/dwl/init.sh"]
