tic;
% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end

%% Logistic Regression
plotHeartPTVOverlapLogisticRegression

%% Overlap distributions
plotHeartPTVOverlapDistributions

toc
