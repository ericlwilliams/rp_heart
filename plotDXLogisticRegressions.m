%% RP vs. heart DX
% Logistical regression fits for DX (dose [Gy] in volme fraction X of heart)
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

%% D05
[d05_Bvals,d05_dev,d05_stats] = glmfit(d05s,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(d05s,epts,d05_Bvals,d05_stats,'d05');

%% D10
[d10_Bvals,d10_dev,d10_stats] = glmfit(d10s,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(d10s,epts,d10_Bvals,d10_stats,'d10');

%% d25
[d25_Bvals,d25_dev,d25_stats] = glmfit(d25s,[epts ones(size(epts))],'binomial','link','logit');
sPlotLogisticRegressionWithData(d25s,epts,d25_Bvals,d25_stats,'d25');


%% B1 pvalues
nDxStep = length(dXs(1,:));

dX_pvals = zeros(nDxStep,1);
for i=1:nDxStep,
    [cur_Bvals,cur_dev,cur_stats] = glmfit(dXs(:,i),[epts ones(size(epts))],'binomial','link','logit');
    dX_pvals(i,1) = cur_stats.p(2);
end
x_axis = [1:nDxStep];

figure('Name',['Logistic Regression B1 p-values vs. Dx'],'NumberTitle','off');
plot(x_axis,dX_pvals,'bs--');
[dX_min,dX_min_idx] = min(dX_pvals);
hold on;
plot(x_axis(dX_min_idx),dX_min,'rs--','LineWidth',3);
xlabel('Dx');
ylabel('B1 p-value');


figure('Name',['Logistic Regression B1 p-values vs. Dx (zoom)'],'NumberTitle','off');
plot(x_axis(1:40),dX_pvals(1:40),'bs--');
hold on;
grid on;
plot(x_axis(dX_min_idx),dX_min,'rs--','LineWidth',3);
xlabel('D_{V} [Gy]');
ylabel('P-value for D_{V}');
sig_pval = repmat([0.05],1,41);
%plot(x_axis(1:40),sig_pval,'r--','LineWidth',1);
line(x_axis(1:40),0.05,'Color','r','LineStyle','--')
xlim([0 40]);
ylim([0 0.2]);
%% Min p-value fit
[dmin_Bvals,dmin_dev,dmin_stats] = glmfit(dXs(:,dX_min_idx),[epts ones(size(epts))],'binomial','link','logit');
dmin_name = num2str(dX_min_idx);
dmin_name = strcat('D_{',dmin_name,'} [Gy]');
sPlotLogisticRegressionWithData(dXs(:,dX_min_idx),epts,dmin_Bvals,dmin_stats,dmin_name);

%% Min dose with complication vs dX
comp_dxs = dXs(epts==1,:);
[comp_minD_dxs,minD_idx] = min(comp_dxs);
%disp(minD_idx);
figure('Name',['Minimum dose vs DX for patients with complications'],'NumberTitle','off');
plot(x_axis,comp_minD_dxs,'bs--');
xlabel('% heart volume');
ylabel('Minimum dose delivered with complication [Gy]');
grid on;
print('-dpng','Z:\elw\MATLAB\heart\canvases\plotDXLogisticRegressions\latest\dx_min_constraints.png');

%% Avg dose with complications vs dX
comp_dxs = dXs(epts==1,:);
cens_dxs = dXs(~epts,:);
comp_meanD_dxs = mean(comp_dxs);
cens_meanD_dxs = mean(cens_dxs);
cens_maxD_dxs = max(cens_dxs);

figure('Visible',printAll,'Name',['Mean doses vs DX'],'NumberTitle','off');

hold on;

%errorbar(x_axis,cens_meanD_dxs,std(cens_dxs)./2,'b-');
%errorbar(x_axis,comp_meanD_dxs,std(comp_dxs)./2,'r-');

h_dx_constraints(1)=plot(x_axis,cens_meanD_dxs,'b-','LineWidth',2);
h_dx_constraints(2)=plot(x_axis,cens_meanD_dxs+std(cens_dxs)./2,'b:',...
    'LineWidth',2);
%hasbehavior(gco,'legend',false);
h_dx_constraints(3)=plot(x_axis,cens_meanD_dxs-std(cens_dxs)./2,'b:',...
    'LineWidth',2);

h_dx_constraints(4)=plot(x_axis,comp_meanD_dxs,'r-','LineWidth',2);
h_dx_constraints(5)=plot(x_axis,comp_meanD_dxs+std(comp_dxs)./2,'r:',...
    'LineWidth',2);
h_dx_constraints(6)=plot(x_axis,comp_meanD_dxs-std(comp_dxs)./2,'r:',...
    'LineWidth',2);

%x_label=cell(1,(length(x_axis)/10)+1);
%length(x_label)
%for i=1:length(x_label),
%    x_label(i)={strcat('d',num2str((x_axis(i)-1)*10))};
%end
%set(gca,'XTickLabel',x_label);
xlabel('% heart volume');
ylabel('Dose delivered [Gy]');
    
%plot(x_axis,cens_maxD_dxs,'b^');
%plot(x_axis,comp_minD_dxs,'rv');

legend([h_dx_constraints(1) h_dx_constraints(4)],...
    'Mean Censored','Mean Complication','Location','Best');

hold off;

print('-dpng','Z:\elw\MATLAB\heart\canvases\plotDXLogisticRegressions\latest\dx_constraints.png');

%% Run Fisher's exact test with split at median
fpvals = zeros(1,length(dXs(1,:)));
for i=1:length(dXs(1,:)),
    cur_dXs = dXs(:,i);
    comp_dXs = cur_dXs(epts==1);
    cens_dXs = cur_dXs(~epts);
    
    median_dX = median(cur_dXs);
    
    a = sum(comp_dXs<=median_dX);
    b = sum(cens_dXs<=median_dX);
    c = sum(comp_dXs>median_dX);
    d = sum(cens_dXs>median_dX);
    
    K = a+c;
    N = a+b;
    M = a+b+c+d;
    
    fpvals(i)=fexact(a,M,K,N);
end

figure('Visible',printAll,'Name',['Fisher exact pval (median split) vs DX'],'NumberTitle','off');

plot(x_axis,fpvals,'-bs');
ylim([0 0.3])
xlabel('heart volume (%)');
ylabel('Fisher exact pval');
title('Fisher exact pval (after median split) vs. Dx');
disp(['Fishers exact pval after d05 median split: ',num2str(fpvals(5))]);

print('-dpng','Z:\elw\MATLAB\heart\canvases\plotDXLogisticRegressions\latest\heart_dx_fexact_median_split.png');

%% Wilcoxin rank-sum test

wpvals = zeros(1,length(dXs(1,:)));
for i=1:length(dXs(1,:)),
    cur_dXs = dXs(:,i);
    comp_dXs = cur_dXs(epts==1);
    cens_dXs = cur_dXs(~epts);

    sort_cens_dXs = sort(cens_dXs);
    sort_comp_dXs = sort(comp_dXs);

    wpvals(i) = ranksum(sort_comp_dXs,sort_cens_dXs);
end

figure('Visible',printAll,'Name',['Wilcoxon rank-sum pval vs. DX'],'NumberTitle','off');

plot(x_axis,wpvals,'-bs');
ylim([0 0.3]);
xlabel('heart volume (%)');
ylabel('Rank-sum pval');
title('Wilcoxon rank-sum pval vs. Dx');

%min_pval = 'min pval = %6.3g';
%text(30,.15,sprintf(min_pval,min(wpvals)),'FontSize',12);

disp(['Wilcoxon rank-sum pval for d05: ',num2str(wpvals(70))]);
print('-dpng','Z:\elw\MATLAB\heart\canvases\plotDXLogisticRegressions\latest\heart_rank_sum.png');

%% d70 distributions (cross-check to rank-sum/fisher pvalues)
screen_size = get(0,'ScreenSize');
figure('Name','DX distributions','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;

for i=1:5:length(dXs(1,:)),
    if i==1,
        ind =1;
        cur_dXs = dXs(:,i);
    else
        cur_dXs = dXs(:,i-1);
    end
    comp_dXs = cur_dXs(epts==1);
    cens_dXs = cur_dXs(~epts);
    subplot(4,5,cur_histo);
    hold on;        
    cur_axis = 1:5:100;
    bar(cur_axis,hist(cens_dXs,cur_axis),'b');
    bar(cur_axis,hist(comp_dXs,cur_axis),'r');
    if i==1,
        xlabel(strcat('d',num2str(i)),...
            'BackgroundColor',[.9 .9 .9]);
    else
        xlabel(strcat('d',num2str(i-1)),...
            'BackgroundColor',[.9 .9 .9]);
    end
    xlim([0 100]);
    cur_histo=cur_histo+1;
end
print('-dpng','Z:\elw\MATLAB\heart\canvases\plotDXLogisticRegressions\latest\heart_dx_histos.png');


%% plot Ranked Dx values
plotRankedDXs

toc;