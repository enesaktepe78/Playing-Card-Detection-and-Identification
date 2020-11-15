function output=preprocess_template(image)

    %Contrast Enhancement
    image = imadjust(image(:,:,3));
    
    %Find Otsu's Threshold
    threshold = graythresh(image);
    
    %Convert image to binary
    image = imbinarize(image,threshold);
    
    output = image;
end

