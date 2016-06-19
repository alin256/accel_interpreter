function [ steps, stepFreq, betaMagFinal ] = count_steps( accel_data, time)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
doPlot=1;
minHz = 0.25;
%minHz=0.4;
maxHz=3.17; 

[m,n]=size(accel_data);
if (m<n)
    accel_data = accel_data';
end

if doPlot
    figure(11)
    plot(accel_data);    
end

freq = fft(accel_data);
alpha = abs(freq);
[m,n]=size(alpha);
mHalf=floor((m-1)/2);
alpha_sym = alpha(1+1:1+mHalf,:) + alpha(m:-1:m-mHalf+1,:);

[maxVal, betaHz] = max(alpha_sym);

if doPlot
    figure(12)
    maxInteresting = ceil(maxHz*time*2);
    freq(maxInteresting+1:m-maxInteresting+1,:) = 0;
    plot(ifft(freq));    
end


%steps = betaHz(maxInd);
%steps = median(betaHz);
steps = max(betaHz);
stepFreq = steps / time;


betaMag = zeros(3,1);
for i=1:3
    %betaMag(i) = 2*sum(alpha_sym(betaHz(i):betaHz(i):mHalf,i));
    %betaHzHalfI = ceil(betaHz(i)/2);
    %betaMag(i) =  betaMag(i) + sum(alpha_sym(betaHzHalfI:betaHz(i):mHalf,i));
    betaMag(i) = 2*sum(alpha_sym(steps:steps:mHalf,i));
    betaHzHalfI = ceil(steps/2);
    betaMag(i) =  betaMag(i) + sum(alpha_sym(betaHzHalfI:steps:mHalf,i));
end


betaMagFinal = norm(betaMag, 2)/m;

[maxVal, maxInd] = max(betaMag);

%if stepFreq<minHz || stepFreq>maxHz
%    steps = 0;
%    stepFreq = 0;
%    betaMagFinal = 0;
%    return
%end


end

