%------------------output in X and Y with trade (output at the cutoff)

function [output_cutoff_y, output_cutoff_x]=trade_output_eq(g_y, g_x, z_vector, skilldist, skill_weights_y, skill_weights_x)
output_y=zeros(2,10);
output_x=zeros(2,10);

for i=1:2
    for j=1:10
        output_y(i,j)=exp(g_y(1,i)*z_vector(1,j))*skilldist(i,j); %output for each skill level
        output_x(i,j)=exp(g_x(1,i)*z_vector(1,j))*skilldist(i,j);
    end
end    


output_weight_y=output_y.*skill_weights_y; % multiply skill-level outputs by skill weights
output_weight_x=output_x.*skill_weights_x;

output_cutoff_y=sum(output_weight_y, 2)';
output_cutoff_x=sum(output_weight_x, 2)';
end