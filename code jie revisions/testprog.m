

indicY=zeros(size(threshZ, 2), 2);
nomwageY=indicY;
nomwageX=indicY;
sy=[0.8, 0.7];
uc=[0.5,1];

for i=1:2
    indicY(threshZ(i,:)'<=sy(i),i)=1;
end

indicX=ones(size(indicY))-indicY;

for i=1:2
    for j=1:size(threshZ, 2)
    nomwageY(j,i)=prod(i)*(exp(ret_y(i)*threshZ(i,j)')).*indicY(j,i);
    nomwageX(j,i)=prod(i)*uc(i)*(exp(ret_x(i)*threshZ(i,j)')).*indicX(j,i);
    end
end

nomwageZ=nomwageY+nomwageX;




%a(threshZ(1,:)'=<share_y(1,1))=1;

% 
% {
% for i=1:2
%     indicY(:,i)=a(:,1)(threshZ(1,:)'<=share_y(1,i))=1; 
% end
% }
% 
