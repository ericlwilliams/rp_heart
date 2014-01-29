if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end
%% L/R overlap fractiosn
figure('Name','Left/Right Heart/PTV overlap fractions','NumberTitle','off');
ols_right = ols(isleft==0);
ols_left = ols(isleft==1);

ols_x = 0:0.5:12;

hold on;
hist(ols_right,ols_x);
hist(ols_left,ols_x);
h= findobj(gca,'Type','patch');

set(h(1),'FaceColor','b','EdgeColor','k','facealpha',0.5);%% left - blue
set(h(2),'FaceColor','r','EdgeColor','k','facealpha',0.5);%% right - red

disp(['max left: ' num2str(max(ols_left))]);
disp(['max right: ' num2str(max(ols_right))]);

left_ol_text = 'Avg. Overlap [%%]: %6.2f \\pm %2.1f';
text(4,9.7,sprintf(left_ol_text,mean(ols_left),std(ols_left)),'FontSize',12,'Color','b');
right_ol_text = 'Avg. Overlap [%%]: %6.2f \\pm %2.1f';
text(4,9,sprintf(right_ol_text,mean(ols_right),std(ols_right)),'FontSize',12,'Color','r');

legend(h,'PTV Left','PTV Right','Location','best');
xlim([-0.5 12]);
xlabel('Target/Heart volume overlap (%)');


%% L/R mean dose
figure('Name','Left/Right Heart mean doses','NumberTitle','off');
mds_right = mds(isleft==0);
mds_left = mds(isleft==1);
mds_x = 1:2:max(mds);

hold on;
hist(mds_right,mds_x);
hist(mds_left,mds_x);
h_mds = findobj(gca,'Type','patch');

set(h_mds(1),'FaceColor','b','EdgeColor','k','facealpha',0.5);%% left - blue
set(h_mds(2),'FaceColor','r','EdgeColor','k','facealpha',0.5);%% right - red

left_md_text = 'Heart mean [Gy]: %6.2f \\pm %2.1f';
text(17,3.75,sprintf(left_md_text,mean(mds_left),std(mds_left)),'FontSize',12,'Color','b');
right_md_text = 'Heart mean [Gy]: %6.2f \\pm %2.1f';
text(17,3.5,sprintf(right_md_text,mean(mds_right),std(mds_right)),'FontSize',12,'Color','r');

ylim([0 4.1]);
legend(h_mds,'PTV Left','PTV Right','Location','best');
xlabel('Mean dose to heart [Gy]');
