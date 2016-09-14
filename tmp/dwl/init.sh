#! /bin/bash

if [ "${DWL_INIT}" != "data" ]; then
    DWL_KEEP_RUNNING=true
    service ssh start;
fi
echo "Ubuntu initialized";

if [ "${DWL_KEEP_RUNNING}" = "true" ]; then
    echo "> KEEP RUNNING ACTIVE";
    tail -f /dev/null;
fi
