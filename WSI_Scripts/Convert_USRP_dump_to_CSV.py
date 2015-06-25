# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

import numpy as np
from scipy import fft, arange,signal
import scipy
from math import pow, log10  
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import datetime as dt

# <codecell>

#############################
#Convert USRP traces to CSV 
#############################

###GLOBALS
#Location of Book.csv / list of alll traces
bookpath='/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/INDUCTION/Book.csv'

#Path to directory where USRP traces are stored
dirpath='/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/INDUCTION'

#Path to directory where USRP trace CSVs are to be stored after conversion
dirpath2='/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/INDUCTION'

#Set size/number of points in a single traces
num_of_points=1999999

# <codecell>

#Read Book.csv to dataframe
DF1 = pd.read_csv(bookpath)

#Generate list of traces
traces=DF1['Traces'].tolist()

#Store number of traces
n=len(traces)

# <codecell>

#Copy data from traces to array list d
d = [0]*n
for i in range(0,n):
    d[i] = np.memmap(dirpath+'/'+traces[i], mode = 'r' , dtype=np.complex64)
    print 'done',i

#Initialize pandas dataframe
df = pd.DataFrame(columns=[''], index=range(num_of_points), dtype=float)

#Copy data to dataframe df and dump to CSV
for i in range(0,n):
    df[''] = abs(d[i][0:1999999])
    df.to_csv(dirpath2+'/'+traces[i]+".csv",header=False,index=False,index_label=False)
    df = pd.DataFrame(columns=[''], index=range(num_of_points), dtype=float)
    print 'done',i

