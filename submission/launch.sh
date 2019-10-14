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

exit_code=$(cat result.exit_code)
stdout="$(base64 result.out)"
stderr="$(base64 result.err)"

RESULT_JSON=$(jq -n \
                 --arg out "$stdout" \
                 --arg err "$stderr" \
                 --arg code $exit_code \
                 '{stdout: $out, stderr: $err, exit_code: $code,}')
curl -X POST "${VMCK_CALLBACK_URL}" -d "$RESULT_JSON" \
     --header "Content-Type: application/json"
