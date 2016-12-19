%------------------------------------
% Biavaschi & Elsner
% Let's be selective about migrant self-selection
% JIE revisions; Mexico only; integrated trade model
%
% This file generates the main results;
%------------------------------------


%---baseline results
spec={'sel', 'neutral'};
% for i=1:2 
%     [real_wages.(spec{i}), ...
%         nom_wages.(spec{i}), ...
%         prices_total.(spec{i}), ...
%         share_y.(spec{i}), ... 
%         trade_gdp.(spec{i}), ... 
%         share_trade_x.(spec{i}), ... 
%         outputs_z.(spec{i}),...
%         nomwageZ.(spec{i})...
%         ...
%         ]=sel_master(param, skilldist_base.(spec{i}), param2);
% end


for i=1:2 
    [outmain.(spec{i})]=sel_master(skilldist_base.(spec{i}), param, param2);
end


%------------------------------------
% Empty outmain

for i=1:2 
        real_wages.(spec{i})=outmain.(spec{i}){1};
        nom_wages.(spec{i})=outmain.(spec{i}){2};
        prices_total.(spec{i})=outmain.(spec{i}){3};
        share_y.(spec{i})=outmain.(spec{i}){4};
        trade_gdp.(spec{i})=outmain.(spec{i}){5}; 
        share_trade_x.(spec{i})=outmain.(spec{i}){6};
        outputs_z.(spec{i})=outmain.(spec{i}){7};
        nomwageZ.(spec{i})=outmain.(spec{i}){8};
end


diff_real_wages=(real_wages.sel-real_wages.neutral)./real_wages.neutral*100;
diff_nominal_wages=(nom_wages.sel-nom_wages.neutral)./nom_wages.neutral*100;
diff_prices=(prices_total.sel-prices_total.neutral)./prices_total.neutral*100;
diff_trade=(trade_gdp.sel-trade_gdp.neutral)*100;
diff_shx=(share_trade_x.sel-share_trade_x.neutral)*100;
diff_z=(outputs_z.sel-outputs_z.neutral);
diff_nomwageZ=(nomwageZ.sel-nomwageZ.neutral)./nomwageZ.neutral*100;

results_basic=[diff_real_wages; diff_nominal_wages; diff_prices; diff_trade; diff_shx; diff_z; diff_nomwageZ];
resbasic=fullfile(texout, 'outputs.tex');


%---create output data
for i=1:size(threshZ, 2)
    a=num2str(outputZ(i)*100);
    b={'wagepct{a}'}
    
end    

rownames={'real income pc'; 'nominal wages'; 'prices'; 'trade share gdp'; 'share_x'; 'cutoff Z'; 'wagePCT25' ; 'wagePCT50' ; 'wagePCT75' ; 'wagePCT90'};
colnames={'Mexico', 'USA'};

basicres=table(results_basic(:,1), results_basic(:,2), 'RowNames', rownames, 'VariableNames', colnames);

% 'RowNames', rownames,
%matrix2latex(results_basic, 'resbasic')





