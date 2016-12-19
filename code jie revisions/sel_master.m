%------------------trade master function

%{
Function requires each input in a matrix that includes both countries

Inputs:

beta: Share of good X in utility function
sigma: elasticity of substitution between varieties of X
theta: elasticity of substitution between X and Y
tau: trade cost
pdf_skilldist: skill distribution
popul: population
prod: tfp
ret_y: returns to skill, sector Y
ret_x: returns to skill, sector X
fixed_cost: fixed cost of production in sector X


Outputs:

outputs_z: cutoff levels of Z
%}




%function [prices_total, real_wages, gini, share_y, trade_gdp, share_trade_x, outputs_z]=sel_master(beta, sigma, theta, tau, pdf_skilldist, popul, prod, ret_y, ret_x, fixed_cost)
%function [real_wages, nom_wages, prices_total, share_y, trade_gdp, share_trade_x, outputs_z, nomwageZ]=sel_master(param, pdf_skilldist, param2)
function [outmain]=sel_master(pdf_skilldist, param, param2)

beta=param(1);
sigma=param(2);
theta=param(3);
tau=param(4);

popul=param2{1};
prod=param2{2};
ret_y=param2{3};
ret_x=param2{4};
fixed_cost=param2{5};
threshZ=param2{6};



%---step1: determine cutoffs Z for both countries from equilibrium
outputs_z=trade_cutoff_fun(beta, sigma, theta, tau, pdf_skilldist, popul, prod, ret_y, ret_x, fixed_cost);


%---step2: compute equilibrium outputs
[price_compx, prices_total, nom_wages, real_wages, nomwageZ, market_clearing, imports_y, imports_x, share_y, trade_gdp, share_trade_x]=...
    trade_outputs_fun(outputs_z, ret_y, ret_x, pdf_skilldist, popul, prod, sigma, beta, theta, tau, fixed_cost, threshZ);


outmain={real_wages, nom_wages, prices_total, share_y, trade_gdp, share_trade_x, outputs_z, nomwageZ};
end

