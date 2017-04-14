#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

######################
# docker-compose.yml #
######################

. ${ITEMPLATES}/portainer-template.sh

portainertemplate ${rootDir} "ubuntu";

echo "portainer-template generated with ubuntu:${branch}";
