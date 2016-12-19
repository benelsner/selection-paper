%------price indices for trade model----------------------
function [price_compx, prices_total]=prices_trade(pop, prod, sigma, beta, theta, tau, f_x, output_cutoff_x, unit_costs)

frac_px=zeros(1,2); % auxiliary: fraction M*tfp/(sigma*F_X)
for i=1:2
    frac_px(1,i)=pop(1,i)*prod(1,i)/(sigma*f_x(1,i));
end

price_compx=zeros(1,2);
price_compx(1,1)=sigma/(sigma-1)*(frac_px(1,1)*output_cutoff_x(1,1)*...
    (unit_costs(1,1))^(1-sigma)+frac_px(1,2)*output_cutoff_x(1,2)*(unit_costs(1,2)*tau)^(1-sigma))^(1/(1-sigma));    
price_compx(1,2)=sigma/(sigma-1)*(frac_px(1,2)*output_cutoff_x(1,2)*...
    (unit_costs(1,2))^(1-sigma)+frac_px(1,1)*output_cutoff_x(1,1)*(unit_costs(1,1)*tau)^(1-sigma))^(1/(1-sigma)); 

% price index
prices_total=zeros(1,2);
for i=1:2
   prices_total(1,i)=(beta^theta*price_compx(1,i)^(1-theta)+...
       (1-beta)^(theta))^(1/(1-theta)); 
end

end