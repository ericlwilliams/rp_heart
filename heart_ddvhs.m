%% heart dDVHs for MSKCC patients
load('heart_data.mat')
n_pats = length(patient_key);

for i=1:n_pats
    ddvh_name='dDVH';
    if i<10,
        ddvh_name=strcat(ddvh_name,strcat('0',int2str(i)));
    else
        ddvh_name=strcat(ddvh_name,int2str(i));
    end
    

    clear cur_fig;
    cur_fig = figure;
    set(cur_fig,'InvertHardCopy','off');
    if patient_key{i,2}==1,
        set(cur_fig,'Color','r');
    else
        set(cur_fig,'Color',get(cur_fig,'Color'));
    end
    
    ddvh=eval(ddvh_name);
    plot(ddvh(:,1),ddvh(:,2));

    % Uncomment below to print pdf of dDVHs
    % pngs automatically created when running publish
    %print_loc = strcat('./figures/',ddvh_name);
    %print_loc = strcat(print_loc,'.eps');
    %print(cur_fig,'-dpdf',print_loc);


end
