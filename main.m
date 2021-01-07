clear
clc

% Set sample frequency
fs = 1000; % Hz

% Load R peaks from a given signal
load('peaks.mat')

HR = {};
R_peaks = {};

figure(1)

for i = 1:10
    
    R_peaks{i} = Peaks{i,1}.PeakDetection.Rwaves;

    R_peaks{i} = remove_NNN(R_peaks{i});
    
    HR{i} = berger(R_peaks{i});
    
    if i>7
        
        % Set time vector
        t = (0:length(HR{i})-1)./5;
        
        plot(t,HR{i})
        
        hold on
    end
end

title('HR as a function of time (BPS)')
xlabel('Time (Sec)')
ylabel('HR (BPS)')
legend('Signal 8','Signal 9','Signal 10')


% Dividing the signals to segments (manualy)

rest{1} = HR{1}(2:2800);
stress{1} = HR{1}(4700:5700);

rest{2} = HR{2}(2:1100);
stress{2} = HR{2}(2000:3000);

rest{3} = HR{3}(4200:6300);
stress{3} = HR{3}(2100:3200);

rest{4} = HR{4}(2:1300);
stress{4} = HR{4}(2200:3300);

rest{5} = HR{5}(2800:3800);
stress{5} = HR{5}(1400:2250);

rest{6} = HR{6}(2:1200);
stress{6} = HR{6}(1800:2800);

rest{7} = HR{7}(500:2000);
stress{7} = HR{7}(4000:5100);

rest{8} = HR{8}(2:2500);
stress{8} = HR{8}(3500:4700);

rest{9} = HR{9}(2:4100);
stress{9} = HR{9}(5400:6800);

rest{10} = HR{10}(4600:5750);
stress{10} = HR{10}(2900:4300);


% 


