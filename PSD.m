function [PSD,f] = PSD(HR)
% Compute PSD of the HR signal

fr = 5;

[PSD,f] = pwelch(HR-mean(HR),[],[],[],fr);

end

