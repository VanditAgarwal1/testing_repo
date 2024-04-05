function out = srcFile_switch_dc2(c1) %#codegen
% DC for switch statement (partial coverage)
% case -1 never true

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0; %#ok
switch c1
    case -1  % missed case
        out = 1;
    case 0
        out = 2;
    case 1
        out = 3;
    otherwise
        out = 4;
end
