function img=final_combine_without_blend(img1,img2,img3,img4,img5,H12,H23,H34,H45)
H35=H34*H45;
H32=inv(H23);
H31=H32*inv(H12);

cor4=get_corners(H34,img4);
cor5=get_corners(H35,img5);
cor2=get_corners(H32,img2);
cor1=get_corners(H31,img1);

min_x=floor(min([1,cor1(1,:),cor2(1,:),cor4(1,:),cor5(1,:)]));
min_y=floor(min([1,cor1(2,:),cor2(2,:),cor4(2,:),cor5(2,:)]));
max_x=ceil(max([size(img3,1),cor1(1,:),cor2(1,:),cor4(1,:),cor5(1,:)]));
max_y=ceil(max([size(img3,2),cor1(2,:),cor2(2,:),cor4(2,:),cor5(2,:)]));

%%%%%%%
% min_x_img2=floor(min([p1(1,1),p2(1,1),p3(1,1),p4(1,1)]));
% 
% 
% n1=ones(3,1);
% n2=[1;size(img1,1);1];
% n3=[size(img1,2);1;1];
% n4=[size(img1,2);size(img1,1);1];
% 
% temp=[p1,p2,p3,p4];
% [min_x_img2,i]=min([p1(1,1),p2(1,1),p3(1,1),p4(1,1)]);
% min_x_img2=floor(min_x_img2);
% if ~(temp(i,1,1)>0 &&temp(i,1,1)<=size(img1,1))&&(temp(i,2,1)>0 &&temp(i,2,1)<size(img1,2))   
%     out1=intersection(n1,n3,p1,p2);
%     out2=intersection(n2,n4,p1,p3);
%     if ((out(1,1)>-1) &&out(1,1)<=(size(img1,1)+1)&&(out(2,1)>-1) &&out(2,1)<(size(img1,2)+1))
%         min_x_img2=out1(1,1);
%     else
%         min_x_img2=out2(1,1);
%     end
% end
% 
% min_y_img2=floor(min([p1(2,1),p2(2,1),p3(2,1),p4(2,1)]));


img=zeros(max_y-min_y+1,max_x-min_x+1,3);
v_q=zeros(1,3);
i1=0;
i2=0;
i3=0;
i4=0;
i5=0;
H33=eye(3);
num=0;
for i=min_x:max_x
    for j=min_y:max_y
    p=[i;j;1];
    v1=int16(check(H31,p,img1));
    i1=(sum(v1)>5);
    v2=int16(check(H32,p,img2));
    i2=(sum(v2)>5);
    v3=int16(check(H33,p,img3));
    i3=(sum(v3)>5);
    v4=int16(check(H34,p,img4));
    i4=(sum(v4)>5);
    v5=int16(check(H35,p,img5));
    i5=(sum(v5)>5);
    num=i1+i2+i3+i4+i5;
    if (num>0)
        img(j-min_y+1,i-min_x+1,:)=(v1+v2+v3+v4+v5)/num;
    end
    end
end 
end