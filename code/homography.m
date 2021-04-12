function H=homography(points1,points2)
%returns homography with last row normalized



A=zeros(2*size(points1,1),9);
for i=1:size(points1,1)
    A(2*i-1,1)=-points1(i,1);
    A(2*i-1,2)=-points1(i,2);
    A(2*i-1,3)=-1;
    A(2*i-1,7)=points2(i,1)*points1(i,1);
    A(2*i-1,8)=points2(i,1)*points1(i,2);
    A(2*i-1,9)=points2(i,1);
    A(2*i,4)=-points1(i,1);
    A(2*i,5)=-points1(i,2);
    A(2*i,6)=-1;
    A(2*i,7)=points2(i,2)*points1(i,1);
    A(2*i,8)=points2(i,2)*points1(i,2);
    A(2*i,9)=points2(i,2);
end
[~,~,v]=svd(A);

H=reshape(v(:,end),3,3)';
