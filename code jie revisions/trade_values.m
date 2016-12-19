%---------------trade values for country 1 (country 2 a mirror image)
% production - consumption
function [imports_y, imports_x, trade_gdp, share_trade_x]=trade_values(ex_sharex, pop, prod, output_cutoff_y, output_cutoff_x, expenditure, price_compx)

%{
expenditure=zeros(1,2);
for i=1:2
   expenditure(1,i)=pop(1,i)*nom_wages(1,i); 
end  
%}

% good Y
for i=1:2
    demand_y(1,i)=(1-ex_sharex(1,i))*expenditure(1,i);
    supply_y(1,i)=pop(1,i)*prod(1,i)*output_cutoff_y(1,i);
    imports_y(1,i)=demand_y(1,i) - supply_y(1,i);
end

% good X
for i=1:2
    demand_x(1,i)=(ex_sharex(1,i)*expenditure(1,i));
    supply_x(1,i)=pop(1,i)*prod(1,i)*output_cutoff_x(1,i);
    imports_x(1,i)=demand_x(1,i) - supply_x(1,i);
end

% share of trade in gdp
for i=1:2
    trade_gdp(1,i)=(abs(imports_y(1,i))+ price_compx(1,i)*abs(imports_x(1,i)))/expenditure(1,i);
    share_trade_x(1,i)=price_compx(1,i)*abs(imports_x(1,i))/(abs(imports_y(1,i))+ price_compx(1,i)*abs(imports_x(1,i)));
end    

%, share_trade_x
%{
demand1_y=(1-ex_sharex(1,1))*expenditure(1,1);
supply1_y=pop(1,1)*prod(1,1)*output_cutoff_y(1,1);
imports1_y=demand1_y - supply1_y;

% good X
demand1_x=(ex_sharex(1,1)*expenditure(1,1));
supply1_x=pop(1,1)*prod(1,1)*output_cutoff_x(1,1);
imports1_x=demand1_x - supply1_x;
%}

end