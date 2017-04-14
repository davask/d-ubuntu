#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

######################
# docker-compose.yml #
######################

cat <<- EOF > ${rootDir}/portainer-template.json
. ${ITEMPLATES}/portainer-template.sh
EOF

echo "portainer-template generated with ubuntu:${branch}";
