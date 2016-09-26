FROM ubuntu:14.04
MAINTAINER davask <docker@davaskweblimited.com>
LABEL dwl.server.os="ubuntu 14.04"

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

# declare gosu version
ENV GOSU_VERSION 1.9

# Update local
RUN /bin/bash -c 'locale-gen ${DWL_LOCAL};'
# Update packages
RUN /bin/bash -c 'apt-get update'
RUN /bin/bash -c 'apt-get install -y ca-certificates'
RUN /bin/bash -c 'apt-get install -y nano'
RUN /bin/bash -c 'apt-get install -y openssh-server'
RUN /bin/bash -c 'apt-get install -y wget'
RUN /bin/bash -c 'rm -rf /var/lib/apt/lists/*'

# add gosu for easy step-down from root
RUN set -x \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

#configuration static
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config
COPY ./tmp/dwl/user.sh /tmp/dwl/user.sh
COPY ./tmp/dwl/ssh.sh /tmp/dwl/ssh.sh
COPY ./tmp/dwl/keeprunning.sh /tmp/dwl/keeprunning.sh
COPY ./tmp/dwl/init.sh /tmp/dwl/init.sh

EXPOSE 22

ENTRYPOINT ["/bin/bash"]
CMD ["/tmp/dwl/init.sh"]
