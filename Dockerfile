FROM ubuntu:14.04
MAINTAINER davask <contact@davaskweblimited.com>

LABEL dwl.server.os="ubuntu"

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# Update packages
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y nano
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]

CMD ["echo", "Ubuntu:14:04 Initialized"]
