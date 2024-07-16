%function predict = eSVR(m_tNum, m_cNum, m_gNum, m_pNum)
function [accuracy,predict] = eSVR(x,flag)

global test1 test1Label Vtest1 Vtest1Label Atest1 Atest1Label
m_tNum = 0;
m_cNum = x(2);
m_gNum = x(3); 
m_pNum = x(4);
m_rNum = x(5);
if x(1)<0.5
    m_tNum = 2;
else
    m_tNum = 3;
end
%
class_12_label = test1Label(:,:);%标签值
class_12_value = test1(:,:);%训练集
%
if flag==1
    test_scale_value = Atest1(:,:);
    test_scale_label = Atest1Label(:,:);
else
    test_scale_value = Vtest1(:,:);
    test_scale_label = Vtest1Label(:,:);
end

if m_tNum==0
    cmd = ['-s 3 -t ',num2str(m_tNum),' -c ',num2str(m_cNum),' -q'];
elseif m_tNum==1
    cmd = ['-s 3 -t ',num2str(m_tNum),' -c ',num2str(m_cNum),' -g ',num2str(m_gNum),' -r ',num2str(m_rNum),' -p ',num2str(m_pNum), ' -q'];
elseif m_tNum==2
    cmd = ['-s 3 -t ',num2str(m_tNum),' -c ',num2str(m_cNum),' -g ',num2str(m_gNum),' -p ',num2str(m_pNum), ' -q'];
elseif m_tNum==3
    cmd = ['-s 3 -t ',num2str(m_tNum),' -c ',num2str(m_cNum),' -g ',num2str(m_gNum),' -r ',num2str(m_rNum),' -p ',num2str(m_pNum), ' -q'];
end


%cmd = ['-s 3'];
model = svmtrain(class_12_label(:,1), class_12_value, cmd);
%model1 = svmtrain(class_12_label(:,2), class_12_value, cmd);
%model2 = svmtrain(class_12_label(:,3), class_12_value, cmd);

model = svmtrain(tsy,time,'-c 1000 -g 0.02 -s 3 -p 0.4 -n 0.1');
%[predict2,accuracy2,dec_values_2] = svmpredict(test_scale_label(:,2), test_scale_value,model1);
%[predict3,accuracy3,dec_values_3] = svmpredict(test_scale_label(:,2), test_scale_value,model1);
predict=[predict1];
accuracy=accuracy1(2);
%accuracy=0.5*(accuracy1(2)+accuracy2(2));
%accuracy=1/3*(accuracy1(2)+accuracy2(2)+accuracy3(2));

%predict = mapminmax('reverse',predict,ps);
% [m,n]=size(predict);
% for i=1:m
%     plot(i,predict(i,1),'g+');
%     hold on
%     plot(i,test_scale_label(i,1),'r*');%真实值
 end


