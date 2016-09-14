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
ENV DWL_ADMIN_GROUP dwladmin
# declare main user
ENV DWL_USER_NAME dwl
ENV DWL_USER_PASSWD dwl
ENV DWL_USER_HOME /home/$DWL_USER_NAME

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
RUN /bin/bash -c 'groupadd -r $DWL_ADMIN_GROUP'
RUN /bin/bash -c 'groupadd -r $DWL_USER_NAME'
RUN /bin/bash -c 'useradd -m -r \
-g $DWL_USER_NAME \
-G $DWL_ADMIN_GROUP \
-d $DWL_USER_HOME \
-s /bin/bash \
-c "dwl ssh user" \
-p $DWL_USER_PASSWD $DWL_USER_NAME'
RUN /bin/bash -c 'chown -R $DWL_USER_NAME:$DWL_USER_NAME -R $DWL_USER_HOME'

#configuration static
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config
COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh

WORKDIR $DWL_USER_HOME
EXPOSE 22
ENTRYPOINT ["/bin/bash"]
CMD ["/tmp/dwl/init.sh"]
