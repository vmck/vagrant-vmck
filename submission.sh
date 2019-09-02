#!/bin/bash -ex

trap "vagrant destroy -f" EXIT

# takes a file as input and returns a JSON list
function make_list()
{
    _output="["

    while IFS= read -r line
    do
        line=$(echo ${line} | tr -cd '[:print:]')
        _output=${_output}"\"${line}\","
    done < $1

    _output=${_output}"\"\"]"

    echo ${_output}
}

curl -X GET ${DOWNLOAD_URL} > archive.zip
unzip archive.zip
vagrant up
vagrant ssh -- < checker.sh > result.out
data=$(make_list ./result.out)
curl -X POST 'http://10.42.1.1:10002/done/' -d "{\"token\": \"${DOWNLOAD_URL}\", \"output\": ${data}}"
