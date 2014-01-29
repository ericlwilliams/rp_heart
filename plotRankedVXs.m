% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end
screen_size = get(0,'ScreenSize');
%% Rank vs. vX 
figure('Name','Rank vs vX distributions (V_{2},V_{5},V_{10},V_{13})','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;

for i=[2 5 10 13],
    cur_vXs = vXs(:,i);
    


    ranks = 1:length(cur_vXs);

    
    
    [ranked_vXs ranked_inds] = sort(cur_vXs);
    [ranked_sig_vXs ranked_sig_inds] = sort(cur_vXs.*epts);
    
    ranked_sig_inds = ranked_sig_inds(ranked_sig_vXs~=0);
    
    ranked_sig_vXs = ranked_sig_vXs(ranked_sig_vXs~=0);
    
%    sig_ranks = zeros(1, length(ranked_sig_vXs));

    for j=1:length(ranked_sig_inds),
        cur_ind = find(ranked_inds==ranked_sig_inds(j));
        sig_ranks(j) = ranks(cur_ind);
    end

    subplot(2,2,cur_histo);
    plot(ranks,ranked_vXs,'*');
    hold on;
    plot(sig_ranks,ranked_sig_vXs,'*r');

    ylabel(sprintf('V_{%i}',i),'BackgroundColor',[.9 .9 .9]);
    
    line(ranks,median(ranked_vXs),'Color','r');
    
    line(ranks,median(ranked_vXs),'Color','r');
   
    hold off;
   
    xlim([0 max(ranks)]);
    cur_histo=cur_histo+1;
end

figure('Name','Rank vs vX distributions (V_{15}-V_{30})','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;
for i=[15 20 25 30],
    cur_vXs = vXs(:,i);
    


    ranks = 1:length(cur_vXs);

    
    
    [ranked_vXs ranked_inds] = sort(cur_vXs);
    [ranked_sig_vXs ranked_sig_inds] = sort(cur_vXs.*epts);
    
    ranked_sig_inds = ranked_sig_inds(ranked_sig_vXs~=0);
    
    ranked_sig_vXs = ranked_sig_vXs(ranked_sig_vXs~=0);
    
%    sig_ranks = zeros(1, length(ranked_sig_vXs));

    for j=1:length(ranked_sig_inds),
        cur_ind = find(ranked_inds==ranked_sig_inds(j));
        sig_ranks(j) = ranks(cur_ind);
    end

    subplot(2,2,cur_histo);
    plot(ranks,ranked_vXs,'*');
    hold on;
    plot(sig_ranks,ranked_sig_vXs,'*r');

    ylabel(sprintf('V_{%i}',i),'BackgroundColor',[.9 .9 .9]);
    
    line(ranks,median(ranked_vXs),'Color','r');
    
    hold off;
   
    xlim([0 max(ranks)]);
    cur_histo=cur_histo+1;
end

figure('Name','Rank vs vX distributions (V_{35}-V_{50})','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;
for i=[35 40 45 50],
    cur_vXs = vXs(:,i);
    


    ranks = 1:length(cur_vXs);

    
    
    [ranked_vXs ranked_inds] = sort(cur_vXs);
    [ranked_sig_vXs ranked_sig_inds] = sort(cur_vXs.*epts);
    
    ranked_sig_inds = ranked_sig_inds(ranked_sig_vXs~=0);
    
    ranked_sig_vXs = ranked_sig_vXs(ranked_sig_vXs~=0);
    
%    sig_ranks = zeros(1, length(ranked_sig_vXs));

    for j=1:length(ranked_sig_inds),
        cur_ind = find(ranked_inds==ranked_sig_inds(j));
        sig_ranks(j) = ranks(cur_ind);
    end

    subplot(2,2,cur_histo);
    plot(ranks,ranked_vXs,'*');
    hold on;
    plot(sig_ranks,ranked_sig_vXs,'*r');

    ylabel(sprintf('V_{%i}',i),'BackgroundColor',[.9 .9 .9]);
    
    line(ranks,median(ranked_vXs),'Color','r');
    
    hold off;
   
    xlim([0 max(ranks)]);
    cur_histo=cur_histo+1;
end
