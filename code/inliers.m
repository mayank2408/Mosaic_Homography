function n=inliers(points1,points2,H,threshold)
    points1=[points1,ones(size(points1,1),1)];
    points=points1*(H');
    points1=points(:,1:2)./points(:,3);
    %points2=points2(:,1:2)/points2(:,3);
    n=sum(sqrt(sum((points1-points2).^2,2))<threshold);
   
   %points2=[points2,ones(size(points2,1),1)];
    %n=sum(sqrt(sum((cross(points1,points2).^2),2))<threshold);
end
