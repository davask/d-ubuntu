#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

#############
# README.md #
#############

echo "# dockerfile

## Exposed port

- 22

## Default ENV values

### Define Default LANG LOCAL

> DWL_LOCAL_LANG: en_US:en

> DWL_LOCAL: en_US.UTF-8

### Define username:passwd for ssh access

> DWL_USER_NAME: username

> DWL_USER_ID: '1000'

> DWL_USER_PASSWD: secret

### Define if ssh and sftp access are accepted

> DWL_SSH_ACCESS: 'false'

### Define if container should keep running after initialization

> DWL_KEEP_RUNNING: 'true'

## LABEL

> dwl.server.os=\"ubuntu ${branch}\"
" > ${rootDir}/README.md

echo "README.md generated with ubuntu:${branch}";

