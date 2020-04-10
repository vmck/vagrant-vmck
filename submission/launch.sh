#!/bin/bash -ex

cd "$( dirname "${BASH_SOURCE[0]}" )"

trap "vagrant destroy -f" EXIT

curl "${VMCK_ARCHIVE_URL}" -o archive.zip
curl "${VMCK_SCRIPT_URL}" -o script.sh
curl "${VMCK_ARTIFACT_URL}" -o artifact.zip

chmod +x script.sh

unzip -t archive.zip
test_archive=$?
unzip -t artifact.zip
test_artifact=$?

if [ $test_archive -eq 0 ] && [ $test_artifact -eq 0]
then
    vagrant up
    (
    set +e
    vagrant ssh -- 'cd /vagrant; ./script.sh' &> result.out
    echo $? > result.exit_code
    )
else
    echo "1" > result.exit_code
    echo "The following downloaded archives are corrupt or incomplete:" > result.out

    if [ $test_archive -ne 0 ]
    then
        echo "--> archive.zip" >> result.out
        stat archive.zip >> result.out
    fi
    if [ $test_artifact -ne 0 ]
    then
        echo "--> artifact.zip" >> result.out
        stat artifact.zip >> result.out
    fi
fi

exit_code=$(cat result.exit_code)
base64 result.out > stdout.tmp
cat stdout.tmp | tr -d '\n' > stdout

jq -n \
    --rawfile out stdout \
    --arg code $exit_code \
    '{stdout: $out, exit_code: $code,}' > out.json

curl -X POST "${VMCK_CALLBACK_URL}" -d @out.json \
     --header "Content-Type: application/json" \
     --retry 20 --retry-connrefused
