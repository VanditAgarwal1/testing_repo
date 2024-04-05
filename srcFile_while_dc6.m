function out = srcFile_while_dc6(EarlyBr) %#codegen
% early break use 'return'

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
while EarlyBr < 4
    out = 7;
    EarlyBr = EarlyBr -1;
    if ( EarlyBr == 1)
        out = 8;
        return;
    end
end
