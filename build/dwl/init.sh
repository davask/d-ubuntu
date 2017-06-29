#! /bin/sh -e

cd .; cd -;

dwlDir="/dwl";

. ${dwlDir}/envvar.sh
. ${dwlDir}/user.sh
. ${dwlDir}/ssh.sh
echo ">> Os initialized";

. ${dwlDir}/permission.sh
echo ">> Permission assigned";

