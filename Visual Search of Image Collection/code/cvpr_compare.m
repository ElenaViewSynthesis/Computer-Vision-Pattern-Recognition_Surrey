% Takes two FEATURE DESCRIPTORS, F1,F2 as input and returns the distance between them
function dst=cvpr_compare(F1, F2)

% This function should compare F1 to F2 - i.e. compute the *EUCLIDEAN DISTANCE*
% -> L2 Norm between the two descriptors.

% For now it just returns a random number
%% Week 2 LECTURES

x = F1-F2;     % Subtract each element of feature F1,F2
x = x.^2;      % Square their differences
x = sum(x);    % Sum up the square differences
dst = sqrt(x); 

return;
