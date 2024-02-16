%Load the image fig2
Fig = imread('Fig2.tif');
MaxSizeFilter = 9;
Adaptive_median_Filter(Fig,MaxSizeFilter);


%function for adaptive median filter
function Adaptive_median_Filter(image,MaxSizeFilter)

global image_fig;

%coordinates of image
[x,y]=size(image);

%convert image to double
image_fig=double(image);

%Apply median filter
image_fig=MedianFilter(MaxSizeFilter);

%Crop the padded image 
Q=MaxSizeFilter-ceil(MaxSizeFilter/2);
image_fig=image_fig(Q:Q+x-1,Q:Q+y-1);
figure();

%Convert the image type to unit8
imshow(uint8(image_fig),[]);
end

%Output Median Filter function
function output=MedianFilter(MaxSizeFilter)
global imag;
global imageTemp;
    %Median filtered image coordinates x rows, y column
[xb,yb]=size(imag);
 
imageTemp=zeros(xb,yb);

%form a padded image
imag=Padding(MaxSizeFilter);
 
%Start point of filter 
StartPoint=MaxSizeFilter-floor(MaxSizeFilter/2);
   
%Apply computation for each pixel
for i=StartPoint:StartPoint+(xb-1)
    for j=StartPoint:StartPoint+(yb-1)
               
        Computation(3,MaxSizeFilter,i,j);
               
    end
end
output=imageTemp;
end
 
 %function for computation
function Computation(Filter_Size,MaxFilterSize,i,j)
global imageTemp;
global imag;
 
%initialize Zxy
            Zxy=0;
            
            justification=ceil((Filter_Size-1)/2);
            Neighbor=imag(i-justification:i+justification,j-justification:j+justification);
            sortedArea=sort(Neighbor(:));

            % min, max, med variables
            Zmin=sortedArea(1);
            Zmax=sortedArea(end);
            Zmed=median(sortedArea);
            Zxy=imag(i,j);
            
            %Differences between points
            B1=Zxy-Zmin;
            B2=Zxy-Zmax;

            %Apply adaptive Median Filter
            if(B1>0 && B2<0)
                imageTemp(i,j)=Zxy;
                return;
            else
                A1=Zmed-Zmin;
                A2=Zmed-Zmax;
                if(A1>0 && A2<0)
                    imageTemp(i,j)=Zmed;
                    return;
                else
                    if(Filter_Size<MaxFilterSize)
                        Filter_Size=Filter_Size+2;
                        Computation(Filter_Size,MaxFilterSize,i,j);
                        return;
                    else
                        imageTemp(i,j)=Zmed;
                    end
                end
            end
end

%function for output padding
 
function output=Padding(maxPadd)
global imag;
 
 counterPadding=floor((maxPadd-1)/2);
 %Counterpadding check
 while(counterPadding)
     imag=[imag(:,1) imag imag(:,end)]; % or imag=[imag(:,1,:) imag imag(:,end,:)];
     imag=[imag(1,:);imag;imag(end,:)]; % or imag=[imag(1,:,:);imag;imag(end,:,:)];
     counterPadding=counterPadding-1;
 end
 output=imag;
end