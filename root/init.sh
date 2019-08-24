#!/bin/ash
/setip.py &
P1=$!
/httpserver.sh &
P2=$!
wait $P1 $P2
