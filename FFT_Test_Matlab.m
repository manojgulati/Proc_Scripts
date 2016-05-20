% Manoj Gulati
% IIIT-D

% % FFT Example in Matlab Toolbox
% http://in.mathworks.com/help/matlab/ref/fft.html

% clear all previously stored variables
clear all;
close all;
clc;

Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 1000;             % Length of signal
t = (0:L-1)*T;        % Time vector

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

X = S ;

%%
plot(1000*t(1:50),X(1:50))
title('Signal')
xlabel('t (milliseconds)')
ylabel('X(t)')

%%
Y = fft(X);

P2 = abs(Y/L);

% % This scaling is required if you are looking at postive half of the 
% % frequency spectrum
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%% Plot in log scale

plot(f,10*log10(((P1.^2)/10^3)))
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


%% Checking for Parseval's Theorem (Energy in time and freq. domain 
% should remain consistent)

E1_timedomain=sum(abs(X.^2))
E1_freqdomain=sum(abs(Y.^2))/L



