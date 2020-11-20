%% Figures for Pigs 3 Analysis
% Patrick M. Donnelly
% University of Washington
% 7 November 2020

% Run pigs3_preprocess.m script
study2_analysis;
addpath(genpath('helper/'));
%% globals
decoding_model = 'acc ~ 1 + int_session + (int_session|record_id)';
acc_model = 'first_acc ~ 1 + int_session + (int_session|record_id)';
rate_model = 'second_rate ~ 1 + int_session + (int_session|record_id)';

%colormap
tab10 = colormap('tab10');

opts.width      = 15;
opts.height     = 15;
opts.fontType   = 'Times';
opts.fontSize   = 12;



%% Figure 1
% Comparison A
dmap = vertcat(tab10(8,:), tab10(1,:));
groups = unique(wide_data.pigs_casecontrol);

% Initialize figure
fig3a=figure;hold;

for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_casecontrol, groups(group)));
    group_data = wide_data(indx, :); 
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.decoding_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
hold on
for group = 1:numel(groups)
    fit_data = long_data(long_data.pigs_casecontrol == groups(group),:);
    fit = fitlme(fit_data, decoding_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    h(group) = plot(sessions, fitted, '-', 'Color', ...
        dmap(group,:), 'linewidth', 3);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '--', 'Color', ...
        dmap(group,:), 'linewidth', 3, 'CapSize', 0);
end

title('Decoding accuracy', 'FontSize', 18)
legend(h,{'Control', 'Intervention'}, ...
    'location', 'northwest', 'FontSize', 12)
xlabel('Session', 'FontSize', 14)
ylabel('Change in number correct', 'FontSize', 14)
hold off

% scaling
fig3a.Units               = 'centimeters';
fig3a.Position(3)         = 10;
fig3a.Position(4)         = 10;
% set text properties
set(fig3a.Children, ...
    'FontName',     'Times', ...
    'FontSize',     opts.fontSize);
% remove unnecessary white space
set(gca,'LooseInset',max(get(gca,'TightInset'), 0.02))

%exportgraphics(gcf,'fig3a.eps','ContentType','vector')

fig3b=figure;hold;
t = tiledlayout(2,2,'TileSpacing','none');


% Real Word
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_casecontrol, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.word_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(real(real.pigs_casecontrol == groups(group), :), ...
        decoding_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    b(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth',3);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 3, 'CapSize', 0);
end

title('Real word decoding', 'FontSize', 18)
%legend(h,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('', 'FontSize', 14)
ylabel('Change in number correct', 'FontSize', 14)
hold off

% Pseudo 
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_casecontrol, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.pseudo_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(pseudo(pseudo.pigs_casecontrol == groups(group), :), ...
        decoding_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    c(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth', 3);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 3, 'CapSize', 0);
end

title('Pseudo word decoding', 'FontSize', 18)
%legend(h,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('', 'FontSize', 14)
ylabel('Change in number correct', 'FontSize', 14)
hold off

% Passage Reading Accuracy
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_casecontrol, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.acc_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(wide_data(wide_data.pigs_casecontrol == groups(group), :), ...
        acc_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    d(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth', 3);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 3, 'CapSize', 0);
end

title('Passage reading accuracy', 'FontSize', 18)
%legend(d,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('Session', 'FontSize', 14)
ylabel('Change in proportion correct', 'FontSize', 14)
hold off

% Passage Reading Rate
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_casecontrol, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.rate_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(wide_data(wide_data.pigs_casecontrol == groups(group), :), ...
        rate_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    e(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth', 3);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 3, 'CapSize', 0);
end

title('Passage reading rate', 'FontSize', 18)
%legend(e,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('Session', 'FontSize', 14)
ylabel('Change in correct words/sec', 'FontSize', 14)
hold off

t.TileSpacing = 'compact';
t.Padding = 'compact';

% scaling
fig3b.Units               = 'centimeters';
fig3b.Position(3)         = opts.width;
fig3b.Position(4)         = opts.height;
% set text properties
set(t.Children, ...
    'FontName',     'Times', ...
    'FontSize',     opts.fontSize);
% remove unnecessary white space
set(gca,'LooseInset',max(get(gca,'TightInset'), 0.02))
%exportgraphics(gcf,'fig3b.eps','ContentType','vector')

%% Figure 2
% Comparison B
dmap = vertcat(tab10(8,:), tab10(3,:), tab10(5,:));
groups = unique(wide_data.pigs_group);

% Initialize figure
fig4a=figure;hold;
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_group, groups(group)));
    group_data = wide_data(indx, :); 
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.decoding_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit_data = long_data(long_data.pigs_group == groups(group),:);
    fit = fitlme(fit_data, decoding_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    a(group) = plot(sessions, fitted, '-', 'Color', ...
        dmap(group,:), 'linewidth', 4);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '--', 'Color', ...
        dmap(group,:), 'linewidth', 4, 'CapSize', 0);
end

title('Decoding accuracy', 'FontSize', 18)
legend(a, {'Control', 'Independent', 'Dyadic'}, ...
    'location', 'northwest', 'FontSize', 12)
xlabel('Session', 'FontSize', 14)
ylabel('Change in number correct', 'FontSize', 14)
hold off


% scaling
fig4a.Units               = 'centimeters';
fig4a.Position(3)         = 10;
fig4a.Position(4)         = 10;
% set text properties
set(fig4a.Children, ...
    'FontName',     'Times', ...
    'FontSize',     opts.fontSize);
% remove unnecessary white space
set(gca,'LooseInset',max(get(gca,'TightInset'), 0.02))

%exportgraphics(gcf,'fig4a.eps','ContentType','vector')


fig4b=figure;hold;
v = tiledlayout(2,2,'TileSpacing','none');


% Real Word
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_group, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.word_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(real(real.pigs_group == groups(group), :), ...
        decoding_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    b(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth', 4);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 4, 'CapSize', 0);
end

title('Real word decoding', 'FontSize', 18)
%legend(h,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('', 'FontSize', 14)
ylabel('Change in number correct', 'FontSize', 14)
hold off

% Pseudo 
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_group, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.pseudo_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(pseudo(pseudo.pigs_group == groups(group), :), ...
        decoding_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    c(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth', 4);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 4, 'CapSize', 0);
end

title('Pseudo word decoding', 'FontSize', 18)
%legend(h,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('', 'FontSize', 14)
ylabel('Change in number correct', 'FontSize', 14)
hold off

% Passage Reading Accuracy
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_group, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.acc_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(wide_data(wide_data.pigs_group == groups(group), :), ...
        acc_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    d(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth', 4);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 4, 'CapSize', 0);
end

title('Passage reading accuracy', 'FontSize', 18)
%legend(d,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('Session', 'FontSize', 14)
ylabel('Change in proportion correct', 'FontSize', 14)
hold off

% Passage Reading Rate
nexttile
hold on
for group = 1:numel(groups)
    indx = find(ismember(wide_data.pigs_group, groups(group)));
    group_data = wide_data(indx, :);
    for record = 1:numel(records)
        ix = find(ismember(group_data.record_id, records(record)));
        record_data = group_data(ix, :);
        plot(record_data.int_session, record_data.rate_slope, ...
            '-', 'Color', dmap(group,:), 'linewidth', 0.1);
    end
end
for group = 1:numel(groups)
    fit = fitlme(wide_data(wide_data.pigs_group == groups(group), :), ...
        rate_model, 'FitMethod', 'REML');
    base = 0;
    fitted = [base, base+fit.Coefficients.Estimate(2), ...
        base+fit.Coefficients.Estimate(3)];
    e(group) = plot(sessions, fitted, '-', 'Color', dmap(group,:), ...
        'linewidth', 4);
    errorbar(sessions(2:end,:), fitted(:,2:end), ...
        fit.Coefficients.SE(2:end,:), '-', 'Color', dmap(group,:), ...
        'linewidth', 4, 'CapSize', 0);
end

title('Passage reading rate', 'FontSize', 18)
%legend(e,{'Control', 'Intervention'}, 'location', 'northwest', ...
%    'FontSize', 12)
xlabel('Session', 'FontSize', 14)
ylabel('Change in correct words/sec', 'FontSize', 14)
hold off



v.TileSpacing = 'compact';
v.Padding = 'compact';

% scaling
fig4b.Units               = 'centimeters';
fig4b.Position(3)         = opts.width;
fig4b.Position(4)         = opts.height;
% set text properties
set(v.Children, ...
    'FontName',     'Times', ...
    'FontSize',     opts.fontSize);
% remove unnecessary white space
set(gca,'LooseInset',max(get(gca,'TightInset'), 0.02))
%exportgraphics(gcf,'fig4b.eps','ContentType','vector')
