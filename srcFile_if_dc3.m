function out = srcFile_if_dc3(decision) %#codegen
% DC no Else and nested If (no coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
if decision % always false
    if decision % never executed
        out = 5;
    else
        out = 6;
    end
end
