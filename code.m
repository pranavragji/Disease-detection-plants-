clc
RGBo = imread('LeafDe.jpg');
RGB = imresize(RGBo ,.95);
figure,imshow(RGB);title('Orignal')
I = rgb2gray(RGB);
figure,imshow(I);title('Grayscale')



equi = histeq(I);
imshow(equi);title('Histogram Equal')

figure ,imhist(I);title('Histogram')
figure,imshow(RGB);title('normal image')


%texture analyzation
I1=double(RGB)/255;

R=I1(:,:,1);
G=I1(:,:,2);
B=I1(:,:,3);

%Hue
numi=1/2*((R-G)+(R-B));
denom=((R-G).^2+((R-B).*(G-B))).^0.5;

%To avoid divide by zero exception add a small number in the denominator
H=acosd(numi./(denom+0.000001));

%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);


%Normalize to the range [0 1]
H=H/360;

%Saturation
S=1- (3./(sum(I1,3)+0.000001)).*min(I1,[],3);


%Intensity
I1=sum(I1,3)./3;


%HSI
HSI=zeros(size(RGB));
HSI(:,:,1)=H;
HSI(:,:,2)=S;
HSI(:,:,3)=I1;


figure,imshow(H);title('H-Component')
figure,imshow(S);title('S-Component')
figure,imshow(I1);title('I1 Component')
figure,imshow(HSI);title('HSI Image');
