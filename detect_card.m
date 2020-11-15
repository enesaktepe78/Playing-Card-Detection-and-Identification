function detect_card(image)
    im = imread(image);
    %Histogram Equailization
    im = rgb2gray(im);
    %Otsu's Method
    threshold = graythresh(im);
    %Convert the image to binary
    im = imbinarize(im,threshold);
    %Noise Removal
    BW2 = bwareaopen(im, 50000);
    %edge detection
    BW2=edge(BW2,'sobel');
    figure;
    imshow(BW2);
end

