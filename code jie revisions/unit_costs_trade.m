%-----------------unit_costs with trade-----------------------
function unit_costs=unit_costs_trade(g_y, g_x, Z)
    unit_costs=zeros(1,2);
    for i=1:2
      unit_costs(1,i)=exp((g_y(1,i)-g_x(1,i))*Z(1,i));
    end
end