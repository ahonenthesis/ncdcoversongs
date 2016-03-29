% Distance calculation
%
% input:
% data1, data2   - the chromagram data inputs
% m, tau, kappa  - the embedding / binarization parameter values
% gammao, gammae - Qmax parameter values
%
% output:
% dval - the distance (or similarity) value
function [dval] = ssa_dist(data1,data2,m,tau,kappa,gammao,gammae,sza)

% first embed chromas
edata1=embedChromagram(data1,m,tau);
edata2=embedChromagram(data2,m,tau);

% then calculate CRP
crp=crossRecurrencePlot(edata1,edata2,kappa);

% then calculate the qmax value
dval=qmaxdistance(crp,gammao,gammae);

% and finally normalize if sza
if (sza)
    dval=sqrt(size(data2,2))/qmx;
end

end
