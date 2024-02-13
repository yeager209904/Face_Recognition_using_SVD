function classId = recognition(img_path,train_mean,U,rank,xi)
N = 5;

epsilon_0 = 50; 
epsilon_1 = 15; 

epsilons = zeros(N, 1);
test_image = readImage(img_path);
test_image = test_image(:) - train_mean; 
x = U(:, 1:rank)' * test_image; 
epsilon_f = ((test_image - U(:, 1:rank) * x)' * (test_image - U(:, 1:rank) * x)) ^ 0.5;

if epsilon_f < epsilon_1
    for i = 1:N
        epsilons(i, 1) = (xi(:, i) - x)' * (xi(:, i) - x);
    end
    [val classId] = min(epsilons(:, 1));
    if val < epsilon_0
        disp(sprintf('The face belongs to %d', classId));
    else
        disp('Unknown face');
    end
else
    disp('Input image is not a face in our dataset');
end

