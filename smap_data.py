import requests
import csv
import pandas as pd
r = requests.get("http://energy.iiitd.edu.in:9106/api/data/uuid/8a95c928-0e5b-5231-b60f-80056da9e263?endtime=1433831400000&starttime=1433827800000&limit=-1").json()	#writes the readings of the mentioned meter (via its uuid) for the given time stamp from the smap website into r
#print r
#print r[0].keys()
readings = r[0]['Readings']	#extract only the readings with the timestamp from the input above and remove the uuid
#print readings
df = pd.DataFrame(readings)	#convert readings into pandas dataframe
df.columns = ["timestamp", "power"]	#columns in the dataframe named
#print df
#df.index = pd.to_datetime(df.timestamp, unit='ms')	#added timestamp of readable date and time
#print df.head()
#df = df.drop("timestamp", 1)	#removed the original timestamp
#print df.head()
#df = df.tz_localize("UTC").tz_convert("Asia/Kolkata")	#changed the timestamp to India's time
#print df.head()
df.to_csv("smap_phase2.csv", sep='\t', encoding='utf-8')
