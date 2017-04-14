#/usr/bin/env bash

branch=${1};
parentBranch=${branch};

if [[ "${branch}" != "12.04" ]] && [[ "${branch}" != "14.04" ]] && [[ "${branch}" != "16.04" ]]; then

    echo "Ubuntu available: 12.04, 14.04, 16.04"
    exit 0;

fi

thisDir=`readlink -m "${PWD}"`;
rootDir="${thisDir}";
buildDir=`readlink -m "${thisDir}/build"`;

. ./script/Dockerfile.sh ${branch} ${parentBranch} ${rootDir} ${buildDir}
. ./script/README.sh ${branch} ${parentBranch} ${rootDir} ${buildDir}
. ./script/docker-compose.sh ${branch} ${parentBranch} ${rootDir} ${buildDir}
. ./script/portainer-template.sh ${branch} ${parentBranch} ${rootDir} ${buildDir}

sudo docker build -t davask/d-ubuntu:${branch} ${thisDir};

echo "sudo docker run --name d-ubuntu -tdi -p 65502:22/tcp -e DWL_KEEP_RUNNING=true davask/d-ubuntu:${branch}";


exit 1;
