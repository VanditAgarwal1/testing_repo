function out = srcFile_for_dc1(input) %#codegen
% Count up (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
for i = input:4
    out = i;
end
