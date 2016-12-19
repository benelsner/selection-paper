%-------------solve the model-------------------------


% pure selection
countries={'norway', 'mexico', 'us1880', 'us2000', 'cal', 'tex', 'us1880other', 'us2000other', 'us1880naive', 'us2000naive'};
spec={'sel', 'neutral'};

for i=1:length(countries)
    for j=1:length(spec)
        [outputmat.(countries{i}).(spec{j}), outputmat_all.(countries{i}).(spec{j}), model_mom.(countries{i}).(spec{j}), employment_y.(countries{i}).(spec{j}),...
            wages_nominal.(countries{i}).(spec{j}), wages_real.(countries{i}).(spec{j}), cutoff.(countries{i}).(spec{j}), z_cutoff.(countries{i}).(spec{j}), ...
            nr_var.(countries{i}).(spec{j}), int_x.(countries{i}).(spec{j}), int_x_values.(countries{i}).(spec{j}), skill_weight.(countries{i}).(spec{j})]= ...
            master_function(g_y.(countries{i}), x.(countries{i})(5,1), x.(countries{i})(1,1), x.(countries{i})(3,1), x.(countries{i})(2,1), total_pop.(countries{i}), ...
            x.(countries{i})(4,1), tfp.(countries{i}), skill_level, skilldist.(countries{i}).(spec{j}));
    end
end

%{
for i=1:length(countries)
    for j=1:length(spec)
        [outputmat.(countries{i}).(spec{j}), outputmat_all.(countries{i}).(spec{j}), model_mom.(countries{i}).(spec{j}), employment_y.(countries{i}).(spec{j}),...
            wages_nominal.(countries{i}).(spec{j}), wages_real.(countries{i}).(spec{j})]= ...
            master_function(g_y.(countries{i}), g_x.(countries{i}), x.(countries{i})(1,1), x.(countries{i})(3,1), x.(countries{i})(2,1), total_pop.(countries{i}), ...
            x.(countries{i})(4,1), tfp.(countries{i}), skill_level, skilldist.(countries{i}).(spec{j}));
    end
end
%}

% selection conditional on age

countries_cond={'norway', 'mexico', 'us1880', 'us2000'};
%{
for i=1:length(countries_cond)
    for j=1:length(spec)
        [outputmat_cond.(countries_cond{i}).(spec{j}), outputmat_all_cond.(countries_cond{i}).(spec{j}),~, ~, ~, ~]= ...
            master_function(g_y.(countries_cond{i}), x.(countries_cond{i})(5,1), x.(countries_cond{i})(1,1),... 
            x.(countries_cond{i})(3,1), x.(countries_cond{i})(2,1), total_pop.(countries_cond{i}), ...
            x.(countries_cond{i})(4,1), tfp.(countries_cond{i}), skill_level, skill_cond.(countries_cond{i}).(spec{j}));
    end
end
%}
for i=1:length(countries_cond)
    for j=1:length(spec)
        [outputmat_cond.(countries_cond{i}).(spec{j}), outputmat_all_cond.(countries_cond{i}).(spec{j}),~, ~, ~, ~, ~, ~, ~, ~, ~, ~]= ...
            master_function(g_y.(countries_cond{i}), g_x.(countries{i}), x.(countries_cond{i})(1,1),... 
            x.(countries_cond{i})(3,1), x.(countries_cond{i})(2,1), total_pop.(countries_cond{i}), ...
            x.(countries_cond{i})(4,1), tfp.(countries_cond{i}), skill_level, skill_cond.(countries_cond{i}).(spec{j}));
    end
end


% autarky
countries_cond={'norway', 'mexico', 'us1880', 'us2000'};
for i=1:length(countries_cond)
        [outputmat_aut.(countries_cond{i}), outputmat_all_aut.(countries_cond{i}),~, ~, ~, ~, ~, ~, ~, ~, ~, ~]= ...
            master_function(g_y.(countries_cond{i}), x.(countries_cond{i})(5,1), x.(countries_cond{i})(1,1),... 
            x.(countries_cond{i})(3,1), x.(countries_cond{i})(2,1), total_pop.(countries_cond{i}), ...
            x.(countries_cond{i})(4,1), tfp.(countries_cond{i}), skill_level, skill_aut.(countries_cond{i}));
end

%{
for i=1:length(countries_cond)
        [outputmat_aut.(countries_cond{i}), outputmat_all_aut.(countries_cond{i}),~, ~, ~, ~]= ...
            master_function(g_y.(countries_cond{i}), g_x.(countries{i}), x.(countries_cond{i})(1,1),... 
            x.(countries_cond{i})(3,1), x.(countries_cond{i})(2,1), total_pop.(countries_cond{i}), ...
            x.(countries_cond{i})(4,1), tfp.(countries_cond{i}), skill_level, skill_aut.(countries_cond{i}));
end
%}

% real wages
for i=1:length(countries)
    for j=1:length(spec)
        [wage_quintiles.(countries{i}).(spec{j})]=quint_real_wage(wages_real.(countries{i}).(spec{j}), skilldist.(countries{i}).(spec{j}));
    end    
end

