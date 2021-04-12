function H=get_best(points1,points2,N,threshold)
best=0;  
[t1,points1]=transform(points1);
[t2,points2]=transform(points2);
H=zeros(3,3);
    for i=1:N
        r=randperm(size(points1,1),4);
        current_p1=points1(r,:);
        current_p2=points2(r,:);
        h_temp=homography(current_p1,current_p2);
        in_number=inliers(points1,points2,h_temp,threshold);
        if(in_number>best)
            best=in_number
            H=h_temp;
        end
    end
    

    points3=[points1,ones(size(points1,1),1)];
    points=points3*(H');
    points3=points(:,1:2)./points(:,3);
    n=sqrt(sum((points3-points2).^2,2))<threshold;
    H=homography(points1(n,:),points2(n,:));
    H=pinv(t2)*H*(t1);
end