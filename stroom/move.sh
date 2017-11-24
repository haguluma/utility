#!/bin/bash -eu
trap "exit 0" 3

#WATCH_DIR=$1
#FILE_PATTERN=$2
#COMMAND=$2

/home/general/test_cn_proc/a.out | while read LINE; do
    echo $LINE
done
    #declare -a eventData=(${LINE})
    #filePath=${eventData[0]}
    #echo $LINE

#    if [[ $filePath =~ ${FILE_PATTERN} ]]; then
    #continue
#    fi
#    ${COMMAND}
#done
