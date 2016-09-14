#! /bin/bash
service ssh start;
echo "Ubuntu initialized";
if [ "${DWL_KEEP_RUNNING}" = "true" ]; then
    echo "> KEEP RUNNING ACTIVE";
    tail -f /dev/null;
fi
