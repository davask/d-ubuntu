#! /bin/bash

dwlDir="/dwl";

. ${dwlDir}/envvar.sh
. ${dwlDir}/user.sh
. ${dwlDir}/ssh.sh
echo ">> Ubuntu initialized";

. ${dwlDir}/permission.sh
echo ">> Permission assigned";

. ${dwlDir}/keeprunning.sh
