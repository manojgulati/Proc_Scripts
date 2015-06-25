import time
import requests
import csv
while 1:
	time.sleep(3)
	requests.get("http://192.168.11.4:8083/ZWaveAPI/Run/devices[2].instances[0].commandClasses[37].Set(255)")