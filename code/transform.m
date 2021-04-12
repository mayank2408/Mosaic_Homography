function [t, points]=transform(points1)
centroid=mean(points1,1);
points=points1-centroid;
t11=eye(3);
t11(1,3)=-centroid(1,1);
t11(2,3)=-centroid(1,2);
c= mean(sqrt(points(:,1).^2+points(:,2).^2));
points=sqrt(2)*points/c;
t2=diag([sqrt(2)/c sqrt(2)/c 1]);
t=t2*t11;