function out = srcFile_for_dc8(input) %#codegen
% early exit (partial coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
for i = 1:input
    if i > 2
        out = i;
        return
    end
end
