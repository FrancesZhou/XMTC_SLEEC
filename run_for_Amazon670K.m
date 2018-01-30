function [result] = run_for_Amazon670K(data_save, model_save, result_save, calculate_candidate)

% data_save = 1;
% model_save = 1;
% calculate_candidate = 1;
cd ReadData_Matlab
% ======================= data ======================
if data_save
    fprintf('load data\n');
    load('dataset/Amazon-670K/Amazon670K.mat');
else
    data = {};
    fprintf('read train data\n');
    [x, y] = read_data('dataset/Amazon-670K/train_data.txt');
    data.X = x';
    data.Y = y';
    fprintf('read test data\n');
    [x, y] = read_data('dataset/Amazon-670K/test_data.txt');
    data.Xt = x';
    data.Yt = y';
    data.name = 'Amazon-670K';
    fprintf('save data\n');
    save('dataset/Amazon-670K/Amazon670K.mat', 'data');
end
% ==================== params =======================
cd dataset/Amazon-670K
fprintf('load params\n');
amazonParams
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
result = SLEEC(data, params, model_save, result, 30, 'Amazon-670K/test_score_mat.txt');

if result_save
    fprintf('save result\n');
    save('ReadData_Matlab/dataset/Amazon-670K/result.mat', 'result');
end

% ==================== calculate_candidate_label =======
if calculate_candidate
    data_train = {};
    data_train.X = data.X;
    data_train.Y = data.Y;
    data_train.Xt = data.X;
    data_train.Yt = data.Y;
    result_train = SLEEC(data_train, params, 1, result, 30, 'Amazon-670K/train_score_mat.txt');
    %result_test = SLEEC(data, params, 1, result, 30);
    %candidate_train = int64(result_train.predictLabels');
    %candidate_test = int64(result_test.predictLabels');
    %save('ReadData_Matlab/dataset/Amazon-670K/candidate_train.mat', 'candidate_train');
    %save('ReadData_Matlab/dataset/Amazon-670K/candidate_test.mat', 'candidate_test');
end




