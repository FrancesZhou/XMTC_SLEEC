function [result] = run_for_eurlex(data_save, model_save, result_save, calculate_candidate)

subdir_name = 'valid_label_data/';
subdir_name = 'all_label_data/';

% data_save = 1;
% model_save = 1;
% calculate_candidate = 1;
cd ReadData_Matlab
% ======================= data ======================
if data_save
    fprintf('load data\n');
    load('dataset/EUR-Lex/eurlex.mat');
else
    data = {};
    fprintf('read train data\n');
    %[x, y] = read_data('dataset/EUR-Lex/train_data.txt');
    [x, y] = read_data(['dataset/EUR-Lex/', subdir_name, 'train_data.txt']);
    data.X = x';
    data.Y = y';
    fprintf('read test data\n');
    %[x, y] = read_data('dataset/EUR-Lex/test_data.txt');
    [x, y] = read_data(['dataset/EUR-Lex/', subdir_name, 'test_data.txt']);
    data.Xt = x';
    data.Yt = y';
    data.name = 'EUR-Lex';
    fprintf('save data\n');
    %save('dataset/EUR-Lex/eurlex.mat', 'data');
    save(['dataset/EUR-Lex/', subdir_name, 'eurlex.mat'], 'data');
end
% ==================== params =======================
cd dataset/EUR-Lex
fprintf('load params\n');
eurlexParams
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
%result = SLEEC(data, params, model_save, result, 30, 'EUR-Lex/test_score_mat.txt');
result = SLEEC(data, params, model_save, result, 30, ['EUR-Lex/', subdir_name, 'test_score_mat.txt']);

% ==================== calculate_candidate_label =======
if calculate_candidate
    %data_train = {};
    %data_train.X = data.X;
    %data_train.Y = data.Y;
    %data_train.Xt = data.X;
    %data_train.Yt = data.Y;
    %result_train = SLEEC(data_train, params, 1, result, 30, 'EUR-Lex/train_score_mat.txt');
    %result_test = SLEEC(data, params, 1, result, 30, 'EUR-Lex/test_score_mat.txt');
    result_test = SLEEC(data, params, 1, result, 30, ['EUR-Lex/', subdir_name, 'test_score_mat.txt']);
    %candidate_train = int64(result_train.predictLabels');
    candidate_test = int64(result_test.predictLabels');
    %save('ReadData_Matlab/dataset/EUR-Lex/candidate_train.mat', 'candidate_train');
    %save('ReadData_Matlab/dataset/EUR-Lex/candidate_test.mat', 'candidate_test');
    save(['ReadData_Matlab/dataset/EUR-Lex/', subdir_name, 'candidate_test.mat'], 'candidate_test');
end
if result_save
    fprintf('save result\n');
    %save('ReadData_Matlab/dataset/EUR-Lex/result.mat', 'result');
    save(['ReadData_Matlab/dataset/EUR-Lex/', subdir_name, 'result.mat'], 'result');
end
%print result.precision
% calculate recall
% fprintf('calculate recall\n');
% cd ReadData_Matlab/dataset/EUR-Lex
% analyze




