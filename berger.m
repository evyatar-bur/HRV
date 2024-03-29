function [HR] = berger(signal)
% This function recieves the indexes of R peaks, and uses berger algoritm
% in order to compute HR, in a steady sample rate of 5 Hz 

% Set original sample frequency
fs = 1000;

% Convert the signal from samples to time
time_signal = signal/fs;

% Length of the signal (Sec)
delta_t = time_signal(end)-time_signal(1);

% Set new sample frequency
fr = 5; % Hz

% Preallocate n and time vector

t = (0:round(delta_t*fr))./fr + time_signal(1);
n = zeros(round(delta_t*fr+1),1);

% Create a window around every sample and compute relevant n for every sample

for i = 2:delta_t*fr

    window = [t(i-1) t(i+1)];
    
    % Check if there is an R wave in the window
    R_index = (time_signal > window(1)).*(time_signal < window(2));
    
    if sum(R_index)==1
    % There is a R wave in the window    
        
        r_wave(1:3) = time_signal(find(R_index)-1:find(R_index)+1);
        b = r_wave(2)-window(1);
        c = window(2)- r_wave(2);
        
        n(i) = (b/(r_wave(2)-r_wave(1))) + (c/(r_wave(3)-r_wave(2)));
    
    else
    % There is no R wave in the window (in assumption that there is at least
    % 0.2 seconds between every two beats)
        
        R_index = find((time_signal>window(2)));
        
        r_wave(1:2) = time_signal(R_index(1)-1:R_index(1));
        
        a = window(2)-window(1);
        
        n(i) = a/(r_wave(2)-r_wave(1));
    
    end
        
    
end

% Use the computed n values to compute HR
HR = n.*(fr/2);

end

