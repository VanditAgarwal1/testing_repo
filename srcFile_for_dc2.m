function out = srcFile_for_dc2(input) %#codegen
% Count down (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
for i = input:-1:1
    out = i;
end
