training = 2;
test = 3;
validation = 4; 

plot_type = training; % change here for plotting different types


% build histogram
figure
hist = histogram(result(:,plot_type));
titleContent = sprintf("number of epochs per training: %d, " + ...
    "did %d times training, learning rate:%f, hiddenLayerSize:%d, numberOfLayers:%d ", ...
    num_epochs, num_training, lr, hiddenLayerSize, numberOfLayers);
title(titleContent)

% build dendrogram
figure
method = "average";
metric = 'cityblock';
tree = linkage(weightsMatrix, method, metric);

dendrogram(tree)
titleContent = sprintf("WB dendrogram %s with %s, number of epochs per training: %d, " + ...
    "did %d times training, learning rate:%f, hiddenLayerSize:%d, numberOfLayers:%d ", ...
    method, metric, num_epochs, num_training, lr,hiddenLayerSize, numberOfLayers);
title(titleContent)

% plot points
figure
plot(result(:,plot_type),'.','Color','red', 'MarkerSize',20)
titleContent = sprintf("number of epochs per training: %d, " + ...
    "did %d times training, learning rate:%f, hiddenLayerSize:%d, numberOfLayers:%d ", ...
     num_epochs, num_training, lr,hiddenLayerSize, numberOfLayers);
title(titleContent)


% dimentianality reduction to 2d and 3d
[coef, score] = pca(weightsMatrix, "Algorithm","eig"); 
figure
scatter(score(:,1), score(:,2))
title("pca in 2d")
figure
scatter3(score(:,1), score(:,2), score(:,3))
title("pca in 3d")

figure
histogram(result(:,6))
title('training error rate distribution')