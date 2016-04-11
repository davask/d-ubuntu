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
ENV DWL_APP_GROUP dwl

USER $DWL_APP_USER

# declare volumes
VOLUME /home/$DWL_APP_USER/www
VOLUME /home/$DWL_APP_USER/tmp

# Instantiate container
COPY ./dwl-init.sh /tmp/dwl-init.sh
COPY ./dwl-init-0-ubuntu.sh /tmp/dwl-init-0-ubuntu.sh
RUN chmod 700 /tmp/dwl-init.sh

WORKDIR /home/$DWL_APP_USER

ENTRYPOINT ["/bin/bash"]

CMD ["/tmp/dwl-init.sh"]
