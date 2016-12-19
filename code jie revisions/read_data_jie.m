%------------------------------------
% Biavaschi & Elsner
% Let's be selective about migrant self-selection
% JIE revisions; Mexico only; integrated trade model
%
% This file reads in the data
%------------------------------------


%{
skill_data=xlsread('skilldistrib_trim.xls'); % basic estimated skill distributions
skill_data_weighted=xlsread('skilldistrib_weighted_neutral_trim.xls'); % re-weighted counterfactual skill distributions for immigrants in US
wage_deciles=xlsread('wage_deciles_trim.xls'); % wage distributions, calculated from aggregate statistics
%}
%[~,~,skill_data]=xlsread('skilldistrib_trim.xls'); % basic estimated skill distributions

skill_data=xlsread('skilldistrib_trim.xls'); % basic estimated skill distributions
[skill_data_weighted]=xlsread('skilldistrib_weighted_neutral_trim.xls'); % re-weighted counterfactual skill distributions for immigrants in US
[wage_deciles]=xlsread('wage_deciles_trim.xls'); % wage distributions, calculated from aggregate statistics

a=size(skill_data_weighted,1);
skill_data_weighted=[zeros(a,1), skill_data_weighted];

b=size(wage_deciles,1);
wage_deciles=[zeros(b,1), wage_deciles];

clear a b

%skill_data=skill_data(2:31, :);


%---Mexico
pdf.mexico.stayers=skill_data(1:10, 2);
pdf.mexico.sel=skill_data(11:20, 2);
pdf.mexico.neutral=skill_data(21:30, 2);
pdf.mexico.pos=flipud(pdf.mexico.sel);
pdf.mexico.veryneg=pdf.mexico.sel;
for i=7:length(pdf.mexico.veryneg) 
    pdf.mexico.veryneg(i,1)=0;
end
sum_mex_aux=sum(pdf.mexico.veryneg);
pdf.mexico.veryneg=pdf.mexico.veryneg/sum_mex_aux;
pdf.mexico.verypos=flipud(pdf.mexico.veryneg);

%---US 2000
pdf.us2000.natives=skill_data(1:10,5);
pdf.us2000.migrants.neutral=skill_data_weighted(1:10,4);
pdf.us2000.migrants.sel=skill_data(11:20,5);
pdf.us2000.migrants.neg=pdf.us2000.migrants.sel;
pdf.us2000.migrants.verypos=pdf.us2000.migrants.sel;
pdf.us2000.migrants.veryneg=pdf.us2000.migrants.sel;


%---California
pdf.cal.natives=skill_data(1:10,6);
pdf.cal.migrants.neutral=skill_data_weighted(1:10,7);
pdf.cal.migrants.sel=skill_data(11:20,6);
pdf.cal.migrants.neg=pdf.cal.migrants.sel;
pdf.cal.migrants.verypos=pdf.cal.migrants.sel;
pdf.cal.migrants.veryneg=pdf.cal.migrants.sel;

%---Texas
pdf.tex.natives=skill_data(1:10,7);
pdf.tex.migrants.neutral=skill_data_weighted(1:10,8);
pdf.tex.migrants.sel=skill_data(11:20,7);
pdf.tex.migrants.neg=pdf.tex.migrants.sel;
pdf.tex.migrants.verypos=pdf.tex.migrants.sel;
pdf.tex.migrants.veryneg=pdf.tex.migrants.sel;


%---wage distributions
wages.mexico=wage_deciles(1:10, 12);
wages.us2000=wage_deciles(21:30, 15);
wages.cal=wage_deciles(21:30, 16);
wages.tex=wage_deciles(21:30, 17);

