%----------trade model function

% inputs:
% 
% scalars: beta, sigma, theta, tau
% 1x2 vectors: Population size (M), productivity (Prod), g_Y, g_X, F_X
% 2x10 vector: skilldist
% 1x10 vector: skill_level

function [eq_y, eq_x, output_cutoff_y, output_cutoff_x]=trade_function(Z, beta, sigma, theta, tau, skilldist, pop, prod, g_y, g_x, f_x)

%---step 1: pick cutoff values for Z_1 and Z_2

% generate skill weights for sectors (Y and X)
% in sector Y a bin in the skill distribution gets weight 1 ifs upper bound lies below the cutoff, 
% zero if Z-Z_cutoff>0.1, and something between 0 and 1 otherwise 
    %z_vector=(0.1:0.1:1);
    [skill_weights_y, skill_weights_x, z_vector]=skill_weights_fun(Z);


%--------------------------------------------------------------------
%---step 2: calculate unit costs, prices, and expenditure shares
% unit costs
    unit_costs=unit_costs_trade(g_y, g_x, Z);

    
% output for a given cutoff
    [output_cutoff_y, output_cutoff_x]=trade_output_eq(g_y, g_x, z_vector, skilldist, skill_weights_y, skill_weights_x);
    
% price for composite good x and aggregate prices
    [price_compx, prices_total]=prices_trade(pop, prod, sigma, beta, theta, tau, f_x, output_cutoff_x, unit_costs);
    
    
% expenditure share good X
    ex_sharex=ex_share_fun(beta, theta, price_compx, prices_total);

%--------------------------------------------------------------------
%---step 3: calculate income and expenditure
% nominal wages
    nom_wages=nom_wages_fun(prod, unit_costs, output_cutoff_y, output_cutoff_x);
    
    
    
    % expenditure
    expenditure=zeros(1,2);
    for i=1:2
       expenditure(1,i)=pop(1,i)*nom_wages(1,i); 
    end    

%--------------------------------------------------------------------
%---step 4: calculate equilibrium conditions

% good Y
eq_y=abs((1-ex_sharex(1,1))*expenditure(1,1)+(1-ex_sharex(1,2))*expenditure(1,2)-pop(1,1)*prod(1,1)*output_cutoff_y(1,1)...
         -pop(1,2)*prod(1,2)*output_cutoff_y(1,2));     
         
     
% auxiliary terms good X
ratio_cx=unit_costs(1,2)/unit_costs(1,1); % note: the numerator and denominator in the eq condition are c_X^(-1)
ratio_fx=(f_x(1,1)/f_x(1,2))^(1/sigma);
demand_den=(ex_sharex(1,1)/(price_compx(1,1))^(1-sigma)*expenditure(1,1)+tau^(1-sigma)*ex_sharex(1,2)/(price_compx(1,2))^(1-sigma)*expenditure(1,2));
demand_num=(ex_sharex(1,2)/(price_compx(1,2))^(1-sigma)*expenditure(1,2)+tau^(1-sigma)*ex_sharex(1,1)/(price_compx(1,1))^(1-sigma)*expenditure(1,1));


eq_x=abs(ratio_cx-ratio_fx*(demand_num/demand_den)^(1/sigma));
end