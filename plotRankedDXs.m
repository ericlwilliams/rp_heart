% load heart_data if not already loaded
if exist('patient_key')==0,
    % not running within another script
    close all;
    clc;
    %clear all;

    load('heart_data.mat');
end
screen_size = get(0,'ScreenSize');
%% Rank vs. DX (D1-D15)
figure('Name','Rank vs DX distributions (D1-D15)','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;

for i=1:5:length(dXs(1,:))/5,
    if i==1,
        ind =1;
        cur_dXs = dXs(:,i);
    else
        cur_dXs = dXs(:,i-1);
    end


    ranks = 1:length(cur_dXs);

    [ranked_dXs ranked_inds] = sort(cur_dXs);
    [ranked_sig_dXs ranked_sig_inds] = sort(cur_dXs.*epts);
    ranked_sig_dXs = ranked_sig_dXs(ranked_sig_dXs~=0);

    sig_ranks = zeros(1, length(ranked_sig_dXs));
    %sig_ranks = zeros(1, length(ranks));

    for j=1:length(ranked_sig_dXs),
        cur_ind = find(ranked_dXs==ranked_sig_dXs(j));
        sig_ranks(j) = ranks(cur_ind);
    end

    subplot(2,2,cur_histo);
    plot(ranks,ranked_dXs,'*');
    hold on;
    plot(sig_ranks,ranked_sig_dXs,'*r');
    
    
    if i==1,
        ylabel(sprintf('D_{%i} [Gy]',i),'BackgroundColor',[.9 .9 .9]);
        xlabel(sprintf('Patient (Ranked by D_{%i})',i),'BackgroundColor',[0.9 0.9 0.9]);
    else
        ylabel(sprintf('D_{%i} [Gy]',i-1),'BackgroundColor',[.9 .9 .9]);
        xlabel(sprintf('Patient (Ranked by D_{%i})',i-1),'BackgroundColor',[0.9 0.9 0.9]);
    end
    
    line(ranks,median(ranked_dXs),'Color','r');
    
    hold off;
   
    xlim([0 max(ranks)]);
    cur_histo=cur_histo+1;
end
%% Rank vs. DX (D20-D35)
figure('Name','Rank vs DX distributions (D20-D35)','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;

for i=20:5:35,
    cur_dXs = dXs(:,i-1);
    ranks = 1:length(cur_dXs);

    [ranked_dXs ranked_inds] = sort(cur_dXs);
    [ranked_sig_dXs ranked_sig_inds] = sort(cur_dXs.*epts);
    ranked_sig_dXs = ranked_sig_dXs(ranked_sig_dXs~=0);

    sig_ranks = zeros(1, length(ranked_sig_dXs));
    %sig_ranks = zeros(1, length(ranks));

    for j=1:length(ranked_sig_dXs),
        cur_ind = find(ranked_dXs==ranked_sig_dXs(j));
        sig_ranks(j) = ranks(cur_ind);
    end

    subplot(2,2,cur_histo);
    plot(ranks,ranked_dXs,'*');
    hold on;
    plot(sig_ranks,ranked_sig_dXs,'*r');
    
    ylabel(sprintf('D_{%i} [Gy]',i),'BackgroundColor',[.9 .9 .9]);
    xlabel(sprintf('Patient (Ranked by D_{%i})',i),'BackgroundColor',[0.9 0.9 0.9]);
    
    line(ranks,median(ranked_dXs),'Color','r');
    
    hold off;
    xlim([0 max(ranks)]);
    cur_histo=cur_histo+1;
end
%% Rank vs. DX (D40-D55)
figure('Name','Rank vs DX distributions (D40-D55)','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;

for i=40:5:55,
    cur_dXs = dXs(:,i-1);
    ranks = 1:length(cur_dXs);

    [ranked_dXs ranked_inds] = sort(cur_dXs);
    [ranked_sig_dXs ranked_sig_inds] = sort(cur_dXs.*epts);
    ranked_sig_dXs = ranked_sig_dXs(ranked_sig_dXs~=0);

    sig_ranks = zeros(1, length(ranked_sig_dXs));
    %sig_ranks = zeros(1, length(ranks));

    for j=1:length(ranked_sig_dXs),
        cur_ind = find(ranked_dXs==ranked_sig_dXs(j));
        sig_ranks(j) = ranks(cur_ind);
    end

    subplot(2,2,cur_histo);
    plot(ranks,ranked_dXs,'*');
    hold on;
    plot(sig_ranks,ranked_sig_dXs,'*r');
 
    ylabel(sprintf('D_{%i} [Gy]',i),'BackgroundColor',[.9 .9 .9]);
    xlabel(sprintf('Patient (Ranked by D_{%i})',i),'BackgroundColor',[0.9 0.9 0.9]);
    
    line(ranks,median(ranked_dXs),'Color','r');

    hold off;
    xlim([0 max(ranks)]);
    cur_histo=cur_histo+1;
end

%% Rank vs. DX (D60-D75)
figure('Name','Rank vs DX distributions (D60-D75)','NumberTitle','off');
set(gcf,'Position',[0 0 screen_size(3) screen_size(4)]);
cur_histo=1;

for i=60:5:75,
    
    cur_dXs = dXs(:,i-1);
    ranks = 1:length(cur_dXs);

    [ranked_dXs ranked_inds] = sort(cur_dXs);
    [ranked_sig_dXs ranked_sig_inds] = sort(cur_dXs.*epts);
    ranked_sig_dXs = ranked_sig_dXs(ranked_sig_dXs~=0);

    sig_ranks = zeros(1, length(ranked_sig_dXs));
    %sig_ranks = zeros(1, length(ranks));

    for j=1:length(ranked_sig_dXs),
        cur_ind = find(ranked_dXs==ranked_sig_dXs(j));
        sig_ranks(j) = ranks(cur_ind);
    end

    subplot(2,2,cur_histo);
    plot(ranks,ranked_dXs,'*');
    hold on;
    plot(sig_ranks,ranked_sig_dXs,'*r');
    
    ylabel(sprintf('D_{%i} [Gy]',i),'BackgroundColor',[.9 .9 .9]);
    xlabel(sprintf('Patient (Ranked by D_{%i})',i),'BackgroundColor',[0.9 0.9 0.9]);

    line(ranks,median(ranked_dXs),'Color','r');
    
    hold off;
    xlim([0 max(ranks)]);
    cur_histo=cur_histo+1;
end
