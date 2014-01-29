function dvh_area_diff=CalcAreaDiff(dvhs,comp_patients)
    
    cur_comp_patients = comp_patients';
    cur_cens_patients = 1:70;
    cur_cens_patients(cur_comp_patients)=[];
    
    % pass only DVHs to be averaged
    cur_comp_cDVHs = dvhs(:,:,cur_comp_patients);
    cur_cens_cDVHs = dvhs(:,:,cur_cens_patients);
    
    % normalize volume
    cur_nComps = size(cur_comp_cDVHs,3);
    for i=1:cur_nComps;
      cur_comp_cDVHs(:,2,i) =...
          cur_comp_cDVHs(:,2,i)./max(cur_comp_cDVHs(:,2,i));
    end

    cur_nCens = size(cur_cens_cDVHs,3);
    for j=1:cur_nCens;
      cur_cens_cDVHs(:,2,j) =...
          cur_cens_cDVHs(:,2,j)./max(cur_cens_cDVHs(:,2,j));
    end
    
    % averages over all patients
    cur_mean_comp_cDVHs = mean(cur_comp_cDVHs,3);
    cur_mean_comp_doses = cur_mean_comp_cDVHs(1:2:end,1);
    cur_mean_comp_vols = cur_mean_comp_cDVHs(1:2:end,2);
    %cur_mean_comp_vols = cur_mean_comp_vols./max(cur_mean_comp_vols);
         
    cur_mean_cens_cDVHs = mean(cur_cens_cDVHs,3);
    cur_mean_cens_doses = cur_mean_cens_cDVHs(1:2:end,1);
    cur_mean_cens_vols = cur_mean_cens_cDVHs(1:2:end,2);
    %cur_mean_cens_vols = cur_mean_cens_vols./max(cur_mean_cens_vols);
    
    % Calculate area difference
    
    % determine range of doses 
    if max(cur_mean_comp_doses)<max(cur_mean_cens_doses),
        max_dose = max(cur_mean_cens_doses);
    else
        max_dose = max(cur_mean_comp_doses);
    end
    if length(cur_mean_cens_doses) ~=...
            length(cur_mean_comp_doses),
        disp(['Error: cens/comp dose axis length not equal!']);
    end
    
    %n_bins = length(cur_mean_cens_doses);
    %dose_step = max_dose/n_bins;
    
    % rebin in range 0-max_dose Gy, in steps of 1 Gy
    max_comp_dose_steps = max(diff(cur_mean_comp_doses));
    max_cens_dose_steps = max(diff(cur_mean_cens_doses));
    if(max_comp_dose_steps > max_cens_dose_steps),
        dose_step=max_comp_dose_steps;
    else
        dose_step=max_cens_dose_steps;
    end        

        %dose_step=100;
    
    vol_diff=0;
    for j=0:dose_step:max_dose,
        gt_comp = cur_mean_comp_doses>=j;
        lt_comp = cur_mean_comp_doses<(j+dose_step);
        good_comp_inds = gt_comp.*lt_comp;
        bin_comp_vols = cur_mean_comp_vols.*good_comp_inds;
        bin_comp_vols(~bin_comp_vols)=[];
        bin_mean_comp_vol = mean(bin_comp_vols);

        gt_cens = cur_mean_cens_doses>=j;
        lt_cens = cur_mean_cens_doses<(j+dose_step);
        good_cens_inds = gt_cens.*lt_cens;
        bin_cens_vols = cur_mean_cens_vols.*good_cens_inds;
        bin_cens_vols(~bin_cens_vols)=[];
        bin_mean_cens_vol = mean(bin_cens_vols);
        
        if (isnan(bin_mean_comp_vol) && ...
                    isnan(bin_mean_cens_vol)),
            continue;   
        elseif (~isnan(bin_mean_comp_vol) &&...
                ~isnan(bin_mean_cens_vol)),
            vol_diff = vol_diff+abs(bin_mean_comp_vol-bin_mean_cens_vol);
        elseif (isnan(bin_mean_cens_vol)),
            vol_diff = vol_diff+abs(bin_mean_comp_vol);
        elseif (isnan(bin_mean_comp_vol)),
            vol_diff = vol_diff+abs(bin_mean_cens_vol);
        end
    end
    
    dvh_area_diff = dose_step*vol_diff;

    if (j+dose_step)<max_dose,
        disp(['Error: bin range too small!']);
    end
end