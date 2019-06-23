#!/bin/bash -ex

cd "$( dirname "${BASH_SOURCE[0]}" )"
cd example_box

set +e
vagrant up --provider=vmck
ret=$?

vagrant ssh <<EOF
set -x
uname -a
w
df -h
free -h
EOF

vagrant destroy -f
exit $ret
