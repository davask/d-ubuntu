#!/bin/bash
chmod -R 700 /tmp

echo "<<<<< LIST /TMP INITIALIZATION FILES";
ls -lah /tmp;
echo ">>>>>";

echo "##### START INITIALIZATION #####";
for init in `ls /tmp | grep dwl-init- | sort -r`;
do
    echo "<<<<< Initialization of /tmp/$init";
    "/tmp/$init";
    echo ">>>>>";
done;

echo "##### END OF INITIALIZATION #####";
/bin/bash
tail -f /dev/null;