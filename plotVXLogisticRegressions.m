%% RP vs. heart Vx
% Logistical regression fits for vX (dose [Gy] in volme fraction X of heart)
tic;
% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end

%% Print variables
printAll='on';
%% V01
%[v01_Bvals,v01_dev,v01_stats] = glmfit(vXs(:,1),[epts ones(size(epts))],'binomial','link','logit');
%sPlotLogisticRegressionWithData(vXs(:,1),epts,v01_Bvals,v01_stats,'v01');

%% V13
[v13_Bvals,v13_dev,v13_stats] = glmfit(v13s,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(v13s,epts,v13_Bvals,v13_stats,'v13');

%% v20
[v20_Bvals,v20_dev,v20_stats] = glmfit(v20s,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(v20s,epts,v20_Bvals,v20_stats,'v20');

%% v30
[v30_Bvals,v30_dev,v30_stats] = glmfit(v30s,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(v30s,epts,v30_Bvals,v30_stats,'v30');

%% B1 pvalues
nVxStep = length(vXs(1,:));

vX_pvals = zeros(nVxStep,1);
for i=1:nVxStep,
    [cur_Bvals,cur_dev,cur_stats] = glmfit(vXs(:,i),[epts ones(size(epts))],'binomial','link','logit');
    vX_pvals(i,1) = cur_stats.p(2);
end
x_axis = [1:nVxStep];

figure('Name',['Logistic Regression B1 p-values vs. Vx'],'NumberTitle','off');
plot(x_axis,vX_pvals,'bs--');
[vX_min,vX_min_ivX] = min(vX_pvals);
hold on;
plot(x_axis(vX_min_ivX),vX_min,'rs--','LineWidth',3);
xlabel('V_{D} [Gy]');
ylabel('P-value for V_{D}');

%% Vx p-values zoom
figure('Name',['Logistic Regression B1 p-values vs. Vx (zoom)'],'NumberTitle','off');
plot(x_axis(1:40),vX_pvals(1:40),'bs--');
hold on;
grid on;
plot(x_axis(vX_min_ivX),vX_min,'rs--','LineWidth',3);
xlabel('V_{D} [Gy]');
ylabel('P-value for V_{D}');
line(x_axis(1:40),0.05,'Color','r','LineStyle','-.');
xlim([0 40]);

%% Min p-value fit
[vmin_Bvals,vmin_dev,vmin_stats] = glmfit(vXs(:,vX_min_ivX),[epts ones(size(epts))],'binomial','link','logit');
vmin_name = num2str(vX_min_ivX);
vmin_name = strcat('V_{',vmin_name);
vmin_name = strcat(vmin_name,'} [%]');
sPlotLogisticRegressionWithData(vXs(:,vX_min_ivX),epts,vmin_Bvals,vmin_stats,vmin_name);
xlim([0 100]);

%% V05 p-value fit
[v05_Bvals,v05_dev,v05_stats] = glmfit(vXs(:,5),[epts ones(size(epts))],'binomial','link','logit');
v05_name = 'V_{05}';
sPlotLogisticRegressionWithData(vXs(:,5),epts,v05_Bvals,v05_stats,v05_name);
xlim([0 100]);

%% V04 p-value fit
[v04_Bvals,v04_dev,v04_stats] = glmfit(vXs(:,4),[epts ones(size(epts))],'binomial','link','logit');
v04_name = 'V_{04}';
sPlotLogisticRegressionWithData(vXs(:,4),epts,v04_Bvals,v04_stats,v04_name);
xlim([0 100]);

%% Run Fisher's exact test with split at median
fpvals = zeros(1,length(vXs(1,:)));
for i=1:length(vXs(1,:)),
    cur_vXs = vXs(:,i);
    comp_vXs = cur_vXs(epts==1);
    cens_vXs = cur_vXs(~epts);
    
    median_vX = median(cur_vXs);
    
    a = sum(comp_vXs<=median_vX);
    b = sum(cens_vXs<=median_vX);
    c = sum(comp_vXs>median_vX);
    d = sum(cens_vXs>median_vX);
    
    K = a+c;
    N = a+b;
    M = a+b+c+d;
    
    fpvals(i)=fexact(a,M,K,N);
end

figure('Visible',printAll,'Name',['Fisher exact pval (median split) vs vX'],'NumberTitle','off');

plot(x_axis,fpvals,'-bs');
ylim([0 0.3]);
xlabel('Dose to Volume');
ylabel('Fisher exact pval');
title('Fisher exact pval (after median split) vs. V_{X}');
disp(['Fishers exact pval after v02 median split: ',num2str(fpvals(2))]);
line(x_axis,0.05,'Color','r','LineStyle','-.');
print('-dpng','Z:\elw\MATLAB\heart\canvases\plotVXLogisticRegressions\latest\heart_vx_fexact_median_split.png');

%% Wilcoxin rank-sum test

wpvals = zeros(1,length(vXs(1,:)));
for i=1:length(vXs(1,:)),
    cur_vXs = vXs(:,i);
    comp_vXs = cur_vXs(epts==1);
    cens_vXs = cur_vXs(~epts);

    sort_cens_vXs = sort(cens_vXs);
    sort_comp_vXs = sort(comp_vXs);

    wpvals(i) = ranksum(sort_comp_vXs,sort_cens_vXs);
end

figure('Visible',printAll,'Name',['Wilcoxon rank-sum pval vs. vX'],'NumberTitle','off');

plot(x_axis,wpvals,'-bs');
ylim([0 0.3]);
xlabel('Dose to volume [Gy]');
ylabel('Rank-sum pval');
title('Wilcoxon rank-sum pval vs. V_{X}');
line(x_axis,0.05,'Color','r','LineStyle','-.');
%min_pval = 'min pval = %6.3g';
%text(30,.15,sprintf(min_pval,min(wpvals)),'FontSize',12);

%disp(['Wilcoxon rank-sum pval for v02: ',num2str(wpvals(70))]);
print('-dpng','Z:\elw\MATLAB\heart\canvases\plotVXLogisticRegressions\latest\vx_heart_rank_sum.png');

%% Student's t-test

stvals = zeros(1,length(vXs(1,:)));
for i=1:length(vXs(1,:)),
    cur_vXs = vXs(:,i);
    comp_vXs = cur_vXs(epts==1);
    cens_vXs = cur_vXs.*(~epts);
    cens_vXs = cens_vXs(cens_vXs>0);% ignore bins with Vx==0, no motivation...
    
    % 'tail' specifies alternate hypothesis:
    %   'right': comp distribution > mean of cens distribution
    %   'left': comp distribution < mean of cens distribution
    %   'both': comp distribution != mean of cens distribution
    [res, stpval] = ttest(comp_vXs,mean(cens_vXs),0.05,'right');

    stvals(i) = stpval;
end

figure('Visible',printAll,'Name',['Students t-test pval vs. vX'],'NumberTitle','off');

plot(x_axis,stvals,'-bs');
%ylim([0 0.3]);
xlabel('Dose to volume [Gy]');
ylabel('t-test pval');
title('Students t-test pval vs. V_{X}');
line(x_axis,0.05,'Color','r','LineStyle','-.');
%min_pval = 'min pval = %6.3g';
%text(30,.15,sprintf(min_pval,min(wpvals)),'FontSize',12);

%disp(['Wilcoxon rank-sum pval for v02: ',num2str(wpvals(70))]);
print('-dpng','Z:\elw\MATLAB\heart\canvases\plotVXLogisticRegressions\latest\vx_heart_ttest.png');

%% vX distributions (cross-check to rank-sum/fisher pvalues)
screen_size = get(0,'ScreenSize');
figure('Name','V_{X} distributions','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;

for i=1:5:length(vXs(1,:)),
    if i==1,
        ind =2;
        cur_vXs = vXs(:,ind);
    else
        cur_vXs = vXs(:,i-1);
    end
    comp_vXs = cur_vXs(epts==1);
    cens_vXs = cur_vXs(~epts);
    subplot(3,5,cur_histo);
    hold on;        
    cur_axis = 1:5:100; % 70 
    bar(cur_axis,hist(cens_vXs,cur_axis),'b');
    bar(cur_axis,hist(comp_vXs,cur_axis),'r');
    if i==1,
        xlabel(strcat('V',num2str(ind)),...
            'BackgroundColor',[.9 .9 .9]);
    else
        xlabel(strcat('V',num2str(i-1)),...
            'BackgroundColor',[.9 .9 .9]);
    end
    xlim([0 100]);
    cur_histo=cur_histo+1;
end
print('-dpng','Z:\elw\MATLAB\heart\canvases\plotVXLogisticRegressions\latest\heart_vx_histos.png');

%% plot Ranked Vx values
plotRankedVXs
