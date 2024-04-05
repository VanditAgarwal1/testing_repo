function out = srcFile_for_dc3(input1, input2) %#codegen
% nested (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
for i = 1:input1
    for j = 1:input2
        out = 2;
    end
end
