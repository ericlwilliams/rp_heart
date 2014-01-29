%% Dx and Vx correlations

tic;
% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end

%% Mean dose correlations with Dx
nDxStep = length(dXs(1,:));
R_md_dXs = zeros(nDxStep,1);% num Dx steps (100)
Pvals_mds_dXs = zeros(nDxStep,1);% num Dx steps (100)

for i=1:nDxStep,
    [cur_corrcoef cur_pvals]= corrcoef(mds,dXs(:,i));
    R_md_dXs(i)= cur_corrcoef(1,2)^2;
    Pvals_mds_dXs(i)= cur_pvals(1,2);
end
toc;

x_axis = 1:nDxStep;

figure('Name','Correlation btwn MD and Dx vs. Dx','NumberTitle','off');
[R_max,R_max_idx] = max(R_md_dXs);

plot(x_axis,R_md_dXs,'*');
hold on;
plot(x_axis(R_max_idx),R_max,'*r');
hold off;
ylabel(['R(MD,D_{V})^2']);
xlabel(['D_{V} [Gy]']);
line([x_axis(R_max_idx) x_axis(R_max_idx)],ylim,'Color','r','LineStyle',':');
best_corr_text = 'Max R^{2}=%6.3f at D_{%i}';
text(60,0.9,sprintf(best_corr_text,R_max,x_axis(R_max_idx)),'Color','r');

%figure('Name','Correlation btwn MD and Dx vs. Dx (zoom)','NumberTitle','off');
%plot(1:40,R_md_dXs(1:40,:),'*');
%hold on;
%plot(x_axis(R_max_idx),R_max,'*r');
%ylabel(['R(MD,D_{V})^2']);
%xlabel(['D_{V}']);
%hold off;

%% Mean lung dose correlations with Dx
nDxStep = length(dXs(1,:));
R_mld_dXs = zeros(nDxStep,1);% num Dx steps (100)
Pvals_mlds_dXs = zeros(nDxStep,1);% num Dx steps (100)

for i=1:nDxStep,
    [cur_corrcoef cur_pvals]= corrcoef(mlds,dXs(:,i));
    R_mld_dXs(i)= cur_corrcoef(1,2)^2;
    Pvals_mlds_dXs(i)= cur_pvals(1,2);
end
toc;

x_axis = 1:nDxStep;

figure('Name','Correlation btwn MLD and Dx vs. Dx','NumberTitle','off');
[R_max,R_max_idx] = max(R_mld_dXs);

plot(x_axis,R_mld_dXs,'*');
hold on;
plot(x_axis(R_max_idx),R_max,'*r');
hold off;
ylabel(['R(MLD,D_{V})^2']);
xlabel(['D_{V} [Gy]']);
line([x_axis(R_max_idx) x_axis(R_max_idx)],ylim,'Color','r','LineStyle',':');
best_corr_text = 'Max R^{2}=%6.3f at D_{%i}';
text(60,0.25,sprintf(best_corr_text,R_max,x_axis(R_max_idx)),'Color','r');

%% Mean dose correlations with Vx
nVxStep = length(vXs(1,:));
R_md_vXs = zeros(nVxStep,1);% num Vx steps (100)
Pvals_mds_vXs = zeros(nVxStep,1);% num Vx steps (100)

for i=1:nVxStep,
    [cur_corrcoef cur_pvals]= corrcoef(mds,vXs(:,i));
    R_md_vXs(i)= cur_corrcoef(1,2)^2;
    Pvals_mds_vXs(i)= cur_pvals(1,2);
end
toc;

x_axis = 1:nVxStep;

figure('Name','Correlation btwn MD and Vx vs. Vx','NumberTitle','off');
[R_md_vXs_max,R_md_vXs_max_idx] = max(R_md_vXs);

plot(x_axis,R_md_vXs,'*');
hold on;
plot(x_axis(R_md_vXs_max_idx),R_md_vXs_max,'*r');

ylabel(['R(MD,V_{D})^2']);
xlabel(['V_{D} [%]']);
line([x_axis(R_md_vXs_max_idx) x_axis(R_md_vXs_max_idx)],ylim,'Color','r','LineStyle',':');
best_corr_text = 'Max R^{2}=%6.3f at V_{%i}';
text(45,0.4,sprintf(best_corr_text,R_md_vXs_max,x_axis(R_md_vXs_max_idx)),'Color','r');
hold off;
%figure('Name','Correlation btwn MD and Vx vs. Vx (zoom)','NumberTitle','off');
%plot(1:40,R_md_vXs(1:40,:),'*');
%hold on;
%plot(x_axis(R_md_vXs_max_idx),R_md_vXs_max,'*r');
%ylabel(['R(MD,V_{X})^2']);
%xlabel(['V_{X}']);
%hold off;
%% Mean lung dose correlations with Vx
nVxStep = length(vXs(1,:));
R_mld_vXs = zeros(nVxStep,1);% num Vx steps (100)
Pvals_mlds_vXs = zeros(nVxStep,1);% num Vx steps (100)

for i=1:nVxStep,
    %[cur_corrcoef cur_pvals]= corrcoef(mlds,vXs(:,i));
    %R_mld_vXs(i)= cur_corrcoef(1,2)^2;
    %Pvals_mlds_vXs(i)= cur_pvals(1,2);
    [cur_corrcoef cur_pvals]= corr(mlds,vXs(:,i),'Type','Pearson');
    R_mld_vXs(i)= cur_corrcoef^2;
    Pvals_mlds_vXs(i)= cur_pvals;
end
toc;

x_axis = 1:nVxStep;

figure('Name','Correlation btwn MLD and Vx vs. Vx','NumberTitle','off');
[R_mld_vXs_max,R_mld_vXs_max_idx] = max(R_mld_vXs);
hold on;
grid on;
plot(x_axis,R_mld_vXs,'*');
plot(x_axis(R_mld_vXs_max_idx),R_mld_vXs_max,'*r');
ylim([0 0.5]);
ylabel(['R(MLD,V_{D})^2']);
xlabel(['V_{D} [%]']);
line([x_axis(R_mld_vXs_max_idx) x_axis(R_mld_vXs_max_idx)],ylim,'Color','r','LineStyle',':');
hold off;


best_corr_text = 'Max R^{2}=%6.3f at V_{%i}';
text(10,0.425,sprintf(best_corr_text,R_mld_vXs_max,x_axis(R_mld_vXs_max_idx)),'Color','r','BackgroundColor',[1 1 1]);


%% D19 with Vx

R_d19_vXs = zeros(nVxStep,1);% num Vx steps (100)
Pvals_d19_vXs = zeros(nVxStep,1);% num Vx steps (100)

for i=1:nVxStep,
    [cur_corrcoef cur_pvals]= corrcoef(dXs(:,19),vXs(:,i));
    R_d19_vXs(i)= cur_corrcoef(1,2)^2;
    Pvals_d19_vXs(i)= cur_pvals(1,2);
end
toc;

x_axis = 1:nVxStep;

figure('Name','Correlation btwn D_{19} and Vx vs. Vx','NumberTitle','off');
[R_d19_vXs_max,R_d19_vXs_max_idx] = max(R_d19_vXs);

plot(x_axis,R_d19_vXs,'*');
hold on;
plot(x_axis(R_d19_vXs_max_idx),R_d19_vXs_max,'*r');
hold off;
ylabel(['R(D_{19},V_{D})^2']);
xlabel(['V_{D}']);


%% V02 vs. Dx

R_v02_vXs = zeros(nDxStep,1);% num Vx steps (100)
Pvals_v02_vXs = zeros(nDxStep,1);% num Vx steps (100)

for i=1:nDxStep,
    [cur_corrcoef cur_pvals]= corrcoef(vXs(:,2),dXs(:,i));
    R_v02_vXs(i)= cur_corrcoef(1,2)^2;
    Pvals_v02_vXs(i)= cur_pvals(1,2);
end
toc;

x_axis = 1:nDxStep;

figure('Name','Correlation btwn V_{02} and Dx vs. Dx','NumberTitle','off');
[R_v02_vXs_max,R_v02_vXs_max_idx] = max(R_v02_vXs);

plot(x_axis,R_v02_vXs,'*');
hold on;
plot(x_axis(R_v02_vXs_max_idx),R_v02_vXs_max,'*r');
hold off;
ylabel(['R(V_{02},D_{V})^2']);
xlabel(['D_{V}']);


figure('Name','Correlation btwn V_{02} and Dx vs. Dx (zoom)','NumberTitle','off');
plot(1:40,R_v02_vXs(1:40,:),'*');
hold on;
plot(x_axis(R_v02_vXs_max_idx),R_v02_vXs_max,'*r');
ylabel(['R(V{02},D_{V})^2']);
xlabel(['D_{V}']);
hold off;

%% V05 vs. Dx

R_v05_vXs = zeros(nDxStep,1);% num Vx steps (100)
Pvals_v05_vXs = zeros(nDxStep,1);% num Vx steps (100)

for i=1:nDxStep,
    [cur_corrcoef cur_pvals]= corrcoef(vXs(:,5),dXs(:,i));
    R_v05_vXs(i)= cur_corrcoef(1,2)^2;
    Pvals_v05_vXs(i)= cur_pvals(1,2);
end
toc;

x_axis = 1:nDxStep;

figure('Name','Correlation btwn V_{05} and Dx vs. Dx','NumberTitle','off');
[R_v05_vXs_max,R_v05_vXs_max_idx] = max(R_v05_vXs);

plot(x_axis,R_v05_vXs,'*');
hold on;
plot(x_axis(R_v05_vXs_max_idx),R_v05_vXs_max,'*r');
hold off;
ylabel(['R(V_{05},D_{V})^2']);
xlabel(['D_{V}']);


figure('Name','Correlation btwn V_{05} and Dx vs. Dx (zoom)','NumberTitle','off');
plot(30:60,R_v05_vXs(30:60,:),'*');
hold on;
plot(x_axis(R_v05_vXs_max_idx),R_v05_vXs_max,'*r');
ylabel(['R(V{05},D_{V})^2']);
xlabel(['D_{V}']);
hold off;


%% Correlation between Vx and Dx

R_dXs_vXs = zeros(nDxStep,nVxStep);
for i=1:nDxStep,
    for j=1:nVxStep,    
        [cur_corrcoef cur_pvals]= corrcoef(dXs(:,i),vXs(:,j));
        R_dXs_vXs(i,j) = cur_corrcoef(1,2)^2;
        
    %Pvals_v05_vXs(i)= cur_pvals(1,2);
    end
end

figure('Name','Correlation btwn D_{V} and V_{D}','NumberTitle','off');
contourf(R_dXs_vXs');
colorbar;
xlabel(['D_{V} [Gy]']);
ylabel(['V_{D} [% Vol]']);
title(['R^2']);

%% MD vs D05
% 
% screen_size = get(0,'ScreenSize');
% figure('Name','MD vs. D05','NumberTitle','off');
% 
% % MD vs D05
% cc2 = 'R^{2} = %6.3g';
% %figure;
% subplot(2,2,1);
% scatter(mds./100,dXs(:,5));
% hold on
% sig_d05s = dXs(:,5).*epts;
% sig_mds = mds.*epts;
% scatter(sig_mds(sig_mds~=0)./100,sig_d05s(sig_d05s~=0),'r','MarkerFaceColor','r');
% xlabel('Mean Dose [Gy]');
% ylabel('D_{05} [Gy]');
% ylim([0 100]);
% %xlim([0 100]);
% R_md_d05 = corrcoef(mds./100.,dXs(:,15));
% text(20,30,sprintf(cc2,R_md_d05(1,2)^2),'FontSize',12);