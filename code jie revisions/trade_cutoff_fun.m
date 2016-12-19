%---------------------- model with trade--------------------------


function output_z=trade_cutoff_fun(beta, sigma, theta, tau, pdf_skilldist, popul, prod, ret_y, ret_x, fixed_cost)

%---step1: GRID SEARCH over a grid if (10x10), find starting values;

eq_Y=zeros(10:10);
eq_X=zeros(10:10);
Z_1=[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
Z_2=[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
%Z_1=(0.1:0.1:1);


for i=1:10
    for j=1:10
        Z=[Z_1(1,j), Z_2(1,i)];
        [eq_Y(i,j), eq_X(i,j)]=trade_function(Z, beta, sigma, theta, tau, pdf_skilldist, popul, prod, ret_y, ret_x, fixed_cost);
    end
end
 
abs_y=abs(eq_Y);
abs_x=abs(eq_X);
total_abs=abs_y + abs_x;
[p,q]=find(total_abs==min(total_abs(:)));
Z1_eq=Z_1(1,p);
Z2_eq=Z_2(1,q);


%---step2: allow for a continuous measure of Z1 and Z2

Z0=[Z1_eq, Z2_eq];
eq_function=@(Z) trade_function(Z, beta, sigma, theta, tau, pdf_skilldist, popul, prod, ret_y, ret_x, fixed_cost);
[output_z]=fminsearch(@(Z) eq_function(Z), Z0);




end