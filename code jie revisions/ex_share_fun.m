%----------------------expenditure share good X------------------------
function ex_sharex=ex_share_fun(beta, theta, price_compx, prices_total)
    ex_sharex=zeros(1,2);
    for i=1:2
        ex_sharex(1,i)=(beta^(theta)*price_compx(1,i)^(1-theta))/((prices_total(1,i))^(1-theta));
    end 
end