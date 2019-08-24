#!/bin/ash
/setip.py &
P1=$!
/server.sh &
P2=$!
wait $P1 $P2
