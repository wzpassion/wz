
function [new_center]=kmeansTest(N)
global test1 test1Label Vtest1 Vtest1Label
data=[test1,test1Label]; 
[m,n]=size(data);
pattern=zeros(m,n+1);
center=zeros(N,n);
pattern(:,1:n)=data(:,:);
for x=1:N
    imRand = randi(m);
    if imRand<1 || imRand>m
        imRand = randi(m);
    end
    center(x,:)=data(imRand,:);
end
center = rmmissing(center);
N=size(center,1);
while 1
distence=zeros(1,N);
num=zeros(1,N);
new_center=zeros(N,n);
 
for x=1:m
    for y=1:N
    distence(y)=norm(data(x,:)-center(y,:));
    end
    [~, temp]=min(distence);
    pattern(x,n+1)=temp;         
end
k=0;
for y=1:N
    for x=1:m
        if pattern(x,n+1)==y
           new_center(y,:)=new_center(y,:)+pattern(x,1:n);
           num(y)=num(y)+1;
        end
    end
    if num(y)==0
        new_center(y,:)=new_center(y,:)/num(y-1);
    else
        new_center(y,:)=new_center(y,:)/num(y);
    end
    if norm(new_center(y,:)-center(y,:))<0.1
        k=k+1;
    end
end

if k>N-4
     break;
else
     center=new_center;
end
end
[m, n]=size(pattern);
new_center = rmmissing(new_center);
end