%------------------------------------
% Biavaschi & Elsner
% Let's be selective about migrant self-selection
% JIE revisions; Mexico only; integrated trade model
%------------------------------------
P=path;
%path(P, 'C:/My Dropbox/Selection paper/matlab/Trade model JIE revisions')
%texout=fileparts('C:/My Dropbox/Selection paper/matlab/Trade model JIE revisions/texout/');

path(P, 'C:\Users\xj908716\Dropbox\Trade model JIE revisions')
texout=fileparts('C:\Users\xj908716\Dropbox\Trade model JIE revisions/texout');



%---------------------------
% READ IN AND CLEAN DATA
exog_para_jie   %<- ENTER ALL MODEL PARAMETERS HERE

read_data_jie   % reads in data from spreadsheets
endog_para_jie  % generates parameters from data and exogenous parameters

%---------------------------
% Non-parametric re-weighting

%---------------------------
% SOLVE MODEL
basic_results_jie

% test

%[prices_total.neutral, real_wages.neutral, gini.neutral, share_y.neutral, trade_gdp.neutral, share_trade_x.neutral, outputs_z.neutral]=...
    %sel_master(beta, sigma, theta, tau, skilldist_base.neutral, popul_base, prod_base, ret_y, ret_x, fc_base);


%---------------------------
% DISPLAY SOLUTION


