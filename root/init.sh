#!/usr/bin/env sh
echo > /IP.txt
/setIP.py &
P1=$!
sleep 30
/httpserver.sh &
P2=$!
wait $P1 $P2
