#! /bin/bash

if [ "${DWL_SSH_ACCESS}" = "true" ]; then
    DWL_KEEP_RUNNING=true;
    echo "> Start Ssh";
    service ssh start;
fi
