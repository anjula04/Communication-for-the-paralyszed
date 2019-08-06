% link LSL keyboard app
% instantiate the library
clear all; clc;
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an Keyboard stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','Markers'); 
end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');
while true
    % get data from the inlet
    [kbstroke,ts] = inlet.pull_sample();
    % and display it
    fprintf('%s\t',kbstroke{1,1});
    fprintf('%.5f\n',ts);
end