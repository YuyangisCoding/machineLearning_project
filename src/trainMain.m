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

load xordata.mat
data_set_name = 'xordata';
x  = xordata.';
t = labels.';
 
% the node topology is I-H-O, for xor data
I = 2; 
H = 2;
O = 1;


% t(2,:) = []; % make output unit become 1
num_training = 3;

%------------------------------------------initialise network
% configuration
numberOfLayers=1;
hiddenLayerSize = 2;
num_epochs = 30000;
lr = 0.005;
trainFcn = 'traingd';    
% Create a Pattern Recognition Network
net = patternnet(hiddenLayerSize, trainFcn);
net = configure(net,x,t); % for manual weight initialisation
net.divideFcn = 'dividetrain'; % whole dataset is for training
net.trainParam.lr = lr; 
net.trainParam.epochs = num_epochs;
net.trainParam.max_fail = num_epochs; % won't fail before all training finish
net.trainParam.min_grad = 0;
net.trainParam.showWindow = 0;
net.layers{1}.transferFcn = 'tansig';
net.performFcn = 'crossentropy';  % Cross Entropy
%------------------------------------------initialise network ends

% start...
result = zeros(num_training,8);
for i = 1:num_training
    % random weights and bias initialisation, from -0.5 to 0.5
    % use same setting as web demo
    rng shuffle % obtain random number generator based current time
    IW = rand(H,I)-0.5;
    b1 = rand(H,1)-0.5;
    LW = rand(O,H)-0.5;
    b2 = rand(O,1)-0.5;
    net.IW{1,1} = IW;
    net.b{1,1} = b1;
    net.LW{2,1} = LW;
    net.b{2,1} = b2;
    % train...
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


