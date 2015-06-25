% Import CSV in to matlab for FFT computation

function Processing_FFT_Ver1_0

%GLOBALS%%%%%%%%%%%%%%%%%%%%%

%Name of folder where trace CSVs are stored
f_number = 'C:\Users\Sanchit-pc\Desktop\USRP\';
%Location of Book.csv
bookpath = 'C:\Users\Sanchit-pc\Desktop\USRP\Book.csv';
%Index of last trace in Book.csv
index1 = 11

buffer(:,:) = zeros(50000,100); %Array to temporarily store fft values
sum_buffer = zeros(50000,1); %Array to average fft values
j = 0; %counter

display(bookpath);

%Read trace numbers from Book.csv
fid = fopen(bookpath,'r');
C = textscan(fid, repmat('%s',1,10), 'delimiter',',', 'CollectOutput',true);
C = C{1};
fclose(fid);

    
for t_index = 2:index1
    
    %counter variable for loop
    j=0;
    %Set trace number of current trace to be processed
    t_number = (C{t_index,1});
    
    %Path to trace CSVs
    path = strcat(f_number,t_number,'.csv');
    display(path);
    display('Loading csv');
    %Read data from trace CSV
    Data = csvread(path);
    display(length(Data));
    % Sampling Frequency
    Fs= 10000000;
    % Load full datagram from CSV payload to matrix for FFT computation
    for index =(1:20)
    % Load the input fed datagram to compute FFT
            x = Data(1+j:99999+j);
            % N is FFT Vector Size
            N = length(x);
            
            %FFT calculation starts here
            display('FFT Start');
            xdft = fft(x); %generate fft 
            xdft = xdft(1:(N+1)/2); %take positive values
            psdx = (1/(Fs*N)).*abs(xdft).^2;
            psdx(2:end-1) = 2*psdx(2:end-1);
            display('FFT Done');
            display(index);
            % Freq. range of observation as shown on X-axis
            freq = 0:Fs/length(x):Fs/2;
            
            %take log of values and store in buffer array
            buffer(:,index) = (10*log10(psdx));
            
            %add fft of one frame to sum array
            sum_buffer = sum_buffer + buffer(:,index);
            
            %initiliaze temp variables for next loop iteration
            j=j+99999;
            N = 0; xdft = 0; psdx = 0;
    end
    display('FFT Averaging over 100 frames');
    
    %avaeraging fft over 100 frames
    sum_buffer = sum_buffer./100;       
    %Convert dB to dBm
    sum_buffer = sum_buffer + 30;
    %File name of FFT averaged data CSV
    output_path = strcat(f_number,t_number,'_FFT_Averaged.csv');
    display(output_path);
    %Write FFT data to CSV
    csvwrite(output_path,[freq',sum_buffer]);
    display('Data Dumped');

end
