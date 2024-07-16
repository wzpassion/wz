%_________________________________________________________________________________
%  eSVR:https://www.csie.ntu.edu.tw/~cjlin/libsvm/
%  再运行本项目之前需要按照上述地址安装libSVM控件，否则无法运行eSVR模块
%  或者安装线性分类器，专门针对大数据 https://www.csie.ntu.edu.tw/~cjlin/liblinear/#document
%__________________________________________
clear all 
clc
tic
global test1 test1Label Vtest1 Vtest1Label Atest1 Atest1Label
Best_scoreM = [];
Best_posM = [];
m_accuracy = [];
% m_tIter = 10;%循环次数 
% for kk=1:1:m_tIter
%%
%读取数据
%appliance energy D1
     % aaArrayTest = importdata('..\data\applianceEnergydata.txt');

%Beijing PM2.5 D2
   % aaArrayTest = importdata('..\data\beijingPM25.txt');
    
%Beijing BikeSharing D3
%    aaArrayTest = importdata('..\data\BikeSharing.txt');
    
%Beijing Query Analytics Workload D4
       aaArrayTest = importdata('..\data\QueryWorkload.txt');
       aaArrayTest = aaArrayTest(all(~isnan(aaArrayTest),2),:);

% Wave Energy Converters D5
%     aaArrayTest = importdata('..\data\Metro.txt');    
%%
%训练集:验证集:测试集=98:1:1;数据量小于10000时，建议比例为6:2:2
aaSize = size(aaArrayTest,1);
bbSize = size(aaArrayTest,2);
trainSize = floor(aaSize*98/100);
trainSizeVa = floor(aaSize*99/100);%验证集1%
test11=aaArrayTest(1:trainSize,1:bbSize-1);%training data
test1Label1=aaArrayTest(1:trainSize,bbSize);%training label
Atest11=aaArrayTest(trainSize+1:trainSizeVa,1:bbSize-1);%validated data
Atest1Label1=aaArrayTest(trainSize+1:trainSizeVa,bbSize);%validated data
Vtest11=aaArrayTest(trainSizeVa+1:aaSize,1:bbSize-1);%test data 
Vtest1Label1=aaArrayTest(trainSizeVa+1:aaSize,bbSize);%test label
%norm
[test1,minp,maxp,test1Label,mint,maxt] = premnmx(test11',test1Label1');
Atest1 = tramnmx(Atest11',minp,maxp);
Atest1Label = tramnmx(Atest1Label1',mint,maxt);
Vtest1 = tramnmx(Vtest11',minp,maxp);
Vtest1Label = tramnmx(Vtest1Label1',mint,maxt);
Atest1 = Atest1';
Atest1Label = Atest1Label';
test1 = test1';
test1Label = test1Label';
Vtest1 = Vtest1';
Vtest1Label = Vtest1Label';
%%
% 聚类  可以大大减少运行时间，但可能会失去一部分精度，此处 仅提供kmeans聚类
center = kmeansTest(60);
test1=center(:,1:bbSize-1);
test1Label=center(:,bbSize);
%%
%使用元启发算法优化SVR超参数
SearchAgents_no=30; % Number of search agents
Function_name='F1';
Max_iteration=1; % Maximum numbef of iterations% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[Best_score,Best_pos,ALO_cg_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
%%
%验证集测试误差，仅考虑MSE
Best_posM=[Best_posM;Best_pos];%最优位置或变量
Best_scoreM=[Best_scoreM,Best_score];%最优MSE(误差)
%测试集测试，训练集统一不变。
[accuracy,predict] = LinearSVR(Best_pos,2);
m_accuracy = [m_accuracy,accuracy];
% end
display(['mean MSE of Validation data is \m ', num2str(mean(Best_scoreM))]);
display(['mean MSE of test data is \m ', num2str(mean(m_accuracy))]);
toc %计时



