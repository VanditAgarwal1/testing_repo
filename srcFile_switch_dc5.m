function out = srcFile_switch_dc5(c1) %#codegen
% DC for switch statement (full coverage)
% Fall-through, first case

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
switch c1
    case -1
    case 0
        out = 2;
    case 1
        out = 3;
    otherwise
        out = 4;
end
