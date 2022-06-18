% Generate xor-like data as in the tensorflow playground example
% Size of each data cloud
squaresize = 5;
% Space between each data cloud
margin = 0.5;
%Number of points in each data cloud
numpts = 30;
xordata = zeros(numpts*4,2);
x1 = (rand(numpts,2).*squaresize) + margin;
x2 = (rand(numpts,2).*squaresize) + margin;
x2(:,2) = x2(:,2) - squaresize - margin;
x3 = (rand(numpts,2).*squaresize) + margin;
x3(:,1) = x3(:,1) - squaresize - margin;
x4 = (rand(numpts,2).*squaresize)- squaresize - margin;

%Plot the data
figure
plot(x1(:,1),x1(:,2),'b*');
hold on;
plot(x2(:,1),x2(:,2),'r*');
plot(x3(:,1),x3(:,2),'r*');
plot(x4(:,1),x4(:,2),'b*');
grid;

xordata = [x1; x2; x3; x4];
labels = [zeros(numpts,1); ones(numpts,1); ones(numpts,1); zeros(numpts,1)];
