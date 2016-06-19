%accel_period
rate = 25
[m,n] = size(accel_period)
steps = zeros(m,1);
stepFreq = zeros(m,1);
magnitude = zeros(m,1);
for i=rate:m
    [steps(i), stepFreq(i), magnitude(i)] = count_steps(accel_period(1:i,:),i/rate);
end
