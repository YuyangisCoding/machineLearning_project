training = 2;
test = 3;
validation = 4; 

plot_type = training; % change here for plotting different types
                      % options: training, test, validation


% build histogram
figure
hist = histogram(result(:,plot_type));
titleContent = sprintf("number of epochs per training: %d, " + ...
    "did %d times training, learning rate:%f, hiddenLayerSize:%d, numberOfLayers:%d ", ...
    num_epochs, num_training, lr, hiddenLayerSize, numberOfLayers);
title(titleContent)

% build dendrogram
% see experimentingWB script for nice dendrogram
% figure
% method = "average";
% metric = 'cityblock';
% tree = linkage(weightsMatrix, method, metric);
% 
% dendrogram(tree)
% titleContent = sprintf("WB dendrogram %s with %s, number of epochs per training: %d, " + ...
%     "did %d times training, learning rate:%f, hiddenLayerSize:%d, numberOfLayers:%d ", ...
%     method, metric, num_epochs, num_training, lr,hiddenLayerSize, numberOfLayers);
% title(titleContent)

% plot points for error (calculated by trainFcn)
figure
plot(result(:,plot_type),'.','Color','red', 'MarkerSize',20)
titleContent = sprintf("number of epochs per training: %d, " + ...
    "did %d times training, learning rate:%f, hiddenLayerSize:%d, numberOfLayers:%d ", ...
     num_epochs, num_training, lr,hiddenLayerSize, numberOfLayers);
title(titleContent)


% dimentianality reduction to 2d and 3d

% colormap
num_of_color = size(weightsMatrix);
num_of_color = num_of_color(1);
cm = jet(num_of_color);
[coef, score] = pca(weightsMatrix, "Algorithm","eig"); 
figure
gscatter(score(:,1), score(:,2), result(:,plot_type), cm);
title("pca in 2d")

figure 
scatter3(score(:,1), score(:,2), score(:,3))
title("pca in 3d")

% training error rate distribution fiugre
% figure
% histogram(result(:,6))
% title('training error rate distribution')

% tsne
figure
tsne_result = tsne(weightsMatrix,Perplexity=80, Algorithm="exact");
gscatter(tsne_result(:,1), tsne_result(:,2), result(:,plot_type), cm)






