% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end
tic;
%% Mean Heart Dose
md_bins = [10 20 30 50];
[md_xaxis,md_yaxis,yerr] = rebin(mds/100.,epts,md_bins);

%% Plot RP incidence vs mean dose w/ poisson errors
figure('Name','Heart Mean Dose vs. RP','NumberTitle','off');
errorbar(md_xaxis,md_yaxis,yerr.*md_yaxis,...
    '*','LineWidth',2,'MarkerSize',10);
grid on;
hold on;
xlabel('Mean heart dose [Gy]');
ylabel('probability of \geq grade 3 pneumonitis');

%Logistic fit
hold on;
X = md_xaxis';
Y = [md_yaxis' ones(length(md_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;
fit_x=1:100;
Z = logistic(Bvals(1) + fit_x*(Bvals(2)));
plot(fit_x,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(10,0.45,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');





%% Mean Lung Dose
[mld_Bvals,mld_dev,mld_stats] = glmfit(mlds,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(mlds,epts,mld_Bvals,mld_stats,'Mean Lung Dose');

%% Patient rank (by mean lung dose) vs mean heart dose
% problem with keeping epts associated after sorting??

patient_rank = 1:length(mlds);
sorted_mlds = sort(mlds);

figure('Name','Patient rank vs. lung mean dose','NumberTitle','off');
p1=plot(patient_rank,sorted_mlds,'*');
xlabel('Patient Rank (By Mean Lung Dose)');
ylabel('Mean Dose Whole Lung [cGy]');
hold on
sorted_sig_mlds = epts.*mlds;
sorted_sig_mlds = sorted_sig_mlds(sorted_sig_mlds~=0);
sorted_sig_rank = zeros(1, length(sorted_sig_mlds));

for i=1:length(sorted_sig_mlds),
    cur_ind = find(sorted_mlds==sorted_sig_mlds(i));
    sorted_sig_rank(i) = patient_rank(cur_ind);
end
ranksum_p = ranksum(sorted_sig_mlds,sorted_mlds);
 


stat_text = 'Rank-Sum p = %6.3g';
text(3,2000,...
    sprintf(stat_text,ranksum_p),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','w');
p2=plot(sorted_sig_rank,sorted_sig_mlds,'*r');

line(xlim,[median(sorted_mlds) median(sorted_mlds)],'Color','g','LineStyle',':');

legend([p1 p2],'\leq Grade 2','\geq Grade 3','Location','best');
hold off;


%% Mean Heart Dose
[md_Bvals,md_dev,md_stats] = glmfit(mds,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(mds,epts,md_Bvals,md_stats,'Mean Heart Dose');

%% Patient rank (by mean dose) vs mean heart dose
% problem with keeping epts associated after sorting??

patient_rank = 1:length(mds);
sorted_mds = sort(mds);

figure('Name','Patient rank vs. heart mean dose','NumberTitle','off');
p1=plot(patient_rank,sorted_mds,'*');
xlabel('Patient Rank (By Mean Heart Dose)');
ylabel('Mean Dose Heart [cGy]');
hold on
sorted_sig_mds = epts.*mds;
sorted_sig_mds = sorted_sig_mds(sorted_sig_mds~=0);
sorted_sig_rank = zeros(1, length(sorted_sig_mds));

for i=1:length(sorted_sig_mds),
    cur_ind = find(sorted_mds==sorted_sig_mds(i));
    sorted_sig_rank(i) = patient_rank(cur_ind);
end
ranksum_p = ranksum(sorted_sig_mds,sorted_mds);
 


stat_text = 'Rank-Sum p = %6.3g';
text(3,3000,...
    sprintf(stat_text,ranksum_p),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','w');
p2=plot(sorted_sig_rank,sorted_sig_mds,'*r');

line(xlim,[median(sorted_mds) median(sorted_mds)],'Color','g','LineStyle',':');

legend([p1 p2],'\leq Grade 2','\geq Grade 3','Location','best');
hold off;