#! /bin/bash

if [ "${DWL_SSH_ACCESS}" = "true" ]; then
    echo "> Start Ssh";
    service ssh start;
fi
