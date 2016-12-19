%-----------------data for lorenz curve and gini coefficient--------------


function [gini]=lorenz_gini_trade(g_y, g_x, prod, unit_costs, prices_total, pdf_skill, skill_weights_y, skill_weights_x)
    
    z_vector=(0.1:0.1:1);
    nom_wages_dec=zeros(1,10); % generates nominal wage by decile
    for i=1:10
       nom_wages_dec=skill_weights_y(1,i)*prod*exp(g_y*z_vector(1,i))+skill_weights_x(1,i)*unit_costs*prod*exp(g_x*z_vector(1,i));
    end
    real_wages_dec=nom_wages_dec/prices_total;
    aux_step1=pdf_skill.*real_wages_dec;
    aux_step2=cumsum(aux_step1);
    aux_step3=[0, aux_step2];
    
    aux_step4=zeros(1,length(pdf_skill));
    for i=2:length(pdf_skill)
        aux_step4(1,i)=pdf_skill(1,i)*(aux_step3(1,i-1)+ aux_step3(1,i));
    end
    numerator=sum(aux_step4);
    denominator=max(aux_step3);
    gini=1-numerator/denominator;
end