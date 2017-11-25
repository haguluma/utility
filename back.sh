#!/bin/bash
./cn_proc/mv_proc &> ./output.log &
python ./cg_tcp.py &> ./output.log &
