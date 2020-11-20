%% demographics table
%zero in on session 1 data
demodata = wide_data(wide_data.int_session == '1',:);

%separate datasets per group for transparency in code
demo_control = demodata(demodata.pigs_group == '4', :);
demo_independent = demodata(demodata.pigs_group == '5', :);
demo_dyadic = demodata(demodata.pigs_group == '6', :);


% Statistical tests

%WJ BRS
[age_p,age_tbl,age_stats] = kruskalwallis(demodata{:,'visit_age'}, demodata{:,'pigs_group'}, 'off');
[brs_p,brs_tbl,brs_stats] = kruskalwallis(demodata{:,'wj_brs'}, demodata{:,'pigs_group'}, 'off');
[twre_p,twre_tbl,twre_stats] = kruskalwallis(demodata{:,'twre_index'}, demodata{:,'pigs_group'}, 'off');
[wasi_p,wasi_tbl,wasi_stats] = kruskalwallis(demodata{:,'wasi_fs2'}, demodata{:,'pigs_group'}, 'off');
[pa_p,pa_tbl,pa_stats] = kruskalwallis(demodata{:,'ctopp_pa'}, demodata{:,'pigs_group'}, 'off');
[rapid_p,rapid_tbl,rapid_stats] = kruskalwallis(demodata{:,'ctopp_rapid'}, demodata{:,'pigs_group'}, 'off');


%create arrays for each group
row_names = [{'Age (y)'}; {'WJ BRS'}; {'TOWRE Index'}; {'WASI FS2'}; ...
            {'CTOPP PA'}; {'CTOPP RAPID'}];

control_means = [mean(demo_control.visit_age)/12; mean(demo_control.wj_brs); 
    mean(demo_control.twre_index); mean(demo_control.wasi_fs2); 
    mean(demo_control.ctopp_pa); nanmean(demo_control.ctopp_rapid);];
control_std = [std(demo_control.visit_age)/12; std(demo_control.wj_brs); 
    std(demo_control.twre_index); std(demo_control.wasi_fs2); 
    std(demo_control.ctopp_pa); nanstd(demo_control.ctopp_rapid);];
        
independent_means = [mean(demo_independent.visit_age)/12; mean(demo_independent.wj_brs); 
    mean(demo_independent.twre_index); mean(demo_independent.wasi_fs2); 
    mean(demo_independent.ctopp_pa); nanmean(demo_independent.ctopp_rapid);];
independent_std = [std(demo_independent.visit_age)/12; std(demo_independent.wj_brs); 
    std(demo_independent.twre_index); std(demo_independent.wasi_fs2); 
    std(demo_independent.ctopp_pa); nanstd(demo_independent.ctopp_rapid);];

dyadic_means = [mean(demo_dyadic.visit_age)/12; mean(demo_dyadic.wj_brs); 
    mean(demo_dyadic.twre_index); mean(demo_dyadic.wasi_fs2); 
    mean(demo_dyadic.ctopp_pa); nanmean(demo_dyadic.ctopp_rapid);];
dyadic_std = [std(demo_dyadic.visit_age)/12; std(demo_dyadic.wj_brs); 
    std(demo_dyadic.twre_index); std(demo_dyadic.wasi_fs2); 
    std(demo_dyadic.ctopp_pa); nanstd(demo_dyadic.ctopp_rapid);];

chisquares = [age_tbl{2,5}; brs_tbl{2,5}; twre_tbl{2,5}; wasi_tbl{2,5}; ...
    pa_tbl{2,5}; rapid_tbl{2,5}];
    
pvalues = [age_p; brs_p; twre_p; wasi_p; pa_p; rapid_p];

demotable = table(row_names, control_means, control_std, ...
    independent_means,independent_std, dyadic_means, dyadic_std, ...
    chisquares, pvalues);


