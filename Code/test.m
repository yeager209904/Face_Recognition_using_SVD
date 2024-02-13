close all;
clear all;clc

input_image = readImage(strcat('train/', '3.jpg'));
N = 10; 
M  = size(input_image, 1) * size(input_image, 2);


S = zeros(M, N); 
for i = 1:N
    temp = readImage(sprintf('train/%d.jpg', i));
    S(:, i) = temp(:);
end

train_mean = mean(S, 2);
imwrite(uint8(train_mean(:, ones(1, N))), 'mean.jpg');

A = S - train_mean(:, ones(1, N));

[u, s, v] = svd(A);

rank = size(A, 2);
xi = u(:, 1:rank)' * A;


epsilon_0 = 50; 
epsilon_1 = 15;

images = ['1' '3' '5' '11' '25' '38' 'nothing' 'U1' 'U2' 'U3']; 
epsilons = zeros(N, 1);
test_image = readImage('test/U1.jpg');
test_image = test_image(:) - train_mean; 
x = u(:, 1:rank)' * test_image; 
epsilon_f = ((test_image - u(:, 1:rank) * x)' * (test_image - u(:, 1:rank) * x)) ^ 0.5;

if epsilon_f < epsilon_1
    for i = 1:N
        epsilons(i, 1) = (xi(:, i) - x)' * (xi(:, i) - x);
    end
    [val, idx] = min(epsilons(:, 1));
    if val < epsilon_0
        disp(sprintf('The face belongs to %d', idx));
    else
        disp('Unknown face');
    end
else
    disp('Input image is not in the dataset');
end

