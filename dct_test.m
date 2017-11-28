im = imread('images/cameraman.tif');
im = double(im);

dctim = dct2(im);
dctim(abs(dctim) < 100) = 0;
rim = idct2(dctim);
imshowpair(im, rim, 'montage');

% Q = dct(im, [], 1);
% R = dct(Q, [], 2);
% 
% X = R(:);
% 
% [~,ind] = sort(abs(R(:)),'descend');
% coeffs = 1;
% while norm(X(ind(1:coeffs)))/norm(X) < .999
%    coeffs = coeffs + 1;
% end
% fprintf('%3.1f%% of the coefficients are sufficient\n',coeffs/numel(R)*100)
% 
% R(abs(R) < X(coeffs)) = 0;
% 
% S = idct(R, [], 2);
% T = idct(S, [], 1);
% 
% T = uint8(T);
% whos('T');
% figure; imshow(T);
% 
% im = uint8(im);
% whos('im');
% figure; imshow(im);