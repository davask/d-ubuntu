#!/bin/bash
chmod -R 700 /home/$DWL_APP_USER/tmp/dwl-$DWL_INIT

echo ">>>>> LIST /TMP INITIALIZATION FILES <<<<<";
ls -lah /home/$DWL_APP_USER/tmp/dwl-$DWL_INIT | sort -r;
echo "";

echo "##### START INITIALIZATION #####";
for init in `ls /home/$DWL_APP_USER/tmp/dwl-$DWL_INIT | sort -r`;
do
    echo ">>>>> Initialization of /home/$DWL_APP_USER/tmp/dwl-$DWL_INIT/$init <<<<<";
    /home/$DWL_APP_USER/tmp/dwl-$DWL_INIT/$init;
    echo "";
done;
unset DWL_INIT_COUNTER
unset DWL_INIT
echo "##### END OF INITIALIZATION #####";
echo "";

echo ">>>>> SWITCH TO USER ${DWL_APP_USER} <<<<<";
su ${DWL_APP_USER}
echo "";

if [ "${DWL_KEEP_ACTIVE}" = "true" ]; then
    echo ">>>>> KEEP APP ACTIVE <<<<<";
    tail -f /dev/null;
fi