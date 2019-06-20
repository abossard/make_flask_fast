#!/bin/bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

gunicorn -k sync -w 4 -b 127.0.0.1:4000 server:app &
sleep 2
boom http://127.0.0.1:4000 -n 2000 -c 2000
kill %1

python server2.py &
boom http://127.0.0.1:8080 -n 2000 -c 2000
kill %1

echo "done"