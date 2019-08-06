clear all;clc;close all;

PsychDefaultSetup(2);
screenNumber = 1;
black = BlackIndex(screenNumber);

% Timing setting
WaitSecs(0.5);
startTime = GetSecs();
keyIsDown = 0;
stimDuration = 1; % seconds

[wPtr,rect] = PsychImaging('OpenWindow', screenNumber, black); % Open an on screen window and color it black
[screenXpixels, screenYpixels] = Screen('WindowSize', wPtr); % Get window size


% Setting up rectangles
Rect0 = [0 0 screenXpixels/2 screenYpixels/2];
Rect1 = OffsetRect(Rect0,screenXpixels/2,0);
Rect2 = OffsetRect(Rect0,screenXpixels/2,screenYpixels/2);
Rect3 = OffsetRect(Rect0,0,screenYpixels/2);
allRects = [Rect0; Rect1;Rect2;Rect3];
rectColor = [1 0 0];
Screen('TextSize', wPtr, 70);

% Print the rect and text
for i = 1:size(allRects,1)
    %initialise local variables
    pressedKey = 0;
    reactionTime = 0;
    
    Screen('FillRect', wPtr, rectColor, allRects(i,:)');
    DrawFormattedText(wPtr, 'Itching','center','center',[1 1 1],[],[],[],[],[],Rect0);
    DrawFormattedText(wPtr, 'Water','center','center',[1 1 1],[],[],[],[],[],Rect1);
    DrawFormattedText(wPtr, 'Toilet','center','center',[1 1 1],[],[],[],[],[],Rect2);
    DrawFormattedText(wPtr, 'TV','center','center',[1 1 1],[],[],[],[],[],Rect3);
    stimTime = Screen('Flip', wPtr,[],1);
    % Keyboardcheck within one rect
    while GetSecs()<=stimTime + stimDuration
        [keyIsDown,pressedSecs,keyCode] = KbCheck(-1);
        if keyIsDown
            pressedKey = KbName(find(keyCode));
            reactionTime = pressedSecs-stimTime;
        end
    end
    Screen('Flip', wPtr);
    if reactionTime>0
        fprintf('\nKey %s was pressed at %.4f seconds\n\n',pressedKey,reactionTime);
    else
        fprintf('\nNo key pressed\n\n')
    end
end

WaitSecs(stimDuration+2);
sca;