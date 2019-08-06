clear all;clc;close all;

% v = VideoReader('capture0.avi');
% while hasFrame(v)
%     video = readFrame(v);
% end
% whos video

xyloObj = VideoReader('EOGKbVdAud2.asf');

vidWidth = xyloObj.Width;
vidHeight = xyloObj.Height;
mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
k = 1;
while hasFrame(xyloObj)
    mov(k).cdata = readFrame(xyloObj);
    k = k+1;
end
hf = figure;
set(hf,'position',[150 150 vidWidth vidHeight]);

movie(hf,mov,1,xyloObj.FrameRate);