function a=get_corners(H,img2)
c1=ones(3,1);
c2=[1;size(img2,1);1];
c3=[size(img2,2);1;1];
c4=[size(img2,2);size(img2,1);1];

p1=pinv(H)*c1;
p1=p1/p1(3,1);
p2=pinv(H)*c2;
p2=p2/p2(3,1);
p3=pinv(H)*c3;
p3=p3/p3(3,1);
p4=pinv(H)*c4;
p4=p4/p4(3,1);
a=[p1,p2,p3,p4];