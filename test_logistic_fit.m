% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    clear all;

    load('heart_data.mat');
end

%% Calculate MD vs RP plot
mean_dose = mds/100.;
xaxis = [5:5:max(mean_dose(:,1))+5];

yaxis = zeros(1,length(xaxis));
nyaxis = yaxis;
for i=1:length(mean_dose),
    cur_md = mean_dose(i);
    for j=1:length(xaxis),
        if cur_md < xaxis(j),
            yaxis(j)=yaxis(j)+epts(i,1);
            nyaxis(j)=nyaxis(j)+1;
            break
        end
    end
end

yaxis=yaxis./nyaxis;

yerr = (nyaxis.^(-.5));
%% Plot RP incidence vs mean dose w/ poisson errors
figure('Name','Heart Mean Dose vs. RP','NumberTitle','off');
errorbar(xaxis,yaxis,yerr.*yaxis,'*');
hold on;
grid on;
xlabel('Mean heart dose [Gy]');
ylabel('probability of \geq grade 3 pneumonitis');


%% Fit logistic regression
%Y = [yaxis' nyaxis'];
%X = mean_dose;

[Bvals,dev,stats] = glmfit(mean_dose,[epts ones(length(epts), 1)],'binomial','link','logit');
Pvals =stats.p;
Z = logistic(Bvals(1) + xaxis*(Bvals(2)));
plot(xaxis,Z);
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(2.5,0.4,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w');

