function results = getSpikesRemovedPotResults(t, s)

% getSpikesRemovedPotResults - Runs test results for aggregate potential values (avg, std, min, and max)
%	       for the whole trace period and return them in a structure.
%
% Usage:
% results = getSpikesRemovedPotResults(t)
%
% Description:
%
%   Parameters:
%	t: A trace object.
%
%   Returns:
%	results: A structure associating potential info names to values in mV as
%		 follows:
%	   min - minimum potential for the whole trace.
%	   avg - average potential for the whole trace.
%	   max - maximum potential for the whole trace.
%
% See also: spike_shape
%
% Author: 
%   Cengiz Gunay <cgunay@emory.edu>, 2004/09/13
%   Vladislav Sekulic <vlad.sekulic@utoronto.ca>, 2011/03/19
%   Alexandre Guet-McCreight <alexandre.guet.mccreight@mail.utoronto.ca>

a_trace = cutSpikes(t, s);

if ~ exist('plotit', 'var')
  plotit = 0;
end

% Check for empty object first.
if isempty(a_trace.data) 
  results.spikesremoved_min = NaN;
  results.spikesremoved_avg = NaN;
  results.spikesremoved_max = NaN;
  results.spikesremoved_std = NaN;
  return;
end

% convert all to ms/mV(mA)
ms_factor = 1e3 * a_trace.dt;
mV_factor = 1e3 * a_trace.dy;

% Run tests
results.spikesremoved_min = calcMin(a_trace) * mV_factor;
results.spikesremoved_max = calcMax(a_trace) * mV_factor;
results.spikesremoved_avg = calcAvg(a_trace) * mV_factor;
results.spikesremoved_std = calcSTD(a_trace) * mV_factor;
