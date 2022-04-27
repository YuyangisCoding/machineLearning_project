function [trainPerformance, testPerformance,valPerformance,best_epoch, ...
    wb, trainErrorPercent, valErrorPercent, testErrorPercent] = trainNetwork(net, x,t)
% Train the Network
[new_net,tr] = train(net,x,t);
% Test the Network
y = new_net(x);
% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(new_net,trainTargets,y);
valPerformance = perform(new_net,valTargets,y);
testPerformance = perform(new_net,testTargets,y);

best_epoch = tr.best_epoch;
wb = getwb(new_net);

% get training, test, validation error percentage
trainErrorPercent = calcPercentError(trainTargets, y);
valErrorPercent = calcPercentError(valTargets, y);
testErrorPercent = calcPercentError(testTargets, y);

end
