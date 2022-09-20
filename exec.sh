#!/bin/bash
cd `dirname $0`

bash ./cpu.sh > ./log/cpu.csv
bash ./runq.sh > ./log/runq.csv
bash ./mem.sh > ./log/mem.csv
