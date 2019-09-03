% Algorithm: Histogram Equalization

% Input: 
%    img: 2D gray image
%    [low, high]: minimum value and maximum value of pixels for transfered imge
%    Method: method  = 1 'common method'
%            method  = 2 'hyperbolisation'

% Output:
%    processedImg: transfered image

function processedImg = HistogramEqualisation(img, low, high, method, alpha)

if nargin < 3
    
   error(message('Input parameters is not enough, please recheck.'))

end

if nargin == 3
    
    method = 1;
    
end

if method ==2 && nargin ==4
    
    alpha = 0.025
    
end

numElement = numel(img);

uniqueElement = unique(img);

numUniqueElement = size(uniqueElement, 1);

% compute old probability function
numPixelList = [];
for i = 1 : numUniqueElement
    
    numPixel = size(find(img == double(uniqueElement(i))), 1);
    
    functionValue = numPixel/numElement;
    
    numPixelList = [numPixelList; functionValue];
    
end

% compute cumulative probability funcition

cumuLativePixel = cumsum(numPixelList);

if cumuLativePixel(end) ~= 1
    error(message(('alogrithm histogram equalization is wrong')))
end

if method == 1
    %
    %Methond 1 (common)
    %compute the pixel mapping
    mappingElementList = [];

    for i = 1: numUniqueElement

        mappingElement = ceil(cumuLativePixel(i)*(high-low + 1) -1);

        mappingElementList = [mappingElementList; mappingElement];

    end
    
end

if method == 2
    
    % Method 2 (Histogram Hyperbolisation)
    % compute the pixel mapping
    mappingElementList = [];

    A = alpha/(1 - exp(-alpha*(high-low)));

    for i = 1: numUniqueElement

    mappingElement = floor((-1/alpha)* log(1 - (alpha/A)*cumuLativePixel(i)) + 0.5); 

    mappingElementList = [mappingElementList; mappingElement];

    end
end

% get the transfered image

HEImg = zeros(size(img));

for i = 1:numUniqueElement
    
    index = find(img == uniqueElement(i));
    
    HEImg(index) = mappingElementList(i);
    
end

processedImg = uint8(HEImg);

% figure
% imshow(processedImg)

end

