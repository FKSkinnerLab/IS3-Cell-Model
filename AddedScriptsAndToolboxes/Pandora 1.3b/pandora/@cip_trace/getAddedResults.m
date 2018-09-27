function results = getAddedResults(a_cip_trace)

% getAddedResults - Calculate added results for depolarization block & fft
%
% Usage:
% results = getAddedResults(a_cip_trace)
%
% Description:
%
%   Parameters:
%	a_cip_trace: A cip_trace object.
%
%   Returns:
%	results: A structure associating test names with result values.

mV_factor = 1e3 * getDy(a_cip_trace);

% Average membrane potential in the first & second halves of the CIP after the initial 100ms
results.PulsePotAvgIni100msRest1 = calcAvg(a_cip_trace, periodPulseIni100msRest1(a_cip_trace)) * mV_factor;
results.PulsePotAvgIni100msRest2 = calcAvg(a_cip_trace, periodPulseIni100msRest2(a_cip_trace)) * mV_factor;

% Average membrane potential in the remaining CIP period after the initial 100ms
results.PulsePotAvgIni100msRest = mean([results.PulsePotAvgIni100msRest1 results.PulsePotAvgIni100msRest2]);

% Ratio of remaining 700ms pulse membrane potential average over Initial membrane potential average
pulse_period = periodPulse(a_cip_trace);
initial_period = periodIniSpont(a_cip_trace);

IniSpontPotAvg = calcAvg(a_cip_trace,initial_period) * mV_factor;
PulsePotAvg = calcAvg(a_cip_trace,pulse_period) * mV_factor;
results.PulseIniSpontPotAvgRatio = abs(PulsePotAvg / IniSpontPotAvg);
results.PulseIniSpontPotAvgDiff = PulsePotAvg - IniSpontPotAvg;
results.PulseIni100msRestIniSpontPotAvgRatio = abs(results.PulsePotAvgIni100msRest / IniSpontPotAvg);
results.PulseIni100msRestIniSpontPotAvgDiff = results.PulsePotAvgIni100msRest - IniSpontPotAvg;

% Total amplitude of area underneath the power spectrum at theta
[ThetaPower, FreqAtMaxThetaPeak] = FiltFFTPower(a_cip_trace,pulse_period,3,12,1);
results.ThetaPower = ThetaPower;
results.FreqAtMaxThetaPeak = FreqAtMaxThetaPeak;