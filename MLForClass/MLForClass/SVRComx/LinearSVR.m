% function predict = eSVR(m_tNum, m_cNum, m_gNum, m_pNum)
function [accuracy,predict11] = LinearSVR(x,flag)

global test1 test1Label Vtest1 Vtest1Label Atest1 Atest1Label
%cd('D:\program files\MATLAB\R2018a\toolbox\liblinear-2.42\matlab')
%cd('D:\program files\MATLAB\R2018a\toolbox\liblinear-2.42\windows')


m_cNum = x(1);
m_pNum = x(2); 
m_eNum = x(3);
if m_cNum<=0
    m_cNum=0.000001;
end
if m_eNum<=0
    m_eNum=0.000001;
end

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

cmd = ['-s 11 -c ',num2str(m_cNum),' -p ',num2str(m_pNum), ' -e ',num2str(m_eNum),' -q'];

%cmd = ['-s 3'];
%model = svmtrain(class_12_label(:,1), class_12_value, cmd);

model = train(class_12_label(:,1), sparse(class_12_value), cmd);
%model1 = svmtrain(class_12_label(:,2), class_12_value, cmd);
%model2 = svmtrain(class_12_label(:,3), class_12_value, cmd);

%model = svmtrain(tsy,time,'-c 1000 -g 0.02 -s 3 -p 0.4 -n 0.1');
[predict1,accuracy1,dec_values_1] = predict(test_scale_label(:,1), sparse(test_scale_value),model);
%[predict2,accuracy2,dec_values_2] = svmpredict(test_scale_label(:,2), test_scale_value,model1);
%[predict3,accuracy3,dec_values_3] = svmpredict(test_scale_label(:,2), test_scale_value,model1);
predict11=[predict1];
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


