function [NN_signal] = remove_NN(signal)
% Remove non-normal intervals


NN_signal = zeros(length(signal),1);

window = 20;

n = window+1;

for i = (window+1:length(signal)-window)
    
    % Calculate the checked interval
    current_RR = signal(i)-signal(i-1);

    % Calculate the mean interval length in the window
    mean_RR = (signal(i+window)-signal(i-window))/(2*window);
    
    if (abs(mean_RR-current_RR)/mean_RR)<=0.2
        % If the interval does not exceed 20%, include it normally
        
        NN_signal(n) = signal(i);
        n = n+1;
        
    elseif current_RR > mean_RR
  
        % If the interval is too long, assume it is a missed detection, and
        % add a detection in the middle
            
        NN_signal(n) = (signal(i)+signal(i-1))/2;
            
        NN_signal(n+1) = signal(i);
            
        n = n+2;
        
    end
    % If the interval is too short, we assume false detection, and do not
    % include the current detection
    
end

% Adding first and last detections
NN_signal(1:window) = signal(1:window);
NN_signal(end-window+1:end) = signal(end-window+1:end);

end

