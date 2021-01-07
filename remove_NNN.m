function [NN_signal] = remove_NNN(signal)
% Remove non-normal beats


NN_signal = zeros(length(signal),1);

window = 20;

n = window+1;

for i = (window+1:length(signal)-window)
    
    current_RR = signal(i)-signal(i-1);

    mean_RR = (signal(i+window)-signal(i-window))/(2*window);
    
    if (abs(mean_RR-current_RR)/mean_RR)<=0.2
        
        NN_signal(n) = signal(i);
        n = n+1;
        
    elseif current_RR > mean_RR
  
        % A missed detection
            
        NN_signal(n) = (signal(i)+signal(i-1))/2;
            
        NN_signal(n+1) = signal(i);
            
        n = n+2;
        
    end
    
    
end

NN_signal(1:window) = signal(1:window);
NN_signal(end-window+1:end) = signal(end-window+1:end);

end

