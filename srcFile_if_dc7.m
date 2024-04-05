function out = srcFile_if_dc7(input) %#codegen
% if-elseif-else (partial coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0; %#ok
if input > 0
    out = 11;
elseif input > 1
    out = 12;
else
    out = 13;
end
