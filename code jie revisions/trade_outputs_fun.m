%-------------outputs with trade---------------------------
function [price_compx, prices_total, nom_wages, real_wages, nomwageZ, market_clearing, imports_y, imports_x, share_y, trade_gdp, share_trade_x]=...
    trade_outputs_fun(output_z, ret_y, ret_x, pdf_skilldist, popul, prod, sigma, beta, theta, tau, fixed_cost, threshZ)

Z=output_z;

% 1) prices

[skill_weights_y, skill_weights_x, z_vector]=skill_weights_fun(Z);
unit_costs=unit_costs_trade(ret_y, ret_x, Z);
[output_cutoff_y, output_cutoff_x]=trade_output_eq(ret_y, ret_x, z_vector, pdf_skilldist, skill_weights_y, skill_weights_x);
[price_compx, prices_total]=prices_trade(popul, prod, sigma, beta, theta, tau, fixed_cost, output_cutoff_x, unit_costs);


% 2) wages

nom_wages=nom_wages_fun(prod, unit_costs, output_cutoff_y, output_cutoff_x);
real_wages=nom_wages./prices_total;

% 2A) wages at different Z scores;
%{
nomwageZ=zeros(size(threshZ, 2), 2);
indicY=nomwageZ;
%}




% 3) test market clearing
expenditure=zeros(1,2);
for i=1:2
   expenditure(1,i)=popul(1,i)*nom_wages(1,i); 
end 
ex_sharex=ex_share_fun(beta, theta, price_compx, prices_total);
market_clearing(1,1)=(1-ex_sharex(1,1))*expenditure(1,1)+(1-ex_sharex(1,2))*expenditure(1,2)-popul(1,1)*prod(1,1)*output_cutoff_y(1,1)-popul(1,2)*prod(1,2)*output_cutoff_y(1,2);
market_clearing_x1=(sigma/(sigma-1)*unit_costs(1,1))^(-sigma)*(ex_sharex(1,1)/price_compx(1,1)^(1-sigma)*expenditure(1,1)+tau^(1-sigma)*ex_sharex(1,2)/price_compx(1,2)^(1-sigma)...
            *expenditure(1,2))-(sigma-1)*fixed_cost(1,1);
market_clearing_x2=(sigma/(sigma-1)*unit_costs(1,2))^(-sigma)*(ex_sharex(1,2)/price_compx(1,2)^(1-sigma)*expenditure(1,2)+tau^(1-sigma)*ex_sharex(1,1)/price_compx(1,1)^(1-sigma)...
            *expenditure(1,1))-(sigma-1)*fixed_cost(1,2);        
market_clearing(1,2)=market_clearing_x1/market_clearing_x2;
        
% 4) trade in good y and x
[imports_y, imports_x, trade_gdp, share_trade_x]=trade_values(ex_sharex, popul, prod, output_cutoff_y, output_cutoff_x, expenditure, price_compx);


% 4) gini
% for i=1:2
%     gini(1,i)=lorenz_gini_trade(ret_y(1,i), ret_x(1,i), prod(1,i), unit_costs(1,i), prices_total(1,i),... 
%         pdf_skilldist(i,:), skill_weights_y(i,:), skill_weights_x(i,:));
% end

% 5) workers in sector Y
aux_share=pdf_skilldist.*skill_weights_y;
share_y=sum(aux_share,2)';

% 6) share trade in gdp and share of X in total trade;

% 7) nominal wages at different percentiles
indicY=zeros(size(threshZ, 2), 2);
nomwageY=indicY;
nomwageX=indicY;

for i=1:2
    indicY(threshZ(i,:)'<=share_y(i),i)=1;
end

indicX=ones(size(indicY))-indicY;

for i=1:2
    for j=1:size(threshZ, 2)
    nomwageY(j,i)=prod(i)*(exp(ret_y(i)*threshZ(i,j)')).*indicY(j,i);
    nomwageX(j,i)=prod(i)*unit_costs(i)*(exp(ret_x(i)*threshZ(i,j)')).*indicX(j,i);
    end
end

nomwageZ=nomwageY+nomwageX;




end