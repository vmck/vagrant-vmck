#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

trap "vagrant destroy -f" EXIT

curl "${VMCK_ARCHIVE_URL}" -o archive.zip
curl "${VMCK_SCRIPT_URL}" -o script.sh

touch reuslt.err

vagrant up
vagrant ssh -- < script.sh 1> result.out 2> result.err

exit_code=$?
stdout="$(base64 result.out)"
stderr="$(base64 reuslt.err)"

JSON_STRING=$(jq -n \
                 --arg out "$stdout" \
                 --arg err "$stderr" \
                 --arg code $exit_code \
                 '{stdout: $out, stderr: $err, exit_code: $code},')
curl -X POST "${VMCK_CALLBACK_URL}" -d "$JSON_STRING" \
     --header "Content-Type: application/json"
