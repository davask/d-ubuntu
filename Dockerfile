FROM ubuntu:14.04
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.server.os="ubuntu 14.04"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive
# Update packages
RUN apt-get update && \
apt-get install -y apt-utils locales
RUN locale-gen "en_US.UTF-8"
# declare locales
ENV DWL_LOCAL_LANG en_US:en
ENV DWL_LOCAL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8

# declare main user
ENV DWL_USER_ID 1000
ENV DWL_USER_NAME username
ENV DWL_USER_PASSWD secret
# declare main user
ENV DWL_SSH_ACCESS false

RUN apt-get update && \
apt-get install -y \
openssl \
ca-certificates \
apt-transport-https \
software-properties-common \
python-software-properties \
openssh-server \
nano \
wget \
sudo

RUN apt-get upgrade -y && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -r \
--comment "dwl ssh user" \
--no-create-home \
--shell /bin/bash \
--uid 999 \
--no-user-group \
admin;
RUN echo "admin ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/admin
RUN chmod 0440 /etc/sudoers.d/admin

#configuration static
COPY ./build/etc/ssh/sshd_config \
./build/etc/ssh/sshd_config.factory-defaults \
/etc/ssh/

COPY ./build/dwl/envvar.sh \
./build/dwl/user.sh \
./build/dwl/ssh.sh \
./build/dwl/permission.sh \
./build/dwl/init.sh \
/dwl/

EXPOSE 22

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/bin/bash /dwl/init.sh && /bin/bash"]
WORKDIR /home/admin
RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
