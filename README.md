# Playing-Card-Detection-and-Identification

PLAYING CARD DETECTION

A. Histogram equlization:
Histogram equalization is best method for image enhancement. It provides better quality of images without loss of any information.

B. Image Thresholding:
Image thresholding is a simple way of partitioning an image into a foreground and background. It benefits identifying object in images. Thresholding gives binary image with sharp boundaries

C. Noise removal:
Small regions are removed with noise removal techniques. Small region less than 50000 pixels are removed with “bwareaopen” function

PLAYING CARD RECOGNITION

A. Playing Card Cropping:
Measure properties of segmented images. MATLAB’s region props function finds coordinates and areas. Small region 25000 pixels probably is not a playing card. After detection MATLAB can easily crop the detected area

B. Crop Corner:
Only upper-left and bottom-right corners can use for template
matching. I cropped upper-left corner of rotated card.

C. Template Matching:
Cross correlation enables find the regions in which two
signals most resemble each other. In digital image
processing,2d cross correlation computes the similarity of
image A and template B.
Normxcorr2 function is used in MATLAB

1)Calculate cross-correlation in the spatial or the frequency
domain, depending on size of images.

2)Calculate local sums by precomputing running sums

3)Use local sums to normalize the cross-correlation to get
correlation coefficients.The implementation closely follows
the formula from
