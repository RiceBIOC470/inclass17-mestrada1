%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results. 
%GB comments
1.	80 Main problem is that you need to incorporate a script that finds the indices (or positions) of pixels that exhibit minimal differences in the pixel intensities. 
2.	100
overall: 90



img1 = imread('img1.tif');
img2 = imread('img2.tif');
imshow(img1 ,[]);
imshow(img2, []);

% Pixel Value Method

diffs = zeros(1,800);
for ov = 1:799
    pix1 = img1(:, (end-ov):end);
    pix2 = img2(:, 1:(1+ov));
    diffs(ov) = sum(sum(abs(pix1-pix2)))/ov;
end
figure; plot(diffs);
xlabel('Overlap', 'FontSize', 28); ylabel('Mean Difference');
[~, overlap] = min(diffs);
img_align = [zeros(800, size(img2, 2)-overlap+1), img2];
imshowpair(img1, img_align);

% Fourier Transform Method

img1_fft = fft2(img1);
img2_fft = fft2(img2);
[nr, nc] = size(img2_fft);
CC = ifft2(img1_fft.*conj(img2_fft));
CCabs = abs(CC);
figure; imshow(CCabs, []);

[row_shift, col_shift] = find(CCabs == max(CCabs(:)));
Nr = ifftshift(-fix(nr/2):ceil(nr/2)-1);
Nc = ifftshift(-fix(nc/2):ceil(nc/2)-1);
row_shift = Nr(row_shift);
col_shift = Nc(col_shift);
img_shift = zeros(size(img2) + [row_shift, col_shift]);
img_shift((end-799):end, (end-799:end)) = img2;
imshowpair(img1, img_shift);
