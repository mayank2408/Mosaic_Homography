function img=final_combine_all(img1,img2,H,min_x_all,min_y_all,min_x_all,max_x_all)
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


n1=ones(3,1);
n2=[1;size(img1,1);1];
n3=[size(img1,2);1;1];
n4=[size(img1,2);size(img1,1);1];

temp=[p1,p2,p3,p4];
[min_x_img2,i]=min([p1(1,1),p2(1,1),p3(1,1),p4(1,1)]);
min_x_img2=floor(min_x_img2);
if ~(temp(i,1,1)>0 &&temp(i,1,1)<=size(img1,1))&&(temp(i,2,1)>0 &&temp(i,2,1)<size(img1,2))   
    out1=intersection(n1,n3,p1,p2);
    out2=intersection(n2,n4,p1,p3);
    if ((out(1,1)>-1) &&out(1,1)<=(size(img1,1)+1)&&(out(2,1)>-1) &&out(2,1)<(size(img1,2)+1))
        min_x_img2=out1(1,1);
    else
        min_x_img2=out2(1,1);
    end
end

min_y_img2=floor(min([p1(2,1),p2(2,1),p3(2,1),p4(2,1)]));
img=zeros(max_y-min_y+1,max_x-min_x+1,3);
% img(1:size(img1,1),1:size(img1,2))=img1;
% for i=1:size(img2,1)
%     for j=1:size(img2,2)
%         p=[i;j;1];
%         p=pinv(H)*p;
%         p=p/p(3,1);
% 
% for i=1:size(img,1)
%     for j=1:size(img,2)
%     p=[i;j;1];
%     p=H*p;
%     p=p/p(3,1);
%     if ((p(1,1)>1 && p(1,1)<size(img2,1)) &&(p(2,1)>1 && p(2,1)<size(img2,2)))
%         v=[img2(floor(p(1,1)),floor(p(2,1))) img2(ceil(p(1,1)),floor(p(2,1)));
%            img2(floor(p(1,1)),ceil(p(2,1))) img2(ceil(p(1,1)),ceil(p(2,1)))] ;  % v = [xmin, xmax;ymin; ymax]
%         v_q=interp2(v,p(1,1),p(2,1),'linear');
%     else v_q=0;
%     end
%     if (v_q>0)
%         if (i<size(img1,1) && (j<size(img1,2)))
%             %alpha=(i-min_x_img2)/(size(img2,1)-min_x_img2);
%             alpha=1/2;
%             img(i,j)=alpha*img1(i,j)+(1-alpha)*v_q;
%         
%         else img(i,j)=v_q;
%         end
%     elseif (i<size(img1,1) && (j<size(img1,2)))
%         img(i,j)=img1(i,j);
%     end
%     end
% end
% end

v_q=zeros(1,3);

for i=min_x:max_x
    for j=min_y:max_y
    p=[i;j;1];
    p=H*p;
    p=p/p(3,1);
    if ((p(1,1)>1 && p(1,1)<size(img2,2)) &&(p(2,1)>1 && p(2,1)<size(img2,1)))
%         v=[img2(floor(p(2,1)),floor(p(1,1))) img2(floor(p(2,1)),ceil(p(1,1)));
%            img2(ceil(p(2,1)),floor(p(1,1))) img2(ceil(p(2,1)),ceil(p(1,1)))] ;  % v = [xmin, xmax;ymin; ymax]
%         v_q=interp2(double(v),p(1,1)-floor(p(1,1))+1,p(2,1)-floor(p(2,1))+1,'linear');
    v_q=img2(round(p(2,1)),round(p(1,1)),:);
    else
        v_q=0;
    end
    if (v_q>0)
       % if ((i-min_x+1)>0&&(i-min_x+1)<size(img1,1) && ((j-min_y+1)>0&&(j-min_y+1)<size(img1,2)))
       if ((i>0 && (i<size(img1,2)))&&(j>0 &&(j<size(img1,1))))
            alpha=double((i-min_x_img2)/(size(img2,1)-min_x_img2));
            %alpha=1/2;
            img(j-min_y+1,i-min_x+1,:)=(1-alpha)*img1(j,i,:)+(alpha)*v_q;
        
       else
           img(j-min_y+1,i-min_x+1,:)=v_q;
        end
    elseif ((i>0 && (i<size(img1,2)))&&(j>0 &&(j<size(img1,1))))
        
        img(j-min_y+1,i-min_x+1,:)=img1(j,i,:);
    end
    end
	
end