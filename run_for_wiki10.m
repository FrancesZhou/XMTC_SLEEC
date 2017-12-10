data_save = 0;
cd ReadData_Matlab
if data_save
    load('dataset/Wiki10/wiki10.mat');
else
    data = {};
    fprintf('read train data\n');
    [x, y] = read_data('dataset/Wiki10/wiki10_train.txt');
    data.X = x';
    data.Y = y';
    fprintf('read test data\n');
    [x, y] = read_data('dataset/Wiki10/wiki10_test.txt');
    data.Xt = x';
    data.Yt = y';
    data.name = 'wiki10';
    fprintf('save data\n');
    save('dataset/Wiki10/wiki10.mat', 'data');
end
% params;
cd dataset/Wiki10
fprintf('load params\n');
wiki10Params

% run SLEEC
cd ../../../
fprintf('run SLEEC\n');
result = SLEEC(data, Params);
fprintf('save result\n');
save('ReadData_Matlab/dataset/Wiki10/result.mat', 'result');
% calculate recall



