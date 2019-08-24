#!/usr/bin/env python3
import time
import sys
import os
import requests
from kubernetes import client, config
from kubernetes.client.rest import ApiException

config.load_incluster_config()
v1 = client.CoreV1Api
POD_NAMESPACE = os.environ["POD_NAMESPACE"]
POD_LABELS = os.environ["POD_LABELS"]
POD_PORT = os.environ["POD_PORT"]

def getNodeWithMostStorage():
	IP = ""
	curMax = 0
	try:
		podList = v1.list_namespaced_pod(POD_NAMESPACE, label_selector=POD_LABELS, watch=False)
	except ApiException as e:
		print("Exception when calling CoreV1Api->list_namespaced_pod: %s\n" % e)
		sys.exit(1)
	else:
		for i in podList.items:
			try:
				r = requests.get("http://" + i.status.pod_ip + ":" + POD_PORT)
			except requests.exceptions.RequestException as e:
				print("Exception when calling requests->get: %s\n" % e)
				sys.exit(1)
			else:
				if r.json() > curMax:
					IP = i.status.host_ip
					curMax = r.json()
	if IP == "":
		print("ScriptError: IP invalid in getNodeWithMostStorage()\n")
		sys.exit(1)
	return IP

while True:
	IP = getNodeWithMostStorage()
	f = open("/IP.txt","w+")
	f.write(IP)
	time.sleep(60)
