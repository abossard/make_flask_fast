#!/bin/bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

gunicorn -k sync -w 4 -b 127.0.0.1:4000 server:app &
sleep 2
boom http://127.0.0.1:4000 -n 1000 -c 100
echo "done"