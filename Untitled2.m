m = 256;
n = 56;
A = 255*ones(m,m,3);
d = (m-n)/2;
A(d:d+n-1,d:d+n-1) = 0;
B = uint8(A);
imshow(B)