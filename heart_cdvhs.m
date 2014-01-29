%% heart cDVHs for MSKCC patients
load('heart_data.mat')
n_pats = length(patient_key);
all_fig = figure('Name','All cDVHs','NumberTitle','off');
clear avg_doses;% matrix of 
avg_doses=[];
clear avg_sig_doses;
avg_sig_doses=[];
clear avg_vols;
avg_vols=[];
clear avg_sig_vols;
avg_sig_vols=[];
n_null=0;
n_sig=0;
for i=1:n_pats
    cdvh_name='cDVH';
    if i<10,
        cdvh_name=strcat(cdvh_name,strcat('0',int2str(i)));
    else
        cdvh_name=strcat(cdvh_name,int2str(i));
    end
    
    clear cur_fig;
    cur_fig = figure;
    set(cur_fig,'InvertHardCopy','off');
    is_sig=false;
    if patient_key{i,2}==1,
        set(cur_fig,'Color','r');
        is_sig=true;
    else
        set(cur_fig,'Color',get(cur_fig,'Color'));
    end
    
    cdvh=eval(cdvh_name);
    plot(cdvh(:,1),cdvh(:,2));
    
    if i==1,
        if is_sig,
            avg_sig_vols=cdvh(:,1);
            avg_sig_doses=cdvh(:,2);
            
            avg_vols = zeros(length(cdvh(:,1)),1);
            avg_doses = zeros(length(cdvh(:,2)),2);
        else
            avg_sig_vols = zeros(length(cdvh(:,1)),1);
            avg_sig_doses = zeros(length(cdvh(:,2)),2);
            
            avg_vols=cdvh(:,1);
            avg_doses = cdvh(:,2);
        end
    else
        if is_sig,
            avg_sig_vols = [avg_sig_vols cdvh(:,1)];
            avg_sig_doses = [avg_sig_doses cdvh(:,2)];
        else
            avg_doses = [avg_doses cdvh(:,2)];
            avg_vols = [avg_vols cdvh(:,1)];
        end
    end
    set(0,'CurrentFigure',all_fig);
    hold on
    if is_sig,
        n_sig=n_sig+1;
        plot(cdvh(:,1),cdvh(:,2),'r','LineWidth',2);
    else
        n_null=n_null+1;
        plot(cdvh(:,1),cdvh(:,2),'b');
    end
    hold off
    
        
    % Uncomment below to print pdf of dDVHs
    % pngs automatically created when running publish
    %print_loc = strcat('./figures/',ddvh_name);
    %print_loc = strcat(print_loc,'.eps');
    %print(cur_fig,'-dpdf',print_loc);


end
%% Mean DVHs
mean_vols = mean(avg_vols');
mean_doses = mean(avg_doses');
std_doses = std(avg_doses');

mean_sig_vols = mean(avg_sig_vols');
mean_sig_doses = mean(avg_sig_doses');
std_sig_doses = std(avg_sig_doses');

figure('Name','Avg cDVHs','NumberTitle','off');
hold on;
plot(mean_vols,mean_doses,'b');%mean values
plot(mean_vols,mean_doses+std_doses,'Color',[0 1 1]);
plot(mean_vols,mean_doses-std_doses,'Color',[0 1 1]);

plot(mean_sig_vols,mean_sig_doses,'r');%mean values
plot(mean_sig_vols,mean_sig_doses+std_sig_doses,'Color',[1 0 1]);
plot(mean_sig_vols,mean_sig_doses-std_sig_doses,'Color',[1 0 1]);
xlim([0 8000]);
ylim([0 1000]);

hold off;
