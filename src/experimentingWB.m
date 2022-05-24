% because filtering symmetric behaviour of neural nets is hard
% so we sum each row of weightsMatrix instaed
% networks that are symmetrical to each other should have similar sum
% then we could do hierarchical clustering and plot dendrogram 

% sum each weights and biases vector
summation = sum(weightsMatrix, 2);

% sort it 
sortedSum = sort(summation);
% dendrogram
method = "average";
metric = 'cityblock';
tree = linkage(sortedSum, method, metric);
figure
dendrogram(tree)

% 2d plot
figure
num = size(sortedSum);
num = num(1);

scatter(1:num, sortedSum, LineWidth=2)

% text(1:num, sortedSum, table2cell(array2table(result(:,6))))
title("plot of summation of weights for each training")




