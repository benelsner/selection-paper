%------------------------------------
% Biavaschi & Elsner
% Let's be selective about migrant self-selection
% JIE revisions; Mexico only; integrated trade model
%
% In this file, all exogenous parameters are entered
%------------------------------------




%---------------Model parameters---------------------


% productivity parameters
g_y.mexico=1;
g_y.us2000=1;
g_y.cal=1;
g_y.tex=1;

g_x.mexico=2.02; % Caselli & Coleman
g_x.us2000=1.64; % Caselli & Coleman


% structural parameters: to be estimated; these serve as initial guesses
beta=0.5;   % share of good X in utility function
theta=1.5;  % elasticity of substitution between X and Y
sigma=4;    % elasticity of substitution between varieties of X
tau=1.4;    % trade costs


% population
pop.us2000=244112; % excludes foreign-born
pop.cal=30014; % excludes Mexicans
pop.tex=19447; % excludes Mexicans
pop.mexico=101826; % stayers only

% migrants
migrants.mexico=10017;
migrants.cal=5102;
migrants.tex=2231; 
migrants.us2000other=26588;


% tfp
tfp.mexico=0.286;  % from OECD statistics
tfp.us2000=1;
tfp.cal=1;
tfp.tex=1;


% share low-skilled workers
share_y.mexico=0.7136;  % stayers only, trim
share_y.us2000=0.2893;  % natives only, trim
share_y.cal=0.2813;
share_y.tex=0.2759;

% skill levels for which to report changes
outputZ=[0.1,0.25,0.5,0.75,0.9];

