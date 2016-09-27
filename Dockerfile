FROM ubuntu:16.04
MAINTAINER davask <docker@davaskweblimited.com>
LABEL dwl.server.os="ubuntu 16.04"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive
# declare if by default we keep container running
ENV DWL_KEEP_RUNNING false
# declare local
ENV DWL_LOCAL en_US.UTF-8
ENV LC_ALL ${DWL_LOCAL}
ENV LANG ${DWL_LOCAL}
# declare main user
ENV DWL_USER_ID 1000
ENV DWL_USER_NAME username
ENV DWL_USER_PASSWD secret
# declare main user
ENV DWL_SSH_ACCESS false

# Update local
RUN /bin/bash -c 'locale-gen ${DWL_LOCAL};'
# Update packages
RUN /bin/bash -c 'apt-get update'
RUN /bin/bash -c 'apt-get install -y ca-certificates'
RUN /bin/bash -c 'apt-get install -y nano'
RUN /bin/bash -c 'apt-get install -y openssh-server'
RUN /bin/bash -c 'apt-get install -y wget'
RUN /bin/bash -c 'rm -rf /var/lib/apt/lists/*'


#configuration static
COPY ./tmp/dwl/envvar.sh /tmp/dwl/envvar.sh
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config
COPY ./tmp/dwl/user.sh /tmp/dwl/user.sh
COPY ./tmp/dwl/ssh.sh /tmp/dwl/ssh.sh
COPY ./tmp/dwl/permission.sh /tmp/dwl/permission.sh
COPY ./tmp/dwl/keeprunning.sh /tmp/dwl/keeprunning.sh
COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh

EXPOSE 22

ENTRYPOINT ["/bin/bash"]
CMD ["/tmp/dwl/init.sh"]
