function [] = video_renderer(name)

images = {};

imgFiles = dir("./figures/"+name+"*.png");
N = length(imgFiles);

for n = 1:N
    "./figures/"+name+"_"+(n-1)+".png"
    images{end+1} = imread("./figures/"+name+"_"+(n-1)+".png");
end

% create the video writer
writerObj = VideoWriter(name, 'MPEG-4');
writerObj.FrameRate = 45;
% open the video writer
open(writerObj);
% write the frames to the video
for n=1:N
    n
    % convert the image to a frame
    frame = im2frame(images{n});
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);


end

