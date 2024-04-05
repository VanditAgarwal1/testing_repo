function out = srcFile_switch_dc4(c1) %#codegen
% DC for switch statement (no coverage)
% switch never executed

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
if (c1 > 2)
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
end
