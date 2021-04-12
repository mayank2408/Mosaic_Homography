Ia = imread('image01.jpg') ;
Ia = rgb2gray(Ia);
points1 = (detectSURFFeatures(Ia));
%points1=points1.selectStrongest(6000);

Ib = imread('image02.jpg') ;
Ib = rgb2gray(Ib);
points2 = detectSURFFeatures(Ib);
%points2=points2.selectStrongest(6000);
[f1,vpts1] = extractFeatures(Ia,points1);
[f2,vpts2] = extractFeatures(Ib,points2);
indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
points1=matchedPoints1.Location;
matchedPoints2 = vpts2(indexPairs(:,2));
points2=matchedPoints2.Location;
%figure; showMatchedFeatures(Ia,Ib,matchedPoints1,matchedPoints2);

N=floor(ransac(0.99,0.3,4));
H=get_best(points1,points2,N,0.028);

Ic = imread('image03.jpg') ;
Ic = rgb2gray(Ic);
points3 = detectSURFFeatures(Ic);
%points2=points2.selectStrongest(6000);
[f3,vpts3] = extractFeatures(Ic,points3);
indexPairs = matchFeatures(f2,f3) ;
matchedPoints2 = vpts2(indexPairs(:,1));
points2=matchedPoints2.Location;
matchedPoints3 = vpts3(indexPairs(:,2));
points3=matchedPoints3.Location;
N2=floor(ransac(0.99,0.3,4));
H2=get_best(points2,points3,N2,0.029);