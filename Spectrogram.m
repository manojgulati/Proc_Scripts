x=linspace(0, 1, 1024);
s =sin(2*pi*8*x);
plot(x, 100*s)
hold
spectrogram(s, ones(1, 16),15,16, 1024, ‘yaxis’)