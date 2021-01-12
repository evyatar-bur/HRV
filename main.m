%% HRV - ex.7
close all
clear
clc

% Set sample frequency
fs = 1000; % Hz

% Load R peaks from a given signal
load('peaks.mat')

% Preallocate cells
HR = cell(1,10);
R_peaks = cell(1,10);

figure(1)

for i = 1:10
    
    % Put detection vectors in a cell
    R_peaks{i} = Peaks{i,1}.PeakDetection.Rwaves;

    % Remove non normal intervals
    R_peaks{i} = remove_NN(R_peaks{i});
    
    % Use berger algorithm to compute HR with steady samples
    HR{i} = berger(R_peaks{i});
    
    if i>7
        
        % Set time vector
        t = (0:length(HR{i})-1)./5;
        
        % Plotting last 3 HR graphs together
        plot(t,HR{i})
        
        hold on
    end
end

title('HR as a function of time (BPS)')
xlabel('Time (Sec)')
ylabel('HR (BPS)')
legend('Signal 8','Signal 9','Signal 10')


%% Dividing the signals to segments (manually)

rest{1} = HR{1}(2:502);
stress{1} = HR{1}(4570:5070);

rest{2} = HR{2}(2:502);
stress{2} = HR{2}(2100:2600);

rest{3} = HR{3}(2:502);
stress{3} = HR{3}(2500:3000);

rest{4} = HR{4}(2:502);
stress{4} = HR{4}(2250:2750);

rest{5} = HR{5}(3300:3800);  % After the stress
stress{5} = HR{5}(1500:2000);

rest{6} = HR{6}(2:502);
stress{6} = HR{6}(2000:2500);

rest{7} = HR{7}(2:502);
stress{7} = HR{7}(4300:4800);

rest{8} = HR{8}(2:502);
stress{8} = HR{8}(3800:4300);

rest{9} = HR{9}(2:502);
stress{9} = HR{9}(5820:6320);

rest{10} = HR{10}(2:502);
stress{10} = HR{10}(3400:3900);


%% Compute power spectral density (PSD)

% preallocate cells and vectors
rest_psd = cell(10,2);
stress_psd = cell(10,2);
rest_ratio = zeros(1,10);
stress_ratio = zeros(1,10);

figure(2)

for i = 1:10
    
    % Compute psd of rest HR
    [rest_psd{i,1},rest_psd{i,2}] = PSD(rest{i});

    % Compute psd of stress HR
    [stress_psd{i,1},stress_psd{i,2}] = PSD(stress{i});
    
    % Find indexes of lf and hf
    rest_lf_index = find((rest_psd{i,2}>=0.04).*(rest_psd{i,2}<=0.15));
    rest_hf_index = find((rest_psd{i,2}>0.15).*(rest_psd{i,2}<=0.4));
    
    stress_lf_index = find((stress_psd{i,2}>=0.04).*(stress_psd{i,2}<=0.15));
    stress_hf_index = find((stress_psd{i,2}>0.15).*(stress_psd{i,2}<=0.4));
    
    % Calculate lf/hf ratio
    rest_ratio(i) = sum(rest_psd{i,1}(rest_lf_index))/sum(rest_psd{i,1}(rest_hf_index));
    stress_ratio(i) = sum(stress_psd{i,1}(stress_lf_index))/sum(stress_psd{i,1}(stress_hf_index));
    
    if i>7
        
        % Create PSD subplot of last three signals - stress and rest
        
        subplot(2,1,1)
        plot(rest_psd{i,2},rest_psd{i,1})
        title('Rest PSD')
        xlabel('Frequency (Hz)')
        ylabel('PSD')
        xlim([0.04 0.5])
        ylim([0 0.15])
        
        hold on
        
        subplot(2,1,2)
        plot(stress_psd{i,2},stress_psd{i,1})
        title('stress PSD')
        xlabel('Frequency (Hz)')
        ylabel('PSD')
        xlim([0.04 0.5])
        ylim([0 0.15])
        
        hold on
        
    end
end

subplot(2,1,1)
legend('signal 8','signal 9','signal 10')

subplot(2,1,2)
legend('signal 8','signal 9','signal 10')
hold off

%% Calculate mean of the ratios (rest and stress)

% Calculate standarad deviations and means
STD = [std(rest_ratio) std(stress_ratio)];

mean_ratio = [mean(rest_ratio) mean(stress_ratio)];

% Create error bar
figure(3)
bar([1 2],mean_ratio)

hold on

er = errorbar([1 2],mean_ratio,STD);
er.LineStyle = 'none';
set(gca,'xtick',[1 2],'xticklabel',{'Rest'; 'Stress'})

title('Mean of rest ratios and mean of stress ratios')
ylabel('lf/hf ratio')
xlim([0.5 2.5]);
