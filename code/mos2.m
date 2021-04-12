function i=mos2(I1,I2)
Ia = rgb2gray(I1);
points1 = (detectSURFFeatures(Ia));
%points1=points1.selectStrongest(6000);

Ib = rgb2gray(I2);
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
i=uint8(final_combine(I1,I2,H));