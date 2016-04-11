FROM davask/d-ubuntu:14.04
MAINTAINER davask <contact@davaskweblimited.com>

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

WORKDIR $DWL_INIT_DIR

CMD ["sh", "-c","$DWL_TMP_DIR/dwl-init.sh"]
