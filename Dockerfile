FROM ubuntu:14.04
MAINTAINER davask <contact@davaskweblimited.com>

LABEL dwl.server.os="ubuntu"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y nano
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y unzip

RUN rm -rf /var/lib/apt/lists/*

VOLUME /tmp/uploads

COPY ./dwl-init.sh /tmp/dwl-init.sh
COPY ./dwl-init-0-ubuntu.sh /tmp/dwl-init-0-ubuntu.sh
RUN chmod 700 /tmp/dwl-init.sh

ENTRYPOINT ["/bin/bash"]

CMD ["/tmp/dwl-init.sh"]
