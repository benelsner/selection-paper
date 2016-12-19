%------------------------------------
% Biavaschi & Elsner
% Let's be selective about migrant self-selection
% JIE revisions; Mexico only; integrated trade model
%
% This file generates all endogenous model parameters
%------------------------------------

% productivity in sector X
g_x.us2000other=g_x.us2000;
g_x.cal=g_x.us2000;
g_x.tex=g_x.us2000;
g_x.us2000naive=g_x.us2000;


% parameters for "all migrants" specification
tfp.us2000other=tfp.us2000;
tfp.us2000naive=tfp.us2000;
g_y.us2000other=g_y.us2000;
g_y.us2000naive=g_y.us2000;


% skill levels
skill_level=(0.1:0.1:1);
skill_groups=length(skill_level);

% populations in autarky in Mexico and Norway
total_pop.mexico=pop.mexico + migrants.mexico;


% populations after migration, USA
total_pop.us2000=pop.us2000 + migrants.mexico;
total_pop.cal=pop.cal + migrants.cal;
total_pop.tex=pop.tex + migrants.tex;
total_pop.us2000other=total_pop.us2000 + migrants.us2000other;
total_pop.us2000naive=pop.us2000 + migrants.mexico;



%---generate pdfs for different scenarios
% sending countries
skilldist.mexico.sel=(pdf.mexico.stayers)';
skilldist.mexico.neutral=(pdf.mexico.stayers +... 
        migrants.mexico/pop.mexico*(pdf.mexico.sel-pdf.mexico.neutral))';


% US2000
skilldist.us2000.sel=(pop.us2000/total_pop.us2000*pdf.us2000.natives + migrants.mexico/total_pop.us2000*pdf.us2000.migrants.sel)';
skilldist.us2000.neutral=(pop.us2000/total_pop.us2000*pdf.us2000.natives + migrants.mexico/total_pop.us2000*pdf.us2000.migrants.neutral)';

skilldist.us2000other.sel=(pop.us2000/total_pop.us2000other*pdf.us2000.natives + ...
    (migrants.mexico+migrants.us2000other)/total_pop.us2000other*pdf.us2000.migrants.sel)';
skilldist.us2000other.neutral=(pop.us2000/total_pop.us2000other*pdf.us2000.natives + ...
    (migrants.mexico+migrants.us2000other)/total_pop.us2000other*pdf.us2000.migrants.neutral)';

skilldist.us2000naive.sel=skilldist.us2000.sel;
skilldist.us2000naive.neutral=(pop.us2000/total_pop.us2000*pdf.us2000.natives + migrants.mexico/total_pop.us2000*skilldist.mexico.neutral')';

% California
skilldist.cal.sel=(pop.cal/total_pop.cal*pdf.cal.natives + migrants.cal/total_pop.cal*pdf.cal.migrants.sel)';
skilldist.cal.neutral=(pop.cal/total_pop.cal*pdf.cal.natives + migrants.cal/total_pop.cal*pdf.cal.migrants.neutral)';


% Texas
skilldist.tex.sel=(pop.tex/total_pop.tex*pdf.tex.natives + migrants.tex/total_pop.tex*pdf.tex.migrants.sel)';
skilldist.tex.neutral=(pop.tex/total_pop.tex*pdf.tex.natives + migrants.tex/total_pop.tex*pdf.tex.migrants.neutral)';

% skill distribution in autarky
skill_aut.us2000=(pdf.us2000.natives)';
skill_aut.mexico=(pop.mexico/total_pop.mexico*pdf.mexico.stayers +  migrants.mexico/total_pop.mexico*pdf.mexico.sel)';


countries={'mexico', 'us2000', 'us2000other', 'us2000naive', 'cal', 'tex'};
spec={'sel', 'neutral'};
for i=1:length(countries)
   for j=1:2 
        cdf.(countries{i}).(spec{j})=cumsum(skilldist.(countries{i}).(spec{j}));
   end
end


%---dataset for finding the Z of various percentiles
% COUNTRY 1: Mexico

distsel=[cdf.mexico.sel;cdf.us2000.sel];
%ind_skillZ=cell(2,size(outputZ,2));
for j=1:2
    ind_skillZ=cell(1,size(outputZ,2));   
    pctZ=ind_skillZ;
    baseZ=ind_skillZ;
    Z=ind_skillZ;
    [ind_skillZ{1:1,:}]=deal(ones(1, size(skilldist.mexico.sel,2)));
    %ind_skillZ=[num2cell(outputZ); ind_skillZ];
    for i=1:size(outputZ,2)
        ind_skillZ{1,i}(distsel(j,:)>outputZ(1,i))=0;
        pctZ{1,i}=sum(ind_skillZ{1,i});
        baseZ{1,i}=[distsel(j,pctZ{1,i}), distsel(j,pctZ{1,i}+1)]; 
        Z{1,i}= 0.1*(pctZ{1,i}+(outputZ(1,i)-baseZ{1,i}(1,1))/(baseZ{1,i}(1,2)-baseZ{1,i}(1,1)));   
    end
    %a(j,:)=Z(j,:);
    threshZ(j,:)=cell2mat(Z(1,:));
end




%-----------------------------------
% Matrices for trade model [1 Mexico; 2 USA]

skilldist_base.sel=[skilldist.mexico.sel; skilldist.us2000.sel];
skilldist_base.neutral=[skilldist.mexico.neutral; skilldist.us2000.neutral];
popul_base=[pop.mexico, pop.us2000 + migrants.us2000other];
fc_base=[0.1,1];
 %pdf_skilldist.sel, popul, prod, ret_y, ret_x, fixed_cost
prod_base=[1, tfp.us2000/tfp.mexico];
ret_y=[g_y.mexico, g_y.us2000];
ret_x=[2.83, 1.42];
%ret_x=[1.5, 3];


%-----------------------------
% Parameter matrices for model
param=[beta, sigma, theta, tau];
param2={popul_base, prod_base, ret_y, ret_x, fc_base, threshZ};


