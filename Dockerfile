FROM ubuntu:14.04
MAINTAINER davask <admin@davaskweblimited.com>

LABEL dwl.server.os="ubuntu 14.04"

# declare if by default we keep container running
ENV DWL_KEEP_RUNNING false

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

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
RUN apt-get install -y sudo
RUN rm -rf /var/lib/apt/lists/*

COPY ./dwl-ubuntu.sh /tmp/dwl-ubuntu.sh
RUN chmod 700 /tmp/dwl-ubuntu.sh

ENTRYPOINT ["/bin/bash"]

CMD ["/tmp/dwl-ubuntu.sh"]
