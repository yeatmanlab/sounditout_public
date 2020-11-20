%% LME Analysis Script for PIGS3
% Patrick M. Donnelly
% University of Washington
% 16 November, 2020

%% Data

long_data = readtable('data/study2/study2_longdata.csv');
wide_data = readtable('data/study2/study2_widedata.csv');

long_data.int_session = categorical(long_data.int_session);
long_data.pigs_casecontrol = categorical(long_data.pigs_casecontrol);
long_data.pigs_group = categorical(long_data.pigs_group);

wide_data.int_session = categorical(wide_data.int_session);
wide_data.pigs_casecontrol = categorical(wide_data.pigs_casecontrol);
wide_data.pigs_group = categorical(wide_data.pigs_group);

records = unique(wide_data.record_id);
sessions = unique(wide_data.int_session);

%% Models
% Decoding
modela = 'acc ~ 1 + pigs_casecontrol*int_session + (int_session|record_id) + (1|acc_Indicator)';
modelb = 'acc ~ 1 + pigs_group*int_session + (int_session|record_id) + (1|acc_Indicator)';
%exploratory analysis 
%replace first variable in interaction with one of the following:
% visit_age, wj_brs, twre_index, ctopp_pa, ctopp_rapid, wasi_fs2
modelexp = 'acc ~ 1 + ctopp_rapid*int_session + (int_session|record_id) + (1|acc_Indicator)';

% Passage Reading
acc_modela = 'first_acc ~ 1 + pigs_casecontrol*int_session + (int_session|record_id)';
rate_modela = 'second_rate ~ 1 + pigs_casecontrol*int_session + (int_session|record_id)';
acc_modelb = 'first_acc ~ 1 + pigs_group*int_session + (int_session|record_id)';
rate_modelb = 'second_rate ~ 1 + pigs_group*int_session + (int_session|record_id)';
%exploratory analysis 
%replace first variable in interaction with one of the following:
% visit_age, wj_brs, twre_index, ctopp_pa, ctopp_rapid, wasi_fs2
acc_modelexp = 'first_acc ~ 1 + ctopp_rapid*int_session + (int_session|record_id)';
rate_modelexp = 'second_rate ~ 1 + ctopp_rapid*int_session + (int_session|record_id)';

%% Decoding accuracy analysis

int_only = long_data(find(ismember(long_data.pigs_casecontrol, '1')),:);
int_only.pigs_group = removecats(int_only.pigs_group, '4');

% perform model fits
decoding_a = fitlme(long_data, modela, 'FitMethod', 'REML'); 
decoding_b = fitlme(int_only, modelb, 'FitMethod', 'REML');
decoding_exp = fitlme(int_only, modelexp, 'FitMethod', 'REML'); 

%% Real word analysis
% focus in on dataset
real = long_data(long_data.type==true,:);
real_intonly = real(find(ismember(real.pigs_casecontrol, '1')),:);
real_intonly.pigs_group = removecats(real_intonly.pigs_group, '4');

% perform model fits
real_a = fitlme(real, modela, 'FitMethod', 'REML');
real_b = fitlme(real_intonly, modelb, 'FitMethod', 'REML'); 
real_exp = fitlme(real_intonly, modelexp, 'FitMethod', 'REML');

%% Pseudo word analysis

% focus in on dataset
pseudo = long_data(long_data.type==false,:);
pseudo_intonly = pseudo(find(ismember(pseudo.pigs_casecontrol, '1')),:);
pseudo_intonly.pigs_group = removecats(pseudo_intonly.pigs_group, '4');

% perform model fits
pseudo_a = fitlme(pseudo, modela, 'FitMethod', 'REML');
pseudo_b = fitlme(pseudo_intonly, modelb, 'FitMethod', 'REML'); 
pseudo_exp = fitlme(pseudo_intonly, modelexp, 'FitMethod', 'REML');


%% Passage Reading Accuracy analysis

accdata_intonly = wide_data(find(ismember(wide_data.pigs_casecontrol, '1')),:);
accdata_intonly.pigs_group = removecats(accdata_intonly.pigs_group, '4');

% perform model fits
acc_a = fitlme(wide_data, acc_modela, 'FitMethod', 'REML'); 
acc_b = fitlme(accdata_intonly, acc_modelb, 'FitMethod', 'REML');
acc_exp = fitlme(accdata_intonly, acc_modelexp, 'FitMethod', 'REML');


%% Passage Reading Rate analysis
ratedata_intonly = wide_data(find(ismember(wide_data.pigs_casecontrol, '1')),:);
ratedata_intonly.pigs_group = removecats(ratedata_intonly.pigs_group, '4');

% perform model fits
rate_a = fitlme(wide_data, rate_modela, 'FitMethod', 'REML');
rate_b = fitlme(ratedata_intonly, rate_modelb, 'FitMethod', 'REML'); 
rate_exp = fitlme(ratedata_intonly, rate_modelexp, 'FitMethod', 'REML');


%% effect size calculation
%look at one visit per person
es_data = wide_data(wide_data.int_session == '1',:);
int_only = es_data(es_data.pigs_casecontrol == '1',:);
cntrl_only = es_data(es_data.pigs_casecontrol == '0',:);

x = int_only.totalchange_rate(~isnan(int_only.totalchange_rate));
y = cntrl_only.totalchange_rate(~isnan(cntrl_only.totalchange_rate));

num_x = numel(x);
num_y = numel(y);

pooled_std = sqrt(((num_x - 1)*(std(x)^2) + (num_y - 1)*(std(y)^2)) / ((num_x - 1) + (num_y - 1)));

d = (mean(x) - mean(y)) / pooled_std;







