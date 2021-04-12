function img=combine2(img1,img2,H)
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

min_x=floor(min([1,p1(1,1),p2(1,1),p3(1,1),p4(1,1)]));
min_y=floor(min([1,p1(2,1),p2(2,1),p3(2,1),p4(2,1)]));
max_x=ceil(max([size(img1,1),p1(1,1),p2(1,1),p3(1,1),p4(1,1)]));
max_y=ceil(max([size(img1,2),p1(2,1),p2(2,1),p3(2,1),p4(2,1)]));

%%%%%%%
min_x_img2=floor(min([p1(1,1),p2(1,1),p3(1,1),p4(1,1)]));

[u,v]=meshgrid(min_x:max_x,min_y:max_y);


z_ = H(3,1) * u + H(3,2) * v + H(3,3) ;
u_ = (H(1,1) * u + H(1,2) * v + H(1,3)) ./ z_ ;
v_ = (H(2,1) * u + H(2,2) * v + H(2,3)) ./ z_ ;
img1_=zeros(max_x-min_x+1,max_y-min_y+1);
u__=(u >0) &(u<size(img1,1));
v__=(v >0) &(v<size(img1,2));
temp4=u.*u__;
temp5=v.*v__;
temp5(temp5==0)=1;
temp4(temp4==0)=1;
for i=1:size(temp4,1)
    img1_(i,:)=img1(temp4(i),temp5(:,i));
end
