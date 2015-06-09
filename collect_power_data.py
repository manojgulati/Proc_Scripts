# Script to fetch data from Z-wave based Plug Load monitor

import time
import requests

t = 1433834450
current_time =  int(time.time());

if ((current_time-t)%3==1):
	time.sleep(2);
	set_time = int(time.time());
elif ((current_time-t)%3==2):
	time.sleep(1);
	set_time = int(time.time());
elif ((current_time-t)%3==0):
	set_time = int(time.time());
print 'rx_set_time'
print set_time

set_time = set_time-6;
print 'tx_set_time'
print set_time

while 1:
	set_time = set_time+3
	url1 = "http://192.168.10.3:8083/ZWaveAPI/Data/" + str(set_time)
	headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
	r = requests.post(url1, headers=headers)
	time.sleep(3)
	#print r.json()
	d=r.json()
	if ('devices.2.instances.0.commandClasses.50.data.2' in d.keys()):
		print set_time, d['devices.2.instances.0.commandClasses.50.data.2']['val']['value']
	else:
		print set_time, 'Dummy Packet'
	
	
