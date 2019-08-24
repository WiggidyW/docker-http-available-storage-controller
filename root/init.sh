#!/usr/bin/env ash
/setIP.py &
P1=$!
/httpserver.sh &
P2=$!
wait $P1 $P2
