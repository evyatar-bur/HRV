function [PSD,f] = PSD(HR)
% Compute PSD of the HR signal

fr = 5;

[PSD,f] = pwelch(HR,200,195,5000,fr);

end

