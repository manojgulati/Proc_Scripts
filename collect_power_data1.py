# Script to fetch data from Z-wave based Plug Load monitor

import time
import requests
import csv

#filename = str(int(time.time())+'.csv')
import csv

current_time =  int(time.time());
print current_time

while 1:
	url = "http://192.168.11.4:8083/ZWaveAPI/Run/devices[2].instances[0].commandClasses[50].Get()"
	headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
	requests.get(url, headers=headers)

	url1 = "http://192.168.11.4:8083/ZWaveAPI/Run/devices[2].instances[0].commandClasses[50].data[2].val['value']"
	r = requests.post(url1, headers=headers)
	#time.sleep(1)
	#print r.json()
	d=r.json()
	print current_time, d
	
	with open('Data_Zwave.csv', 'a+') as csvfile:
		writer = csv.writer(csvfile)
		writer.writerow([current_time, d])
	#current_time = current_time+1
	current_time =  int(time.time());

	
