function out = srcFile_switch_dc6(c1) %#codegen
% DC for switch statement (full coverage)
% no otherwise statement (implicit default)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
switch c1
    case -1
        out = 1;
    case 0
        out = 2;
    case 1
        out = 3;
end
