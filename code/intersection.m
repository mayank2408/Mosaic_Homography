function out=intersection(p1_1,p2_1 ,p1_2,p2_2)
l1=cross(p1_1,p2_1);
l2=cross(p1_2,p2_2);
out=cross(l1,l2);
out=out/out(3,1);