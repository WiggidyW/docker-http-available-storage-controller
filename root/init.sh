#!/usr/bin/env sh
while true;
do {
	echo -e 'HTTP/1.1 200 OK\r\n';
	echo $(cat /IP.txt);
} | nc -l -p 8080;
done
