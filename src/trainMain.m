tic
% clear; clc;
% example built in dataset
%    simpleclass_dataset     - Simple pattern recognition dataset.
%    cancer_dataset          - Breast cancer dataset.
%    crab_dataset            - Crab gender dataset.
%    glass_dataset           - Glass chemical dataset.
%    iris_dataset            - Iris flower dataset.
%    ovarian_dataset         - Ovarian cancer dataset.
%    thyroid_dataset         - Thyroid function dataset.
%    wine_dataset            - Italian wines dataset.


data_set_name = 'xor';

x = xordata.';
t = labels.';
%Try a smaller dataset
%x = x(:,1:10);
%t = t(1:10);
%[x,t]=cancer_dataset;
% configuration
numberOfLayers=1;
hiddenLayerSize = 2;
num_epochs = 300;
lr = 0.3;
num_training = 500;

trainFcn = 'trainscg';

% Create a Pattern Recognition Network
net = patternnet(hiddenLayerSize, trainFcn);

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivision
net.divideFcn = 'dividetrain'; % whole dataset is for training
% net.divideMode = 'sample';
% net.divideParam.trainRatio = 100/100;
% net.divideParam.valRatio = 0;
% net.divideParam.testRatio = 0;
net.trainParam.lr = lr; 
net.trainParam.epochs = num_epochs;
net.trainParam.max_fail = num_epochs; % won't fail before all training finish
net.trainParam.min_grad = 0;
net.trainParam.showWindow = 0;

net.layers{1}.transferFcn = 'tansig';

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

save(sprintf("%s_%d_%d_%f_%d_%d_%s.mat", ...
     data_set_name, num_epochs, num_training, lr,hiddenLayerSize, numberOfLayers, trainFcn))

toc


