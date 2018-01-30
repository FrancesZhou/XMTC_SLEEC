function [result] = run_for_wiki10(data_save, model_save, result_save, calculate_candidate)

% data_save = 1;
% model_save = 1;
% calculate_candidate = 1;
cd ReadData_Matlab
% ======================= data ======================
if data_save
    fprintf('load data\n');
    load('dataset/Wiki10/wiki10.mat');
else
    data = {};
    fprintf('read train data\n');
    [x, y] = read_data('dataset/Wiki10/train_data.txt');
    data.X = x';
    data.Y = y';
    fprintf('read test data\n');
    [x, y] = read_data('dataset/Wiki10/test_data.txt');
    data.Xt = x';
    data.Yt = y';
    data.name = 'wiki10';
    fprintf('save data\n');
    save('dataset/Wiki10/wiki10.mat', 'data');
end
% ==================== params =======================
cd dataset/Wiki10
fprintf('load params\n');
wiki10Params
% ==================== model ========================
if model_save
    fprintf('load trained model\n');
    load('result.mat');
    cd ../../../
else
    result = {};
    % run SLEEC
    cd ../../../
end

fprintf('run SLEEC\n');
result = SLEEC(data, params, model_save, result, 30, 'Wiki10/test_score_mat.txt');
%candidate_test = int64(result.predictLabels');
%save('ReadData_Matlab/dataset/Wiki10/candidate_test.mat', 'candidate_test');

% ==================== calculate_candidate_label =======
if calculate_candidate
    data_train = {};
    data_train.X = data.X;
    data_train.Y = data.Y;
    data_train.Xt = data.X;
    data_train.Yt = data.Y;
    result_train = SLEEC(data_train, params, 1, result, 30, 'Wiki10/train_score_mat.txt');
    %result_test = SLEEC(data, params, 1, result, 30);
    candidate_train = int64(result_train.predictLabels');
    %candidate_test = int64(result_test.predictLabels');
    save('ReadData_Matlab/dataset/Wiki10/candidate_train.mat', 'candidate_train');
end
if result_save
    fprintf('save result\n');
    save('ReadData_Matlab/dataset/Wiki10/result.mat', 'result');
end
% calculate recall
fprintf('calculate recall\n');
cd ReadData_Matlab/dataset/Wiki10
analyze




