%---------------calculate skill weights-------------------------
% 1 if an entire bin of the skill distribution is used for the production
% of a good
% 0 if the entire bin is not used for the production of a good
% 0<weight<1 if part of the bin produces one good and another part the
% other good

function [skill_weights_y, skill_weights_x, z_vector]=skill_weights_fun(Z)
z_vector=(0.1:0.1:1);
skill_weights_y=zeros(2,10);
z_diff=zeros(2,10);

for i=1:2
    for j=1:10
        z_diff(i,j)=z_vector(1,j)-Z(1,i);
        skill_min_y(i,j)=min(1,(1-z_diff(i,j)*10));
        skill_weights_y(i,j)=max(0,skill_min_y(i,j));
    end    
end    
skill_weights_x=ones(2,10)-skill_weights_y;

end