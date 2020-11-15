function output= preprocessing(image)
%% PRE-PROCESSING

    %Histogram Equailization
    image = imadjust(image(:,:,3));

    %Otsu's Method
    threshold = graythresh(image);

    %Convert the image to binary
    image = imbinarize(image,threshold);

    %Noise Removal
    gaussian_filter = fspecial('gauss',2,1);
    image = imfilter(image,gaussian_filter,'same','repl');
    image = medfilt2(image);
    output=image;

end

