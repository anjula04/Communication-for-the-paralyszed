% cmd--> C:\toolbox\OpenBCI_LSL-master
% cmd--> python openbci_lsl.py --stream
% vis_stream
% instantiate the library
clear all; clc;
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an EEG stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EEG'); 
end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');
i = 1;
while i <= 2000
    % get data from the inlet
    [eeg(i,:),ts(i)] = inlet.pull_sample();
    % and display it
%     fprintf('%.2f\t',vec);
%     fprintf('%.5f\n',ts);
    i = i+1;
end

figure
plot(ts,eeg)