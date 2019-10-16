#!/bin/bash -ex

cd "$( dirname "${BASH_SOURCE[0]}" )"

trap "vagrant destroy -f" EXIT

curl "${VMCK_ARCHIVE_URL}" -o archive.zip
curl "${VMCK_SCRIPT_URL}" -o script.sh
curl "${VMCK_ARTIFACT_URL}" -o artifact.zip

chmod +x script.sh

vagrant up
(
set +e
vagrant ssh -- 'cd /vagrant; ./script.sh' 1> result.out 2> result.err
echo $? > result.exit_code
)

base64 result.out > stdout.b64
base64 result.err > stderr.b64
cat stdout.b64 stderr.64 result.exit_code | tr '\n' ' ' > out.tmp

awk '{print "{\"stdout\":\""$1"\",\"stderr\":\""$2"\",\"exit_code\":\""$3"\"}"}' out.tmp > out.json

curl -X POST "${VMCK_CALLBACK_URL}" -d @out.json \
     --header "Content-Type: application/json"
