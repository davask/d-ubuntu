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

# declare main user
ENV DWL_APP_USER dwl
RUN adduser --disabled-password --gecos "" $DWL_APP_USER

# declare volumes
VOLUME /home/$DWL_APP_USER

# Instantiate container
RUN export DWL_INIT=app
RUN export DWL_INIT_COUNTER=0

COPY ./ubuntu.sh /tmp/dwl-$DWL_INIT/$DWL_INIT_COUNTER-ubuntu.sh
RUN DWL_INIT_COUNTER=$(($DWL_INIT_COUNTER+1))

COPY ./dwl-$DWL_INIT.sh /tmp/dwl-init.sh

RUN chmod 700 /tmp/dwl-init.sh

WORKDIR /home/$DWL_APP_USER

ENTRYPOINT ["/bin/bash"]
CMD ["/tmp/dwl-init.sh"]
