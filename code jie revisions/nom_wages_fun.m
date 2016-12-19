%--------------nominal wages----------------------
function [nom_wages, nom_wages_dec]=nom_wages_fun(prod, unit_costs, output_cutoff_y, output_cutoff_x)
nom_wages=zeros(1,2);
for i=1:2
   nom_wages(1,i)=prod(1,i)*(output_cutoff_y(1,i)+unit_costs(1,i)*output_cutoff_x(1,i));
end   
end