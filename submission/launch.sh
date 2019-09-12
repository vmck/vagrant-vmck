#!/bin/bash -ex
trap "vagrant destroy -f" EXIT
curl "${ARCHIVE_URL}" -o submission.zip
curl "${SCRIPT_URL}" -o checker.sh
vagrant up
vagrant ssh -- < checker.sh > result.out
data="$(base64 result.out)"
JSON_STRING=$(jq -n \
                 --arg tok "$SUBMISSION_ID" \
                 --arg out "$data" \
                 '{token: $tok, output: $out,}')
curl -X POST "${INTERFACE_ADDRESS}/done/" -d "$JSON_STRING" \
     --header "Content-Type: application/json"