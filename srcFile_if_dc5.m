function out = srcFile_if_dc5(input) %#codegen
% DC nested If (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0; %#ok
if input > 0
    if input > 1
        out = 8;
    else
        out = 9;
    end
else
    out = 10;
end
