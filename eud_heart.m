% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end
tic;
nEudStep=21;
%% EUDs
euds_p = zeros(nEudStep,1);
euds_lls = zeros(nEudStep,1);

for i=1:nEudStep;
    [eud_b,eud_dev,eud_stats] = glmfit(euds(:,i),[epts ones(size(epts))],'binomial','link','logit');
    cur_pval = eud_stats.p;
    euds_p(i)=cur_pval(2);
    
    [eud_fit,~,~] = glmval(eud_b,euds(:,i),'logit',eud_stats);
    pr = binopdf(epts, ones(size(epts)),eud_fit);
   % pr(epts==1)=1-pr(epts==1);
    euds_lls(i) = sum(log(pr));
end
x_eud=-1:0.1:1;
figure('Name','Log. Reg. P-val vs. EUD','NumberTitle','off');
hold on;
plot(x_eud,euds_p,'bs--');
[min_eud,min_eud_idx] = min(euds_p);
plot(x_eud(min_eud_idx),min_eud,'rs--');

sig_pval = repmat([0.05],1,length(x_eud));
plot(x_eud,sig_pval,'r.','LineWidth',3);
ylim([0 0.2]);

hold off;

stat_text = 'Min p-value = %6.3g at a = %6.3g';
text(-0.3,0.18,...
    sprintf(stat_text,[min_eud 10^((min_eud_idx-11)/10)]),...
        'FontSize',10,'BackgroundColor','w','EdgeColor','k');
xlabel(['log_{10}(a)']);
ylabel(['EUD vs. RP logistic regression fit p-value']);

%% LLs
figure('Name','Log. Likelihood vs. EUD','NumberTitle','off');
hold on;
plot(x_eud,euds_lls,'*');
[max_eud,max_eud_idx] = max(euds_lls);
plot(x_eud(max_eud_idx),max_eud,'*r');
hold off;

stat_text = 'Max LLs = %6.3g at a = %6.3g';
text(-0.9,-27.2,...
    sprintf(stat_text,[max_eud (max_eud_idx-11)/10]),...
        'FontSize',10,'BackgroundColor','w','EdgeColor','k');
xlabel(['log_{10}(a)']);
ylabel(['EUD vs. Log-Likelihood']);


%% Best log(a)
[best_b,best_dev,best_stats] = glmfit(euds(:,min_eud_idx),[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(euds(:,min_eud_idx),epts,best_b,best_stats,'Heart EUD Dose');
toc;



