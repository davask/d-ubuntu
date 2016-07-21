FROM ubuntu:16.04
MAINTAINER davask <admin@davaskweblimited.com>

LABEL dwl.server.os="ubuntu 16.04"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

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
RUN rm -rf /var/lib/apt/lists/*

COPY ./dwl-ubuntu.sh /tmp/dwl-ubuntu.sh
RUN chmod 700 /tmp/dwl-ubuntu.sh

ENTRYPOINT ["/bin/bash"]

CMD ["/tmp/dwl-ubuntu.sh"]
