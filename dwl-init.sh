#!/bin/bash
chmod -R 700 /tmp

echo ">>>>> LIST /TMP INITIALIZATION FILES <<<<<";
ls -lah /tmp | grep dwl-init- | sort -r;
echo "";

echo "##### START INITIALIZATION #####";
echo "";
for init in `ls /tmp | grep dwl-init- | sort -r`;
do
    echo ">>>>> Initialization of /tmp/$init <<<<<";
    "/tmp/$init";
    echo "";
done;

echo "";
echo "##### END OF INITIALIZATION #####";

echo ">>>>> SWITCH TO USER ${DWL_APP_USER} <<<<<";
su ${DWL_APP_USER}
echo "";

if [ "${DWL_KEEP_ACTIVE}" = "true" ]; then
    echo ">>>>> KEEP APP ACTIVE <<<<<";
    tail -f /dev/null;
fi