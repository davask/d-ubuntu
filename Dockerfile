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
ENV DWL_USER_NAME dwl
RUN adduser --disabled-password --gecos "" $DWL_USER_NAME

# declare volumes
ENV DWL_USER_DIR /home/$DWL_USER_NAME
VOLUME $DWL_USER_DIR
ENV DWL_TMP_DIR $DWL_USER_DIR/tmp
RUN test -d "$DWL_TMP_DIR" || mkdir -p "$DWL_TMP_DIR"

# Instantiate container
ENV DWL_INIT=app
ENV DWL_INIT_DIR $DWL_TMP_DIR/dwl-$DWL_INIT
RUN test -d "$DWL_INIT_DIR" || mkdir -p "$DWL_INIT_DIR"
ENV DWL_INIT_COUNTER=0

COPY ./ubuntu.sh $DWL_INIT_DIR/$DWL_INIT_COUNTER-ubuntu.sh
RUN DWL_INIT_COUNTER=$(($DWL_INIT_COUNTER+1))

COPY ./dwl-init.sh $DWL_TMP_DIR/dwl-init.sh
RUN chmod 700 $DWL_TMP_DIR/dwl-init.sh

ENTRYPOINT ["/bin/bash"]
CMD ["sh", "-c","$DWL_TMP_DIR/dwl-init.sh"]
