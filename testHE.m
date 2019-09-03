low = 0;
high = 255;
alpha = 0.025;
path ='D:\Files\Projects\HISKY\SpeckleDenoising\MyContribution\HiskyData\';
file = dir(fullfile(path,'*.png')); % (*.dat)
fileNames = {file.name}';
numFiles = size(fileNames,1);

for i = 1:1
    singleImgName = strcat(path, fileNames(i));
    img = imread(singleImgName{1});
    figure
    imshow(img)
end

processedImg = HistogramEqualisation(img, low, high, 2)

figure
imshow(processedImg)