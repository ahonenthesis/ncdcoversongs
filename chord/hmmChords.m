% Small wrapper for the HMM chord estimation. Uses the HMM Toolbox by Kevin
% Murphy, available at
% http://www.cs.ubc.ca/~murphyk/Software/HMM/hmm.html
%
function [seq,pri2,trans2,loglik] = hmmChords(data, pri, trans, mu, Sigma)

  [~, pri2, trans2, mu, Sigma, mm] = ...
  mhmm_em(data, pri, trans, mu, Sigma, [],...
	  'max_iter',100,'adj_mu',0,'adj_Sigma',0,'thresh',1e-3,'verbose',0);
  [b1,b2] = mixgauss_prob(data, mu, Sigma, mm);
  [seq, loglik] = viterbi_path(pri2, trans2, b1);

end
