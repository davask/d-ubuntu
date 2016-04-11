#!/bin/bash
chmod -R 700 ${DWL_INIT_DIR}

echo ">>>>> LIST /TMP INITIALIZATION FILES <<<<<";
ls -lah ${DWL_INIT_DIR} | sort -r;
echo "";

echo "##### START INITIALIZATION #####";
for init in `ls ${DWL_INIT_DIR} | sort -r`;
do
    echo ">>>>> Initialization of ${DWL_INIT_DIR}/${init} <<<<<";
    ${DWL_INIT_DIR}/${init};
    echo "";
done;
unset DWL_INIT_COUNTER
unset DWL_INIT
echo "##### END OF INITIALIZATION #####";
echo "";

echo ">>>>> ACCESS WORKDIR ${DWL_USER_DIR} <<<<<";
cd ${DWL_USER_DIR}

echo ">>>>> SWITCH TO USER ${DWL_USER_NAME} <<<<<";
su ${DWL_USER_NAME}
echo "";

if [ "${DWL_INIT}" = "app" ] || [ "${DWL_KEEP_ACTIVE}" = "true" ]; then
    echo ">>>>> KEEP APP ACTIVE <<<<<";
    tail -f /dev/null;
fi