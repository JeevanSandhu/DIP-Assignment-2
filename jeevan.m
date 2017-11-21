im = imread('cameraman.tif');
figure();
imshow(im);

fftim = fftshift(fft2(double(im)));
mag = abs(fftim);
figure();
imshow(mag, []);
figure();
imshow(log(1 + mag), []);

n = 1; %order
d = 50; %cutoff
h = size(im,1);
w = size(im,2);
fftim = fftshift(fft2(double(im)));
[x, y] = meshgrid(-floor(w/2):floor(w/2)-1,-floor(h/2):floor(h/2)-1);
%hhp=(1./(d./(x.^2+y.^2).^0.5).^(2*n));

B = sqrt(2) - 1; %// Define B
D = sqrt(x.^2 + y.^2); %// Define distance to centre
hhp = 1 ./ (1 + B * ((d ./ D).^(2 * n)));
llp = 1 ./ (1 + B * (D ./ d).^(2 * n));
out_spec_centre = fftim .* hhp;
out_spec_centre1 = fftim .* llp;
figure;
imshow(log(1 + abs(out_spec_centre)), []);
figure;
imshow(log(1 + abs(out_spec_centre1)), []);
%imshow(out_spec_centre, []);

%// Uncentre spectrum
out_spec = ifftshift(out_spec_centre);
out_spec1 = ifftshift(out_spec_centre1);

%// Inverse FFT, get real components, and cast
out = real(ifft2(out_spec));
out1 = real(ifft2(out_spec1));
%// Normalize and cast
out = (out - min(out(:))) / (max(out(:)) - min(out(:)));
out = uint8(255*out);
out1 = (out1 - min(out1(:))) / (max(out1(:)) - min(out1(:)));
out1 = uint8(255*out1);
%// Show image
figure;
imshow(out);
figure;
imshow(out1);