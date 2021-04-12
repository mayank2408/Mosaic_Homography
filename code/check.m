function v_q=check(H,p,img2)
p=H*p;
p=p/p(3,1);
v_q=zeros(1,3);
    if ((p(1,1)>1 && p(1,1)<size(img2,2)) &&(p(2,1)>1 && p(2,1)<size(img2,1)))
        v_q=img2(round(p(2,1)),round(p(1,1)),:);
    else
        v_q=(zeros(1,1,3));
    end
end