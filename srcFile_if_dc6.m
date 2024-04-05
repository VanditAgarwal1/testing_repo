function out = srcFile_if_dc6(input) %#codegen
% if-elseif-else (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0; %#ok
if input < 1
    out = 11;
elseif input > 1
    out = 12;
else
    out = 13;
end
