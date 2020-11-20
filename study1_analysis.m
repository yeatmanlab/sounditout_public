%% PIGS X Analysis
% Patrick M Donnelly
% University of Washington
% 16 November 2020

%prep data for LME analysis; by outcome measure
word_data = readtable('data/study1/study1_word.csv');
pseudo_data = readtable('data/study1/study1_pseudo.csv');
acc_data = readtable('data/study1/study1_acc.csv');
rate_data = readtable('data/study1/study1_rate.csv');


word_data.pigs_group = categorical(word_data.pigs_group);
pseudo_data.pigs_group = categorical(pseudo_data.pigs_group);
acc_data.pigs_group = categorical(acc_data.pigs_group);
rate_data.pigs_group = categorical(rate_data.pigs_group);

word_data.condition = categorical(word_data.condition);
pseudo_data.condition = categorical(pseudo_data.condition);
acc_data.condition = categorical(acc_data.condition);
rate_data.condition = categorical(rate_data.condition);




%% Perform LME model fits

%% Real Word

model_1 = 'acc ~ 1 + condition + (1|record_id) + (1|pigs_group)';
model_2 = 'acc ~ 1 + condition + (1|record_id) + (1|pigs_group) + (1|list)';

fit1 = fitlme(word_data, model_1, 'FitMethod', 'REML');
fit2 = fitlme(word_data, model_2, 'FitMethod', 'REML');
compare(fit1,fit2)
%model comparison indicates random effect of list is a better model


%plot residuals to check heteroscedasticity
figure();
plotResiduals(fit2)%reveals normally distributed residuals

%plot the fitted response versus the observed response and residuals
F = fitted(fit2);
R = response(fit2);
figure();
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')
%indicates good fit

word_fit = fit2;
% fixed effect of condition (0.19, p = 0.611)


%% Pseudo Word

model_1 = 'acc ~ 1 + condition + (1|record_id) + (1|pigs_group) + (1|list)';
% for consistency using same model as real word
fit1 = fitlme(pseudo_data, model_1, 'FitMethod', 'REML');

%model comparison indicates random effect of list is a better model

%plot residuals to check heteroscedasticity
figure();
plotResiduals(fit1)%reveals normally distributed residuals

%plot the fitted response versus the observed response and residuals
F = fitted(fit1);
R = response(fit1);
figure();
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')
%indicates decent fit, but lots of variance

pseudo_fit = fit1;
% fixed effect of condition (-0.21, p = 0.736)



%% accuracy

model_1 = 'acc ~ 1 + condition + (1|record_id) + (1|pigs_group)';
model_2 = 'acc ~ 1 + condition + (1|record_id) + (1|pigs_group) + (1|passage)';

fit1 = fitlme(acc_data, model_1, 'FitMethod', 'REML');
fit2 = fitlme(acc_data, model_2, 'FitMethod', 'REML');
compare(fit1,fit2)
%model comparison indicates random effect of passage is not a better model

%plot residuals to check heteroscedasticity
figure();
plotResiduals(fit1)%reveals normally distributed residuals

%plot the fitted response versus the observed response and residuals
F = fitted(fit1);
R = response(fit1);
figure();
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')
%indicates decent fit, but lots of variance

acc_fit = fit1;
% fixed effect of condition (0.028, p = 0.017)



%% rate

model_1 = 'rate ~ 1 + condition + (1|record_id) + (1|pigs_group)';
model_2 = 'rate ~ 1 + condition + (1|record_id) + (1|pigs_group) + (1|passage)';

fit1 = fitlme(rate_data, model_1, 'FitMethod', 'REML');
fit2 = fitlme(rate_data, model_2, 'FitMethod', 'REML');
compare(fit1,fit2)
%model comparison indicates random effect of passage is not a better model

%plot residuals to check heteroscedasticity
figure();
plotResiduals(fit1)%reveals normally distributed residuals

%plot the fitted response versus the observed response and residuals
F = fitted(fit1);
R = response(fit1);
figure();
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')
%indicates decent fit, but lots of variance

rate_fit = fit1;
% fixed effect of condition (-0.048, p = 0.372)



%% Demographics table

demodata = readtable('data/study1/study1_demodata.csv');

%create arrays for each group
row_names = [{'Age (y)'}; {'WJ BRS'}; {'TOWRE Index'}; {'WASI FS2'}; ...
            {'CTOPP PA'}; {'CTOPP RAPID'}];

means = [mean(demodata.visit_age)/12; mean(demodata.wj_brs); 
    mean(demodata.twre_index); mean(demodata.wasi_fs2); 
    mean(demodata.ctopp_pa); nanmean(demodata.ctopp_rapid);];
std = [std(demodata.visit_age)/12; std(demodata.wj_brs); 
    std(demodata.twre_index); std(demodata.wasi_fs2); 
    std(demodata.ctopp_pa); nanstd(demodata.ctopp_rapid);];



demotable = table(row_names, means, std);
