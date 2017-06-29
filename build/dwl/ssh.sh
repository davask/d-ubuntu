#! /bin/bash

if [ "${DWL_SSH_ACCESS}" = "true" ]; then
    DWL_KEEP_RUNNING=true;
    echo "> Start Ssh";
    sudo service ssh start;
fi
