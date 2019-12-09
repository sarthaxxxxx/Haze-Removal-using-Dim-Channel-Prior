function [ radiance ] = dehaze_fast( image, omega, win_size )


if ~exist('omega', 'var')
    omega = 0.95;
end

if ~exist('win_size', 'var')
    win_size = 5;
end

[m, n, ~] = size(image);


f=imread('ge1.png');
gui=imread('ge1.png');


r = 15;
res = 1e-3;
sigma_s=50/min(m,n);
sigma_r=10/255;
sigmas = 1;
sigmar = 2;
tol   = 0.01;
w  = round(6*sigmas);
nstd=10.0;
sigmaC = 8;
epsilon = 0.1;

noisy1 = uint8(double(f)+randn(size(f))*nstd);
noisy2 = saltpepper(noisy1,0.1);


dark_channel = get_dark_channel(image, win_size);


atmosphere = get_atmosphere(image, dark_channel);

trans_est = get_transmission_estimate(image, atmosphere, omega, win_size);
%imshow(trans_est),figure(3)
x = guided_filter(rgb2gray(image), trans_est, r, res); %Guided filter
figure(3),imshow(x,[]),title('Guided Filter')
% xx2=functionabc(x);
% figure(4),imshow(xx2,[]),title('New Operation')

%[x] = customBilateralFilter(trans_est);
%xx2=functionabc(x);
%figure(4),imshow(xx2,[]),title('Contrast')



%x=qx_recursive_bilateral_filter(image,sigma_s,sigma_r,rgb2gray(image));

%%recursive bilateral filter(system crashes always)

%[x, ~] =shiftableBF(image, sigmas, sigmar, w, tol); %Fast Bilateral Filt

%x=guidedbilateralfilter(rgb2gray(noisy2), uint8(trans_est)); % Guided Bilateral Filter 
%figure(3),imshow(x,[])
%x1=x(:,:,2);
%allBlack = zeros(size(image, 1), size(image, 2), 'uint8');
%just_red = cat(3, x1, allBlack, allBlack);
%x=trilateralFilter(image,sigmaC,epsilon);
%figure(3),imshow(x,[])

transmission = reshape(x,m,n);

radiance = get_radiance(image, transmission, atmosphere);

end

