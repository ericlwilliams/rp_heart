close all;
clc;
clear all;

load('heart_data.mat');
corr_coef2 = 'R^{2} = %6.3g';

vx_heart

dx_heart 
sig_mds = mds.*epts;

screen_size = get(0,'ScreenSize');

%% MD vs VX
figure('Name','Heart Mean Dose vs VX','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
subplot(2,2,1);
scatter(mds,v13s);
hold on
sig_v13s = v13s.*epts;
scatter(sig_mds(sig_mds~=0),sig_v13s(sig_v13s~=0),'r','MarkerFaceColor','r');
xlabel('Mean Dose [cGy]');
ylabel('V_{13} [%]');
ylim([0 100]);
R_md_v13 = corrcoef(mds,v13s);

text(500,80,sprintf(corr_coef2,R_md_v13(1,2)^2),'FontSize',12);
% MD vs V20
subplot(2,2,2);
scatter(mds,v20s);
hold on
sig_v20s = v20s.*epts;
scatter(sig_mds(sig_mds~=0),sig_v20s(sig_v20s~=0),'r','MarkerFaceColor','r');
xlabel('Mean Dose [cGy]');
ylabel('V_{20} [%]');
ylim([0 100]);
R_md_v20 = corrcoef(mds,v20s);
text(500,80,sprintf(corr_coef2,R_md_v20(1,2)^2),'FontSize',12);

% MD vs V30
subplot(2,2,3);
scatter(mds,v30s);
hold on
sig_v30s = v30s.*epts;
scatter(sig_mds(sig_mds~=0),sig_v30s(sig_v30s~=0),'r','MarkerFaceColor','r');
xlabel('Mean Dose [cGy]');
ylabel('V_{30} [%]');
ylim([0 100]);
R_md_v30 = corrcoef(mds,v30s);
text(500,80,sprintf(corr_coef2,R_md_v30(1,2)^2),'FontSize',12);

%% MD vs DX
figure('Name','Heart Mean Dose vs DX','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
subplot(2,2,1);
scatter(mds./100.,d25s);
hold on
sig_d25s = d25s.*epts;
scatter(sig_mds(sig_mds~=0)./100,sig_d25s(sig_d25s~=0),'r','MarkerFaceColor','r');
xlabel('Mean Dose [Gy]');
ylabel('D_{25} [Gy]');
ylim([0 100]);
xlim([0 60]);
R_md_d25 = corrcoef(mds,d25s);
text(10,80,sprintf(corr_coef2,R_md_d25(1,2)^2),'FontSize',12);

% MD vs D50
subplot(2,2,2);
scatter(mds./100.,d50s);
hold on
sig_d50s = d50s.*epts;
scatter(sig_mds(sig_mds~=0)./100,sig_d50s(sig_d50s~=0),'r','MarkerFaceColor','r');
xlabel('Mean Dose [Gy]');
ylabel('D_{50} [Gy]');
ylim([0 60]);
xlim([0 60]);
R_md_d50 = corrcoef(mds,d50s);
text(10,45,sprintf(corr_coef2,R_md_d50(1,2)^2),'FontSize',12);

% MD vs D75
subplot(2,2,3);
scatter(mds./100.,d75s);
hold on
sig_d75s = d75s.*epts;
scatter(sig_mds(sig_mds~=0)./100,sig_d75s(sig_d75s~=0),'r','MarkerFaceColor','r');
xlabel('Mean Dose [Gy]');
ylabel('D_{75} [Gy]');
ylim([0 40]);
xlim([0 60]);
R_md_d75 = corrcoef(mds,d75s);
text(10,30,sprintf(corr_coef2,R_md_d75(1,2)^2),'FontSize',12);

% MD vs D05
subplot(2,2,4);
scatter(mds./100.,d05s);
hold on
sig_d05s = d05s.*epts;
scatter(sig_mds(sig_mds~=0)./100,sig_d05s(sig_d05s~=0),'r','MarkerFaceColor','r');
xlabel('Mean Dose [Gy]');
ylabel('D_{05} [Gy]');
ylim([0 100]);
xlim([0 60]);
R_md_d05 = corrcoef(mds,d05s);
text(45,30,sprintf(corr_coef2,R_md_d05(1,2)^2),'FontSize',12);


%% Heart Mean Dose vs RP
md_heart


