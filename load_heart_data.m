% Load heart data
% Reads all data files in ~studies/data/heart_data of form
% (patient_name)_HEART_ABSVOL.TXT
% Loads variables cDVH(N), N is # of patient and patient_key a Nx2 cell
% with <N, patient_name> information
% OUTPUT: heart_data.mat

%clc
%clear all

%% Load heart patient dDVHs
% List cDVH files from ~studies/data/heart_data

%heart_analy_loc = 'G:\My Documents\studies\heart\';
%heart_data_loc = 'G:\My Documents\studies\data\heart_data\';

%heart_analy_loc = 'Z:\elw\MATLAB\heart\';
%heart_data_loc = 'Z:\elw\MATLAB\regions\meta\heart\';

heart_analy_loc = 'Z:\elw\MATLAB\heart\';
heart_data_loc = 'Z:\elw\MATLAB\original_data\MSK\heart\';

% load endponts file with endpoints info
%import_heart_endpoints_file('endpoints.xlsx');
import_heart_endpoints_file('l-r_heart-overlap.xls');

cd(heart_analy_loc);
heart_dir = dir(heart_data_loc);

patient_num=1;

clear patient_key;
patient_key=cell(length(heart_dir),2);
mds = zeros(length(heart_dir),1);

nDxStep = 100;
dXs = zeros(length(heart_dir),nDxStep);

nVxStep = 70;
vXs = zeros(length(heart_dir),nVxStep);

d05s = zeros(length(heart_dir),1);
d10s = zeros(length(heart_dir),1);
d25s = zeros(length(heart_dir),1);
d33s = zeros(length(heart_dir),1);
d50s = zeros(length(heart_dir),1);
d66s = zeros(length(heart_dir),1);
d75s = zeros(length(heart_dir),1);
v13s = zeros(length(heart_dir),1);
v20s = zeros(length(heart_dir),1);
v30s = zeros(length(heart_dir),1);
epts = zeros(length(heart_dir),1);
ols = zeros(length(heart_dir),1);
mlds = zeros(length(heart_dir),1);
llds = zeros(length(heart_dir),1);
ilds = zeros(length(heart_dir),1);
isleft = zeros(length(heart_dir),1);

nEudStep=21;% 21 steps from log(a)=-1 to log(a)=1
euds = zeros(length(heart_dir),nEudStep);

cDVHs = zeros(201,2,length(heart_dir));

for i=1:length(heart_dir)
    cur_name = heart_dir(i).name;
    good_patient=false;
    

  if 1,
      if isempty(strfind(cur_name,'HEART_ABSVOL.TXT'))==false,
          patient_key{patient_num,1}=strrep(cur_name,'_HEART_ABSVOL.TXT','');
          good_patient=true;
      elseif isempty(strfind(cur_name,'HEARTEY_ABSVOL.TXT'))==false,
          patient_key{patient_num,1}=strrep(cur_name,'_HEARTEY_ABSVOL.TXT','');
          good_patient=true;
      elseif isempty(strfind(cur_name,'HEARTLB_ABSVOL.TXT'))==false,
          patient_key{patient_num,1}=strrep(cur_name,'_HEARTLB_ABSVOL.TXT','');
          good_patient=true;
      end
  end
    
  if good_patient,
        
        cur_patient_name = patient_key{patient_num,1};
        patient_ep_found=false;
        cur_ep_index=0;
        for j=2:length(textdata(:,1)),
            ep_patient = textdata{j,1};
            if strcmpi(cur_patient_name,ep_patient),
                patient_ep_found=true;
                cur_ep_index=j-1;
                break
            end
        end

        if patient_ep_found==true,
            patient_key{patient_num,2} = data(cur_ep_index,1);
            [cur_dDVH,cur_cDVH]=import_ddvh_file(strcat(heart_data_loc,cur_name),patient_num);

            
            % Load gEUD values
            mds(patient_num,1) = gEUD_from_absDVH(cur_dDVH,1);
            v13s(patient_num,1) = Vx_from_cDVH(cur_cDVH,13);
            
            for i=1:nDxStep,
                dXs(patient_num,i) = Dx_from_cDVH(cur_cDVH,i);
            end
            
             for j=1:nVxStep,
                vXs(patient_num,j) = Vx_from_cDVH(cur_cDVH,j);
             end
            k=1;
            for loga=-1:0.1:1,
                euds(patient_num,k) = gEUD_from_absDVH(cur_dDVH,10^loga);
                k=k+1;
            end
             
            d05s(patient_num,1) = Dx_from_cDVH(cur_cDVH,5);
            d10s(patient_num,1) = Dx_from_cDVH(cur_cDVH,10);
            d25s(patient_num,1) = Dx_from_cDVH(cur_cDVH,25);
            d33s(patient_num,1) = Dx_from_cDVH(cur_cDVH,33);
            d50s(patient_num,1) = Dx_from_cDVH(cur_cDVH,50);
            d66s(patient_num,1) = Dx_from_cDVH(cur_cDVH,66);
            d75s(patient_num,1) = Dx_from_cDVH(cur_cDVH,75);
            v20s(patient_num,1) = Vx_from_cDVH(cur_cDVH,20);
            v30s(patient_num,1) = Vx_from_cDVH(cur_cDVH,30);
            epts(patient_num,1) = data(cur_ep_index,1);
            %% Fractional heart overlap
            ols(patient_num,1) = 100.*data(cur_ep_index,3)/cur_cDVH(1,2);
            ptv_loc = textdata(cur_ep_index+1,5);
            ptv_loc = char(ptv_loc);
            isleft(patient_num,1) = isequal('L',ptv_loc(1));
            mlds(patient_num,1) = data(cur_ep_index,6);
            ilds(patient_num,1) = data(cur_ep_index,7);
            llds(patient_num,1) = data(cur_ep_index,8);
            
            cDVHs(:,:,patient_num) = cur_cDVH;
            
            patient_num=patient_num+1;           
        else,
            disp(['Patient, ',cur_name,' not found!']);
        end
  end
end
mds = mds(1:(patient_num-1),1);
assignin('base','mds',mds);

euds = euds(1:(patient_num-1),:);
assignin('base','euds',euds);

dXs = dXs(1:(patient_num-1),:);
assignin('base','dXs',dXs);

vXs = vXs(1:(patient_num-1),:);
assignin('base','vXs',vXs);

d05s = d05s(1:(patient_num-1),1);
assignin('base','d05s',d05s);
d10s = d10s(1:(patient_num-1),1);
assignin('base','d10s',d10s);
d25s = d25s(1:(patient_num-1),1);
assignin('base','d25s',d25s);
d33s = d33s(1:(patient_num-1),1);
assignin('base','d33s',d33s);
d50s = d50s(1:(patient_num-1),1);
assignin('base','d50s',d50s);
d66s = d66s(1:(patient_num-1),1);
assignin('base','d66s',d66s);
d75s = d75s(1:(patient_num-1),1);
assignin('base','d75s',d75s);
v13s = v13s(1:(patient_num-1),1);
assignin('base','v13s',v13s);
v20s = v20s(1:(patient_num-1),1);
assignin('base','v20s',v20s);
v30s = v30s(1:(patient_num-1),1);
assignin('base','v30s',v30s);

epts = epts(1:(patient_num-1),1);
assignin('base','epts',epts);

ols = ols(1:(patient_num-1),1);
assignin('base','ols',ols);

mlds = mlds(1:(patient_num-1),1);
assignin('base','mlds',mlds);

llds = llds(1:(patient_num-1),1);
assignin('base','llds',llds);

ilds = ilds(1:(patient_num-1),1);
assignin('base','ilds',ilds);

isleft = isleft(1:(patient_num-1),1);
assignin('base','isleft',isleft);

cDVHs= cDVHs(:,:,1:(patient_num-1));
assignin('base','cDVHs',cDVHs);

% remove all empty cells
%patient_tmp_key = patient_tmp_key(~cellfun('isempty',patient_tmp_key));
patient_key = patient_key(1:(patient_num-1),1:2);
%patient_key = patient_key(~cellfun('isempty',patient_key));


save heart_data patient_key mds euds epts isleft cDVHs ols mlds llds ilds v13s v20s v30s dXs vXs d05s d10s d25s...
    d33s d50s d66s d75s '-regexp' 'dDVH\d\d' 'cDVH\d\d';
clear all;
