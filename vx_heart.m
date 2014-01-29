%% RP vs. heart VX
% Code to plot incidence of RP vs. heart VX (X=13,20,30 Gy)

% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    clear all;

    load('heart_data.mat');
end

screen_size = get(0,'ScreenSize');
%% VX
cc2 = 'R^{2} = %6.3g';
figure('Name','VX correlations','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
subplot(2,2,1);
scatter(v13s,v20s);
hold on
sig_v13s = v13s.*epts;
sig_v20s = v20s.*epts;
scatter(sig_v13s(sig_v13s~=0),sig_v20s(sig_v20s~=0),'r','MarkerFaceColor','r');
xlabel('V_{13} [%]');
ylabel('V_{20} [%]');
ylim([0 100]);
xlim([0 100]);
R_v13_v20 = corrcoef(v13s,v20s);
text(10,80,sprintf(cc2,R_v13_v20(1,2)^2),'FontSize',12);

%V13 vs V30
subplot(2,2,2);
scatter(v13s,v30s);
hold on
sig_v30s = v30s.*epts;
scatter(sig_v13s(sig_v13s~=0),sig_v30s(sig_v30s~=0),'r','MarkerFaceColor','r');
xlabel('V_{13} [%]');
ylabel('V_{30} [%]');
ylim([0 100]);
xlim([0 100]);
R_v13_v30 = corrcoef(v13s,v30s);
text(10,80,sprintf(cc2,R_v13_v30(1,2)^2),'FontSize',12);

% V20 vs V30
subplot(2,2,3);
scatter(v20s,v30s);
hold on
sig_v20s = v20s.*epts;
scatter(sig_v20s(sig_v20s~=0),sig_v30s(sig_v30s~=0),'r','MarkerFaceColor','r');
xlabel('V_{20} [%]');
ylabel('V_{30} [%]');
ylim([0 100]);
xlim([0 100]);
R_v20_v30 = corrcoef(v20s,v30s);
text(10,80,sprintf(cc2,R_v20_v30(1,2)^2),'FontSize',12);

%% V13
v13_bins = [20,40,60,100];
[v13_xaxis,v13_yaxis,yerr] = rebin(v13s,epts,v13_bins);

figure('Name','Heart V13 vs. RP','NumberTitle','off');
errorbar(v13_xaxis,v13_yaxis,yerr.*v13_yaxis,...
'*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('V_{13}[%]');
ylabel('probability of \geq grade 3 pneumonitis');
xlim([0 150]);
ylim([0 0.8]);

%Logistic fit
hold on;
X = v13_xaxis';
Y = [v13_yaxis' ones(length(v13_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;
fit_x=1:150;
Z = logistic(Bvals(1) + fit_x*(Bvals(2)));
plot(fit_x,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(10,0.45,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');

%% V20
v20_bins = [20,40,60,100];
[v20_xaxis,v20_yaxis,yerr] = rebin(v20s,epts,v20_bins);

figure('Name','Heart V20 vs. RP','NumberTitle','off');
errorbar(v20_xaxis,v20_yaxis,yerr.*v20_yaxis,...
'*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('V_{20}[%]');
ylabel('probability of \geq grade 3 pneumonitis');
xlim([0 150]);
ylim([0 0.8]);

%Logistic fit
hold on;
X = v20_xaxis';
Y = [v20_yaxis' ones(length(v20_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;
fit_x=1:150;
Z = logistic(Bvals(1) + fit_x*(Bvals(2)));
plot(fit_x,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(10,0.45,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');

%% V30
v30_bins = [10,30,50,80];
[v30_xaxis,v30_yaxis,yerr] = rebin(v30s,epts,v30_bins);

figure('Name','Heart V30 vs. RP','NumberTitle','off');
errorbar(v30_xaxis,v30_yaxis,yerr.*v30_yaxis,...
'*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('V_{30}[%]');
ylabel('probability of \geq grade 3 pneumonitis');
xlim([0 150]);
ylim([0 0.8]);

%Logistic fit
hold on;
X = v30_xaxis';
Y = [v30_yaxis' ones(length(v30_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;
fit_x=1:150;
Z = logistic(Bvals(1) + fit_x*(Bvals(2)));
plot(fit_x,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(10,0.45,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');

