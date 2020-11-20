function [ y ] = sem( x )
% Calculates standard error for input array
%   

y = nanstd(x) / sqrt(numel(~isnan(x)));



end

