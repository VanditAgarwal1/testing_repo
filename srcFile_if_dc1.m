function out = srcFile_if_dc1(decision) %#codegen
% DC with Else (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0; %#ok
if decision
    out = 1; 
else
    out = 2;
end
