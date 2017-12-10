data_save = 0;
cd ReadData_Matlab
if data_save
    load('dataset/Wiki10/wiki10.mat');
else
    data = {};
    [x, y] = read_data('dataset/Wiki10/wiki10_train.txt');
    data.X = x';
    data.Y = y';
    [x, y] = read_data('dataset/Wiki10/wiki10_test.txt');
    data.Xt = x';
    data.Yt = y';
    data.name = 'wiki10';
    save('dataset/Wiki10/wiki10.mat', 'data');
end
% params;
cd dataset/Wiki10
wiki10Params

% run SLEEC
cd ../../../
result = SLEEC(data, Params);
save('ReadData_Matlab/dataset/Wiki10/result.mat', 'result');
% calculate recall



