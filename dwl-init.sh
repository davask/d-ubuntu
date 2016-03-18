#!/bin/sh
chmod -R 700 /tmp
echo "List /tmp initialization files";
ls -lah /tmp;
echo 'Start initialization';
for init in `ls /tmp | grep dwl-init- | sort -r`;
do
    echo "Initialization of /tmp/$init";
    do "/tmp/$init";
done;
echo 'End of initialization';
