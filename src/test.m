
load xordata.mat

data_set_name = 'xor';
x = xordata.';
t = labels.';
lr = 0.03;
epoch = 5000;

trainFcn = 'traingd';

% Create a Pattern Recognition Network
net = patternnet(2, trainFcn);

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivision
net.divideFcn = 'dividetrain'; 

net.trainParam.lr = lr; 
net.trainParam.epochs = epoch;
net.trainParam.max_fail = epoch+1; % won't fail before training finish
net.trainParam.min_grad = 0;
net.trainParam.showWindow = 0;

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'crossentropy';  % Cross Entropy

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotconfusion', 'plotroc'};

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
% e = gsubtract(t,y);
% performance = perform(net,t,y);
% tind = vec2ind(t);
% yind = vec2ind(y);
% percentErrors = sum(tind ~= yind)/numel(tind);

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y);
valPerformance = perform(net,valTargets,y);
testPerformance = perform(net,testTargets,y);

best_epoch = tr.best_epoch;
wb = getwb(net);

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)