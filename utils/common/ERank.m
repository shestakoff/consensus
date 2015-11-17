function r = ERank(e,k)
 
for t=1:k
    rord(t,1)=size(find(e==t),2);
end

[temp, r]=sort(rord,'descend');
end

