function out = srcFile_switch_dc1(c1) %#codegen
% DC for switch statement (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0; %#ok
switch c1
    case -1
        out = 1;
    case 0
        out = 2;
    case 1
        out = 3;
    otherwise
        out = 4;
end
