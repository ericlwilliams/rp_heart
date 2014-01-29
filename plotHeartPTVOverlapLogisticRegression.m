% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end

[ol_Bvals,ol_dev,ol_stats] = glmfit(ols,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(ols,epts,ol_Bvals,ol_stats,'Heart/PTV Overlap (%)');

