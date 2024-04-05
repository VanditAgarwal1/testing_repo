function out = srcFile_for_dc5(input) %#codegen
% early break (partial coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
for i = 1:input
    if i > 2
        out = 2;
        break;
    end
end