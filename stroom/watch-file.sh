#!/bin/bash -eu
trap "exit 0" 3

WATCH_DIR=$1
#FILE_PATTERN=$2
COMMAND=$2

inotifywait -e CLOSE_WRITE -m -r ${WATCH_DIR} --format "%w %e" | while read LINE; do
    declare -a eventData=(${LINE})
    filePath=${eventData[0]}
    echo $LINE

#    if [[ $filePath =~ ${FILE_PATTERN} ]]; then
#	continue
#    fi
    ${COMMAND}
done
