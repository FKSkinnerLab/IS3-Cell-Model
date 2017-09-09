function [FreqRangePower, FreqAtMaxPowerPeak] = FiltFFTPower(t, a_period,minfreqrange,maxfreqrange,lowpass40Hz)

% FiltFFTPower - Calculates the area under the power spectrum curve at a
% specified frequency region of interest, as well as the frequency at which
% the power spectrum peaks in that region of interest. Also has the option
% of including a lowpass filter at 40Hz
%
% Usage:
% [FreqRangePower, FreqAtMaxPowerPeak] = FiltFFTPower(t, a_period,minfreqrange,maxfreqrange,lowpass40Hz)
%
% Description:
%
%   Parameters:
%	t: A trace object.
%	period: A period object.
%   minfreqrange: Minimum frequency in frequency range of interest
%   maxfreqrange: Maximum frequency in frequency range of interest
%   lowpass40Hz: if 1, add a lowpass filter at 40Hz
%
%   Returns:
%	FreqRangePower: Area under the power spectrum in the specified frequency range.
%	FreqAtMaxPowerPeak: Frequency at which the highest power peak occurs in the specified frequency range.

t_period = withinPeriod(t,a_period);

% Butterworth filter
if lowpass40Hz
    t_filt = lowpassfilt(t_period,1,40);
else
    t_filt = t_period;
end

% Extract data
data = get(t_filt,'data');
data = data(500:end-500); % Removes data during CIP rise & fall times
dt = get(t_filt,'dt');

% Fast Fourier Transform
m = length(data); % Number of samples
fs = 1/dt; % Sampling frequency in Hz
y = fft(data); % Discrete Fourier Transform (DFT)
power1 = (abs(y).^2)/(fs*m); % Puts power in mV^2/Hz
f = (0:m-1)*(fs/m); % Frequency range

% Indexing Frequency Range of Interest
freq1 = f(f <= maxfreqrange); % Finds all frequency values less than maxfreqrange
freq2 = find(freq1 >=minfreqrange); % Finds all indexed spots in freq1 that are more than minfreqrange
freq = f(freq2);
power = power1(freq2);

% Results
FreqRangePower = trapz(freq,power); % Area under theta power using Trapz function
FreqAtMaxPowerPeak = freq(power == max(power));