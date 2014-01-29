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
doAreaCalc = true;
%% Avg dose with complications vs dX
comp_cDVHs = cDVHs(:,:,epts==1);
nComps = size(comp_cDVHs,3);

% normalize volume
for i=1:nComps;
  comp_cDVHs(:,2,i) = 100*comp_cDVHs(:,2,i)./max(comp_cDVHs(:,2,i));
end

cens_cDVHs = cDVHs(:,:,~epts);
nCens = size(cens_cDVHs,3);
for i=1:nCens;
    cens_cDVHs(:,2,i) = 100*cens_cDVHs(:,2,i)./max(cens_cDVHs(:,2,i));
end
% averages over all patients
mean_comp_cDVHs = mean(comp_cDVHs,3);
mean_cens_cDVHs = mean(cens_cDVHs,3);

std_comp_cDVHs = std(comp_cDVHs,0,3);
std_cens_cDVHs = std(cens_cDVHs,0,3);

mean_comp_doses = mean_comp_cDVHs(1:2:end,1);
mean_comp_vols = mean_comp_cDVHs(1:2:end,2);
std_comp_vols = std_comp_cDVHs(1:2:end,2);

mean_cens_doses = mean_cens_cDVHs(1:2:end,1);
mean_cens_vols = mean_cens_cDVHs(1:2:end,2);
std_cens_vols = std_cens_cDVHs(1:2:end,2);

figure('Visible',printAll,'Name',['cDVHs'],'NumberTitle','off');

hold on;
h_comp = plot(mean_comp_doses,mean_comp_vols,'r-');
plot(mean_comp_doses,...
    mean_comp_vols+(std_comp_vols./2),'r:');
plot(mean_comp_doses,...
    mean_comp_vols-(std_comp_vols./2),'r:');

h_cens = plot(mean_cens_doses,mean_cens_vols,'b');
plot(mean_cens_doses,...
    mean_cens_vols+(std_cens_vols./2),'b:');
plot(mean_cens_doses,...
    mean_cens_vols-(std_cens_vols./2),'b:');

ylabel('heart volume [%]');
xlabel('Dose [cGy]');
    
ylim([0 100]);

h = findobj(gca,'Type','patch');
legend([h_comp h_cens],...
    'Mean w/ complication','Mean w/o complication','Location','Best');

hold off;

print('-dpng','Z:\elw\MATLAB\heart\canvases\plotDXLogisticRegressions\latest\dx_constraints.png');


%% Do area calculation with permutations

% Create matrix of permutations: patient_perms
% matrix columns are length 10 listing randomly choosen patient numbers 
% between 1-70
% N (~10000) matrix columns total (one for each permutation)

if doAreaCalc,
    nPerms = 1000;
    nSimComps = 10;

% old
%patient_perms = randi(70,nSimComps,nPerms); % not unique
patient_perms = zeros(nSimComps,nPerms);

for i=1:nPerms,
    cur_perm = randperm(70);
    cur_perm = cur_perm(1:nSimComps);
    patient_perms(:,i) = cur_perm; % unique
end

sim_area_diffs = zeros(nPerms,1);
% calculate area difference between avgd comp cDVHs and avgd cens

for i=1:nPerms,
   if numel(unique(patient_perms(:,i)))~=nSimComps,% perms not unique. should not happen
       while numel(unique(patient_perms(:,i)))~=nSimComps,
        cur_randi = randi(70,nSimComps,1);
        patient_perms(:,i) = cur_randi;
       end
   end
    dvh_area_diff = CalcAreaDiff(cDVHs,patient_perms(:,i));
    sim_area_diffs(i) = dvh_area_diff;  
end


%% plot simulated area differences
figure('Visible',printAll,'Name',['Area differences'],'NumberTitle','off');

max_area_diff = max(sim_area_diffs);
area_diff_x = 0:10:(max_area_diff+10);
[n,x]=hist(sim_area_diffs,area_diff_x);
stairs(x,n);
xlabel('DVH area difference [% volume * cGy]');
ylabel('Number of occurances');

% calculate area for actual complications

comp_inds = find(epts==1);
real_dvh_area_diff = CalcAreaDiff(cDVHs,comp_inds);
%line(real_dvh_area_diff,[0 10],'Color','r');
line([real_dvh_area_diff real_dvh_area_diff],ylim,'Color','r');

num_sim_area_diff_greater = sum(sim_area_diffs>real_dvh_area_diff);

n_sim_text = '%i simulations';
n_greater_text = '%i simulations with greater areas';
obs_area_text = 'Observed area: %6.2f';
p_val_text = 'p-value: %6.4f';
y_text_loc = ylim;
y_text_loc = y_text_loc(2);

text(850,0.8*y_text_loc,sprintf(n_sim_text,nPerms),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','w');
text(850,0.74*y_text_loc,sprintf(obs_area_text,real_dvh_area_diff),...
    'FontSize',10,'BackgroundColor','w','Color','r','EdgeColor','w');
text(850,0.69*y_text_loc,sprintf(n_greater_text,num_sim_area_diff_greater),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','w');
text(850,0.63*y_text_loc,sprintf(p_val_text,num_sim_area_diff_greater/nPerms),...
    'FontSize',10,'BackgroundColor','w','EdgeColor','w');   


disp(['Observed area difference: ',num2str(real_dvh_area_diff)]);
disp([num2str(num_sim_area_diff_greater),' simulations with greater areas']);
disp(['p-value: ',num2str(num_sim_area_diff_greater/nPerms)]);
end;

toc;
