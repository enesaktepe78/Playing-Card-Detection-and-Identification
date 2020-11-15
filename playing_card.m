function playing_card(image)
    clc;
    area=250000;
    cards_number = 0;
    maximum_shape=0;
    maximum_rank=0;

    addpath('/asdas');

    im = imread(image);

    if size(im,1) > size(im,2)
        im = imrotate(im,90);
    end

    original = im;

    SPADES = imread('asdas\spades.jpg');
    HEARTS = imread('asdas\hearts.jpg');
    DIAMONDS = imread('asdas\diamonds.jpg');
    CLUBS = imread('asdas\clubs.jpg');

    A = imread('asdas\A.jpg');
    K = imread('asdas\K.jpg');
    Q = imread('asdas\Q.jpg');
    J = imread('asdas\J.jpg');
    two = imread('asdas\2.jpg');
    three = imread('asdas\3.jpg');
    four = imread('asdas\4.jpg');
    five = imread('asdas\5.jpg');
    six = imread('asdas\6.jpg');
    seven = imread('asdas\7.jpg');
    eight = imread('asdas\8.jpg');
    nine = imread('asdas\9.jpg');
    ten = imread('asdas\10.jpg');
   

    shape_names = {'HEARTS','DIAMONDS','SPADES','CLUBS'};
    rank_names = {'2','3','4','5','6','7','8','9','10','J','Q','K','A'};

    %Adding  templates
   
    suits = {HEARTS,DIAMONDS,SPADES,CLUBS};
    ranks = {two,three,four,five,six,seven,eight,nine,ten,J,Q,K,A};

    for i=1:length(suits)
        suits{i} = preprocess_template(suits{i});
    end

    for i=1:length(ranks)
        ranks{i} = preprocess_template(ranks{i});
    end

    %Preprocess images
    im=preprocessing(im);
    
    %Segmentation image
    [cropp,nlbls] = bwlabel(im);

    % process card
     for card = 1:nlbls
            bounding = (cropp==card);
            %Get the bounding properties
            bounding_properties = regionprops(bounding,'ConvexHull','Area','Centroid','Orientation', 'BoundingBox');
            
           %If  area of convex hull is <=area
           if (bounding_properties.Area <=area)
               continue
           end

          %Crop the playing card out
          cropp_image = imcrop(im, bounding_properties.BoundingBox);
          % angle
          angle = bounding_properties.Orientation;
          % Rotate image
          upright_image = imrotate(cropp_image, -angle+90);
          [rows, columns] = find(upright_image);

          %Crop the playing card after rotating
          top_row = min(rows);
          bottom_row = max(rows);
          left_Column = min(columns);
          right_column = max(columns);
          croppedImage_rotated = upright_image(top_row:bottom_row, left_Column:right_column);
          
          cards_number = cards_number + 1;
          [width,height] = size(croppedImage_rotated);

          rotate_angle = {0,180};
          size_template = {1,0.7};
         
          % template matching             
            for i=1:length(rotate_angle)
                cropped_corner = imrotate(croppedImage_rotated,rotate_angle{i});
                %Get the CORNER
                cropped_corner = cropped_corner(1:int16(width/3),1:int16(height/3));

                %2D Correlation of suits

                for suits_counter=1:length(suits)
                    for q=1:length(size_template)
                        current_shape = imresize(suits{suits_counter},size_template{q});
                        shape_correlation_matrix = normxcorr2(current_shape,cropped_corner);
                        shape_correlation = max(shape_correlation_matrix(:));
                         
                    if (shape_correlation > maximum_shape)
                        maximum_shape = shape_correlation;
                        shape = shape_names{suits_counter};
                    end
                  end
                end

            %2D Correlation of ranks

            for ranks_counter=1:length(ranks)

                for q=1:length(size_template)

                    current_rank = imresize(ranks{ranks_counter},size_template{q});
                    rank_correlation_matrix = normxcorr2(current_rank,cropped_corner);
                    rank_correlation = max(rank_correlation_matrix(:));
                   
                    if (rank_correlation > maximum_rank)
                        maximum_rank = rank_correlation;
                        rank = rank_names{ranks_counter};
                    end
                end
            end
            end

            %Display result
            current_title = sprintf(' %s  %s',rank,shape);

            position = [bounding_properties.Centroid(1) bounding_properties.Centroid(2)];
            
            original = insertText(original,position,current_title,'FontSize',100,'BoxColor','blue','BoxOpacity',0.9,'TextColor','white','AnchorPoint','leftbottom');
            figure;
            imshow(original);

        end
     text_format = sprintf('Cards detected=%d\n',cards_number);
     fprintf(text_format);
end

