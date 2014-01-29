%% RP vs. heart DX
% Code to plot incidence of RP vs. heart DX (X=25,33,50,66,75 %)
tic;
% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    clear all;

    load('heart_data.mat');
end

%% Fit logistic regression model
[d10_Bvals,d10_dev,d10_stats] = glmfit(d10s,[epts ones(size(epts))],'binomial','link','logit');

%% Plot(doses, b_vals, stats, epts)

sPlotLogisticRegressionWithData(d10s,epts,d10_Bvals,d10_stats,'d10');

toc;