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
RUN export DWL_TMP_DIR=`echo /home/$DWL_APP_USER/tmp`
RUN export DWL_INIT_DIR=`echo $DWL_TMP_DIR/dwl-$DWL_INIT`
RUN export DWL_INIT_COUNTER=0

RUN echo $DWL_INIT_DIR

COPY ./ubuntu.sh $DWL_INIT_DIR/$DWL_INIT_COUNTER-ubuntu.sh
RUN DWL_INIT_COUNTER=$(($DWL_INIT_COUNTER+1))

COPY ./dwl-init.sh $DWL_TMP_DIR/dwl-init.sh
RUN chmod 700 $DWL_TMP_DIR/dwl-init.sh

WORKDIR /home/$DWL_APP_USER

ENTRYPOINT ["/bin/bash"]
CMD ["$DWL_TMP_DIR/dwl-init.sh"]
