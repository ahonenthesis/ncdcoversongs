% Configuration paths for a cover song exvaluation run. Modify to suit 
% your needs.
function toolboxConfig

% first add the system itself
addpath(genpath((pwd)));

% MIRToolbox root directory
mirpath = '/home/teahonen/oldstuff/MIRtoolbox1.3.4/';
% add to the path
addpath(genpath(mirpath));
% turn the rather annoying verbose and waitbar stuff off
mirverbose(0);
mirwaitbar(0);

% The HMM toolkit path
hmmpath = '/home/teahonen/oldstuff/HMMall/';
% add to the path
addpath(genpath(hmmpath));

end
