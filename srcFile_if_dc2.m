function out = srcFile_if_dc2(decision) %#codegen
% DC with Else (partial coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0; %#ok
if decision % always true
    out = 3;
else
    out = 4; % never executed
end
