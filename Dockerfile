FROM ubuntu:14.04
MAINTAINER davask <admin@davaskweblimited.com>
LABEL dwl.server.os="ubuntu 14.04"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive
# declare if by default we keep container running
ENV DWL_KEEP_RUNNING false
# declare local
ENV DWL_LOCAL en_US.UTF-8
# declare admin group
ENV DWL_ADMIN_GROUP dwladmin
# declare main user
ENV DWL_USER_NAME username
ENV DWL_USER_PASSWD secret
# declare main user
ENV DWL_SSH_ACCESS false

# Update local
RUN /bin/bash -c 'locale-gen ${DWL_LOCAL};'
# Update packages
RUN /bin/bash -c 'apt-get update;'
RUN /bin/bash -c 'apt-get install -y nano;'
RUN /bin/bash -c 'apt-get install -y openssh-server;'
RUN /bin/bash -c 'rm -rf /var/lib/apt/lists/*;'
# init user
RUN /bin/bash -c 'groupadd -r ${DWL_ADMIN_GROUP};'

#configuration static
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config
COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh

EXPOSE 22

ENTRYPOINT ["/bin/bash"]
CMD ["/tmp/dwl/init.sh"]
