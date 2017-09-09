function the_period = periodPulseFin700ms(t)

% periodPulseIni100ms - Returns the last 700ms of the CIP period of 
%			cip_trace, t. 
%
% Usage:
% the_period = periodPulseIni100ms(t)
%
% Description:
%
%   Parameters:
%	t: A trace object.
%
%   Returns:
%	the_period: A period object.
%
% See also: period, cip_trace, trace

time_start = t.pulse_time_start + t.pulse_time_width - 700e-3 / t.trace.dt + 1;
time_end = t.pulse_time_start + t.pulse_time_width - 1;

the_period = period(time_start, time_start + floor((time_end - time_start) / 2));