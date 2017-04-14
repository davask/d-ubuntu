#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

######################
# docker-compose.yml #
######################

echo "d-ubuntu:
  ports:
  - 65502:22/tcp
  environment:
    DWL_LOCAL_LANG: en_US:en
    DWL_LOCAL: en_US.UTF-8
    DWL_USER_NAME: username
    DWL_SSH_ACCESS: 'false'
    DWL_USER_ID: '1000'
    DWL_USER_PASSWD: secret
    DWL_KEEP_RUNNING: 'true'
  tty: true
  hostname: localhost
  image: davask/d-ubuntu:${branch}
  net: bridge
  volumes:
  - ${rootDir}/volumes/home/username:/home/username
" > ${rootDir}/docker-compose.yml

echo "docker-compose.yml generated with ubuntu:${branch}";

