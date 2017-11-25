#! /bin/bash
date +%M.%S.%N | sed -e 's/\./ /g' | gawk '{print $1*60000000000+$2*1000000000+$3}'
