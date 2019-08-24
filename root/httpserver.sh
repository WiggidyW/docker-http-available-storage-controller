#!/usr/bin/env ash
while true;
do {
	echo -e 'HTTP/1.1 200 OK\r\n';
	cat /IP.txt;
} | nc -l -p 8080;
done
