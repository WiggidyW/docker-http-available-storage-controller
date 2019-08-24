#!/bin/ash
while true;
do {
	echo -e 'HTTP/1.1 200 OK\r\n';
	source /setip.py && echo ${IP};
} | nc -l -p 8080;
done
