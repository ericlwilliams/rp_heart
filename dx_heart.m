%% RP vs. heart DX
% Code to plot incidence of RP vs. heart DX (X=25,33,50,66,75 %)

% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    clear all;

    load('heart_data.mat');
end
%% D05 vs DX

screen_size = get(0,'ScreenSize');
figure('Name','D05 vs. DX','NumberTitle','off');

% D05 vs D10
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,1);
scatter(d05s,d10s);
hold on
sig_d05s = d05s.*epts;
sig_d10s = d10s.*epts;
scatter(sig_d05s(sig_d05s~=0),sig_d10s(sig_d10s~=0),'r','MarkerFaceColor','r');
xlabel('D_{05} [Gy]');
ylabel('D_{10} [Gy]');
ylim([0 100]);
xlim([0 100]);
R_d05_d10 = corrcoef(d05s,d10s);
text(10,30,sprintf(cc2,R_d05_d10(1,2)^2),'FontSize',12);


% D05 vs D25
cc2 = 'R^{2} = %6.3g';
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
subplot(2,2,2);
scatter(d05s,d25s);
hold on
sig_d25s = d25s.*epts;
scatter(sig_d05s(sig_d05s~=0),sig_d25s(sig_d25s~=0),'r','MarkerFaceColor','r');
xlabel('D_{05} [Gy]');
ylabel('D_{25} [Gy]');
ylim([0 90]);
xlim([0 100]);
R_d05_d25 = corrcoef(d05s,d25s);
text(10,50,sprintf(cc2,R_d05_d25(1,2)^2),'FontSize',12);


% D05 vs D50
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,3);
scatter(d05s,d50s);
hold on
sig_d50s = d50s.*epts;
scatter(sig_d05s(sig_d05s~=0),sig_d50s(sig_d50s~=0),'r','MarkerFaceColor','r');
xlabel('D_{05} [Gy]');
ylabel('D_{50} [Gy]');
ylim([0 60]);
xlim([0 100]);
R_d05_d50 = corrcoef(d05s,d50s);
text(10,40,sprintf(cc2,R_d05_d50(1,2)^2),'FontSize',12);

%D05 vs D66
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,4);
scatter(d05s,d66s);
hold on
sig_d66s = d66s.*epts;
scatter(sig_d05s(sig_d05s~=0),sig_d66s(sig_d66s~=0),'r','MarkerFaceColor','r');
xlabel('D_{05} [Gy]');
ylabel('D_{66} [Gy]');
ylim([0 50]);
xlim([0 100]);
R_d05_d66 = corrcoef(d05s,d66s);
text(10,40,sprintf(cc2,R_d05_d66(1,2)^2),'FontSize',12);

print('-dpng','Z:\elw\MATLAB\heart\canvases\dx_heart\latest\d05_vs_dx.png');

%% D10


figure('Name','D10 vs. DX','NumberTitle','off');
screen_size = get(0,'ScreenSize');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
% D10 vs D25
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,1);
scatter(d10s,d25s);
hold on
sig_d25s = d25s.*epts;
scatter(sig_d10s(sig_d10s~=0),sig_d25s(sig_d25s~=0),'r','MarkerFaceColor','r');
xlabel('D_{10} [Gy]');
ylabel('D_{25} [Gy]');
ylim([0 100]);
xlim([0 100]);
R_d10_d25 = corrcoef(d10s,d25s);
text(10,30,sprintf(cc2,R_d10_d25(1,2)^2),'FontSize',12);

% d10 vs V50
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,2);
scatter(d10s,d50s);
hold on
sig_d50s = d50s.*epts;
scatter(sig_d10s(sig_d10s~=0),sig_d50s(sig_d50s~=0),'r','MarkerFaceColor','r');
xlabel('D_{10} [Gy]');
ylabel('D_{50} [Gy]');
ylim([0 60]);
xlim([0 100]);
R_d10_d50 = corrcoef(d10s,d50s);
text(10,40,sprintf(cc2,R_d10_d50(1,2)^2),'FontSize',12);

%D10 vs D66
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,3);
scatter(d10s,d66s);
hold on
sig_d66s = d66s.*epts;
scatter(sig_d10s(sig_d10s~=0),sig_d66s(sig_d66s~=0),'r','MarkerFaceColor','r');
xlabel('D_{10} [Gy]');
ylabel('D_{66} [Gy]');
ylim([0 50]);
xlim([0 100]);
R_d10_d66 = corrcoef(d10s,d66s);
text(10,40,sprintf(cc2,R_d10_d66(1,2)^2),'FontSize',12); 

%D10 vs D75
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,4);
scatter(d10s,d75s);
hold on
sig_d75s = d75s.*epts;
scatter(sig_d10s(sig_d10s~=0),sig_d75s(sig_d75s~=0),'r','MarkerFaceColor','r');
xlabel('D_{10} [Gy]');
ylabel('D_{75} [Gy]');
ylim([0 50]);
xlim([0 100]);
R_d10_d75 = corrcoef(d10s,d75s);
text(10,40,sprintf(cc2,R_d10_d75(1,2)^2),'FontSize',12); 

print('-dpng','Z:\elw\MATLAB\heart\canvases\dx_heart\latest\d10_vs_dx.png');

%% D25 vs DX

screen_size = get(0,'ScreenSize');
% D25 vs V33
cc2 = 'R^{2} = %6.3g';
figure('Name','D25 vs. DX','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
subplot(2,2,1);
scatter(d25s,d33s);
hold on
sig_d25s = d25s.*epts;
sig_d33s = d33s.*epts;
scatter(sig_d25s(sig_d25s~=0),sig_d33s(sig_d33s~=0),'r','MarkerFaceColor','r');
xlabel('D_{25} [Gy]');
ylabel('D_{33} [Gy]');
ylim([0 90]);
xlim([0 100]);
R_d25_d33 = corrcoef(d25s,d33s);
text(10,50,sprintf(cc2,R_d25_d33(1,2)^2),'FontSize',12);

% D25 vs V50
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,2);
scatter(d25s,d50s);
hold on
sig_d50s = d50s.*epts;
scatter(sig_d25s(sig_d25s~=0),sig_d50s(sig_d50s~=0),'r','MarkerFaceColor','r');
xlabel('D_{25} [Gy]');
ylabel('D_{50} [Gy]');
ylim([0 60]);
xlim([0 100]);
R_d25_d50 = corrcoef(d25s,d50s);
text(10,40,sprintf(cc2,R_d25_d50(1,2)^2),'FontSize',12);
%D25 vs V66
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,3);
scatter(d25s,d66s);
hold on
sig_d66s = d66s.*epts;
scatter(sig_d25s(sig_d25s~=0),sig_d66s(sig_d66s~=0),'r','MarkerFaceColor','r');
xlabel('D_{25} [Gy]');
ylabel('D_{66} [Gy]');
ylim([0 50]);
xlim([0 100]);
R_d25_d66 = corrcoef(d25s,d66s);
text(10,40,sprintf(cc2,R_d25_d66(1,2)^2),'FontSize',12);
% D25 vs V75
cc2 = 'R^{2} = %6.3g';
%figure;
subplot(2,2,4);
scatter(d25s,d75s);
hold on
sig_d75s = d75s.*epts;
scatter(sig_d25s(sig_d25s~=0),sig_d75s(sig_d75s~=0),'r','MarkerFaceColor','r');
xlabel('D_{25} [Gy]');
ylabel('D_{75} [Gy]');
ylim([0 40]);
xlim([0 100]);
R_d25_d75 = corrcoef(d25s,d75s);
text(10,30,sprintf(cc2,R_d25_d75(1,2)^2),'FontSize',12);

print('-dpng','Z:\elw\MATLAB\heart\canvases\dx_heart\latest\d25_vs_dx.png');
%% D33 vs DX
cc2 = 'R^{2} = %6.3g';
figure('Name','D33 vs. DX','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
subplot(2,2,1);
scatter(d33s,d50s);
hold on
scatter(sig_d33s(sig_d33s~=0),sig_d50s(sig_d50s~=0),'r','MarkerFaceColor','r');
xlabel('D_{33} [Gy]');
ylabel('D_{50} [Gy]');
ylim([0 40]);
xlim([0 50]);
R_d33_d50 = corrcoef(d33s,d50s);
text(10,30,sprintf(cc2,R_d33_d50(1,2)^2),'FontSize',12);%% D33 vs V75
cc2 = 'R^{2} = %6.3g';
%D33 vs. D66
subplot(2,2,2);
scatter(d33s,d66s);
hold on
scatter(sig_d33s(sig_d33s~=0),sig_d66s(sig_d66s~=0),'r','MarkerFaceColor','r');
xlabel('D_{33} [Gy]');
ylabel('D_{66} [Gy]');
ylim([0 40]);
xlim([0 60]);
R_d33_d66 = corrcoef(d33s,d66s);
text(10,30,sprintf(cc2,R_d33_d66(1,2)^2),'FontSize',12);
cc2 = 'R^{2} = %6.3g';
% D33 vs. D75
%figure;
subplot(2,2,3);
scatter(d33s,d75s);
hold on
scatter(sig_d33s(sig_d33s~=0),sig_d75s(sig_d75s~=0),'r','MarkerFaceColor','r');
xlabel('D_{33} [Gy]');
ylabel('D_{75} [Gy]');
ylim([0 40]);
xlim([0 60]);
R_d33_d75 = corrcoef(d33s,d75s);
text(10,30,sprintf(cc2,R_d33_d75(1,2)^2),'FontSize',12);
%% D50 vs DX
% D50 vs D66
cc2 = 'R^{2} = %6.3g';
figure('Name','D50 vs. DX','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
subplot(2,2,1);
scatter(d50s,d66s);
hold on
scatter(sig_d50s(sig_d50s~=0),sig_d66s(sig_d66s~=0),'r','MarkerFaceColor','r');
xlabel('D_{50} [Gy]');
ylabel('D_{66} [Gy]');
ylim([0 40]);
xlim([0 60]);
R_d50_d66 = corrcoef(d50s,d66s);
text(10,30,sprintf(cc2,R_d50_d66(1,2)^2),'FontSize',12);
cc2 = 'R^{2} = %6.3g';
% D50 vs. D75
%figure;
subplot(2,2,2);
scatter(d50s,d75s);
hold on
scatter(sig_d50s(sig_d50s~=0),sig_d75s(sig_d75s~=0),'r','MarkerFaceColor','r');
xlabel('D_{50} [Gy]');
ylabel('D_{75} [Gy]');
ylim([0 40]);
xlim([0 60]);
R_d50_d75 = corrcoef(d50s,d75s);
text(10,30,sprintf(cc2,R_d50_d75(1,2)^2),'FontSize',12);


%% Logistic Regressions
%% D05
%d05_xaxis = [10:10:max(d05s(:,1))+10];
d05_bins = [25,50, 70,90];
[d05_xaxis,d05_yaxis,yerr] = rebin(d05s,epts,d05_bins);

figure('Name','Heart D05 vs. RP','NumberTitle','off');
errorbar(d05_xaxis,d05_yaxis,yerr.*d05_yaxis,...
    '*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('D_{05}[Gy]');
ylabel('probability of \geq grade 3 pneumonitis');
%Logistic fit
hold on;

X = d05_xaxis';
Y = [d05_yaxis' ones(length(d05_yaxis), 1)];
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



%% D10
%d10_xaxis = [10:10:max(d10s(:,1))+10];
d10_bins = [25,50, 70,90];
[d10_xaxis,d10_yaxis,yerr] = rebin(d10s,epts,d10_bins);

figure('Name','Heart D10 vs. RP','NumberTitle','off');
errorbar(d10_xaxis,d10_yaxis,yerr.*d10_yaxis,...
    '*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('D_{10}[Gy]');
ylabel('probability of \geq grade 3 pneumonitis');
%Logistic fit
hold on;
X = d10_xaxis';
Y = [d10_yaxis' ones(length(d10_yaxis), 1)];
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
%% D25
%d25_xaxis = [20:20:max(d25s(:,1))+20];
d25_bins = [10,30,50,90];
[d25_xaxis,d25_yaxis,yerr] = rebin(d25s,epts,d25_bins);

figure('Name','Heart D25 vs. RP','NumberTitle','off');
errorbar(d25_xaxis,d25_yaxis,yerr.*d25_yaxis,...
    '*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('D_{25}[Gy]');
ylabel('probability of \geq grade 3 pneumonitis');

%Logistic fit
hold on;
X = d25_xaxis';
Y = [d25_yaxis' ones(length(d25_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;
Z = logistic(Bvals(1) + fit_x*(Bvals(2)));
plot(fit_x,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(10,0.45,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');

%% D33

d33_bins = [10,20,40,90];
[d33_xaxis,d33_yaxis,yerr] = rebin(d33s,epts,d33_bins);

figure('Name','Heart D33 vs. RP','NumberTitle','off');
errorbar(d33_xaxis,d33_yaxis,yerr.*d33_yaxis,...
    '*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('D_{33}[Gy]');
ylabel('probability of \geq grade 3 pneumonitis');
%Logistic fit
hold on;

X = d33_xaxis';
Y = [d33_yaxis' ones(length(d33_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;
Z = logistic(Bvals(1) + fit_x*(Bvals(2)));
plot(fit_x,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(10,0.45,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');
%% D50
d50_bins=10:10:50;
[d50_xaxis,d50_yaxis,yerr] = rebin(d50s,epts,d50_bins);

figure('Name','Heart D50 vs. RP','NumberTitle','off');
errorbar(d50_xaxis,d50_yaxis,yerr.*d50_yaxis,...
    '*','LineWidth',2,'MarkerSize',10);
grid on;
xlim([0 100]);
ylim([0 0.8]);
xlabel('D_{50}[Gy]');
ylabel('probability of \geq grade 3 pneumonitis');
%Logistic fit
hold on;

X = d50_xaxis';
Y = [d50_yaxis' ones(length(d50_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;

% bad fit, don't plot
%Z = logistic(Bvals(1) + d50_xaxis*(Bvals(2)));
%plot(d50_xaxis,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(5,0.6,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');

%% D66

d66_bins = [10,20,45];
[d66_xaxis,d66_yaxis,yerr] = rebin(d66s,epts,d66_bins);

figure('Name','Heart D66 vs. RP','NumberTitle','off');
errorbar(d66_xaxis,d66_yaxis,yerr.*d66_yaxis,...
    '*','LineWidth',2,'MarkerSize',10);
grid on;
xlabel('D_{66}[Gy]');
ylabel('probability of \geq grade 3 pneumonitis');
xlim([0 50]);
ylim([0 0.7]);
%Logistic fit
hold on;

X = d66_xaxis';
Y = [d66_yaxis' ones(length(d66_yaxis), 1)];
[Bvals,dev,stats] = glmfit(X,Y,'binomial','link','logit');
Pvals =stats.p;
%Z = logistic(Bvals(1) + fit_x*(Bvals(2)));
%plot(fit_x,Z,'--g');
% print b values and p values
stat_text = 'B = [%6.3g, %6.3g]\n\np = [%6.3g, %6.3g]';
text(5,0.6,...
    sprintf(stat_text,[Bvals(1) Bvals(2) Pvals(1) Pvals(2)]),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','k');
