#! /bin/bash

if [ -d /dwl/home/host/files ]; then
    sudo rm -rdf /home/${DWL_USER_NAME}/files;
    sudo ln -sf /dwl/home/host/files /home/${DWL_USER_NAME}/files;
fi

sudo chown -R ${DWLC_USER_NAME}:${DWLC_USER_NAME} /home/${DWLC_USER_NAME}/;
# sudo chown root:root /home/${DWLC_USER_NAME};
