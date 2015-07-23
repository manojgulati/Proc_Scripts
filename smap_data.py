import requests
import csv
import time

time_end = int(time.time()*1000)	#first time assigning the timestamp

while True:

    time_start = time_end	#start time stamp of data collection assigned
<<<<<<< HEAD
    #print "Start_time: %d" % time_start
    time.sleep(60)	# delay to fetch large number of data values. This delay can be set as needed
=======
    time.sleep(10)	# delay to fetch large number of data values. This delay can be set as needed
>>>>>>> 3e91dd4ac2c2cfd437329a43987b64e413552ffc
    time_end = int(time.time()*1000)	#end time stamp of data collection assigned

    url = "http://energy.iiitd.edu.in:9106/api/data/uuid/f0de0796-f3b6-594d-81d5-58d2993b69b7?endtime="+str(time_end)+"&starttime="+str(time_start)+"&limit=-1"

    r = requests.get(url).json()	#writes the readings of the mentioned meter (via its uuid) for the given time stamp from the smap website into r

    readings = r[0]['Readings']	#extract only the readings with the timestamp from the input above and remove the uuid

    print time_start, time_end	#print on screen to keep check of incoming data
    print len(readings)
    
    with open('smap_data.csv', 'ab') as fp:	#to create file for the first time and append the data in csv file
        a = csv.writer(fp, delimiter=',', quoting=csv.QUOTE_MINIMAL)
        a.writerows(readings)

    
#	why limit=-1 is used in url ??
