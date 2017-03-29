#! /bin/bash

if [ "${DWL_KEEP_RUNNING}" = "true" ]; then
    echo "> Kept container active";
    tail -f /dev/null;
fi
