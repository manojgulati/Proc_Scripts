
import socket
import sys
import numpy as np
import struct
import scipy


#########################################################
#Sets up a tcp_client to receive data from USRP tcp_sink 
#and dump data to file
#########################################################

###GLOBALS
file_size = 1999999 #Number of data points in single traces
no_of_files = 10 #Number of traces to be taken

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the port
server_address = ('127.0.0.1', 10000)
print >>sys.stderr, 'starting up on %s port %s' % server_address
sock.bind(server_address)

# Listen for incoming connections
sock.listen(1)

#Set client address and port number
client_address=('127.0.0.1',10000)

while True:
	print >>sys.stderr, 'waiting for a connection'
	connection, client_address = sock.accept()
	try:
		print >>sys.stderr, 'connection from', client_address
		num_of_points = 0  #counter for no. of points
		file_no = 1 #counter for no. of files
        	fname="Trace_0000"  #Name data dump file
		f = open(fname, 'a')
		print "File created: "+fname
	        # Receive the data in small chunks and retransmit it
	    	while True:
            		data = connection.recv(8);
            		f.write(data)	    
            		num_of_points += 1
            		if(num_of_points == file_size):
                		f.close()
				print "Done.: "+fname
				#New dump file name
				fname="Trace_000"+str(file_no)
                		f = open(fname, 'a')
				print "Opening new file : "+fname
				if(file_no == no_of_files):
					break
				num_of_points = 0
				file_no += 1
				

		print "Done creating files.."
	finally:
		connection.close()
		break	
