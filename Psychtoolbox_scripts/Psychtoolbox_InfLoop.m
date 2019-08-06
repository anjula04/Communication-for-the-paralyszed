% Clear the workspace and the screen
clear all,
clc;
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
% For help see: Screen Screens?
screens = Screen('Screens');

% Draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. When only one screen is attached to the monitor we will draw to
% this.
% For help see: help max
screenNumber = 0;

% Define black (white will be 1 and black 0). This is because
% luminace values are (in general) defined between 0 and 1.
% For help see: help BlackIndex
black = BlackIndex(screenNumber);

% Open an on screen window and color it black
% For help see: Screen OpenWindow?
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect half the screen
Rect0 = [0 0 screenXpixels/2 screenYpixels/2];
Rect1 = OffsetRect(Rect0,screenXpixels/2,0);
Rect2 = OffsetRect(Rect0,screenXpixels/2,screenYpixels/2);
Rect3 = OffsetRect(Rect0,0,screenYpixels/2);
allRects = [Rect0; Rect1;Rect2;Rect3];

% Center the rectangle on the centre of the screen using fractional pixel
% values. For help see: CenterRectOnPointd
centeredRect = CenterRectOnPointd(Rect0, xCenter, yCenter);

rectColor = [1 0 0];
Screen('TextSize', window, 70);

while true
    for i = 1:size(allRects,1)
        Screen('FillRect', window, rectColor, allRects(i,:)');
        DrawFormattedText(window, 'Itching','center','center',[1 1 1],[],[],[],[],[],Rect0);
        DrawFormattedText(window, 'Water','center','center',[1 1 1],[],[],[],[],[],Rect1);
        DrawFormattedText(window, 'Toilet','center','center',[1 1 1],[],[],[],[],[],Rect2);
        DrawFormattedText(window, 'TV','center','center',[1 1 1],[],[],[],[],[],Rect3);
        Screen('Flip', window,[],1);
        WaitSecs(4);
        Screen('Flip', window);
    end
end
% KbStrokeWait
sca;