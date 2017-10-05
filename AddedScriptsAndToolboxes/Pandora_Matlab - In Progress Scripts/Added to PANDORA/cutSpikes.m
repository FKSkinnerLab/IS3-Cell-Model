function obj = cutSpikes(t, s)

% cutSpikes - Convert subthreshold windows in the trace to an object
%
% Usage:
% obj = cutSpikes(trace, spikes)
%
% Description:
%   Creates a subthreshold_shape object from non-spiking time windows.
%
% Parameters:
%	trace: A trace object.
%	spikes: (Optional) A spikes object obtained from trace,
%		calculated automatically if given as [].
%
% Author:
%   Alexandre Guet-McCreight

num_traces = length(t);
num_spikes = length(s);

data = get(t, 'data');
SpikesRemovedTrace = nan(1, length(data));

% If called with array of traces
if num_traces > 1
    % If also passed array of spikes objects
    if num_spikes > 1
        if num_spikes ~= num_traces
            error(['Length of trace (' num_traces ') and spikes (' num_spikes ...
                ') arrays must be equal.']);
        end
        for trace_num = 1:num_traces
            SpikesRemovedTrace(trace_num) = cutSpikes(t(trace_num), s(trace_num));
        end
    else
        for trace_num = 1:num_traces
            SpikesRemovedTrace(trace_num) = cutSpikes(t(trace_num), []);
        end
    end
    return;
end

if isempty(s)
    s = spikes(t);
end

period = periodWhole(t);
period_spikes = withinPeriod(s, period);
num_spikes = length(period_spikes.times);

for spike_num = 0:num_spikes+1
    
    if isempty(s.times) % If there are no spikes in the trace
        max_left = 1;
        max_right = length(get(t, 'data'));
        SpikesRemovedTrace(max_left:max_right) = data(max_left:max_right);
        break
    else
        if spike_num == 0
            continue
        end
        if spike_num < num_spikes+1
            spike_idx = s.times(spike_num);
        end
        if spike_num > 1
            spike_idx0 = s.times(spike_num-1);
        end
    end
    
    if spike_num == 1 % If first spike
        
        start = 1;
        % Minimal 1 ms
        max_right = max(1e-3 / t.dt, spike_idx - 10e-3 / t.dt);
        % Calculate right side accordingly
        % Add some more on the right side
%         right = floor(min(50e-3 / t.dt, max_right));
        
        SpikesRemovedTrace(start:max_right) = data(start:max_right);
        
    elseif spike_num > length(s.times) % If after last spike
        
        endd = length(get(t, 'data'));
        % Minimal 1 ms
        max_left = max(0, spike_idx0 + 10e-3 / t.dt);
        % Points from left side of peak, depends on existing data points
%         left = floor(min(7e-3 / t.dt, max_left));
        
        SpikesRemovedTrace(max_left:endd) = data(max_left:endd);
        
    else
        
        max_left = max(0, spike_idx0 + 10e-3 / t.dt);
%         left = floor(min(7e-3 / t.dt, max_left));
        
        max_right = max(1e-3 / t.dt, spike_idx - 10e-3 / t.dt);
%         right = floor(min(50e-3 / t.dt, max_right));
        
        SpikesRemovedTrace(max_left:max_right) = data(max_left:max_right);
        
    end
end
SpikesRemovedTrace(find(isnan(SpikesRemovedTrace))) = []; % Remove NaN index place holders
SpikesRemovedTrace(find(SpikesRemovedTrace > -50)) = []; % Remove if greater than -50 mV (Sometimes it misses spikes that are cut short at the end of the trace)
obj.data = SpikesRemovedTrace;
obj.dt = t.dt;
obj.dy = t.dy;
obj.id = t.id;
obj.props = t.props;
obj = class(obj, 'trace');
