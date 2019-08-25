#!/usr/bin/env sh
echo > /IP.txt
/setIP.py &
P1=$!
/httpserver.sh &
P2=$!
wait $P1 $P2
