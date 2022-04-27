tic
clear; clc;
% dataset
%  simpleclass_dataset     - Simple pattern recognition dataset.
%    cancer_dataset          - Breast cancer dataset.
%    crab_dataset            - Crab gender dataset.
%    glass_dataset           - Glass chemical dataset.
%    iris_dataset            - Iris flower dataset.
%    ovarian_dataset         - Ovarian cancer dataset.
%    thyroid_dataset         - Thyroid function dataset.
%    wine_dataset            - Italian wines dataset.
data_set_name = 'cancer_dataset';
[x,t] = cancer_dataset;
% configuration
numberOfLayers=1;
hiddenLayerSize = 5;
num_epochs = 80;
lr = 0.03;
num_training = 100;

trainFcn = 'traingd';

% Create a Pattern Recognition Network

net = patternnet(hiddenLayerSize, trainFcn);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
 net.input.processFcns = {'removeconstantrows','mapminmax'};

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivision
net.divideFcn = 'dividerand';  % Divide data in 3 fix portion
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net.trainParam.lr = lr; 
net.trainParam.epochs = num_epochs;
net.trainParam.max_fail = num_epochs; % won't fail before all training finish
net.trainParam.min_grad = 1e-5;
net.trainParam.showWindow = 0;

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'crossentropy';  % Cross Entropy


% start...
result = zeros(num_training,8);
for i = 1:num_training
    [trainPerformance, testPerformance, ...
        valPerformance,best_epoch,wb, trainErrorPercent, ...
        valErrorPercent, testErrorPercent] = trainNetwork(net,x,t);

    result(i,:) = [lr, trainPerformance, testPerformance, ...
        valPerformance,best_epoch, trainErrorPercent, ...
        valErrorPercent, testErrorPercent];

    weightsMatrix(i,:) = wb.';

    fprintf(1, "finished training %d\n", i);
    pause(0.000001)
end

cellTitle = {'learning rate', 'trainPerformance', 'testPerformance', ...
        'valPerformance','best_epoch', 'trainErrorPercent', 'valErrorPercent', 'testErrorPercent'};
cell = num2cell(result);
tableResult = [cellTitle;cell];

save(sprintf("%s_%d_%d_%f_%d_%d.mat", ...
     data_set_name, num_epochs, num_training, lr,hiddenLayerSize, numberOfLayers))

toc


